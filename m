Return-Path: <linux-kernel+bounces-237198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCDE91ED4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AA51C21665
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0116112FB1B;
	Tue,  2 Jul 2024 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="lRW/TU5+"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AA412CD8B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889340; cv=none; b=SHqlYVoliOC8aymsNC/hzAN+6rPL47HG4itcCi6HfFpK2egnEMMgx4oHF13dCyn9UrGvlXf6KiVJ9JaVeBxM/h0tfLOyzT746FmVWaWo5D2x59i2KZVdmXkRKCtQyzAxmb5ry3d9w8lhQiy85Wb8oBZUoh1s1vA2lI7WMFHnVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889340; c=relaxed/simple;
	bh=76AMBBXtU5aCqHyAiKD9DbjKd2koPJbTbe5mV7L1o6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPY5yjZBfLBB+Asozu4O/w3LupRbHZlT1yddZsW16uXr+PNxjM3C8DtDAuzRLJFYfbtGpr0utHhOeAnCD6zl58JMm71KXq2OcnKSNJNJY7RfBNARQw4wtA2rZi68eDNBx3w8GKRYf1DZkJHlFTmenopYvEIZYsougHSXGXdx7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=lRW/TU5+; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-700d083b65bso2614998a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 20:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1719889337; x=1720494137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQQwXyMsRqqUNEWCeRrNsfzgQh+cx/wn5vbkQhMYQAQ=;
        b=lRW/TU5+JlaDB6RTSJh2UefQqtuM/TxtLjVqRhugqTyBRyWMBFo1QMjsUPVouHSIL7
         LLO5Zldc56NstXoWgmUUtb7rdCZYnJhuj315RAMA2UuHBfBPR4/47I14ljvOd5LZt8kt
         8+N2oBHllEE08j+NrDijsmQcabHESFhilUVNZb+ZEl9odQ18jRrV2Ah5fHlT3pSE5tkI
         sOLpxtPJfnXt8F46LXt2fck9RoYkhVfzKI3M44jnnxVCjp4JF6Qy0167Y18lLySyYpXb
         WtVAIgoytYrRHbi9kvhItuypxA9ebEUkM/ddRpAROTt/UiQwHxQFUzHqIPrMF6si9QbH
         awAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719889337; x=1720494137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQQwXyMsRqqUNEWCeRrNsfzgQh+cx/wn5vbkQhMYQAQ=;
        b=QSKGO5lAQ+C3ecAe3AQxDY4C7VyFUxljCT8y3plWXfcH/mqxfutZqov7TvCI2yWx12
         5nznfV3aOSOIB0P648nx8Y77ji0Rxi0MM6z5ZnWMhhL6datVgat9Vav+6iz/jEpMIPMP
         GsqW0HsiaOz+wndTmRBH17nP2JvF9pQ9WhNB6tP6DDujcGyF0jDPG0jrXjZ4Lt7szJ3e
         l7i4vsLh/72IY9B9De5a+O906w4tdobbD6wXycsW9T69oWMq8lB8HLdCuqLVKZyOgH9X
         5CZqwI51kTkBuB1bpDX26CMaDmvsom1us45my+DPwryKVLXvz0GRTcJni0E0kMXiCSdk
         LJQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyDUe5C+hmc9M1MxmvQ/RMMgsBLYr6RXAgeNoSh2OSXBWVtLfhueBgFl8wxBOsbUjDVCpjY0tBr0LsXkBiUx9Wi6rACSql8Etqj6or
X-Gm-Message-State: AOJu0Yx3u440+oIzI7meNJ+4QL4fxvuehNMa8iCXo/bBxL/15RwXulWd
	8VgTC6Z9rZsVjzOSAX9ORwa5lZs7rF8mj+8t0md+qhPN0kz5YdFYfTkBDWz6HMY=
X-Google-Smtp-Source: AGHT+IEo6Ekcikz9MU8COKrqbNv2gz5ysi3gbJlGTeBCwSZVzy9i9s/b1kCO7DSOJ+UAekre76dXuA==
X-Received: by 2002:a05:6830:6b47:b0:702:59b:d26 with SMTP id 46e09a7af769-7020766b795mr8938625a34.27.1719889337505;
        Mon, 01 Jul 2024 20:02:17 -0700 (PDT)
Received: from fedora.smartx.com ([103.172.41.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbb2fsm4792904a12.31.2024.07.01.20.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 20:02:17 -0700 (PDT)
From: Haoqian He <haoqian.he@smartx.com>
To: Christoph Hellwig <hch@infradead.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: fengli@smartx.com
Subject: [PATCH 3/3] scsi: sd: remove some redundant initialization code
Date: Mon,  1 Jul 2024 23:01:16 -0400
Message-ID: <20240702030118.2198570-4-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240702030118.2198570-1-haoqian.he@smartx.com>
References: <20240702030118.2198570-1-haoqian.he@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the memory allocated by kzalloc for sdkp has been
initialized to 0, the code that initializes some sdkp
fields to 0 is no longer needed.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/scsi/sd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b49bab1d8610..c7268780c642 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3957,7 +3957,6 @@ static int sd_probe(struct device *dev)
 	sdkp->disk = gd;
 	sdkp->index = index;
 	sdkp->max_retries = SD_MAX_RETRIES;
-	atomic_set(&sdkp->openers, 0);
 	atomic_set(&sdkp->device->ioerr_cnt, 0);
 
 	if (!sdp->request_queue->rq_timeout) {
@@ -3990,13 +3989,7 @@ static int sd_probe(struct device *dev)
 
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
2.44.0


