Return-Path: <linux-kernel+bounces-239133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F01E9256EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507AC1C22462
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39D913D619;
	Wed,  3 Jul 2024 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="F1HZW4bV"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D413B592
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999352; cv=none; b=uFyjZB8yy40AvgvM7RorNqb78yxn4EqvITczxcU/Um/HX/pvy2G4OIM7EOd+vfQKlZNb3pEwY3RKep5tRTaMrsNg5CWOQ1G7pvN6Hoc8HZhe/LT61NygzHwur7PlmgVivvtjA/d6bh1GmODypsLs8RrO1othCfgDg1LESAbptD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999352; c=relaxed/simple;
	bh=T0otbUFamaMmokgYceZKbl9qke58ILXLp2J3aUMITZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkiVtGKN5kOUpVI6JIb5qHQX7dEmsPq/LZMNI+tVImQ4hoSbN4SyuvID89YLOPIyxhYCoSd/xXWU+8JfTWRVsKA2M9fTwc8WeqRSuj5WVcSBhXEWmxD/xu3iJx1t9YwUk3TH/dXRORhMmdLq36Wovc4IiMHOm2wxiQ2oUvPvZ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=F1HZW4bV; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d841a56e1dso1600512b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 02:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719999349; x=1720604149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewOTsQs7Dh/s9g0htpLiAZ9Zrvk13brvrgRs5kRd2wY=;
        b=F1HZW4bVt5e5DeWXA7hKdlyXn44zhTRdj/MzFH3YC++uMlsDmNL6wt0SOw9qIUWoqO
         8vkmQhp7vJ10o2asgxUC942SnE3HyMkDryup+dSHG/9+0Y3QG9YYaAbnSwPCsubrVH8Z
         hXSEs+EYqUoU68OpwwFCi88uz+oeaSz3Cjw+1f2lQW1XbdAI4ppwKsr2G8khkqmFCDZC
         fqlha+UzFNF5dTiUIhGyQoMJPvXQtopYBVfao/U9qYzIAM7DO6Bw8puhGZCyn+tT6rYw
         dFnlg8Uum4Lc1gonbZQINSbd0/pIWiMsjrNwTrrHtIm01dZnb+cNDDXttB0SaIfo+P4a
         u5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719999349; x=1720604149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewOTsQs7Dh/s9g0htpLiAZ9Zrvk13brvrgRs5kRd2wY=;
        b=Bu4CppSbJGXguZ/ny/juflqao8La0LWBLfe1+yc/EJ4I2N6hro9K2Yi2/O9gOcfVOs
         FK12d0hjBr3H7+aQejOpjRNJCWUcgm+TEO1XBee9mbWGmruXCNKruciMwwU40WTKg3W/
         cz7sNGDPKkT1lf0nQIj9nDXglU0UMRmIV+ZZwN1j0nmjvRZ1SDa/4cHor5voIQ+WfqyZ
         JHErceP41SedJAA63ne09YDuHysGEzdCw5ExULTq+5f5vOYRT6PIjviqykCL/tOkTQV3
         yv1PkFyDikmCy5+fCjF2tfbHa7m24ILCRxCUTnL9wp8p6/zQ9QtIJ9LfA3dJGTF3+yhF
         Wc+w==
X-Forwarded-Encrypted: i=1; AJvYcCXSEbzPgEN6/BIhNbf703VX7ApkPC2roDxzna+2galC44+j+qEqcOgBLydpKfHywkEFCmG21cL8E8JfFu4Z5qyPOhBzx08dLjyFSpvY
X-Gm-Message-State: AOJu0YyKgjYtpljj+qA7ceQ763ZyZn/kFdnHXtY4bjNpbZV3sM5pjayu
	pxxoeyhxje9YMXNCpAmofZAzIm2TZ7kpWj9DMExf30d1ybWz0lSCz5H0RFz5iWI=
X-Google-Smtp-Source: AGHT+IG7Fek5s1ebX2jhJYVxA6ULWO/NpR9m/JOExyTrTDK0hgepXZermmGQVehiH1plFKSVh5C/Zg==
X-Received: by 2002:a05:6870:b250:b0:25e:101c:28cf with SMTP id 586e51a60fabf-25e101d419dmr947169fac.51.1719999349407;
        Wed, 03 Jul 2024 02:35:49 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044b1112sm9963220b3a.182.2024.07.03.02.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 02:35:49 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] crash: Remove duplicate included header
Date: Wed,  3 Jul 2024 11:35:18 +0200
Message-ID: <20240703093517.730559-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/kexec.h

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..d3b4cd12bdd1 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.45.2


