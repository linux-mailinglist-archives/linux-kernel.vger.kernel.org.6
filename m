Return-Path: <linux-kernel+bounces-286608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1F3951D19
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D66B2AF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96001B32C1;
	Wed, 14 Aug 2024 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsVA+dTO"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D2D1B32A9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645620; cv=none; b=RAL6WUYRKkI9qR6HC7jWL9TSQb1iL+JBwGqEsf4zOGMPS8ITtpUXtCR+M+HvQjJbVpG7gui/wB8Nm0FDmCcnuFiBDdCW7xSYCi3jUxYksUqQ0N//qavGjYYgtsWaEbUeZkkciyMkbIJyJx2O5jlPhRl83+CAH8pgG1GtU47yx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645620; c=relaxed/simple;
	bh=Kqsjs+e1NOlUMGPGmqTLI4cvaMW7NNLLcEqgX5TaoDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rs2jiEwcbQc+mLXHnXMoVm21wrI+mqYbXB7FSbxWJbQ109j7NS6uyX11f6yPLSzBdnlsJo5FoLwtajBf9fa4hHUD2tySOOV98WmI6NlmOMnsm6ao2O5Lml8LHhhTkllLGkXzqBq5uTtKR/6qpJIjDvNcYIdUsBHHTjbKr0vrCa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsVA+dTO; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1e0ff6871so370695385a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723645617; x=1724250417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8s5PcKxFDUFsNJHv4vSWmkKdsgjHkeKLgCsEPLUanfA=;
        b=GsVA+dTOwBpHIGzR7ymLN6zg338DSm45snAix319rygnkHHbotCR6G1cSysg0IwdhY
         V4GOM+bz6wpQKLo+ZHVazcw0YhpEpjKHv4Ksfj4z0B/S09N+nxh81TnmH260AuduaPTJ
         MApPPBxavjp1r/8uvGKzQHjxKM8DbqhRiHZ4NhEse7etp+pH4Z/tkHkduOPMUU6EPjo8
         6MChuWWq1jpkHF1WKbPJWeiwyXUwfq3JOrwpX8C8nVzXFQZk/JbFmG7UwO1k6NfEEM8o
         u1nrQvG3kDfPuNijJ519q2Kjy5CkZdn8V7x9U+a2UpobMoZlhuK4uVdOt7LPyfj2Vxp+
         /yJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723645617; x=1724250417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8s5PcKxFDUFsNJHv4vSWmkKdsgjHkeKLgCsEPLUanfA=;
        b=o/vxinwwzKI7XI+3beM3DpxsailB068PNtnZqQzyQqB314ZdeX3HNFQ4gu4Prrtjsc
         3A4ZK8EI/90I21yiupPWBVURAwoGrfQUfGo6vD3dAEWS+eLSBiMsw2ecByh6c6ufhlLA
         prOAgLFfIGqiZtGnIOCRF5YQifqOdjr3sk/JgKN56uK5oBTXYrA21qewLAHkQz1FjnMp
         dK2ctEK9LKyDd8bKB5M6WOzb20igibt5evvsngDmMHzGgwz8dChPpiEKHELEyDVKytQT
         6ndi1tjmMfmT2W9pY1yJ+0+qG4ANuKaJNtbGcEW7V3NTRrt4PybPLhWmss2boYmhZEz2
         4c+A==
X-Forwarded-Encrypted: i=1; AJvYcCV44lg9HBVAgg8nOqsfrvRhTYT9DvN+MjKIYry9A6xvhNwnsMSkZk2sBQSLo+N4VzyXrKEymXO9MRQjE/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmfq9enpuHTFscl10ghF2DB7ruYdDB64mu9rjKdxrBwnbk/k4d
	Qs72XsZsATk6gW4wdkMfOm7ytajEEwubBKRkt4lkPbAwDTXvhokU
X-Google-Smtp-Source: AGHT+IES/6r2HuU4sA8FZ1SjvqDBS1kUps6OK6CqMwkxtqkTtWHYl2uTeWGdJFZd03n2Muq68Ycyeg==
X-Received: by 2002:a05:620a:3720:b0:7a3:5f3f:c084 with SMTP id af79cd13be357-7a4ee34e1b7mr309474985a.30.1723645617215;
        Wed, 14 Aug 2024 07:26:57 -0700 (PDT)
Received: from localhost (fwdproxy-ash-112.fbsv.net. [2a03:2880:20ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d7122bsm438906485a.40.2024.08.14.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:26:56 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: yuzhao@google.com,
	david@redhat.com,
	leitao@debian.org,
	huangzhaoyang@gmail.com,
	bharata@amd.com,
	willy@infradead.org,
	vbabka@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] mm: drop lruvec->lru_lock if contended when skipping folio
Date: Wed, 14 Aug 2024 15:26:47 +0100
Message-ID: <20240814142647.3668269-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Zhao <yuzhao@google.com>

lruvec->lru_lock is highly contended and is held when calling
isolate_lru_folios. If the lru has a large number of CMA folios
consecutively, while the allocation type requested is not MIGRATE_MOVABLE,
isolate_lru_folios can hold the lock for a very long time while it
skips those. vmscan_lru_isolate tracepoint showed that skipped can go
above 70k in production.
This can cause lockups [1] and high memory pressure for extended periods of
time [2]. Hence release the lock if its contended when skipping a folio to
give other tasks a chance to acquire it and not stall.

[1] https://lore.kernel.org/all/CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com/
[2] https://lore.kernel.org/all/ZrssOrcJIDy8hacI@gmail.com/

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/vmscan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 25f4e8403f41..4e817d78abbb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1696,8 +1696,14 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		if (folio_zonenum(folio) > sc->reclaim_idx ||
 				skip_cma(folio, sc)) {
 			nr_skipped[folio_zonenum(folio)] += nr_pages;
-			move_to = &folios_skipped;
-			goto move;
+			list_move(&folio->lru, &folios_skipped);
+			if (!spin_is_contended(&lruvec->lru_lock))
+				continue;
+			if (!list_empty(dst))
+				break;
+			spin_unlock_irq(&lruvec->lru_lock);
+			cond_resched();
+			spin_lock_irq(&lruvec->lru_lock);
 		}
 
 		/*
-- 
2.43.5


