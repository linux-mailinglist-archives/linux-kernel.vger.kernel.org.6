Return-Path: <linux-kernel+bounces-224287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FCA912043
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA316B21137
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFE516DEC1;
	Fri, 21 Jun 2024 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvzuOkpe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C9168C20
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961368; cv=none; b=VvNLb+RpF5w0F5F8acAvmaKENGUGVxXqjYKgyCQOLi2eZWoSpSoBXi2ekEaU8fzTu7FWUmnJSky/OUyr7cO13hr2VnPh/n8oR6q1h8Onxmw+tr4lnbjpOFgBEkhzx8Qi+qZsrGfEn28TBGfxFI5h1/EVnbjSFaCxnd9SiXppN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961368; c=relaxed/simple;
	bh=v9vDfILX0XNYI2C2j3gLeaWjlrBWZ18W2cpxU4y3+30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WuqmFjSPfq8fTdlUfm/Q4b/ksO4wse/SHhDftFW6zwloDx98h7pY6KUOehG6jC572Vl8se0coeWN8dEiI2D/ddyuBW6gYhmNrT50Bn1/Vrpy2p9gJ+3ftR+bh+97VZbAawHMJalj+WRRpAs1ObYwsaOaUwYh5EU08a5+0DN+VP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvzuOkpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A58FC2BBFC;
	Fri, 21 Jun 2024 09:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718961367;
	bh=v9vDfILX0XNYI2C2j3gLeaWjlrBWZ18W2cpxU4y3+30=;
	h=From:To:Cc:Subject:Date:From;
	b=OvzuOkpe/NCLzcUahPzchjXwk5CWz4QhZaHEypFbwbHIcJuG2UuSFS5diEHZgTAA/
	 eQH5sVTwLSsJEnklsFEBAxK4+DcFbDbPVcWaolau3Io3aTuyaqVmeNBxsa5ROqk9D+
	 d5chdlm4fLwLeh+lDbtCxR4FsrTwtuUoUWEStrkkFdjiNNWwuCBksBfua/ZX6mZL2P
	 Qx7FyWtAVPiUdH0Hrssodk2IYU8Np5EEmQbx/Z84wo2KvYVXcv2nRAIsJRO7EPV4aV
	 nRJiIEHODnWESngJhKABlyRsmzoERWR6rC9VdDUG6JDX3hb0LB1sufQ1ZqhTmaNHOq
	 HzgRnacwWv1uw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/4 v4] perf: Fix leaked sigtrap events
Date: Fri, 21 Jun 2024 11:15:57 +0200
Message-ID: <20240621091601.18227-1-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is essentially a resend to remind the patchset on people's pile,
using a small typo fix on patch 3 (thanks Sebastian) as an excuse.

Thanks.

Frederic Weisbecker (4):
  task_work: s/task_work_cancel()/task_work_cancel_func()/
  task_work: Introduce task_work_cancel() again
  perf: Fix event leak upon exit
  perf: Fix event leak upon exec and file release

 include/linux/perf_event.h |  1 +
 include/linux/task_work.h  |  3 ++-
 kernel/events/core.c       | 49 +++++++++++++++++++++++++++++---------
 kernel/irq/manage.c        |  2 +-
 kernel/task_work.c         | 34 ++++++++++++++++++++++----
 security/keys/keyctl.c     |  2 +-
 6 files changed, 72 insertions(+), 19 deletions(-)

-- 
2.45.2


