Return-Path: <linux-kernel+bounces-410267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9E99CD70F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740FC28335F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A618787A;
	Fri, 15 Nov 2024 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdO6eHo7"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978481865EA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652019; cv=none; b=NM5uL9qEMjRWEddy+UG0zHIfGxpFC5sstFmtMjl1fzYqX5Vv4FxodvlvtSFzudiiky4eCOUn73dW50s6XwHGjlsU1WNP5iWlovvzXwEbtqqQNw7GoFEJ+fs+43GKoohge2RXWS3JV83iv83zRZEETJSlzy2SbRjl1wqxY7yqI3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652019; c=relaxed/simple;
	bh=SEOTn+lkHc4hgkSChbLoegk28F7zgytRKRiZFmoACiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AULTwzY5owsGLOAogR5xIAsI5hve5cCRtn9BIjNyb6h07yzIibVMTdL4lgpcezUA70OTqxAnhcTlezfXP3bn/PDMR9qW0eyPB0CD1YIMLDEVtiby28utYsJMY6MMf8FAfW8hoGs6Zr8QumgQT7X/UZYjKk/WzLL0QIO55MFIvIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdO6eHo7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53da5a27771so1578561e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731652015; x=1732256815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1J8YPPScFRM8avVFTNWdv56IQPE49tvtNbMytzKJF2c=;
        b=RdO6eHo7tAK7JIxaurzIrCgq8jF4iQODifHlnWk1A3vNJvmCHRlPZLHfRN8Aa3HGYV
         yadVrpuNNVnUmbqAiiVat6CykZvTmCr0LzYSBC5ni1aqAth/czXBnzNwsWmHw6uOhXk4
         Nhx9cMwMdcBu+7VMHiimf2/DTZ1iJ8c/iN8AlmdzNFa/spJquEFj6TzNOWCY8kHhcI5A
         d+yfLK30o4FUYO152PrxgICaZbsQLLdhE7TCWWQjuPxph3bfhLwLEcLcz/ztAWRGddCt
         LlNgRZzzEIgbNUexlkBOxrBGqiCnLkaV+J8xc9P1U8VXZtY22E6/VlHV2q4mrhBzcgQk
         PDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731652015; x=1732256815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J8YPPScFRM8avVFTNWdv56IQPE49tvtNbMytzKJF2c=;
        b=TXt6cRnm0E0y+adx1bxSvFTf0jqmeQMb60OJjew3lMtm3xZhPanzPvBxpqk08Rp+ar
         X4cgccqd6OfDZadz0F3cLgwZ8rsWdvEJOKv/a8JH6x6Evx+zRXPoLbxfnGPu4+twrQFK
         u5QaXEFwOA6kAk2lIMirJCqnV/RRYKZf072dnt7jBY8ywm6e2yhW57S6SpVwQMonEkPL
         G2IWpwPe54MJkxOv3jGjEpttgptHIVJ5KDu8fE/K3p/zaFhkuYSscPAsy2rC5+iphHEM
         n8NRZgmw/ys4dOFhAx0fOPmSKBtcaLoIPp6nOBBXEw9xpQ6HuUMuqtHTQEbBeSsthL/f
         j5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzCe461zm36Qw3Towv0st1VfjidTQGkdANhoXTD0I6rkAaZgxMLhWjvm34gHKU0xahvpsTNennwJ8gcns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3RSo+O8mgOYBrx1RdNMBW23AibicTfYvVLh49OGDA/eAiahZV
	QJ31y/uEqMBWt025vMF4jjIwRfBPDUFrdeZb6h1Lv7xYGY8HS9LLY+lhl5XJKOk=
X-Google-Smtp-Source: AGHT+IHeRfCBqcZLNmnFoEG/mQnBqtDw3vKMNqwmSRjKMnCBShl3S5C72FWKECfFbwGJqH/kTo07sA==
X-Received: by 2002:a05:6512:b96:b0:53d:a6d1:b72a with SMTP id 2adb3069b0e04-53dab29abdfmr500983e87.15.1731652014545;
        Thu, 14 Nov 2024 22:26:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6548e9bsm445045e87.262.2024.11.14.22.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:26:54 -0800 (PST)
Date: Fri, 15 Nov 2024 08:26:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingwei Zhang <quic_tingweiz@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org, 
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com, kw@linux.com, lpieralisi@kernel.org, 
	quic_qianyu@quicinc.com, conor+dt@kernel.org, neil.armstrong@linaro.org, 
	andersson@kernel.org, konradybcio@kernel.org, quic_shashim@quicinc.com, 
	quic_kaushalk@quicinc.com, quic_tdas@quicinc.com, quic_aiquny@quicinc.com, 
	kernel@quicinc.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 4/5] arm64: dts: qcom: qcs8300: enable pcie0 for QCS8300
Message-ID: <cp2g6j43zlx2njou5qz5tmwsnnzahqtk2hsxkj2ftrzbcmy742@ysca5ica4mvr>
References: <20241114095409.2682558-1-quic_ziyuzhan@quicinc.com>
 <20241114095409.2682558-5-quic_ziyuzhan@quicinc.com>
 <rg4isufmnhnbsiljm34rfdsn46gfpatbsiscynaqtsnykbhnm3@ovcaulkfj4nk>
 <26943ea3-109c-473d-818b-2a08dba859ab@oss.qualcomm.com>
 <288be342-952b-4210-afe7-6e194dfd54a9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288be342-952b-4210-afe7-6e194dfd54a9@quicinc.com>

On Fri, Nov 15, 2024 at 12:59:12PM +0800, Tingwei Zhang wrote:
> On 11/14/2024 9:03 PM, Konrad Dybcio wrote:
> > On 14.11.2024 1:10 PM, Dmitry Baryshkov wrote:
> > > On Thu, Nov 14, 2024 at 05:54:08PM +0800, Ziyue Zhang wrote:
> > > > Add configurations in devicetree for PCIe0, including registers, clocks,
> > > > interrupts and phy setting sequence.
> > > > 
> > > > Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> > > > ---
> > > >   arch/arm64/boot/dts/qcom/qcs8300-ride.dts |  44 +++++-
> > > >   arch/arm64/boot/dts/qcom/qcs8300.dtsi     | 176 ++++++++++++++++++++++
> > > >   2 files changed, 219 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > > > index 7eed19a694c3..9d7c8555ed38 100644
> > > > --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > > > @@ -213,7 +213,7 @@ vreg_l9c: ldo9 {
> > > >   &gcc {
> > > 
> > > The patch doesn't seem to update the gcc node in qcs8300.dtsi. Is there
> > > any reason to have the clocks property in the board data file?
> > 
> > Definitely not. Ziyue, please move that change to the soc dtsi
> 
> Gcc node is updated in board device tree due to sleep_clk is defined in
> board device tree. Sleep_clk is from PMIC instead SoC so we were requested
> to move sleep_clk to board device tree in previous review [1].

Note, the review doesn't talk about sleep_clk at all. The recent
examples (sm8650, x1e80100, sa8775p) still pull the clocks into the SoC
dtsi, but without the freq.

> 
> [1]https://lore.kernel.org/all/10914199-1e86-4a2e-aec8-2a48cc49ef14@kernel.org/
> > 
> > Konrad
> 
> 
> -- 
> Thanks,
> Tingwei
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

