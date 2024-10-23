Return-Path: <linux-kernel+bounces-378274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6209ACD77
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA1DB20379
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F2C1C9B86;
	Wed, 23 Oct 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1UZBIip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2537C1C9DF6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694163; cv=none; b=IgX5cSqKoV/nMSayxZvRCNwglNebq72zywp88L2Uv8CROd3Xutl9ryslpEwloaPuRAJSxz9hFRdi84y9ohcUIoOxoAdqSfkVPxjtSbcUWzPOnf2mCN8YtAbyqE7uGXJPPgFfaJx9tVoZ1kclszCFRQ4YsWazGpeYoqLTxatbus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694163; c=relaxed/simple;
	bh=5xeFwBGTQ2v2Q53kSF9LhE2WT28J9kwe+vfFMiYzsFI=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=aRVo3jQllVcoMGEinUG2BhuRVhYT2pvKVtlFosVtX/PqyfweHakcnwsLA6BPUIKAdJRszair7rm3UTuL4cmOJ9Gcoxfw3ISMUvFEbRJ/8+Uf+iOSyqh8o8Zxw9OA0xyn9qI8rDA0w6L5Uw3EbUq/vntzIXgjVU9SGY9kumPdXDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1UZBIip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7B3C4CEC6;
	Wed, 23 Oct 2024 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729694163;
	bh=5xeFwBGTQ2v2Q53kSF9LhE2WT28J9kwe+vfFMiYzsFI=;
	h=Date:From:To:Cc:Subject:From;
	b=T1UZBIipF7+uoy29qonSB070OO3YpkWYpxr7vQcs6Qpz3BwvAaCMJf/eGL2FH406w
	 fwkE1jh9gD1uUEvStRCbDaJJhN/afpCzqUP6pSu4u1UCvi+tNuAU77QOWLhpMD+MC8
	 A+laJVKVt161mLPoBbcidm2hW3RTDd/Sxb/vq+RKsZOpETgbOdonaxVs9ZjYWIY9O5
	 R4oJLr1CeMd0AHJJsG+Ypz68T2fuN3ZJ6awYsKXtTkpXFQZ9UdXh99S5ZUXZT/3Tdh
	 UgUt1zr8WcxItpdh2sBhRd3QadP80EYcixmCvL+uXddpID9CbhEMBiAlPrjc/Cq0+y
	 WYdGo8rbkP+3w==
Date: Wed, 23 Oct 2024 23:36:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Leo Yan <leo.yan@arm.com>, Mikel Rychliski <mikel@mikelr.com>, Viktor
 Malik <vmalik@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] probes: Fixes for v6.12-rc4-2
Message-Id: <20241023233600.d309ab5fa8421e97d041bbc0@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes fixes for v6.12-rc4(2):

- objpool: Fix choosing allocation for percpu slots
  Fixes to allocate objpool's percpu slots correctly according to the
  GFP flag. It checks whether "any bit" in GFP_ATOMIC is set to choose
  the vmalloc source, but it should check "all bits" in GFP_ATOMIC flag
  is set, because GFP_ATOMIC is a combined flag.

- tracing/probes: Fix MAX_TRACE_ARGS limit handling
  If more than MAX_TRACE_ARGS are passed for creating a probe event, the
  entries over MAX_TRACE_ARG in trace_arg array are not initialized.
  Thus if the kernel accesses those entries, it crashes. This rejects
  creating event if the number of arguments is over MAX_TRACE_ARGS.

- tracing: Consider the NULL character when validating the event length
  A strlen() is used when parsing the event name, and the original code
  does not consider the terminal null byte. Thus it can pass the name
  1 byte longer than the buffer. This fixes to check it correctly.


Please pull the latest probes-fixes-v6.12-rc4.2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.12-rc4.2

Tag SHA1: 62eeda86599cd8c8fe92b4bc6181ef6d2c1e6e03
Head SHA1: 0b6e2e22cb23105fcb171ab92f0f7516c69c8471


Leo Yan (1):
      tracing: Consider the NULL character when validating the event length

Mikel Rychliski (1):
      tracing/probes: Fix MAX_TRACE_ARGS limit handling

Viktor Malik (1):
      objpool: fix choosing allocation for percpu slots

----
 kernel/trace/trace_eprobe.c | 7 ++++++-
 kernel/trace/trace_fprobe.c | 6 +++++-
 kernel/trace/trace_kprobe.c | 6 +++++-
 kernel/trace/trace_probe.c  | 2 +-
 kernel/trace/trace_uprobe.c | 4 +++-
 lib/objpool.c               | 2 +-
 6 files changed, 21 insertions(+), 6 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

