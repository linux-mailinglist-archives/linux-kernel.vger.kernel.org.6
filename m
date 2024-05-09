Return-Path: <linux-kernel+bounces-174478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06408C0F58
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C72282018
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF96714C591;
	Thu,  9 May 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="MuyTcKIw"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577918E0E
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256496; cv=none; b=XQfaK1WAngpgEw5Jq7NQbh9EnPCW8/11T3AiKYqS0Uk6dhDz2m8EhAg77aB9WokgDbe4UDYESPl4FARsd1pxgSrLWVG0SAyzSF/yBkz7ISyZfnX16V7Cq3eiuvxu4OkXdHO9EEyQpy0l1NZQpMghi0m8I2f3k0s4PTWYKX6TQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256496; c=relaxed/simple;
	bh=+01TA5ZUxNo2/7VkWc+eXZ6sH4MRBj4uV65fOZLXwkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4Vde/JkcYTM4Wr3BAAMVmhD9oW0f7E3Uzqgro4w552sg9zEkUKIG+PDjJbivXRHP/mB0O/VepS66eKp30T0zV4NwFVZHPFinmGuskXmlU6/VcM9Vqzjr0XQp/+Uc+Mvith7X39ZGMs+6Zh0/r/ZGyADrZOydr0u3+LBNeGjvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=MuyTcKIw; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36c8bdc30f7so3221625ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 05:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1715256493; x=1715861293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0/sHEsU5Iuak7LrbKVuAGkVdZseEUXuu3gE0C3VzY4=;
        b=MuyTcKIwzhY44Mbz+TmIFMaO5tgaCkN5zMI92QLhykYxzg+/CiUS87CkmavfNg0MT6
         877c1JDKRqdOwhcEiHpSM9enG4n8TquImKG/azKV2wyXNotwEmMqsonUcxOqvZC75crG
         UxZlcbCN9daZtKnq1IPvTJWeeFUIUUd7To/wNDzvMe1DMd5xEVhsf7pxzbyN+HKElqiM
         QRrJvh0TmUnTFtWFk2nSOMsCL3ZWMCMOvm3mPbmGPzAU2CkB00l7daOh47ttssAyrLfL
         Rg8ojoPCpYDCP9ALjyAUP96a28l3EcEWoyqE8Tcs6ohHW4RffrAjFtbJKCpvW25zjKpg
         2tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715256493; x=1715861293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0/sHEsU5Iuak7LrbKVuAGkVdZseEUXuu3gE0C3VzY4=;
        b=bvaLKjceJ9xdqDfVpKODgTbaVrmQwoIIKlDUmlCzk0/j/7E6wrH7uX0Go3WaVxP3RK
         vF6Oyj9NX74GSZY53Y5PuPlr+yHxPGMxXtDVm9zbleDFulITVl9kNHTtQNQAcwWktCrK
         l1syVDby4DGnbctWiridC02cj+yeenAEP+hhvsSV5FvfuYCIAsOD5j1D4pyVYAzqqNVc
         x2K2QYR0uXgFeUvcF9e8fU6xZWALgByYBozudOb4ksckS9oHWCDP4mKxgm1AwrgZwFSV
         OsLyh8itVQCfqfqvUIx2IhhjTajsU671z1Knn/XfBD0sZj/vxtL4ASfl1tOLr1D5XKSD
         EMyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSsv2euLrpQeKmsYMxlNM9e5l4huv65+fkI3dzVRuBw0gI9JjQr6m7LN1o3DiMPokSp68pmzsdiSdx8lLqcNhY6GYlS1voFBYGE6tE
X-Gm-Message-State: AOJu0YzGFdEUuWWAlePWMRBQHtubM7g2V7mUl9U0k6Jdm4BKT+JBhe0u
	Vmr/Sb3hvx7s51Q5Rq0AmA44rdK6EcSkITvhWd/Qgr1LldvZ2mRxdOLYY9DfVDdhCQBkDu5LqB9
	hLUGKMMcxX9ETbtMbLKhUEbi2UtKUPU9aKXRw5InCk3Jo51mr
X-Google-Smtp-Source: AGHT+IFxngAXt8R2TVgbhQdKQz0TYJYNPoSykwlNOk9jjQmT5XnJ91XOvqcUmMyg4SOw6a0EP4txAyNz02ST9bCGXwM=
X-Received: by 2002:a92:c242:0:b0:36c:a2c:ceaf with SMTP id
 e9e14a558f8ab-36caecc863fmr59112085ab.6.1715256492972; Thu, 09 May 2024
 05:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430040822.1133339-1-apatel@ventanamicro.com> <CAGETcx8C81OAfpTVBqk1yRdcwFG5v7v0PWVF6Udg2gPK0vH9dQ@mail.gmail.com>
In-Reply-To: <CAGETcx8C81OAfpTVBqk1yRdcwFG5v7v0PWVF6Udg2gPK0vH9dQ@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 9 May 2024 17:37:59 +0530
Message-ID: <CAAhSdy0g_2xeuox3yn=dwtk8aZmozO_ctVAfubNRvQVh=C4MpA@mail.gmail.com>
Subject: Re: [PATCH v3] of: property: Add fw_devlink support for interrupt-map property
To: Saravana Kannan <saravanak@google.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Rob Herring <robh@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 2:25=E2=80=AFAM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Mon, Apr 29, 2024 at 9:08=E2=80=AFPM Anup Patel <apatel@ventanamicro.c=
om> wrote:
> >
> > Some of the PCI controllers (such as generic PCI host controller)
> > use "interrupt-map" DT property to describe the mapping between
> > PCI endpoints and PCI interrupt pins. This the only case where
> > the interrupts are not described in DT.
> >
> > Currently, there is no fw_devlink created based on "interrupt-map"
> > DT property so interrupt controller is not guaranteed to be probed
> > before PCI host controller. This affects every platform where both
> > PCI host controller and interrupt controllers are probed as regular
> > platform devices.
> >
> > This creates fw_devlink between consumers (PCI host controller) and
> > supplier (interrupt controller) based on "interrupt-map" DT property.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> > Changes since v2:
> > - No need for a loop to find #interrupt-cells property value
> > - Fix node de-reference leak when index is greater than number
> >   of entries in interrupt-map property
> > Changes since v1:
> > - Updated commit description based on Rob's suggestion
> > - Use of_irq_parse_raw() for parsing interrupt-map DT property
> > ---
> >  drivers/of/property.c | 50 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index a6358ee99b74..7326ca07adfe 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1311,6 +1311,55 @@ static struct device_node *parse_interrupts(stru=
ct device_node *np,
> >         return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args=
np;
> >  }
> >
> > +static struct device_node *parse_interrupt_map(struct device_node *np,
> > +                                              const char *prop_name, i=
nt index)
> > +{
> > +       const __be32 *imap, *imap_end, *addr;
> > +       struct of_phandle_args sup_args;
> > +       u32 addrcells, intcells;
> > +       int i, imaplen;
> > +
> > +       if (!IS_ENABLED(CONFIG_OF_IRQ))
> > +               return NULL;
> > +
> > +       if (strcmp(prop_name, "interrupt-map"))
> > +               return NULL;
> > +
> > +       if (of_property_read_u32(np, "#interrupt-cells", &intcells))
> > +               return NULL;
> > +       addrcells =3D of_bus_n_addr_cells(np);
> > +
> > +       imap =3D of_get_property(np, "interrupt-map", &imaplen);
> > +       if (!imap || imaplen <=3D (addrcells + intcells))
> > +               return NULL;
> > +       imap_end =3D imap + imaplen;
> > +
> > +       sup_args.np =3D NULL;
> > +       while (imap < imap_end) {
> > +               addr =3D imap;
> > +               imap +=3D addrcells;
> > +
> > +               sup_args.np =3D np;
> > +               sup_args.args_count =3D intcells;
> > +               for (i =3D 0; i < intcells; i++)
> > +                       sup_args.args[i] =3D be32_to_cpu(imap[i]);
> > +               imap +=3D intcells;
> > +
> > +               if (of_irq_parse_raw(addr, &sup_args))
> Can you leave a comment above this call saying of_irq_parse_raw()
> updates sup_args.np? It's really a problem with the function IMO, but
> a comment here would be helpful.

Sure, I will add a comment about this.

>
> > +                       return NULL;
> > +
> > +               if (!index)
> > +                       return sup_args.np;
> > +
> > +               of_node_put(sup_args.np);
> > +               sup_args.np =3D NULL;
>
> Why do you need to set it to NULL? Can we just delete this line?

These NULL assignments are residue from previous revision. I will
remove these assignments.

>
> If you take care of these minor comments, then
>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
>
> -Saravana
>
> > +               imap +=3D sup_args.args_count + 1;
> > +               index--;
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> >  static struct device_node *parse_remote_endpoint(struct device_node *n=
p,
> >                                                  const char *prop_name,
> >                                                  int index)
> > @@ -1359,6 +1408,7 @@ static const struct supplier_bindings of_supplier=
_bindings[] =3D {
> >         { .parse_prop =3D parse_msi_parent, },
> >         { .parse_prop =3D parse_gpio_compat, },
> >         { .parse_prop =3D parse_interrupts, },
> > +       { .parse_prop =3D parse_interrupt_map, },
> >         { .parse_prop =3D parse_regulators, },
> >         { .parse_prop =3D parse_gpio, },
> >         { .parse_prop =3D parse_gpios, },
> > --
> > 2.34.1
> >

Thanks,
Anup

