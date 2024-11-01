Return-Path: <linux-kernel+bounces-392734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7CD9B9797
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF0D1F23199
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3408C1CF29D;
	Fri,  1 Nov 2024 18:32:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8A1CEEB4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485977; cv=none; b=HS24XDQG04eiyIZXBoImaeSkBV8njW8cLTrLvZF+yVmBknVCJ7PGJKwox7p3ATWkHlNoJ8Yd7hkcru/nMpvEzEhYJlmBP+7VRnzjlyo1At5dGxm5KRbTWtmskksfxIBBpMCWUu7owJ6u2n3xWq4kwUZxVrjQcCbenIXpXL+OQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485977; c=relaxed/simple;
	bh=uvO2VQ1/+BRLTYLYeuDIqk39nV8y1krnr3D6rGy17Xk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=bgA+tgb0ocdG5tuV9mJxNVaeRfVkZ6uN5wNS0Ofl/QF2/yfIpDlYvN86W42QogmXgsRAEimX9wr+3deDYxnfVt0WDcJkX/CsD2ZKNkp71cbA3WU4wa6mAmwQmrglfdUEDSJFNa8Ad9AQGBrmejLbwkLZlUvUKATfluhXAPF9RBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D78EC4CECD;
	Fri,  1 Nov 2024 18:32:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6wT5-00000005X3J-1qsu;
	Fri, 01 Nov 2024 14:33:55 -0400
Message-ID: <20241101183327.693623203@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 14:33:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracefs: Fix mount options and add selftest
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Fix tracefs mount options:

The commit 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
broke the gid setting when set by fstab or other mount utility.
It is ignored when it is set. Fix the code so that it recognises the
option again and will honor the settings on mount at boot up.

Update the internal documentation and create a selftest to make sure
it doesn't break again in the future.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tracefs/fixes

Head SHA1: 8b55572e51805184353ee7d587c720a51818fb82


Kalesh Singh (3):
      tracing: Fix tracefs mount options
      tracing: Document tracefs gid mount option
      tracing/selftests: Add tracefs mount options test

----
 fs/tracefs/inode.c                                 |  12 ++-
 kernel/trace/trace.c                               |   4 +
 .../ftrace/test.d/00basic/mount_options.tc         | 101 +++++++++++++++++++++
 .../ftrace/test.d/00basic/test_ownership.tc        |  16 +---
 tools/testing/selftests/ftrace/test.d/functions    |  25 +++++
 5 files changed, 142 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc

