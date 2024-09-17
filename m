Return-Path: <linux-kernel+bounces-331249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1862997AA57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C475228558B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B18518C22;
	Tue, 17 Sep 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d5fwPqaI"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE14C66
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726539028; cv=none; b=IW41yzkRpsL+WwoSGmmrg62INXnhKpaq79TXdBVSM1V7bmE75F8eFP9liljpI6herj0/N8MU/ib7aflJZMVHOV0T7CBFTlv66s18nkjIxApSWFEUcduD1bnO0vjPuHSjTyFswSOsAOf+MEZs0BFSJgAQx8MUcjy43C8xMbSRWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726539028; c=relaxed/simple;
	bh=Rm0D4hKCIqASEdUgaGZuIjwwMNN1qazrBLogG5bdoEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDGahsbiOJbPSrzyfhic1zVJxP7JAYwMPDi2h+9kMF1M/+waIZ0f3dk9+ltsAOloO5wda4CxrXJ8B2wxJrWgIAMYh6OgmBnkfwNQ1PLKkBXaDjPo9kg11xu/F/t++LzdwELBroqaHdpM7mDqhaBKmxAJiUT0ugLxnBNKCiuzE/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d5fwPqaI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d8f06c2459so2697477a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726539026; x=1727143826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G9cKM2n4Br272D+neNiNXEC1CqQLNsVcrcJeCwmehUA=;
        b=d5fwPqaIuQ1aN5LMPilYXCInkuRmfBr2aH9YxVm8zVbWZOnpsidxYxuwU4njug3Yh/
         wZunDhyJoYZT8BmZLgHDZd00zu12+TigU/kUZPN6OiilH7Isf9tXf0gakLyu0FlhvibV
         upW9mh2K+ND3D7LesBEA/VZhHzuq65K5j2cyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726539026; x=1727143826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9cKM2n4Br272D+neNiNXEC1CqQLNsVcrcJeCwmehUA=;
        b=v5qk+JNKCwxqWdVEjqhcj6dF8q1XA1vzuP1zusI4zw0g5i7rG4L0ODSFU74GQrhYkE
         Y5jEcvBZlBd4pSCkw3B0o4Kd6NYsX+CK2e5CG6v3gzYj7bFDYEyrUC0WndE13wL5MOWi
         rTl62MT5gLmvJ2UcszbH484hvCyMF9v+0fJ2ak2a+YlRzWXDDp5MrO+f+EPAdyqH12Qh
         LC0TRiEYABwbdlnAchusrR2WURqXrEPRbnw7/copW0+sVX/SV5NMvJ+5LklAp2zEyYrE
         gmfWahYh/4GGd1LNrCgBpqW/a2cATftQeCr/NrwMU0vRORtU9PBtZjh+AigxDhrpHjHL
         1kZQ==
X-Gm-Message-State: AOJu0YzHcCZrrBknyyHPqS5ifN+pS0Gt44nTY+shGQJqOS42uX91DUHL
	QOR/HoyPtZC9p3621fytCOYqhdm7xAz1qUmhK9gfGxIOEtjg8dASSY2Us2UECg==
X-Google-Smtp-Source: AGHT+IHYArQ66WLsypK8mBLnRtqAPZT3kEqQTwGoNtfGMlY2wvykeSfMusdjEM1m2BfPKs4QwDnm2A==
X-Received: by 2002:a17:90a:b383:b0:2d8:d58b:52c8 with SMTP id 98e67ed59e1d1-2dbb9e1e9famr18470780a91.19.1726539026429;
        Mon, 16 Sep 2024 19:10:26 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:693c:b4a9:5e6e:c397])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd9313fsm6037293a91.44.2024.09.16.19.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 19:10:25 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 0/7] zram: optimal post-processing target selection
Date: Tue, 17 Sep 2024 11:09:05 +0900
Message-ID: <20240917021020.883356-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
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

v4..v5:
-- removed UNDER_WB flag and simplified writeback

Sergey Senozhatsky (7):
  zram: introduce ZRAM_PP_SLOT flag
  zram: permit only one post-processing operation at a time
  zram: rework recompress target selection strategy
  zram: rework writeback target selection strategy
  zram: do not mark idle slots that cannot be idle
  zram: reshuffle zram_free_page() flags operations
  zram: remove UNDER_WB and simplify writeback

 Documentation/admin-guide/blockdev/zram.rst |   2 +
 drivers/block/zram/zram_drv.c               | 366 +++++++++++++++-----
 drivers/block/zram/zram_drv.h               |   3 +-
 3 files changed, 278 insertions(+), 93 deletions(-)

--
2.46.0.662.g92d0881bb0-goog


