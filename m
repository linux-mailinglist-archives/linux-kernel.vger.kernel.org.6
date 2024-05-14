Return-Path: <linux-kernel+bounces-178930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41028C5987
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F7B1C2176E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1CF1802B8;
	Tue, 14 May 2024 16:16:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E883F17F394
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703365; cv=none; b=CoEq+tLqknt8DyO2qeHPBpovVKKSKQysxbJEGQE0n6wQnV4sE6XdqT/wmLjyxEYVkl3yHRxjTs0+Q1cwZlzXDC56pYcT1bf9Y7dGEvuQOmf1eXiInqZPggFy6HKrhnIN2AY3wRW5tlm/jRKy9UyjLdjrnmycUJ75EcSJvG0VgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703365; c=relaxed/simple;
	bh=tKNrtit3+nE6gDNwsOEgPVm9M0Mdw0ErmGEv3KHMRFs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=msXi1aW9jWfrrBpkN1cw9UJHDEV0WkGQZK5Z6eTA81dArF5E7V6KETG7K/5PjY7xrlAGC/rep4AvQpLD5IUHovppCG3K6TASSbwIHEH7PE+9E3Yx1PPnuZAT/XQbdTB6QKQKBs/k4vRnLesICvNVlFuTQ6yvvJxARm0DMDkRPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DA4C2BD10;
	Tue, 14 May 2024 16:16:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s6upK-00000003tBh-0OGs;
	Tue, 14 May 2024 12:16:30 -0400
Message-ID: <20240514161558.664348429@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 14 May 2024 12:15:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/6] ring-buffer: Memmory mapping the ring buffer to user space
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

ring-buffer/for-next

Head SHA1: fe832be05a8eee5f1488cbcc2c562dd82d079fd6


Steven Rostedt (Google) (1):
      ring-buffer: Have mmapped ring buffer keep track of missed events

Vincent Donnefort (5):
      ring-buffer: Allocate sub-buffers with __GFP_COMP
      ring-buffer: Introducing ring-buffer mapping functions
      tracing: Allow user-space mapping of the ring-buffer
      Documentation: tracing: Add ring-buffer mapping
      ring-buffer/selftest: Add ring-buffer mapping test

----
 Documentation/trace/index.rst                  |   1 +
 Documentation/trace/ring-buffer-map.rst        | 106 ++++++
 include/linux/ring_buffer.h                    |   6 +
 include/uapi/linux/trace_mmap.h                |  48 +++
 kernel/trace/ring_buffer.c                     | 471 ++++++++++++++++++++++++-
 kernel/trace/trace.c                           | 104 +++++-
 kernel/trace/trace.h                           |   1 +
 tools/testing/selftests/ring-buffer/.gitignore |   1 +
 tools/testing/selftests/ring-buffer/Makefile   |   8 +
 tools/testing/selftests/ring-buffer/config     |   2 +
 tools/testing/selftests/ring-buffer/map_test.c | 294 +++++++++++++++
 11 files changed, 1026 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/.gitignore
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c

