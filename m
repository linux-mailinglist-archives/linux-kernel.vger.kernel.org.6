Return-Path: <linux-kernel+bounces-516000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9BCA36BD2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B74172A1E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A741624C8;
	Sat, 15 Feb 2025 03:52:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95A17C61
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591568; cv=none; b=uhwqnd3dCI0JC/+1WB6riGzyeocMZ4b34E99Fb5cseHdezrq7PrG8z539adOB36b+XY3gyOWwMEwCxpDmjw9k2wi1cpLxUdr6qIoIyW0HFT3CKdGcINftEQZUxA99ZYtkfJr/igWnTJYSgRYuhORVkLl5/qGo6afBJIa7+tZVJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591568; c=relaxed/simple;
	bh=MkI9jQ9fqjw55EXvCJTE0HEsx8IYnFIAJA5xA8KjY2s=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Dn4V9dPSjzA4ushQkUyH737eSirKMDY4cip/r0HCLqG8GM/urKP066mD6xjHFEqGUVdw6pNXQnDNvdNGatXWinJUJ1Ewm+yt/pq2pCdmr00wr7MhJpr2D+HqXVHaJHKrl/AJO+yLxXF3nRKyumIOciZWVlYS41IzUAd7Qmh3QQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502EBC4CEE4;
	Sat, 15 Feb 2025 03:52:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tj9Ek-00000002hDW-0i4q;
	Fri, 14 Feb 2025 22:53:02 -0500
Message-ID: <20250215035231.786853904@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Feb 2025 22:52:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] ring-buffer: Fixes for v6.14
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/fixes

Head SHA1: b9b289edd70d130f489317bbd04c2103053a77e3


Steven Rostedt (5):
      ring-buffer: Unlock resize on mmap error
      tracing: Have the error of __tracing_resize_ring_buffer() passed to user
      ring-buffer: Validate the persistent meta data subbuf array
      tracing: Do not allow mmap() of persistent ring buffer
      ring-buffer: Update pages_touched to reflect persistent buffer content

----
 kernel/trace/ring_buffer.c | 28 ++++++++++++++++++++++++++--
 kernel/trace/trace.c       | 12 +++++-------
 2 files changed, 31 insertions(+), 9 deletions(-)

