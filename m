Return-Path: <linux-kernel+bounces-259233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3B89392FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11732819FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F1916EB6E;
	Mon, 22 Jul 2024 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKu9FpgD"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60311CAA9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668404; cv=none; b=V8+s4GP9PK2osOT6yDt8Et6Vs7AA/PNtAKfdyY8lhwgECVnHt20ooxqDr9pdVRPXZ/iBh0CXVu9L2rC60j/EexJnCcFQVahThx2XlwILW7/lqlkgLENYypGNTICfp9tvbQKWfpgLTbqVr6/qLh5cSJ1ZdBSEoTbp6Kl5nBdLk/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668404; c=relaxed/simple;
	bh=/enLv7shwaOpI6jYOaZSQsFVRhU1YOdwJ33jl+pIRtA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dfQi8nMCunwoq0npA6nMD5bhcMla/VMo+4teb33OiVU0Zfef92Qm7Cio5+k+idm/MzMRAW/wztWPRtKkbhFTMxKqh7HUbZ/dlDYbGCVlqrTWiR4tFIvf1XMLDwJ3u0CSC6JJzsmJxU/86zdUfbOg1FhPJMIb0QmoSkZFpVzXnUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKu9FpgD; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79f15e7c879so313420185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721668401; x=1722273201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlzsr0aEbLd1fKawMEtWtodnCT2ftbY2wbZbcPg3z+o=;
        b=fKu9FpgDV8zrt8QEu/8s9CJfdQmZzIoYYcEUqLpkw2uEYySHoxpss5ILw1llUeDRyF
         tHbKJleu1nmLwsNHjZC16XFfl5wIK6zhVlqF7/3TjT5U+UN9vCXSW2K3ejbvveUW+6sC
         2Pg+oESSuNoOZUaSF//iHOeBueXaYkEWSh/YNy+1kzAjGdbk3euwH/xfZJuPzGVqSQco
         /pWndq/hvytqVqRzpT2hpL/FzjJHO5dbGR2FX85Q1M7FIoPbgAJSWOQiN+eGTbty4blc
         VtmaYsGg3B8haAglDpRHLax2rLeFd2n47HS58xdEcmA+lTXQoNQ9Ouu1o3SPrYAGOj/Y
         zlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721668401; x=1722273201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vlzsr0aEbLd1fKawMEtWtodnCT2ftbY2wbZbcPg3z+o=;
        b=liOVfmWazPOO1+AVQTe3y2h99mYOACTABaLnZKkFy5nKIq6Uhdzakw/0pVBcdeyFZY
         4tiH8OVqaqnQQ04QUn821E1yIJwa9NmSM3z03YD0BXJ+gfJU57vKY8YBSidpuMsA7mXU
         RDkRrth+k+zKZqpeUTi7qkXxgRSLRDRxDY/2I/iHszPIhL+veQDk8wkRhQAb4pyL9sZT
         jInzUXCCkjD1bveCiVEUFBs7VHBbGrXmJ2L+X0bvvMKH8/pzReDKnPGFNH42B0bLXOQW
         RN3rfx0+Ye1c9VX1pUxkKxiWp/wPyqD8P5t7gA0H+AkGumtJ7Zo6zd/i6F2wsvPD4Q2v
         OY+w==
X-Forwarded-Encrypted: i=1; AJvYcCWwr/LK5j2jqYSYm8Al637bVoTUnXe5H8zeDGpv5t09jCnJ8aJlpxJgxzWUPI6mHZRHBfKQGozbmGJRe/miW1NdQ6nUC+kByL1I1RAJ
X-Gm-Message-State: AOJu0YxYJ5u5G7iTeJCb3ya043PfIDZurq5l0JR0YEHUfbiZmqP009o8
	QOvKoKSrYstG/aqlpjKLbnIGaJfagRW48DGveRrijrJNxEZFQUz6
X-Google-Smtp-Source: AGHT+IH1EYMuImUaaSOSyOxBBdptY9FAWLJJVmqrQNQzezWal6sQSa4zscGVinuGNYJlPPUK4P/1mw==
X-Received: by 2002:a05:620a:4714:b0:79f:4f3:88f5 with SMTP id af79cd13be357-7a1c06c5ba6mr65352285a.15.1721668401440;
        Mon, 22 Jul 2024 10:13:21 -0700 (PDT)
Received: from localhost.localdomain (syn-024-171-058-032.res.spectrum.com. [24.171.58.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199078357sm377571085a.107.2024.07.22.10.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 10:13:20 -0700 (PDT)
From: Matthew Cassell <mcassell411@gmail.com>
To: akpm@linux-foundation.org,
	yosryahmed@google.com,
	cerasuolodomenico@gmail.com,
	lizhijian@fujitsu.com,
	ying.huang@intel.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	mcassell411@gmail.com
Subject: [PATCH] mm: added node_reclaim successes to VM event counters
Date: Mon, 22 Jul 2024 17:13:16 +0000
Message-Id: <20240722171316.7517-1-mcassell411@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/proc/vmstat currently shows the number of node_reclaim() failures when
vm.zone_reclaim_mode is set appropriately. It would be convenient to have
the number of successes right next to zone_reclaim_failed (similar to
compaction and migration).

While just a trivially addition to the vmstat file. It was helpful during
benchmarking to not have to probe node_reclaim() to observe the
success/failure ratio.

Signed-off-by: Matthew Cassell <mcassell411@gmail.com>
---
 include/linux/vm_event_item.h | 1 +
 mm/vmscan.c                   | 4 +++-
 mm/vmstat.c                   | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 747943bc8cc2..6fff8ed3b1fd 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -50,6 +50,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGSTEAL_ANON,
 		PGSTEAL_FILE,
 #ifdef CONFIG_NUMA
+		PGSCAN_ZONE_RECLAIM_SUCCESS,
 		PGSCAN_ZONE_RECLAIM_FAILED,
 #endif
 		PGINODESTEAL, SLABS_SCANNED, KSWAPD_INODESTEAL,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..321f259d713a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7496,7 +7496,9 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 	ret = __node_reclaim(pgdat, gfp_mask, order);
 	clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
 
-	if (!ret)
+	if (ret)
+		count_vm_event(PGSCAN_ZONE_RECLAIM_SUCCESS);
+	else
 		count_vm_event(PGSCAN_ZONE_RECLAIM_FAILED);
 
 	return ret;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8507c497218b..27e02b188da8 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1295,6 +1295,7 @@ const char * const vmstat_text[] = {
 	"pgsteal_file",
 
 #ifdef CONFIG_NUMA
+	"zone_reclaim_success",
 	"zone_reclaim_failed",
 #endif
 	"pginodesteal",
-- 
2.34.1


