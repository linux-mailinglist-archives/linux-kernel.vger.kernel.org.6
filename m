Return-Path: <linux-kernel+bounces-413925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18D49D20A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1A71F22DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBD919753F;
	Tue, 19 Nov 2024 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DnUGRHx4"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266C14F9E7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000869; cv=none; b=YnVAS5fYL97rVD45FTrhK6FIod1cQFUPXTe6tqnFNMsAMy6etcdGDxAB1N/a4tJJaGyAuBOLvgrg77TLD70V2S4k9KqmqU03Wl+6Y8Y3hEi9s8Qeghgg8j9jLUFrfZfZLb/uxf5PVYoQrUATFSZBxgOgtsKZGHRl3HRYKY7zhp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000869; c=relaxed/simple;
	bh=55dqSCwZtJRWjRLShFkVUUIpivXMX5HWrsfMTgnd1pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6/EfFgzEyTeXDAsyOXkto4/wH7Y2i7VI4vy/lXdegeC53OCJdCY9+izYcsV62b8t1oshmZJf9SBTkOZptaRqDQ82LlAzhxOHAEXh/cWnJ+Gl6s91EmxRR4VqN6OMCdsnCNPSFxHV+XaDD7FWWoLXKtsx5W8plWHZbJmYQzrq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DnUGRHx4; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e5f6e44727so1627682b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732000867; x=1732605667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q/5L9SIu5rwldrEbUs2WhmscYirGWBWS/629Fd7FoQ=;
        b=DnUGRHx4qXqmXW0nxqo/3ZzM9M3ui9rE0RHozo8zaQn0Cego3pEKHy6TA1RZ21Iug0
         dBP7vJDbuHokCmwt6jVq4t9vI4i0F6j5LXPDPJy+FCXdNJdiNiC03lKBlGNSkwXO865c
         +74VBxUbSAjincTxieHvz9LjXVlKOJHjFFCUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732000867; x=1732605667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q/5L9SIu5rwldrEbUs2WhmscYirGWBWS/629Fd7FoQ=;
        b=TdjbuaaplQEbvPps9A7vZDWpOOMaEKS8X8hQZ9PHK6aHHC8WKIBK+spToVjiU5rkrq
         PIJONqP3/i2Yy3X5gtJzQnjWLuZxOgppTUi8BoWvDWudY+0odK1WJtOt2PIQpjEvVMQ2
         +Slwwh+MibBw7aj7h37ivwW6TDTORaivpRoBwCfkqDsd3I+kf7ckFCCKM/N4/oP5bWRP
         j+UN1Iqk9vZGUtdGKK/2yFeukkyxRf36kq6hFgSleI+YHhHfswZJLticsjgnkyk+Yd+p
         i8wFTN2iiM3wnqBUTC6gnGlPzjnXZuHZpvJrGP2lEYaOTCnMSgLDvpPn6vxo2rs+0Mwe
         pOvA==
X-Gm-Message-State: AOJu0YzDNAqO8OXV0dTAQM3K/aWcMerr9D2DTvrFl+d1WVJUwYaDqk11
	4eHX/4NWyFxd1y+lv29nsjqrgMXSWw4UGSmcz3xo0lNCk8sJZWp3YutglGnCZg==
X-Google-Smtp-Source: AGHT+IGNx1cjKIAjK5ApVq0fmA/BaUlKaY6OH5RzqsFORvd5XDiMWUtUCYCTkQ6mYjoeJeseNXe0uA==
X-Received: by 2002:a05:6808:14ca:b0:3e6:402:d228 with SMTP id 5614622812f47-3e7bc7c5116mr14045933b6e.13.1732000867333;
        Mon, 18 Nov 2024 23:21:07 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5534:f54c:1465:9438])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7f8c1dd3f4csm6930821a12.75.2024.11.18.23.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 23:21:06 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv1 1/8] zram: cond_resched() in writeback loop
Date: Tue, 19 Nov 2024 16:20:39 +0900
Message-ID: <20241119072057.3440039-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
In-Reply-To: <20241119072057.3440039-1-senozhatsky@chromium.org>
References: <20241119072057.3440039-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writeback loop can run for quite a while (depending on
wb device performance, compression algorithm and the
number of entries we writeback), so we need to do
cond_resched() there, similarly to what we do in
recompress loop.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3dee026988dc..882a32d46a75 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -883,6 +883,8 @@ static ssize_t writeback_store(struct device *dev,
 next:
 		zram_slot_unlock(zram, index);
 		release_pp_slot(zram, pps);
+
+		cond_resched();
 	}
 
 	if (blk_idx)
-- 
2.47.0.371.ga323438b13-goog


