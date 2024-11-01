Return-Path: <linux-kernel+bounces-391677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B39B8A25
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 05:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC3A1C21634
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 04:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368551422B8;
	Fri,  1 Nov 2024 04:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOABM2wQ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E89211C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 04:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730434004; cv=none; b=s3SjoVgVmZKHNzDK5uAY5Ezk9PMYiSWMJCoEEN9q/cCAbA4Wg1aGdyzazmgKgeS9j3NwOfjUGTHA7ny1zpUwRjevnirwqxTvUj0pehS5oEcoh3cyVMe/t2/osB0+LHHW2hC2RVbSFTwIkwUnokaPKrrrvVrD7yFSNzRDLQ0DIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730434004; c=relaxed/simple;
	bh=wg+7EhxTHp/RU3B2qd+RlvJRvoI7xgJzuhBj4xZgTQw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NejRZOkCSPyKH/TFRyIH/CdqXvXlOeGJpwv3VwU0LJv2nXpBMRvQRH977wOBJvcAaHMIdYbVY0QJUHxZq7er5WozHkX28cl/0fcI6ealjriO0icHaL3DMbRoH+wtFMyy/fDjLDfbwfEsn3mtBmsH5G7aZu/CKJmh1jFQIHzF0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOABM2wQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720aa3dbda5so1172072b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730434002; x=1731038802; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6fNV9cqBbjiDhmOMg+ZfjCE9jQFN6pT8SjAyM1Cm5I=;
        b=HOABM2wQzBveHZH7xjzG9/yGzPolsTiHqs1O3cqml1YTI2rqoPxJAIjXo6SJarQ9N7
         QFsJOOaf/iCmv3vWppZyPaTOE0KGyJwnp2EcOC7FkH+wuJl/d3mFYosXbxV1YkEMa9Ac
         HNqrwIlzBh4l3UTq8gYSDxNyECjOgpjl77I2I4A6wBQga2vDPiaX4/HHlXVksxhBN1rH
         /nHyGz/uphZCbOo+6vDzQ2zdE1Re+FRia3gt3JeMUEyt27JxTOGHHlRJIirtXXODcSXk
         +agrjJf9bOhwNqsI4YrY1dzfOVvl+noFjOp27eW3+NWx1hcaRaL6F/VIHRHUClX1pJ7w
         Sixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730434002; x=1731038802;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6fNV9cqBbjiDhmOMg+ZfjCE9jQFN6pT8SjAyM1Cm5I=;
        b=pjLJc2tVxgBzVU5zNN3n88hcFu9eKs60H2Vr5/F2y4EKaKwLwXqqk7iMmtO7fHXI1Q
         dabrN7/MuJXo2HVFx60jLZXaarn0HToECW/KdARCtGJ8EBXG9uZ4+kGvKD/IC2sp2j/3
         n1rPkbAejnMF/pPczQSAjoJqpGT4nyavkd7Yscmqs2VWJppMZImzTnMSacoBGzoZzBfg
         KWZQD/+3lQorE+CHyaYQhkj2ZSZIb8RXijW2lSnLD81w2Jhc76DXBl/2ZFf9aBrvGfQH
         nBPsY6tTesCisFOhidVEpAM6sjXCymAf4Yj1OYongjTBId6cdI0CToL7XMd4/bs00CDP
         cImQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCAV5WV/bYgZBrmjxP9v2p44ekVm0GcxN7Y60SWKZMJii535JMu4svmDf9gWn7dYLaqknKV+rdgKNZQs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQlxzB+aN5wuZ/Xrktoxf4v0MS6nWxXVTXoGmoZlvlU7JwpPMc
	8MdNKmmogntm+hQgtWm7J7+a1sfvlepT6aIaCEFIaTXJPfnDxfN5
X-Google-Smtp-Source: AGHT+IFRZttj0xlmw4OmFxhi0fckSwFgrA7Yr/3PVKMpe0/4OOitM0lPDhLUY1wXX/iIP6DL31PNxA==
X-Received: by 2002:a05:6a21:8cc9:b0:1d9:83cd:3d88 with SMTP id adf61e73a8af0-1d9eeb95defmr14112699637.14.1730434001670;
        Thu, 31 Oct 2024 21:06:41 -0700 (PDT)
Received: from localhost.localdomain ([43.153.70.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93daac954sm1958373a91.23.2024.10.31.21.06.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2024 21:06:41 -0700 (PDT)
From: mengensun88@gmail.com
X-Google-Original-From: mengensun@tencent.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	alexjlzheng@tencent.com,
	MengEn Sun <mengensun@tencent.com>
Subject: [PATCH v2] vmstat: call fold_vm_zone_numa_events() before show per zone NUMA event
Date: Fri,  1 Nov 2024 12:06:38 +0800
Message-Id: <1730433998-10461-1-git-send-email-mengensun@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: MengEn Sun <mengensun@tencent.com>

Since 5.14-rc1, NUMA events will only be folded from per-CPU
statistics to per zone and global statistics when the user
actually needs it.

Currently, the kernel has performs the fold operation when reading
/proc/vmstat, but does not perform the fold operation in
/proc/zoneinfo. This can lead to inaccuracies in the following
statistics in zoneinfo:
- numa_hit
- numa_miss
- numa_foreign
- numa_interleave
- numa_local
- numa_other

Therefore, before printing per-zone vm_numa_event when reading
/proc/zoneinfo, we should also perform the fold operation.

Fixes: f19298b9516c ("mm/vmstat: convert NUMA statistics to basic NUMA counters")
Reviewed-by: JinLiang Zheng <alexjlzheng@tencent.com>
Signed-off-by: MengEn Sun <mengensun@tencent.com>
---
changelog:
v1: https://lore.kernel.org/linux-mm/20241030163527.cc9075a4aeb60448873aea73@linux-foundation.org/
v2: made some modifications to the commit message: 
    - Made the commit information more detailed
    - Added the range of versions that need to be fixed.
---
 mm/vmstat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index b5a4cea..2770800 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1778,6 +1778,7 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 			   zone_page_state(zone, i));
 
 #ifdef CONFIG_NUMA
+	fold_vm_zone_numa_events(zone);
 	for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++)
 		seq_printf(m, "\n      %-12s %lu", numa_stat_name(i),
 			   zone_numa_event_state(zone, i));
-- 
1.8.3.1


