Return-Path: <linux-kernel+bounces-530863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C98A4397C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5F81885F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D88025EF9A;
	Tue, 25 Feb 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdk7E+GP"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206531FE465;
	Tue, 25 Feb 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475742; cv=none; b=cALRuN3TZUZlY5z0NizhciHSv6ruz3tv80hxyl3y0FTb/CC3BQFERv34VtUVOV1St1HJ2SCu85y4IKS/SW2q3G0DmRZm7n/BFzY76//1712BsjLBhC5VXtjJ3P5H56GA6qWqX6Y678kMSxgfwKLWuw8+q/TTEADoaaHmretUtfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475742; c=relaxed/simple;
	bh=OdzuHQdFfMJy5x96fUs0BOGptZ7qLb7hY+obT5tqo5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8GL0E9VQfo9PsUgGuxRWAlpKYj7p4v0eRGg0f1SjU6clW7PJz/yQfRRXu1YkPPC1TW4rG2b3is1IoirSKb+N3goCwWES0PijuMZwauiLPWEhcEkUwaq0Q7gpNS4kCb78JPMkljMzOoQd2zdq3OwOYrFpAt4SWJBNU3XE9Urbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gdk7E+GP; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d2f5a93a32so6861155ab.0;
        Tue, 25 Feb 2025 01:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740475740; x=1741080540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5RAcrBB50TjVM/sWT6LRaM+Bt33WtMy317v0E/ly18=;
        b=Gdk7E+GP0+BDUqjJAcppCDPMxh57tkfFCaR0jx0chdLDrpvQMB/h8DoZxYd7K4a2yG
         hma/jkRNg2gfW0xwiL3qF6turZsq/qK+VsdRBJNEVqAekbv79s5BsaD84PlojCASPpnq
         pdeQR78txKAjRqw4KnHIvdP+rT5iSWR5Z/jMHb36VgBPYU2kw6VNoDWCjcAhg2Z8z2UM
         MeqUo8knLSOsLXeHwZZqwi5tTs4U6vG4UgVsVKad9FcmFTiZZ3B0NeyQedyROg1TVVHz
         enJDRJH4yFuf8cKj94oEiFL17zpXCaPcaQW+v6TRPl7FTbypNT3UaWKWNBhXaO+2GMkR
         qQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475740; x=1741080540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5RAcrBB50TjVM/sWT6LRaM+Bt33WtMy317v0E/ly18=;
        b=XNSepfCV93N7VM9L8mIFQHYP+phfmHHi5lL1/3oTlZOAGRTZ3r4p2DJRENiMypYoME
         ezu/23renVetUpeeiLKOphP50jqgW0tRynsd3kFkYfRlIRxUzUE0K4exQjff6+czN6W4
         J4H/AYoymMO7pE61o8MNc/ECDoBRiF5hMndeHlpoAHjQlcWG5rLyDohXm/1L+vE5hYxk
         m9sv0sPC6sHTUYrt+4l+Es/oNX2DzbhhGOlYVRyYbSstkKvRl0nREY79M7mI7HJxtCCB
         u+RkkRwLFDIUB6e/jcqQAj2t4ginFzQJH35IqU2ItSOzxcXQDcrFNgQYHektmVfyzZGX
         2MaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgL/R836sIdfevBH+5PaFZ5JefU2vO78BT4Gc4Bx7WjBYv1OC0eLSOkwa0f6WYv3GgtC+zVTS9LKt0@vger.kernel.org, AJvYcCWb0b3mJ8FbJ/eQsGxyo/rpHM16inch6Cl/K21SN5IsrYu7HMnRU02y4g+keY2TCX3ous+3qxLjzslYxW9h@vger.kernel.org
X-Gm-Message-State: AOJu0YzodDi7rjbWFzAl4Zty0FAXqNVks2Md7mhXLJooRynJ7nUwy4Fc
	+voXqPcXBCsz6689vz7+saqPBGhdrc3Mr9tuTuMRxz/+h+TBGtI+fQXAbffcU+AT+zay9y4v7wj
	33GnkdRgz4K3BD1l2DkETufbpzbs/dEci
X-Gm-Gg: ASbGncvzjXjqnmIv1VgF3thUADLoZSXAX64Kh8Ko6lRPYl2oG54ZzB3wQmsxXKEZBCb
	Cp3pabxBjWd2l9a1mFR/eycj3n2OzfI4VR/qBj9PJjRo7kj2PHIbBj6bBOOaZ4ndRs0l0Ou2E4D
	NcB/Hdc3wbpQ==
X-Google-Smtp-Source: AGHT+IG3S+miW8bytlxRLt4dF7J/MfWpqEtjKRP9Ux3q3q1rZRYxIzuRpYtll427KSmxvQf/Y4UVMgRQ4T9nILpToM8=
X-Received: by 2002:a05:6e02:3e06:b0:3d2:a5a0:8b02 with SMTP id
 e9e14a558f8ab-3d2cae6b894mr154201355ab.6.1740475739996; Tue, 25 Feb 2025
 01:28:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224083908.1880383-1-yschu@nuvoton.com> <20250224083908.1880383-4-yschu@nuvoton.com>
 <Z7yfEunAWuR8jchq@lizhi-Precision-Tower-5810>
In-Reply-To: <Z7yfEunAWuR8jchq@lizhi-Precision-Tower-5810>
From: Stanley Chu <stanley.chuys@gmail.com>
Date: Tue, 25 Feb 2025 17:28:48 +0800
X-Gm-Features: AQ5f1JpwY1gJAPYPQYccJ75GsOFquINzIz5MccpQ2uTgTVgAk5Kh2gziYHclTmE
Message-ID: <CAPwEoQNZef_CeeCDNFGG4oJHCiM3MN9-juq+xX3hB5DKp4vorQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] i3c: master: svc: Fix npcm845 FIFO empty issue
To: Frank Li <Frank.li@nxp.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i3c@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 12:32=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Feb 24, 2025 at 04:39:06PM +0800, Stanley Chu wrote:
> > From: Stanley Chu <yschu@nuvoton.com>
> >
> > I3C HW stalls the write transfer if the transmit FIFO becomes empty,
> > when new data is written to FIFO, I3C HW resumes the transfer but the
> > first transmitted data bit may have the wrong value.
> > Fill the FIFO in advance to prevent FIFO from becoming empty.
> >
> > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > ---
> >  drivers/i3c/master/svc-i3c-master.c | 44 ++++++++++++++++++++---------
> >  1 file changed, 31 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/s=
vc-i3c-master.c
> > index 8834f87a4767..07506ae0f914 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -942,7 +942,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_=
i3c_master *master,
> >                                       u8 *addrs, unsigned int *count)
> >  {
> >       u64 prov_id[SVC_I3C_MAX_DEVS] =3D {}, nacking_prov_id =3D 0;
> > -     unsigned int dev_nb =3D 0, last_addr =3D 0;
> > +     unsigned int dev_nb =3D 0, last_addr =3D 0, dyn_addr;
> >       u32 reg;
> >       int ret, i;
> >
> > @@ -985,6 +985,17 @@ static int svc_i3c_master_do_daa_locked(struct svc=
_i3c_master *master,
> >               if (SVC_I3C_MSTATUS_RXPEND(reg)) {
> >                       u8 data[6];
> >
> > +                     /*
> > +                      * One slave sends its ID to request for address =
assignment,
> > +                      * pre-filling the dynamic address can reduce SCL=
 clock stalls
> > +                      * and also fix the SVC_I3C_QUIRK_FIFO_EMPTY quir=
k.
> > +                      */
> > +                     dyn_addr =3D i3c_master_get_free_addr(&master->ba=
se, last_addr + 1);
> > +                     if (dyn_addr < 0)
> > +                             return -ENOSPC;
> > +
> > +                     writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
> > +
>
> Although there is 64 clock time after issue do_daa, it is still better if
> prefill dyn_addr before sent do daa command?
>
> If add a debug message before i3c_master_get_free_addr(), does it trigger
> hardware issue?
>
> Frank

Ideally, prefilling before the processDAA command is better. However,
it requires an additional check to write the dyn_addr at the right time
because the driver needs to write the processDAA command twice for one
assignment

Prefilling here is safe and efficient because the FIFO starts filling
within a few hundred nanoseconds on the npcm845, which is significantly
faster compared to the 64 SCL clock cycles.


>
> >                       /*
> >                        * We only care about the 48-bit provisioned ID y=
et to
> >                        * be sure a device does not nack an address twic=
e.
> > @@ -1063,21 +1074,16 @@ static int svc_i3c_master_do_daa_locked(struct =
svc_i3c_master *master,
> >               if (ret)
> >                       break;
> >
> > -             /* Give the slave device a suitable dynamic address */
> > -             ret =3D i3c_master_get_free_addr(&master->base, last_addr=
 + 1);
> > -             if (ret < 0)
> > -                     break;
> > -
> > -             addrs[dev_nb] =3D ret;
> > +             addrs[dev_nb] =3D dyn_addr;
> >               dev_dbg(master->dev, "DAA: device %d assigned to 0x%02x\n=
",
> >                       dev_nb, addrs[dev_nb]);
> > -
> > -             writel(addrs[dev_nb], master->regs + SVC_I3C_MWDATAB);
> >               last_addr =3D addrs[dev_nb++];
> >       }
> >
> >       /* Need manual issue STOP except for Complete condition */
> >       svc_i3c_master_emit_stop(master);
> > +     svc_i3c_master_flush_fifo(master);
> > +
> >       return ret;
> >  }
> >
> > @@ -1225,8 +1231,8 @@ static int svc_i3c_master_read(struct svc_i3c_mas=
ter *master,
> >       return offset;
> >  }
> >
> > -static int svc_i3c_master_write(struct svc_i3c_master *master,
> > -                             const u8 *out, unsigned int len)
> > +static int svc_i3c_master_write(struct svc_i3c_master *master, const u=
8 *out,
> > +                             unsigned int len, bool last)
> >  {
> >       int offset =3D 0, ret;
> >       u32 mdctrl;
> > @@ -1243,7 +1249,7 @@ static int svc_i3c_master_write(struct svc_i3c_ma=
ster *master,
> >                * The last byte to be sent over the bus must either have=
 the
> >                * "end" bit set or be written in MWDATABE.
> >                */
> > -             if (likely(offset < (len - 1)))
> > +             if (likely(offset < (len - 1)) || !last)
> >                       writel(out[offset++], master->regs + SVC_I3C_MWDA=
TAB);
> >               else
> >                       writel(out[offset++], master->regs + SVC_I3C_MWDA=
TABE);
> > @@ -1274,6 +1280,17 @@ static int svc_i3c_master_xfer(struct svc_i3c_ma=
ster *master,
> >                      SVC_I3C_MCTRL_RDTERM(*actual_len),
> >                      master->regs + SVC_I3C_MCTRL);
> >
> > +             if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !r=
nw && xfer_len) {
> > +                     u32 len =3D min_t(u32, xfer_len, SVC_I3C_FIFO_SIZ=
E);
> > +
> > +                     ret =3D svc_i3c_master_write(master, out, len,
> > +                                                xfer_len <=3D SVC_I3C_=
FIFO_SIZE);
> > +                     if (ret < 0)
> > +                             goto emit_stop;
> > +                     xfer_len -=3D len;
> > +                     out +=3D len;
> > +             }
> > +
>
> The same here, you prefill data after issue sent out address, timing stil=
l
> tight, only 9 SCL clock time. should it prefill before issue address?
>
> Frank

The entire transaction can consist of multiple read and write
transfers. In the case
of S+7E/W+Sr+dyn_addr/W+data+P, If the data is prefilled before Sr, it
will be emitted
immediately and become part of the previous transfer.

It is not a problem to fill FIFO here, the reason is the same as above.
I will also modify the code as below to make it efficient and keep
svc_i3c_master_write unchanged.

                if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) &&
!rnw && xfer_len) {
                        u32 len =3D min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE)=
;

                        while (len--) {
                                if (xfer_len =3D=3D 1)
                                        writel(out[0], master->regs +
SVC_I3C_MWDATABE);
                                else
                                        writel(out[0], master->regs +
SVC_I3C_MWDATAB);
                                xfer_len--;
                                out++;
                        }
                }


>
> >               ret =3D readl_poll_timeout(master->regs + SVC_I3C_MSTATUS=
, reg,
> >                                SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000)=
;
> >               if (ret)
> > @@ -1335,7 +1352,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_mas=
ter *master,
> >       if (rnw)
> >               ret =3D svc_i3c_master_read(master, in, xfer_len);
> >       else
> > -             ret =3D svc_i3c_master_write(master, out, xfer_len);
> > +             ret =3D svc_i3c_master_write(master, out, xfer_len, true)=
;
> >       if (ret < 0)
> >               goto emit_stop;
> >
> > @@ -1362,6 +1379,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_mas=
ter *master,
> >  emit_stop:
> >       svc_i3c_master_emit_stop(master);
> >       svc_i3c_master_clear_merrwarn(master);
> > +     svc_i3c_master_flush_fifo(master);
> >
> >       return ret;
> >  }
> > --
> > 2.34.1
> >

