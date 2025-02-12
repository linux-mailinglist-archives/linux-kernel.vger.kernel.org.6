Return-Path: <linux-kernel+bounces-510833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE08A322A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D52166C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FD42066D9;
	Wed, 12 Feb 2025 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFzKYLQO"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A12066DD;
	Wed, 12 Feb 2025 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353357; cv=none; b=Zh/Z9/wzIgOPFShFbrVMbQ/xB0qYlBWJdjP3QlYAKLeatem4S1G93Ido93SLDcD3u917WNli/RczmoizZMbYILNwiC0OJVSivr7AV36qUa2RHE315Kgs/lcWBzu9rML+tWtR8V9U+Q5S+0qHH9n18X4zus3qVLMqNvbp1zHRepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353357; c=relaxed/simple;
	bh=ylBFuo1zwM8RrVkKsFCFYgaQTBlPg2VK8bGbOHE7mVk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnyGNbKlI5wvhrOBatLUwusSpLGm8QjwlVDWEledGfH++dMqU6YyeJ+LeHQMMYpwBIGsmI1yR2ckCWoJNtSusKzP6IcLruNDKWCsw6VGza+3rwzK1o4Zzgu72ptq8kuNQMpfmloVhDop13iqSkix6AjErCDigVtw2KR1kTqHlxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFzKYLQO; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f3c0abde9eso722034b6e.1;
        Wed, 12 Feb 2025 01:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739353354; x=1739958154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BDt179jsPGPQXJw6cCKRg6ipVwilMKrhen68cQV3C0=;
        b=lFzKYLQOhezEkZCNI/6uZEGIC4KQ43Oipad8f5VcILaGhGOmbI48TZ25TzdA8y4Qyi
         hpquxDSsTuzIjxiHrYr8qZaOFHsIo2yblru0jCjMBxf6TS3m1UE0TxPi5Nh1PfXWThBf
         2mfZ1sF+2coGY32u1DaGZU/dlw8ftj6dvIweBNfTa7U3Rrad4a6oT9VgyFvIvAIGa0+d
         3tkLJQZm4xBENpV4lOeacUwdqGkWai0YE1caD9JeKvTbYe8XvpatSRtuQIUAFy7jw9em
         XwBkg+KK687hTiiuMB1dePxQZG7JNPJYVyM2qnWoQ1UrEZAcyO2D4F38gMxHC02JeRkS
         ZGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739353354; x=1739958154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BDt179jsPGPQXJw6cCKRg6ipVwilMKrhen68cQV3C0=;
        b=ZpTQasEX/CsqExFvlFIaAepKTypEu7Vtqpw1uiKVpoKombtGk80qZnJaPpEumq/4ZY
         cZJfKPcCY450VswKo680OCvBlNKCSZl9oP33a8qR99moLe0DRAlpb4Qb61diHOoryb6P
         QvHt707sAaEbyHktRpsRJMDedxoJFmAZ7Mi06gkyMJK3Xv6pn9apejL0m+k69+WOjks4
         7v9EP7DIXV/awuSMEX08XMpKgybM3f+Cy8+tvgFoIeo0Hb1t2CUHA9c10+xI8z5SJaCB
         uwELbfv8ws+ppRCgIIlbwmsNQ04xjKPBv38MC/mLLQJY3/aTYM8sDZRv0uXYgXl9/DTd
         URWA==
X-Forwarded-Encrypted: i=1; AJvYcCUtzr3UkctPJBc4ijarNd6YzRW2PjwIXp2LqtslDm6R9lpzd5koptxbfyMcqlUKcw42mXBYbbHTc5zzo3YN@vger.kernel.org, AJvYcCXZUOf1FJNinXA+xTRAVUS1JMKvwHqB3mBjAFaTwWERER/1G30zvtFL8Aseb6J5W8TVlH7ylRyjCQro@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwy6AgteAg4xslIPysvjw59Zh3IpoKELfyD9zDK5sd9ueIlhw
	N+sReK7jUn1G/TPwBUNOqtXfrdJKmB21KVZdtRGWKU1K5JwJmUJ+
X-Gm-Gg: ASbGnctjYCRN8cQE1mlnt2jwNov19FwuzTz0A5xDFaJxkuY8zC/ww/vtUdbfm8UGwgW
	pmCriDIszY0arCs+68ITGI85ipTqoihnHbA198hnf4KclrDFQltavXjBOZXkQHJZPrkHJ3AeKPN
	4PZSHJfYjl6ZlSb/D+qPxB6QQZx8hazGXTRQp/eK3CbQgr9cWs5TGwZ0uV6Al7aV3cxWLJvRsfA
	f/o6LijfDr9dlxiFqJ3n8foEBq6tnJd9oIMtmHvoFRZsrWmGTe6BhbgMKVeesSMK6VcrNDOapWh
	us7KzUq+cXOvRQTCzUQ/gj8Zvg==
X-Google-Smtp-Source: AGHT+IEy/UxKhE92PT2Nyvo9fgnKrPBECelMkTakVs7vyrkYcrqQXDdT71oXo3Zyrau9+iD0WHIA7g==
X-Received: by 2002:a05:6808:2e85:b0:3f3:c9fe:7fa4 with SMTP id 5614622812f47-3f3cd60df50mr2191427b6e.19.1739353353785;
        Wed, 12 Feb 2025 01:42:33 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726f2065dcfsm819321a34.34.2025.02.12.01.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:42:32 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com,
	inochiama@gmail.com,
	sophgo@lists.linux.dev
Subject: [PATCH 2/2] riscv: sophgo: dts: add cooling maps for Milk-V Pioneer
Date: Wed, 12 Feb 2025 17:42:23 +0800
Message-Id: <5a36a2784d97ed7b1e06777cb0c3c14fe9185e99.1739351437.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739351437.git.unicorn_wang@outlook.com>
References: <cover.1739351437.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

The normal operating temperature range of SG2042 is -20 degrees
Celsius ~ 85 degrees Celsius.

Simultaneously monitor soc temperature and board temperature to
improve redundancy and safety.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 74c997ed8283..34645a5f6038 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -111,6 +111,28 @@ soc_hot: soc-hot {
 					type = "hot";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&soc_active1>;
+					cooling-device = <&pwmfan 0 1>;
+				};
+
+				map1 {
+					trip = <&soc_active2>;
+					cooling-device = <&pwmfan 1 2>;
+				};
+
+				map2 {
+					trip = <&soc_active3>;
+					cooling-device = <&pwmfan 2 3>;
+				};
+
+				map3 {
+					trip = <&soc_hot>;
+					cooling-device = <&pwmfan 3 4>;
+				};
+			};
 		};
 
 		board-thermal {
@@ -125,6 +147,13 @@ board_active: board-active {
 					type = "active";
 				};
 			};
+
+			cooling-maps {
+				map4 {
+					trip = <&board_active>;
+					cooling-device = <&pwmfan 3 4>;
+				};
+			};
 		};
 	};
 };
-- 
2.34.1


