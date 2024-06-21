Return-Path: <linux-kernel+bounces-225472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB749130F7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 01:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21DE1F22DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A9A16F8E4;
	Fri, 21 Jun 2024 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2ajfKhn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC316EB76
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719014179; cv=none; b=SdXCdMk2HXUhHpuuaPa6a773+xNzyOVNdksDngK6P8iW/Ofp2W80TEoZ+M6G0J7S1+76Qxxqg4zHpkNYkV7X4KkY6DbKsLvREIsD8eMeEcs2G4PjBBZuUToK4eWm7Zwwil32K1/JOiEaNrmkG5ukB9OLomXXmT+fm4iBdiN/zvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719014179; c=relaxed/simple;
	bh=nWi4TkapE2Ezxu7e4csCWHYxNmjlAhbuDlvNb1n3IPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk7tmOIEmN8++wdv1IlN/TX/kAbsuRy9jPysmbfUVkBed64+Os1EtQgXhP60gSG0+ktLH2gzeO72OmQccsGxqH53epVhDbir3lT6snvqjm+6Kkj3Ja2dTaMnxfn9Fc2Le2A8p9u9jEm7g9+h3w86V7aSW3w/N8B0zih+gkKIblw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z2ajfKhn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f70ec6ff8bso230135ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 16:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719014177; x=1719618977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIy2CR/RFjZQaJDXPjHveFD5gn1nucaR+J0UOyxBY1U=;
        b=Z2ajfKhnQ2h3ZfKHj+6jmtRIkRSYPFfeCvUhEaqP9GyS7gW+JD+3R+041XKloVqPpE
         XDxHga8l9hglsKe0/enbZRyNIlIZl1Vkyrv77dUZAZmTCyRJBtnQMpZs6QjExpYahQyJ
         4L3jMUfkFlYfSbljawAOHITnw/jQ2NAu4PVZHeh5fbVpvEDSkWdZNh2UHs0F4jHB6elQ
         qIKVOuwAKHs/U4m0UgvcaG4DT8XJtWK0ODrmUkYcXzYeUeg++SoS4cxd0MbEEIhvT0fQ
         BnxnX7tI5qLJdCY+GMS1TKwH3ZxZJCEYQHR1Rf2lFu2WQ1CfzVQjLDFttcLALLlV/n+D
         YtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719014177; x=1719618977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIy2CR/RFjZQaJDXPjHveFD5gn1nucaR+J0UOyxBY1U=;
        b=pYIwgQhcNYqI2VzjbObNCDa/5OKuTKZwwtVzdCaTk8uB8qmyptE2kV30bzdduvM1Ti
         2DuXER6UBvMIPA2c12w1SYVmsBQzc92yQDs+4tqN+KogqIX4HNd0vj8BnJ+6QvvTDXsw
         XTGXQ4pOtAI9NT+11RkPy6yjDE+5GJGwapsClUJ8B4Q9EEmI582ZR0D2JFkSxST/GgYI
         QYc0B0cCltkYoN7LWmmZWGiCcL4oUNwjdQppHVInIYbfa4wnTK5mhb3c1nwv2wanflrE
         fR5EANiP/WDPV1JaYkBppI1ExtmySnx7X0MwPAfrZExHHZOqY30bUN3ifHd4ciZ9bz/s
         vzgA==
X-Forwarded-Encrypted: i=1; AJvYcCU9ksM7eCHOu4NIN6QXeisJfVpPjq7/Nk5yJsB0ijSE7Sl2a9Oh+iO25NmpItXmH0iiyJM9DgAOopEtLz0QeRywEgFnVUHOnZCiXckV
X-Gm-Message-State: AOJu0YyJO8DuKOyTtke9Sbjyh1IrOJWwCi2l/2aUR1Ah+TFkIjESka9M
	d0f02M5T1kgXI2cVcNl5Ifc5juof0di0FpuzG7+l3sgSuBav2aB2QG4Zf2vf9g==
X-Google-Smtp-Source: AGHT+IHwKZFfTcf6qeuALbcdQ3AWCrAEIufgmLdwwP3qVJwrhBc2d0hTnJg9cYYAp8QYf/0EybR/ZA==
X-Received: by 2002:a17:902:a58b:b0:1ea:963e:2e2d with SMTP id d9443c01a7336-1fa0a29ec8cmr788815ad.24.1719014177092;
        Fri, 21 Jun 2024 16:56:17 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819dbb963sm2168967a91.41.2024.06.21.16.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 16:56:16 -0700 (PDT)
Date: Fri, 21 Jun 2024 16:56:13 -0700
From: William McVicker <willmcvicker@google.com>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: lee@kernel.org, arnd@arndb.de, krzk@kernel.org, alim.akhtar@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org, andre.draszik@linaro.org,
	saravanak@google.com, semen.protsenko@linaro.org,
	kernel-team@android.com
Subject: Re: [PATCH v3 1/2] mfd: syscon: add of_syscon_register_regmap() API
Message-ID: <ZnYTHcjBo5E8Lxi0@google.com>
References: <20240621115544.1655458-1-peter.griffin@linaro.org>
 <20240621115544.1655458-2-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621115544.1655458-2-peter.griffin@linaro.org>

On 06/21/2024, Peter Griffin wrote:
> The of_syscon_register_regmap() API allows an externally created regmap
> to be registered with syscon. This regmap can then be returned to client
> drivers using the syscon_regmap_lookup_by_phandle() APIs.
> 
> The API is used by platforms where mmio access to the syscon registers is
> not possible, and a underlying soc driver like exynos-pmu provides a SoC
> specific regmap that can issue a SMC or hypervisor call to write the
> register.
> 
> This approach keeps the SoC complexities out of syscon, but allows common
> drivers such as  syscon-poweroff, syscon-reboot and friends that are used
> by many SoCs already to be re-used.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

Tested-by: Will McVicker <willmcvicker@google.com>

[...]

Thanks Peter! I've tested the patch series on my Pixel 6 Pro and all is working
well. I verified all the modularized drivers load and probe successfully:

root@google-gs:~# lsmod
Module                  Size  Used by
at24                   24576  0
dwc3_exynos            12288  0
i2c_exynos5            28672  0
phy_exynos_ufs         20480  1
ufs_exynos             32768  0
phy_exynos5_usbdrd     36864  2
s3c2410_wdt            24576  0
arm_dsu_pmu            24576  0

Thanks,
Will

