Return-Path: <linux-kernel+bounces-374460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6110E9A6A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1553D1F26E86
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF11F81BF;
	Mon, 21 Oct 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPX9Hhzv"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2291F819A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517931; cv=none; b=L0eS7pUWhMk3c6j0gRIKOvPNMXMuS9iOgB0VoC96okEsfVsrcHwhoSvpjgKyEDl8+R563f8VkLhj/DDhT2b78YzIFDG58syh7qPEGvydzLrh2m7ZhwyHNOMafxXJ6g+fnPyo+Kcf+WTAwwFl56bjy4Abf88kJQfvDgn3/ECFRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517931; c=relaxed/simple;
	bh=Hw7am8cAMTcp0tk0OuIDegUjLABJS7Wk6K0Z3Zl0/EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUIxrMx9xKKr94O4qFXA90xAzG5zrNJCrpgbPiqp45B2BgZAhiO0a1qZROGS3VPMIrSZyFilHk/9GyFV3h0Qtvouvkb448m1CnF9UGRYFFstCfGqyEURJHYII6jEjrE3tXmTZUUSZCyvhjkIVC2gG4uNo5cbesAiZCg2aIPwbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jPX9Hhzv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e8586b53so4649645e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729517928; x=1730122728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8g40yJFCVF/kQgPOlAOJfuUVkkE/M2NaeZrJA3RoZVM=;
        b=jPX9Hhzv09GAh2ys3BixxijSbnCJAEQflR1uFkYDKyT2KySefuMti/OjGAgaHS4tAU
         pf5s9H/Ya96nt3TJUrI54aYToN9mZaojGhZ5ipYPeq4xXrIRajZ4mmCQRpqxTTfL12QM
         OXlvUmE9fpcAKuUL7kefV4qjY85HfHYHm8C0ByHN77vEHWRPSqKMshYsJi6Q2ep+iPm5
         uxhH9Sxj2WFNvixlFX/MAYKMGxoHbJsb6HmOBWUQ8+65xldI7gQBDxKAUIYlZtWhBlkd
         5VogOb3OrWWfNZ9hjAJ0L1hXijzKaonlfKKFK8QD8nXXPF97fFkt3JmkIwmwy0UA/7aj
         odYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517928; x=1730122728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g40yJFCVF/kQgPOlAOJfuUVkkE/M2NaeZrJA3RoZVM=;
        b=dBGSjyRicUhmhiITFn2RJ36fb8L+6vKNSfyBo64dHqdBl3Yfjc8co4SADcAevJ9BWH
         kGKzDl7dE7Q9a9RCzUbU9mlkHxShhJWWeHP97NwsWmMYm3YAdRoAKbwy11PreUAQygSw
         sLxpHIhXLEemS37jHGuTIjYmbShFfIjaxPDmpQSGgB5a6AoXn31fCTJWcN0U1MAAxgEo
         lS63XkowtqWVMcHBEaL6q+XWEfymCppSjCzqV+k6nsZxaQ0iNCwWl2zpQ4iYVv1PGQVj
         4IwBaxpFiK9F/Mur1w/DrSLphKl7Kud8DeaCi3T3Kdxke4liYPcpBLC+olsc8q+Q9uQI
         guSw==
X-Forwarded-Encrypted: i=1; AJvYcCW4V6tMJYU7JAy8OjGnHFJw8qYi2YporL+RDkhPK3aDBF4orOQZppnSIHBl/5sU19tapa6T90nfpu9liys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU5j9Tq8AWzWJ6lDh7GvoZh0U43lL7k8EaEygzVIspJVQB/lcT
	PnZVUBzTeyUeycrvyV/SI5+bU9P53C4AHqwVNWllKJzXPmoeJj3RYVBmB2EvRNg=
X-Google-Smtp-Source: AGHT+IHaAFA/d1Sfb8qbQO6ADrmiNeY/Cnl3HJeORRDmfQJgbpz/zfzr8OfUKV6CkqcCEdJ8CI7Mzw==
X-Received: by 2002:a05:6512:1193:b0:539:ede3:827f with SMTP id 2adb3069b0e04-53a0c734bccmr4551001e87.24.1729517927713;
        Mon, 21 Oct 2024 06:38:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a224319e0sm478107e87.237.2024.10.21.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:38:47 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:38:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] soc: qcom: smem: Fix up kerneldoc
Message-ID: <ykl5csg3rbue4v3lldo72bbhtnqzsjpgrfobcyrg7myl5ptywa@fo3lnwkgz2fq>
References: <20241021-topic-smem_kerneldoc-v1-1-4825904a7e25@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-topic-smem_kerneldoc-v1-1-4825904a7e25@oss.qualcomm.com>

On Mon, Oct 21, 2024 at 01:54:56PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Fix warnings like:
> 
> smem.c:504: warning: No description found for return value of 'qcom_smem_alloc'
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/smem.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


