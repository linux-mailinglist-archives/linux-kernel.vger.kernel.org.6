Return-Path: <linux-kernel+bounces-433012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ED09E52E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39C728577D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722AD1DB346;
	Thu,  5 Dec 2024 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GZ+HBnpa"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8597C1D88D7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395727; cv=none; b=gLPTDGIX+LSYXkObWuwwsHvlxHPTddGiO4RUWJsoO3GLtNRi5+JSNS4UQ5LofkaWN5fpPy3PuYNQuRr+eZO9lWAS7mjwEauPGreB+dusbF3Z+v2mpemPYX09sYyetrBUpImLu6Rd7OuAy/rf2vAiW19laPEiggspTZ7J84roT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395727; c=relaxed/simple;
	bh=MmgDZLSQtID9mT3Je11M6/sbF7asAJmRXqbPI1UO6rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdTCsGL9UU5AB3kkGwEG6Ye6AaSFVTgtNsFyu3J2VbSLNdTLrZMmNRPljm1D5ij+yA0H7xVEnTHm+2rTAUqJQv6DEWooDaNWASAtF81/BO75Dg+O4TWYKdv3RwfEF6HQu3/jMmru6eD9AApYYrvYVgj3J1CAaZRv2NOIj894Z2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GZ+HBnpa; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385d987398cso98947f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733395724; x=1734000524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzuw/zLX0WQJcc9n8LmQ2bz/aCPLkYLRBmSSAzg1cgo=;
        b=GZ+HBnpa4jJwfCeADhVf9huYax/jNmb80AIsTEwVDkdMLnWXpDQZwXET+vDrSvU8oq
         5C6KVzEDgWhPqj4LKey6a26A5UPwwGhrKGuFaJKoMlNWFZ7QH4X5jzU1lES2crpftJuE
         8NQv5VdT+Pv61RgIkNwyc89OOhin9ltZGaOsVb8ee8U/G7Z8uSTO2SgatJqvnNZbPAlA
         M8B3qjnezDi9sUOrx/K2ugfkBeh4FD0u5w/wFplKL0GIBsaHudg9LnaCQUbERhzn2P29
         vDlWE8Ha5IvWr6taG1V1SlAnSNRQDqK2V1LE1BJOFzGEMarZCKSSc6WAA4ZxKVA2Wkh5
         VKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395724; x=1734000524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tzuw/zLX0WQJcc9n8LmQ2bz/aCPLkYLRBmSSAzg1cgo=;
        b=i86ywCIS6c78y3yGAMNxpR5sl564I2iZjKbLsqbXHrN/iBjzGgo9AA2d32yUt7DqHT
         LWDnwwCfa57DJ1GeMn7I1QRDJ5lq5yLB/VUysowIaPBo849klajMEIFYQUJnprLM0k2X
         iZMrOQMEJDz3i0cUx8J00ZmV6Glq3oYOAyB+KuuiwJYe0jjbnGTlGuSPg4fV0+2ewrRN
         52DTvHg75c1rynzv/9pJ4XgUlbSyDQ6rDDJfmEJhRC7ou0Qb/WR0jG72tZlIWe/Y+seG
         lInA2lrIYeHC9uFwbC9rSWJeQvy3qDhkVwPO8awagrdd2cNcvnfk3gVTr2xjtJTnAM6v
         BkTg==
X-Forwarded-Encrypted: i=1; AJvYcCUWwsCe36cdnhEUkPNIpBkpOm0neR9abJRP/BWkWqsagQWQA6uc0kKWg/mc4+NSqqAvEWtqYSIfhStiids=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKVsUMiYnAmZ5FhZoXW4ZdRV9xFIFDtd35SX25SE4wgUtyCAh
	W/t+OziToTGp3B+9lDWMwVdyA4dq6GuSmXkMcyyGMinfDuFby1vK3WjTNui/mXA=
X-Gm-Gg: ASbGncvw/DyqYuYcBbSkiMNfTaRn6nuY6iq/0cmt+j8CfN4M4loKNk+KIaeu9wGxgmU
	LLr14LQUw4xHV7QbHAxqnxDOxO3j727gNASqoeyOCxENzn0opzI7P4NI0w8neLPMKB/0auDfaH4
	3LkFMS2yz0M9H4JXf+2NpVRtyetMxlicmZpx6QZaGTXj4FCvNqIryUevWnoLjmA4NRzi/gi/81z
	ImzAKYWVpJQPyRwXQFak5Tr7X8EdsowJMpFLMsF4WtwLYnmw5xtkxf1OHZ7isVl
X-Google-Smtp-Source: AGHT+IGOivLgwrbcfAxI55SOIo7GYAysOTEQKhOrkf3R1BczYe6WFuJe7SnaKy0jMJc7mQC4v9gOSA==
X-Received: by 2002:a5d:5988:0:b0:385:e30a:e0ee with SMTP id ffacd0b85a97d-385fd3f26c2mr3542670f8f.8.1733395723996;
        Thu, 05 Dec 2024 02:48:43 -0800 (PST)
Received: from localhost.localdomain ([114.254.73.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef4600d14fsm1081629a91.45.2024.12.05.02.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:48:43 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev
Cc: Heming Zhao <heming.zhao@suse.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] ocfs2: Revert "ocfs2: fix the la space leak when unmounting an ocfs2 volume"
Date: Thu,  5 Dec 2024 18:48:32 +0800
Message-ID: <20241205104835.18223-2-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205104835.18223-1-heming.zhao@suse.com>
References: <20241205104835.18223-1-heming.zhao@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit dfe6c5692fb5 ("ocfs2: fix the la space leak when
unmounting an ocfs2 volume").

In commit dfe6c5692fb5, the commit log "This bug has existed since the
initial OCFS2 code." is wrong. The correct introduction commit is
30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()").

The influence of commit dfe6c5692fb5 is that it provides a correct
fix for the latest kernel. however, it shouldn't be pushed to stable
branches. Let's use this commit to revert all branches that include
dfe6c5692fb5 and use a new fix method to fix commit 30dd3478c3cd.

Fixes: dfe6c5692fb5 ("ocfs2: fix the la space leak when unmounting an ocfs2 volume")
Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Cc: <stable@vger.kernel.org>
---
 fs/ocfs2/localalloc.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 8ac42ea81a17..5df34561c551 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -1002,25 +1002,6 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
 		start = bit_off + 1;
 	}
 
-	/* clear the contiguous bits until the end boundary */
-	if (count) {
-		blkno = la_start_blk +
-			ocfs2_clusters_to_blocks(osb->sb,
-					start - count);
-
-		trace_ocfs2_sync_local_to_main_free(
-				count, start - count,
-				(unsigned long long)la_start_blk,
-				(unsigned long long)blkno);
-
-		status = ocfs2_release_clusters(handle,
-				main_bm_inode,
-				main_bm_bh, blkno,
-				count);
-		if (status < 0)
-			mlog_errno(status);
-	}
-
 bail:
 	if (status)
 		mlog_errno(status);
-- 
2.43.0


