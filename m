Return-Path: <linux-kernel+bounces-523892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1DDA3DC88
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF8219C3A38
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE01FC0ED;
	Thu, 20 Feb 2025 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPRzJH9l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B71DE4DB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061143; cv=none; b=EcrniWvhr2zbd5BrpZi6r0VseNnV7qclYPbKW0M0Z5LpF+0+709KipKOn0vfs2L1+u0rn/PiPd+J/e+H1vIgKiJKfNj29O41lnj2DY03ePBbtm22cLyEtW8qwXRN9l7F/JKWf2A0CTr3dD/bkivI6eQOZ1s7WzaRbkueitqR2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061143; c=relaxed/simple;
	bh=QDV5g8FGlk1PKGA8+qOmRMSnu6kXIaPu1NrxOeUEEus=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=V8DRmt4+crQvJSvoeiLw/SfgEg/VDNrLk4zzOls7AfsnKXl3pn3WPRUG9GPN64Huus4MWa9NiE8/rFHy6LOcsoyVrxXm56KhubU6CY4xDd/H1eleJxZd3ys1UFh4AtXKCe6Zad93BFFeqZwssY0olPX7/PYUz94kA1mb6QKVCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPRzJH9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D753C4CED1;
	Thu, 20 Feb 2025 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740061142;
	bh=QDV5g8FGlk1PKGA8+qOmRMSnu6kXIaPu1NrxOeUEEus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CPRzJH9lrL89V6GMsTdLhx5uSzTjLkgR4NcbDpLlxeN5/whY5+WadHOWnxq2xU5X9
	 MJLqxOiGMBwVRiCxyGo8UJxa7u3OedspofMhEI5cpGZG4vecSvTioze9vhtED4yJSJ
	 rugBuKxRhNaTSxtH6NsOAJQPZ6UV1L0fhe/JSG9A3kiRaq8CdiK+7hHoUAAQJTBGc6
	 B04qJ3OgZlVaOUmtEOit08B65sZAjxI68TrQ0CX6u7H0LJqcp5Kkf7ppOBJCC3JFtf
	 LPeOfC+QdL3A2D5hKjTi6mODWTvO7/WQSVPIHMfQvEp1QdOxwyRqWje4tesSxTcKRR
	 Yu45u3fuZVLFw==
Date: Thu, 20 Feb 2025 23:18:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Lance Yang <ioworker0@gmail.com>, mhiramat@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>, Anna
 Schumaker <anna.schumaker@oracle.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, Steven
 Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, Linux
 Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 0/2] hung_task: Dump the blocking task stacktrace
Message-Id: <20250220231857.6e377e5f208b60a7ba303cea@kernel.org>
In-Reply-To: <8ca57548-4b18-401d-bfda-95bc12216adf@redhat.com>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<CAK1f24knkxX34hNLRjT20mjyyOwasmXgXJBbTDX=7WYwiw9S1g@mail.gmail.com>
	<CAK1f24m-Ci3BvgfVYGW2tFSUEkPwiO9=0M_w4kpOt1qViiDXdg@mail.gmail.com>
	<8ca57548-4b18-401d-bfda-95bc12216adf@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 19 Feb 2025 15:20:39 -0500
Waiman Long <llong@redhat.com> wrote:

> 
> On 2/19/25 10:02 AM, Lance Yang wrote:
> > On Wed, Feb 19, 2025 at 9:33 PM Lance Yang <ioworker0@gmail.com> wrote:
> >> CC linux-mm
> >>
> >> On Wed, Feb 19, 2025 at 9:00 PM Masami Hiramatsu (Google)
> >> <mhiramat@kernel.org> wrote:
> >>> Hi,
> >>>
> >>> The hung_task detector is very useful for detecting the lockup.
> >>> However, since it only dumps the blocked (uninterruptible sleep)
> >>> processes, it is not enough to identify the root cause of that
> >>> lockup.
> >>>
> >>> For example, if a process holds a mutex and sleep an event in
> >>> interruptible state long time, the other processes will wait on
> >>> the mutex in uninterruptible state. In this case, the waiter
> >>> processes are dumped, but the blocker process is not shown
> >>> because it is sleep in interruptible state.
> > Cool! I just ran into something similar today, but with rwsem. In that
> > case, the blocked process was locked up, and we could not identify
> > the root cause either ;(
> 
> Once this patch series is settled down, we can extend rwsem to provide 
> similar feature.

While discussing about rwsem with Sergey, he pointed that we can not
identify a single blocker on rwsem, because several readers can block
several writers. In this case, we need to dump all of them but we
don't have such info.

So anyway, I would like to start from mutex, which is the simplest one.
For the other locks, we will discuss later. (or start with limited
support, like showing only rwsem::owner)

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

