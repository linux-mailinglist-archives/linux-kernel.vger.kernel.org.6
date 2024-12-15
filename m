Return-Path: <linux-kernel+bounces-446293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A2F9F223C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27E01886E10
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF314C13D;
	Sun, 15 Dec 2024 05:04:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6689E23A9
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734239094; cv=none; b=SYZJllxHEHiMfzTP5lh8o/GDE7nf29Lu7YG8YL8+IrYCvMfPA/j+L02a37DhzorHz9QAMh9LWUW6gW5xqhFfbqZgF+U/HRUVfT+CSI99dNX9IibRJgil3HUHVWWSOSX55/YGpYkfQ/vFtAHtiBp2iP5bj9KyU3fnN5szdd4YIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734239094; c=relaxed/simple;
	bh=TPLvY7rNOfFrkZBEV5HvE2zS6hqoZeNgY+JB5egD3RE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1P6+UyLJ0bmlfvjORCklP93NTnCyP8aqQRR+TBGoA3tuM99fxfT0y2gSivYoDSpd4ZcUOf4rs7yp1jMrFRFSWQJoQO4oWcElaXxsV4bmVbZm5lQDsgacgw6+0d6sxqEwun5iEy8WUak79YT9DVxVYXCcq4ANR5ROt5pmXmYamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08441C4CECE;
	Sun, 15 Dec 2024 05:04:52 +0000 (UTC)
Date: Sun, 15 Dec 2024 00:05:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241215000522.227f26de@gandalf.local.home>
In-Reply-To: <20241215044843.GC1977892@ZenIV>
References: <20241214182138.4e7984a2@batman.local.home>
	<20241215044843.GC1977892@ZenIV>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 04:48:43 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> IOW, immediate fix is right, but the long-term fix suggested in pull request
> is not.

Actually, this requires HAVE_DYNAMIC_FTRACE_WITH_ARGS, because without
that, the fregs passed in could be NULL. fregs is guaranteed to be non-NULL
for all archs that have that set. As microblaze doesn't have that set, that
would be the fix.

I'll have to resend this pull request anyway depending on the outcome of
the first commit.

-- Steve

