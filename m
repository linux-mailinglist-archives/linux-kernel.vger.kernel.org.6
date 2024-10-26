Return-Path: <linux-kernel+bounces-383345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2D29B1A61
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 20:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C920B217C8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425E21D47AC;
	Sat, 26 Oct 2024 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9cvFgHf"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939DF1D3653
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729966716; cv=none; b=SX4j6Fq1BMOMldeZX/bxv0xD/AE6KX/bWm3+wmkOowS/SS+5q3uyzr97uSX6kZCXBDlYIAHVHo1npyjlbIakM/3pn3ir0mwbNKwZik6g4CdO0nYerfRp2mpTh6LLD4g86gEdFWTxdRXNbTW9+JQrElVWnQQgaVJCT96ISZWg6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729966716; c=relaxed/simple;
	bh=mLUZ286GPbKzQ1G8TxZd2G/6DT+8CQKrGlwx0R4zdyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Py2KSl9ZCnNT10S7NkbsiU/Gl9UalaTD9y5r3hkAgYL/8nqMuduFYk99Jv22RMjVWeE/o+pcPcUKotZ7KA7XeFLCgynxykt6MvBluluTtE2+cPFjjQVFJQBLvh4j+RHNoVFpTOwQ2VkylT4R30LUGFLdAc3SvJEtqqljYNtp0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L9cvFgHf; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e8607c2aso3282557e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729966713; x=1730571513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lr+0jRvi1NT0IJOuOscYHQQgaFgqgoi2S8/w67o5wxU=;
        b=L9cvFgHfI6ipBzSAdinQHFlfnZr2NeHxHFBsk9Tmq+WzxHVZir4aklhHyiwaIMTK94
         qWZRUtqyHuWEGS3l0buUbs4cwvyY/a5Ov6IkHz44kB/vwG4FRmd8tyCMXegCJtdMVT7v
         +5wnygnxsgR1t1ouDA+ul/uQ9jdvuvxtO/JZdWSlFMKmu+rrzmhVqdoUJlkAKWATyQg8
         /F5vbtICQ08U/fwDU0LLDaZIDosD+e+pWzS3iXdG/sykUnBTmhJD5AOWZsBxos2IaRQ5
         7QQDiPJj6kXC/hsb0UWBjb5ZnBelfKCVeIeCoAfrbDIwOTQPKIhSnNNDVgVd97Sr/D9z
         cwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729966713; x=1730571513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr+0jRvi1NT0IJOuOscYHQQgaFgqgoi2S8/w67o5wxU=;
        b=rTU76+gbh4FrdvKg+SkRDzEAgMAAZpul8BRvHyJmq77Ry/5sFBLd60A7zPCEJkY8VX
         QnQhstAcgwCiw35lfk7T7qnkXAERnWO3QqQS0d0K33bti2ITuQZvoAL/f3GPpyLa2uP8
         76uEIqef2pjoeHTrvk6hF2c69W+dFT6XkHqvwXNV3/R2XCfxmDwy8se5cHY0TBnbi8uz
         4OPN0DyRvH/JZhE5sVMvsNqfuwEoeAJZ7NjSrt09uKzlei3t1AeRfXe/3VT4spbg9/uw
         7aLJJx20eD+r6dyN0sMQ693iCXeDEnEV1X6XzofMEO67gJwOkeEPJVUoH164ge7fx3Nz
         JAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL0ZdhbxzYW/4P6BCfaGtSrCLdW4tPs9DCblUkKqh8WbdWbSmSJjAATOyqZ1F3DYoTBpIb4v1ENJLXrb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4l1zbUHcO0U68EBTjaGgSsiFSft5MzNJCJT758BX4fjJd2F8y
	Ko0kYiSDsRp8RRCSNR5XqtcA8jwldZu2vcuVS+7x2rrb0QSP/vC6LobWh6mpudU=
X-Google-Smtp-Source: AGHT+IHV18CqxOkaMvlzQe0OOHQoINVJqyxJyEeaJmdcBaU//KGhWUqaFp4ObZCcBr8YBYAq+CXG0g==
X-Received: by 2002:a05:6512:3b06:b0:539:f607:1d2b with SMTP id 2adb3069b0e04-53b348b7c7bmr1048338e87.7.1729966712681;
        Sat, 26 Oct 2024 11:18:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e124610sm567623e87.84.2024.10.26.11.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 11:18:31 -0700 (PDT)
Date: Sat, 26 Oct 2024 21:18:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Qingqing Zhou <quic_qqzhou@quicinc.com>, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	robimarko@gmail.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: qcs615: add the APPS SMMU node
Message-ID: <nhthg2rlfatc2pyhsuoulvo5447cxg7buv4aq3r7r5amsmjjoq@pgfyvvegfron>
References: <20241025030732.29743-1-quic_qqzhou@quicinc.com>
 <20241025030732.29743-5-quic_qqzhou@quicinc.com>
 <8a60b729-b312-4afc-835b-a18060ad3f03@oss.qualcomm.com>
 <zsphor7rpbwx4km6uxpepky2h7atbgjn2435puygmpssfc36mc@wkquqxud2yij>
 <8c9804f2-ef4d-412b-97ea-f521dfd35ec2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c9804f2-ef4d-412b-97ea-f521dfd35ec2@oss.qualcomm.com>

On Fri, Oct 25, 2024 at 06:45:01PM +0200, Konrad Dybcio wrote:
> On 25.10.2024 1:06 PM, Dmitry Baryshkov wrote:
> > On Fri, Oct 25, 2024 at 10:54:24AM +0200, Konrad Dybcio wrote:
> >> On 25.10.2024 5:07 AM, Qingqing Zhou wrote:
> >>> Add the APPS SMMU node for QCS615 platform. Add the dma-ranges
> >>> to limit DMA address range to 36bit width to align with system
> >>> architecture.
> >>>
> >>> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> >>> ---
> >>
> >> You probably also want to mark it `dma-coherent` (see e.g.
> >> x1e80100.dtsi)
> > 
> > Is it? I don't think SM6150 had dma-coherent SMMU, at least it wasn't
> > marked as such.
> 
> I don't think I have any documentation on this, so.. one way to find out!

I don't have qcs615 at hand, so a purely theoretical question. But how
should it break if we mark it as dma-coherent, while it is not?

-- 
With best wishes
Dmitry

