Return-Path: <linux-kernel+bounces-527246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87501A408D3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B4619C3C5D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F631474A0;
	Sat, 22 Feb 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkdeQGlJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D5E145A03
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740232458; cv=none; b=q8iYQwYMMRwVoJqg/B7t+rYAg+C0k2cIQgrVHY47lud45MaUGMeAtgicpVEGxAdBOq+uU8txBuuyGR+X6Gs0sVcJOypyjOng8f6wYl9NHIKF3jWTvV2S2hMi+OTzfWyj7AudQlV1DvpexGQHC1ilyu9fgP31y8v0Wshc8FxC5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740232458; c=relaxed/simple;
	bh=9kib/xowRDjBzBQdZkMjZ1TL/x6brRnVlFrpE8pOZ7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iwicG5ahvHHBp81pl/uYk5nwWvm/yBqcVgw1MoPvz8WIAPn6hAj1mBCkuw9v/tVCOsK7ynFYEiPkI78RbzN5dOwE+ahJ0T7HhD1cN69/rBdQX+/FuACmsrME4SC8iNi/QxPEw1LqgDvzZco2jbzhMqXLQvTCW27SJosYxtT5l58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkdeQGlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64938C4CED1;
	Sat, 22 Feb 2025 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740232457;
	bh=9kib/xowRDjBzBQdZkMjZ1TL/x6brRnVlFrpE8pOZ7g=;
	h=Date:From:To:Cc:Subject:From;
	b=HkdeQGlJR/G7yW36+wmpxOYzismFqjFNRQ3SZxFrELOcL4BlbRGTBMLtNJPsGHkzy
	 9xoYLFUhpzwzc2LO9vXVxmzinpO9T+rQOTLCZJBUVeIFk8337x+q3lS4imD/S/mXEF
	 pxBfIO6367tFYsbhgWLTXEdTyG66Q19W2iUnBUyHvLYaZYpCboQQHFjaJ8m38zeE6r
	 PUhNGuGB0nlSTPm9nmAh3tkEVThEr2ebV3xBbjA7fWpJoN5A8FqwIMSRKB+kTLRo/d
	 RSx3PmsFdwkDqW6n91EApPQp86P5op6HAZ2mqcT7qZw7QwXGChio6gKrWIeBdaPZcY
	 bGCp+lT6tmRaA==
Date: Sat, 22 Feb 2025 14:54:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [GIT PULL] performance events fixes
Message-ID: <Z7nXAHg-7bznAz83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-02-22

   # HEAD: 782cffeec9ad96daa64ffb2d527b2a052fb02552 perf/x86/intel: Fix event constraints for LNC

Fix x86 Intel Lion Cove CPU event constraints, and fix
uprobes debug/error printk output pointer-value verbosity.

 Thanks,

	Ingo

------------------>
Kan Liang (1):
      perf/x86/intel: Fix event constraints for LNC

Thomas Weiﬂschuh (1):
      uprobes: Don't use %pK through printk


 arch/x86/events/intel/core.c | 20 +++++++-------------
 arch/x86/events/intel/ds.c   |  2 +-
 kernel/events/uprobes.c      |  2 +-
 3 files changed, 9 insertions(+), 15 deletions(-)

