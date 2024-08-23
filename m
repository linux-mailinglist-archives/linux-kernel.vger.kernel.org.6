Return-Path: <linux-kernel+bounces-298954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0335A95CE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364171C212BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F79187875;
	Fri, 23 Aug 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vx6NtFDd"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70334430
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420496; cv=none; b=tiiS85X3GUL5gmLeRFeehhHgC2DM5C4e/pCzWO41SvwpWGLbP7X/b69UhKRFZwKdhkD/10/zsQ/NMzyH0BkKd0PXvXPioJOfYWgpGjEIWw1RJnj2oUgwLd03E+KyPK11hQHIVVYyseS4RDVA5rR2kZWVUi+vjAQIY7A1FMMlIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420496; c=relaxed/simple;
	bh=PJaIxgOdV8WYNarq4L6gg4MyoJXnyxUqZQl5qVXDwb8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i/IwC1QrO0k05+qrl7dVY9q6zCAJceC+LGs6MK/o0KgsBsFLkoEldwhJtpT8/vlT+Vv1qu8ffsyEBLcjZOMY7Kvt3hk/YKEong5TxWyJOmXBhp+fcbqe4zVd14AViTXFXi/WE2DL3K4r4JNvdD9/ZuvoI5bdQKPwEPQ4mZQ3dGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vx6NtFDd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-371c5cbc7c8so266734f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724420493; x=1725025293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLXphlx4Jr/wlEp6hPPEJ9LkWbBrVmLQW+HX4IXSgtQ=;
        b=vx6NtFDdT7J6aB0reF6ZnPCxLExWkot4DYQHlXnzCfDs3MjUSfX1Wi8s+4A0uovFkm
         DRZRa3b+OLOAvuqucqPWYJyc1jvis7+IC3QMyCEMELBYi9uQ8zz2guVGbmt8VMmL+7+v
         RyauLWsmFBAxs4X1LMZexMQSVyFrb5ARTOwJoArDUYn4iqChKg/FAIQDDZnpKvj+RRLl
         xh8vJwlKZjOCZZ5oJAvP8bmhma1ZrfG65ITUJd9Hap1S1H6G2gc/64J38pHqBAmYQre0
         QDUYNHfv4ypsvRHpZg3NAOCwLf3TAdgu318nKgcGVA9AhbtgzJMfROJVdoS373AE7dos
         C78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724420493; x=1725025293;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLXphlx4Jr/wlEp6hPPEJ9LkWbBrVmLQW+HX4IXSgtQ=;
        b=JZ4IXBlyK//DRdKt4z3PQOn2IfqjN474YCCzypauZrS2BSShiTeyHoD8smbpY8hwRN
         Lp02zjwNL7pvl1z0taG989Z9HiKqK84v0Bb2gJGO8HsXD7tmq1q6JTuOlli4+0u7dcfj
         VWd6Q92x9lsQuQexX1S8eBzrMyHjB/x29s6AmBWJjGHJjN+YDrMQo+ZMIZm62nn9+WwK
         7oVKovuolUW08AcKLNSzLKGnFbfhc0yrtWy+kPpkOCRU/8FwSXWvnugB1qRbsJ5U1StV
         Ygkbl5xcKZFeFlUtQn+THohlkXTEHmg9W3wtzvIHrKktD+Z0Zhw3xWHq3yIPojfwbF5w
         7wIA==
X-Forwarded-Encrypted: i=1; AJvYcCWkgIq2qvVTL2i2dwIM/tZGAoKVW9KGc8mYi/2FSpIJa7xmxPCUUHvgI6HGN1kr+lY1fE0pzT/2fLhpBH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Sh6cknFBRWveB/XWzP1r9d5mJvz4p8O/iQmRzHk9F6yr0UbQ
	DdzBWtmL4m/2jnI5JvpbR4gq3JKqxWCAkDo8hVPfeJ/f13Nmn8JYWrlRxRD12co=
X-Google-Smtp-Source: AGHT+IFAy5TWXluGypKumB4L46fCMYjfuXS/7gcYMZMUIjnPaNZc5SXlvykLSSlmd7HczFCeAQnMLg==
X-Received: by 2002:a5d:6c6f:0:b0:368:4e31:7735 with SMTP id ffacd0b85a97d-3731191ea94mr885503f8f.9.1724420493063;
        Fri, 23 Aug 2024 06:41:33 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef81777sm95905955e9.27.2024.08.23.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:41:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, s.nawrocki@samsung.com, linus.walleij@linaro.org, 
 Shen Lichuan <shenlichuan@vivo.com>
Cc: alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
In-Reply-To: <20240823114441.50648-1-shenlichuan@vivo.com>
References: <20240823114441.50648-1-shenlichuan@vivo.com>
Subject: Re: [PATCH v2] drivers: pinctrl: samsung: Use kmemdup_array
 instead of kmemdup for multiple allocation
Message-Id: <172442049174.83535.13112470931201037762.b4-ty@linaro.org>
Date: Fri, 23 Aug 2024 15:41:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 23 Aug 2024 19:44:41 +0800, Shen Lichuan wrote:
> Let the kmemdup_array() take care about multiplication
> and possible overflows.
> 
> Using kmemdup_array() is more appropriate and makes the code
> easier to audit.
> 
> 
> [...]

Applied, thanks!

[1/1] drivers: pinctrl: samsung: Use kmemdup_array instead of kmemdup for multiple allocation
      https://git.kernel.org/pinctrl/samsung/c/39dbbd4e6778ac5580313ba34409855250633c61

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


