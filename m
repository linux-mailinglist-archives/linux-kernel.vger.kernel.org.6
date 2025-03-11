Return-Path: <linux-kernel+bounces-555318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C350AA5B599
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CAF189099C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E421DE4CD;
	Tue, 11 Mar 2025 01:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbfF8OBW"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080038821
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 01:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741655117; cv=none; b=A7BCs3Z8KxBegMxFpXI3D27Nx0AwFEsg6GL5rTWyUZrjLTIy2K+I6r41pR6ep6g11FV8vZXlw7mtu/M+ri4Gylt2lnXll+uJjJWwPl2K5ZCAfm1ekqQkDziZ+k8D+0T96hWVxS8cTZaJvaOmqLwBpBdi93TMw6geq5IfQ0G+LPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741655117; c=relaxed/simple;
	bh=UQHqtWnaCLmtHKZHpZTGA00uiaHb+Tb8cSWqq8N2AQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jhZGOmB5gMxQzgSJBEj4F5IpoH0cn2T3IUNKFXGjZNkECtiajtnrRdDYd6/Wr4jlpbH9f+k4Wm0Ld3F1OnYEuu03WfgJlyLj/Kj72kBhbGWfwe5zgTlbU1ibmwXapTKi5vukr1nH/QzvQHAV+RJKxpKixh+BRq3DSCx3KT3wbhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbfF8OBW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c548db0aa0so39384485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741655115; x=1742259915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HIpHK0snzAGLj3MCW/rDxP/sRl2fL4OAmqNPStHo5ps=;
        b=ZbfF8OBWv3qh2nTl0YB5J5nQKs4fFw57Q8bCN18FGVIPYzcsLQSHpq8krTZQiY3Pt+
         X68JN28x4kAO8HHjZ9Isc9jkoLxxRC2QC8bSU4EhhQWv/umr++WQy2AXcShHWf6/swcE
         RR3WMO8aEZp8BvvvOtztKU9+eD+s0isz/lv9iiYAMbn+RIOG3pz4iN9DZKE0QDGFxQTM
         2vqb7htsDfq6Od8+tNSi84Lpzgc9PcuYkwS/cXjGjupCppl4vMqpiS5pr8vuIaPmX8bz
         QH2XTJ8rW2hXKfs+Be/w9n0s1EthC5s34DDL7jViLbkHKLpXjv+I8C/nog8ik9jdne8y
         ZVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741655115; x=1742259915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIpHK0snzAGLj3MCW/rDxP/sRl2fL4OAmqNPStHo5ps=;
        b=waucdWYhxm9m8WAoxD3+hR6gb65QjC1sY1VMrUmoGkUjhbCUDqRWG7HmZxGOeVOtN1
         kX3lTIjaTNjqQgaXRGnJ8BciE8IckF7wTtR46fx16flED9CjTi4vxVXOKPUvhK5WuHsE
         cTR3ey0Q60xSisUAbl1H4j064ifu9C/DQVcYwv3widySQTX2IPj27+6KqplqM6N7KfYH
         oqTM2GQ8elAsNx34R+geohepofUD1HtXL3aTuEncHOYcj1H0bklzrZxYQRmS8s/MPSA9
         zdTg9O8T39/7kgsmBqaEgAV1B5dUOCWaDMdwQtpb1c4DdD/aN/6hkhVWMd+WVTkvYygj
         OyZA==
X-Gm-Message-State: AOJu0YwOT/9XYKk0Kh71ubobCo9VKobtkWfKbSx8splosgGDN3yCpcmI
	EhfSw85vPrj7svDuf4sTPJ86NtLg2qKhaQkxtcGiekKN562/Ars=
X-Gm-Gg: ASbGncudZB8CLsHqWRXetK4juLASsYxcZ7SCs1i/M8BK4a5omGxfcsfOCTBPBmIQIaT
	Ty/ClFGvEUE+3nJ/Vs3S0bkLEzPShxu2DNW3TmknoR9uyIWE9kXhU3YjSR9+liXMz/ScAAOqAZh
	iITC+saocOuS8edtfsgPGpxfYCuTPwbAUECc5MjTQQrZ/GIXZHAOyHXEEYKfCFZI5jlI+67qDqk
	HEdbDKX2ygm5tVEvUzmdUSiHHcpfhdm7YApnc9S6eC4m7k3VVqOhkO36OT4XBxF3Pas4jLhckE7
	81nAfymb/HNBjWRf8aEgQcVlwUnQ4PZJgUWyvQT0hg==
X-Google-Smtp-Source: AGHT+IGsdti2YH2aHXnwKrSqcs+H3JeTeyvtlO09sZ05uk+yiX9BLSzuwRgg5tLmXk2ZnX3cD2uXwA==
X-Received: by 2002:a05:620a:2697:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7c55e863b14mr118476985a.6.1741655114693;
        Mon, 10 Mar 2025 18:05:14 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c55e4c41c4sm77492785a.54.2025.03.10.18.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 18:05:14 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	richardcochran@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] misc: tps6594-pfsm: Add NULL pointer check in tps6594_pfsm_probe()
Date: Mon, 10 Mar 2025 20:05:11 -0500
Message-Id: <20250311010511.1028269-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The returned value, pfsm->miscdev.name, from devm_kasprintf()
could be NULL.
A pointer check is added to prevent potential NULL pointer dereference.
This is similar to the fix in commit 3027e7b15b02
("ice: Fix some null pointer dereference issues in ice_ptp.c").

This issue is found by our static analysis tool.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/misc/tps6594-pfsm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/tps6594-pfsm.c b/drivers/misc/tps6594-pfsm.c
index 0a24ce44cc37..6db1c9d48f8f 100644
--- a/drivers/misc/tps6594-pfsm.c
+++ b/drivers/misc/tps6594-pfsm.c
@@ -281,6 +281,9 @@ static int tps6594_pfsm_probe(struct platform_device *pdev)
 	pfsm->miscdev.minor = MISC_DYNAMIC_MINOR;
 	pfsm->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "pfsm-%ld-0x%02x",
 					    tps->chip_id, tps->reg);
+	if (!pfsm->miscdev.name)
+		return -ENOMEM;
+
 	pfsm->miscdev.fops = &tps6594_pfsm_fops;
 	pfsm->miscdev.parent = dev->parent;
 	pfsm->chip_id = tps->chip_id;
-- 
2.34.1


