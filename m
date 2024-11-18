Return-Path: <linux-kernel+bounces-412962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDCC9D11C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864AB283F66
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63B21BAEDC;
	Mon, 18 Nov 2024 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nmYZDE8J"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA71A0BFB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936134; cv=none; b=Hf5TGSTgM2gW+TOfJuQlyo0WPbM8pvtDKfajIvM96O/5kWvTL/7GS0H6xHL+Q5ZNgyE8rxVCZzMzbewnDHkKlKT+L0vwKg2841VXOBclmQ5Pm73H/pOxj/N0QcLDdPoZOgnDzWhIESFTrvKtw8YQVz2pdZdeaM50uDgnFPhPp9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936134; c=relaxed/simple;
	bh=8WZWHjrrpvf6/wJGZvis8eIJoW+Xx+9uwID59tAg6dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+vspc0J9SqT2qThOqZ99/oR4RgY9+C4RUgevtbAHIloHu7XtR8MEBv2cOUceAwQQ6Pnhn/2U+rYCuK/K9tu6Wk4gvrXoyi3v0TkP2cfJSJBAH37VcPVpVeZozwQp7Za3ssEhCSKVHR5ApZhTQDlBXeOI8fh2O0SMhbhsNnD+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nmYZDE8J; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e4b7409fso4259779e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731936131; x=1732540931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHlRycREef525moGSk+vFsAJO6g0zablcSaT2Q6MMzE=;
        b=nmYZDE8JwRzVTuTCeRnqBYBoe4FSU0oLp4AIoT+ZDVIgiq9ZIDoe0DA6qwqmNw0WWl
         4d1ek1cnz1V55To9ihuI/+/Qma1aFA7Dkf6SVwuwqlAQIhw2m8mcfh9Peoq6nxRuXAqg
         9QY7v5T0pLGOH+7lXNnsOgY6/tzdS6jKbw3pXZXRWfna/MMauDhr8DDXSv9UXnEkcyYG
         6deoWVN2+06hu4X47r97HroD8tTncHOAVc4b3u9fLLse4jV6AOXFd0bvZl3yJVCZEl6k
         7BdYr6JDXfqWguTj10uqKuESGPXbm/jMvI5wyLbDxMG1TUhPr7xvpo5s35IvhR1vbFqd
         v9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731936131; x=1732540931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHlRycREef525moGSk+vFsAJO6g0zablcSaT2Q6MMzE=;
        b=mO92w2KNF23u3EP7RR8sJGxutZbS8wOuLymnV6JIxmKi981X/CugJqHMBZP+GqYlnG
         Su+hKWs6XDFKbW4X7T7UPzaCeaMpIns3UxcJ/PAXqltDCy8RYWA4shpczkWxzdAL2AsE
         I1JGRnQFONL0TEmZG3S/qwIqhtFUXGOK555GEpAT3+3xKDU2fw7T1A8fdWkjFm2OQZ3l
         f8EbqZ5vpfEeWx17shgDBKY4HBzIHCQwFPChpWrJ51LrKoLw+AcFU76hQonEPZSto0mV
         ai6p1THLZXnRuwTW9B5wwOmDPd/a8ZqDZK8LlfcKBliAoxGnaKbUK1Ba1AJYupu9Dguu
         57Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXLmG7rsp6fmPUo0FFZnnwIR8S6yZTlRtWGOaeV1GaAgKWghe29x2IfY5A+EgNxSYFfdNN8fX00JK+vnUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNY3QvMlWbLAXKZNABOVzh+P3zZfM9eu6MUrZVFq3WggGq6GE
	mIaphQeQu05YsYed+5mW8TKt2DPyQZbChhbCRIw1/mosHCcbgRYGPQxAncV49Ac=
X-Google-Smtp-Source: AGHT+IEth3Rs4CRCnHxcAkRLL3QYVR7t7ZRuvLES7ZeMPLIutcz17tWZ5cEK7b+lVyqxjvupb/VQnA==
X-Received: by 2002:a05:6512:ac8:b0:53d:a821:390e with SMTP id 2adb3069b0e04-53daafed725mr3889907e87.7.1731936130882;
        Mon, 18 Nov 2024 05:22:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da654880bsm1611327e87.225.2024.11.18.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 05:22:09 -0800 (PST)
Date: Mon, 18 Nov 2024 15:22:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qingqing Zhou <quic_qqzhou@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, robimarko@gmail.com, will@kernel.org, 
	robin.murphy@arm.com, joro@8bytes.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: qcs615: add the APPS SMMU node
Message-ID: <buu6l7re4tqauqsbfhlryf223lt4f3624jm2b2nnhexwxmymtk@7hrpd7ht3aff>
References: <20241105032107.9552-1-quic_qqzhou@quicinc.com>
 <20241105032107.9552-4-quic_qqzhou@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105032107.9552-4-quic_qqzhou@quicinc.com>

On Tue, Nov 05, 2024 at 08:51:07AM +0530, Qingqing Zhou wrote:
> Add the APPS SMMU node for QCS615 platform. Add the dma-ranges
> to limit DMA address range to 36bit width to align with system
> architecture.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 75 ++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

