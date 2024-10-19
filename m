Return-Path: <linux-kernel+bounces-372883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FBB9A4EC3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B922884A6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A4284039;
	Sat, 19 Oct 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWh5D1vc"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D73417BB3F
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729348842; cv=none; b=N174O3FCisHYPrjNEK8iuQg743C+48W1Y3FK6oDj3JauwXcVrbmRX4MFurYPSt1IkFVrcIU2i1uFkP/b3oIdbKX2xgeiE5vP1SXM3RbBYkXQ8AnJpgDJY0L+TqaneAKBqTM7lQbzacAUxO85XvnSBFUwUXJCTE5aBMqVyK+NAFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729348842; c=relaxed/simple;
	bh=vYcLiI3IuK/ccfFwkPpMjzaA+I7DIut0fI5zAhFMpZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LF3FIUYGjekE4HNCEq5IA+MXaBLUMgHbpkpZQctEbZwIWAI8NuFWtGJNdMbMhG6mYeLv9N6qNHlsGBWHejA/uoroHdTsPqrLZ9Sm1Gk5OdrtIPYUdTpLUdwczTuzkmoU1GRvZTGddqRRX+UJAqjFt57SeJmIUmW6FoZ+lM6SBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tWh5D1vc; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e5a5a59094so29958137b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729348839; x=1729953639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAsb3dViYkYUK08mSbBFYucBIF4FBJQvNLZYivX9oYQ=;
        b=tWh5D1vcwYv51Pe4GcctrtaSnhsXBiJeDx7u6Fxxo2v/v3prGPQNMyhdmNvPsREeyY
         IgmxrNlrzH6cQNBHSnayst483JUsiAhLKXG3BpFHXZIh+7J2j9UrOV7ssHUcfvLmFpc9
         GdvEZquxwg0O02c+5HlfRVI2KApS9hQpqpGMJqrjMUToZCYCUTeT+DXMtBIcLXKCByaj
         UOUjSgJEPKSX4K/oPdEijSnvSn6G2geDYnF+k8q77/SMg07AZYOy6PK5e9mQGpxWGVMt
         0tr95A0EACwtnbgtCUJatD9khaoRkTYfejMLod9XU3NjVL9Q0WvyTJ8yZPp9y/6gedpr
         CjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729348839; x=1729953639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAsb3dViYkYUK08mSbBFYucBIF4FBJQvNLZYivX9oYQ=;
        b=gOcABtBO8WLMDLmv6oJ5eZn2VUTt8Zh6wAURUcDTTyFoq8mk2Z6L0xKc8x0lVM0Oxh
         sla/PF+drjJp9bw5GJFq2HjhGVQWSequYB5riMmBJ+78wOMKcj2+SGB1mMpnKMYPMCM6
         03EFqtupZwcQ4BWiB7H4YSs02zW8hdx4h5fQ62ih85Cu2W1qpD+8ykR5DzzX/0YAqJQz
         QTSbs+Pe1NM9r+V9J47YUiDke0EJZcTs2PiShdsZpk3mJslA6vDJS4k/htvOahdIRBBk
         wPN3FsV/CMiDnSzPBHOdFTcq7WEgUtVpdoQe7zT4E0QfovVr1ZOxBkorb6Otcsf7TpJD
         tq6A==
X-Forwarded-Encrypted: i=1; AJvYcCXjhJXrQOFuPRgqVwEdYvfc1Mda61u7ZP/2wZxJRxN7NFqYKeOpohQZlQ1kd5u/PakjEnWNOApYzyCM1P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIalEpEfI/lBDCwsxwFDcAN8+DOMlGRuC5XRru3WoFFsDHS4tf
	j2W56GrmRqMYJDXUlBJcVIwu4fnuLPD6GwFEtCQzMF8WCATU0qpBJKRcIuxGHL8u4lgLt+5yaWt
	d6s44LIaOonbeAfKfqmVCcrnNHECuQLCnvnz8PQ==
X-Google-Smtp-Source: AGHT+IGqPF1hDI6npb1Ra3kQlC30zupo0zxsrPaYhHn5fC8eWJumubYNVNJKJ67xr80YljK2ct42Xs9mw7+sl7ixqIM=
X-Received: by 2002:a05:690c:60c3:b0:6e2:167e:814f with SMTP id
 00721157ae682-6e5bfc0c786mr61479077b3.31.1729348839350; Sat, 19 Oct 2024
 07:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-14-f1f3ca1d88e5@mainlining.org> <pyr3t3kcpjj5zor226fwembjsbpp5zh7mpe2a3bqmwnbqccj7h@a55efscym3s7>
 <46f7b167220a7d54242e9457d00d67e2@mainlining.org> <jj4ky6uuidv3rdjl7q4ehe7cdgcjxtnmtcufmy462gznkjiex2@pptv6aufsudj>
In-Reply-To: <jj4ky6uuidv3rdjl7q4ehe7cdgcjxtnmtcufmy462gznkjiex2@pptv6aufsudj>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 19 Oct 2024 17:40:28 +0300
Message-ID: <CAA8EJprvDhvnphNitJqKkNFB-DbXfd_oGtBmgimjRB5n5VgEQA@mail.gmail.com>
Subject: Re: [PATCH RFC 14/14] arm64: dts: qcom: Add Xiaomi Redmi 5A
To: barnabas.czeman@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 19 Oct 2024 at 17:38, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sat, Oct 19, 2024 at 03:57:54PM +0200, barnabas.czeman@mainlining.org =
wrote:
> > On 2024-10-19 15:48, Dmitry Baryshkov wrote:
> > > On Sat, Oct 19, 2024 at 01:50:51PM +0200, Barnab=C3=A1s Cz=C3=A9m=C3=
=A1n wrote:
> > > > Add initial support for Xiaomi Redmi 5A (riva).
> > > >
> > > > Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@main=
lining.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/Makefile                |   1 +
> > > >  arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts | 295
> > > > +++++++++++++++++++++++
> > > >  2 files changed, 296 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/Makefile
> > > > b/arch/arm64/boot/dts/qcom/Makefile
> > > > index 065bb19481c16db2affd291826d420c83a89c52a..79add0e07d8a5f3362d=
70b0aaaaa9b8c48e31239
> > > > 100644
> > > > --- a/arch/arm64/boot/dts/qcom/Makefile
> > > > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > > > @@ -59,6 +59,7 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D
> > > > msm8916-wingtech-wt86518.dtb
> > > >  dtb-$(CONFIG_ARCH_QCOM)  +=3D msm8916-wingtech-wt86528.dtb
> > > >  dtb-$(CONFIG_ARCH_QCOM)  +=3D msm8916-wingtech-wt88047.dtb
> > > >  dtb-$(CONFIG_ARCH_QCOM)  +=3D msm8916-yiming-uz801v3.dtb
> > > > +dtb-$(CONFIG_ARCH_QCOM)  +=3D msm8917-xiaomi-riva.dtb
> > > >  dtb-$(CONFIG_ARCH_QCOM)  +=3D msm8929-wingtech-wt82918hd.dtb
> > > >  dtb-$(CONFIG_ARCH_QCOM)  +=3D msm8939-huawei-kiwi.dtb
> > > >  dtb-$(CONFIG_ARCH_QCOM)  +=3D msm8939-longcheer-l9100.dtb
> > > > diff --git a/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
> > > > b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..7553f73603fc87797b0=
d424a2af6f2da65c90f5f
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
> > > > @@ -0,0 +1,295 @@
> > > > +// SPDX-License-Identifier: BSD-3-Clause
> > > > +/*
> > > > + * Copyright (c) 2023, Barnabas Czeman
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include <dt-bindings/arm/qcom,ids.h>
> > > > +#include <dt-bindings/gpio/gpio.h>
> > > > +#include <dt-bindings/input/linux-event-codes.h>
> > > > +#include <dt-bindings/leds/common.h>
> > > > +#include "msm8917.dtsi"
> > > > +#include "pm8937.dtsi"
> > > > +
> > > > +/ {
> > > > + model =3D "Xiaomi Redmi 5A (riva)";
> > > > + compatible =3D "xiaomi,riva", "qcom,msm8917";
> > > > + chassis-type =3D "handset";
> > > > +
> > > > + qcom,msm-id =3D <QCOM_ID_MSM8917 0>;
> > > > + qcom,board-id =3D <0x1000b 2>, <0x2000b 2>;
> > >
> > > Is this required to boot?
> > Yes
>
> Hmm, did you verify the dts against DT bindings? I think you need to fix
> them.

Hmm, ignore this. You added qcom,msm8917 to the allow list in the
previous patch. Please expand the commit message there, describing
that you are enabling msm-id / board-id for this SoC, which doesn't
work otherwise.

--=20
With best wishes
Dmitry

