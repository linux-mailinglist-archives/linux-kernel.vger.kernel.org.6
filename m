Return-Path: <linux-kernel+bounces-320172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CDB9706FD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A811C20C13
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CBD157485;
	Sun,  8 Sep 2024 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dH0qsgL8"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E118C22
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795758; cv=none; b=CcA0UUDCAcPS83PJGm4x1KY30MLI4731f1WGo+5Q2wOhu7chu3QARIgmxbDovAMIaCZstwPtuubqWdIe069AkO7nGrxuoCx948wRTeXZEoCw5mBkaAhc7yfXeAZ8hgkc8qtNGe9UY6/ewc2UDBvk19wai0avvzVPVjsyzBQ7HJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795758; c=relaxed/simple;
	bh=57eFswqTrr8+S8LlyO+kLla9Ay+AAffsr0OTTIPiLtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFljLzNJ/PEcaIlR3nSBXrMK4bEhgV3Q+Xd4UsnC0aoqlqYLOTOzryDEqIoIuOze7WY57ghy5cOKUvns4xXw54Qw3gaYxauvGicnDUTk6a3B35WENybsLLPtRAsByzFECRIDsR/sz5m3o1pJYcd/q/+JYpgzm8Mqh7fHBM2UYvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dH0qsgL8; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82a626d73efso164140439f.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 04:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725795755; x=1726400555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsFajEjZr956Q5CmXQIoAb+FGBAkdzDqcpohNG6RrgA=;
        b=dH0qsgL8gm3haW0Hk2peDFdWds0ZtdR+pQqwYvJ8a1ELFifsrrEn5CHATvpLkYGr7X
         nU9+phk8kqD4CvMV3otxKWuxr9EsYe3Dnv9bGRl45YPIrOJkUArOBor9HyS7K5t149dl
         pYbmcucUDQUj0UEFkhRuseJ1kVhJP+QqODLag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795755; x=1726400555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsFajEjZr956Q5CmXQIoAb+FGBAkdzDqcpohNG6RrgA=;
        b=g8MvL8W9q0ZRGYO2fXigBl0auDzhbH4S18ub5chAI/GgaHc2CZg31t+dVT0st/VJg3
         7vi0AIVoiZE2qw4Uc8mc4F20KajWx5ei79wjD5H1V6u8YA9mijYAQh+3gDxWQ/tVjaoR
         i+AinBCxzpddU1ojUNbZ5FnkZiTGOXMeUJtBkFsMVtj+ymW5Lgrc3+eTxwdF7uStG1rW
         IUzrhLJiCOSiRHUcvg7aeUAKINzBL3PnwhHLc8Aw4cTY590/ILqX0BuQsV2TuxUQWjXd
         4QOR3JW0ygrrRGKcWwJRvtMIkMGTKtBovFoEaeZJTl1wq5v3gXKgf9kxHpxyq155F4uV
         fRkA==
X-Forwarded-Encrypted: i=1; AJvYcCUhflx+UyMb4N+9Rla5vF7dML4IGMEoJPOhWgiwYNj/XSjEo9bkQh8fCzUPt34xgGKAfoBJCopyF8ybuQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPV2dkYZo6jz2CSdHSGqOSKUm1kfV5x7MjlflLMXMz70AQBvKR
	94q1ZmTnrmcDhtHQgUS0RZIGM4qR+c52TQGoVS+d4mXbvTGyhdi4n29zr7aPYQ==
X-Google-Smtp-Source: AGHT+IHTBaNAYWsSpLF2sGbIjhVUTafhwXQAqAZ9iRlkE9w+sXFeRIzu/NmZUpF5w1ELH5dlnxCTIQ==
X-Received: by 2002:a05:6e02:b43:b0:39b:389d:f7ce with SMTP id e9e14a558f8ab-3a04f067191mr97010735ab.2.1725795755560;
        Sun, 08 Sep 2024 04:42:35 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5879:695a:4656:45ff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d823cf3a2esm1923029a12.24.2024.09.08.04.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 04:42:35 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 0/3] zram: optimal post-processing target selection
Date: Sun,  8 Sep 2024 20:42:00 +0900
Message-ID: <20240908114223.3024872-1-senozhatsky@chromium.org>
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


