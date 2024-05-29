Return-Path: <linux-kernel+bounces-194205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9FF8D385F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C051F279F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8DC1BC3F;
	Wed, 29 May 2024 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glTvyKE1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5F4C83;
	Wed, 29 May 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990684; cv=none; b=Cn8qGvMLPDr7yk1/cVXZfKQCuOnkSxqc6RmKuowkUl4rXldBj4HzwmkHPSj5xTkgAIfMAd/wHgGd1pmVyBIgYpGzK7WU9X+ljFkSt1qY+OxWDHI8ThPt5tnsfu/8aR1cCcH0tmHhainDc9e0JQDh7qvg0YkSL6vQAfA4SDMftpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990684; c=relaxed/simple;
	bh=BJ0TXx2vfnEC4Z+RIBMvi1k52uSQxAJ881y+TAk76Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnF774dSzHLby+guh8V/XaI7SdVDgj/QBeCLNwh6/wil/Wgc1L8eP8cuGSc8Z6PYgYMhYM4iBZlFVIW94b2hQ9pbsbIDBPvjy3vm3gVdgOWz4d7THgq9D0M1QwPX+YzVYaUBUz9FtW9sQ6jBcOBhS5G4am0wbFN4SP2zFYFZcSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glTvyKE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87935C113CC;
	Wed, 29 May 2024 13:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716990682;
	bh=BJ0TXx2vfnEC4Z+RIBMvi1k52uSQxAJ881y+TAk76Xc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=glTvyKE1BDLaoKay4Is2RxK9ZLP7otBzDadCkbihj7j5fOfCzNhbrdsF7E72O5zZs
	 R49BngIslnkt9pCOyfhIGCkbEt+q0aus9GUwZB1UaGjGPcKeFNThjZu+Qts0VEMgIr
	 aIuIy162D3mvj9p9cCjSmpBMVnlXC2iQARHZ478J+Nm5BuiSsXr6NbuA4nf4UPTPMZ
	 J+Jj6aXUKrkyMRHFDu5g8dO05w3oSZjHkQ29W8plGuwR1stJSQLh5GRHaAYPHXOaSa
	 hFsE/Ri7V/orrGaZ8nLeQEw7wXGrRd1oIZhIhmo3asqFECyCaoKF71oTxKhhJPKwJR
	 JczYkWElMSGIw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b79447c58so438320e87.1;
        Wed, 29 May 2024 06:51:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXezOK60I/UKylTL+jQfbB2BBlH6pkptGNIfgjKABmOoIJeOo9CbiocoPshDHOca7HjvQMp5BqXheJsp/mVL9SORd0MZgOkKLDjzSW8X+KaEY2qJoc2uSW8bOpTC0oG0EITR++FgQO/Zw==
X-Gm-Message-State: AOJu0YwAa+OvHxGKiksE5LvwftOiAoliOXOTtJIdR3XdwZLyqskdMYdD
	e//N3kIPpC5d5xMk1Ysv9yBQrqFJjzGE5mea4H3XAPlf4knRQFXEQfMzMJgh63s7m8lBMrwOdLR
	CxmoLPTQJh5uhhIDkwwQ7ph5fuA==
X-Google-Smtp-Source: AGHT+IFw3h5FJYkh/BLuUPGGhDkU0QPpEgcY8mopX/t1NYjI2PH+epPkMD4dMuQuIVTrx+ZhnDlOady59nQVDczYcsA=
X-Received: by 2002:ac2:5dc1:0:b0:522:8352:ff29 with SMTP id
 2adb3069b0e04-5296736bb86mr12249215e87.42.1716990680924; Wed, 29 May 2024
 06:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528164132.2451685-1-maz@kernel.org> <CAK9=C2XNPJP0X=pg5TSrQbsuouDD3jP-gy2Sm4BXNJp0ZiWp+A@mail.gmail.com>
 <86bk4pm8j1.wl-maz@kernel.org> <CAK9=C2XRx==OTPoGW_AHmjq4Th0bv4okwcq6-3L5JYwHwQp97A@mail.gmail.com>
 <86a5k8nbh1.wl-maz@kernel.org> <CAK9=C2Ugq=0y8M86CD75mQccBo=TBLBomb4rqC4i1naKy2LyWQ@mail.gmail.com>
In-Reply-To: <CAK9=C2Ugq=0y8M86CD75mQccBo=TBLBomb4rqC4i1naKy2LyWQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 29 May 2024 08:51:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJE15D-xXxmELsmuD+JQHZzxGzdXvikChn6KFWqk6NzPw@mail.gmail.com>
Message-ID: <CAL_JsqJE15D-xXxmELsmuD+JQHZzxGzdXvikChn6KFWqk6NzPw@mail.gmail.com>
Subject: Re: [PATCH] of: property: Fix fw_devlink handling of interrupt-map
To: Anup Patel <apatel@ventanamicro.com>
Cc: Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 6:28=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Wed, May 29, 2024 at 4:15=E2=80=AFPM Marc Zyngier <maz@kernel.org> wro=
te:
> >
> > On Wed, 29 May 2024 11:16:30 +0100,
> > Anup Patel <apatel@ventanamicro.com> wrote:
> > >
> > > On Wed, May 29, 2024 at 12:03=E2=80=AFPM Marc Zyngier <maz@kernel.org=
> wrote:
> > > >
> > > > On Wed, 29 May 2024 06:15:52 +0100,
> > > > Anup Patel <apatel@ventanamicro.com> wrote:
> > > > >
> > > > > On Tue, May 28, 2024 at 10:11=E2=80=AFPM Marc Zyngier <maz@kernel=
org> wrote:
> > > > > >
> > > > > > Commit d976c6f4b32c ("of: property: Add fw_devlink support for
> > > > > > interrupt-map property") tried to do what it says on the tin,
> > > > > > but failed on a couple of points:
> > > > > >
> > > > > > - it confuses bytes and cells. Not a huge deal, except when it
> > > > > >   comes to pointer arithmetic
> > > > > >
> > > > > > - it doesn't really handle anything but interrupt-maps that hav=
e
> > > > > >   their parent #address-cells set to 0
> > > > > >
> > > > > > The combinations of the two leads to some serious fun on my M1
> > > > > > box, with plenty of WARN-ON() firing all over the shop, and
> > > > > > amusing values being generated for interrupt specifiers.
> > > > > >
> > > > > > Address both issues so that I can boot my machines again.
> > > > > >
> > > > > > Fixes: d976c6f4b32c ("of: property: Add fw_devlink support for =
interrupt-map property")
> > > > > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > > > > Cc: Anup Patel <apatel@ventanamicro.com>
> > > > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > > > Cc: Rob Herring (Arm) <robh@kernel.org>
> > > > >
> > > > > Thanks for the fix patch but unfortunately it breaks for RISC-V.
> > > > >
> > > > > > ---
> > > > > >  drivers/of/property.c | 16 ++++++++++++++--
> > > > > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > > index 1c83e68f805b..9adebc63bea9 100644
> > > > > > --- a/drivers/of/property.c
> > > > > > +++ b/drivers/of/property.c
> > > > > > @@ -1322,7 +1322,13 @@ static struct device_node *parse_interru=
pt_map(struct device_node *np,
> > > > > >         addrcells =3D of_bus_n_addr_cells(np);
> > > > > >
> > > > > >         imap =3D of_get_property(np, "interrupt-map", &imaplen)=
;
> > > > > > -       if (!imap || imaplen <=3D (addrcells + intcells))
> > > > > > +       imaplen /=3D sizeof(*imap);
> > > > > > +
> > > > > > +       /*
> > > > > > +        * Check that we have enough runway for the child unit =
interrupt
> > > > > > +        * specifier and a phandle. That's the bare minimum we =
can expect.
> > > > > > +        */
> > > > > > +       if (!imap || imaplen <=3D (addrcells + intcells + 1))
> > > > > >                 return NULL;
> > > > > >         imap_end =3D imap + imaplen;
> > > > > >
> > > > > > @@ -1346,8 +1352,14 @@ static struct device_node *parse_interru=
pt_map(struct device_node *np,
> > > > > >                 if (!index)
> > > > > >                         return sup_args.np;
> > > > > >
> > > > > > -               of_node_put(sup_args.np);
> > > > > > +               /*
> > > > > > +                * Account for the full parent unit interrupt s=
pecifier
> > > > > > +                * (address cells, interrupt cells, and phandle=
).
> > > > > > +                */
> > > > > > +               imap +=3D of_bus_n_addr_cells(sup_args.np);
> > > > >
> > > > > This breaks for RISC-V because we don't have "#address-cells"
> > > > > property in interrupt controller DT node and of_bus_n_addr_cells(=
)
> > > > > retrieves "#address-cells" from the parent of interrupt controlle=
r.
> > > >
> > > > That's a feature, not a bug. #address-cells, AFAICT, applies to all
> > > > child nodes until you set it otherwise.
> > > >
> > > > >
> > > > > The of_irq_parse_raw() looks for "#address-cells" property
> > > > > in the interrupt controller DT node only so we should do a
> > > > > similar thing here as well.
> > > >
> > > > This looks more like a of_irq_parse_raw() bug than anything else.
> > >
> > > If we change of_irq_parse_raw() to use of_bus_n_addr_cells()
> > > then it would still break for RISC-V.
> >
> > I'm not trying to "fix" riscv. I'm merely outlining that you are
> > relying on both broken DTs and a buggy OS.
> >
> > >
> > > Using of_bus_n_addr_cells() over here forces interrupt controller
> > > DT nodes to have a "#address-cells" DT property. There are many
> > > interrupt controller (e.g. RISC-V PLIC or RISC-V APLIC) where the
> > > DT bindings don't require "#address-cells" DT property and existing
> > > DTS files with such interrupt controllers don't have it either.
> >
> > It forces you to set #address-cells *if you rely on a different
> > value in a child node*. It's not like the semantics are new.
>
> We don't have child nodes under the interrupt controller DT node
> (for both RISC-V PLIC and APLIC) so we certainly don't require the
> "#address-cells" property in the interrupt controller DT node.

interrupt controller nodes which are referred to by interrupt-map
require #address-cells. Period. Child nodes or not.

Really, it should be just interrupt-controller nodes require
#address-cells, but that spewed too many warnings so it's limited to
where it is really needed.

Rob

