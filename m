Return-Path: <linux-kernel+bounces-256136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E086C934992
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885601F233B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA58078C9D;
	Thu, 18 Jul 2024 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="mOwTuxfH"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2765178C88
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290119; cv=none; b=XVBbdWPejUptNnMz/06YY9SBPgyupoYl0wV2ASSS1Q62CPjpnlDrkeLboYMji+/EiN6umTt+ml5ttzOM8oETbL7DsqZUwcn5/nxo61w1RLeij8qq89qhw4mOAAeG36nJ3VawCWF3bJ2o5L5hzMeQZuOpUsJrVQhNbXYaS6szzfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290119; c=relaxed/simple;
	bh=H4w4bWRvrB8E66jmulgnfGAybN14N6YfNxdxG+lAPUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZIfYbD2Ov/EOU4+xrz1AoVTqKI7t4irL02Y1vxxLBh0cypG9r8pkyZotsIN2GYiyeY0Y28cN+qN7Sy35viSV4qtJzfTbUbaD7S9EYJ6fTYL8xmbHqB8V/zcMhcWsXGtQXw1eNOK1B2RIINaFetcjsZ9xI/5PPOwlDHdc9ICQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=mOwTuxfH; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-38f69f73966so652215ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1721290116; x=1721894916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zvKcJeZW/5nlFPVZg7CuEvKzbd3IdJrobgY1LSpsC0=;
        b=mOwTuxfHHIKADmb10i1U0f3ttUyT2kANWxCx4emcJIEKCuUQdjiMjs2s2uRZ1zOQZc
         1YdgqrNEU+jMT1xu5vt4JWtSTzM2MUxqbvkoCwM+s3c5FTRRJnsxNfuzLGr8Egtou2Fx
         m1o9eAoqiuVDx/yxiS/DRHSpxHG3IvP+jnad4lq3Z3SOQDMxAD20bSM/yNnvf+CGX9Es
         Bi2DIEuxriAZx7X6E9ei+Yucz3/GJgQeL9uuuM5S79eBcXpd2kDGrAKv2ppLE/yoVkbt
         c189/3baiPCN63d5+zVnfiDgVM/h4bCPSQJHr9k2jaifCtaQUzzfff0CG7B/fYsPlTkK
         1F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290116; x=1721894916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zvKcJeZW/5nlFPVZg7CuEvKzbd3IdJrobgY1LSpsC0=;
        b=uZPW6Iqq4jKImSSVsh1dcI/fQSli23h77r//j6qmYZFRlXXTL8k9gNm3BP8bWgwPH0
         3q48kDpP4c0NOr24TAqgbksLRK5atGBx5RdZdp6raBGtyncxWH17vOs4X2xunuNyTmzo
         Joo2ovWk3/sQLnZl5idxkhBJBjwJuSc/j4nEjnk59lrCvjblfcqvEwtOTvHvZPks3YtW
         b2WjxU4FNTly7sqQHoaCz1DuMAhd4j+ujXJGbgssqLxDrE3ggVfmyKRub/WUFVWSLJai
         4x9Sz01V7kIxfhBkooEoOW0r6lVb24dPk5cIGsl6m1jgxc9WP2OZyvOQC75SwwOcjJPP
         vekQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvi8i01EcKHyGhw+RdhhrvLeZXvqYL7xq+s7BHupBtfW8+0TFa5iP6aUkorJ5mkM2U5Nnrh8vqsVVzM0gH59uBeA8+MT3uwzD4ToWM
X-Gm-Message-State: AOJu0Yy4ac/eBM8V5tGhpek62ZUgeJcXIcS0elAFac+jRFCP7VOOYb1K
	qygIxL/HB/4ea1IZ9qjSLSNKtOwYGdFt8cNe8Kd+T0/tMno1ztNYZcIflg0hwB+3l23NrcIbu/e
	FKQAUbA==
X-Google-Smtp-Source: AGHT+IG+282LO3MdKEtecYTgxT/0LeZXejY4bHurHDfBCc4XmaLwlg8D0qa19SjkP31nyxE0heR9UA==
X-Received: by 2002:a05:6e02:168d:b0:376:1264:d82d with SMTP id e9e14a558f8ab-3955760e43fmr49523385ab.30.1721290115841;
        Thu, 18 Jul 2024 01:08:35 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc (vps-bd302c4a.vps.ovh.ca. [15.235.142.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e34d2c4d3sm7385958a12.48.2024.07.18.01.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:08:35 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Haoqian He <haoqian.he@smartx.com>
Subject: [PATCH v3 2/2] scsi: sd: remove some redundant initialization code
Date: Thu, 18 Jul 2024 16:07:23 +0800
Message-ID: <20240718080751.313102-3-fengli@smartx.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718080751.313102-1-fengli@smartx.com>
References: <20240718080751.313102-1-fengli@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqian He <haoqian.he@smartx.com>

Since the memory allocated by kzalloc for sdkp has been
initialized to 0, the code that initializes some sdkp
fields to 0 is no longer needed.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/scsi/sd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index c180427e2c98..3921b8fd71d1 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3953,7 +3953,6 @@ static int sd_probe(struct device *dev)
 	sdkp->disk = gd;
 	sdkp->index = index;
 	sdkp->max_retries = SD_MAX_RETRIES;
-	atomic_set(&sdkp->openers, 0);
 	atomic_set(&sdkp->device->ioerr_cnt, 0);
 
 	if (!sdp->request_queue->rq_timeout) {
@@ -3986,13 +3985,7 @@ static int sd_probe(struct device *dev)
 
 	/* defaults, until the device tells us otherwise */
 	sdp->sector_size = 512;
-	sdkp->capacity = 0;
 	sdkp->media_present = 1;
-	sdkp->write_prot = 0;
-	sdkp->cache_override = 0;
-	sdkp->WCE = 0;
-	sdkp->RCD = 0;
-	sdkp->ATO = 0;
 	sdkp->first_scan = 1;
 	sdkp->max_medium_access_timeouts = SD_MAX_MEDIUM_TIMEOUTS;
 
-- 
2.45.2


