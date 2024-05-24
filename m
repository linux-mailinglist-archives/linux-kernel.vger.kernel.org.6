Return-Path: <linux-kernel+bounces-188935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB48CE8BD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4052F1C212EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F92C12EBDC;
	Fri, 24 May 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iFOBYWj8"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF58626E
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568361; cv=none; b=sy1k4YiEEgO1AQDKwhzkwXcD7siSO7lYnpd2hncswoY7aI34WD7suQrTadds3QQqyyydZ01XyQMXyq3DveDjvuPi3fYPx6Ep2+irOvGyAEWiS2BGJnFNjTorwdU5PNYbWibeUwebbHVRO/0HLI+fmKTfWeS8gEh7ZHpHuTkA2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568361; c=relaxed/simple;
	bh=V5yJfKH4l9EdMIfe0zzFlx2/sSHkB5HTTY8hf6EMyzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XogezNBkAfD+ckwwu3yP6nF0tGWSjO+3S1DREgXOlOe8W6VlXFzI80uLXNv+PJYTRQcbAr61lseOICecUylMsfIBdlyn/kDgzyGWAlmSQNntyP5xna9w+goTQCtKEIshD05Ns9M3t6675UiK4HJiNzoVpJbGqGyxbuWsqHMuFnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=iFOBYWj8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5295f201979so1255749e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716568355; x=1717173155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rowFNmK/eeWfKpXfDGUas/+gao88imRRDFo7GrdeK1c=;
        b=iFOBYWj8DCERyFPtIfeIXbk0x3FEAV+k47Pc0/tP8ISFUa1uYD37LfXUm0lAHraEsz
         nSxT1fquMlt2acEj+WvhU5TPB3oz4SQVoMo8S0R/0mTypmo0XaNqc0dr7zdzCJ0ok02t
         gk5P6pOFaBQV3a1jikQC41lHN8SIvMixKmMj0PHylH1jLvr0Lwc1DeH3tmjhD33H5CtR
         Q2XuRmaxQnVjmABQu30lnGywmU6nf4fH81li7W09OXMIwXd2yArwP3Fwu1fS1/RDcUpv
         edHK+9UiAkFwqM9aN+bD7RdUQ9WRJNMiWtgeH+d36DkOfwKoUkSvfX4NmXL7eSWFBzhK
         CENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568355; x=1717173155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rowFNmK/eeWfKpXfDGUas/+gao88imRRDFo7GrdeK1c=;
        b=ma+YeVQ35d+e7o+RExIyUhfXCkdZ+vX2tCa1NLX3FepNGjoU+5rHQZoHTf5HGBUj3O
         y3/FCYzzBPj9NJvsuA77juzbUA1tvpdL5BC6qifECiHc8IlqdGA8HHzpcuq4d9p0OgLH
         /ZItAay+sHaEHuYSoVOx7f8P2REz+rlnqa2NbevKE72jSleWw4IXnAjQwHGaqvZi0Eik
         m2AMtoGGTTUD/svAtGX21z5tpXsldKS7q2Fz21MYLmWXow11sIs1MHMDK51YnbLMZc2L
         Rar6Pw/NKX8AX14oU8PIMh+BtfCGRqKTQ9poJhYW7ELsej/bnfm9eltdj9JvWKkQe0LD
         6m2A==
X-Forwarded-Encrypted: i=1; AJvYcCXn3mdjynZH4nePMJ4O7TNv1O4GyVIA5NGXvVGAGXaZCDIgn5JleB/3f5MlUfs/h7rbOcPihPCr6POou9MhisUICUbaU7PbAas2elYX
X-Gm-Message-State: AOJu0YygDS+j3BYOXd8507DNjeLTsCI9+VF8soWVvfhGjFhNECvSEujj
	hhGkMIY1f4mquC1a7dXtLdrB7WHuQc3Xh8xIUjCWjaS8Cv0OXUDbMSKomc1yHoy5nXG2u5KjBBR
	u/ajxuJTePUsQCe4j9wqhV4zJe4+u361bUqqUdg==
X-Google-Smtp-Source: AGHT+IFo7/oh9jt5q+vzlbZbJlHYc/mC+NYZPrSi07kUzdRicKexqi9GP/G5ozxQ6lKJdhzJHPWPesa2FMaWqmR4QWA=
X-Received: by 2002:ac2:5b12:0:b0:523:df53:93c2 with SMTP id
 2adb3069b0e04-529666d81a6mr1879288e87.51.1716568354843; Fri, 24 May 2024
 09:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715708679.git.tjeznach@rivosinc.com> <4a1ac62b8b452f9face321c29502dee8ee88191c.1715708679.git.tjeznach@rivosinc.com>
 <CANXhq0os1R3kR7dCKWs1Yu1ZeaKoQ2b3Q7QbvyU9nRgbB8ZFmA@mail.gmail.com>
 <CAH2o1u4j9MS9Pq7d=4skq-nLM7c_x0Dwqy8WxVfO1FBSWqA0yg@mail.gmail.com>
 <CAK9=C2Wff07Q72LXrB9POz=91t4SNZ8AaLhQdjjjXhbqTYKCHA@mail.gmail.com>
 <CAH2o1u5N9ZdXePh=aJHkYOpLMXeuwQTzCuQJyLdgc3-FAKim2A@mail.gmail.com>
 <CAK9=C2VAWa4jzCW63q366rB60wk2KDUJmF86EtQkVcMYLyiPBg@mail.gmail.com> <CAH2o1u4jbObtXDAiXkedy_7P6VyRVTFj9OtmqwjgGYYfys1RmA@mail.gmail.com>
In-Reply-To: <CAH2o1u4jbObtXDAiXkedy_7P6VyRVTFj9OtmqwjgGYYfys1RmA@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 24 May 2024 22:02:23 +0530
Message-ID: <CAK9=C2W4D7+zGZerH_VV2ARYOx2MzPmFRCEX7NZ2RdqwwUpr8g@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] iommu/riscv: Add RISC-V IOMMU platform device driver
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Zong Li <zong.li@sifive.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
	Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 9:43=E2=80=AFPM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> On Fri, May 17, 2024 at 8:51=E2=80=AFPM Anup Patel <apatel@ventanamicro.c=
om> wrote:
> >
> > On Sat, May 18, 2024 at 1:11=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosi=
nc.com> wrote:
> > >
> > > On Fri, May 17, 2024 at 9:28=E2=80=AFAM Anup Patel <apatel@ventanamic=
ro.com> wrote:
> > > >
> > > > Hi Tomasz,
> > > >
> > > > On Fri, May 17, 2024 at 9:16=E2=80=AFPM Tomasz Jeznach <tjeznach@ri=
vosinc.com> wrote:
> > > > >
> > > > > On Fri, May 17, 2024 at 12:22=E2=80=AFAM Zong Li <zong.li@sifive.=
com> wrote:
> > > > > >
> > > > > > On Wed, May 15, 2024 at 2:17=E2=80=AFAM Tomasz Jeznach <tjeznac=
h@rivosinc.com> wrote:
> > > > > > >
> > > > > > > Introduce platform device driver for implementation of RISC-V=
 IOMMU
> > > > > > > architected hardware.
> > > > > > >
> > > > > > > Hardware interface definition located in file iommu-bits.h is=
 based on
> > > > > > > ratified RISC-V IOMMU Architecture Specification version 1.0.=
0.
> > > > > > >
> > > > > > > This patch implements platform device initialization, early c=
heck and
> > > > > > > configuration of the IOMMU interfaces and enables global pass=
-through
> > > > > > > address translation mode (iommu_mode =3D=3D BARE), without re=
gistering
> > > > > > > hardware instance in the IOMMU subsystem.
> > > > > > >
> > > > > > > Link: https://github.com/riscv-non-isa/riscv-iommu
> > > > > > > Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> > > > > > > Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> > > > > > > Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> > > > > > > Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> > > > > > > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > > > > > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > > > > > > ---
> > > > > > >  MAINTAINERS                          |   1 +
> > > > > > >  drivers/iommu/Kconfig                |   1 +
> > > > > > >  drivers/iommu/Makefile               |   2 +-
> > > > > > >  drivers/iommu/riscv/Kconfig          |  15 +
> > > > > > >  drivers/iommu/riscv/Makefile         |   2 +
> > > > > > >  drivers/iommu/riscv/iommu-bits.h     | 707 +++++++++++++++++=
++++++++++
> > > > > > >  drivers/iommu/riscv/iommu-platform.c |  92 ++++
> > > > > > >  drivers/iommu/riscv/iommu.c          |  99 ++++
> > > > > > >  drivers/iommu/riscv/iommu.h          |  62 +++
> > > > > > >  9 files changed, 980 insertions(+), 1 deletion(-)
> > > > > > >  create mode 100644 drivers/iommu/riscv/Kconfig
> > > > > > >  create mode 100644 drivers/iommu/riscv/Makefile
> > > > > > >  create mode 100644 drivers/iommu/riscv/iommu-bits.h
> > > > > > >  create mode 100644 drivers/iommu/riscv/iommu-platform.c
> > > > > > >  create mode 100644 drivers/iommu/riscv/iommu.c
> > > > > > >  create mode 100644 drivers/iommu/riscv/iommu.h
> > > > > > >
> > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > index 7e090f878dc7..c0ef07031d01 100644
> > > > > > > --- a/MAINTAINERS
> > > > > > > +++ b/MAINTAINERS
> > > > > > > @@ -18963,6 +18963,7 @@ L:      iommu@lists.linux.dev
> > > > > > >  L:     linux-riscv@lists.infradead.org
> > > > > > >  S:     Maintained
> > > > > > >  F:     Documentation/devicetree/bindings/iommu/riscv,iommu.y=
aml
> > > > > > > +F:     drivers/iommu/riscv/
> > > > > > >
> > > > > > >  RISC-V MICROCHIP FPGA SUPPORT
> > > > > > >  M:     Conor Dooley <conor.dooley@microchip.com>
> > > > > > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > > > > > index c04584be3089..9359f07fe671 100644
> > > > > > > --- a/drivers/iommu/Kconfig
> > > > > > > +++ b/drivers/iommu/Kconfig
> > > > > > > @@ -195,6 +195,7 @@ config MSM_IOMMU
> > > > > > >  source "drivers/iommu/amd/Kconfig"
> > > > > > >  source "drivers/iommu/intel/Kconfig"
> > > > > > >  source "drivers/iommu/iommufd/Kconfig"
> > > > > > > +source "drivers/iommu/riscv/Kconfig"
> > > > > > >
> > > > > > >  config IRQ_REMAP
> > > > > > >         bool "Support for Interrupt Remapping"
> > > > > > > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > > > > > > index 542760d963ec..5e5a83c6c2aa 100644
> > > > > > > --- a/drivers/iommu/Makefile
> > > > > > > +++ b/drivers/iommu/Makefile
> > > > > > > @@ -1,5 +1,5 @@
> > > > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > > > > -obj-y +=3D amd/ intel/ arm/ iommufd/
> > > > > > > +obj-y +=3D amd/ intel/ arm/ iommufd/ riscv/
> > > > > > >  obj-$(CONFIG_IOMMU_API) +=3D iommu.o
> > > > > > >  obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
> > > > > > >  obj-$(CONFIG_IOMMU_API) +=3D iommu-sysfs.o
> > > > > > > diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/risc=
v/Kconfig
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..5dcc5c45aa50
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/iommu/riscv/Kconfig
> > > > > > > @@ -0,0 +1,15 @@
> > > > > > > +# SPDX-License-Identifier: GPL-2.0-only
> > > > > > > +# RISC-V IOMMU support
> > > > > > > +
> > > > > > > +config RISCV_IOMMU
> > > > > > > +       bool "RISC-V IOMMU Support"
> > > > > > > +       depends on RISCV && 64BIT
> > > > > > > +       default y
> > > > > > > +       select IOMMU_API
> > > > > >
> > > > > > Hi Tomasz,
> > > > > > Could I know do we need to add RISCV dependency on CONFIG_IOMMU=
_DMA
> > > > > > due to the patch 'de9f8a91eb32 ("iommu/dma: Clean up Kconfig")'=
?
> > > > > >
> > > > >
> > > > > Hi Zong,
> > > > >
> > > > > Correct, This series will be followed with actual enablement of t=
he
> > > > > iommu/riscv driver with the change to add IOMMU_DMA for RISCV arc=
h,
> > > > > here is the change:
> > > >
> > > > I understand that this series is intended to be minimal but I sugge=
st
> > > > expanding this series a bit more such that at least a basic EDU dev=
ice
> > > > works along with MSIs from EDU device. This will give us a more
> > > > usable IOMMU driver sooner and also allow people to do more
> > > > testing.
> > > >
> > > > Subsequent series can add more features (such as IOMMU_DMA,
> > > > HPM, etc) incrementally.
> > > >
> > >
> > > Hi Anup,
> > >
> > > This series introduces a fundamental and practical IOMMU/RISC-V
> > > driver. It is fully testable on simulated, emulated, or real hardware
> > > implementations of the RISC-V architecture. Users can enable
> > > additional kernel configuration options, such as VFIO and IOMMU_DMA,
> > > to facilitate testing.
> >
> > In terms of features, what is fundamental and practical IOMMU
> > driver to you might not be for others.
> >
> > >
> > > The activation of IOMMU_DMA for the RISC-V architecture will be
> > > feasible once the core components achieve compatibility with the DMA
> > > subsystem, which unfortunately is currently not the case. Without
> > > IOMMU_DMA enabled, driver will recognize RISC-V IOMMU hardware,
> > > register itself in the IOMMU core subsystem, and will provide basic
> > > IDENTITY protection domains for connected devices.
> >
> > I am not asking for IOMMU_DMA feature instead I am asking for
> > supporting device MSIs in this series.
> >
>
> Ok. Makes sense.
> I've looked at the option to pull in / add small change to enable MSI
> bypass window for systems with IMSIC enabled. With that, MSIs will be
> supported, however without full interrupt remapping capabilities that
> could IOMMU provide. If that sounds as sufficient change I'll add it
> to this series.

Jason wants to keep this separate so I suggest sending out your
subsequent series based upon this series sooner.

>
> > >
> > > For those interested in testing this series (based on v6.9), with MSI
> > > support (riscv_aia_v17), I have provided a ready to use branch [1]
> > > with necessary fixes/workarounds included for convenience.
> > >
> > > [1] link: https://github.com/tjeznach/linux/tree/riscv_iommu_v5_aia_1=
7
> >
> > Up-streaming the patches is much more useful compared to
> > sharing patches in private branches.
> >
> > It seems you already have subsequent patches so why not just
> > submit another series which depends on this series ?
> >
> > It is very easy to pull patches from mailing list using b4. Waiting
> > for this series to be merged before sending another series will
> > only delay having a usable driver in upstream. People send-out
> > multiple interdependent series all the time. Usually, it takes time
> > to review patches so it is generally better to have patches on the
> > list as soon as possible. This also allows others to test and
> > propose or send fixes on top.
> >
>
> Understood.  Next set of features, re-based on this series will go out
> shortly, as the initial set of iommu/riscv changes seams to be in
> stable shape IMHO.

Thanks, that will be very helpful.

Regards,
Anup

>
>
> > Regards,
> > Anup
> >
>
> Best,
> - Tomasz
>
> > >
> > > Best regards,
> > > - Tomasz
> > >
> > >
> > > > Regards,
> > > > Anup
> > > >
> > > > >
> > > > > --- a/drivers/iommu/Kconfig
> > > > > +++ b/drivers/iommu/Kconfig
> > > > > @@ -150,7 +150,7 @@ config OF_IOMMU
> > > > >
> > > > >  # IOMMU-agnostic DMA-mapping layer
> > > > >  config IOMMU_DMA
> > > > > -       def_bool ARM64 || X86 || S390
> > > > > +       def_bool ARM64 || X86 || S390 || RISCV
> > > > >         select DMA_OPS
> > > > >         select IOMMU_API
> > > > >         select IOMMU_IOVA
> > > > >
> > > > > Best regards,
> > > > > - Tomasz
> > > > >
> > > > > > > +       help
> > > > > > > +         Support for implementations of the RISC-V IOMMU arc=
hitecture that
> > > > > > > +         complements the RISC-V MMU capabilities, providing =
similar address
> > > > > > > +         translation and protection functions for accesses f=
rom I/O devices.
> > > > > > > +
> > > > > > > +         Say Y here if your SoC includes an IOMMU device imp=
lementing
> > > > > > > +         the RISC-V IOMMU architecture.
> > > > > > > diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/ris=
cv/Makefile
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..e4c189de58d3
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/iommu/riscv/Makefile
> > > > > > > @@ -0,0 +1,2 @@
> > > > > > > +# SPDX-License-Identifier: GPL-2.0-only
> > > > > > > +obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-platform.o
> > > > > > > diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu=
/riscv/iommu-bits.h
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..48f795a0cd10
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/iommu/riscv/iommu-bits.h
> > > > > > > @@ -0,0 +1,707 @@
> > > > > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > > > > +/*
> > > > > > > + * Copyright =C2=A9 2022-2024 Rivos Inc.
> > > > > > > + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> > > > > > > + * Copyright =C2=A9 2023 RISC-V IOMMU Task Group
> > > > > > > + *
> > > > > > > + * RISC-V IOMMU - Register Layout and Data Structures.
> > > > > > > + *
> > > > > > > + * Based on the 'RISC-V IOMMU Architecture Specification', V=
ersion 1.0
> > > > > > > + * Published at  https://github.com/riscv-non-isa/riscv-iomm=
u
> > > > > > > + *
> > > > > > > + */
> > > > > > > +
> > > > > > > +#ifndef _RISCV_IOMMU_BITS_H_
> > > > > > > +#define _RISCV_IOMMU_BITS_H_
> > > > > > > +
> > > > > > > +#include <linux/types.h>
> > > > > > > +#include <linux/bitfield.h>
> > > > > > > +#include <linux/bits.h>
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Chapter 5: Memory Mapped register interface
> > > > > > > + */
> > > > > > > +
> > > > > > > +/* Common field positions */
> > > > > > > +#define RISCV_IOMMU_PPN_FIELD          GENMASK_ULL(53, 10)
> > > > > > > +#define RISCV_IOMMU_QUEUE_LOGSZ_FIELD  GENMASK_ULL(4, 0)
> > > > > > > +#define RISCV_IOMMU_QUEUE_INDEX_FIELD  GENMASK_ULL(31, 0)
> > > > > > > +#define RISCV_IOMMU_QUEUE_ENABLE       BIT(0)
> > > > > > > +#define RISCV_IOMMU_QUEUE_INTR_ENABLE  BIT(1)
> > > > > > > +#define RISCV_IOMMU_QUEUE_MEM_FAULT    BIT(8)
> > > > > > > +#define RISCV_IOMMU_QUEUE_OVERFLOW     BIT(9)
> > > > > > > +#define RISCV_IOMMU_QUEUE_ACTIVE       BIT(16)
> > > > > > > +#define RISCV_IOMMU_QUEUE_BUSY         BIT(17)
> > > > > > > +
> > > > > > > +#define RISCV_IOMMU_ATP_PPN_FIELD      GENMASK_ULL(43, 0)
> > > > > > > +#define RISCV_IOMMU_ATP_MODE_FIELD     GENMASK_ULL(63, 60)
> > > > > > > +
> > > > > > > +/* 5.3 IOMMU Capabilities (64bits) */
> > > > > > > +#define RISCV_IOMMU_REG_CAP            0x0000
> > > > > > > +#define RISCV_IOMMU_CAP_VERSION                GENMASK_ULL(7=
, 0)
> > > > > > > +#define RISCV_IOMMU_CAP_S_SV32         BIT_ULL(8)
> > > > > > > +#define RISCV_IOMMU_CAP_S_SV39         BIT_ULL(9)
> > > > > > > +#define RISCV_IOMMU_CAP_S_SV48         BIT_ULL(10)
> > > > > > > +#define RISCV_IOMMU_CAP_S_SV57         BIT_ULL(11)
> > > > > > > +#define RISCV_IOMMU_CAP_SVPBMT         BIT_ULL(15)
> > > > > > > +#define RISCV_IOMMU_CAP_G_SV32         BIT_ULL(16)
> > > > > > > +#define RISCV_IOMMU_CAP_G_SV39         BIT_ULL(17)
> > > > > > > +#define RISCV_IOMMU_CAP_G_SV48         BIT_ULL(18)
> > > > > > > +#define RISCV_IOMMU_CAP_G_SV57         BIT_ULL(19)
> > > > > > > +#define RISCV_IOMMU_CAP_AMO_MRIF       BIT_ULL(21)
> > > > > > > +#define RISCV_IOMMU_CAP_MSI_FLAT       BIT_ULL(22)
> > > > > > > +#define RISCV_IOMMU_CAP_MSI_MRIF       BIT_ULL(23)
> > > > > > > +#define RISCV_IOMMU_CAP_AMO_HWAD       BIT_ULL(24)
> > > > > > > +#define RISCV_IOMMU_CAP_ATS            BIT_ULL(25)
> > > > > > > +#define RISCV_IOMMU_CAP_T2GPA          BIT_ULL(26)
> > > > > > > +#define RISCV_IOMMU_CAP_END            BIT_ULL(27)
> > > > > > > +#define RISCV_IOMMU_CAP_IGS            GENMASK_ULL(29, 28)
> > > > > > > +#define RISCV_IOMMU_CAP_HPM            BIT_ULL(30)
> > > > > > > +#define RISCV_IOMMU_CAP_DBG            BIT_ULL(31)
> > > > > > > +#define RISCV_IOMMU_CAP_PAS            GENMASK_ULL(37, 32)
> > > > > > > +#define RISCV_IOMMU_CAP_PD8            BIT_ULL(38)
> > > > > > > +#define RISCV_IOMMU_CAP_PD17           BIT_ULL(39)
> > > > > > > +#define RISCV_IOMMU_CAP_PD20           BIT_ULL(40)
> > > > > > > +
> > > > > > > +#define RISCV_IOMMU_CAP_VERSION_VER_MASK       0xF0
> > > > > > > +#define RISCV_IOMMU_CAP_VERSION_REV_MASK       0x0F
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * enum riscv_iommu_igs_settings - Interrupt Generation Supp=
ort Settings
> > > > > > > + * @RISCV_IOMMU_CAP_IGS_MSI: I/O MMU supports only MSI gener=
ation
> > > > > > > + * @RISCV_IOMMU_CAP_IGS_WSI: I/O MMU supports only Wired-Sig=
naled interrupt
> > > > > > > + * @RISCV_IOMMU_CAP_IGS_BOTH: I/O MMU supports both MSI and =
WSI generation
> > > > > > > + * @RISCV_IOMMU_CAP_IGS_RSRV: Reserved for standard use
> > > > > > > + */
> > > > > > > +enum riscv_iommu_igs_settings {
> > > > > > > +       RISCV_IOMMU_CAP_IGS_MSI =3D 0,
> > > > > > > +       RISCV_IOMMU_CAP_IGS_WSI =3D 1,
> > > > > > > +       RISCV_IOMMU_CAP_IGS_BOTH =3D 2,
> > > > > > > +       RISCV_IOMMU_CAP_IGS_RSRV =3D 3
> > > > > > > +};
> > > > > > > +
> > > > > > > +/* 5.4 Features control register (32bits) */
> > > > > > > +#define RISCV_IOMMU_REG_FCTL           0x0008
> > > > > > > +#define RISCV_IOMMU_FCTL_BE            BIT(0)
> > > > > > > +#define RISCV_IOMMU_FCTL_WSI           BIT(1)
> > > > > > > +#define RISCV_IOMMU_FCTL_GXL           BIT(2)
> > > > > > > +
> > > > > > > +/* 5.5 Device-directory-table pointer (64bits) */
> > > > > > > +#define RISCV_IOMMU_REG_DDTP           0x0010
> > > > > > > +#define RISCV_IOMMU_DDTP_MODE          GENMASK_ULL(3, 0)
> > > > > > > +#define RISCV_IOMMU_DDTP_BUSY          BIT_ULL(4)
> > > > > > > +#define RISCV_IOMMU_DDTP_PPN           RISCV_IOMMU_PPN_FIELD
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * enum riscv_iommu_ddtp_modes - I/O MMU translation modes
> > > > > > > + * @RISCV_IOMMU_DDTP_MODE_OFF: No inbound transactions allow=
ed
> > > > > > > + * @RISCV_IOMMU_DDTP_MODE_BARE: Pass-through mode
> > > > > > > + * @RISCV_IOMMU_DDTP_MODE_1LVL: One-level DDT
> > > > > > > + * @RISCV_IOMMU_DDTP_MODE_2LVL: Two-level DDT
> > > > > > > + * @RISCV_IOMMU_DDTP_MODE_3LVL: Three-level DDT
> > > > > > > + * @RISCV_IOMMU_DDTP_MODE_MAX: Max value allowed by specific=
ation
> > > > > > > + */
> > > > > > > +enum riscv_iommu_ddtp_modes {
> > > > > > > +       RISCV_IOMMU_DDTP_MODE_OFF =3D 0,
> > > > > > > +       RISCV_IOMMU_DDTP_MODE_BARE =3D 1,
> > > > > > > +       RISCV_IOMMU_DDTP_MODE_1LVL =3D 2,
> > > > > > > +       RISCV_IOMMU_DDTP_MODE_2LVL =3D 3,
> > > > > > > +       RISCV_IOMMU_DDTP_MODE_3LVL =3D 4,
> > > > > > > +       RISCV_IOMMU_DDTP_MODE_MAX =3D 4
> > > > > > > +};
> > > > > > > +
> > > > > > > +/* 5.6 Command Queue Base (64bits) */
> > > > > > > +#define RISCV_IOMMU_REG_CQB            0x0018
> > > > > > > +#define RISCV_IOMMU_CQB_ENTRIES                RISCV_IOMMU_Q=
UEUE_LOGSZ_FIELD
> > > > > > > +#define RISCV_IOMMU_CQB_PPN            RISCV_IOMMU_PPN_FIELD
> > > > > > > +
> > > > > > > +/* 5.7 Command Queue head (32bits) */
> > > > > > > +#define RISCV_IOMMU_REG_CQH            0x0020
> > > > > > > +#define RISCV_IOMMU_CQH_INDEX          RISCV_IOMMU_QUEUE_IND=
EX_FIELD
> > > > > > > +
> > > > > > > +/* 5.8 Command Queue tail (32bits) */
> > > > > > > +#define RISCV_IOMMU_REG_CQT            0x0024
> > > > > > > +#define RISCV_IOMMU_CQT_INDEX          RISCV_IOMMU_QUEUE_IND=
EX_FIELD
> > > > > > > +
> > > > > > > +/* 5.9 Fault Queue Base (64bits) */
> > > > > > > +#define RISCV_IOMMU_REG_FQB            0x0028
> > > > > > > +#define RISCV_IOMMU_FQB_ENTRIES                RISCV_IOMMU_Q=
UEUE_LOGSZ_FIELD
> > > > > > > +#define RISCV_IOMMU_FQB_PPN            RISCV_IOMMU_PPN_FIELD
> > > > > > > +
> > > > > > > +/* 5.10 Fault Queue Head (32bits) */
> > > > > > > +#define RISCV_IOMMU_REG_FQH            0x0030
> > > > > > > +#define RISCV_IOMMU_FQH_INDEX          RISCV_IOMMU_QUEUE_IND=
EX_FIELD
> > > > > > > +
> > > > > > > +/* 5.11 Fault Queue tail (32bits) */
> > > > > > > +#define RISCV_IOMMU_REG_FQT            0x0034
> > > > > > > +#define RISCV_IOMMU_FQT_INDEX          RISCV_IOMMU_QUEUE_IND=
EX_FIELD
> > > > > > > +
> > > > > > > +/* 5.12 Page Request Queue base (64bits) */
> > > > > > > +#define RISCV_IOMMU_REG_PQB            0x0038
> > > > > > > +#define RISCV_IOMMU_PQB_ENTRIES                RISCV_IOMMU_Q=
UEUE_LOGSZ_FIELD
> > > > > > > +#define RISCV_IOMMU_PQB_PPN            RISCV_IOMMU_PPN_FIELD
> > > > > > > +
> > > > > > > +/* 5.13 Page Request Queue head (32bits) */
> > > > > > > +#define RISCV_IOMMU_REG_PQH            0x0040
> > > > > > > +#define RISCV_IOMMU_PQH_INDEX          RISCV_IOMMU_QUEUE_IND=
EX_FIELD
> > > > > > > +
> > > > > > > +/* 5.14 Page Request Queue tail (32bits) */
> > > > > > > +#define RISCV_IOMMU_REG_PQT            0x0044
> > > > > > > +#define RISCV_IOMMU_PQT_INDEX_MASK     RISCV_IOMMU_QUEUE_IND=
EX_FIELD
> > > > > > > +
> > > > > > > +/* 5.15 Command Queue CSR (32bits) */
> > > > > > > +#define RISCV_IOMMU_REG_CQCSR          0x0048
> > > > > > > +#define RISCV_IOMMU_CQCSR_CQEN         RISCV_IOMMU_QUEUE_ENA=
BLE
> > > > > > > +#define RISCV_IOMMU_CQCSR_CIE          RISCV_IOMMU_QUEUE_INT=
R_ENABLE
> > > > > > > +#define RISCV_IOMMU_CQCSR_CQMF         RISCV_IOMMU_QUEUE_MEM=
_FAULT
> > > > > > > +#define RISCV_IOMMU_CQCSR_CMD_TO       BIT(9)
> > > > > > > +#define RISCV_IOMMU_CQCSR_CMD_ILL      BIT(10)
> > > > > > > +#define RISCV_IOMMU_CQCSR_FENCE_W_IP   BIT(11)
> > > > > > > +#define RISCV_IOMMU_CQCSR_CQON         RISCV_IOMMU_QUEUE_ACT=
IVE
> > > > > > > +#define RISCV_IOMMU_CQCSR_BUSY         RISCV_IOMMU_QUEUE_BUS=
Y
> > > > > > > +
> > > > > > > +/* 5.16 Fault Queue CSR (32bits) */
> > > > > > > +#define RISCV_IOMMU_REG_FQCSR          0x004C
> > > > > > > +#define RISCV_IOMMU_FQCSR_FQEN         RISCV_IOMMU_QUEUE_ENA=
BLE
> > > > > > > +#define RISCV_IOMMU_FQCSR_FIE          RISCV_IOMMU_QUEUE_INT=
R_ENABLE
> > > > > > > +#define RISCV_IOMMU_FQCSR_FQMF         RISCV_IOMMU_QUEUE_MEM=
_FAULT
> > > > > > > +#define RISCV_IOMMU_FQCSR_FQOF         RISCV_IOMMU_QUEUE_OVE=
RFLOW
> > > > > > > +#define RISCV_IOMMU_FQCSR_FQON         RISCV_IOMMU_QUEUE_ACT=
IVE
> > > > > > > +#define RISCV_IOMMU_FQCSR_BUSY         RISCV_IOMMU_QUEUE_BUS=
Y
> > > > > > > +
> > > > > > > +/* 5.17 Page Request Queue CSR (32bits) */
> > > > > > > +#define RISCV_IOMMU_REG_PQCSR          0x0050
> > > > > > > +#define RISCV_IOMMU_PQCSR_PQEN         RISCV_IOMMU_QUEUE_ENA=
BLE
> > > > > > > +#define RISCV_IOMMU_PQCSR_PIE          RISCV_IOMMU_QUEUE_INT=
R_ENABLE
> > > > > > > +#define RISCV_IOMMU_PQCSR_PQMF         RISCV_IOMMU_QUEUE_MEM=
_FAULT
> > > > > > > +#define RISCV_IOMMU_PQCSR_PQOF         RISCV_IOMMU_QUEUE_OVE=
RFLOW
> > > > > > > +#define RISCV_IOMMU_PQCSR_PQON         RISCV_IOMMU_QUEUE_ACT=
IVE
> > > > > > > +#define RISCV_IOMMU_PQCSR_BUSY         RISCV_IOMMU_QUEUE_BUS=
Y
> > > > > > > +
> > > > > > > +/* 5.18 Interrupt Pending Status (32bits) */
> > > > > > > +#define RISCV_IOMMU_REG_IPSR           0x0054
> > > > > > > +
> > > > > > > +#define RISCV_IOMMU_INTR_CQ            0
> > > > > > > +#define RISCV_IOMMU_INTR_FQ            1
> > > > > > > +#define RISCV_IOMMU_INTR_PM            2
> > > > > > > +#define RISCV_IOMMU_INTR_PQ            3
> > > > > > > +#define RISCV_IOMMU_INTR_COUNT         4
> > > > > > > +
> > > > > > > +#define RISCV_IOMMU_IPSR_CIP           BIT(RISCV_IOMMU_INTR_=
CQ)
> > > > > > > +#define RISCV_IOMMU_IPSR_FIP           BIT(RISCV_IOMMU_INTR_=
FQ)
> > > > > > > +#define RISCV_IOMMU_IPSR_PMIP          BIT(RISCV_IOMMU_INTR_=
PM)
> > > > > > > +#define RISCV_IOMMU_IPSR_PIP           BIT(RISCV_IOMMU_INTR_=
PQ)
> > > > > > > +
> > > > > > > +/* 5.19 Performance monitoring counter overflow status (32bi=
ts) */
> > > > > > > +#define RISCV_IOMMU_REG_IOCOUNTOVF     0x0058
> > > > > > > +#define RISCV_IOMMU_IOCOUNTOVF_CY      BIT(0)
> > > > > > > +#define RISCV_IOMMU_IOCOUNTOVF_HPM     GENMASK_ULL(31, 1)
> > > > > > > +
> > > > > > > +/* 5.20 Performance monitoring counter inhibits (32bits) */
> > > > > > > +#define RISCV_IOMMU_REG_IOCOUNTINH     0x005C
> > > > > > > +#define RISCV_IOMMU_IOCOUNTINH_CY      BIT(0)
> > > > > > > +#define RISCV_IOMMU_IOCOUNTINH_HPM     GENMASK(31, 1)
> > > > > > > +
> > > > > > > +/* 5.21 Performance monitoring cycles counter (64bits) */
> > > > > > > +#define RISCV_IOMMU_REG_IOHPMCYCLES     0x0060
> > > > > > > +#define RISCV_IOMMU_IOHPMCYCLES_COUNTER        GENMASK_ULL(6=
2, 0)
> > > > > > > +#define RISCV_IOMMU_IOHPMCYCLES_OVF    BIT_ULL(63)
> > > > > > > +
> > > > > > > +/* 5.22 Performance monitoring event counters (31 * 64bits) =
*/
> > > > > > > +#define RISCV_IOMMU_REG_IOHPMCTR_BASE  0x0068
> > > > > > > +#define RISCV_IOMMU_REG_IOHPMCTR(_n)   (RISCV_IOMMU_REG_IOHP=
MCTR_BASE + ((_n) * 0x8))
> > > > > > > +
> > > > > > > +/* 5.23 Performance monitoring event selectors (31 * 64bits)=
 */
> > > > > > > +#define RISCV_IOMMU_REG_IOHPMEVT_BASE  0x0160
> > > > > > > +#define RISCV_IOMMU_REG_IOHPMEVT(_n)   (RISCV_IOMMU_REG_IOHP=
MEVT_BASE + ((_n) * 0x8))
> > > > > > > +#define RISCV_IOMMU_IOHPMEVT_CNT       31
> > > > > > > +#define RISCV_IOMMU_IOHPMEVT_EVENT_ID  GENMASK_ULL(14, 0)
> > > > > > > +#define RISCV_IOMMU_IOHPMEVT_DMASK     BIT_ULL(15)
> > > > > > > +#define RISCV_IOMMU_IOHPMEVT_PID_PSCID GENMASK_ULL(35, 16)
> > > > > > > +#define RISCV_IOMMU_IOHPMEVT_DID_GSCID GENMASK_ULL(59, 36)
> > > > > > > +#define RISCV_IOMMU_IOHPMEVT_PV_PSCV   BIT_ULL(60)
> > > > > > > +#define RISCV_IOMMU_IOHPMEVT_DV_GSCV   BIT_ULL(61)
> > > > > > > +#define RISCV_IOMMU_IOHPMEVT_IDT       BIT_ULL(62)
> > > > > > > +#define RISCV_IOMMU_IOHPMEVT_OF                BIT_ULL(63)
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * enum riscv_iommu_hpmevent_id - Performance-monitoring eve=
nt identifier
> > > > > > > + *
> > > > > > > + * @RISCV_IOMMU_HPMEVENT_INVALID: Invalid event, do not coun=
t
> > > > > > > + * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
> > > > > > > + * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
> > > > > > > + * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
> > > > > > > + * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
> > > > > > > + * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
> > > > > > > + * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
> > > > > > > + * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: S/VS-Stage page table w=
alks
> > > > > > > + * @RISCV_IOMMU_HPMEVENT_G_WALKS: G-Stage page table walks
> > > > > > > + * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event =
IDs
> > > > > > > + */
> > > > > > > +enum riscv_iommu_hpmevent_id {
> > > > > > > +       RISCV_IOMMU_HPMEVENT_INVALID    =3D 0,
> > > > > > > +       RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> > > > > > > +       RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> > > > > > > +       RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> > > > > > > +       RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> > > > > > > +       RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> > > > > > > +       RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> > > > > > > +       RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> > > > > > > +       RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> > > > > > > +       RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> > > > > > > +};
> > > > > > > +
> > > > > > > +/* 5.24 Translation request IOVA (64bits) */
> > > > > > > +#define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
> > > > > > > +#define RISCV_IOMMU_TR_REQ_IOVA_VPN    GENMASK_ULL(63, 12)
> > > > > > > +
> > > > > > > +/* 5.25 Translation request control (64bits) */
> > > > > > > +#define RISCV_IOMMU_REG_TR_REQ_CTL     0x0260
> > > > > > > +#define RISCV_IOMMU_TR_REQ_CTL_GO_BUSY BIT_ULL(0)
> > > > > > > +#define RISCV_IOMMU_TR_REQ_CTL_PRIV    BIT_ULL(1)
> > > > > > > +#define RISCV_IOMMU_TR_REQ_CTL_EXE     BIT_ULL(2)
> > > > > > > +#define RISCV_IOMMU_TR_REQ_CTL_NW      BIT_ULL(3)
> > > > > > > +#define RISCV_IOMMU_TR_REQ_CTL_PID     GENMASK_ULL(31, 12)
> > > > > > > +#define RISCV_IOMMU_TR_REQ_CTL_PV      BIT_ULL(32)
> > > > > > > +#define RISCV_IOMMU_TR_REQ_CTL_DID     GENMASK_ULL(63, 40)
> > > > > > > +
> > > > > > > +/* 5.26 Translation request response (64bits) */
> > > > > > > +#define RISCV_IOMMU_REG_TR_RESPONSE    0x0268
> > > > > > > +#define RISCV_IOMMU_TR_RESPONSE_FAULT  BIT_ULL(0)
> > > > > > > +#define RISCV_IOMMU_TR_RESPONSE_PBMT   GENMASK_ULL(8, 7)
> > > > > > > +#define RISCV_IOMMU_TR_RESPONSE_SZ     BIT_ULL(9)
> > > > > > > +#define RISCV_IOMMU_TR_RESPONSE_PPN    RISCV_IOMMU_PPN_FIELD
> > > > > > > +
> > > > > > > +/* 5.27 Interrupt cause to vector (64bits) */
> > > > > > > +#define RISCV_IOMMU_REG_ICVEC          0x02F8
> > > > > > > +#define RISCV_IOMMU_ICVEC_CIV          GENMASK_ULL(3, 0)
> > > > > > > +#define RISCV_IOMMU_ICVEC_FIV          GENMASK_ULL(7, 4)
> > > > > > > +#define RISCV_IOMMU_ICVEC_PMIV         GENMASK_ULL(11, 8)
> > > > > > > +#define RISCV_IOMMU_ICVEC_PIV          GENMASK_ULL(15, 12)
> > > > > > > +
> > > > > > > +/* 5.28 MSI Configuration table (32 * 64bits) */
> > > > > > > +#define RISCV_IOMMU_REG_MSI_CONFIG     0x0300
> > > > > > > +#define RISCV_IOMMU_REG_MSI_ADDR(_n)   (RISCV_IOMMU_REG_MSI_=
CONFIG + ((_n) * 0x10))
> > > > > > > +#define RISCV_IOMMU_MSI_ADDR           GENMASK_ULL(55, 2)
> > > > > > > +#define RISCV_IOMMU_REG_MSI_DATA(_n)   (RISCV_IOMMU_REG_MSI_=
CONFIG + ((_n) * 0x10) + 0x08)
> > > > > > > +#define RISCV_IOMMU_MSI_DATA           GENMASK_ULL(31, 0)
> > > > > > > +#define RISCV_IOMMU_REG_MSI_VEC_CTL(_n)        (RISCV_IOMMU_=
REG_MSI_CONFIG + ((_n) * 0x10) + 0x0C)
> > > > > > > +#define RISCV_IOMMU_MSI_VEC_CTL_M      BIT_ULL(0)
> > > > > > > +
> > > > > > > +#define RISCV_IOMMU_REG_SIZE   0x1000
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Chapter 2: Data structures
> > > > > > > + */
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Device Directory Table macros for non-leaf nodes
> > > > > > > + */
> > > > > > > +#define RISCV_IOMMU_DDTE_VALID BIT_ULL(0)
> > > > > > > +#define RISCV_IOMMU_DDTE_PPN   RISCV_IOMMU_PPN_FIELD
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * struct riscv_iommu_dc - Device Context
> > > > > > > + * @tc: Translation Control
> > > > > > > + * @iohgatp: I/O Hypervisor guest address translation and pr=
otection
> > > > > > > + *          (Second stage context)
> > > > > > > + * @ta: Translation Attributes
> > > > > > > + * @fsc: First stage context
> > > > > > > + * @msiptp: MSI page table pointer
> > > > > > > + * @msi_addr_mask: MSI address mask
> > > > > > > + * @msi_addr_pattern: MSI address pattern
> > > > > > > + * @_reserved: Reserved for future use, padding
> > > > > > > + *
> > > > > > > + * This structure is used for leaf nodes on the Device Direc=
tory Table,
> > > > > > > + * in case RISCV_IOMMU_CAP_MSI_FLAT is not set, the bottom 4=
 fields are
> > > > > > > + * not present and are skipped with pointer arithmetic to av=
oid
> > > > > > > + * casting, check out riscv_iommu_get_dc().
> > > > > > > + * See section 2.1 for more details
> > > > > > > + */
> > > > > > > +struct riscv_iommu_dc {
> > > > > > > +       u64 tc;
> > > > > > > +       u64 iohgatp;
> > > > > > > +       u64 ta;
> > > > > > > +       u64 fsc;
> > > > > > > +       u64 msiptp;
> > > > > > > +       u64 msi_addr_mask;
> > > > > > > +       u64 msi_addr_pattern;
> > > > > > > +       u64 _reserved;
> > > > > > > +};
> > > > > > > +
> > > > > > > +/* Translation control fields */
> > > > > > > +#define RISCV_IOMMU_DC_TC_V            BIT_ULL(0)
> > > > > > > +#define RISCV_IOMMU_DC_TC_EN_ATS       BIT_ULL(1)
> > > > > > > +#define RISCV_IOMMU_DC_TC_EN_PRI       BIT_ULL(2)
> > > > > > > +#define RISCV_IOMMU_DC_TC_T2GPA                BIT_ULL(3)
> > > > > > > +#define RISCV_IOMMU_DC_TC_DTF          BIT_ULL(4)
> > > > > > > +#define RISCV_IOMMU_DC_TC_PDTV         BIT_ULL(5)
> > > > > > > +#define RISCV_IOMMU_DC_TC_PRPR         BIT_ULL(6)
> > > > > > > +#define RISCV_IOMMU_DC_TC_GADE         BIT_ULL(7)
> > > > > > > +#define RISCV_IOMMU_DC_TC_SADE         BIT_ULL(8)
> > > > > > > +#define RISCV_IOMMU_DC_TC_DPE          BIT_ULL(9)
> > > > > > > +#define RISCV_IOMMU_DC_TC_SBE          BIT_ULL(10)
> > > > > > > +#define RISCV_IOMMU_DC_TC_SXL          BIT_ULL(11)
> > > > > > > +
> > > > > > > +/* Second-stage (aka G-stage) context fields */
> > > > > > > +#define RISCV_IOMMU_DC_IOHGATP_PPN     RISCV_IOMMU_ATP_PPN_F=
IELD
> > > > > > > +#define RISCV_IOMMU_DC_IOHGATP_GSCID   GENMASK_ULL(59, 44)
> > > > > > > +#define RISCV_IOMMU_DC_IOHGATP_MODE    RISCV_IOMMU_ATP_MODE_=
FIELD
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * enum riscv_iommu_dc_iohgatp_modes - Guest address transla=
tion/protection modes
> > > > > > > + * @RISCV_IOMMU_DC_IOHGATP_MODE_BARE: No translation/protect=
ion
> > > > > > > + * @RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4: Sv32x4 (2-bit extens=
ion of Sv32), when fctl.GXL =3D=3D 1
> > > > > > > + * @RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4: Sv39x4 (2-bit extens=
ion of Sv39), when fctl.GXL =3D=3D 0
> > > > > > > + * @RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4: Sv48x4 (2-bit extens=
ion of Sv48), when fctl.GXL =3D=3D 0
> > > > > > > + * @RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4: Sv57x4 (2-bit extens=
ion of Sv57), when fctl.GXL =3D=3D 0
> > > > > > > + */
> > > > > > > +enum riscv_iommu_dc_iohgatp_modes {
> > > > > > > +       RISCV_IOMMU_DC_IOHGATP_MODE_BARE =3D 0,
> > > > > > > +       RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4 =3D 8,
> > > > > > > +       RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4 =3D 8,
> > > > > > > +       RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4 =3D 9,
> > > > > > > +       RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4 =3D 10
> > > > > > > +};
> > > > > > > +
> > > > > > > +/* Translation attributes fields */
> > > > > > > +#define RISCV_IOMMU_DC_TA_PSCID                GENMASK_ULL(3=
1, 12)
> > > > > > > +
> > > > > > > +/* First-stage context fields */
> > > > > > > +#define RISCV_IOMMU_DC_FSC_PPN         RISCV_IOMMU_ATP_PPN_F=
IELD
> > > > > > > +#define RISCV_IOMMU_DC_FSC_MODE                RISCV_IOMMU_A=
TP_MODE_FIELD
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * enum riscv_iommu_dc_fsc_atp_modes - First stage address t=
ranslation/protection modes
> > > > > > > + * @RISCV_IOMMU_DC_FSC_MODE_BARE: No translation/protection
> > > > > > > + * @RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32: Sv32, when dc.tc.SX=
L =3D=3D 1
> > > > > > > + * @RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39: Sv39, when dc.tc.SX=
L =3D=3D 0
> > > > > > > + * @RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48: Sv48, when dc.tc.SX=
L =3D=3D 0
> > > > > > > + * @RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57: Sv57, when dc.tc.SX=
L =3D=3D 0
> > > > > > > + * @RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8: 1lvl PDT, 8bit process=
 ids
> > > > > > > + * @RISCV_IOMMU_DC_FSC_PDTP_MODE_PD17: 2lvl PDT, 17bit proce=
ss ids
> > > > > > > + * @RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20: 3lvl PDT, 20bit proce=
ss ids
> > > > > > > + *
> > > > > > > + * FSC holds IOSATP when RISCV_IOMMU_DC_TC_PDTV is 0 and PDT=
P otherwise.
> > > > > > > + * IOSATP controls the first stage address translation (same=
 as the satp register on
> > > > > > > + * the RISC-V MMU), and PDTP holds the process directory tab=
le, used to select a
> > > > > > > + * first stage page table based on a process id (for devices=
 that support multiple
> > > > > > > + * process ids).
> > > > > > > + */
> > > > > > > +enum riscv_iommu_dc_fsc_atp_modes {
> > > > > > > +       RISCV_IOMMU_DC_FSC_MODE_BARE =3D 0,
> > > > > > > +       RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 =3D 8,
> > > > > > > +       RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 =3D 8,
> > > > > > > +       RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48 =3D 9,
> > > > > > > +       RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57 =3D 10,
> > > > > > > +       RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8 =3D 1,
> > > > > > > +       RISCV_IOMMU_DC_FSC_PDTP_MODE_PD17 =3D 2,
> > > > > > > +       RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20 =3D 3
> > > > > > > +};
> > > > > > > +
> > > > > > > +/* MSI page table pointer */
> > > > > > > +#define RISCV_IOMMU_DC_MSIPTP_PPN      RISCV_IOMMU_ATP_PPN_F=
IELD
> > > > > > > +#define RISCV_IOMMU_DC_MSIPTP_MODE     RISCV_IOMMU_ATP_MODE_=
FIELD
> > > > > > > +#define RISCV_IOMMU_DC_MSIPTP_MODE_OFF 0
> > > > > > > +#define RISCV_IOMMU_DC_MSIPTP_MODE_FLAT        1
> > > > > > > +
> > > > > > > +/* MSI address mask */
> > > > > > > +#define RISCV_IOMMU_DC_MSI_ADDR_MASK   GENMASK_ULL(51, 0)
> > > > > > > +
> > > > > > > +/* MSI address pattern */
> > > > > > > +#define RISCV_IOMMU_DC_MSI_PATTERN     GENMASK_ULL(51, 0)
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * struct riscv_iommu_pc - Process Context
> > > > > > > + * @ta: Translation Attributes
> > > > > > > + * @fsc: First stage context
> > > > > > > + *
> > > > > > > + * This structure is used for leaf nodes on the Process Dire=
ctory Table
> > > > > > > + * See section 2.3 for more details
> > > > > > > + */
> > > > > > > +struct riscv_iommu_pc {
> > > > > > > +       u64 ta;
> > > > > > > +       u64 fsc;
> > > > > > > +};
> > > > > > > +
> > > > > > > +/* Translation attributes fields */
> > > > > > > +#define RISCV_IOMMU_PC_TA_V    BIT_ULL(0)
> > > > > > > +#define RISCV_IOMMU_PC_TA_ENS  BIT_ULL(1)
> > > > > > > +#define RISCV_IOMMU_PC_TA_SUM  BIT_ULL(2)
> > > > > > > +#define RISCV_IOMMU_PC_TA_PSCID        GENMASK_ULL(31, 12)
> > > > > > > +
> > > > > > > +/* First stage context fields */
> > > > > > > +#define RISCV_IOMMU_PC_FSC_PPN RISCV_IOMMU_ATP_PPN_FIELD
> > > > > > > +#define RISCV_IOMMU_PC_FSC_MODE        RISCV_IOMMU_ATP_MODE_=
FIELD
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Chapter 3: In-memory queue interface
> > > > > > > + */
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * struct riscv_iommu_command - Generic I/O MMU command stru=
cture
> > > > > > > + * @dword0: Includes the opcode and the function identifier
> > > > > > > + * @dword1: Opcode specific data
> > > > > > > + *
> > > > > > > + * The commands are interpreted as two 64bit fields, where t=
he first
> > > > > > > + * 7bits of the first field are the opcode which also define=
s the
> > > > > > > + * command's format, followed by a 3bit field that specifies=
 the
> > > > > > > + * function invoked by that command, and the rest is opcode-=
specific.
> > > > > > > + * This is a generic struct which will be populated differen=
tly
> > > > > > > + * according to each command. For more infos on the commands=
 and
> > > > > > > + * the command queue check section 3.1.
> > > > > > > + */
> > > > > > > +struct riscv_iommu_command {
> > > > > > > +       u64 dword0;
> > > > > > > +       u64 dword1;
> > > > > > > +};
> > > > > > > +
> > > > > > > +/* Fields on dword0, common for all commands */
> > > > > > > +#define RISCV_IOMMU_CMD_OPCODE GENMASK_ULL(6, 0)
> > > > > > > +#define        RISCV_IOMMU_CMD_FUNC    GENMASK_ULL(9, 7)
> > > > > > > +
> > > > > > > +/* 3.1.1 I/O MMU Page-table cache invalidation */
> > > > > > > +/* Fields on dword0 */
> > > > > > > +#define RISCV_IOMMU_CMD_IOTINVAL_OPCODE                1
> > > > > > > +#define RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA      0
> > > > > > > +#define RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA     1
> > > > > > > +#define RISCV_IOMMU_CMD_IOTINVAL_AV            BIT_ULL(10)
> > > > > > > +#define RISCV_IOMMU_CMD_IOTINVAL_PSCID         GENMASK_ULL(3=
1, 12)
> > > > > > > +#define RISCV_IOMMU_CMD_IOTINVAL_PSCV          BIT_ULL(32)
> > > > > > > +#define RISCV_IOMMU_CMD_IOTINVAL_GV            BIT_ULL(33)
> > > > > > > +#define RISCV_IOMMU_CMD_IOTINVAL_GSCID         GENMASK_ULL(5=
9, 44)
> > > > > > > +/* dword1[61:10] is the 4K-aligned page address */
> > > > > > > +#define RISCV_IOMMU_CMD_IOTINVAL_ADDR          GENMASK_ULL(6=
1, 10)
> > > > > > > +
> > > > > > > +/* 3.1.2 I/O MMU Command Queue Fences */
> > > > > > > +/* Fields on dword0 */
> > > > > > > +#define RISCV_IOMMU_CMD_IOFENCE_OPCODE         2
> > > > > > > +#define RISCV_IOMMU_CMD_IOFENCE_FUNC_C         0
> > > > > > > +#define RISCV_IOMMU_CMD_IOFENCE_AV             BIT_ULL(10)
> > > > > > > +#define RISCV_IOMMU_CMD_IOFENCE_WSI            BIT_ULL(11)
> > > > > > > +#define RISCV_IOMMU_CMD_IOFENCE_PR             BIT_ULL(12)
> > > > > > > +#define RISCV_IOMMU_CMD_IOFENCE_PW             BIT_ULL(13)
> > > > > > > +#define RISCV_IOMMU_CMD_IOFENCE_DATA           GENMASK_ULL(6=
3, 32)
> > > > > > > +/* dword1 is the address, word-size aligned and shifted to t=
he right by two bits. */
> > > > > > > +
> > > > > > > +/* 3.1.3 I/O MMU Directory cache invalidation */
> > > > > > > +/* Fields on dword0 */
> > > > > > > +#define RISCV_IOMMU_CMD_IODIR_OPCODE           3
> > > > > > > +#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT   0
> > > > > > > +#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT   1
> > > > > > > +#define RISCV_IOMMU_CMD_IODIR_PID              GENMASK_ULL(3=
1, 12)
> > > > > > > +#define RISCV_IOMMU_CMD_IODIR_DV               BIT_ULL(33)
> > > > > > > +#define RISCV_IOMMU_CMD_IODIR_DID              GENMASK_ULL(6=
3, 40)
> > > > > > > +/* dword1 is reserved for standard use */
> > > > > > > +
> > > > > > > +/* 3.1.4 I/O MMU PCIe ATS */
> > > > > > > +/* Fields on dword0 */
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_OPCODE             4
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_FUNC_INVAL         0
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_FUNC_PRGR          1
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_PID                        GENMA=
SK_ULL(31, 12)
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_PV                 BIT_ULL(32)
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_DSV                        BIT_U=
LL(33)
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_RID                        GENMA=
SK_ULL(55, 40)
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_DSEG               GENMASK_ULL(6=
3, 56)
> > > > > > > +/* dword1 is the ATS payload, two different payload types fo=
r INVAL and PRGR */
> > > > > > > +
> > > > > > > +/* ATS.INVAL payload*/
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_INVAL_G            BIT_ULL(0)
> > > > > > > +/* Bits 1 - 10 are zeroed */
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_INVAL_S            BIT_ULL(11)
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_INVAL_UADDR                GENMA=
SK_ULL(63, 12)
> > > > > > > +
> > > > > > > +/* ATS.PRGR payload */
> > > > > > > +/* Bits 0 - 31 are zeroed */
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_PRGR_PRG_INDEX     GENMASK_ULL(4=
0, 32)
> > > > > > > +/* Bits 41 - 43 are zeroed */
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE     GENMASK_ULL(4=
7, 44)
> > > > > > > +#define RISCV_IOMMU_CMD_ATS_PRGR_DST_ID                GENMA=
SK_ULL(63, 48)
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * struct riscv_iommu_fq_record - Fault/Event Queue Record
> > > > > > > + * @hdr: Header, includes fault/event cause, PID/DID, transa=
ction type etc
> > > > > > > + * @_reserved: Low 32bits for custom use, high 32bits for st=
andard use
> > > > > > > + * @iotval: Transaction-type/cause specific format
> > > > > > > + * @iotval2: Cause specific format
> > > > > > > + *
> > > > > > > + * The fault/event queue reports events and failures raised =
when
> > > > > > > + * processing transactions. Each record is a 32byte structur=
e where
> > > > > > > + * the first dword has a fixed format for providing generic =
infos
> > > > > > > + * regarding the fault/event, and two more dwords are there =
for
> > > > > > > + * fault/event-specific information. For more details see se=
ction
> > > > > > > + * 3.2.
> > > > > > > + */
> > > > > > > +struct riscv_iommu_fq_record {
> > > > > > > +       u64 hdr;
> > > > > > > +       u64 _reserved;
> > > > > > > +       u64 iotval;
> > > > > > > +       u64 iotval2;
> > > > > > > +};
> > > > > > > +
> > > > > > > +/* Fields on header */
> > > > > > > +#define RISCV_IOMMU_FQ_HDR_CAUSE       GENMASK_ULL(11, 0)
> > > > > > > +#define RISCV_IOMMU_FQ_HDR_PID         GENMASK_ULL(31, 12)
> > > > > > > +#define RISCV_IOMMU_FQ_HDR_PV          BIT_ULL(32)
> > > > > > > +#define RISCV_IOMMU_FQ_HDR_PRIV                BIT_ULL(33)
> > > > > > > +#define RISCV_IOMMU_FQ_HDR_TTYPE       GENMASK_ULL(39, 34)
> > > > > > > +#define RISCV_IOMMU_FQ_HDR_DID         GENMASK_ULL(63, 40)
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * enum riscv_iommu_fq_causes - Fault/event cause values
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_INST_FAULT: Instruction access faul=
t
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_RD_ADDR_MISALIGNED: Read address mi=
saligned
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_RD_FAULT: Read load fault
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_WR_ADDR_MISALIGNED: Write/AMO addre=
ss misaligned
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_WR_FAULT: Write/AMO access fault
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_INST_FAULT_S: Instruction page faul=
t
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S: Read page fault
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S: Write/AMO page fault
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_INST_FAULT_VS: Instruction guest pa=
ge fault
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS: Read guest page fault
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS: Write/AMO guest page f=
ault
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED: All inbound transacti=
ons disallowed
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT: DDT entry load acce=
ss fault
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_DDT_INVALID: DDT entry invalid
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED: DDT entry miscon=
figured
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED: Transaction type dis=
allowed
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT: MSI PTE load access=
 fault
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_MSI_INVALID: MSI PTE invalid
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED: MSI PTE misconfi=
gured
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_MRIF_FAULT: MRIF access fault
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT: PDT entry load acce=
ss fault
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_PDT_INVALID: PDT entry invalid
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED: PDT entry miscon=
figured
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_DDT_CORRUPTED: DDT data corruption
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_PDT_CORRUPTED: PDT data corruption
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED: MSI page table da=
ta corruption
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_MRIF_CORRUIPTED: MRIF data corrupti=
on
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_INTERNAL_DP_ERROR: Internal data pa=
th error
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT: IOMMU MSI write acces=
s fault
> > > > > > > + * @RISCV_IOMMU_FQ_CAUSE_PT_CORRUPTED: First/second stage pa=
ge table data corruption
> > > > > > > + *
> > > > > > > + * Values are on table 11 of the spec, encodings 275 - 2047 =
are reserved for standard
> > > > > > > + * use, and 2048 - 4095 for custom use.
> > > > > > > + */
> > > > > > > +enum riscv_iommu_fq_causes {
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_INST_FAULT =3D 1,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_RD_ADDR_MISALIGNED =3D 4,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_RD_FAULT =3D 5,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_WR_ADDR_MISALIGNED =3D 6,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_WR_FAULT =3D 7,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_INST_FAULT_S =3D 12,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S =3D 13,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S =3D 15,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_INST_FAULT_VS =3D 20,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS =3D 21,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS =3D 23,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED =3D 256,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT =3D 257,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_DDT_INVALID =3D 258,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED =3D 259,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED =3D 260,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT =3D 261,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_MSI_INVALID =3D 262,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED =3D 263,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_MRIF_FAULT =3D 264,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT =3D 265,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_PDT_INVALID =3D 266,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED =3D 267,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_DDT_CORRUPTED =3D 268,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_PDT_CORRUPTED =3D 269,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED =3D 270,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_MRIF_CORRUIPTED =3D 271,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_INTERNAL_DP_ERROR =3D 272,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT =3D 273,
> > > > > > > +       RISCV_IOMMU_FQ_CAUSE_PT_CORRUPTED =3D 274
> > > > > > > +};
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * enum riscv_iommu_fq_ttypes: Fault/event transaction types
> > > > > > > + * @RISCV_IOMMU_FQ_TTYPE_NONE: None. Fault not caused by an =
inbound transaction.
> > > > > > > + * @RISCV_IOMMU_FQ_TTYPE_UADDR_INST_FETCH: Instruction fetch=
 from untranslated address
> > > > > > > + * @RISCV_IOMMU_FQ_TTYPE_UADDR_RD: Read from untranslated ad=
dress
> > > > > > > + * @RISCV_IOMMU_FQ_TTYPE_UADDR_WR: Write/AMO to untranslated=
 address
> > > > > > > + * @RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH: Instruction fetch=
 from translated address
> > > > > > > + * @RISCV_IOMMU_FQ_TTYPE_TADDR_RD: Read from translated addr=
ess
> > > > > > > + * @RISCV_IOMMU_FQ_TTYPE_TADDR_WR: Write/AMO to translated a=
ddress
> > > > > > > + * @RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ: PCIe ATS translation =
request
> > > > > > > + * @RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ: PCIe message request
> > > > > > > + *
> > > > > > > + * Values are on table 12 of the spec, type 4 and 10 - 31 ar=
e reserved for standard use
> > > > > > > + * and 31 - 63 for custom use.
> > > > > > > + */
> > > > > > > +enum riscv_iommu_fq_ttypes {
> > > > > > > +       RISCV_IOMMU_FQ_TTYPE_NONE =3D 0,
> > > > > > > +       RISCV_IOMMU_FQ_TTYPE_UADDR_INST_FETCH =3D 1,
> > > > > > > +       RISCV_IOMMU_FQ_TTYPE_UADDR_RD =3D 2,
> > > > > > > +       RISCV_IOMMU_FQ_TTYPE_UADDR_WR =3D 3,
> > > > > > > +       RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH =3D 5,
> > > > > > > +       RISCV_IOMMU_FQ_TTYPE_TADDR_RD =3D 6,
> > > > > > > +       RISCV_IOMMU_FQ_TTYPE_TADDR_WR =3D 7,
> > > > > > > +       RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ =3D 8,
> > > > > > > +       RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ =3D 9,
> > > > > > > +};
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * struct riscv_iommu_pq_record - PCIe Page Request record
> > > > > > > + * @hdr: Header, includes PID, DID etc
> > > > > > > + * @payload: Holds the page address, request group and permi=
ssion bits
> > > > > > > + *
> > > > > > > + * For more infos on the PCIe Page Request queue see chapter=
 3.3.
> > > > > > > + */
> > > > > > > +struct riscv_iommu_pq_record {
> > > > > > > +       u64 hdr;
> > > > > > > +       u64 payload;
> > > > > > > +};
> > > > > > > +
> > > > > > > +/* Header fields */
> > > > > > > +#define RISCV_IOMMU_PREQ_HDR_PID       GENMASK_ULL(31, 12)
> > > > > > > +#define RISCV_IOMMU_PREQ_HDR_PV                BIT_ULL(32)
> > > > > > > +#define RISCV_IOMMU_PREQ_HDR_PRIV      BIT_ULL(33)
> > > > > > > +#define RISCV_IOMMU_PREQ_HDR_EXEC      BIT_ULL(34)
> > > > > > > +#define RISCV_IOMMU_PREQ_HDR_DID       GENMASK_ULL(63, 40)
> > > > > > > +
> > > > > > > +/* Payload fields */
> > > > > > > +#define RISCV_IOMMU_PREQ_PAYLOAD_R     BIT_ULL(0)
> > > > > > > +#define RISCV_IOMMU_PREQ_PAYLOAD_W     BIT_ULL(1)
> > > > > > > +#define RISCV_IOMMU_PREQ_PAYLOAD_L     BIT_ULL(2)
> > > > > > > +#define RISCV_IOMMU_PREQ_PAYLOAD_M     GENMASK_ULL(2, 0)    =
   /* Mask of RWL for convenience */
> > > > > > > +#define RISCV_IOMMU_PREQ_PRG_INDEX     GENMASK_ULL(11, 3)
> > > > > > > +#define RISCV_IOMMU_PREQ_UADDR         GENMASK_ULL(63, 12)
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * struct riscv_iommu_msi_pte - MSI Page Table Entry
> > > > > > > + * @pte: MSI PTE
> > > > > > > + * @mrif_info: Memory-resident interrupt file info
> > > > > > > + *
> > > > > > > + * The MSI Page Table is used for virtualizing MSIs, so that=
 when
> > > > > > > + * a device sends an MSI to a guest, the IOMMU can reroute i=
t
> > > > > > > + * by translating the MSI address, either to a guest interru=
pt file
> > > > > > > + * or a memory resident interrupt file (MRIF). Note that thi=
s page table
> > > > > > > + * is an array of MSI PTEs, not a multi-level pt, each entry
> > > > > > > + * is a leaf entry. For more infos check out the AIA spec, c=
hapter 9.5.
> > > > > > > + *
> > > > > > > + * Also in basic mode the mrif_info field is ignored by the =
IOMMU and can
> > > > > > > + * be used by software, any other reserved fields on pte mus=
t be zeroed-out
> > > > > > > + * by software.
> > > > > > > + */
> > > > > > > +struct riscv_iommu_msi_pte {
> > > > > > > +       u64 pte;
> > > > > > > +       u64 mrif_info;
> > > > > > > +};
> > > > > > > +
> > > > > > > +/* Fields on pte */
> > > > > > > +#define RISCV_IOMMU_MSI_PTE_V          BIT_ULL(0)
> > > > > > > +#define RISCV_IOMMU_MSI_PTE_M          GENMASK_ULL(2, 1)
> > > > > > > +#define RISCV_IOMMU_MSI_PTE_MRIF_ADDR  GENMASK_ULL(53, 7)   =
   /* When M =3D=3D 1 (MRIF mode) */
> > > > > > > +#define RISCV_IOMMU_MSI_PTE_PPN                RISCV_IOMMU_P=
PN_FIELD   /* When M =3D=3D 3 (basic mode) */
> > > > > > > +#define RISCV_IOMMU_MSI_PTE_C          BIT_ULL(63)
> > > > > > > +
> > > > > > > +/* Fields on mrif_info */
> > > > > > > +#define RISCV_IOMMU_MSI_MRIF_NID       GENMASK_ULL(9, 0)
> > > > > > > +#define RISCV_IOMMU_MSI_MRIF_NPPN      RISCV_IOMMU_PPN_FIELD
> > > > > > > +#define RISCV_IOMMU_MSI_MRIF_NID_MSB   BIT_ULL(60)
> > > > > > > +
> > > > > > > +#endif /* _RISCV_IOMMU_BITS_H_ */
> > > > > > > diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/i=
ommu/riscv/iommu-platform.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..1b453334fbbe
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/iommu/riscv/iommu-platform.c
> > > > > > > @@ -0,0 +1,92 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > > +/*
> > > > > > > + * RISC-V IOMMU as a platform device
> > > > > > > + *
> > > > > > > + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> > > > > > > + * Copyright =C2=A9 2023-2024 Rivos Inc.
> > > > > > > + *
> > > > > > > + * Authors
> > > > > > > + *     Nick Kossifidis <mick@ics.forth.gr>
> > > > > > > + *     Tomasz Jeznach <tjeznach@rivosinc.com>
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include <linux/kernel.h>
> > > > > > > +#include <linux/of_platform.h>
> > > > > > > +#include <linux/platform_device.h>
> > > > > > > +
> > > > > > > +#include "iommu-bits.h"
> > > > > > > +#include "iommu.h"
> > > > > > > +
> > > > > > > +static int riscv_iommu_platform_probe(struct platform_device=
 *pdev)
> > > > > > > +{
> > > > > > > +       struct device *dev =3D &pdev->dev;
> > > > > > > +       struct riscv_iommu_device *iommu =3D NULL;
> > > > > > > +       struct resource *res =3D NULL;
> > > > > > > +       int vec;
> > > > > > > +
> > > > > > > +       iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNE=
L);
> > > > > > > +       if (!iommu)
> > > > > > > +               return -ENOMEM;
> > > > > > > +
> > > > > > > +       iommu->dev =3D dev;
> > > > > > > +       iommu->reg =3D devm_platform_get_and_ioremap_resource=
(pdev, 0, &res);
> > > > > > > +       if (IS_ERR(iommu->reg))
> > > > > > > +               return dev_err_probe(dev, PTR_ERR(iommu->reg)=
,
> > > > > > > +                                    "could not map register =
region\n");
> > > > > > > +
> > > > > > > +       dev_set_drvdata(dev, iommu);
> > > > > > > +
> > > > > > > +       /* Check device reported capabilities / features. */
> > > > > > > +       iommu->caps =3D riscv_iommu_readq(iommu, RISCV_IOMMU_=
REG_CAP);
> > > > > > > +       iommu->fctl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_=
REG_FCTL);
> > > > > > > +
> > > > > > > +       /* For now we only support WSI */
> > > > > > > +       switch (FIELD_GET(RISCV_IOMMU_CAP_IGS, iommu->caps)) =
{
> > > > > > > +       case RISCV_IOMMU_CAP_IGS_WSI:
> > > > > > > +       case RISCV_IOMMU_CAP_IGS_BOTH:
> > > > > > > +               break;
> > > > > > > +       default:
> > > > > > > +               return dev_err_probe(dev, -ENODEV,
> > > > > > > +                                    "unable to use wire-sign=
aled interrupts\n");
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       iommu->irqs_count =3D platform_irq_count(pdev);
> > > > > > > +       if (iommu->irqs_count <=3D 0)
> > > > > > > +               return dev_err_probe(dev, -ENODEV,
> > > > > > > +                                    "no IRQ resources provid=
ed\n");
> > > > > > > +       if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
> > > > > > > +               iommu->irqs_count =3D RISCV_IOMMU_INTR_COUNT;
> > > > > > > +
> > > > > > > +       for (vec =3D 0; vec < iommu->irqs_count; vec++)
> > > > > > > +               iommu->irqs[vec] =3D platform_get_irq(pdev, v=
ec);
> > > > > > > +
> > > > > > > +       /* Enable wire-signaled interrupts, fctl.WSI */
> > > > > > > +       if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
> > > > > > > +               iommu->fctl |=3D RISCV_IOMMU_FCTL_WSI;
> > > > > > > +               riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCT=
L, iommu->fctl);
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       return riscv_iommu_init(iommu);
> > > > > > > +};
> > > > > > > +
> > > > > > > +static void riscv_iommu_platform_remove(struct platform_devi=
ce *pdev)
> > > > > > > +{
> > > > > > > +       riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct of_device_id riscv_iommu_of_match[] =3D =
{
> > > > > > > +       {.compatible =3D "riscv,iommu",},
> > > > > > > +       {},
> > > > > > > +};
> > > > > > > +
> > > > > > > +static struct platform_driver riscv_iommu_platform_driver =
=3D {
> > > > > > > +       .probe =3D riscv_iommu_platform_probe,
> > > > > > > +       .remove_new =3D riscv_iommu_platform_remove,
> > > > > > > +       .driver =3D {
> > > > > > > +               .name =3D "riscv,iommu",
> > > > > > > +               .of_match_table =3D riscv_iommu_of_match,
> > > > > > > +               .suppress_bind_attrs =3D true,
> > > > > > > +       },
> > > > > > > +};
> > > > > > > +
> > > > > > > +builtin_platform_driver(riscv_iommu_platform_driver);
> > > > > > > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/risc=
v/iommu.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..3c5a6b49669d
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/iommu/riscv/iommu.c
> > > > > > > @@ -0,0 +1,99 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > > +/*
> > > > > > > + * IOMMU API for RISC-V IOMMU implementations.
> > > > > > > + *
> > > > > > > + * Copyright =C2=A9 2022-2024 Rivos Inc.
> > > > > > > + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> > > > > > > + *
> > > > > > > + * Authors
> > > > > > > + *     Tomasz Jeznach <tjeznach@rivosinc.com>
> > > > > > > + *     Nick Kossifidis <mick@ics.forth.gr>
> > > > > > > + */
> > > > > > > +
> > > > > > > +#define pr_fmt(fmt) "riscv-iommu: " fmt
> > > > > > > +
> > > > > > > +#include <linux/compiler.h>
> > > > > > > +#include <linux/crash_dump.h>
> > > > > > > +#include <linux/init.h>
> > > > > > > +#include <linux/iommu.h>
> > > > > > > +#include <linux/kernel.h>
> > > > > > > +
> > > > > > > +#include "iommu-bits.h"
> > > > > > > +#include "iommu.h"
> > > > > > > +
> > > > > > > +/* Timeouts in [us] */
> > > > > > > +#define RISCV_IOMMU_DDTP_TIMEOUT       50000
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * This is best effort IOMMU translation shutdown flow.
> > > > > > > + * Disable IOMMU without waiting for hardware response.
> > > > > > > + */
> > > > > > > +static void riscv_iommu_disable(struct riscv_iommu_device *i=
ommu)
> > > > > > > +{
> > > > > > > +       riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP, 0);
> > > > > > > +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_CQCSR, 0);
> > > > > > > +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FQCSR, 0);
> > > > > > > +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_PQCSR, 0);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int riscv_iommu_init_check(struct riscv_iommu_device =
*iommu)
> > > > > > > +{
> > > > > > > +       u64 ddtp;
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * Make sure the IOMMU is switched off or in pass-thr=
ough mode during
> > > > > > > +        * regular boot flow and disable translation when we =
boot into a kexec
> > > > > > > +        * kernel and the previous kernel left them enabled.
> > > > > > > +        */
> > > > > > > +       ddtp =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDT=
P);
> > > > > > > +       if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> > > > > > > +               return -EBUSY;
> > > > > > > +
> > > > > > > +       if (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp) > RISCV_IO=
MMU_DDTP_MODE_BARE) {
> > > > > > > +               if (!is_kdump_kernel())
> > > > > > > +                       return -EBUSY;
> > > > > > > +               riscv_iommu_disable(iommu);
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       /* Configure accesses to in-memory data structures fo=
r CPU-native byte order. */
> > > > > > > +       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) !=3D !!(iommu->=
fctl & RISCV_IOMMU_FCTL_BE)) {
> > > > > > > +               if (!(iommu->caps & RISCV_IOMMU_CAP_END))
> > > > > > > +                       return -EINVAL;
> > > > > > > +               riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCT=
L,
> > > > > > > +                                  iommu->fctl ^ RISCV_IOMMU_=
FCTL_BE);
> > > > > > > +               iommu->fctl =3D riscv_iommu_readl(iommu, RISC=
V_IOMMU_REG_FCTL);
> > > > > > > +               if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) !=3D !!=
(iommu->fctl & RISCV_IOMMU_FCTL_BE))
> > > > > > > +                       return -EINVAL;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +void riscv_iommu_remove(struct riscv_iommu_device *iommu)
> > > > > > > +{
> > > > > > > +       iommu_device_sysfs_remove(&iommu->iommu);
> > > > > > > +}
> > > > > > > +
> > > > > > > +int riscv_iommu_init(struct riscv_iommu_device *iommu)
> > > > > > > +{
> > > > > > > +       int rc;
> > > > > > > +
> > > > > > > +       rc =3D riscv_iommu_init_check(iommu);
> > > > > > > +       if (rc)
> > > > > > > +               return dev_err_probe(iommu->dev, rc, "unexpec=
ted device state\n");
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * Placeholder for a complete IOMMU device initializa=
tion.  For now,
> > > > > > > +        * only bare minimum: enable global identity mapping =
mode and register sysfs.
> > > > > > > +        */
> > > > > > > +       riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP,
> > > > > > > +                          FIELD_PREP(RISCV_IOMMU_DDTP_MODE, =
RISCV_IOMMU_DDTP_MODE_BARE));
> > > > > > > +
> > > > > > > +       rc =3D iommu_device_sysfs_add(&iommu->iommu, NULL, NU=
LL, "riscv-iommu@%s",
> > > > > > > +                                   dev_name(iommu->dev));
> > > > > > > +       if (rc)
> > > > > > > +               return dev_err_probe(iommu->dev, rc,
> > > > > > > +                                    "cannot register sysfs i=
nterface\n");
> > > > > > > +
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/risc=
v/iommu.h
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..700e33dc2446
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/iommu/riscv/iommu.h
> > > > > > > @@ -0,0 +1,62 @@
> > > > > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > > > > +/*
> > > > > > > + * Copyright =C2=A9 2022-2024 Rivos Inc.
> > > > > > > + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> > > > > > > + *
> > > > > > > + * Authors
> > > > > > > + *     Tomasz Jeznach <tjeznach@rivosinc.com>
> > > > > > > + *     Nick Kossifidis <mick@ics.forth.gr>
> > > > > > > + */
> > > > > > > +
> > > > > > > +#ifndef _RISCV_IOMMU_H_
> > > > > > > +#define _RISCV_IOMMU_H_
> > > > > > > +
> > > > > > > +#include <linux/iommu.h>
> > > > > > > +#include <linux/types.h>
> > > > > > > +#include <linux/iopoll.h>
> > > > > > > +
> > > > > > > +#include "iommu-bits.h"
> > > > > > > +
> > > > > > > +struct riscv_iommu_device {
> > > > > > > +       /* iommu core interface */
> > > > > > > +       struct iommu_device iommu;
> > > > > > > +
> > > > > > > +       /* iommu hardware */
> > > > > > > +       struct device *dev;
> > > > > > > +
> > > > > > > +       /* hardware control register space */
> > > > > > > +       void __iomem *reg;
> > > > > > > +
> > > > > > > +       /* supported and enabled hardware capabilities */
> > > > > > > +       u64 caps;
> > > > > > > +       u32 fctl;
> > > > > > > +
> > > > > > > +       /* available interrupt numbers, MSI or WSI */
> > > > > > > +       unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
> > > > > > > +       unsigned int irqs_count;
> > > > > > > +};
> > > > > > > +
> > > > > > > +int riscv_iommu_init(struct riscv_iommu_device *iommu);
> > > > > > > +void riscv_iommu_remove(struct riscv_iommu_device *iommu);
> > > > > > > +
> > > > > > > +#define riscv_iommu_readl(iommu, addr) \
> > > > > > > +       readl_relaxed((iommu)->reg + (addr))
> > > > > > > +
> > > > > > > +#define riscv_iommu_readq(iommu, addr) \
> > > > > > > +       readq_relaxed((iommu)->reg + (addr))
> > > > > > > +
> > > > > > > +#define riscv_iommu_writel(iommu, addr, val) \
> > > > > > > +       writel_relaxed((val), (iommu)->reg + (addr))
> > > > > > > +
> > > > > > > +#define riscv_iommu_writeq(iommu, addr, val) \
> > > > > > > +       writeq_relaxed((val), (iommu)->reg + (addr))
> > > > > > > +
> > > > > > > +#define riscv_iommu_readq_timeout(iommu, addr, val, cond, de=
lay_us, timeout_us) \
> > > > > > > +       readx_poll_timeout(readq_relaxed, (iommu)->reg + (add=
r), val, cond, \
> > > > > > > +                          delay_us, timeout_us)
> > > > > > > +
> > > > > > > +#define riscv_iommu_readl_timeout(iommu, addr, val, cond, de=
lay_us, timeout_us) \
> > > > > > > +       readx_poll_timeout(readl_relaxed, (iommu)->reg + (add=
r), val, cond, \
> > > > > > > +                          delay_us, timeout_us)
> > > > > > > +
> > > > > > > +#endif
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
> > > > > > >
> > > > > > > _______________________________________________
> > > > > > > linux-riscv mailing list
> > > > > > > linux-riscv@lists.infradead.org
> > > > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv

