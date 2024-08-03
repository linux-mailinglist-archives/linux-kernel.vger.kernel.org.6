Return-Path: <linux-kernel+bounces-273592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112F946B27
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 23:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CA41F21F67
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 21:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692015589C;
	Sat,  3 Aug 2024 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIARshgM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9793E101EC;
	Sat,  3 Aug 2024 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722719614; cv=none; b=S3mCpV90b3tI2IHwlcSbOj+cUinhxIO2H67zPCi6VoCDLrZqLGASndC3BZACQsxAicEeEKla+PkcdvUbUY7Rcp4t/cEnkGU4f/sO6JFuAJhic2brttgXX3Ky7w+9WHm2Ae72fqPIn6JIIIhmgX8KG46JkxtwD9Vp84bgF+B4KS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722719614; c=relaxed/simple;
	bh=VbujnbgoREC/EjtlU2OLtgA7pGFcUD32j+2uA98dzIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNwHffugxBO5oPfQ5F8uq74qCEr8TW7snxSgepBEFGRdJ0fGKOngmGSYTXC5E89A65aj4iDiCi+sssa3SpnUqz5Mcbo+82l5gnYku/2Y+GRTHS2hL9Mp5g2ARunj2taGnFvMb0rWt0I9qT3k8w1R/xUskDnxh/aE9UZtevldAS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIARshgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A59C116B1;
	Sat,  3 Aug 2024 21:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722719614;
	bh=VbujnbgoREC/EjtlU2OLtgA7pGFcUD32j+2uA98dzIM=;
	h=From:To:Cc:Subject:Date:From;
	b=nIARshgMFi2ztPSlWqERTh5s/U/GveczbDqGoHPAHo/oOl/NdWUUaVmJAobaniMLB
	 SwTw00xerl4QhKGIc2QugavzZAIYuFc2Sl4Y9J5ZfNsAVaNon2bwyeoVolokh0QRkk
	 byxrEzblR9XcDYiGVg5afDTwZsZHX1zwKZMags6sZwBDkiFHasagGSQZTrnQTUGao3
	 uu48mNgxGK4/FIeiVtbAu4z78QVH08pVb4Vh9lx3S2aXK1SuVy6Ldgzcy88IIQFQk7
	 GpC7E3zATNF54avXi1qkPMxfN2JYjluvAxzNiDS7mz1Pu4Az+dDybmQLJFYui54dYs
	 4zG2n2peSbc0g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCHSET 0/5] perf annotate: Add --skip-empty option (v1)
Date: Sat,  3 Aug 2024 14:13:27 -0700
Message-ID: <20240803211332.1107222-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is to make perf annotate has the same behavior as perf report.
Especially in the TUI browser, we want to maintain the same experience
when it comes to display dummy events from perf report.

  $ perf mem record -a -- perf test -w noploop

  $ perf evlist
  cpu/mem-loads,ldlat=30/P
  cpu/mem-stores/P
  dummy:u

Just using perf annotate with --group will show the all 3 events.

  $ perf annotate --group --stdio | head
   Percent                 |    Source code & Disassembly of ...
  --------------------------------------------------------------
                           : 0     0xe060 <_dl_relocate_object>:
      0.00    0.00    0.00 :    e060:       pushq   %rbp
      0.00    0.00    0.00 :    e061:       movq    %rsp, %rbp
      0.00    0.00    0.00 :    e064:       pushq   %r15
      0.00    0.00    0.00 :    e066:       movq    %rdi, %r15
      0.00    0.00    0.00 :    e069:       pushq   %r14
      0.00    0.00    0.00 :    e06b:       pushq   %r13
      0.00    0.00    0.00 :    e06d:       movl    %edx, %r13d

Now with --skip-empty, it'll hide the last dummy event.

  $ perf annotate --group --stdio --skip-empty | head
   Percent         |    Source code & Disassembly of ...
  ------------------------------------------------------
                   : 0     0xe060 <_dl_relocate_object>:
      0.00    0.00 :    e060:       pushq   %rbp
      0.00    0.00 :    e061:       movq    %rsp, %rbp
      0.00    0.00 :    e064:       pushq   %r15
      0.00    0.00 :    e066:       movq    %rdi, %r15
      0.00    0.00 :    e069:       pushq   %r14
      0.00    0.00 :    e06b:       pushq   %r13
      0.00    0.00 :    e06d:       movl    %edx, %r13d

The code is available in 'perf/annotate-skip-v1' branch at
git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (5):
  perf annotate: Use al->data_nr if possible
  perf annotate: Set notes->src->nr_events early
  perf annotate: Use annotation__pcnt_width() consistently
  perf annotate: Set al->data_nr using the notes->src->nr_events
  perf annotate: Add --skip-empty option

 tools/perf/Documentation/perf-annotate.txt |  3 ++
 tools/perf/builtin-annotate.c              |  2 +
 tools/perf/util/annotate.c                 | 47 +++++++++++++---------
 tools/perf/util/annotate.h                 |  2 +-
 tools/perf/util/disasm.c                   |  6 +--
 5 files changed, 35 insertions(+), 25 deletions(-)

-- 
2.46.0.rc2.264.g509ed76dc8-goog


