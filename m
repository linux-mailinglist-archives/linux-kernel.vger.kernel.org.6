Return-Path: <linux-kernel+bounces-519682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68918A3A0A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E99D161E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F1C26AA8F;
	Tue, 18 Feb 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H71gqkxS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4326A1B9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890762; cv=none; b=rvwL1JvIoExfJG+7eBbKsl5/J7ZV3ams2qHem+Ib2KnMniWam2Koe2IJ9fSElyMlocxg1cxtd+UhA38D+wutQFcI7JQ16H69mx4KL7w2byxPlxDXYItxFfv27PkDQCaxUAn2plsYCui8lvl/39U7TYzO7T709+VtuDOI/PWZGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890762; c=relaxed/simple;
	bh=U4ttHmbROYWj+9w5SFXyLaGRJ+dCLm6fSJ85d5ZGqwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwMlZpe7904uZA5sPc5KjBFqk0R0EVb0ep0wF3IvtpxSrUF13RnYLQCFKD5uO/klC39psBb3+bpJ+C0Zrete9xX0d8XIxPw6HqT/qWwY0NtqmPrA+v+h17ZbgmjtX8l1JNRzSbAIdCfaCPnEg5/Dr96JIc/cCZXJ/tYS1Fk7+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H71gqkxS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739890759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3P5Bv7x56MBkd9Q05jft+aCiZKZJGmpB3DSAgOdj5TQ=;
	b=H71gqkxSn0Ga1rTvIs5RWg19GSH3XeQI9xyLbKZgEpZBDUopV7lZC1KgskzS+xeYwm6QQj
	niHxmRBseEi4FFayt1L3wivv/G3TqnA/oKgy/Nh5F4CouQkbTO2JdFaxEghQ6IPFUAvV5G
	NqTrnb1nVzdCPpTT/hY42EXFuPSHbOc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-j8lXVl8yObalA-vB5MJvRw-1; Tue,
 18 Feb 2025 09:59:15 -0500
X-MC-Unique: j8lXVl8yObalA-vB5MJvRw-1
X-Mimecast-MFC-AGG-ID: j8lXVl8yObalA-vB5MJvRw_1739890753
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F2F1180087D;
	Tue, 18 Feb 2025 14:59:13 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B121C1800361;
	Tue, 18 Feb 2025 14:59:10 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/8] rtla: Collect data using BPF program
Date: Tue, 18 Feb 2025 15:58:51 +0100
Message-ID: <20250218145859.27762-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The current implementation of rtla uses libtracefs and libtraceevent to
pull sample events generated by the timerlat tracer from the trace
buffer. rtla then processes the sample by updating the histogram and
summary (current, maximum, minimum, and sum values) as well as checks
if tracing has been stopped due to threshold overflow.

In use cases where a large number of samples is being generated, that
is, with measurements running on many CPUs and with a low interval,
this sample processing design causes a significant CPU load on the rtla
side. Furthermode, with >100 CPUs and 100us interval, rtla was reported
as not being able to keep up with the samples and dropping most of them,
leading to it being unusable.

A timerlat trace change was proposed [1] to implement an alternative
way of processing timerlat samples by the way of a trace event. This
patchset makes use of that by attaching a BPF program to the trace event
using the BPF skeleton feature of bpftool. One BPF program is shared
for both top and hist, operating in three different modes: top, hist,
and auto-analysis only. Data is collected using per-CPU BPF maps to
achieve maximum performance and avoid lock contention. The maps are then
processed in userspace when the data is to be displayed (at the end of
the run for hist and quiet top, once per second for regular top).

During the time of measurement, the new implementation is idle, waiting
for either a signal or threshold overflow. Unlike the current
implementation, the BPF implementation does not check whether tracing is
stopped (in BPF mode, tracing is always off to improve performance), but
waits for a write to a BPF ringbuffer instead. This allows rtla to exit
immediately when a threshold is violated, without waiting for the next
iteration of the while loop.

If the requirements for the BPF implementation are not met, either at
build time or at run time, the current implementation is used as
fallback. Which implementation is being used can be seen when running
rtla timerlat with "-D" option. rtla can be forced to run in non-BPF
mode by setting the RTLA_NO_BPF option to 1, for debugging purposes.

The BPF implementation has the following build requirements:
- libbpf 1.0.0 or later
- bpftool with skeleton support
- clang with BPF CO-RE support

Unlike perf, rtla does not build its own static libbpf and likewise
relies on system bpftool instead of using an in-tree one. In the future,
this might change if modern BPF features not commonly available on
Linux distributions are introduced.

The runtime requirements are as follows:
- BPF support enabled in the kernel
- libbpf library
- osnoise:timerlat_sample trace event present

No performance penalty was seen during testing on the timerlat tracer
side, as the performance of the BPF program is comparable to writing
the sample entry to the tracefs buffer. As rtla is idle during
measurements, except for printing the summary for timerlat-top in
non-quiet mode, the overall CPU usage is reduced significantly, and
the -H option to pin rtla to housekeeping CPUs becomes unnecessary for
most use cases.

Note: The unification of the timerlat_*_params struct was done to
enable the BPF implementation to be fully shared between top and hist,
besides the processing of the data. The plan is to avoid duplicate code
and instead continually merge the implementations of top and hist. top
was developed first, and currently, is essentially hist without
the histogram, and with some old code. Thus, I expect it to be possible
to fully merge it into the hist implementation in the future.

[1] https://lore.kernel.org/linux-trace-kernel/20250203090418.1458923-1-tglozar@redhat.com

Tomas Glozar (8):
  rtla/timerlat: Unify params struct
  tools/build: Add bpftool-skeletons feature test
  rtla: Add optional dependency on BPF tooling
  rtla/timerlat: Add BPF skeleton to collect samples
  rtla/timerlat_hist: Use BPF to collect samples
  rtla/timerlat_top: Move divisor to update
  rtla/timerlat_top: Use BPF to collect samples
  rtla/timerlat: Test BPF mode

 tools/build/Makefile.feature           |   3 +-
 tools/build/feature/Makefile           |   3 +
 tools/scripts/Makefile.include         |   3 +
 tools/tracing/rtla/.gitignore          |   1 +
 tools/tracing/rtla/Makefile            |  20 +-
 tools/tracing/rtla/Makefile.config     |  42 +++
 tools/tracing/rtla/src/Build           |   1 +
 tools/tracing/rtla/src/osnoise.h       |   2 +
 tools/tracing/rtla/src/timerlat.bpf.c  | 149 ++++++++++
 tools/tracing/rtla/src/timerlat.h      |  54 ++++
 tools/tracing/rtla/src/timerlat_aa.c   |   2 -
 tools/tracing/rtla/src/timerlat_bpf.c  | 166 +++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h  |  59 ++++
 tools/tracing/rtla/src/timerlat_hist.c | 229 +++++++++++-----
 tools/tracing/rtla/src/timerlat_top.c  | 366 +++++++++++++++++--------
 tools/tracing/rtla/tests/timerlat.t    |  14 +
 16 files changed, 923 insertions(+), 191 deletions(-)
 create mode 100644 tools/tracing/rtla/src/timerlat.bpf.c
 create mode 100644 tools/tracing/rtla/src/timerlat_bpf.c
 create mode 100644 tools/tracing/rtla/src/timerlat_bpf.h

-- 
2.48.1


