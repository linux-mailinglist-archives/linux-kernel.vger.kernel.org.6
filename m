Return-Path: <linux-kernel+bounces-551067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E1DA567BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5C67A376D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3129E218EA8;
	Fri,  7 Mar 2025 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUzw63um"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9456B218E99
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350139; cv=none; b=EPaqLCvkN9cYcLa9igPca4LaSKVGHnW7BT7T+3YOHfAdNohmO6nK9D60A86ltYY6JA1IbELGG/lU2jxU3YA+1JS/X2rcRBfVsp9ww7kX1jbux46dWrkJ8RWO34z/d8eoqdvBxMl7nlKTYQGKDRoyTInqYci6Kl/rfn56L2XDtA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350139; c=relaxed/simple;
	bh=8cRpUhjNTk2YuSqaKD6byIx/0SwWnv/6GjymbmF5DUI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uZqTE50wBm82whIaIdkAXcmtQlIRF/S2NnImaJxBTKj0+yK16ptVt6B3ixF5PpLRDAxirNWdRnAxHKQKRZegTe0LYss+oFZt/PkPb73spQnEcOkVo6WMlqD8rfiE9paupa8zDwqG+4rNj5dvWwNjzs/KUGIoIQ0+jCo0WKoo+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUzw63um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1819C4CED1;
	Fri,  7 Mar 2025 12:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741350137;
	bh=8cRpUhjNTk2YuSqaKD6byIx/0SwWnv/6GjymbmF5DUI=;
	h=Date:From:To:Cc:Subject:From;
	b=RUzw63umpoi/J3d4EDrEL+DokInXvab/SHQyN9bU62LYrvZ4eBchVGYgzxGBQZ+rl
	 pkglUKHsI5954y/on0Z4fq64CMZT/Tpw9tNwpPRJyC0zIeqMxanJP2ywLdU60SWt7a
	 2quoH/svRbRMCM5rbqoN6BiwOk6Ab8LZ06ntZ+Oz9crCDqmtX5MXR3A+jTkKT3DPlq
	 bLgCQmKzkt9TlfI10huQ3my3o/eti6ZLqji5Rpk3q9n1qzSkeHwTAery39UBLWHuGD
	 JsXMNfRebyGZ+nev/z32JoTtpHYyKV0f5JFnzY8VhAUDNkf1A4RppU6w9usuZ9oF60
	 hMwc/K+pHlzaw==
Date: Fri, 7 Mar 2025 13:22:12 +0100
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
Subject: [GIT PULL] perf events fixes
Message-ID: <Z8rk9Mv_arA31-c2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-03-07

   # HEAD: 003659fec9f6d8c04738cb74b5384398ae8a7e88 perf/core: Fix perf_pmu_register() vs. perf_init_event()

Fix a race between PMU registration and event creation,
and fix pmus_lock vs. pmus_srcu lock ordering.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (2):
      perf/core: Fix pmus_lock vs. pmus_srcu ordering
      perf/core: Fix perf_pmu_register() vs. perf_init_event()


 kernel/events/core.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

