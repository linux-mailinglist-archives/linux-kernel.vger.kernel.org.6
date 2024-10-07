Return-Path: <linux-kernel+bounces-353817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F31B99331C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D21B282EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1C01DA63F;
	Mon,  7 Oct 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wtLm1Dpj"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A4D1DA628
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318315; cv=none; b=XghwVqArhGKlkgLqQiz5H6kbXkZpBDsEq0qp/3VwsiPlEzh3CRRS9DzvzupkguzsPH777P07TUcS++UKG/ys2hjDzvsrbBeCfNlZWRy4GIqWDF/wpGlsJoeQQ4JCwBmrNzyvTHzPtgBiQtNGwBOkrRz/TvMKLYynaSu7tRpj4Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318315; c=relaxed/simple;
	bh=ztgOmLTBp+aKdjTsSSsdeQWqF1Gb2Vp+FAgfWTJeSGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfjJih1EIqsEHzkLkeKhb2ySj/Csf3RADFnHfdzF/JYyfrTcHgbjLt7ilqtD/pah1JK705uDvb2IRwuhXoEqyJ+gz06eWDGiScIfJI2NeExTGNSjdgREfemngYa0FrWZYcjSyCayoFFeN8Dkzu77lbRHGHHth3F9umXodV5SsLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wtLm1Dpj; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e2d2447181so21377127b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 09:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728318313; x=1728923113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ij6m8Bk1SL0pSLcGOK58/xYqt64VC0Wd1t/6D+nVQI=;
        b=wtLm1Dpj1cxn8GMU9X3EJwYjuq7H1tQih1VNG3lMcCEjlXx9/zWOhXlIB3T2pWVm+3
         V0BC5gTxaA2ETbPqVOOUmt09bX7QuUZ3AZUsBLgZxF+OGjBfyXo/L7I4k8kaKcD4xIcM
         1xh8OgYUBRYAokg2up9jCnc+MbcUbfNJjSKiA3YUqiJNLxmk1i7SukJZvnEurBcaMMok
         MGoVZus64m792WiFwuLIGXdroZ3b/R3uT/Y4/uYp+JXfK1aTA1KPLXa5/WJndor0z7ZM
         XG6UlzH4PKDUpYCmvXrNgf7SgztB8bMVc/Ebbh2ME1xGih/f5tLsMAeDgF3eZwinPeVI
         cBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728318313; x=1728923113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ij6m8Bk1SL0pSLcGOK58/xYqt64VC0Wd1t/6D+nVQI=;
        b=N23WNxbOp8FkF+p/LdvrZ+7guif7Kl3jPYU4KuBDvjj+7eQHrTXFe6klMoVAbNqb9T
         hWvX8hpVyDpu8nuxhHjBs/hVwBINoa/JDc0wh+JvhYTUggzW3JzYCfzgegVD4AeKxqQ5
         0UwWXhXGcRldv4x1cBXFigG50s7pmb000eF3pwVtIFzJ6PcuExHqWlKQQjqVGT7Gjy6e
         OfjFfFYTmrdLEIXsDJSApHFCtP39H4FCB9EsviMFsYWf894UKBmmH+T8ZKm19tStvnN6
         KYANPwdGE5gF+He/AZwHXi7kU2Ktt+WkILAqahtvoeI+vX+a8p4R/CoyJM3vMo2UZU7O
         o+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDtxJqdKStfgFp0dvjm3GFoD5UdVJw1bPOptWF8O32Yqoos+4Wtttm3yMqc1+0G/lW0Kieg68POMFm6yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQIKiYS5OFFFsRSKGBApB1go2/up5vSu+Le+iXFKI9wAuXFCf
	Iom+4L+J8IGSlD5AMC1Soz4V1s9hnGkIgPlHYjqhbS7PCIHygBb6wlcF52oDhrp2axCPX8MCcqk
	Wr5qZMUMURPcK4ZNtyIWVAl1MMg9a9Gb7V84NTQ==
X-Google-Smtp-Source: AGHT+IEWXaI5JMnHwVXLtqDixS2grY1KW8zAkygxRWI6l8yi3FXTCl6aQoI8wQY+X5MjkN8m9qEJL4uqytMKz4F9PUI=
X-Received: by 2002:a05:690c:dc3:b0:6e2:1334:a944 with SMTP id
 00721157ae682-6e2c6fc7e3cmr98008117b3.9.1728318312864; Mon, 07 Oct 2024
 09:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004212359.2263502-1-quic_mojha@quicinc.com>
 <20241004212359.2263502-2-quic_mojha@quicinc.com> <pt5x7miszg3vrqjimhdfesxghnpdsu4zzdr37vcmuze7yccmkn@twjeb5cfdqph>
 <ZwP/tA06k6we7uUh@hu-mojha-hyd.qualcomm.com>
In-Reply-To: <ZwP/tA06k6we7uUh@hu-mojha-hyd.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 7 Oct 2024 18:25:01 +0200
Message-ID: <CAA8EJpqay7Nryb5HwwHE1+iiMXKUvqi-djmCsYN8fxigt-s-tQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: remoteproc: qcom,pas-common: Introduce
 iommus and qcom,devmem property
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shiraz Hashim <quic_shashim@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Oct 2024 at 17:35, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
> On Sun, Oct 06, 2024 at 10:38:01PM +0300, Dmitry Baryshkov wrote:
> > On Sat, Oct 05, 2024 at 02:53:54AM GMT, Mukesh Ojha wrote:
> > > From: Shiraz Hashim <quic_shashim@quicinc.com>
> > >
> > > Qualcomm=E2=80=99s PAS implementation for remote processors only supp=
orts a
> > > single stage of IOMMU translation and is presently managed by the
> > > Qualcomm EL2 hypervisor (QHEE) if it is present. In the absence of QH=
EE,
> > > such as with a KVM hypervisor, IOMMU translations need to be set up b=
y
> > > the KVM host. Remoteproc needs carveout memory region and its resourc=
e
> > > (device memory) permissions to be set before it comes up, and this
> > > information is presently available statically with QHEE.
> > >
> > > In the absence of QHEE, the boot firmware needs to overlay this
> > > information based on SoCs running with either QHEE or a KVM hyperviso=
r
> > > (CPUs booted in EL2).
> > >
> > > The qcom,devmem property provides IOMMU devmem translation informatio=
n
> > > intended for non-QHEE based systems.
> > >
> > > Signed-off-by: Shiraz Hashim <quic_shashim@quicinc.com>
> > > Co-Developed-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > ---
> > >  .../bindings/remoteproc/qcom,pas-common.yaml  | 42 +++++++++++++++++=
++
> > >  .../bindings/remoteproc/qcom,sa8775p-pas.yaml | 20 +++++++++
> > >  2 files changed, 62 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-co=
mmon.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.ya=
ml
> > > index 63a82e7a8bf8..068e177ad934 100644
> > > --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.ya=
ml
> > > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.ya=
ml
> > > @@ -52,6 +52,48 @@ properties:
> > >      minItems: 1
> > >      maxItems: 3
> > >
> > > +  iommus:
> > > +    maxItems: 1
> > > +
> > > +  qcom,devmem:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > +    description:
> > > +      Qualcomm=E2=80=99s PAS implementation for remote processors on=
ly supports a
> > > +      single stage of IOMMU translation and is presently managed by =
the
> > > +      Qualcomm EL2 hypervisor (QHEE) if it is present. In the absenc=
e of QHEE,
> > > +      such as with a KVM hypervisor, IOMMU translations need to be s=
et up by
> > > +      the KVM host. Remoteproc might need some device resources and =
related
> > > +      access permissions to be set before it comes up, and this info=
rmation is
> > > +      presently available statically with QHEE.
> > > +
> > > +      In the absence of QHEE, the boot firmware needs to overlay thi=
s
> > > +      information based on SoCs running with either QHEE or a KVM hy=
pervisor
> > > +      (CPUs booted in EL2).
> > > +
> > > +      The qcom,devmem property provides IOMMU devmem translation inf=
ormation
> > > +      intended for non-QHEE based systems. It is an array of u32 val=
ues
> > > +      describing the device memory regions for which IOMMU translati=
ons need to
> > > +      be set up before bringing up Remoteproc. This array consists o=
f 4-tuples
> > > +      defining the device address, physical address, size, and attri=
bute flags
> > > +      with which it has to be mapped.
> >
> > I'd expect that this kind of information is hardware-dependent. As such
> > it can go to the driver itself, rather than the device tree. The driver
> > can use compatible string to select the correct table.
> >
>
> IIUC, are you saying that to move this into driver file and override the
> compatible string via overlay ?

Ideally we should live without compat overrides. On the other hand,
sc7180 and sc7280 provide an example of doing exactly that.

>
> > > +
> > > +      remoteproc@3000000 {
> > > +          ...
> > > +
> > > +          qcom,devmem =3D <0x82000 0x82000 0x2000 0x3>,
> > > +                        <0x92000 0x92000 0x1000 0x1>;
> > > +      }
> > > +
> > > +    items:
> > > +      items:
> > > +        - description: device address
> > > +        - description: physical address
> > > +        - description: size of mapping
> > > +        - description: |
> > > +            iommu attributes - IOMMU_READ, IOMMU_WRITE, IOMMU_CACHE,=
 IOMMU_NOEXEC, IOMMU_MMIO
> > > +          enum: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,=
 16, 17, 18, 19, 20, 21, 22, 23, 24,
> > > +                  25, 26, 27, 28, 29, 30, 31 ]
> >
> > Attributes should definitely be defined and then the DT should use
> > defines rather than the raw values.
> >
>
> Ack.
>
> -Mukesh
>


--=20
With best wishes
Dmitry

