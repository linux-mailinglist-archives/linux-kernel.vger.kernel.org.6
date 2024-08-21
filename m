Return-Path: <linux-kernel+bounces-296079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D1695A55C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D371E1F22DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E2A16EB58;
	Wed, 21 Aug 2024 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWexFVzF"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D737A31
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268955; cv=none; b=m7u2FfWq0jnVTJIqtGgjmeRuqBbx13LxHVnnFiY6U12B9M6Fwoonpb53NrBC4mNPvcGN1BLxhFH9jnmOGSN+iqk3ZifsM+EAExkG6ZJFhqEmyzadqRGvCsCISiY7OpeT3EDjD09pUKW7FsvVbQdRlblPE6DUxaHAUHdwYnqh68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268955; c=relaxed/simple;
	bh=rXwFpnKz1CFuln/TKZw7P+Uk7tNaAbZUFoquGGJ1htw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGdYgqRTLvwmZgQMnIvZ4+WBezrXZQfnuIP8jemifAp3ugNbIcyNREdB4ZGFZq6rqWVBpL7a7z+XHTNFFdS3CR30DlDnl/fsh4ZOrNg2y6JPm3wjt9NnxTEzw0oAZKNaVod5cpWrHBsrq+jp9T0QY1SYcIMcZExK6FUs7iQll7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWexFVzF; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bf999ac52bso20951846d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724268952; x=1724873752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aAlsd1JHvdhK5Hz0/hi6Hu9e2FXd9VK6pKbxR5UtnGw=;
        b=AWexFVzFRQN/Mh1PLTldpsdFBYFFLQANOByFW4JfuOURVmyAkqbO67K7iBF1KfZcPI
         Kin3PgNENGEd7wIGz/jLAMWLgNSGUZjQT3JBpV1ZhamMHG7KDJqKtjhzW70PAp2jM3ad
         NAbiqNZHxd2iJ+DRyYW4gxtGgb+G/6V3lBVmDnNt/UgQCjkMp7ObXSI+fJ6N7jQtgMLS
         nZJc5akbVNw4g5n/6FC4S4Y4YUefEpknqJ/53RlYOBpMDIGbrFay6Lp4JPiU4l0sRzFF
         cRZseNsqbi+PBLv45jhixSrWDWiW1WAXznhlmG2WS5Bjh7RssxfyRNTKmU/IPGJYLeA1
         /kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724268952; x=1724873752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAlsd1JHvdhK5Hz0/hi6Hu9e2FXd9VK6pKbxR5UtnGw=;
        b=OjBjtk+zz3R3RyLbLQGMcShi5v1CS94uMWrK4RxvgdKuBPmowK+vECiHC3Xp9UKuA5
         LPeKaB6MPHuVy5+CA9kVOuirkaUINuxEDWgTrFAO9+lYTaTIN3avcsDlC0nkLmX5zOVp
         nNBaYcpKFEubuKFrLDtiuoJAGzG2I7rWLHC2PtDkRZMkKb5yKru0Igg33tQ2ykExeXKp
         0nbVSMifo62zYtDIrq63U/ryKLludw2Q0Umrs77zH71coMYuggmItE8JKMLOCtqNjRjs
         il7VL5t67B/u2R2a/JpTvi57oxfjEsk2ExnvO08OJK3Q1uV0zsURCHDCkz3ide2QOiou
         lYkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLSReX6b9357gHGd4YbkntSpcLdja0TU1SPgWXNW5n950t3d2Mt1lgJsAUU5CINRZhJD73qBBjY1WUGV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZOPATDhQzVCTPtatqeCOGrWFpVfHypsFNc1RkSioToAmZetV
	IINgBPY1Yb71P7TIYjdIFRMB3sMyMm1Wz7twHUXS/hR6jXRg2Tt+
X-Google-Smtp-Source: AGHT+IFPZE+Jff2sgvSYZBsIe6gdmnstfGArL49uu6MQk4I8eTSFrt+0eYBlfcaYlOmfu7guMgEigA==
X-Received: by 2002:a05:6214:578a:b0:6bf:7f5b:1d3 with SMTP id 6a1803df08f44-6c155d5de39mr43397716d6.16.1724268952272;
        Wed, 21 Aug 2024 12:35:52 -0700 (PDT)
Received: from localhost (fwdproxy-ash-017.fbsv.net. [2a03:2880:20ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db0b30sm111696d6.77.2024.08.21.12.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 12:35:51 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	zhaoyang.huang@unisoc.com,
	yuzhao@google.com,
	david@redhat.com,
	leitao@debian.org,
	huangzhaoyang@gmail.com,
	bharata@amd.com,
	willy@infradead.org,
	vbabka@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] Revert "mm: skip CMA pages when they are not available"
Date: Wed, 21 Aug 2024 20:35:06 +0100
Message-ID: <20240821193506.1525996-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 5da226dbfce3a2f44978c2c7cf88166e69a6788b.

lruvec->lru_lock is highly contended and is held when calling
isolate_lru_folios. If the lru has a large number of CMA folios
consecutively, while the allocation type requested is not
MIGRATE_MOVABLE, isolate_lru_folios can hold the lock for a very long
time while it skips those. For FIO workload, ~150million order=0
folios were skipped to isolate a few ZONE_DMA folios [1].
This can cause lockups [1] and high memory pressure for extended periods
of time [2].

[1] https://lore.kernel.org/all/CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com/
[2] https://lore.kernel.org/all/ZrssOrcJIDy8hacI@gmail.com/

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/vmscan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5dc96a843466..78ad4a141409 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1690,8 +1690,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		nr_pages = folio_nr_pages(folio);
 		total_scan += nr_pages;
 
-		if (folio_zonenum(folio) > sc->reclaim_idx ||
-				skip_cma(folio, sc)) {
+		if (folio_zonenum(folio) > sc->reclaim_idx) {
 			nr_skipped[folio_zonenum(folio)] += nr_pages;
 			move_to = &folios_skipped;
 			goto move;
-- 
2.43.5


