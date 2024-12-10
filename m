Return-Path: <linux-kernel+bounces-439729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 901119EB34A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CC41887BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6301AC450;
	Tue, 10 Dec 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSilVU6e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B6C1AAA13
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840969; cv=none; b=MDUqcc/9KOMuebiPm9EcxUpy5vz4NMOiE2xoOwI3asroleNhjgRc5UWr4zwp7wpYO9fW/X65nhqQDZqhv6W8uw3nDDKtGZvOgvcMwRdII5n/PFsubXaW5YVciaQexUqLRSNikywOZjGqpksKMazqMEQLI0w7B4u1VAeS0Iwms8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840969; c=relaxed/simple;
	bh=VcHPTYXG7cR9wsKgG47kMNZjM7W7mq+WawPJlZb6SXU=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=dG4OvH3Aeu5K+Bj/UYKcqJDK8ail/XSp9uOarr7TAFYArBsATi1N76VGA0j6JYlx31HD9Zez7jMGvyzPIsrxjgj98MsQRVjS7iSE+KX/qIc6S/KCyqPP7DDBbuXdhpE+zBkoyV2ibuEZR+8YECQAOcxY1vitFf5XlURtzh31Nco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSilVU6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7466CC4CED6;
	Tue, 10 Dec 2024 14:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733840968;
	bh=VcHPTYXG7cR9wsKgG47kMNZjM7W7mq+WawPJlZb6SXU=;
	h=Date:From:To:Cc:Subject:From;
	b=VSilVU6e4T5/8cehmJGJLwsARHSYuFyQVgFie/ZE26PKdw0wjTvtUyUxNn7v+Vs7Q
	 udOAJogo5+tbqAL31ZS7T1bDantx+se4snA3J6Y7c41WMCwl07xmLHJgGjou+AhVTt
	 pCxxl3yn/4vJ60K0ATNjqMnoS2hg+TLWllRTVpEqMNWmeneWqeSKF7Q+pLJ0q6erY0
	 gpjkFewCSsAB/TyJOfUHcNlyUO2dwDC7O9aZ9qqLskQMo05eQ0BfPOOvPw3DmfHKeq
	 ax+4dKZPeID/rxViHvvp7Tf9GpqS/qmupZzzhCIVk97vOrsevIAtFDvwKUCi6USvua
	 XCEavyhDGfOwQ==
Date: Tue, 10 Dec 2024 23:29:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.13-rc1
Message-Id: <20241210232920.d10face123275fef39ecfb6b@kernel.org>
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

Probes fixes for v6.13-rc1:

- eprobes: Fix to release eprobe when failed to add dyn_event.
  This unregisters event call and release eprobe when it fails to add
  a dynamic event. Found in cleaning up.


Please pull the latest probes-fixes-v6.13-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.13-rc1

Tag SHA1: 6c325e49ea23bdadf663c85fa87d11294a009e35
Head SHA1: 494b332064c0ce2f7392fa92632bc50191c1b517


Masami Hiramatsu (Google) (1):
      tracing/eprobe: Fix to release eprobe when failed to add dyn_event

----
 kernel/trace/trace_eprobe.c | 5 +++++
 1 file changed, 5 insertions(+)
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

