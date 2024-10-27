Return-Path: <linux-kernel+bounces-383428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301449B1B8E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 02:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D16282317
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 00:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2675553AC;
	Sun, 27 Oct 2024 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8HC0aPI"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C45684
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729989611; cv=none; b=s2RM4yQ1FHDTzjHBCvILjhyfEb6A98k0NtMP48OoQ4jgkDCivT1UWLpcquwr6QJ0NAZmyqVsxgb88jOLaxXiYSsYthW8nl6Vb6LlVZFB/Jo0It57H9K7vlmuKc3XxOoQagDuBXSlILX5xc9tgw0jg5WSvL3FGGCOino7ARWnnis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729989611; c=relaxed/simple;
	bh=Cl9UtE8OyqoKM+LeMFJhK/rENqv72HttrSABIaMXnN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=olftfwsEaRuOlfKpTFlIfePGre0WqKuahp81HRlAdT1tUDqU49ZTkJzDjqK5hY3d9VYmgiP23hjyeKbuIiUQSafUOF6APoSLM2oI8fItJkR2ywQHBCtgE1aJX6bS2k6rulUaKnHxtzczu2NlDUwTNcgeykzfROJy0ePuAnqccf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8HC0aPI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e625b00bcso2447285b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 17:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729989609; x=1730594409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQJ+pKSjrQb8jSHkxntFhCYwxTGq9B9H91Vh7EbFVag=;
        b=L8HC0aPI39upaltUrRLoR+6vfUwFmWADXsIDpRJMnMGqpJttu6JVesKA3Wz0Q76bP2
         pp0l/EK6+M8bNtxfvJoxqTvYNt/F8uPVyM3pDvLlEbHMbTHPdpmDuzIrilZCw01jrEY4
         mw/c3jVHLoN+6l+itU8X1u3gPN93dWZNIATima5fDQh4UY5qpssCN1Ldo5GFNukLu/Ss
         8JzzviXpFOAtrV6JbLPOZr7bhWpNB2mhj7+jCVavpLBSRTGoHSYHKBRfFUfsEkj5jIxy
         hCoen/UISiF2CS/it+2IeVWSDDYBrOiRWj01kEc8iHNUTtH+8R5VlbxLhSjokE5j6rTJ
         d5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729989609; x=1730594409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQJ+pKSjrQb8jSHkxntFhCYwxTGq9B9H91Vh7EbFVag=;
        b=b4bxEMxS+WxuzBqWd061z4uJ+9DVbBSKL/zv6LgKtqp8YiKV9RkJCKhKy0tCbHt9D3
         CJS+lfU7u0jbtQJHX3aK5ANhui/a+4+PHZdoJmS7MFcMw6rXg5v2KyJhegIOCBZB8dbm
         HLCsD7VIFNDKVJ+n+z+RhwjN45igshpNRuc07D105uvrJt9EmID3O8YRwrqAtbbLltcg
         ixqifiLyDCnSm1xLPdq8BrGXzAgTvHzuPIAwEN2prk4x0ISDhrTJqwHthk3wOTY3RgRo
         7Ls8VkjSJdQqdKFs+CnMex8uoIii7eyLp7E2U1MmFMzmlMRG19OoqA5bkmNZxJ7Ki3UD
         hqRg==
X-Forwarded-Encrypted: i=1; AJvYcCV+NzyyAWrhQeSk3vU+T1e5AqRajFfoY8VdvDZfy8D6qcia/F6F3sGtPXXPnMXJpgV66xM/EkBW7/6MoUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxuskaBSssE2YE3spZsAmgIPvFV9J7YTfJhDEZYcHc3+9fqeM0
	OujFJe9nwB5PJ/5w1FoJPNYFkV0eq8i+vVoUzYoTnkYpKmnKGI7A
X-Google-Smtp-Source: AGHT+IFM8uYnbucK/PBr28FvUa55xwYdVVgS+/GrT3/LD1j4oq34t4XBgJRW0L7+qPXWjBQb1DU7qw==
X-Received: by 2002:a05:6a00:1a88:b0:71e:8023:c718 with SMTP id d2e1a72fcca58-72062fb828bmr6006445b3a.8.1729989608839;
        Sat, 26 Oct 2024 17:40:08 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0a065sm3270329b3a.136.2024.10.26.17.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 17:40:08 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] MAINTAINERS: Add entry for min heap library code
Date: Sun, 27 Oct 2024 08:40:03 +0800
Message-Id: <20241027004003.987934-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new entry in the MAINTAINERS file for the min heap library code,
with myself as the maintainer. I am pleased to take on the
responsibility of maintaining and reviewing patches for this library,
as I am well-acquainted with its details through recent contributions.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a27407950242..aa19dafa7a70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15407,6 +15407,15 @@ F:	arch/arm/boot/dts/marvell/armada-xp-crs326-24g-2s.dts
 F:	arch/arm/boot/dts/marvell/armada-xp-crs328-4c-20s-4s-bit.dts
 F:	arch/arm/boot/dts/marvell/armada-xp-crs328-4c-20s-4s.dts
 
+MIN HEAP
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/core-api/min_heap.rst
+F:	include/linux/min_heap.h
+F:	lib/min_heap.c
+F:	lib/test_min_heap.c
+
 MIPI CCS, SMIA AND SMIA++ IMAGE SENSOR DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
-- 
2.34.1


