Return-Path: <linux-kernel+bounces-250126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9AD92F482
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF7B28343E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816C810A1F;
	Fri, 12 Jul 2024 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frozUFe6"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC2C17C96
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720756304; cv=none; b=PMhdZWVpK4L/Cz0yzqy9RAyai2Dz7JqZhTzVppbUsczxr8d8xiWEVRvpwxyPMI2HMWM0oRoRND6aQanb8f5+Hqm+NZOx+LQs/njBcKSJE6p9XiPwjjq0tLi3YMkofkEHIAl/UnP7oPixazTsjbo1oTOTb6WCNaV0m7xcA8jLpqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720756304; c=relaxed/simple;
	bh=5F62QexdAD1TUTWLXl65C3GB13KVi99o1pl6wguzU6s=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dz1ZOqm2sPNXff3voSTfbybGijSk7+kwb3PZJt9+cL1of+e7VPr5+7A21fNArR2ACduybdMxkSrYBPYeU9TVQ5t1+wLCM2Q90MQGkHGp6oi9HSYQY7nRN88IVlnUjqVlrRjSzsnFbxaVNHAO/adR5GiiljlYFThbztbmgn8B42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frozUFe6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea1a69624so1691670e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720756301; x=1721361101; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO3Tf5d/D2iUR2IShRIcj0G34F0OnXwQyIKn4cZF5cA=;
        b=frozUFe6Mcq8SJ2Swyei0Re4bLyEAMVIEZIaC/ojkJTiVksEEpExu3MD7OgDRNt+JG
         x2hnS/9mUU8B8aTKB2ikch7evO1pRggPbBEsHSOY9qgspe/jvJX9GLiaZ+Nk6JNImP7s
         jSQeZJWp82vbLKJMqE8sVkL2K8bL6KLZeNb08kfXc2O5I1xz80ei30yxT1UbyVdPlGkB
         9X5puUmiGtWhaA4TJjvwR2AaFmRJnCzH8frdrIeCHuJRZ96qrcG8rYwIbnwwXrgoaZYD
         mzeAADfpBAqpiP/+C4a/uxPwUdEMFnskymHcfXost28/pcsDMclgdZAxWU+BjFYVP8QT
         O7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720756301; x=1721361101;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GO3Tf5d/D2iUR2IShRIcj0G34F0OnXwQyIKn4cZF5cA=;
        b=MarFpRWADqcBQYAKAb6FHhdYmZzrTQ9BRSNBo6Sel1Gt7GXZMtYbRQqAQ1tzqSMCAP
         jIziIwFppU4NCP0wHYEOIviF1owpyNRNAjLXD2XRFSZCuObh9aovXndWGIkm0MAbGQqh
         /qztTqxefGb1htX3ktH/RHhvS4NDhLgFbFreH8t6Izg3r/upeE2WEKL7PDX2WkDj137O
         YK05H8s7WY1Xqo0Djbi3iCUCdNu94Jyr4gdBWmnPvF9TkhBDy+qGcjHq8H8NjHFGqAgv
         rSXMXMAKr2JKBRTtTGjYLGrhYPyCnigSHujJA7vyUcAJcnGIHBZWg8D27kcwARrub4bJ
         ccaw==
X-Gm-Message-State: AOJu0YwIgoH9OS2StpgB7BkaTVzM8cHao6sMWhy5zFz0Gurj3afHMtNP
	BVJSZfOALQRgWNSqfNbtxYTeemmS0Ni+yoxK4M67JXAgPL0vl8lf
X-Google-Smtp-Source: AGHT+IExIfsRuIjmVCVmlBrOm5Tvms9/AW+A/1McpINa6Usy+IXI0N3dcRJKq2pF5w6hHwE7YYaqgg==
X-Received: by 2002:ac2:42da:0:b0:52c:891f:d732 with SMTP id 2adb3069b0e04-52eb99d3d1amr4646680e87.56.1720756301255;
        Thu, 11 Jul 2024 20:51:41 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bda276c0sm4069558a12.79.2024.07.11.20.51.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2024 20:51:40 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	willy@infradead.org,
	Liam.Howlett@oracle.com,
	will@kernel.org,
	broonie@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/3] memblock tests: include memory_hotplug.h in mmzone.h as kernel dose
Date: Fri, 12 Jul 2024 03:51:36 +0000
Message-Id: <20240712035138.24674-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In kernel code, memory_hotplug.h is included in mmzone.h instead of in
init.h. Let's sync with kernel.

This is a preparation for move init.h in common include directory.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport <rppt@kernel.org>
---
 tools/testing/memblock/linux/init.h   | 1 -
 tools/testing/memblock/linux/mmzone.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/memblock/linux/init.h b/tools/testing/memblock/linux/init.h
index 828e0ee0bc6c..4aeddce53310 100644
--- a/tools/testing/memblock/linux/init.h
+++ b/tools/testing/memblock/linux/init.h
@@ -4,7 +4,6 @@
 
 #include <linux/compiler.h>
 #include <asm/export.h>
-#include <linux/memory_hotplug.h>
 
 #define __section(section)              __attribute__((__section__(section)))
 
diff --git a/tools/testing/memblock/linux/mmzone.h b/tools/testing/memblock/linux/mmzone.h
index 71546e15bdd3..bb682659a12d 100644
--- a/tools/testing/memblock/linux/mmzone.h
+++ b/tools/testing/memblock/linux/mmzone.h
@@ -3,6 +3,7 @@
 #define _TOOLS_MMZONE_H
 
 #include <linux/atomic.h>
+#include <linux/memory_hotplug.h>
 
 struct pglist_data *first_online_pgdat(void);
 struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
-- 
2.34.1


