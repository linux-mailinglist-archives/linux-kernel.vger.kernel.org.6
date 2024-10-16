Return-Path: <linux-kernel+bounces-368192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AF69A0C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8791F2451D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FA6209F25;
	Wed, 16 Oct 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3WG0IhT"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE920E007;
	Wed, 16 Oct 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088310; cv=none; b=rh6TDG5rHro5E3w6L81OYlJddGyY1tyrIr24LShoGDtR78XUoIw+I8+tpfukzYGpQR5Xy7sKYKFDpf1URKQXFbrRxP+UYU4E0S/pDz1MQ3LqGhnzWP90Y3pQc0niJK0Ejb6AuNGVTUlmYK7dRxh//Y0jEO815GmYeszWL5/PwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088310; c=relaxed/simple;
	bh=bW/5USlzxQSQRe1vRIFyfk9oRfm1AzJH2gOiS1ib34Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avd567mMJW35ZUh+VjJNZwAMO6S3CrsIU8SJ89Zlccoiy0voPkEzpcFCzL0feDfj2N9bruhp23GQTpPMUzKDLyrZmCdaQ3mV4IA7k8YKX4KijH4P2wnwZQXDcOwsp5Jf5/tZOQ0TscnIAMk9cU7qtDDlsLtTfux+8s6iJAUeGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3WG0IhT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cb14ed25fso3187895ad.1;
        Wed, 16 Oct 2024 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729088308; x=1729693108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzbKH9K4OSmznApbZG3tMFshW4lu/LSxQy6YojeRnGs=;
        b=d3WG0IhTc1Hn14N8K+3P1XUC9qfEx7rO7mx36r9gIhUgvoXzsAutUFVE+WbI636J0A
         xrhck/ETdx9kovhBn1C+/yOv1AK5mSJJJ41X7IZpGRbuWrHTMEhNyd3UUugvXg2MeCoq
         LMywdGHsI2Y9MzMlRI9o/CknXsqj6cDo6S1cNsX++XMRIj4Myje+j8JT9/m70F0y7FJ2
         Usjvx4Gs1iFm3OYaoM+p/uoUmUVIOTqCcFd4D1oYislKEFCcSyeQ05QFoHuxuI3kt9cG
         UjgEgmcvZGGQc+Nw2KYHvvfYxIttaWnooZxfO/WMlwjB7pRaUoaJuKeuDrKpPU7zLsSL
         UUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729088308; x=1729693108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzbKH9K4OSmznApbZG3tMFshW4lu/LSxQy6YojeRnGs=;
        b=F10aaybV+8TOLwK8FHogqy3eMngVxqPDFLTy6QBHwiWZTTHZb8k1PNyL5dMeqcyuaY
         RRGBmcplxPw5Ui1XmjqeAYcwWosB9C2VMtMEe9O8pWVUkkQ9wNYZruNsHey7sysBwDx9
         mBr1EIKU+mx+4lXcvVsyjUMnSW3chXqy3NddlsOvbOXcyvxh7uYhFmUDbQKsTq4q1nfr
         p4BpD06b4JyKT+3BuQyn3EFDZm8RzkErZSC1Hkx07lnYkNFhN/6XRJ85uWkQ963cq/WX
         wE2KbWS2XKduK4Wx1p+zuxNY8FwDDUBbpVpo3EgZSHkt9f61MaI9OMdPriixvSOLdIGF
         tkUA==
X-Forwarded-Encrypted: i=1; AJvYcCXashsLT5fcApzl4MuSZRxG7DkDB1IW5n1g0Dlie6oKUVw/MCstwO37awqWE27RAUchpnuK4UZ6aQ84nlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ6Zo228w8yfhbEfT6Bd0mPUTGtmnyW0AHeYTcHIMGfKVhVSgf
	JaXSb90MuCuhwdta/XvNJmV6dgIUHKvv9Voo/FiyvxjW7paVKASA
X-Google-Smtp-Source: AGHT+IH+KZm9Pe6ua0+iqyKqFal5/hjF+XCqnPEf2HZCDDAoRiklbZBRRsx0CnrvJQpUvicWceYr8g==
X-Received: by 2002:a17:902:ecc6:b0:20c:e250:d4e with SMTP id d9443c01a7336-20ce2500e58mr69899305ad.9.1729088308547;
        Wed, 16 Oct 2024 07:18:28 -0700 (PDT)
Received: from aizome.localdomain ([36.170.32.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804c033sm29057045ad.214.2024.10.16.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 07:18:28 -0700 (PDT)
From: Pengyu Zhang <zpenya1314@gmail.com>
To: alexs@kernel.org,
	siyanteng@loongson.cn,
	corbet@lwn.net,
	seakeel@gmail.com,
	si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaxin_wang_uestc@163.com,
	zenghui.yu@linux.dev,
	Pengyu Zhang <zpenya1314@gmail.com>
Subject: [PATCH v6 3/4] Docs/zh_CN: Fix the pfn calculation error in page_tables.rst
Date: Wed, 16 Oct 2024 22:18:00 +0800
Message-Id: <20241016141801.25487-4-zpenya1314@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016141801.25487-1-zpenya1314@gmail.com>
References: <20241016141801.25487-1-zpenya1314@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Synchronize the changes of origin document to fix the pfn value.

Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
---
v5->v6:no changed
 Documentation/translations/zh_CN/mm/page_tables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/mm/page_tables.rst b/Documentation/translations/zh_CN/mm/page_tables.rst
index eac0f93070d9..c9f750fc5298 100644
--- a/Documentation/translations/zh_CN/mm/page_tables.rst
+++ b/Documentation/translations/zh_CN/mm/page_tables.rst
@@ -32,7 +32,7 @@ Linux 将页表定义为一个分级结构，目前有五级。对于支持的
 在页粒度为 4KB 且地址范围为32位的情况下，pfn 0 对应地址0x00000000，pfn 1 对应
 地址0x00001000，pfn 2 对应地址 0x00002000，以此类推，直到 pfn 0xfffff 对应
 0xfffff000。如果页粒度为 16KB，则 pfn 分别对应地址 0x00004000、0x00008000
-... 0xffffc000，pfn 的范围从 0 到 0x3fffff。
+... 0xffffc000，pfn 的范围从 0 到 0x3ffff。
 
 如你所见，对于 4KB 页面粒度，页基址使用地址的 12-31 位，这就是为什么在这种情况下
 `PAGE_SHIFT` 被定义为 12，并且 `PAGE_SIZE` 通常由页偏移定义，为 `(1 << PAGE_SHIFT)`。
-- 
2.25.1


