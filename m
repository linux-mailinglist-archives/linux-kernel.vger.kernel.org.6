Return-Path: <linux-kernel+bounces-440353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF61E9EBC16
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F86188ADC2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5602309AE;
	Tue, 10 Dec 2024 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omfAYIDv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB923ED78;
	Tue, 10 Dec 2024 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867436; cv=none; b=WBdRPLz2ctDb7mDkCJUhlSnxfhutmQiUlcIZpOYCV4da10Zq1WlbeVBVs5N+HdWwCGG/9XzKVYJcFXcdAEIewwTV0E11yZc6H57xN5gVcHHU/UGPCx5ItZq0VuAqzVPDcvptPMppdj68+JHXaQ85AiMyHoU8mBCeByXjnvmwSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867436; c=relaxed/simple;
	bh=kYpbn67PrWOlsV/B1/qX/YwX9r+I+iwn6E8e2nl71Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kSGno73zBvVtS7gJhS5M5YhHemymmGnLNizTJLUGmYAEEjuuDBXy5CaeI3if5JOasWi53a0I1WdXvkL7cgcxlh1GWZRPrWFQ9+/ip7h5kAHUfnIVKtJia+fKjRRhT/SAAz0DlOCAKlAaQrxKjk01HJPmxvnU9qAjULsSUBistD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omfAYIDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD14C4CED6;
	Tue, 10 Dec 2024 21:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733867436;
	bh=kYpbn67PrWOlsV/B1/qX/YwX9r+I+iwn6E8e2nl71Y4=;
	h=From:To:Cc:Subject:Date:From;
	b=omfAYIDvEwAU2+mwrYoJHtfOjt3drri7yzemlmyHfzNBlJfnsEUEYs4BsJKr4z9xW
	 XfG/vH3ArYpXiGunJloafkKatNQKy4OiYv2UMxy3nB80P53schyQnWAh1IJ9dAUcym
	 Y05yuzSS4qsgia7d0VyGM4WxJj/LtTlhAtoUmxcQQMFQOM/6eqer5zY4KApsnUxQD9
	 8l2ugIqn4eRdxV1hIgdRR7e11E6OMUMX047db/0/a33l8B3/PiBmS6Xqjs7HMdGe2S
	 oHfS7J3mSz5mpx9/Qsu0DvCYdmMq8S7i6KsXc3tMpc+OnyqEvEHeffS+hMeATbJfkZ
	 oiFLFQCC/794w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/5] mm/damon: add sample modules
Date: Tue, 10 Dec 2024 13:50:25 -0800
Message-Id: <20241210215030.85675-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON provides API for other subsystems or modules in the kernel space.
The API functions have their own kernel-doc comments, but having working
example usages would further helps beginners.  There are DAMON modules
built using DAMON API, including DAMON_{SYSFS,RECLAIM,LRU_SORT}.  But
those are for real world usage rather than examples.  Add sample DAMON
modules for exasmple usages of DAMON API for beginners.

Changes from RFC
(https://lore.kernel.org/20241113162624.48973-1-sj@kernel.org)
- Add minimum age to prcl
- Wordsmith commit message
- Remove module_{license,author,description} that unnecessary for static modules

SeongJae Park (5):
  samples: add a skeleton of a sample DAMON module for working set size
    estimation
  samples/damon/wsse: start and stop DAMON as the user requests
  samples/damon/wsse: implement working set size estimation and logging
  samples/damon: introduce a skeleton of a smaple DAMON module for
    proactive reclamation
  samples/damon/prcl: implement schemes setup

 MAINTAINERS            |   1 +
 samples/Kconfig        |   2 +
 samples/Makefile       |   2 +
 samples/damon/Kconfig  |  30 +++++++++
 samples/damon/Makefile |   4 ++
 samples/damon/prcl.c   | 136 +++++++++++++++++++++++++++++++++++++++++
 samples/damon/wsse.c   | 116 +++++++++++++++++++++++++++++++++++
 7 files changed, 291 insertions(+)
 create mode 100644 samples/damon/Kconfig
 create mode 100644 samples/damon/Makefile
 create mode 100644 samples/damon/prcl.c
 create mode 100644 samples/damon/wsse.c


base-commit: d344b591933d7f56960f43d9c86effd14559f0f2
-- 
2.39.5


