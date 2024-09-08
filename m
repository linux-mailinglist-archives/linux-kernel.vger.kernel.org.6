Return-Path: <linux-kernel+bounces-320179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42C97070C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257081F21A1D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537A41586CD;
	Sun,  8 Sep 2024 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lonXM0MF"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302E157A41
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795948; cv=none; b=g55lluoY3E+hxJ4AVhyJri2mC6gGa7kd91EOhA/2yTKygNgjDwlnOjgd1nsn8MwxVsC6i9SezGUXCtaX9HN8nhN0Le9A5mjRT6sOA0HSBMEe0kpVbhHf2Z+GOocU6Otrv+vHDe7RZgAbI922d0Jg1Z485tisb1ukecrlFH/eLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795948; c=relaxed/simple;
	bh=57eFswqTrr8+S8LlyO+kLla9Ay+AAffsr0OTTIPiLtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IKPKI5E8/P4oVdoI58lNDIfl6Mc3dzqPK+BQ28MSvjk9kNJUPlcsRYWi6xZkgL+8iY3FA8Qmaa6GcV1z+5WB1hr/vUaIwbmI8iWJ7/gZ8M2XN+As60dcpYxXuTXrRi9OBS9bzSH3ROVWzNtb2p5RIXZYVONZeYOtkjXLFvLwd78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lonXM0MF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2053f6b8201so32571375ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 04:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725795946; x=1726400746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsFajEjZr956Q5CmXQIoAb+FGBAkdzDqcpohNG6RrgA=;
        b=lonXM0MFO/wLkVMQwvzShPJISNDxG4v6RZs+hsv1tkHwVNwPITSWF5vlk74UNpEUVC
         JJXdzU8gaF7AcC3RK38wPVtWZHjTAkCy6E8OTXXNMcg605LN6uqTc4pJjumBVaIsdKW6
         qcFLwmeW9j3O3urgZHGahANCemWZIpUjDJrPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795946; x=1726400746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsFajEjZr956Q5CmXQIoAb+FGBAkdzDqcpohNG6RrgA=;
        b=v3tiZn+rSWhcKnbW0vKvSz9tH668SL1eV5fupCA3OTp/oT7G7PNKopOgMph3Ic4sPs
         LPFaYl0pBzPf31Gxz7Ct5VxJ/H7qxq0kBfMx7vxLCGfqOW1JUAJi2btzvTbeHXN74aNa
         D5oOOirsGAN2SWUT0LSNJHPMWmTi5ueVTK5EWYMZaG8sIao4CkZSfJm99tRNvSOUDnBO
         08+NKck+gYg2sqJVlDESGLDzw87RYq3zk1B0JB/uIHjL00JI9+d2goXdoiU1X7AOQuB3
         yor4PWrULWByP1eqAaFQ/IASVabOy8r8sJeAydN1GaZWGrxOl0vGRliMO5lqdo2SXKTS
         y7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSGrIuS9IZtoDw74eEROE2Xb2xHGZs4ODzyFSQoUx0rRES4spXxAKz9BTjv1LXcUqhg7PZcsZB6LdjMx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuOqONLLbZ7/k0teQ8pJpFfXwp2pn5+Q76Of/zGUY41U+7AE+e
	j+g6Yyt8uyl18HRQ34W2UG/2VGzYlVkiICQsH/EZF1GES0FOxzGMn/yufXK1Hw==
X-Google-Smtp-Source: AGHT+IH9y9NEhDBsK/1Qr4jxJclMVF4y5mSVNKqKgdgPm5E+qL5OXcjfFUsYpp1qKq0BTmzYKPN0SA==
X-Received: by 2002:a17:902:e888:b0:202:2fc8:da35 with SMTP id d9443c01a7336-206f06241femr115225005ad.55.1725795946465;
        Sun, 08 Sep 2024 04:45:46 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5879:695a:4656:45ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1f3f6sm19087065ad.226.2024.09.08.04.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 04:45:46 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 0/3] zram: optimal post-processing target selection
Date: Sun,  8 Sep 2024 20:45:10 +0900
Message-ID: <20240908114541.3025351-1-senozhatsky@chromium.org>
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
slot immediately.  Instead we assign it to a PP (post-processing)
bucket.  PP bucket is, basically, a list which holds pp candidate
slots that belong to the same size class.  PP buckets are 64 bytes
apart, slots are not strictly sorted within a bucket there is a
64 bytes variance.

The select step simply iterates over pp buckets from highest to lowest
and picks all candidate slots a particular buckets contains.  So this
gives us sorted candidates (in linear time) and allows us to select
most optimal (largest) candidates for post-processing first.

v2..v1:
-- clear PP_SLOT when slot is accessed
-- kmalloc pp_ctl instead of keeoing it on the stack
-- increase the number of pp-buckets and rework the way it's defined
-- code reshuffle and refactoring

Sergey Senozhatsky (3):
  zram: introduce ZRAM_PP_SLOT flag
  zram: rework recompress target selection strategy
  zram: rework writeback target selection strategy

 drivers/block/zram/zram_drv.c | 279 ++++++++++++++++++++++++++++------
 drivers/block/zram/zram_drv.h |   1 +
 2 files changed, 235 insertions(+), 45 deletions(-)

--
2.46.0.469.g59c65b2a67-goog


