Return-Path: <linux-kernel+bounces-532485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA9A44E59
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D850A1721B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDF818893C;
	Tue, 25 Feb 2025 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQxVhYtA"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D1D18DB2C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517590; cv=none; b=UJKFPNBmos5FEi+atUS7Gkbegz2iHzFMXpG4pVXwLxDtpk/Qulpj1lnsTatd1cIJxZ+cBc4eb6dceU9aU3JcNWGza1wjTZUos2DydRu55lrqR8vlkaqjRb/C44aZg5RliHCMq77GhFOGi5PGOsxDK2BtNsKegbdHA1Vy7c4EumE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517590; c=relaxed/simple;
	bh=WmGJxpRtCAtAMLQXKUCjzBB1xFWO+4jFrTVLTJKp0yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBCBNUtUIjyLKu/B1T15OIABjpCg5s2ia0FLunI6nTekm79XWbkoc7mD99v2zKqCUoYCjMLYIXO9uKFdXdtMf84WJpx6VP59BXfmX07TsfAeLo/uOTaaCGuEEIc0BhNjuC0ZB/cnTrkRLyMC9FYq8JZjxPbtJTizNl47xG3g0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oQxVhYtA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5485646441cso1111590e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740517587; x=1741122387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ccj8mQiqVZD3kd0H/8TemcjtwIEI2BuIPjkRPoWw6Q=;
        b=oQxVhYtApH8KpEn7K1SORifN3X32IQF61N1XRLW7Lbcr6gWIOW5+mzomUxNL4SVOOv
         SM3rCSqvlcnyVww3o5ip31wUKvXfgBDkbi50BL1COYNj/bhseqDJnpn/IJk8D6wMmP/3
         eo8x9P1HbRiZUEAJsZHd/Ktb7lsI/8roeF8dNO45CM7s0Pc//rOmFn5xvnXZNGPdQF01
         enpK2uaak9gUVdw2spnLNKN/rVO/anh8BeEWiG/C6KzIZR433xrlR25k622ujk7Sjj5L
         qQAXwYk1dITAHmqUi0yLoraylUDl+TBR2KvKPyO0teyLxN4nqgEFK56hQD2uTbqUkvq2
         l6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740517587; x=1741122387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ccj8mQiqVZD3kd0H/8TemcjtwIEI2BuIPjkRPoWw6Q=;
        b=Yh9E0LoeSouCT0GmRfL2PqKxhgrBeThSz1gpM2Yyx2Ja0sm5YiIchpBHv22gGMYwuE
         pNK/0hT6rx8SNSt6nsVSLNgz4oC8CBds+NLHNCtSg1w+JHeuc7iwkzYl9yWZjX40YK+6
         qAn7aNJdO4jgsF0zGgUICQHz2qkzOpnbNizcAx+37mdtbyC/XV4zBvrU3gg95uquiyJB
         jXDdZbGCvIqB/EA9uKjSJP15JOgHB/YtKrv+0aF2Cyt/dpUlGqfmcDVhritr2CuNd78I
         mngqr6cRaaYAmJN/5oMGCCt+qVLzKHn54YN3bEyGFpIobL3o01kb7IMBCXRwfr3Hzb5e
         /+pw==
X-Forwarded-Encrypted: i=1; AJvYcCW5ShaIFqunfROZWBFm7MhBvrZWuSO2aTXsZQzsiJbQRs/aENyD6r8wSp14tPnVxSa4HOf9eCQDmby2e9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzhkL9zXgEpEkk5Vzt/gx6lMb+OYjii229+j/Rf2D46lnTV+JB
	RQ3QzPh7xQhv9FhhGPR9owhcg4cJWDRn4+HPmf5p0Vgb3VBHgZDD3Hn6/D55UcM=
X-Gm-Gg: ASbGncs8+LWoYXsMOtxy9F9vZL55MoNui9xuHiQuhfUjZy/IRhiZgZZ3t6M4O5sgVDv
	1AtdgQj05azlmb0nAz+Vab9HrSIldEfR/It2cnfi4dgBg/4hKFq74V4oSauFKzS+x/MJWSIJIJg
	MQ2SXkTtYobkna8UVbCFArQ7fGOPScby5WB1S4S/Pdw7Obnr8mwp8zwe2HkultgvER5U/6+BxLv
	WRbbHQDISnFTkQHdxYSoHzpxG0YfydKmClIK0VKznBgcTMYtkbRZJo0HznCGvB6QJjqSw77ZXS2
	TEqU4nmHucRXy/mSQ13zZdypOQLR/vcjmcCHrG9LBr7UrCGW1EyU8rlGQa+E2ZcXl8CPIvIbkFN
	0YBTWSQ==
X-Google-Smtp-Source: AGHT+IHHsK+fxV7rGxHgqaCajsxqWGESnNX/hIrjllNl78iTD1Ai8xp/XSeeAKtHfF2+7lOR6sFvcQ==
X-Received: by 2002:a05:6512:e83:b0:545:2776:8529 with SMTP id 2adb3069b0e04-548510ce6e2mr3332428e87.5.1740517586807;
        Tue, 25 Feb 2025 13:06:26 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514efaccsm266286e87.155.2025.02.25.13.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 13:06:25 -0800 (PST)
Date: Tue, 25 Feb 2025 23:06:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Konrad Dybcio <quic_kdybcio@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] Revert "arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on
 apps_smmu"
Message-ID: <bwj3a7cbxqh2eeglvx6vh7bmjonbfufup4clgdogoub77mkjfo@wa4jmtvwnrvx>
References: <20250225-topic-845_smmu_not_coherent-v1-1-98ca9d17471c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-topic-845_smmu_not_coherent-v1-1-98ca9d17471c@oss.qualcomm.com>

On Tue, Feb 25, 2025 at 02:44:40PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> There are reports that the pagetable walker cache coherency is not a
> given across the spectrum of SDM845/850 devices, leading to lock-ups
> and resets. It works fine on some devices (like the Dragonboard 845c,
> but not so much on the Lenovo Yoga C630).
> 
> This unfortunately looks like a fluke in firmware development, where
> likely somewhere in the vast hypervisor stack, a change to accommodate
> for this was only introduced after the initial software release (which
> often serves as a baseline for products).
> 
> Revert the change to avoid additional guesswork around crashes.
> 
> This reverts commit 6b31a9744b8726c69bb0af290f8475a368a4b805.
> 
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Closes: https://lore.kernel.org/linux-arm-msm/20250215-yoga-dma-coherent-v1-1-2419ee184a81@linaro.org/
> Fixes: 6b31a9744b87 ("arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on apps_smmu")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Should we enable dma-coherent for RB3 only then?


-- 
With best wishes
Dmitry

