Return-Path: <linux-kernel+bounces-194488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939E88D3D12
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9C21F219B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415CA18412E;
	Wed, 29 May 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCkNXUfP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A11836DB;
	Wed, 29 May 2024 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001230; cv=none; b=MJzTBufvlzhIWJdmvgHdy+g1yC5yEB3ohOhmC02oieo/EGtvIkKZUaxgVGqYKQkrM04EI612Qfqnh+KPZCbdggM8RTxoexN5fwMwt6RtHvP3vdUZWI76ACA432SMXNGq5AM2V29HmgGal3M//o0uJtkyliwkfs4VjK5wnKMcaRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001230; c=relaxed/simple;
	bh=n7ShnOOdeIWlPrL1n4Qs6VgIfCSCN6l/akX1/ZK9iYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWONw/aPYv53ktZdz0KOhV/Abib4IwBhimTgT+lWwJheh7QkiBeP9QpZhCBcaPy+SHklsH5AeuqJhNbcOW6VC/U4FUh41cCnsmN7h+Bv3DXBXfX6KABOKBGBBCs4VnoDL/mdmKSFrBWHRXijA0pXokXNF2z08jG5TybhA+AGqns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCkNXUfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B9CC2BD10;
	Wed, 29 May 2024 16:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717001229;
	bh=n7ShnOOdeIWlPrL1n4Qs6VgIfCSCN6l/akX1/ZK9iYo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aCkNXUfPlo3EhRbLwsDwFyRATwLVLUxUtj5wd3U/saK9gL5LhRqc4OABpaV61v8zT
	 ubUpa9SCgvaGflDHtcC8oDphpTExJvrdJ+lTHVVkOBGjvb5RCZRBTEAnMVwE2kM7ky
	 DL1TWkTid2Dw77FzPEK/ULvttmd3G6bb8U0Msa1QzIR43ZEhnhfPlO7fYqttmVEd1X
	 m0kx6PFCQ9hiWY6dGLVwi+TVW0JGQ7hNUH2kXCA1V7vf7fIbrl1+r+ZGIFsLdtL5Hp
	 TM1sj/29jL/UZBxiuz4r8M6mtqA0FkvfVZTUdoUobAUeaoBZMayRftrVGZolSbCs1v
	 Lq91EPR1iUUOA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b78ef397bso191000e87.0;
        Wed, 29 May 2024 09:47:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKjWdIYunNS7nq+gyVDdD3nNA0iBHzuF1LjW8twFBt5nBmD8jUYptFgw5PQdlFENT/OdiiO2+YtfQTINqnuZgkUgU6Sj2my+vJSbh/xWfZEw2Imx2Rz04NwMVArbLlZM4lXQ/JWgAriQ==
X-Gm-Message-State: AOJu0YyDBjgHbfDbw8FWTZmQYAwTcI194Q8zQmNgEQxp84MiTIT1K/9s
	GQOaXVJUBDuMbZDTLVTXvOvoZlKPOSCr/2t0bz3R+oLVIzC8SVseGyJX+Qn9nwBJahtJU2qvb9i
	xszD6KDrpFmUS+8jTFMLGb4tPyg==
X-Google-Smtp-Source: AGHT+IFE6/+pP8QOr7VDz95upfl9e+YZ3sfN4RgI1zbUAJDDzRKCICanPYQR7UH0Oun/B9qoZvrxOicJ6ZYmtkymUpk=
X-Received: by 2002:ac2:5a08:0:b0:52a:7742:4593 with SMTP id
 2adb3069b0e04-52a78c36684mr864211e87.25.1717001228317; Wed, 29 May 2024
 09:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528164132.2451685-1-maz@kernel.org> <CAK9=C2XNPJP0X=pg5TSrQbsuouDD3jP-gy2Sm4BXNJp0ZiWp+A@mail.gmail.com>
 <86bk4pm8j1.wl-maz@kernel.org> <CAK9=C2XRx==OTPoGW_AHmjq4Th0bv4okwcq6-3L5JYwHwQp97A@mail.gmail.com>
 <86a5k8nbh1.wl-maz@kernel.org> <CAK9=C2Ugq=0y8M86CD75mQccBo=TBLBomb4rqC4i1naKy2LyWQ@mail.gmail.com>
 <CAL_JsqJE15D-xXxmELsmuD+JQHZzxGzdXvikChn6KFWqk6NzPw@mail.gmail.com>
In-Reply-To: <CAL_JsqJE15D-xXxmELsmuD+JQHZzxGzdXvikChn6KFWqk6NzPw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 29 May 2024 11:46:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL5BwSCZDZPNW2-0kBOw0j9KZZ8WOdnqEmGKhSgquY6Pw@mail.gmail.com>
Message-ID: <CAL_JsqL5BwSCZDZPNW2-0kBOw0j9KZZ8WOdnqEmGKhSgquY6Pw@mail.gmail.com>
Subject: Re: [PATCH] of: property: Fix fw_devlink handling of interrupt-map
To: Anup Patel <apatel@ventanamicro.com>
Cc: Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 8:51=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, May 29, 2024 at 6:28=E2=80=AFAM Anup Patel <apatel@ventanamicro.c=
om> wrote:
> >
> > On Wed, May 29, 2024 at 4:15=E2=80=AFPM Marc Zyngier <maz@kernel.org> w=
rote:
> > >
> > > On Wed, 29 May 2024 11:16:30 +0100,
> > > Anup Patel <apatel@ventanamicro.com> wrote:
> > > >
> > > > On Wed, May 29, 2024 at 12:03=E2=80=AFPM Marc Zyngier <maz@kernel.o=
rg> wrote:
> > > > >
> > > > > On Wed, 29 May 2024 06:15:52 +0100,
> > > > > Anup Patel <apatel@ventanamicro.com> wrote:
> > > > > >
> > > > > > On Tue, May 28, 2024 at 10:11=E2=80=AFPM Marc Zyngier <maz@kern=
el.org> wrote:
> > > > > > >
> > > > > > > Commit d976c6f4b32c ("of: property: Add fw_devlink support fo=
r
> > > > > > > interrupt-map property") tried to do what it says on the tin,
> > > > > > > but failed on a couple of points:
> > > > > > >
> > > > > > > - it confuses bytes and cells. Not a huge deal, except when i=
t
> > > > > > >   comes to pointer arithmetic
> > > > > > >
> > > > > > > - it doesn't really handle anything but interrupt-maps that h=
ave
> > > > > > >   their parent #address-cells set to 0
> > > > > > >
> > > > > > > The combinations of the two leads to some serious fun on my M=
1
> > > > > > > box, with plenty of WARN-ON() firing all over the shop, and
> > > > > > > amusing values being generated for interrupt specifiers.
> > > > > > >
> > > > > > > Address both issues so that I can boot my machines again.
> > > > > > >
> > > > > > > Fixes: d976c6f4b32c ("of: property: Add fw_devlink support fo=
r interrupt-map property")
> > > > > > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > > > > > Cc: Anup Patel <apatel@ventanamicro.com>
> > > > > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > > > > Cc: Rob Herring (Arm) <robh@kernel.org>
> > > > > >
> > > > > > Thanks for the fix patch but unfortunately it breaks for RISC-V=
.
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/of/property.c | 16 ++++++++++++++--
> > > > > > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > > > index 1c83e68f805b..9adebc63bea9 100644
> > > > > > > --- a/drivers/of/property.c
> > > > > > > +++ b/drivers/of/property.c
> > > > > > > @@ -1322,7 +1322,13 @@ static struct device_node *parse_inter=
rupt_map(struct device_node *np,
> > > > > > >         addrcells =3D of_bus_n_addr_cells(np);
> > > > > > >
> > > > > > >         imap =3D of_get_property(np, "interrupt-map", &imaple=
n);
> > > > > > > -       if (!imap || imaplen <=3D (addrcells + intcells))
> > > > > > > +       imaplen /=3D sizeof(*imap);
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * Check that we have enough runway for the child uni=
t interrupt
> > > > > > > +        * specifier and a phandle. That's the bare minimum w=
e can expect.
> > > > > > > +        */
> > > > > > > +       if (!imap || imaplen <=3D (addrcells + intcells + 1))
> > > > > > >                 return NULL;
> > > > > > >         imap_end =3D imap + imaplen;
> > > > > > >
> > > > > > > @@ -1346,8 +1352,14 @@ static struct device_node *parse_inter=
rupt_map(struct device_node *np,
> > > > > > >                 if (!index)
> > > > > > >                         return sup_args.np;
> > > > > > >
> > > > > > > -               of_node_put(sup_args.np);
> > > > > > > +               /*
> > > > > > > +                * Account for the full parent unit interrupt=
 specifier
> > > > > > > +                * (address cells, interrupt cells, and phand=
le).
> > > > > > > +                */
> > > > > > > +               imap +=3D of_bus_n_addr_cells(sup_args.np);
> > > > > >
> > > > > > This breaks for RISC-V because we don't have "#address-cells"
> > > > > > property in interrupt controller DT node and of_bus_n_addr_cell=
s()
> > > > > > retrieves "#address-cells" from the parent of interrupt control=
ler.
> > > > >
> > > > > That's a feature, not a bug. #address-cells, AFAICT, applies to a=
ll
> > > > > child nodes until you set it otherwise.
> > > > >
> > > > > >
> > > > > > The of_irq_parse_raw() looks for "#address-cells" property
> > > > > > in the interrupt controller DT node only so we should do a
> > > > > > similar thing here as well.
> > > > >
> > > > > This looks more like a of_irq_parse_raw() bug than anything else.
> > > >
> > > > If we change of_irq_parse_raw() to use of_bus_n_addr_cells()
> > > > then it would still break for RISC-V.
> > >
> > > I'm not trying to "fix" riscv. I'm merely outlining that you are
> > > relying on both broken DTs and a buggy OS.
> > >
> > > >
> > > > Using of_bus_n_addr_cells() over here forces interrupt controller
> > > > DT nodes to have a "#address-cells" DT property. There are many
> > > > interrupt controller (e.g. RISC-V PLIC or RISC-V APLIC) where the
> > > > DT bindings don't require "#address-cells" DT property and existing
> > > > DTS files with such interrupt controllers don't have it either.
> > >
> > > It forces you to set #address-cells *if you rely on a different
> > > value in a child node*. It's not like the semantics are new.
> >
> > We don't have child nodes under the interrupt controller DT node
> > (for both RISC-V PLIC and APLIC) so we certainly don't require the
> > "#address-cells" property in the interrupt controller DT node.
>
> interrupt controller nodes which are referred to by interrupt-map
> require #address-cells. Period. Child nodes or not.

Now that I've re-read the code, the kernel will treat missing
#address-cells in the interrupt parent as 0. Looking in the parent
nodes for #address-cells only happens for the input address (i.e. the
address before the phandle). IOW, the first use of_bus_n_addr_cells()
was correct, but the 2nd use is not correct. That's not great, but
that's how this code passed down on stone tablets works...

As I commented on v1 of the original patch. I don't like parsing
interrupt-map in 2 places. It leads to problems exactly as this thread
has shown. The duplication was reduced some, but is still more than
I'd like. So I'm looking at how to refactor of_irq_parse_raw() to make
it work for what's needed here. Maybe I'll have a fix quickly. If not,
I'm going to revert the original commit.

Rob

