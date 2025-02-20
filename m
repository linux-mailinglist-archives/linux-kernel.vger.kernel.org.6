Return-Path: <linux-kernel+bounces-522907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BD4A3CFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5580E189940D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51B1DC991;
	Thu, 20 Feb 2025 03:11:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666D1D7E30
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021080; cv=none; b=ieUPCo96ghsUIvoIa0GjpU5W19N2YKOh+j5CJuGoakKFAIgfIY62n/EJQb624k/foUzWzVemRIStI7AFK7Zp/S1SYvOTVRVduMuDtAPWoASBMKMPhqWV7c/JtK8DhuJdSyIXQYfP9Wkj2me4fOhhgFAJeWEgGDAiJszkJPcac40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021080; c=relaxed/simple;
	bh=wUWP3fDsHHSizt/qcvRdRHUGTjHDHORenMJRrzhVPAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWKcgfr8dhgIAq/Awz6YgBciO12jZPe6TVdl5otu1CZYYDoEGGCqewOtWb4v6UQ57nqlePXnndqcsGWcXhuu4OTeOMYDmdBZGmRzi3+sZYxgR/HBxODVXKWRcsLwQbF7KF70YSMkW8k1bmDPC7Quq+1Cii5WHm/tZiCN+k8l4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CEFC4CED1;
	Thu, 20 Feb 2025 03:11:16 +0000 (UTC)
Date: Wed, 19 Feb 2025 22:11:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Waiman Long <llong@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, Joel
 Granados <joel.granados@kernel.org>, Anna Schumaker
 <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, Kent
 Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, Linux
 Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <20250219221141.09f9fe48@gandalf.local.home>
In-Reply-To: <20250220114036.e22e388402a00f7809a81dee@kernel.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
	<20250219152435.35077ac3@gandalf.local.home>
	<db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
	<20250220075639.298616eb494248d390417977@kernel.org>
	<d8c01f69-34c0-45cf-a532-83544a3a3efd@redhat.com>
	<20250219204153.65ed1f5e@gandalf.local.home>
	<20250220114036.e22e388402a00f7809a81dee@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 11:40:36 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hmm, right.
> Since the blocked_on must be NULL before setting flag, if we can ensure
> the writing order so that blocked_flags is always updated before
> blocked_on, may it be safe?
> 
> Or, (this may introduce more memory overhead) don't use union but
> use different blocked_on_mutex, blocked_on_rwsem, etc. 
> 
> Another idea is to make the owner offset same, like introducing
> 
> struct common_lock {
> 	atomic_long_t owner;
> };
> 
> But the problem is that rt_mutex does not use atomic for storing
> the owner. (we can make it atomic using wrapper)

Either that, or add to the task_struct:

	struct mutex	*blocked_on_mutex;
	struct rwsem	*blocked_on_rwsem;
	struct rtlock	*blocked_on_rtlock;

And just have each type assign to its own type. Then you only need to look
at each one. But yeah, this adds even more bloat to task_struct.

  :-/

-- Steve

