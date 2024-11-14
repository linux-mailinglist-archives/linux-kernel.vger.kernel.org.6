Return-Path: <linux-kernel+bounces-409256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B469C898F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602D92820BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DA11F9AAA;
	Thu, 14 Nov 2024 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JnXLe4zW"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D21F8F13
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586307; cv=none; b=OZCzDmosQp9S823EKWcK/2b1Qex8Eo97eUBrjAoLgUqkIIgE6mvbRrKSy0/YcEu3B23DzzPx/womjuADVBs6uqtiAOsobwrXysgr2B+KpIypV7ALZRXtcmKxS6DLsDQpBEESctalpk8cdsROhssc2ewB8b/hXtYpuRHE1A2eWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586307; c=relaxed/simple;
	bh=8z+kqJBm6xVUjsx7g2KL+Nw8vebu/U9FGTQdulnyuOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuWH1cAatqUHhKU9Vuy55t/Y6GSzxh3TrluEjIfw8Xh8w5y9EZh8EyIg1Lk89ssXtCYsLHqDMdYR/PfvdBNdMNbxXK8iFN1OJ7DO4gN4Fq7Kd/RZHOKLIGZAOX9ppNxAfWv7WcBgLCQbr+qhqMuvAsD6xk9rwUPqZ8feFANHlrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JnXLe4zW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53da07b78dfso552828e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731586303; x=1732191103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E+Fn+TRNlFXO3ulOSTzXE3Z/L18YHrd+68I42zTssiQ=;
        b=JnXLe4zWtSk7OGlME9cgTQdpgDnZG7qL8lO3CiiEnH7PSrjACstCKAWk3S9H6hGeNq
         S/Lnhon4sLeuOxn0hrWyV1z19FDhFY+OSwxPx2dP2eOvtlC209D4wja31ujBBCUIQc0x
         M9LbnI0wXm2YzKg1MI62T7bnUVwe8mQox/n0nLiLZjWgFuReytvvXysGcfdND4YSyWWJ
         qlynMbNLiZxheBXSmKCqG+dSt8ybJcTF9Zxaklwt9PcxgWXmtV5t/Xcjl9oOWqcFWEE2
         py/+wSCjxt/rTUVvJrIO8cd48nLyglpJ9mWwR5QMyPegPg7xqaB8uzy0rWLBdJsu0Q/n
         EBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731586303; x=1732191103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+Fn+TRNlFXO3ulOSTzXE3Z/L18YHrd+68I42zTssiQ=;
        b=dhFbwplfhvrIjZdjsB5hCSdD9RgSZzsrx2/0Fd3wg9BBN3G503MArRgWqVr+aMgYBN
         TYc3l9JzT4ySo9mj7LUqG0aFvTmpr1kz7zyLrHb8NnLvixvQWgeO9Pd7DyG/jgVz4WSz
         mY14ThRxFRC2Q2UUTEKnUKBZFJ1EMg2RxeGZLluGbnHt3meziAFQfbgCDERtaFHi95GH
         EpO325ifiy4qBl6SR/IrBNKxVSM69VjBNVV9G+4mWy7l0pz8R+kngdiqiNM37EAH9ZYa
         42cv2K9T5uRS1FnGAToRkRaNpKJ598lJ7TaIpy3hgs+cPOkHtgco2B1p/aptmm69CdE5
         HN5g==
X-Forwarded-Encrypted: i=1; AJvYcCW7TlhOxYJCZoOL/wx/FqA4Lb5oczynt8oua/68U8lptzGhPzJQw3Pg3LLDpId7VXlZLzmoy/AkeKiAgEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/olUy5xudaDAtNhOGYjpAswhHVkRkDh4Gj7oilaYk+WERFNs
	vRyETM97/APXzsfTvf8pJUPlvAjxkwY8kwdC5zxnwdV0x5aNCWoAJj2m14vZAQw=
X-Google-Smtp-Source: AGHT+IEuwJH3uXzQoHJuqJQBlLC78MEjhVMGtWYMu62qUlP11U2Jmmz1Nm73TpwhnS/Tw4rX6aoyBA==
X-Received: by 2002:ac2:4c04:0:b0:53d:a077:1d0b with SMTP id 2adb3069b0e04-53da0771ddcmr2952197e87.44.1731586303288;
        Thu, 14 Nov 2024 04:11:43 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da64fa596sm164800e87.48.2024.11.14.04.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 04:11:41 -0800 (PST)
Date: Thu, 14 Nov 2024 14:11:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Renjiang Han (QUIC)" <quic_renjiang@quicinc.com>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	"Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>, "bryan.odonoghue@linaro.org" <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] media: venus: core: add qcs615 platform data
Message-ID: <refu5diitlpho62d756sgarsd77upbkidarx2dwuqng7kpndrd@xiqfir3nentb>
References: <20241112-add-venus-for-qcs615-v2-0-e67947f957af@quicinc.com>
 <20241112-add-venus-for-qcs615-v2-2-e67947f957af@quicinc.com>
 <eldjwrookzs46mvxdp56uj2eytfeu5fuj4zs4yowcyilhra3pg@vc6v72klixem>
 <a8c4dea53aab46b9ab8d40b9d997f13e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8c4dea53aab46b9ab8d40b9d997f13e@quicinc.com>

On Thu, Nov 14, 2024 at 04:25:45AM +0000, Renjiang Han (QUIC) wrote:
> On Thu 11/14/2024 2:01 AM, Dmitry Baryshkov wrote:
> > On Tue, Nov 12, 2024 at 05:17:58PM +0530, Renjiang Han wrote:
> > > Initialize the platform data and enable venus driver probe of QCS615 
> > > SoC.
> > > 
> > > Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>
> > > ---
> > >  drivers/media/platform/qcom/venus/core.c | 50 
> > > ++++++++++++++++++++++++++++++++
> > > 1 file changed, 50 insertions(+)
> > > 
> > > diff --git a/drivers/media/platform/qcom/venus/core.c 
> > > b/drivers/media/platform/qcom/venus/core.c
> > > index 
> > > 423deb5e94dcb193974da23f9bd2d905bfeab2d9..39d8bcf62fe4f72674746b75994c
> > > ce6cbaee94eb 100644
> > > --- a/drivers/media/platform/qcom/venus/core.c
> > > +++ b/drivers/media/platform/qcom/venus/core.c
> > > @@ -630,6 +630,55 @@ static const struct venus_resources msm8998_res = {
> > >  	.fwname = "qcom/venus-4.4/venus.mbn",  };
> > >  
> > > +static const struct freq_tbl qcs615_freq_table[] = {
> > > +	{ 0, 460000000 },
> > > +	{ 0, 410000000 },
> > > +	{ 0, 380000000 },
> > > +	{ 0, 300000000 },
> > > +	{ 0, 240000000 },
> > > +	{ 0, 133333333 },
> > > +};
> > > +
> > > +static const struct bw_tbl qcs615_bw_table_enc[] = {
> > > +	{  972000,  951000, 0, 1434000, 0 },	/* 3840x2160@30 */
> > > +	{  489600,  723000, 0,  973000, 0 },	/* 1920x1080@60 */
> > > +	{  244800,  370000, 0,	495000, 0 },	/* 1920x1080@30 */
> > > +};
> > > +
> > > +static const struct bw_tbl qcs615_bw_table_dec[] = {
> > > +	{ 1036800, 1987000, 0, 2797000, 0 },	/* 4096x2160@30 */
> > > +	{  489600, 1040000, 0, 1298000, 0 },	/* 1920x1080@60 */
> > > +	{  244800,  530000, 0,  659000, 0 },	/* 1920x1080@30 */
> > > +};
> > > +
> > > +static const struct venus_resources qcs615_res = {
> > > +	.freq_tbl = qcs615_freq_table,
> > > +	.freq_tbl_size = ARRAY_SIZE(qcs615_freq_table),
> > > +	.bw_tbl_enc = qcs615_bw_table_enc,
> > > +	.bw_tbl_enc_size = ARRAY_SIZE(qcs615_bw_table_enc),
> > > +	.bw_tbl_dec = qcs615_bw_table_dec,
> > > +	.bw_tbl_dec_size = ARRAY_SIZE(qcs615_bw_table_dec),
> > > +	.clks = {"core", "iface", "bus" },
> > > +	.clks_num = 3,
> > > +	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
> > > +	.vcodec_clks_num = 2,
> > > +	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
> > > +	.vcodec_pmdomains_num = 2,
> > > +	.opp_pmdomain = (const char *[]) { "cx" },
> > > +	.vcodec_num = 1,
> > > +	.hfi_version = HFI_VERSION_4XX,
> > > +	.vpu_version = VPU_VERSION_AR50,
> > > +	.vmem_id = VIDC_RESOURCE_NONE,
> > > +	.vmem_size = 0,
> > > +	.vmem_addr = 0,
> > > +	.dma_mask = 0xe0000000 - 1,
> > > +	.cp_start = 0,
> > > +	.cp_size = 0x70800000,
> > > +	.cp_nonpixel_start = 0x1000000,
> > > +	.cp_nonpixel_size = 0x24800000,
> > > +	.fwname = "qcom/venus-5.4/venus_s6.mbn",
> 
> > Why does it need a separate firmware file?
> 
> SC7180, qcs615 can be enabled on same firmware ideally, but due to a different signing for qcs615, it takes a separate bin (venus_s6.mbn).

Continuing discussion in the linux-firmware@ thread.

-- 
With best wishes
Dmitry

