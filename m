Return-Path: <linux-kernel+bounces-553569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D3CA58BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 06:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C5D169E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 05:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2EA1C7013;
	Mon, 10 Mar 2025 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lsYelF8V"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2511624C0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 05:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741585835; cv=none; b=B3rCkYl99VmBvJHFKoCgG0w0ObCWG6zVyy+D8qKoV9+qGoMUbWB4I1tI/Vlb4ruNUxKIL7KLo7w8oGHxQiqEAAxSB9EaFDsHutHdE9jod1JINW2D0ZQrrXTc+baFM79BGmT7VEcMjLKYjAU71WAfWL2H4lO5XgsIJRn/gaAkvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741585835; c=relaxed/simple;
	bh=zYnvO7UxXaLKDgnQdtARGxHYoWdcUJWZPhez49Oo7HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzKu1BBbhXrFzuaYfIxz33xR/z1SZXqAdubF39hhdQbunSCGiEL0ox1cwdlvDRS+bdrad0jMqeuPMuiVwfjLqn7ZSqDudnFx/DPTdd/o9XVOgVF2gDRDQL+JhmkzegVTngo3qjCs/EbeqQUb1oszlwRXwydHkiFVJwSeATyOBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lsYelF8V; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2254e0b4b79so32444975ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 22:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741585833; x=1742190633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UwUL+b7ViJdTbaqWpBCbM43ivsoRmiuqDxKHQGJRDvo=;
        b=lsYelF8VO/wVUjaV36pPJvzGnzNrVXBmOxjOXcbW9T9adNqy1w7H7YZm3JH6Zi7mPX
         DEOejG45HV4inYdrOVmVkfG1XS2CAhDL0ufkHN5zObwGIhhZPsf0cfgu8li36aRR9DXW
         9X8VuONPHJzMzTU2xeKxsM73CmsW2Kn9IZdW/tJxdm6xCdaSCaLcpccQAC5AVkKdu6h3
         9MbopGVLHCOScwMj+4+RuyycmfV/AU99HOIijxo+gLTOaw3Eiqp5GQp6uZwvuVftIkcN
         74Rqk6ePDcixAumaaI2OQodmVWXjANuwAnHuLBVIzilLaRrTMvwzsxNDkHDqtBx50HcJ
         rWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741585833; x=1742190633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwUL+b7ViJdTbaqWpBCbM43ivsoRmiuqDxKHQGJRDvo=;
        b=W5wwO+REjBn9jHv/OctuyP2+9qMPFgt8M9V1HCV7GOS9OGnKYQK87pseqk6b2vUrB4
         yrjp+B+nAVaTOiqukRGWH7OLdoK4WrFWpg08R6Xy3nmDm3AwFcHzrafkh8E6q4EOdPcz
         otq49JURS9Zc9Qg+ErN5wuxYmv58dm3a7HZqie9OTEIuTDjiOFA3uGm0/24MmhX+KzNx
         AmBjRginVHY5/g2Pi2t7IvqbqyW82ZXsE0CF20Vb8Llxji9Z2qemH3vMmB+2E4Tk1hVB
         pB3teFKtzAt+lhCjy++XGPeV5FDn535geW5BawNlxp0j4QKyMmTe6FBWMbFcFUSU1wkY
         xTQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/P9Lxu/qKuihSH+tjRmv2ouXFqNWaYDrBK84TtyPjHNbqJo8dCCvyV0PoY0tP/G6k7SzqBcMl/BhhWds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAwAwcTdStLdxXeIqp64nR1OXlgvNL+oek97Ys6HOPpqoaikkc
	Sivk3qTLaIm6nEZXCM53m3Nis5QNER/pfdkeW0WiKU7Eb04+boY4IA1vnsJj5P0=
X-Gm-Gg: ASbGnctCdkAW/T2pJUqG3szsDzw50tFyPDfkT9XUhDo+UI7AMIOcC0Rx5G7T5vdah/5
	rVdX6BYqCXu/7+G121VIxH2uqHCpfbTObo3iNVe74fPPx/qUnNaymdZP3n4XCQ4E++32NEaKqBY
	59Z5/rgSCO//ADT/lirVgc283Rk/xW/XR6X+q3aXvDOCEGPWaiVbOKMpjWnChPKwsETa4Oy6+mb
	cuQVlNCuCeGCH9YpLdc6iH+ED899w/A00o+ahc0QL0Kfc9BalwAA3FVbuHg+FuUQv1xji1egUXB
	QHk+dCgcsupfoslB84kKVHgtTOGiS48iLSlDAXWhi8YbRg==
X-Google-Smtp-Source: AGHT+IHPp3K4l2ZyxYf/rKQ3RqUoT3ZhMn6STVsJw+Ky5U+CU8LfyTho0FXbT7xpiSFmiuzSgnUX3w==
X-Received: by 2002:a05:6a00:b4e:b0:736:592e:795f with SMTP id d2e1a72fcca58-736aaa1d1d6mr13217009b3a.9.1741585832714;
        Sun, 09 Mar 2025 22:50:32 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736ca79944csm2481508b3a.87.2025.03.09.22.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 22:50:32 -0700 (PDT)
Date: Mon, 10 Mar 2025 11:20:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aaron Kling <luceoscutum@gmail.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2] cpufreq: tegra186: Share policy per cluster
Message-ID: <20250310055029.7u4qkmcnfqhtof24@vireshk-i7>
References: <20250310-cpufreq-t186-share-policy-v2-1-d0b743cd051f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-cpufreq-t186-share-policy-v2-1-d0b743cd051f@gmail.com>

On 10-03-25, 00:28, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <luceoscutum@gmail.com>
> 
> This functionally brings tegra186 in line with tegra210 and tegra194,
> sharing a cpufreq policy between all cores in a cluster.
> 
> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied. Thanks.

-- 
viresh

