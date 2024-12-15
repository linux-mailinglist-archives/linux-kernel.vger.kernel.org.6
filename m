Return-Path: <linux-kernel+bounces-446349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60EC9F2325
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 11:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA444164590
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128EF14900F;
	Sun, 15 Dec 2024 10:24:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC814320E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734258297; cv=none; b=kZ+B83jkycse/stVB27B0GuD/I26d/3xBMLEdGyhF1e1ebqhvvHAom5ADZWx2vQHrIPKTxxLn/ImgkK0671H3KD7kKwGc4mZowD0mh+Z44VofYmcqmeASvRH1h+0B+ycWA3pq0pbY/LIGogpS337gZfrZ+1LE2y55byrsgs2+H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734258297; c=relaxed/simple;
	bh=8K9Du3Rw2sSzQ/IpsCCij734zu3MgQjVtSnNaKZzMRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kieeZlGhGdp1fIn89n+U2mT1vrfL1o61E1cQZjt6W42+xqabdMnATXpGuv0YdE1fUXcnouXdIGirCq0uxjLpNfRP0M+k3cNEgAAyNjvtXUEx7x70sDTh4jf73OSND3xV8JzAbPhPl26+7JRxkfAyV7FraJySxhBPEyQ1NA3s3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B2AC4CECE;
	Sun, 15 Dec 2024 10:24:56 +0000 (UTC)
Date: Sun, 15 Dec 2024 05:25:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241215052526.7f0cdc5b@gandalf.local.home>
In-Reply-To: <20241215050517.050e9d83@gandalf.local.home>
References: <20241214182138.4e7984a2@batman.local.home>
	<CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
	<20241214220403.03a8f5d0@gandalf.local.home>
	<20241214221212.38cc22c3@gandalf.local.home>
	<CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
	<CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
	<20241214233855.46ad80e0@gandalf.local.home>
	<CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
	<20241215050517.050e9d83@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 05:05:17 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> That commit fixes the iter->fmt being passed into the function by making
> the assumption that p will iterate over the temp buffer. It has nothing to
> do with the current code that hasn't seen a bug since 2022, and has stopped
> constant "%s" bugs since then.

In fact, I could have fixed this with this one line change:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index be62f0ea1814..d990687335b1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3722,6 +3722,10 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 	if (static_branch_unlikely(&trace_no_verify))
 		goto print;
 
+	/* If hash-ptr is not set, the fmt points to our temp buffer */
+	if (p == iter->fmt)
+		goto print;
+
 	/*
 	 * When the kernel is booted with the tp_printk command line
 	 * parameter, trace events go directly through to printk().


-- Steve

