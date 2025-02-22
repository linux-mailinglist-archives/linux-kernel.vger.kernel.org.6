Return-Path: <linux-kernel+bounces-527159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B1DA407FD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE147AEC5A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6E620B1FC;
	Sat, 22 Feb 2025 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3EQZFKB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B7620AF82
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224348; cv=none; b=srEck/ajP9uUQUPd7S0gJjSjqGcrWo3y8DKZyw8/vsbzyJCY5aepLdkUl4axtSbreHRqmy3SZUpoJzGJeFMvFVmbpz7P6cQUWNSThoLbcEe0JIUdc4q3s4JF64IRJq27bq76c4gFyjSImVnu8izoSXSKiqy4mi5AJVkXAfMFWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224348; c=relaxed/simple;
	bh=gPRrQJeVCXlOJnPHZ1jVCWa17XfTG/pp0Es1n6IQ+7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVG2Sj8ZMLcaoxzqh7mNWCoU22P9XrAaVnIPInoKbcrWFEvaIduskejaxnGEKZDc5qIhEHnd1zw9099LjfhSaa5XYpZZlyQLn4/ikhib4a/BodS/s6Kqr5mYf3rYKOEZAOstn8JJVQTcmrXddG2XMi40Cpgi8CvWPjjA0zPCXKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3EQZFKB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abad214f9c9so54199666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740224345; x=1740829145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHqWYtyFBm3eO0Y8IspbVVZ2ofwEug+k6Mqw+YANX7k=;
        b=g3EQZFKBDKEdHs4ttKurboVL+KZbCBanDdorLy7k5SkSQTZCMCwakIizj4nUvLJma0
         +OcE+fyE1PPXaMRtZb59ExMbFOleF/eoIuAXl9j0IACvL1jnqinEgRH0H/8Ccu3zixiY
         5JwfyvA6vRhLqzocl0jsaim6YCYpAEYawhwkvDAgyBGrWXqA9VX8q0Vv+J2ArSXgHBEx
         uF1WPJdgSGPW6I8yBf2RUn0tF3NRqvVg1M5bCiuGaeWyNEilp/RoAsQT787J77Vs/Fja
         OcWCKi46HLfUpQ+VAdl6vb3CtthFSA5O9TaKACUTY2Vw/3ES26dlgR/siPSXVW4vq9GQ
         jEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224345; x=1740829145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHqWYtyFBm3eO0Y8IspbVVZ2ofwEug+k6Mqw+YANX7k=;
        b=jxGnepfSFYThQJrUIrW03kdJ7QhRdZNTOg0IYYv95XjU6ETbPvZYxAfvJ8FWt5DLol
         z0pzYskiHFKi/wovPZWx2HdNJfGkIv+CyUno62M+qnmBjdO/2a8Rvb7qipxhsjPjfcMH
         WlkGA4DM/OPjT5eAUgHD0gRDxvnrXtBizTPrODiGIq3k25rV3uahy7NU1w8lnveVAnY2
         uCo2rpr0yMq021sKwr54il27iYQEOR5vQMLJdhGctqqbLKxv4ihmbK1U0sx9AXAw8Lzh
         +234BxWOEG7byHZa7vKSp7RSqfMQPECfr8LcaHMDQs99mIPJCfC0hvOKWM1hGdSVVa7V
         VvAA==
X-Forwarded-Encrypted: i=1; AJvYcCXiQq9C/0uMHrB45T3cC7KTmplu6L/sjzg93iR1aSqqZmCRVJz4EbCCgR8ex18AZHs6pAF8WwglKozzQK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg/y4jZrhhfO0gWh93DC8AGcwi3z/NjNKa8vbog74PmlmCTWEn
	QIQ1joZoQxveB4kRWNhCxiRw/BeSBpxuyEfpwrVLyUYqexQDCJnDe7+Ubi0hu70=
X-Gm-Gg: ASbGncuCexngZPG/Vejp2DaR96C6ct6UUR3vIUIfLv4wscNuSf7I9oOIUQc2/3P/dWb
	7OAK+hTdUwm5ToZ7DDyXtXJmYxe6Z7h7RPrjYuIHEBUR4FyKleusfYHIcYBqxojhnuXXAo6nKEA
	vtz1mWIXaELTiR07ij3iFKxPDfMEO3VDmrrLyy7veimTjC5LEwTwd142lW1Q5NYQYaGP/jNKJ3h
	MOccJZAvD2H7tqC/lXiGZP/Vh9eQCxVxsSyQMUtkOQbhVIVX9WrlrGNlJm0xZo10eJ1XQg3/rsJ
	C4ZdgQOcTgTK5nJLK82RdaTx8M65vDQUUM+SYR1XPexfRMbXKAwy6f+8FgedlI2QhuG3nPjlkPP
	D
X-Google-Smtp-Source: AGHT+IEADqs+izaDN1hPXMaJ1Zk4lygqEDHkwdj7DtAHH3E7GEbPdzWsvTEOd9OEw48mA+XiOWcQqA==
X-Received: by 2002:a17:907:7b8b:b0:aba:6055:9ed1 with SMTP id a640c23a62f3a-abc09a2c559mr257354566b.6.1740224344847;
        Sat, 22 Feb 2025 03:39:04 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9723a559sm1202702066b.96.2025.02.22.03.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:39:04 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 22 Feb 2025 12:38:57 +0100
Subject: [PATCH 1/3] coresight: catu: Constify amba_id table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-coresight-const-arm-id-v1-1-69a377cd098b@linaro.org>
References: <20250222-coresight-const-arm-id-v1-0-69a377cd098b@linaro.org>
In-Reply-To: <20250222-coresight-const-arm-id-v1-0-69a377cd098b@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=818;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=gPRrQJeVCXlOJnPHZ1jVCWa17XfTG/pp0Es1n6IQ+7w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnubdSOKHDbtPKiytMq7VNkehnIP6qq4GF/kE9O
 ziK5nlVetqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7m3UgAKCRDBN2bmhouD
 1ywXD/40O8XwA+NE+t9BlVaXPJJZpnhWfPER7p69opKPzBgBEgPhhAMecsT2PkhDojzqsxC8uEv
 fND8wAAyHimTkBXtWshKusQN7YLyY3z6zGvNnS1c8Br4nZO2SYAD5tbxNiUv0X5Do6wXrgV7lAt
 8BvwDFx+3kDbkvA9jtdt67GT+mNVIsKkf6DbOYCWL2zqa8FQDyS9TwT6D5xnpfnWh6+RjWk6uB5
 poq8pZVkt10R89YCGR5OvkmxRcZk7bPuQnOLwmyhQUkN3ML4vtSOOQlj86vF6vWuYEy8DCcy3Rd
 FFdLgzxuoHDBBAweNx156SeT96ITaLZoWR5DZ4/ea1y3Ax+B3vMpSNLs4iX5H/qpZmtoSw4QHPX
 LhGNZP5ZR2Nz5UVNJAvXJstsq9X5vHsos5ceSp0aBud4bUa8nI8vjCNzMqSk8T8RyfpAy2oDalK
 L/RvaQ9E54P9+I3uDqIfn6rIwMzUD88nZB75P672eneWgpg1g8CRPZeKB68wrzohI7AY0pL6a9/
 MjiRogVa+G7jwxVU9Uc9nN134EqYboUsSIPn1yvSvVmxgjvvqv55cXzGWgqT/X77M3RYZSaB36n
 u46TgGOmJ0RIQBxz+2bjG2+zV63MfIqrhIE6bwmK53ePMmxeJH+tyDVi8bvktYzcgvOUgDrur0r
 vrsgv7SQ7jtbtSA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct amba_id' table is not modified so can be changed to const for
more safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwtracing/coresight/coresight-catu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 275cc0d9f505fb0c1b2847da94fdfd468c49c6c4..947bf6f331f92df6a2e0fa97bdf3b001c7fa9027 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -594,7 +594,7 @@ static void catu_remove(struct amba_device *adev)
 	__catu_remove(&adev->dev);
 }
 
-static struct amba_id catu_ids[] = {
+static const struct amba_id catu_ids[] = {
 	CS_AMBA_ID(0x000bb9ee),
 	{},
 };

-- 
2.43.0


