Return-Path: <linux-kernel+bounces-413924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114229D20A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4DB282869
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CA71531D2;
	Tue, 19 Nov 2024 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fF5OnBp9"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2454147C71
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000867; cv=none; b=G8rEt5bQPQte7rcke1QFY/trmrmvn3Yir6ezFzKwLbfXtd1TQTVtVMnJND0xbJ3Iwo+6tPtovSafkHBwtoabvSlrBTtzHGxPuEId88IG1qewxTqmbsr87JpDALiquVx3GekimNHjW9MNlUY1H6aYV+xSLwNdowyO9SMjWzvYKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000867; c=relaxed/simple;
	bh=IQTQ09ZL6ko/rQMhWpAlJlGz8sNEwWvLsT0sOkNh5RY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6z0itirpyvYxe6SQlQarn3bNnafaTNrN5edoi3LbLJd0KRnQx8cIkX6tyT+ZFmdvE2rzBDBs+acds4GmUQY2SZX4SECZ5JoSKPn6LmvymrVFvxT/Apq9sDcNLVS9UP69r44+jHEpzK4nEQY2dV0YyvPD4fDe9NP1aoQB5MQBWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fF5OnBp9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so497898b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732000864; x=1732605664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+LfXTikfPYYGwQ5N8KWqaL9Dmqw7b6zBz3xUO6IbQ6k=;
        b=fF5OnBp9K+k9iHyY71Wjk0iMASmDCFUYrj0wlJBAfjG8tEcG6EL9cFhbZL8xSplcxi
         97C57sDot9A+I5ReL+z+ZMcJfVbnfQIuA/D9NLUyaCcPkpC0bJnwc6GgxoOS9CeHcyxe
         UzaUCtvJnrv28UNt8NNHQRJzqB9Jwsd5Jt6fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732000864; x=1732605664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LfXTikfPYYGwQ5N8KWqaL9Dmqw7b6zBz3xUO6IbQ6k=;
        b=w8Xf6SXdfCw48KUIAkMPXflzX/9hIOfffBPsd8CLClhtXb1Fxtfzb/G7YeSgZRxX3p
         W/L441zfx8rCvR/ujl/TaEDXqLgpJIZeshxN35ohP5uINaxGUkqvxtHFr79Gx9gaB13j
         uV8eUzay2Xz0yUg4R1EfuCHmp7IGjtXAsbeIVagrIbjvQx+7MGPsG6v0XqOPzd9NB4NJ
         UCgtsv49bhDAEmH4HYR67KG8dbKIxLnqPEb0YqLpRi8c8gH5XVP1vSYhPyxbW0dy/buZ
         TJnuOQp4QPscib8TTXiEJP+cNjA77g5Wvcd42rJA7026H2qZgP90lhLaRJ++oncYvUi0
         JTew==
X-Gm-Message-State: AOJu0YxrHEN7lZh280tsGdOVqOlhGBFGleInhI0zSGImqph+J5Kbiab/
	dJWk7eMdCBXz4zMjOOswGoJ1vu5z67MH7X9U4PR1yeC33k+sX97BR+AdgjQ7Tw==
X-Google-Smtp-Source: AGHT+IFuUuk+AOr6dfN8knqHdaKjjTsGcjYd4S3tS1R1eqg3m096pGTOqlXPa2ZQKcTlW0WS8sMJEA==
X-Received: by 2002:a05:6a00:4f8e:b0:71e:7887:81ac with SMTP id d2e1a72fcca58-72476d1764cmr18022607b3a.16.1732000863988;
        Mon, 18 Nov 2024 23:21:03 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5534:f54c:1465:9438])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7247710046bsm7354728b3a.35.2024.11.18.23.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 23:21:03 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv1 0/8] zram: introduce multi-handle entries
Date: Tue, 19 Nov 2024 16:20:38 +0900
Message-ID: <20241119072057.3440039-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	ZRAM_HUGE objects are incompressible and each takes a whole
physical page on the zsmalloc side.  zsmalloc pool, naturally, has
some internal memory fragmentation (within size-classes), so what
we can do for ZRAM_HUGE objects is to split them into several
smaller objects (2 at this point) and store those parts individually
in regular size-classes (hence multi-handle entries). This, basically,
lets us to use already allocated (but unused) zspages memory for
ZRAM_HUGE objects, instead of unconditional allocation of 0-order
page for each ZRAM_HUGE object.

v1:
-- reworked ZRAM_SAME patch (added missing slot lock guard for slot
   flags operation, added missing .pages_stored bump, factored out
   into a separate function)
-- renamed mhandle defines and added mhandle tail len define
-- fixed some typos

Sergey Senozhatsky (8):
  zram: cond_resched() in writeback loop
  zram: free slot memory early during write
  zram: remove entry element member
  zram: factor out ZRAM_SAME write
  zram: factor out ZRAM_HUGE write
  zram: factor out ZRAM_HUGE read
  zsmalloc: move ZS_HANDLE_SIZE to zsmalloc header
  zram: introduce multi-handle entries

 drivers/block/zram/zram_drv.c | 368 ++++++++++++++++++++++------------
 drivers/block/zram/zram_drv.h |  12 +-
 include/linux/zsmalloc.h      |   2 +
 mm/zsmalloc.c                 |   2 -
 4 files changed, 249 insertions(+), 135 deletions(-)

-- 
2.47.0.371.ga323438b13-goog


