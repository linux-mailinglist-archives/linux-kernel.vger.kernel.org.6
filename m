Return-Path: <linux-kernel+bounces-404271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6034A9C41B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9572FB2302D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4C419995D;
	Mon, 11 Nov 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKZQyh8N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994125777;
	Mon, 11 Nov 2024 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338271; cv=none; b=BBDk/zwv26s72zAq0p+iDhskwNoQvNY9rvlYzG6Ro+WOgPIjY4nu+MXWnbnMwTPJQtnzo77UjfUylWbdTRAe8ae5pA2GCYdQgXzIXTWh98qipF5hMd178ptYz3Ri3NnE9GiXYIrb/xlNVXq34T/WV0wqJtTEiEoPn+Y4/mfL6Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338271; c=relaxed/simple;
	bh=JJEuT4pKfZrpzCaAnchu4cuIvmGaFNaJSEgcI0/ekBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5UqjAkVplaXnOVntA4JFgWTcjyrm3aIr95LkDvlpVXsZkDwwk3HYyEAwlNf3afwPIVg0t700nR+80Vw1ReeoIlBm4M0S9OyfqS/EmIRFSZ6eSJpQ6Mcs8Vg/qtK+wO2F9qYWGMj83X4E6S3YyuxK/nyDqttRPTa+DsmbGo6Vks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKZQyh8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D64C4CED6;
	Mon, 11 Nov 2024 15:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731338270;
	bh=JJEuT4pKfZrpzCaAnchu4cuIvmGaFNaJSEgcI0/ekBM=;
	h=From:To:Cc:Subject:Date:From;
	b=SKZQyh8NN9cwznpx3g1867EX0ClC6tGcUtkaVbhThw3V0fpL5GQCA+v/jWVYtbsWl
	 mSGE1m3VZiH/qypeuG99ln4hOWWA2FcuCKS2HoaY47jqCBGdYPKCmZBEcuX8rkm1C2
	 loM9kDl3FiPf/B5QWk7oBcslDU8dJmvmm8GpUm3w/GntgXhmgoSYqyeA3vDq1u+pwr
	 mU66YErI3bbbjoRkuxIy3dniWrP4+5erpTi6Y1O9n22lpRBlGoGmW2v1Y8cljcQUFo
	 tKu0qJ8fQp2MZg3+//+EZjdUFQTeZpyoYYz1G7m9wn78nqbtxFgjP6vNQoC5M6o6St
	 PuOXYxQ5808DQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Steinar H . Gunderson" <sesse@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 0/3 perf-tools-next] Selectable disassembler
Date: Mon, 11 Nov 2024 12:17:31 -0300
Message-ID: <20241111151734.1018476-1-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	While trying to see source code in the 'perf annotate' output I
noticed that for some reason this is done nowadays only with the
'objdump' method, and that there was no way to specify which of the
included methods should be tried first, this patch series is an attempt
at addressing that.

	After it is processed I plan to add 'perf test' entries to
compare the output of the disassemblers, to help in detecting
regressions or problems with the libraries those methods use.

	It is available at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-disasm-selectable

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf-disasm-selectable

- Arnaldo

Arnaldo Carvalho de Melo (3):
  perf disasm: Introduce symbol__disassemble_objdump()
  perf disasm: Define stubs for the LLVM and capstone disassemblers
  perf disasm: Allow configuring what disassemblers to use

 tools/perf/Documentation/perf-config.txt |  13 ++
 tools/perf/util/annotate.c               |   6 +
 tools/perf/util/annotate.h               |   6 +
 tools/perf/util/disasm.c                 | 261 ++++++++++++++++-------
 4 files changed, 204 insertions(+), 82 deletions(-)

-- 
2.47.0


