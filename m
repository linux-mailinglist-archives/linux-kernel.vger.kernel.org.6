Return-Path: <linux-kernel+bounces-268316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCCD94231A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB15B233FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACB11917D9;
	Tue, 30 Jul 2024 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZpJk/3A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1DE145A11;
	Tue, 30 Jul 2024 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379887; cv=none; b=T3sSVZONDM8HHzMnhxMvo2Nda/ujUtY/TTjxzjZEvjzeRCqCwo2QGnse/e5+l/pUVNd6WZaU4mtUb+VbikPEoxqWWgAFVbV8NhsRimqqEZcaySG2OrY5ksd56VRedqgSG4TFf9t83JjmI33hUX8Xu70xc3421lgo8UPfWmzrlRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379887; c=relaxed/simple;
	bh=To3jG9LZmvwtcJpByl0+0q7VWH7fMvnFebrU5dzpiqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bY1qA65AceANNgwS13rsp7Jt9gpsFnTChyaoYBDn4s99kOslsWO0zZtJQefyXSU3BxT+6WNCxs46GUihIUhXte5tgodKTqTGZWSROW385u8sliaFv92yXf+Rglim5OxwREanfmCbYUQXtksujSxiUwUZIeh39Co2B3veCSrTYpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZpJk/3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4D7C32782;
	Tue, 30 Jul 2024 22:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722379887;
	bh=To3jG9LZmvwtcJpByl0+0q7VWH7fMvnFebrU5dzpiqg=;
	h=From:To:Cc:Subject:Date:From;
	b=PZpJk/3A2NvyYK1nqypwjhq6NQo7psx9ZLyId56wbX9EJZm4egyJr8ANtQyXZG+AG
	 hkTKUyCUEmg1XGk/M0j8arvo6wjgw+SPJEQs4sZSOKBbJwBwhfO8iewkJpXLl0gGLV
	 CGzrFyXWJcQYD5QAuDFXzYlUFkzRADLhLRzlxBYareMk8FG1ltHLbQz/ImiBhuYdgp
	 ePjosAXKa1F5JtshPnmC/K9p6xf5YRkXKsfQTDXHyKn4vkfZtDhiSF57FR9EIjQq+a
	 WLpixo27Px2sY7Us/4p2Sqx+fQ4PL8z4Qv++itmz9skFO9rZnBGeZvQ7KD6o3Lm7iY
	 Gya2wwhFZQg9Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Leo Yan <leo.yan@linux.dev>,
	Casey Chen <cachen@purestorage.com>
Subject: [GIT PULL] perf-tools fixes for v6.11-rc2
Date: Tue, 30 Jul 2024 15:51:24 -0700
Message-ID: <20240730225124.4057811-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.11.

Thanks,
Namhyung


The following changes since commit 92717bc077892d1ce60fee07aee3a33f33909b85:

  perf dso: Fix build when libunwind is enabled (2024-07-17 13:17:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.11-2024-07-30

for you to fetch changes up to d27087c76e3c859ea05b7581ef7ce8aa5a088dd8:

  perf docs: Document cross compilation (2024-07-26 11:15:55 -0700)

----------------------------------------------------------------
Another perf tools fixes for v6.11

Some more fixes about the build and a random crash:

* Fix cross-build by setting pkg-config env according to the arch
* Fix static build for missing library dependencies
* Fix Segfault when callchain has no symbols

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Casey Chen (1):
      perf tool: fix dereferencing NULL al->maps

Leo Yan (6):
      perf: build: Setup PKG_CONFIG_LIBDIR for cross compilation
      perf: build: Set Python configuration for cross compilation
      perf: build: Only link libebl.a for old libdw
      perf: build: Link lib 'lzma' for static build
      perf: build: Link lib 'zstd' for static build
      perf docs: Document cross compilation

 tools/build/feature/Makefile       | 53 +++++++++++++++++++++++++++++++-------
 tools/perf/Documentation/Build.txt | 28 ++++++++++++++++++++
 tools/perf/Makefile.config         | 20 +++++++++++++-
 tools/perf/Makefile.perf           | 27 ++++++++++++++++++-
 tools/perf/util/callchain.c        |  2 +-
 5 files changed, 117 insertions(+), 13 deletions(-)

