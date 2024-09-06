Return-Path: <linux-kernel+bounces-318147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5C796E8F6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298931F24CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81F54FB5;
	Fri,  6 Sep 2024 05:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hjLId02R"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA021FDD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 05:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725599112; cv=none; b=bvXfBkWbJ+OcfKAHNourSjsyOyPwhz1r65tPNL3mB3RtgnwfC68uy5rCO+gy5wporGmoLYsfYmr+G4gsPWK+TSVja3MwcEoAQ8tJfGolfxFW3Yx+7M822Lve9RpnS13t7bm0M5l6ERnbyp177Arnw5Afn8LrZfMd0hMw2VFP9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725599112; c=relaxed/simple;
	bh=sZ2k21ZEXYLV9VovrLLyiV4uy0Dxri8c+6ypHItgeMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txPlrrKurOdSt6BBSuNwLMir46vrm6fwZ06cmhpmTgDfjaEDGgZglHZHbQ3h6Q2TzlRQPW6+BTGBfOcmuoNH6z8moBq85Q7ibFwcqNv8+aHL1cGb6FMO32ZD0mQBx2gsRhxUozo0jcRcCCGj4q+wHAfd5b0Q8c2R+nROkiKKb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hjLId02R; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso1216264a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 22:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725599111; x=1726203911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URjs2e14Fp7RVkIyMVrCJPWGc66YEPbg+saVVglr4c0=;
        b=hjLId02RkOAuojahihlML8IlSeGZR+ZlcVFUN2KTssMjhS53ar/GA/2a1D1DrfUdU0
         UNfbvARJ69SsFSY46qfP6S+ew8MlrHj+IiX3uvFEHBdTP0ArJmLoQnJYIjKibhTMlA33
         fSYHT1U+F7RG3T4J8o5ebpESyoydDLAVKywzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725599111; x=1726203911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URjs2e14Fp7RVkIyMVrCJPWGc66YEPbg+saVVglr4c0=;
        b=i0ZvOrimaeWChOLUpEqIwFeqT3erfj52Ms5Cz+jMDd/DVhnq3nXkELJOrOmyu8gVIo
         5BibGvKrHTh6yFgODAlU94kzRCVMhYzAcSDNGKTHbGO+Vnx3DUrztMM7T9OrfMYvtGz3
         iXF/nb0Ozt5NOHIVYUFLBEH5B/4lMOwXehcwGFLGt9297KC7VPT0sAzZNbAOl5LMtyub
         OmORvqT607ptT/RZT5GxWKWmH9/neeXOYyI7LSanrweeutwgk7ZRNo3bYcxQuE5I68c0
         7SIWOG+ELHjv162BNuLPhnz8mw7JU6J6MHL3g13lWGgHaWBpM4TGck1+HYFxZfwRKDE/
         NhxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqdgDhlAeAUbh1Dvb0jCZ2eP0MPO0xfU3JC5g6hyJmxUj+WPYMGyUkMXpRPR5h9LI0utHhXLUtQtHEpZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFaNuc8PH2XoYMjWNvdTjkZhjDnRvi0JrXF3nz31Ps3CWhQ9UQ
	KD8v6PQVGdMLmpndW8LJAtCI1FCSyGslC0hoAiyocVjwx1ZKM4b9OjSV1+PO+w==
X-Google-Smtp-Source: AGHT+IFF/cAKRv6jWIUL9IOZEt399Ti517iaCaiz6PRilgbEyGIRgojHin+i4Pgxl2noLFwa9C3h+A==
X-Received: by 2002:a05:6a21:3102:b0:1ce:e67a:66af with SMTP id adf61e73a8af0-1cee67a66f3mr17441522637.26.1725599110602;
        Thu, 05 Sep 2024 22:05:10 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:8eb7:9f7e:1b0e:95db])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae90f3a2sm36252945ad.38.2024.09.05.22.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 22:05:10 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv1 0/3] zram: optimal post-processing target selection
Date: Fri,  6 Sep 2024 14:04:44 +0900
Message-ID: <20240906050501.2494686-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
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
slot immediately.  Instead we assign it to a pp bucket, we have 16 (in
this patch) of them.  PP bucket is, basically, a list which holds
pp candidate slots that belong to the same size class. PP buckets
are 256 bytes apart from each other on a 4K system:

        pp bucket #16: holds candidates of sizes 3840-4096 bytes
        pp bucket #15: holds candidates of sizes 3584-3840 bytes
        and so on

The select step simply iterates over pp buckets from highest to lowest
and picks all candidate slots a particular buckets contains.  So this
gives us sorted candidates (in linear time) and allows us to select
most optimal (largest) candidates for post-processing first.

Sergey Senozhatsky (3):
  zram: introduce ZRAM_PP_SLOT flag
  zram: rework recompress target selection strategy
  zram: rework writeback target selection strategy

 drivers/block/zram/zram_drv.c | 283 ++++++++++++++++++++++++++++------
 drivers/block/zram/zram_drv.h |   1 +
 2 files changed, 238 insertions(+), 46 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog


