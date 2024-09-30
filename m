Return-Path: <linux-kernel+bounces-344336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C186C98A873
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BCF28501C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E6D194C9E;
	Mon, 30 Sep 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0bgZlu5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6671922FA
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710030; cv=none; b=k4Dn0I+QnnI6Tc7KR0qEVylvUNrhveY754Gfz9defvkfFnaSYzsJrZPvwrZGvSBX2kuXoBbI88Fxb+bO6S7o5GWsN9Wd88yGMlXPYsyvVp5skLMjU7/KlDObCa5mNnuHPCLImCmbX170GkSUkH4P9QB0idhatxgLpH3pXditSRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710030; c=relaxed/simple;
	bh=3miv1F1A4Z9ag8W8Ix9bhPQcIbViWenNhqk5fc3VAQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ho+GI2spVN5yCJrkrog083YbO5h5VytobPGLsa9/vIelhyAlG9/FS/7DvcLDi/bv7zddlKvhYWveRFiFzAs+w1emxUqM8us/taQ+hJYY3LHK0SK+eGpa1PFNQV+EtZvjlseaiwY2CW/KZCbwfepK32cfYiB8XDv9j1WDeUECOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0bgZlu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0C1C4CEC7;
	Mon, 30 Sep 2024 15:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727710029;
	bh=3miv1F1A4Z9ag8W8Ix9bhPQcIbViWenNhqk5fc3VAQc=;
	h=Date:From:To:Cc:Subject:From;
	b=J0bgZlu58lfG/qPZxD+x0AbJIuqgTNO9kUA0z6s1o4sjK5OysREnLMbSG3CWvkksS
	 nXrFri9KIO20p7PHBG0LWBw82HmkwIdCZUv2Zdaic0dUTRRxltv+k2QVQYS0dcXRys
	 QEvtrUQeqg2KCb1B8g+P6XeFatPUDXgC0Dp2XIYajTZOiV21+ogf/eiKnlmD50pLHK
	 7Eux7QQFyTNTvem/srDSZG1RM4Qi9sBsVF5aAfOToYLDmwxiukGJtoB2uyb0+JW+YQ
	 yCE3GfMMJGvD3jCWvjkHKumB4LrzS2r6fzv3cao5xEY4UoTseVkfU2eBj89WNE9Oim
	 a1OtzpVuvkveA==
Date: Mon, 30 Sep 2024 12:27:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/1 fyi] tools include UAPI: Sync linux/sched.h copy with the
 kernel sources
Message-ID: <ZvrDShNVXotZpiwk@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

Picking the changes from:

  f0e1a0643a59bf1f ("sched_ext: Implement BPF extensible scheduler class")

The inclusion of the SCHED_EXT define doesn't cause any change in
behaviour in tools/perf.

This just silences this perf tools build warning:

  diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/uapi/linux/sched.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/sched.h b/tools/perf/trace/beauty/include/uapi/linux/sched.h
index 3bac0a8ceab26ee7..359a14cc76a4038a 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/sched.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/sched.h
@@ -118,6 +118,7 @@ struct clone_args {
 /* SCHED_ISO: reserved but not implemented yet */
 #define SCHED_IDLE		5
 #define SCHED_DEADLINE		6
+#define SCHED_EXT		7
 
 /* Can be ORed in to make sure the process is reverted back to SCHED_NORMAL on fork */
 #define SCHED_RESET_ON_FORK     0x40000000
-- 
2.46.0


