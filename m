Return-Path: <linux-kernel+bounces-324394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A56974BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E65CB23DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A74E13C9C7;
	Wed, 11 Sep 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MPjK75Yw"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5313AD11
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041702; cv=none; b=ise30geHaWEW+DD56bXPnu8uaup9dmKZY1LxZjiT7n17W7IR0PF9r+d8/WUYT5QVVpB6+/74BcVR3bDzqIZ2MtxZ7RLzu2hSPExN/j5h+1jBsIyyEHVTMKBmrVnHWakmsWszGbQSd4lV+X60iQ8L0YaXj0LAYS+7UbSREMFwGXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041702; c=relaxed/simple;
	bh=Rt378Xnlv1wIuJ8WZYfxbF22T7CPHpqpUPG0VOxEWp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lngMEoWrKw2TbEIc7PZYvCi5EmV/IcEpkjtkysdW2LuhhsMF1X+leazKaxqBru7USDs7qSONzkCgUOvToIAce5oqRgQgnOrDCfRJJZQtuCZhf535i5wWtemy6Nwxy3hAqEHePbRKjNuW5uFNWQsiWK4MlHm82O7B71GcMJICHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MPjK75Yw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2053a0bd0a6so17498925ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726041700; x=1726646500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKTTGB5Tszo1WDwpVWbrnV8zpck++hRVCMGV85JDchU=;
        b=MPjK75Ywxh//L3mcFanUiFr8arOsXTnjHsu4NUJLwzN7FKDOBC+iRKwoIv5M7HXKgi
         idLe56qW84VXsVsudWEEwVZvB1bF2gTXOoM/ylHiGPDzQIf7oxG6gStKb/UzymRn2Rxh
         ZUsMiGZ4XAYktouKJykGC82wnAZuvJQI0BD50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041700; x=1726646500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKTTGB5Tszo1WDwpVWbrnV8zpck++hRVCMGV85JDchU=;
        b=UC0Qet2LMymKsVvxIJkt/WEfFT4KH8XHlDyrFAcHWvZ92x+U2ldi6fSoihGLLMES8L
         vrmEHcJqp/jHK501guuHqoTuIIGj3xdjIIEXkgAZ900Q14E+qVoHXDnKFCFTOmrRblLb
         XL3XJDvgz0ue+CaSfC94CycCRfzxHWyPvElqHzmjn7zWXuJpGf6cDBiKVEVZmri5qod6
         edIJqFDz+56QdM/jJ6qeYYNgmvrvNppv5Y49nRTK38r6Qckd/UhJHQnYiTlNCy6h/I8e
         6vVZNsgWePl7HdB2BMqAXXaqP40fCrfAvIeFAG0V10M+TT2KBRcjpFp1loOHLGlgv4w9
         RX3A==
X-Gm-Message-State: AOJu0YwZSlOWcPkcmCfGfhclt5/WXxxZ21cug/ooQENFY+0464yoMlbV
	u6OqYtJrQvxJx05xSbI1+9/8T/suNH9FAd6CbvgIraY1BztGyVHeMRBIwX0zUA==
X-Google-Smtp-Source: AGHT+IFU7jvHI7+1/JUDX/WvfK5VRy/1j0jBxKXlZwbwNnoTkp31TbDPEjqlxUJdpZi2DgmXpOPT3w==
X-Received: by 2002:a17:903:41d2:b0:207:1828:82fd with SMTP id d9443c01a7336-207521b80cemr26248205ad.28.1726041700298;
        Wed, 11 Sep 2024 01:01:40 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:d828:3442:b431:2762])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e37922sm58737795ad.110.2024.09.11.01.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:01:40 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 0/6] zram: optimal post-processing target selection
Date: Wed, 11 Sep 2024 17:01:08 +0900
Message-ID: <20240911080130.3766632-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem:
--------
Both recompression and writeback perform a very simple linear scan
of all zram slots in search for post-processing (writeback or
recompress) candidate slots.  This often means that we pick the
worst candidate for pp (post-processing), e.g. a 48 bytes object for
writeback, which is nearly useless, because it only releases 48
bytes from zsmalloc pool, but consumes an entire 4K slot in the
backing device.  Similarly, recompression of an 48 bytes objects
is unlikely to save more memory that recompression of a 3000 bytes
object.  Both recompression and writeback consume constrained
resources (CPU time, batter, backing device storage space) and
quite often have a (daily) limit on the number of items they
post-process, so we should utilize those constrained resources in
the most optimal way.

Solution:
---------
This patch reworks the way we select pp targets.  We, quite clearly,
want to sort all the candidates and always pick the largest, be it
recompression or writeback.  Especially for writeback, because the
larger object we writeback the more memory we release.  This series
introduces concept of pp buckets and pp scan/selection.

The scan step is a simple iteration over all zram->table entries,
just like what we currently do, but we don't post-process a candidate
slot immediately.  Instead we assign it to a PP (post-processing)
bucket.  PP bucket is, basically, a list which holds pp candidate
slots that belong to the same size class.  PP buckets are 64 bytes
apart, slots are not strictly sorted within a bucket there is a
64 bytes variance.

The select step simply iterates over pp buckets from highest to lowest
and picks all candidate slots a particular buckets contains.  So this
gives us sorted candidates (in linear time) and allows us to select
most optimal (largest) candidates for post-processing first.

v2..v3:
-- select_pp_slot() doesn't list_del() from its bucket now: this
   simplifies error handling
-- permit only one post-processing operation at a time: this takes
   care of race conditions between recompress and writeback
-- do not mark ZRAM_IDLE slots that cannot be ZRAM_IDLE
-- simplify some checks: for example we don't need to check for
   ZRAM_UNDER_WB now when select slots for post-processing, because
   no slot selection will run concurrently with post-processing
-- reshuffle code of zram_free_page()

Sergey Senozhatsky (6):
  zram: introduce ZRAM_PP_SLOT flag
  zram: permit only one post-processing operation at a time
  zram: rework recompress target selection strategy
  zram: rework writeback target selection strategy
  zram: do not mark idle slots that cannot be idle
  zram: reshuffle zram_free_page() flags operations

 Documentation/admin-guide/blockdev/zram.rst |   2 +
 drivers/block/zram/zram_drv.c               | 327 ++++++++++++++++----
 drivers/block/zram/zram_drv.h               |   2 +
 3 files changed, 269 insertions(+), 62 deletions(-)

--
2.46.0.598.g6f2099f65c-goog


