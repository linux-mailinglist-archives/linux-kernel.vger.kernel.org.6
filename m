Return-Path: <linux-kernel+bounces-211550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAD8905394
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C061F23C73
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BAB17B42A;
	Wed, 12 Jun 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThjlDsGS"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1F178398
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198511; cv=none; b=WNLxNxB8LO5h0PwPn40UbKudDTLpL+JEteLXoVdNERq+0fByl0c1L3y+N6qifkLPvC96/F4cVaGdoIhaM9JKUf+j8SWPegdMLhEVQ2dKUNVKyykurRFCE0S/vTHjjYXI4f48AKZnM5OLz9g/kHV3qaseCf9iv/iJ8SCBOOhzIK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198511; c=relaxed/simple;
	bh=BA4Wf/72hxqc3d+G5WSmwDys1g8/cuiumB2zbFar818=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFrJ22ZEIgWguwl+Zm8c0TVAc4msc6BDkCtLZEfbM7DV2TQ9tOrR1ny+sxF8Z0dLb9s5pbifMeDnJreQDpS0tkBLVyf6jv+kwZyy6jDBuq/x95e+PZPeBExPKr92HyKl7bfGQsIEo/Mw3hFb8/dBa5hQOUyMF9VDtx2WmxhmdTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ThjlDsGS; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfe398bc50dso832165276.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718198508; x=1718803308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QaE3/IVsQgFpAVoWWAOoQa4iD4hM/AcKPalY+VYsWQM=;
        b=ThjlDsGS7gO3SWXq976MKn4g1X11YcXNsa1gA3TOfwge8gYjXUbmmsmy2clEQUkIze
         9fl/2hK2Lts2tNvK2SNkHkO/f90fcpShRHdfspfc+u14rRF/B2Fo/mbzAvegj4U1B7/v
         Z7LKXcuMvx5aFw5Bgj1/dD4kYOqLkihM4fPltAFdR2UlEvfhs9pZ/TJGHLntfSJwafsa
         VN+0QU0l61y0P1nG+i7Fr3ZvO6V0DQhW+RovDNZx789QiC5awXE7WsQOtbMOn758JWec
         /mmcCqJkEd6IvGcaPT2vDhqPc0d/v9mMEK8q8mav3KYquO6Vjic2owm4Wig9rvpxnvaP
         YxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718198508; x=1718803308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QaE3/IVsQgFpAVoWWAOoQa4iD4hM/AcKPalY+VYsWQM=;
        b=ZKtxPlymwXDyEcJ+nu2bONot6xAZo96RE2RxMyMeDnROA2QeBiU1Cq/kPAa4ZEo2nH
         jpxwtbw6ul1jpaasERn4cvCNQlXQWpT8jT1sAY1F3ovbHw3gtwOTB3d0RGq1ChpeptrD
         qeZKLvPO0l3gDeZgUmUVDxRdWAu8YxuZuxZVhLnpStTnSP1wtXWySR/jKx0SzyYsigA2
         Uu+a5SLsbxMOdkkLkCTj0jc/XxnDRulGr0WlJrkwnJ88eaf4tTm84kd9x0yXCyDNAO1G
         7A8tYURvrBZu3F8UUD4tq/H8bnCpR+Go0cjJ6xHWYU8rkSsvTrseepxmI1Fho6myb0kf
         hykg==
X-Forwarded-Encrypted: i=1; AJvYcCVtkBPzVMZ9TCVIsM9MtSxpGyyKmSra3OSvVlBt7sMqRwe9O+yBX3PC7YOMd4H0qX+kqITRGbGmAS0yOycrL0jCOO7X/eVr/coM12Tx
X-Gm-Message-State: AOJu0YwP0TSULokI4IkJp3nknbpYx4Y53c7bvbxG4Lsp7vGqv/ifohg8
	OEtafBlRhaQA3aGLVB0dnHDMNEmaB4FtaVVESDSMZB9XSvyQcTehyNty9lMtxuVwexQig7sM8FO
	1WXORAfPLV93LB7tmd29yxinyKSKWPcLR4/EdTw==
X-Google-Smtp-Source: AGHT+IED4NrVMojf2ugvymFvDTDHoVkUFaTrUqR0EYBjIykxoqNrlFfWmhnWwfv2v2hj4msHRjXm9A9casCYvrHGKeI=
X-Received: by 2002:a25:d8d3:0:b0:dfa:fed0:caee with SMTP id
 3f1490d57ef6-dfe67758c1amr2053151276.39.1718198508029; Wed, 12 Jun 2024
 06:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611223743.113223-1-danila@jiaxyga.com> <20240611223743.113223-2-danila@jiaxyga.com>
 <171815244421.3448243.12009673117592867975.robh@kernel.org>
 <727417e8-781c-435c-8abd-f3dfe6b0e5bb@jiaxyga.com> <20240612132003.GA1934293-robh@kernel.org>
In-Reply-To: <20240612132003.GA1934293-robh@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 12 Jun 2024 16:21:36 +0300
Message-ID: <CAA8EJpqre9bNH_vk=YH2-a6a5g4r=+o=X=ocL9oo+di8Wf9mUQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: display/msm: Add SM7150 MDSS
To: Rob Herring <robh@kernel.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, jonathan@marek.ca, krzk+dt@kernel.org, 
	quic_khsieh@quicinc.com, linux-arm-msm@vger.kernel.org, 
	quic_rmccann@quicinc.com, sean@poorly.run, tzimmermann@suse.de, 
	mripard@kernel.org, linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org, 
	dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
	daniel@ffwll.ch, freedreno@lists.freedesktop.org, 
	marijn.suijten@somainline.org, robdclark@gmail.com, conor+dt@kernel.org, 
	swboyd@chromium.org, quic_abhinavk@quicinc.com, devicetree@vger.kernel.org, 
	airlied@gmail.com, quic_jesszhan@quicinc.com, neil.armstrong@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 16:20, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 12, 2024 at 09:19:35AM +0300, Danila Tikhonov wrote:
> > On 6/12/24 03:34, Rob Herring (Arm) wrote:
> > > On Wed, 12 Jun 2024 01:37:40 +0300, Danila Tikhonov wrote:
> > > > Document the MDSS hardware found on the Qualcomm SM7150 platform.
> > > >
> > > > Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> > > > ---
> > > >   .../display/msm/qcom,sm7150-mdss.yaml         | 460 ++++++++++++++++++
> > > >   1 file changed, 460 insertions(+)
> > > >   create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml
> > > >
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dts:25:18: fatal error: dt-bindings/clock/qcom,sm7150-dispcc.h: No such file or directory
> > >     25 |         #include <dt-bindings/clock/qcom,sm7150-dispcc.h>
> > >        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > compilation terminated.
> > > make[2]: *** [scripts/Makefile.lib:427: Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb] Error 1
> > > make[2]: *** Waiting for unfinished jobs....
> > > make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
> > > make: *** [Makefile:240: __sub-make] Error 2
> > >
> > > doc reference errors (make refcheckdocs):
> > >
> > > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240611223743.113223-2-danila@jiaxyga.com
> > >
> > > The base for the series is generally the latest rc1. A different dependency
> > > should be noted in *this* patch.
> > >
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > > date:
> > >
> > > pip3 install dtschema --upgrade
> > >
> > > Please check and re-submit after running the above command yourself. Note
> > > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > > your schema. However, it must be unset to test all examples with your schema.
> > >
> >
> > Yes, this happened because I forgot to add note (same for both dtbindings):
> > Depends on commit ca3a91063acc (dt-bindings: clock: qcom: Add SM7150 DISPCC
> > clocks)
>
> So then this can't be merged as I imagine that is in a different tree.
> Maybe you want to not use the header for the example.

Danila, please resend using invented clocks like
<&dispcc_whatever_ahb_mdss_clk> instead. I don't want for it to be
delayed further.

-- 
With best wishes
Dmitry

