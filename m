Return-Path: <linux-kernel+bounces-527165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33FBA40802
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2E47027A9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65CC20AF67;
	Sat, 22 Feb 2025 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1whvBpF"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA02080D7
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224515; cv=none; b=iqufv325N51oTxpWybQHStj+AFZ1jbUM08PZbhsr3bZbTDnM9yDkkZ9zTKAhqCQfga35ur4DppJ2aFe/WmQkiH7BzXSvu0Z/gkspnf5w2os1frZyrvHcjKulYAq7oY8alQpySR6MKue1Zowy1yduFiwy6tpPCNpuFOWQ3ywK08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224515; c=relaxed/simple;
	bh=MlzLoJn0hI4TnuOde5+xu8VG/g5LzpLWIDWX+sOucWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMKRMYHDXBfep5VwV67nGETCGw67vjZKBTDYMFj98s+kMck9KgINVytdBP48fjI26kowHQRTJ7JOZKC7CR5pD3QJbvxPA3jx72s03Rj5NshqwOuGF2pRjetI5CYsvqyL7Dve6+0eM0LpmBqMaD2dZ7F0RNg8i5btmZrAf+hcoPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g1whvBpF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dc5a32c313so568268a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740224512; x=1740829312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNjfWzQZO+4PAOyGjW6OluToh2XJFJIsJj/h61r4mUk=;
        b=g1whvBpFuaUVYYkGSAsVt33qU03lMYI6DVekCuSHQ5Wa0gaZ7O3W3ygY3ibK8lhUK8
         inqnuvoekYKJh8Mfhlx0bYF9Yo7aOo4bOA0zhIWneruiH7Gp56gjHK6+DhSClPrcuPP1
         3hOumiDF+nRT1v4vfY4XilR6lTkuY5Axw4FT4GY5+eyfoTvFF915UCoC051/igj5urHv
         +NyHtEuL5O0WKN3DdtV1+4UeRCPObWRuXTB7OO9kowttysz8uCDWK9rtDdnt+BVOphTF
         qwhfYIXSE2ycnzIZMaEQ1YA8KP2L3Uelt+/yskU4fSTjfCHiwOdW6j5z6+/vvJgJGmYu
         fsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224512; x=1740829312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNjfWzQZO+4PAOyGjW6OluToh2XJFJIsJj/h61r4mUk=;
        b=csfL4Lx1VmqQHQH5Q1NH7/WaleD1plnAow9yCwZ3q/vD52SxgmzSMuyCSBsi7hCYIY
         50JTY6bgIAOUBKq0QeKgIAUXpSoGNF0/dx2z7A2J4Bodv47BCI/kJ3q7uOyZxT9EYh1r
         rwO+LYCRYpeGtCAbg9vJDEPiMwAzDxbxpRA8nuc/uoXbfHK9u40ewWLuxdBxMECy/lHd
         Qhi+HnDXgRpjuTHP8ZpCMM/9Ro1JVeb0IAE5HR55LRMH6DKGpGs5a78f1yxzEAe0TkEd
         dtGfGQHVXhskCbZbHXGl6vShHIjCJOMQ8fzpZLSEQBFdrhQ8eGK7GsYfuF0zkYHL2thX
         4E3w==
X-Forwarded-Encrypted: i=1; AJvYcCUbXaqru+So16vq1lomUi9Vd1wfU3elLTfHDWBPrwaAXcJoMiDa3rLtm7sWlM8iLG+cfYqNHC4vj1AQ56M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCB6b1Zj2e9SLfFV1pCxlTMtdVaLSNFOU8DxSEJqSMBf6e9dBs
	U7IuzFXWqYfaB7B/r7RsP5unJGkzlF29eB+LzNUUW/9at9UNoF6JSdBqrFHxEOg=
X-Gm-Gg: ASbGncuYJt5lULMohhaFfcCrRWjQgB9kg7AY9h2Ox3aTUZ+BL9YPm0cOH+z+nLGdnkw
	iBCUj4CidtoicQlAhXL/AnvOfFxYt1CU5dAFy5zrWhH09TlStSXMSDbCwyOeeJCCjUREobrk6dd
	RPS4GQja6xaHjrvQfPPkhYzYq2nD0Zx/jJGhTFni9HV9agRDFmG09F3paB7d2nAh/NhletQbJOW
	tzs/1cl6mHBgEL6eSyZ3HZnV9V6/Ir7oOC/VHCIT5KXwEyJP9jNTe/ou/0juU7lu+z4bZJY9xnN
	i4Q6ItO8mqgWVRMIVihGyMYXGa3+rFUWzwq2tbiWRNN6dOsOBAs6GJl2osYnOXIKP9FnR4B47eg
	=
X-Google-Smtp-Source: AGHT+IFcQvTgkA1f2hC6rhrOt+z8Rgj5dYf0GvHomaCCODgthYe9l7spIG6OTlB1RUvFoiqx9sQzmg==
X-Received: by 2002:a17:906:4fd5:b0:ab7:82a7:bb1f with SMTP id a640c23a62f3a-abc09bed0bbmr266509166b.10.1740224511727;
        Sat, 22 Feb 2025 03:41:51 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5337634bsm1852663066b.91.2025.02.22.03.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:41:51 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] rtc: pl030: Constify amba_id table
Date: Sat, 22 Feb 2025 12:41:46 +0100
Message-ID: <20250222114146.162835-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250222114146.162835-1-krzysztof.kozlowski@linaro.org>
References: <20250222114146.162835-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct amba_id' table is not modified so can be changed to const for
more safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rtc/rtc-pl030.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index 39038c0754ee..1326f310bf93 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -148,7 +148,7 @@ static void pl030_remove(struct amba_device *dev)
 	amba_release_regions(dev);
 }
 
-static struct amba_id pl030_ids[] = {
+static const struct amba_id pl030_ids[] = {
 	{
 		.id	= 0x00041030,
 		.mask	= 0x000fffff,
-- 
2.43.0


