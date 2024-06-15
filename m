Return-Path: <linux-kernel+bounces-215812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEDE909745
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 11:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBECB224F8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F2B25779;
	Sat, 15 Jun 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXHM2Kfj"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157520B20
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718444060; cv=none; b=ABmaJFH8NBgQjJdvklrL3ghlg/MKRv1QFVjGymMMfWq3zzT5PJGmRmEri6MoZeeQFPb9It9xnBzZFCDiQLsVUn+yHCIVC7SdQRI7juX07HXpoz6ijjJymnxMLYf5DxYagmaQLvvhXgqbuto3D6uyyF7Bx+Pz5qEl/oOEJtg9Yz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718444060; c=relaxed/simple;
	bh=3za2qru6IudAnlvg331Gz6kpAAhoSS3OkP2M4j9O85s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XV5YVmCKxlT17W/svtqTKu14LE7h4F/R4G1A1QL9Hex5KMfbHQpmUqyeTwrBdFnTMes+NtiD5PtcbKby9hA0Tjs/gDbyTb0zAkDYuz7i4kH+Rq2jAfTjMX3fFzuJ1IIY02yLw3u9KhYvShywBY/yJv+Pdh0DiDYun6XJ8IwEVYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MXHM2Kfj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f176c5c10so351378566b.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718444056; x=1719048856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfZBpVGHvd72Jhxh5IFoFhgV44PvrjVT+p8ObH39azY=;
        b=MXHM2Kfj5LOnLun4yzQTIVSjarBzirv3cZ2Bx85qDfdeXL9ofO3+T16Xt3V8Cvce47
         xhpTDGMblIvefVvT4JnRveX0+Xc1odQm1eBKv91JCXj9ujUe+B0+mul9i+BPR5maltct
         /m85tjihdQj/3loX6zjWPrX4Fe3+a6jzC4L1V1KG2R0ZfZzHqS4iB+BRjEOfqKCgOyAl
         sSzavHgc7X42WCu++fmMFxCkMC1lADY8TYEbV+UDidlPU7VYX4HByQzNt3kro40Okdgz
         dAqiGN7ufdvt0/BVTp0J2EC6jQQHHmAyFkW4f3PNvN/aR1hPag1uAqyv68Lfxk9h6x7X
         Gyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718444056; x=1719048856;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfZBpVGHvd72Jhxh5IFoFhgV44PvrjVT+p8ObH39azY=;
        b=Id2+r33tLw87VZLXRwYLx7xHmY1lkslac1rLDfFSdSHdghqBIvjJPKL12iD+ZKVW8x
         FeoyxC85rSipYzvPInNTdICQAdvGtTudbZBMwo2Rtcafsdtok8oITeBHubg9Lqwqgucu
         XLpb8fB9D+jLrmqTzqpHwTbrUEyOSyujVilWnr46d0+lD//aAGgcttwhjcn3Hsi5CHtC
         3HfMssx9jJ4bgyq6At4KirRCpKTJEPkD+7S7gRU4h8Mu16D8ol+HUskcDbwFn7HHND8B
         JE79iHgWz/A3B38cWp9l55nqQukv3JZqYYjc1JCgW3pv4UBiybXptAeZCqcS/nMTaUnr
         RBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3IFY0eGSRP4F0RND7I0h7bUAu6rMzZFrr+qyj3k3WUjWuL9ydngrQmbQ0jyOFE3x7T0lEenRuLfb143HALWtlD3CDqP3jfib93/0C
X-Gm-Message-State: AOJu0Yyhw7MENNo5atvnd1ZDLs6ia8oCmdOIiJy8lPZ8ioqL7YtjrmjD
	VspJ+7t4+vbDtZUFLn1URDn0TBmFmZ2PIGN6K7oYmz0p/sHfZreg85mx++OlKj0=
X-Google-Smtp-Source: AGHT+IEtFhJEkGhaxkm/K+KEuOma7XVKbE3HuYkNhE3LESdF3P5GzSShCp9aDgvx0t1/jk5PuH9Udg==
X-Received: by 2002:a17:906:bccf:b0:a6e:7e1f:592f with SMTP id a640c23a62f3a-a6f60d4277cmr311524766b.39.1718444055716;
        Sat, 15 Jun 2024 02:34:15 -0700 (PDT)
Received: from [127.0.1.1] ([78.10.206.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3fb9sm278588966b.30.2024.06.15.02.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 02:34:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240611-gs101-dts-cleanup-v1-1-877358cd6536@linaro.org>
References: <20240611-gs101-dts-cleanup-v1-1-877358cd6536@linaro.org>
Subject: Re: [PATCH] arm64: dts: exynos: gs101: reorder properties as per
 guidelines
Message-Id: <171844405455.10532.15057026872451571740.b4-ty@linaro.org>
Date: Sat, 15 Jun 2024 11:34:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Tue, 11 Jun 2024 17:07:59 +0100, André Draszik wrote:
> * 'interrupts' & 'cpus' & 'clocks' are standard/common properties as
>   per the Devicetree Sources (DTS) Coding Style and therefore should be
>   sorted alphabetically within the standard/common section
> * vendor properties should be last
> * reg / ranges should be 2nd/3rd (after compatible)
> * status should be last
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: exynos: gs101: reorder properties as per guidelines
      https://git.kernel.org/krzk/linux/c/7872f905b246982296d7833fe820f4ba5862cefb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


