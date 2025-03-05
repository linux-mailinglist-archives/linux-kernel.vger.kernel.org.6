Return-Path: <linux-kernel+bounces-546141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4B4A4F6E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3F116EEF2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9FC1C8FBA;
	Wed,  5 Mar 2025 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BMpXDLVH"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782BB1DDA0C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741155115; cv=none; b=WBSxuyV4v8OFeiWRxUYRPUkcz9GvOOZcx0/0Dzx7CikO2YXdUp9iEHA+fhhRnNhcncODyRylQ16rIHc/pD4Sq/LUvlHJi0ixh+5Cp0Lp7QtILqmvdURirwY8YdEhV5J5bNmY01ITzSQ7bskpFP3uU1n/mtQ2QkxJIjPZ6LuWxBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741155115; c=relaxed/simple;
	bh=B/h1xUzz3GWMga/m+nh+B6acXOAhdQBi0bfPZWm9FKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t6qiNFidfA2cjGfd8TYY9Ggce1cHnk7Yd3hyG/zX1iSsSz8GolNGleAIvNkZoUH5aP8QBQSnJu1Jh78b9HAplnaPNGbN1gE4Bzzb59tKyLLRRYZ+7vCIIrZaAvDtoL4dwCm39nyxPbOrqkH0OUc+TyyuYd9WvBLO7uAVHaaSHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BMpXDLVH; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741155110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DGV3NqkAzmPvaMleyfC1/0RAiA4ZDXfweSNW83tscmE=;
	b=BMpXDLVHdTANYIV7oWSC1xvpBCuOlZbEQfDti58iGKS9fF1qmxpDIv8lPx0fXQfnxv9l7i
	7TY3WYx4NQ6LqPVVBY1phLf/uL47YviJI+A6kp77NkzjS7Bp5/3KhzsPJw8dfY6UUrlYPg
	9b0nZe02toud0idNMlzkTMI5phFOf9U=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH mm-unstable 0/5] Switch zswap to object read/write APIs
Date: Wed,  5 Mar 2025 06:11:28 +0000
Message-ID: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series updates zswap to use the new object read/write APIs
defined by zsmalloc in [1], and remove the old object mapping APIs and
the related code from zpool and zsmalloc.

This depends on the zsmalloc/zram series introducing the APIs [1] and
the series removing zbud and z3fold [2].

[1]https://lore.kernel.org/lkml/20250227043618.88380-1-senozhatsky@chromium.org/
[2]https://lore.kernel.org/lkml/20250129180633.3501650-1-yosry.ahmed@linux.dev/

Yosry Ahmed (5):
  mm: zpool: Add interfaces for object read/write APIs
  mm: zswap: Use object read/write APIs instead of object mapping APIs
  mm: zpool: Remove object mapping APIs
  mm: zsmalloc: Remove object mapping APIs and per-CPU map areas
  mm: zpool: Remove zpool_malloc_support_movable()

 include/linux/cpuhotplug.h |   1 -
 include/linux/zpool.h      |  42 ++----
 include/linux/zsmalloc.h   |  21 ---
 mm/zpool.c                 |  93 +++++--------
 mm/zsmalloc.c              | 263 +++----------------------------------
 mm/zswap.c                 |  37 ++----
 6 files changed, 75 insertions(+), 382 deletions(-)

-- 
2.48.1.711.g2feabab25a-goog


