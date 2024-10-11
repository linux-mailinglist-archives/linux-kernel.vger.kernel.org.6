Return-Path: <linux-kernel+bounces-361751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D76799AC8C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1991C20F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3301CDA1C;
	Fri, 11 Oct 2024 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sts9UuH1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66D1C2327
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674481; cv=none; b=Zvwnbl8vGLasJN7h8WrxDGQvZNbi6Fe4hKKdtQfsPQUkvd+fAL0zi1mnBH5f+ETCaNpqFjd1Rs019V8gzpbClRuqU6/pzrOsYQ1GKBS7EnNjouPM46ftUorZUgCAut3Lgk7TjnOnGXWFziTDmd6EG+sGfSmti+oYNrTqssUBiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674481; c=relaxed/simple;
	bh=ki+j3Ox6ENbZiYOptV4CGvpu7r3SiDTSCtzwO2Mymc0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ouIYttvhi+EpDMuE8TZRh2BcMn1K+N9C4LoFALtDlMWi3iAOqdKsPDukFz4+yiTErdmKJ/UiCFLsuVtyXJoTMbLMlmYncKRORJQ4TZu6Clk0SGMGMX25JyrPyooWm4DL2xGsDlQFIU3XhiUGdnNc4yF7mdIE0gRJnqIGEV1dgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sts9UuH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D588AC4CEC3;
	Fri, 11 Oct 2024 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728674480;
	bh=ki+j3Ox6ENbZiYOptV4CGvpu7r3SiDTSCtzwO2Mymc0=;
	h=Date:From:To:Cc:Subject:From;
	b=Sts9UuH1j2Vk37UR11Ups/YHI0X8KTlrhqSUcwd8kyMRAXJymn2C8W2OfFjDo/Oef
	 xom6EkfIjp/GHuwNMzC9gdR81dsI9z1hGfhx9SOlLDswRhAkYPhiLkoRIr988eOwxk
	 TAaICPTn1KCogBQHO5cHTzMo9Eyw4pzhLaFNyGViWgWpJI5osjF2tUAcdxY59y8nTq
	 uJbqxvZ+VqhbCIXsBLazQD5C93lAr/+YhJuihRMWuQp6CZYk+cyqapEBHOYva5nU+k
	 l9pcldqUb7rEc5AKyef+Cdmc+mGNeFqerorJvcKtsWBAhv6UQyvIEhoYdzhkh4RHCu
	 JD+rkFN4LBX6Q==
Date: Fri, 11 Oct 2024 16:21:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1 perf-tools] perf trace: The return from 'write' isn't a
 pid
Message-ID: <Zwl6q8PMuyBz1k9d@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When adding a explicit beautifier for the 'write' syscall when the BPF
based buffer collector was introduced there was a cut'n'paste error that
carried the syscall_fmt->errpid setting from a nearby syscall (waitid)
that returns a pid.

So the write return was being suppressed by the return pretty printer,
remove that field, reverting it back to the default return handler, that
prints positive numbers as-is and interpret negative values as errnos.

I actually introduced the problem while making Howard's original patch
work just with the 'write' syscall, as we couldn't just look for any
buffers, the ones that are filled in by the kernel couldn't use the same
sys_enter BPF collector.

Fixes: b257fac12f38d7f5 ("perf trace: Pretty print buffer data")
Reported-by: James Clark <james.clark@linaro.org>
Link: https://lore.kernel.org/lkml/bcf50648-3c7e-4513-8717-0d14492c53b9@linaro.org
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f6e8475290739a10..d3f11b90d0255c7e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1399,7 +1399,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 	  .arg = { [2] = { .scnprintf = SCA_WAITID_OPTIONS, /* options */ }, }, },
 	{ .name	    = "waitid",	    .errpid = true,
 	  .arg = { [3] = { .scnprintf = SCA_WAITID_OPTIONS, /* options */ }, }, },
-	{ .name	    = "write",	    .errpid = true,
+	{ .name	    = "write",
 	  .arg = { [1] = { .scnprintf = SCA_BUF /* buf */, .from_user = true, }, }, },
 };
 
-- 
2.47.0


