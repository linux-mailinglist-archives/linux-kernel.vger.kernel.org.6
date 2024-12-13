Return-Path: <linux-kernel+bounces-444401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0469F062D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89937285907
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C80B192D9D;
	Fri, 13 Dec 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bl49EiLE"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A47DA8C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077841; cv=none; b=qfcKL07GnFtBD7QFTRFnztr6kF+G0rMSP72SdgyEOCydW6igo4xWVh5aV4+fiwtlsy6lG5qgJnF4wxLAY40VSDCKfNEjERhUMfudmP9dZ4oHuNXnzJ/lwveXtz6mlx+8oqbjF199x/kzqbKF08xB29ediBIL7KqORdBJEkHOugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077841; c=relaxed/simple;
	bh=vFtiKg5oInJfRfvjoGCgWCYLLTho2gqfTWCjTVwo/1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iXI6xESPR18HgaIA9CmnEzYsZIAmK6IO2XyZDQKbubdPUDv11SierYt+VB4K8wE2wjP8pSBU1KJa+tNJ65/sg+wPEeoPXJvrxr3uvlx7gTUdMguI/fxdOTAJfxjBCIWTT8qzzY8T6fqdq6Gnms/KJbJ8I2Ihj4VRz+FyGXmT1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bl49EiLE; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-728ec840a8aso1707970b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734077839; x=1734682639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+aW5Mr9qE0qfjhgTO9mJhgzzfKvLM/ZWs/peRYXQh9c=;
        b=bl49EiLEvhD5tpYgasgXyvGP5A0BoiZ6ZYipuHNSrmf/qi9o1CB+Dg+5IXBwtIQGme
         RNuxF0GLO5saZGQnwxjNNmZRZHt7UpWbfQ1KKGrvMd1TuP24fwh6ICkPH8Chpt6WxZkO
         CO6CmosmGL5kHiKpTmkfPpG+Q1sZd/+ypgS3zR0myZLe4YCMAGDhKLEd2E+vEsUA+9X4
         ZXqjcnIW3gR6HreX1SDuAVYreQmxDcb5DedlRvl/88p8piD3ifsAJiMHR2nANdFXKTAZ
         B8hfc6Qiug4iWTJThNIPbDZtEu0PatlUQQ/H7MQTB+kb0DFe+0Trf3SQdaJrGtbCURvw
         j/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734077839; x=1734682639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aW5Mr9qE0qfjhgTO9mJhgzzfKvLM/ZWs/peRYXQh9c=;
        b=kcPKZU9ddjvTDFPXhDymkLre69TYwsQ3yhU2fP6/AgrOve435Abnun8wm5wNY9jQXb
         tJzMKw4QPDE6BWhJlUYwzet9V8u3MlQjpao4pOrbPdrVgD3MBjmpLLZ7tAFr7HkwZUw6
         +tcXQ+P1sG095NYD3aphn6Jo7KUKC7HpLkdknt6eq8Hwr2OydPYDbLJ8L5r6LSl7dKlu
         e92Ilwhi9/+TdiN8N3FS/Gu3i8THDnYZY6tBRX9QMlgc6X0vTcXN7ceVtV7TW9WWsMFZ
         LD+RCeMpGQXFb2OsRPUXUfnnEOpFAKpN6T61fBU8sKpg4Kug/6l6bzIKENpx34o6oS0j
         W+lw==
X-Gm-Message-State: AOJu0YwHbQy837Ki0vUbgkZnAUBfhMcTHreaRkU5RO/X5kWDLhFIo35e
	boEgqjDbpj3OnvXp9H87n891uC0axvAx3g4l1cnhgmDuokvYYO9ElqbqTEOPpDc=
X-Gm-Gg: ASbGncvP0wClb4jS+MexP4echFd6lcn4IIogA9X/kDLhSdOKMn5lHBk+rSGLj7HzuX/
	pevVQuXFZiNUsed8Jee27JBkpCVQ/W2AGiBrUuDOvdsn5JJzp1SKrgavFjfk+DettUlewmyEKJv
	NjbJWQM824t/obuSKX+gghnIE66+rIiIqitznq8/otXq3uVhFck/pHzLfxN63TV9/QJSh1CMfiE
	UAxmrsgHpNj2471/PcSKwzs5m0xJWrTZbWIRlAJlnMBsADwHJjBm7L/
X-Google-Smtp-Source: AGHT+IH8cuOL6gMPiRHYoBhv4wc/6qGhYbStcloPbWzZYYMeqZLoWaVKg5i2liQS8cUlDs9g0QtsQg==
X-Received: by 2002:a05:6a00:2341:b0:728:e1e3:3d88 with SMTP id d2e1a72fcca58-7290c15d7bfmr2514688b3a.7.1734077838960;
        Fri, 13 Dec 2024 00:17:18 -0800 (PST)
Received: from localhost.localdomain ([192.169.96.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4ec342b2sm7860660a12.70.2024.12.13.00.17.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Dec 2024 00:17:18 -0800 (PST)
From: zhouzihan30 <15645113830zzh@gmail.com>
X-Google-Original-From: zhouzihan30 <zhouzihan30@jd.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	zhouzihan30 <zhouzihan30@jd.com>,
	yaowenchao1 <yaowenchao@jd.com>
Subject: [PATCH V1] mm: fix bug in some memory information update
Date: Fri, 13 Dec 2024 16:16:19 +0800
Message-Id: <20241213081618.53458-1-zhouzihan30@jd.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kernel, the zone's lowmem_reserve and _watermark, and the global
variable 'totalreserve_pages' depend on the value of managed_pages,
but after running adjust_managed_page_count, these values didn't updated,
which caused some problems.

For example, in a system with six 1GB large pages, we found that the value
of protection in zoneinfo (zone->lowmem_reserve), is not right.
Its value seems calculated from the initial managed_pages,
but after the managed_pages changed, was not updated. Only after reading
 the file /proc/sys/vm/lowmem_reserve_ratio, updates happen.

read file /proc/sys/vm/lowmem_reserve_ratio:

lowmem_reserve_ratio_sysctl_handler
----setup_per_zone_lowmem_reserve
--------calculate_totalreserve_pages

protection changed after reading file:

[root@test ~]# cat /proc/zoneinfo | grep protection
        protection: (0, 2719, 57360, 0)
        protection: (0, 0, 54640, 0)
        protection: (0, 0, 0, 0)
        protection: (0, 0, 0, 0)
[root@test ~]# cat /proc/sys/vm/lowmem_reserve_ratio
256     256     32      0
[root@test ~]# cat /proc/zoneinfo | grep protection
        protection: (0, 2735, 63524, 0)
        protection: (0, 0, 60788, 0)
        protection: (0, 0, 0, 0)
        protection: (0, 0, 0, 0)

lowmem_reserve increased also makes the totalreserve_pages increased,
which causes a decrease in available memory. The one above is just a
 test machine, and the increase is not significant. On our online machine,
the reserved memory will increase by several GB due to reading this file.
It is clearly unreasonable to cause a sharp drop in available memory just
 by reading a file.

In this patch, we update reserve memory when update managed_pages, The
size of reserved memory becomes stable. But it seems that the _watermark
 should also be updated along with the managed_pages. We have not done
 it because we are unsure if it is reasonable to set the watermark through
 the initial managed_pages. If it is not reasonable, we will propose
 new patch.

Signed-off-by: zhouzihan30 <zhouzihan30@jd.com>
Signed-off-by: yaowenchao1 <yaowenchao@jd.com>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b6958333054d..b23e128afbcd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5826,10 +5826,13 @@ __meminit void zone_pcp_init(struct zone *zone)
 			 zone->present_pages, zone_batchsize(zone));
 }
 
+static void setup_per_zone_lowmem_reserve(void);
+
 void adjust_managed_page_count(struct page *page, long count)
 {
 	atomic_long_add(count, &page_zone(page)->managed_pages);
 	totalram_pages_add(count);
+	setup_per_zone_lowmem_reserve();
 }
 EXPORT_SYMBOL(adjust_managed_page_count);
 
-- 
2.33.0


