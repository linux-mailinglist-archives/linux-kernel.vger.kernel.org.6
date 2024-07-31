Return-Path: <linux-kernel+bounces-268791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F355942950
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516DC2846FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463D1A8C03;
	Wed, 31 Jul 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTaHF/So"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFE18B480
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415130; cv=none; b=dPQt7LWAA76zTTgzN/6iVmqdYxy+yoDDC66YoyV4pjfjwMT0GhBH69jYJzkEqGhiWxDXGEjqZu2g3kBgn4QAUfeiL1GAYXvBxX4TJj/mqps3pPl7rM0mmNNq1iAs5RwyRS8EClw5GpxfsP0hs5nFwU01fulpTe+O4EV7sxLEYXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415130; c=relaxed/simple;
	bh=TYuM2Qyx5m4eXjldmdhrRfploKZMlHPRrqR5pbbArBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5RkqRpV9tMjGSb6PrxGIBs2WmnLXRqiL6L5IOajJjySk+W2MCauUZDW7hLklX/m+hUsdlEOfJST+Ue7iKmUXwa5iSbfQ7HLpr7yPBpkl9dFLgc82WOH1IVgEYMoPp0s5W3mp8RMmqx3eTji9eS1bJQYNSLNHgb/N6dLz9qeA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTaHF/So; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722415126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M0/XfQheFkcXv5hhJ/BMk+Zu+dmZjQ8ZUt/ETM+zdtg=;
	b=YTaHF/SocieuKC5KWrb5Nd2fU1A+CyjR2PYNvtPco9IL1LDOVmQ/LOFKpj9Yub+mfDkP7D
	/NMalFaic4jg6MrCN4MnADWz5eGmbdP/DUcSfUOS2nBgrHiR3+vZCQWGr6rZ15gZoLY2+a
	qnmbIm+9bDBPceVaVu+7dXytEE8pxrM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-3pt_oLCPNhST12WnKtnrIA-1; Wed,
 31 Jul 2024 04:38:42 -0400
X-MC-Unique: 3pt_oLCPNhST12WnKtnrIA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 448871955D48;
	Wed, 31 Jul 2024 08:38:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB6503000197;
	Wed, 31 Jul 2024 08:38:38 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 0/6] rtla: Support idle state disabling via libcpupower in timerlat
Date: Wed, 31 Jul 2024 10:36:49 +0200
Message-ID: <20240731083655.375293-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
 tools/tracing/rtla/Makefile                   |   2 +
 tools/tracing/rtla/Makefile.config            |  10 ++
 tools/tracing/rtla/README.txt                 |   4 +
 tools/tracing/rtla/src/timerlat_hist.c        |  46 +++++-
 tools/tracing/rtla/src/timerlat_top.c         |  46 +++++-
 tools/tracing/rtla/src/utils.c                | 140 ++++++++++++++++++
 tools/tracing/rtla/src/utils.h                |   6 +
 10 files changed, 265 insertions(+), 2 deletions(-)

-- 
2.45.2


