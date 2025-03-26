Return-Path: <linux-kernel+bounces-577181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA206A71993
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02C43A8123
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057BC1F3FD1;
	Wed, 26 Mar 2025 14:55:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949741F30CC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000917; cv=none; b=ubUHcds+DTLajq139Fm20wb4NHYU+7OZsxkepwx8AJi23RyNjli5Up9ZLWao42s5/9WOsnecHN7dkNaqnWvq8hAgBGwEaQp7VQqlsBn+4lC5n5vjnDQFH3/TX6qOe52n8MfN/1bsK5UmztvjmI0tU9yNkIdRVJIOGf7dZUMnddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000917; c=relaxed/simple;
	bh=scuDGNQP9rfdHCmAsIW4kDzxKfZEolkxKnk9DbU1EFs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=TfN4bzj5pLkMK6tKPv9loRblwMDlNylkh2i9gmJXao3/F9jyqU4Yaa5dbOW1hMuEMXjrFzWpLKTv0zVuRmfOjJEndtvPFERDb9L0c36/Jm1bofoPbX5voxAS/G14Y+h1bM7DHgH9A2uyJka3snZPecBWDl/Dsnv2GOeiIYm8ICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094BFC4CEE2;
	Wed, 26 Mar 2025 14:55:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txSAl-00000002kC7-3ExQ;
	Wed, 26 Mar 2025 10:56:03 -0400
Message-ID: <20250326145549.978154551@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Mar 2025 10:55:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 0/9] rtla: Updates for 6.15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/for-next

Head SHA1: 732032692f6ae311bc35159b18e5b7c5e64010fc


John Kacur (1):
      rtla: Add the ability to create ctags and etags

Tomas Glozar (8):
      tools/build: Use SYSTEM_BPFTOOL for system bpftool
      rtla: Fix segfault in save_trace_to_file call
      rtla/osnoise: Unify params struct
      rtla: Unify apply_config between top and hist
      rtla/osnoise: Set OSNOISE_WORKLOAD to true
      rtla: Always set all tracer options
      rtla/tests: Reset osnoise options before check
      rtla/tests: Test setting default options

----
 tools/build/feature/Makefile           |   2 +-
 tools/scripts/Makefile.include         |   2 +-
 tools/tracing/rtla/Makefile            |   2 +-
 tools/tracing/rtla/Makefile.rtla       |  17 ++++-
 tools/tracing/rtla/src/osnoise.c       |  86 ++++++++++++++++++++++-
 tools/tracing/rtla/src/osnoise.h       |  48 +++++++++++++
 tools/tracing/rtla/src/osnoise_hist.c  | 121 +++++---------------------------
 tools/tracing/rtla/src/osnoise_top.c   | 123 ++++-----------------------------
 tools/tracing/rtla/src/timerlat.c      | 106 ++++++++++++++++++++++++++++
 tools/tracing/rtla/src/timerlat.h      |  12 ++--
 tools/tracing/rtla/src/timerlat_hist.c | 122 +++++---------------------------
 tools/tracing/rtla/src/timerlat_top.c  | 113 ++++--------------------------
 tools/tracing/rtla/src/trace.c         |   2 +-
 tools/tracing/rtla/tests/engine.sh     |  66 ++++++++++++++++++
 tools/tracing/rtla/tests/osnoise.t     |   6 ++
 15 files changed, 397 insertions(+), 431 deletions(-)

