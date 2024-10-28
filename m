Return-Path: <linux-kernel+bounces-384353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E869B2946
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089D21C217E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDDC201260;
	Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QMRcfsK2"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E41FCF66
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100947; cv=none; b=mIUWnSENNAitGdruM8phHe9VZvnajXppUfLBvrRA975iZIkW9FTmZXsepjY4V0rAPYfmiNvdKu4TmT4bFYfD9pM2BkALaQI7eKGi99MufZOPa0pBu3wRepu+bpQPUMBjUeWIcLIM0y8mQxawD1DngeicJOe26F8l1cN2JgCoJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100947; c=relaxed/simple;
	bh=5C6DBvGmT5i07ri7JujTGzVFRrILdJa6VrgjkTKYFNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2L+1DWyTyHkSmaUax7C41mvLsfw79l5dnuKzLpL6M7bl6P9P5Z+SoPY6xJdauLZy63mViBqcXd8SDT8kw8P1iLqwbX7YWzjnQ09E/VfGSDwd+cTxaM2rXDKTD6JkFt1bIw9aPkNvS/8GcmQIsQXvlT2aa3s3JzbeVrV7yRixF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QMRcfsK2; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7180ab89c58so2033896a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 00:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730100943; x=1730705743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmjWQcwWRYj7eMjpIQsNdFdyWK14BHSWWqmxxEvL6kM=;
        b=QMRcfsK2YU4C+L3QJw6vY9RVwI/Pe1Li/enY2K4momtuFTgmARd6CkQjtudtYlbbZP
         P7Pt42gUmGzWxNefjVWBDxdL/IOZMXVSCiZYuUkFxXfwssJEsFRFD6V3ADPWK9NQDjN6
         fYLwVMvyCInIGTZiUgXBx1318oLAk97SPLKNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730100943; x=1730705743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmjWQcwWRYj7eMjpIQsNdFdyWK14BHSWWqmxxEvL6kM=;
        b=WewLe4Djp19p+x98pjbDJDAYWgjV8Ner93qwu3blk9t+xT7uaRFkFzBOqR6Uttt7Xe
         k6rtu4xOkuXGkNocNN2vxO3sK8WHbTV+O5mv01JPyNtwpeBpg8ooJ2I8csFK7+9N9EJV
         Xspl+8MhbISt/GXYZow2pz1pPqTlIPEBF3KSNu00gVT5Ir5wCZM9htOi+zj0t0qN/WAR
         +K6mt47rq7spAa8KQLzcFt2JP3Vq2JdUBqqiTS487gHpd/pkdg7K+f305MrBqXM8m2qg
         lQ3ntXPUbTo1lIlFy9igLmj+bKJNeIhtMsqbUlqDShp94BN7/GHnHzdTQeNwHmqPd+sk
         WPzA==
X-Forwarded-Encrypted: i=1; AJvYcCVmJh7cTHF2qNkFJ394AK8Hkblu+/Esseouv4k9yiaBU3b8GmtdmutK6iQF/lt6zaP/J+U66qFR/1KAIu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytqtEhBRLtcSadcSltlP/8Q4tP37qNBs2VrTvriJuOGy485MVw
	frWDSs8rUZPm1pMHysRxmX5x6oysjtWvcAKNJQ/8X1ztzmu74wZ8U2dsQubfc2hVqKcCNmGPgzU
	=
X-Google-Smtp-Source: AGHT+IG4oFx85VTTOQd9EbtUPk0T6vWbtu4r9HKqH9g2BWUweVvxM2LtSpJdWcbLGASiu3ipiopbZg==
X-Received: by 2002:a05:6830:4194:b0:718:787:b416 with SMTP id 46e09a7af769-718682801d0mr6096180a34.16.1730100943210;
        Mon, 28 Oct 2024 00:35:43 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:f1f8:97e1:9c5b:d66f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720579360f5sm5131189b3a.88.2024.10.28.00.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:35:42 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shin Kawamura <kawasin@google.com>
Subject: [PATCH 1/2] zram: clear IDLE flag after recompression
Date: Mon, 28 Oct 2024 16:34:57 +0900
Message-ID: <20241028073529.1383980-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241028073529.1383980-1-senozhatsky@chromium.org>
References: <20241028073529.1383980-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recompression should clear ZRAM_IDLE flag on the entires
it has accessed, because otherwise some entries, specifically
those for which recompression has failed, become immediate
candidate entries for another post-processing (e.g. writeback).

Consider the following case:
- recompression marks entries IDLE every 4 hours and attempts
  to recompress them
- some entries are incompressible, so we keep them intact and
  hence preserve IDLE flag
- writeback marks entries IDLE every 8 hours and writebacks
  IDLE entries, however we have IDLE entries left from
  recompression, so writeback prematurely writebacks those
  entries.

Reported-by: Shin Kawamura <kawasin@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e6d12e81241d..764c5b79b42b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1864,6 +1864,13 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	if (ret)
 		return ret;
 
+	/*
+	* We touched this entry so mark it as non-IDLE. This makes sure that
+	* we don't preserve IDLE flag and don't incorrectly pick this entry
+	* for different post-processing type (e.g. writeback).
+	*/
+	zram_clear_flag(zram, index, ZRAM_IDLE);
+
 	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
 	/*
 	 * Iterate the secondary comp algorithms list (in order of priority)
-- 
2.47.0.163.g1226f6d8fa-goog


