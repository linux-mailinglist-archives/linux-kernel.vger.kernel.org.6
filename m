Return-Path: <linux-kernel+bounces-532941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF468A453FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 142967A6FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4985A25487B;
	Wed, 26 Feb 2025 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoIvorT/"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9B19DF7D;
	Wed, 26 Feb 2025 03:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540400; cv=none; b=Ig88FRcn8R9Kxbj/MnESjRfwNmPEIwnN9SGwXsr7Wzrjwllqs/7Fy2VIu3kDx1Bif8SG5dfGaVzZrmEl3oSnq2gWiVY5CGrUnDFZeNqc9dx2yM+GDGgo+N8crCY779QqDWyFEv1z75Uu93CXl8q8hIYQtnYn/9qXqzncRbKJIP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540400; c=relaxed/simple;
	bh=DEEQkt27WS1xLaIXX4SllW+vUEN6DjuqAh6Fg8i8Sp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE6QzBaGayHzTs4LM/Cn61j0uhey26RcSVi+s7KeSpmkfWD/z95unPSh34QkUhvYHQXZCfyXuHYPD7nAgSmdtEgnXtIPLC7hQLUQ7hu2kLDFlte3gC4iY8ax2Csppj+MUOY4jKvQogDBp382HNRlfSHepYqN81Y/O8adPJQsNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoIvorT/; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3cf82bd380bso54621965ab.0;
        Tue, 25 Feb 2025 19:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740540398; x=1741145198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjPFcya5e2r+WV7UgeL+WIIYPlcJCo8wOjQTIXu/Hr0=;
        b=GoIvorT/zWXEf1MIxly4RCsGPdYoIawHWLJ+s3U0N5ZPWclbWo3Qal7wCYk5BKpL1p
         4xH6gZGdA5DsMTktJGdhUwJdONeVgHcIaMxRKeVhjLEhA2vkDEbx2qSbtz94CvXNvFxs
         IX9iOeDXBH0E4ZUj6W+ObS5Wa4EvJyoIWouMaTbYsiEyoRhmYCHbXG3Mutdl1ca0POLd
         Aq2vT6Hz0DJofhiXVe823Rxlzx97G3OwqXi1AKneB91CqBFEe0t04JR7QY26myVOspgL
         5q9k16OxkhpnRvQWGc+g98dGG85B1d397K/aLWwBkTb+TrtgJCav5b243C1QF/7gqO3X
         bICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740540398; x=1741145198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjPFcya5e2r+WV7UgeL+WIIYPlcJCo8wOjQTIXu/Hr0=;
        b=DWY1tC6cp8e7mTs7VWIz0Xg0M25DvhpOr5vImh+lbW3PeGER0jWhXSw20Olzd4I4Wg
         BZFLbohCZtt/9HMwHkIp2hIVDBmtNU+owK4Ly9lmR1A1s0QekkDIlcOWcI1eP4+sew0y
         wsF/vAlu8obJ3UnW65WyOxmhGgOIe7mr/E+0KHxN9WGz3lELKkcNnbKyGicBlkl6X8Xc
         YX4IAwhqjn8r9aj+3DGFEK0vPChkjfUnUVEGxz10DTIALc2qo4mx+XMAD7YX6klyz54x
         cIRp3835ShUEPg0UYF13iQugRIybX7HGp42uzZ7ZjO0rP1v2whwM11upUdlKlvGB59Zd
         MS2g==
X-Forwarded-Encrypted: i=1; AJvYcCVkU2phR6CGpSyxkNhzmIRLaj9rSzEuIHJEJjImRlcNmY33RhRiovD4UuhoDVxfEyivGi7XbTYVz03Mf9yF@vger.kernel.org, AJvYcCWbdcmwSqZIfSIrVlgSV6YAdRUgBF6gwNhDl3fYCcLP2hre4i7f0vVh4imcvii1BvwtDiLWDIpQcMVG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw12GJlspJuj886sAaKS+MCfkZsedYnK1WuDKUaApxxZncQVAIf
	qtqT5SLi4spF13cky2SNLoiLvD0CMbCOQIJDkyDCh4kisj0Fkd/sxo7mjXd52z5Cs7a969H4g7a
	CHXJYFioldgmsG5YR4FckKlsHraM=
X-Gm-Gg: ASbGncsdx14xxO7pdzpOyAfS95oHeQxY46nL2wUSSzZPIfuiVl8N6VVuKySp9vGqLUN
	ZXwmMQz/IC2rVxiVBCfqONy6Sfy1ETjvEC0k+ctjKC+/RlUvWYpIQSYxceu8MStsxoD47a1by7F
	6VSwyQlN89Kg==
X-Google-Smtp-Source: AGHT+IGkIlMulPsC4dRSPOa5KPszEP283dCQUI1IJqGtxhMPLh3ea4rtlULGEOwZit8MCB9CzDPWc43TOivBKx4JShk=
X-Received: by 2002:a05:6e02:1526:b0:3d0:4a82:3f43 with SMTP id
 e9e14a558f8ab-3d2cb43281cmr187250305ab.5.1740540397675; Tue, 25 Feb 2025
 19:26:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224083908.1880383-1-yschu@nuvoton.com> <20250224083908.1880383-4-yschu@nuvoton.com>
 <Z7yfEunAWuR8jchq@lizhi-Precision-Tower-5810> <CAPwEoQNZef_CeeCDNFGG4oJHCiM3MN9-juq+xX3hB5DKp4vorQ@mail.gmail.com>
 <Z73wr/6Or6SWOQD8@lizhi-Precision-Tower-5810>
In-Reply-To: <Z73wr/6Or6SWOQD8@lizhi-Precision-Tower-5810>
From: Stanley Chu <stanley.chuys@gmail.com>
Date: Wed, 26 Feb 2025 11:26:24 +0800
X-Gm-Features: AQ5f1Jqy-HEV10m9ieeI2ZnTXj2eE0rZkF5vWPHsJXa3Dsmbw9T9_oYdCx5-L2I
Message-ID: <CAPwEoQPmbn0N5UCJn3c90A6ppNCa9t2MYUBppiosrOFN4JW9xA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] i3c: master: svc: Fix npcm845 FIFO empty issue
To: Frank Li <Frank.li@nxp.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i3c@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 12:32=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Tue, Feb 25, 2025 at 05:28:48PM +0800, Stanley Chu wrote:
> > On Tue, Feb 25, 2025 at 12:32=E2=80=AFAM Frank Li <Frank.li@nxp.com> wr=
ote:
> > >
> > > On Mon, Feb 24, 2025 at 04:39:06PM +0800, Stanley Chu wrote:
> > > > From: Stanley Chu <yschu@nuvoton.com>
> > > >
> > > > I3C HW stalls the write transfer if the transmit FIFO becomes empty=
,
> > > > when new data is written to FIFO, I3C HW resumes the transfer but t=
he
> > > > first transmitted data bit may have the wrong value.
> > > > Fill the FIFO in advance to prevent FIFO from becoming empty.
> > > >
> > > > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > > > ---
> > > >  drivers/i3c/master/svc-i3c-master.c | 44 ++++++++++++++++++++-----=
----
> > > >  1 file changed, 31 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/mast=
er/svc-i3c-master.c
> > > > index 8834f87a4767..07506ae0f914 100644
> > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > @@ -942,7 +942,7 @@ static int svc_i3c_master_do_daa_locked(struct =
svc_i3c_master *master,
> > > >                                       u8 *addrs, unsigned int *coun=
t)
> > > >  {
> > > >       u64 prov_id[SVC_I3C_MAX_DEVS] =3D {}, nacking_prov_id =3D 0;
> > > > -     unsigned int dev_nb =3D 0, last_addr =3D 0;
> > > > +     unsigned int dev_nb =3D 0, last_addr =3D 0, dyn_addr;
> > > >       u32 reg;
> > > >       int ret, i;
> > > >
> > > > @@ -985,6 +985,17 @@ static int svc_i3c_master_do_daa_locked(struct=
 svc_i3c_master *master,
> > > >               if (SVC_I3C_MSTATUS_RXPEND(reg)) {
> > > >                       u8 data[6];
> > > >
> > > > +                     /*
> > > > +                      * One slave sends its ID to request for addr=
ess assignment,
> > > > +                      * pre-filling the dynamic address can reduce=
 SCL clock stalls
> > > > +                      * and also fix the SVC_I3C_QUIRK_FIFO_EMPTY =
quirk.
> > > > +                      */
> > > > +                     dyn_addr =3D i3c_master_get_free_addr(&master=
->base, last_addr + 1);
> > > > +                     if (dyn_addr < 0)
> > > > +                             return -ENOSPC;
> > > > +
> > > > +                     writel(dyn_addr, master->regs + SVC_I3C_MWDAT=
AB);
> > > > +
> > >
> > > Although there is 64 clock time after issue do_daa, it is still bette=
r if
> > > prefill dyn_addr before sent do daa command?
> > >
> > > If add a debug message before i3c_master_get_free_addr(), does it tri=
gger
> > > hardware issue?
> > >
> > > Frank
> >
> > Ideally, prefilling before the processDAA command is better. However,
> > it requires an additional check to write the dyn_addr at the right time
> > because the driver needs to write the processDAA command twice for one
> > assignment
> >
> > Prefilling here is safe and efficient because the FIFO starts filling
> > within a few hundred nanoseconds on the npcm845, which is significantly
> > faster compared to the 64 SCL clock cycles.
>
> Okay, please this to comments.
>
> >
> >
> > >
> > > >                       /*
> > > >                        * We only care about the 48-bit provisioned =
ID yet to
> > > >                        * be sure a device does not nack an address =
twice.
> > > > @@ -1063,21 +1074,16 @@ static int svc_i3c_master_do_daa_locked(str=
uct svc_i3c_master *master,
> > > >               if (ret)
> > > >                       break;
> > > >
> > > > -             /* Give the slave device a suitable dynamic address *=
/
> > > > -             ret =3D i3c_master_get_free_addr(&master->base, last_=
addr + 1);
> > > > -             if (ret < 0)
> > > > -                     break;
> > > > -
> > > > -             addrs[dev_nb] =3D ret;
> > > > +             addrs[dev_nb] =3D dyn_addr;
> > > >               dev_dbg(master->dev, "DAA: device %d assigned to 0x%0=
2x\n",
> > > >                       dev_nb, addrs[dev_nb]);
> > > > -
> > > > -             writel(addrs[dev_nb], master->regs + SVC_I3C_MWDATAB)=
;
> > > >               last_addr =3D addrs[dev_nb++];
> > > >       }
> > > >
> > > >       /* Need manual issue STOP except for Complete condition */
> > > >       svc_i3c_master_emit_stop(master);
> > > > +     svc_i3c_master_flush_fifo(master);
> > > > +
> > > >       return ret;
> > > >  }
> > > >
> > > > @@ -1225,8 +1231,8 @@ static int svc_i3c_master_read(struct svc_i3c=
_master *master,
> > > >       return offset;
> > > >  }
> > > >
> > > > -static int svc_i3c_master_write(struct svc_i3c_master *master,
> > > > -                             const u8 *out, unsigned int len)
> > > > +static int svc_i3c_master_write(struct svc_i3c_master *master, con=
st u8 *out,
> > > > +                             unsigned int len, bool last)
> > > >  {
> > > >       int offset =3D 0, ret;
> > > >       u32 mdctrl;
> > > > @@ -1243,7 +1249,7 @@ static int svc_i3c_master_write(struct svc_i3=
c_master *master,
> > > >                * The last byte to be sent over the bus must either =
have the
> > > >                * "end" bit set or be written in MWDATABE.
> > > >                */
> > > > -             if (likely(offset < (len - 1)))
> > > > +             if (likely(offset < (len - 1)) || !last)
> > > >                       writel(out[offset++], master->regs + SVC_I3C_=
MWDATAB);
> > > >               else
> > > >                       writel(out[offset++], master->regs + SVC_I3C_=
MWDATABE);
> > > > @@ -1274,6 +1280,17 @@ static int svc_i3c_master_xfer(struct svc_i3=
c_master *master,
> > > >                      SVC_I3C_MCTRL_RDTERM(*actual_len),
> > > >                      master->regs + SVC_I3C_MCTRL);
> > > >
> > > > +             if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) &=
& !rnw && xfer_len) {
> > > > +                     u32 len =3D min_t(u32, xfer_len, SVC_I3C_FIFO=
_SIZE);
> > > > +
> > > > +                     ret =3D svc_i3c_master_write(master, out, len=
,
> > > > +                                                xfer_len <=3D SVC_=
I3C_FIFO_SIZE);
> > > > +                     if (ret < 0)
> > > > +                             goto emit_stop;
> > > > +                     xfer_len -=3D len;
> > > > +                     out +=3D len;
> > > > +             }
> > > > +
> > >
> > > The same here, you prefill data after issue sent out address, timing =
still
> > > tight, only 9 SCL clock time. should it prefill before issue address?
> > >
> > > Frank
> >
> > The entire transaction can consist of multiple read and write
> > transfers. In the case
> > of S+7E/W+Sr+dyn_addr/W+data+P, If the data is prefilled before Sr, it
> > will be emitted
>
> I think S+7E/W should be xfer[0]
>         Sr+dyn_addr/W + data + P should be xfer[1]
>
> this function only handle one xfer each call. xfer[0]'s size is 0, no
> pre fill data.
>
> Only have prefill data at xfer[1].
>

Hi Frank,

Please check the example, a transaction contains 2 transfers.
xfer[0].addr=3D7E/W, no data
xfer[1].addr=3Ddyn_addr/W, with data

send xfer[0]:
1. Emit Start+7E/W
2. Wait for MCTRLDONE
send xfer[1]:
3. Prefill xfer[1].data  // data is emitted immediately
4. Emit RepeatedStart+dyn_addr/W
5. Wait for MCTRLDONE
6. Write remaining data to FIFO if needed
7. Emit STOP

Part of xfer[1].data is emitted in xfer[0], which is the problem of prefill
before EmitStartAddr. This is the reason I moved step 3 after step 4.


> > immediately and become part of the previous transfer.
> >
> > It is not a problem to fill FIFO here, the reason is the same as above.
> > I will also modify the code as below to make it efficient and keep
> > svc_i3c_master_write unchanged.
>
> no issue to modify svc_i3c_master_write(). I consider prefill data before
> actually.
>
> This hardware is not prefect.  Although it aleady in spin lock, it may ru=
n
> some secuity firmware in secuity domain.  There are 100us timeout. If a
> hypervisor manage firmware interrupt transfer, one timeout may happen.
>
> If prefill data before send address,  it was safe at least for lenght les=
s
> than FIFO case.
>
> Frank
>

Since prefill before EmitStartAddr has the problem I mentioned above, the F=
IFO
should start filling as soon as possible to work around the hardware issue.
This is why I prefer writing MWDATAB here instead of using svc_i3c_master_w=
rite,
as it can save some polling time.

The hardware-specific quirk is added to avoid affecting other platforms tha=
t
do not have this issue.

Stanley


> >
> >                 if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) &&
> > !rnw && xfer_len) {
> >                         u32 len =3D min_t(u32, xfer_len, SVC_I3C_FIFO_S=
IZE);
> >
> >                         while (len--) {
> >                                 if (xfer_len =3D=3D 1)
> >                                         writel(out[0], master->regs +
> > SVC_I3C_MWDATABE);
> >                                 else
> >                                         writel(out[0], master->regs +
> > SVC_I3C_MWDATAB);
> >                                 xfer_len--;
> >                                 out++;
> >                         }
> >                 }
> >
> >
> > >
> > > >               ret =3D readl_poll_timeout(master->regs + SVC_I3C_MST=
ATUS, reg,
> > > >                                SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1=
000);
> > > >               if (ret)
> > > > @@ -1335,7 +1352,7 @@ static int svc_i3c_master_xfer(struct svc_i3c=
_master *master,
> > > >       if (rnw)
> > > >               ret =3D svc_i3c_master_read(master, in, xfer_len);
> > > >       else
> > > > -             ret =3D svc_i3c_master_write(master, out, xfer_len);
> > > > +             ret =3D svc_i3c_master_write(master, out, xfer_len, t=
rue);
> > > >       if (ret < 0)
> > > >               goto emit_stop;
> > > >
> > > > @@ -1362,6 +1379,7 @@ static int svc_i3c_master_xfer(struct svc_i3c=
_master *master,
> > > >  emit_stop:
> > > >       svc_i3c_master_emit_stop(master);
> > > >       svc_i3c_master_clear_merrwarn(master);
> > > > +     svc_i3c_master_flush_fifo(master);
> > > >
> > > >       return ret;
> > > >  }
> > > > --
> > > > 2.34.1
> > > >
> >
> > --
> > linux-i3c mailing list
> > linux-i3c@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-i3c

