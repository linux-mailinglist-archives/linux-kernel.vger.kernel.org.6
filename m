Return-Path: <linux-kernel+bounces-326064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE3A976215
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFE1284CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87711189BBF;
	Thu, 12 Sep 2024 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hjt9hwpZ"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732F5188930
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124663; cv=none; b=aX4JG7+8sKug1hJg2dw/6VNHvEurlZ8HCIVmbHcQrVhfGfrRqR/j7aE7wgfkFkw49pQID7MhvoiTdFQ4vV1gIOdsYcnS3/YFiTi8e76ZxD5KyiFyQTGjILv/6RxLURlUP7QBqFLVorTBBIKUPgUrGnaLIm+sSRnn7wqEsk6o4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124663; c=relaxed/simple;
	bh=tUAsn1X2dcWD50h91S23iq2IzM5QBO32GU2FcCo2tWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DeCU+FFIK86zDcu826y/iS+sCn01NC52RiPg160zB5K0f8MoVM11R+oKHemcMoE3+HZP6QIAj25F6GR6kmUE15TIcvhpslWnU2OQIAxiyJFq/XuErQwWQi2YahYKH69Mv4GOtGyHTwk3c5FnElhlxsBtjeuIOv6BvV1lVFAxsEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hjt9hwpZ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39f37a5a091so2237565ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726124661; x=1726729461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnHs7mT9NKBlwnpVU7v4uMjDewpTnDWqdqOj9+bDc2k=;
        b=Hjt9hwpZpab5Kkz5rE8Z86Y7vo64fyUsIxch7FxgLSb9AveBlkzyhaRV5ixqZfrRo/
         vj1XusbzgxMOrXVb9SS7Oy/dp05f4Q5a35cisVjh3U2A5HTXdSMjuVq3PrIoSU6I8XUL
         GV+oUeJaLU9nJgVhAE24ib5fj3jLbuSbknrec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726124661; x=1726729461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnHs7mT9NKBlwnpVU7v4uMjDewpTnDWqdqOj9+bDc2k=;
        b=ZedtbhXO4bw5u42If8tUyeDRdeGGtXRRK+YyVxWfgNPyQu5TqB/tK5gnr8m3sTZZPD
         CPG1RwjS8HoOcnAkt8j0nJuqBkqcubtByaerIqSLwxNRz9VuyPf/svIIskwpeYYHTmOA
         w3gBw5eSKGRO8kw2zuNek9H75zh8djFtqaRy8OKsXBN8Li2BTmMihHl4YwR0I8IPConL
         bacocX2nTqIjwhNgn17g2imPLlRppl3ZcCBWCoEhJL/F7uhrBeZPNt613covTs01VQdh
         u6nU9W7I+gvxNt+c1s3oQJ6sV451k9YdlZ+zp+mVNqhuCv55ZZAEWLxIAhiV1pdMbGN+
         jUrw==
X-Gm-Message-State: AOJu0YzYKV4V0hXrCYq0w+rthXnSg/Um4++y/cAAfVTJpt/+k7c+vkKo
	LxUVUJLcZxpC2jPVI1G76o5mWd+oXA4lYOuAWXhmEFYZl3Z/MOxL1We7I4luUA==
X-Google-Smtp-Source: AGHT+IGyajUA7y7CenDctbUoYm/R/mWCWIe7jbasJKOZ9QslobbAVgC18iR8uAZtY+C2kNNey1Mlag==
X-Received: by 2002:a05:6e02:1948:b0:39d:2a84:869f with SMTP id e9e14a558f8ab-3a0848f9672mr14689445ab.6.1726124661369;
        Thu, 12 Sep 2024 00:04:21 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:2fb2:d683:de5d:c3cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5a23sm1101543a12.31.2024.09.12.00.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:04:20 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 0/6] zram: optimal post-processing target selection
Date: Thu, 12 Sep 2024 16:02:15 +0900
Message-ID: <20240912070413.4179924-1-senozhatsky@chromium.org>
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

v3..v4:
-- do not reset pp_in_progress of another context. I'm such a muppet.

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


