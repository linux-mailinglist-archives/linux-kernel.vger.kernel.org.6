Return-Path: <linux-kernel+bounces-368193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F699A0C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25886B2846B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4675B20B201;
	Wed, 16 Oct 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtSG6KY2"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A120E021;
	Wed, 16 Oct 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088314; cv=none; b=OPdCHpdmAOvLKj3+70QRRIqOlCoubKszvzQeOd3MBb0ck5QF1aJYZaZirdSI1EkS+a+BAKjqiUrPIWMrObFv5aw05OsU+Sy3FnwQvX5dMhpUYhFCPsoJyQB6j6/ONnf1Pt60P/OS7ajGMfg5ARomiYK1Nh3WTap8ZCp4cDv3WSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088314; c=relaxed/simple;
	bh=pwZ1SFatElpp7QliBGqRdyP6wxmrfZVJ8uvKAQDUdVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nl5T9APPTJxt/zEYqdNKpqqw/QfeqvmyPTb1uPhnsvvQ0ycRnWlfSB8LjBRaptBw3ekhUsZHLUspHKp+BbUtzL63oMeGhhoOnLKkpxq7fTfnt/Syx5BT20hcEJSzY+EKdGrZxJqS0rJT7k6zI9g+Ob/XXmdxuIyntX07DioNtx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtSG6KY2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c804409b0so3984185ad.2;
        Wed, 16 Oct 2024 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729088312; x=1729693112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Af30M0prT6OlrSQUfOsmAdCrPRcP2Y7IveJfSJnIm2o=;
        b=KtSG6KY2RFgFL4N3dPIVgDmcjJD7zyNlTdN7mQv6HV4/OMVTTNUwpOWJeoehEXeg8S
         3OAIETUoMCRF2CAz/+/P0Vrmy0U6K/uXOC0huBn7133/ltEhb0mGuD12r7M6s4CYOXzu
         kz3U5uThc3wiy4ZBQYH2ezI7iuZESxkUniyTdvVFdm9VpP8cIFTnXCiC1KW16qyNsh0T
         aJ2YirOZAon0GQEE7kX+Qv6RGXAk5e2Zqwfsp3Tjs4OVkGPg+VgjmNxMEcUKKoStHGsc
         39v6Fyi35PO4g2rQemY3T9yDaZ1+ToZziDuQvz2I5GMDQLSK7LdUaQ3KWdXnsJ3DQ0uN
         aUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729088312; x=1729693112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Af30M0prT6OlrSQUfOsmAdCrPRcP2Y7IveJfSJnIm2o=;
        b=PJpvx/xa6+tvBrVjCd01WIpc9BjMXrAeNDgwISNVJJnyJn3FQUg2Bd4uHQMr0B7+j+
         i6lx2kUwqJpSUKgw0YrrZjV3KzlPIqRe0IbOurT9koyflWug9ZxFmfEiafL4M73Z95o3
         MLfd2leRb+DpcBi9B8sxRiZOb8v0rGHQPQ9X1//8dtFe16a3OuayrmWO20Wux2hlVJjG
         YiTj2njZY3u1/AWijuN4GR7hkCs2HJ+RB2OGmtdMgKii/e2SQMoG1hp4R+lAec88cSWU
         weqfqIFkUcL1hwTWcK4s23g9lhLSMxk32FiXEGyaR+fdqUrRsXZL7TEjMG0mzYg4X/GO
         Tdvw==
X-Forwarded-Encrypted: i=1; AJvYcCWoIYbcv/PhOLX3bdmf6o/joh13XGD0I8p7vdMEr7KeDFzX/7fySZC8kGV7ub/135kP0V3JjUpMcgB6X5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlR6k3eAw/yX0LFTDSOzRE4slLfdqR50GQzVpBZfYnhdWAWo+O
	miXTgVoT1ejnl8Jyjidzy1ue1s7SZjNMqYj1Su+QdhQ/p1pOCliZ
X-Google-Smtp-Source: AGHT+IH9iVpK7A3qTUiEYoH8V+v/cwF0JsTQ+fDSk9MrrZCyfJJb0NjDrrwRBpJHK36Eb3Hs/HrL0g==
X-Received: by 2002:a17:902:d2ce:b0:20c:ee32:7595 with SMTP id d9443c01a7336-20d2fd09bd4mr16204325ad.2.1729088312512;
        Wed, 16 Oct 2024 07:18:32 -0700 (PDT)
Received: from aizome.localdomain ([36.170.32.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804c033sm29057045ad.214.2024.10.16.07.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 07:18:32 -0700 (PDT)
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
Subject: [PATCH v6 4/4] docs/zh_CN: Add a entry in Chinese glossary
Date: Wed, 16 Oct 2024 22:18:01 +0800
Message-Id: <20241016141801.25487-5-zpenya1314@gmail.com>
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

To avoid confusion with the term "entry," the glossary stipulates
that in contexts related to page tables, "page table entry" will be
translated as "页表项," while "entry" will be translated as "表项."

Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
---
 Documentation/translations/zh_CN/glossary.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/translations/zh_CN/glossary.rst b/Documentation/translations/zh_CN/glossary.rst
index 24f094df97cd..5975b0426f3d 100644
--- a/Documentation/translations/zh_CN/glossary.rst
+++ b/Documentation/translations/zh_CN/glossary.rst
@@ -34,3 +34,4 @@
 * semaphores: 信号量。
 * spinlock: 自旋锁。
 * watermark: 水位，一般指页表的消耗水平。
+* PTE: 页表项。（Page Table Entry）
-- 
2.25.1


