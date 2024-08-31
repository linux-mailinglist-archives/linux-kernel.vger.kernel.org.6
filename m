Return-Path: <linux-kernel+bounces-309702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240F4966F74
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD24B21A42
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B13613BC02;
	Sat, 31 Aug 2024 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+Mduk8Y"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303020DC4
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725083134; cv=none; b=MDWs4TePcKJ+8CvI9obG4Mdg187rbsf0Zh1fNTfw0VV/0WRzGzREVcn4vIfIYTi1E5Ut0aeof+MSKAUc9x7k3qvHKeQBdxuG48mXQl2+1D/6Cjf8W7obf4urAg7aAV676+p/hM1zoXdye5/dFL26nigpgrhuusmix0j1qwCqhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725083134; c=relaxed/simple;
	bh=TyuAkbB/j5TL19NdlwHMd+78FMaqJRnpoTf3HZhi2DE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dfyvEtm8MGH0mBs5pn/3bCaVa6KKSUsQeAGKQc9pCfv9Vtp6efj1OiKOBWqO0fg7itpLRHy9qo1RTUMYZaZPaijeog6J9fcClBKZIaMi3+/t1kz4BQo07t4N08RcOpq1uMHHvYtifddZQ/YoYmOoEng8++G2mwnH9Fa2l8vOSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M+Mduk8Y; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bbd555541so1593685e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 22:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725083131; x=1725687931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrXZso5Gm2mzlfd850rrfZ2B11di6r9bUJl1cxGvq74=;
        b=M+Mduk8Y4JQpgSghqiD8tqu5uwI+7R+U6aqgDKeTgrnpD0ofNPYbZVO+oDJA7gM+o0
         TTRbJFbSIbJjI0b50ZNU7PEHRgOITBZv4GCWjt8ju5uW8qyLal0ElN7IKT9O/m0dMUIn
         c0HW/lG7U5W9Y5IWf70P/LI15l3DMncCyJJ5GSTXYbaAuIpBOhDBa1BsYGyryticzNr2
         ThnlfKem5i5mZ5H/tKW99CiB76ih+WUNE4dluswQ2qN+5eKN9/1K3euYnelMhA3ox0cr
         Lj370Xm/i+MlRhtDkJLA8SSrpejzp0d8hXBbanJLs1ZXDa1xtBNKb39lCO18c+BEu9W9
         s5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725083131; x=1725687931;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrXZso5Gm2mzlfd850rrfZ2B11di6r9bUJl1cxGvq74=;
        b=EXS5RJN0w06+RiwcIzRUfyqRsTP+5VCH9zeAnWSAdQ+TCVdDdqRGKd0rGwWFGYe8Mz
         lV9AC4RcM3g4MxyVQqXBecwAw7C/6yH/RvfWZcjY4eFSWqlrh2OzWIfEXpMDOaTUNKPG
         6efXKzrndBDNQRzmYmVz6ryDLOCeZe/jvyHhycwZyFNB2T7HvrBCTPufXL8u7wHYJ5IL
         ipYaBcG9Vs++GzZL9tSKroLVUdeDdLw1SndISMHd+zvPw3bFOuwEbjLjkMLlL8DO6SVr
         ucPH5IIC76nzK8HuXcu4Q7RSJ/P0ezc3j+PNgen89n/sjK8i8VVUsp7eR8GW526OrWTx
         RVPA==
X-Forwarded-Encrypted: i=1; AJvYcCXfUb6BA86W5vlYXcobNEq8q8KiMsEZBNm8PN4nAdB2m0X20jJxJ8POOA7lwA1znTYvdCyuS2z50p5MJr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytn0EddcFQfh+5PXJFvbkc2F0YVao/KaSLNkIXFNStes8YZ8vk
	DQcwiKoErhsRYlVlY/Ot1Us+EY6tk8f4QRjZK+U/8Jf5yinmnCCOJ/N9wgLgD/k=
X-Google-Smtp-Source: AGHT+IEkllVc8bvcY+xECeoK/LuLjbTAQMCJbR0RmXVX6O+O/vU9mX0Apct+rKZGiiFIvuoDdZKx/A==
X-Received: by 2002:a05:6000:4010:b0:367:2da6:aa1b with SMTP id ffacd0b85a97d-374a9644d00mr1630307f8f.7.1725083130885;
        Fri, 30 Aug 2024 22:45:30 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33b41sm64985405e9.40.2024.08.30.22.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 22:45:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vladimir Zapolskiy <vz@mleia.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
In-Reply-To: <20240825135001.48963-1-krzysztof.kozlowski@linaro.org>
References: <20240825135001.48963-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] memory: pl172: simplify releasing AMBA regions
 with devm
Message-Id: <172508312949.6769.12439040744745378226.b4-ty@linaro.org>
Date: Sat, 31 Aug 2024 07:45:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Sun, 25 Aug 2024 15:50:00 +0200, Krzysztof Kozlowski wrote:
> Use devm_add_action_or_reset() and dev_err_probe() to make the probe()
> error handling simpler around amba_release_regions() cleanup.  This
> allows to drop the remove() callback entirely.
> 
> 

Applied, thanks!

[1/2] memory: pl172: simplify releasing AMBA regions with devm
      https://git.kernel.org/krzk/linux-mem-ctrl/c/331b8a963137d182248599d500edd9b4a3783db5
[2/2] memory: pl353-smc: simplify with scoped for each OF child loop
      https://git.kernel.org/krzk/linux-mem-ctrl/c/32960b4f25c248f13758b8bbe6cc4260828442a1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


