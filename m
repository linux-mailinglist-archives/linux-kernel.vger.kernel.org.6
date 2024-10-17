Return-Path: <linux-kernel+bounces-369925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C484F9A248C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C4CB233D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7889D1DE3CB;
	Thu, 17 Oct 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZW8x0Jq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388991DDC3C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174185; cv=none; b=nxFU3ho4SrApYwGuweQW3P1T+t/lqvcHjqdo/dnQUhOJQRFOIiBL8+5wNckzUStwYxzzIE1D8e+HQmUGdoIrgklf8Qt1Fou4bhF2rFDHBzTZQjxBhURar4SV8IVHnvx/SeqcAAjdNMxHiEf2UN4Ie/fhsuomV7cIcnV/UeNPJDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174185; c=relaxed/simple;
	bh=zf9X5WW010Iu6VZwadiwhBxjeKnYSBLT8pczlZCSZjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P59Tm43Ke7xwq3NDEYIFCNIw5Tu2cCXw65apmgIhFXfqxdjMd3IGeLv/E2gdmGSXX3lTy+YrL+TO6jYJPe/yLTkeoeX9A00/eQhdnnHunqBBmkGN0Xn81moLbbO0FWxvg63BmDUnXwnbN/qGiD7srTHDmqse7SS25Lw2w8VDyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZW8x0Jq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729174183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lS3XCuwdjC1DKJQJRbWG8+XzGx7VU0HgoCPB9kXKW2w=;
	b=NZW8x0Jqb5xaDyRl49dxrZ894k9A9VhW3QWYO0MagRAqQ2m3A05GKDTKAVQC+H/QbDSHAk
	8n8OpObXyiN9NzaBQyRnPRnW2CbfWocXsuU+wIfDKz+DYVguTf78qUI8zDO4Ze6fcGSRWV
	rynXHzM0xr4wJWZ/iJh0J8WASvroTj8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-hboI29hWNJSQJZ8DqfLByw-1; Thu,
 17 Oct 2024 10:09:42 -0400
X-MC-Unique: hboI29hWNJSQJZ8DqfLByw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECEB41955D45;
	Thu, 17 Oct 2024 14:09:40 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E04619560AD;
	Thu, 17 Oct 2024 14:09:38 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v5 0/6] rtla: Support idle state disabling via libcpupower in timerlat
Date: Thu, 17 Oct 2024 16:09:08 +0200
Message-ID: <20241017140914.3200454-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Tomas Glozar <tglozar@redhat.com>


rtla-timerlat allows reducing latency on wake up from idle by setting
/dev/cpu_dma_latency during the timerlat measurement. This has an effect on
the idle states of all CPUs, including those which are not used by timerlat.

Add option --deepest-idle-state that allows limiting the idle state only on cpus
where the timerlat measurement is running.

libcpupower is used to do the disabling of idle states via the corresponding
sysfs interface.

v2:
- Split patch adding dependency on libcpupower to two patches, one for
libcpupower detection and one for rtla libcpupower dependency.
- Make building against libcpupower optional. rtla will throw an error
when built without libcpupower and --deepest-idle-state is used.
- Rename option from --disable-idle-states to --deepest-idle-state and
add an argument to choose the deepest idle state the CPU is allowed to
get into. -1 can be used to disable all idle states: this is useful on
non-ACPI platforms, where idle state 0 can be an actual idle state with
an exit latency rather than a representation of an active CPU, as with the
ACPI C0 state.

Note: It is also possible to retrieve the latency for individual idle states
of a cpu by calling cpuidle_state_latency. This could be used to implement
another rtla option that would take the maximum latency, like --dma-latency
does, and which would only take effect on CPUs used by timerlat.

My opinion is that this proposed feature should not replace either
--dma-latency nor --deepest-idle-state. For the former, there might be
systems which have /dev/cpu_dma_latency but don't have a cpuidle
implementation; for the latter, in many cases the user will want to set
the idle state rather than the latency itself.

v3:
- Remove unneeded NULL check before free in restore_cpu_idle_disable_state
and free_cpu_idle_disable_states.
- Check for calloc() returning NULL in save_cpu_idle_disable_state.
- Check for saved_cpu_idle_disable_state existing in
restore_cpu_idle_disable_state.
- Implement dummy functions for libcpupower functionality if libcpupower is
not present during build. That allows libcpupower presence to be checked
through a special function at one place instead of using several #ifdefs.
- Only call sysconf() once when iterating through all CPUs. Note that there
are a few instances in the original code which keep on calling sysconf()
multiple times; fixing that is for another patch.

v4:
- Swap check for saved_cpu_idle_disable_state and nr_states == 0 in
restore_cpu_idle_disable_state to avoid error in case there are no
idle states for the CPUs timerlat is to run on.

v5:
- Added tools/build/feature/test-libcpupower.c which was accidentally
omitted from the patchset since v2.
- Do not try to detect libcpupower via pkg-config, it does not have
a .pc file and the detection just errors out. Instead, simply add
-lcpupower to EXTLIBS to link libcpupower properly.

Tomas Glozar (6):
  tools/build: Add libcpupower dependency detection
  rtla: Add optional dependency on libcpupower
  rtla/utils: Add idle state disabling via libcpupower
  rtla/timerlat: Add --deepest-idle-state for top
  rtla/timerlat: Add --deepest-idle-state for hist
  rtla: Documentation: Mention --deepest-idle-state

 .../tools/rtla/common_timerlat_options.rst    |   8 +
 tools/build/Makefile.feature                  |   1 +
 tools/build/feature/Makefile                  |   4 +
 tools/build/feature/test-libcpupower.c        |   8 +
 tools/tracing/rtla/Makefile                   |   2 +
 tools/tracing/rtla/Makefile.config            |  10 ++
 tools/tracing/rtla/README.txt                 |   4 +
 tools/tracing/rtla/src/timerlat_hist.c        |  42 ++++-
 tools/tracing/rtla/src/timerlat_top.c         |  42 ++++-
 tools/tracing/rtla/src/utils.c                | 150 ++++++++++++++++++
 tools/tracing/rtla/src/utils.h                |  13 ++
 11 files changed, 282 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/feature/test-libcpupower.c

-- 
2.47.0


