Return-Path: <linux-kernel+bounces-543899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB690A4DB30
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A377A677D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2188B1FECCD;
	Tue,  4 Mar 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hqu81SRd"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BA1EEA36
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085181; cv=none; b=Ct/Yl1pTWjic8STQQtjK+/mNDpk2C2VlatgEl71xiezPSkOTK17ePAd3y5lqUOQG6yLueH+gOBnuuSWwGsCP+BiSXFyeTuOOmQl6FaNJycx2fgOPCu9h62qN7/xybJLaPwKR4X2qJ3uV+frRJ/e5jYTyh4Z5/VCzVtLGf2lK4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085181; c=relaxed/simple;
	bh=2z4xJ/oVBzhQcfL4L8jnNsoPpesn5R7TIXhKiA9UeKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7ws0rfOKQ9GkJhu+1E+aAfIm3FCYLNmzSFLbFXLv36aAX5e7261G8hEOF0hVUskBI4m+s2ppFPEj/QCLG5YRc7PO+kxxXoaF4GqZLt1fP6vDcAu1F/4FQZDVRkxQJw9tjsJyOoDJH7wS7XZva2a5o4/IwkqGBhsvBXrtnh00p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hqu81SRd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2232b12cd36so73018875ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741085179; x=1741689979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQbDCOHa2pj582SZg3Jgs217+eBO1p9MvDkVyDBmmeA=;
        b=hqu81SRdwa3wEd5xYJV80SaN9wPaFJniwHRdjcH4Ejx0JtJf/Kc/Kr/Q7lT+qPBvSM
         h+UtWX8JZ5hl1d33q1itu8nIMmUMtxa7V5fGz6bzWuagdvCd11TOJBHZS9viASycfE9E
         oL5SmP4Xqj9p8/ch963aYpR+5cUOwZG7JhNVT/uFIFSB2hGKKM9VallDIHJ9hU4ldNhM
         cmYqYKFkbMPFwAwLZzTufoeSYU28glDdXDiA/WWKAXD1z6TxuOvpIiGeRfZbJnijhL+G
         JvbQJ/3+1OGW2DWoGwaqklNj5YTNbepzi8DJKK/pRK1yXMDH1tFVkhIANzX9V9C6L8uJ
         w7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085179; x=1741689979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQbDCOHa2pj582SZg3Jgs217+eBO1p9MvDkVyDBmmeA=;
        b=hX5yPrybMA4CrRGpBbs0mqXWs3mhKIsref17dCM65hbfgQ5QMYJ0xmdYAtKPwerwMH
         ET1hARfxk+aG4th2Ck6vHgo2gN1h3ogv+x9/+5CJftM3wwbIqVBV1t+jQWO9Y9rw1EfD
         dDmCDtF8OJQxYZGqPgyy2IO53MKQewK1EF3zgvkMGrk0ZxQ93aB4hq0Shtlf1gOzXzyf
         D1MPUX1SBmIruJkor9+vc4Xv49dkuIvP7I6vyutnV3pVxFlrtaIzafaz8OZu+UBPpICj
         m94ijqy2lQ+i10P6kFRP1HPZWH6l6chx2vk3IaKBPOIRZNuiih1r70Ey7WWO4B16Y91K
         SgWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeWblL64r0hZAO7chtVvuNnKxMP40BBvyBXMgWXsStf6+Y3kh+ON+lmM13YGBpTT3Y91L9fXopzDFE0D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBikqh+NSVn5Vg2Tz0aNYqv4OlX72i1JbwAP3FqMUr2fiptw8A
	rUCzv7oG9RPQj3jINEmU6qHcu+nSK6VqCrHv4jWPtM30HG2a6750uLwMkcqbHmk=
X-Gm-Gg: ASbGnctExFsIXPyGHvyV3uAzcixXzcWLnU1lBXpGWaHq08sBQxOjHNOIuF/fwS6hoEZ
	bwgqgiw5iygVQR3dQlKTStFo18TTZQLXRc6jgbey4jqxdkPfvbmo3O1vbdx0kC1UWm82CaqM8Jj
	5IrhDR2s9rV3F19xwHvneAkAWd6Pqrs3JPaqryCDEGaXQrwUAG+YpampjhDxs9WxxYe04o9ocqy
	JpLoau7iSs0VvYlUDagegua5z6GLKWkyZ4PC+XWVgsVK14vB2ioJMaspOqI07L4JrIkSVRNychM
	BBpXQXAIaHO6VwRQlyYtt2ZJ24EKSRT6XsPcctLXRBH0lw==
X-Google-Smtp-Source: AGHT+IGJt/FnrpzymxUjIqCIkUti+b2qTGqcr76eFWaDRGxtiT/MuoYL9mWlXIKVzc+48AhF9ZOMeA==
X-Received: by 2002:a05:6a00:92a1:b0:736:3f4d:4d49 with SMTP id d2e1a72fcca58-7363f4d5011mr17422751b3a.8.1741085178806;
        Tue, 04 Mar 2025 02:46:18 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ec7esm10592435b3a.153.2025.03.04.02.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:46:17 -0800 (PST)
Date: Tue, 4 Mar 2025 16:16:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Sumit Gupta <sumitg@nvidia.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: tegra194: Allow building for Tegra234
Message-ID: <20250304104614.ws3yikqfrip26hfp@vireshk-i7>
References: <20250226-build-tegra234-v2-1-cf7e0828714e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-build-tegra234-v2-1-cf7e0828714e@gmail.com>

On 26-02-25, 12:51, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Support was added for Tegra234 in the referenced commit, but the Kconfig
> was not updated to allow building for the arch.
> 
> Fixes: 273bc890a2a8 ("cpufreq: tegra194: Add support for Tegra234")
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Changes in v2:
> - Drop pci patch which duplicates
>   https://lore.kernel.org/lkml/20250128044244.2766334-1-vidyas@nvidia.com/
> - Link to v1: https://lore.kernel.org/r/20250224-build-tegra234-v1-0-39e4e912f968@gmail.com
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

