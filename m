Return-Path: <linux-kernel+bounces-522869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3559BA3CF6E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDF0189AF97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03DA1D6DA9;
	Thu, 20 Feb 2025 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy6oHLYv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9FE1D63E3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740019240; cv=none; b=qkT+9+Zht+9Ed5/k+Ez7pki3CR/YEUl2Jq1kdy4lf+V6H3n/wKBY4W8UpxL8lZ5fg/qELV5/UvwcMRcNlpltVM33tGC/E5S1E9TRAsDlHsktA8fdcEZFRbL75D4//Li8c4ts1p9UcXQlEIi5SR0Hc4g4HW9Fxx+pGlQNIKMbTFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740019240; c=relaxed/simple;
	bh=cZem6vk8RIlTJW54kI3MHj6xqDgsVXPXhU+70B7Qt2o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XrLxuWBgmWNUz345sY71gc4idYDRkYCGLJFLP/PjDpTNFKug742AHCp24uFt4ESqdPA4y3Ditp3GidjmH3jGHOm2mIo+vGc5xPIDvy7O2xjzoqumovAu1EaeGokhlFLzogjEXK02B0GW71O1tM9JgRW15ufFpeV4v7HptI6lZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy6oHLYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0C6C4CED1;
	Thu, 20 Feb 2025 02:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740019240;
	bh=cZem6vk8RIlTJW54kI3MHj6xqDgsVXPXhU+70B7Qt2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jy6oHLYvMtwLtyLJXKmfTufWlyI2tx2InFfzV/vBCExBM3Jk9BHkPNZ1fMP0WQnhL
	 dzS82FcU8WpM2+VJX7pFZTzpQujWozF7BKqtwYkc9yvvOWyfWTfjOPzj8s0bNewGLz
	 lGIXdIYh6oJ0hVVAxmJiTNBTztUJg/G+2hgPilwS6MhXOCe7ZI6G4ffy2N1vmkzjx3
	 S7CluCkVUzPTSQGpqpIKYrXSqahB7rL0+rA5vZRVgzvCP8t0VbBHtfIXs0gCetvVsh
	 Ysm7/mbVwLPwKkXnAQ8aFeE7g0xR3m6uF/ADOawFDCgLovtzIRpCUQ/GFBQaSsLEar
	 jjr0J5OjqGqhA==
Date: Thu, 20 Feb 2025 11:40:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Waiman Long <llong@redhat.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, Joel
 Granados <joel.granados@kernel.org>, Anna Schumaker
 <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, Kent
 Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, Linux
 Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-Id: <20250220114036.e22e388402a00f7809a81dee@kernel.org>
In-Reply-To: <20250219204153.65ed1f5e@gandalf.local.home>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
	<20250219152435.35077ac3@gandalf.local.home>
	<db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
	<20250220075639.298616eb494248d390417977@kernel.org>
	<d8c01f69-34c0-45cf-a532-83544a3a3efd@redhat.com>
	<20250219204153.65ed1f5e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 20:41:53 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 19 Feb 2025 20:36:13 -0500
> Waiman Long <llong@redhat.com> wrote:
> 
>  
> > >>>> this field, we don't need to take lock, though taking the wait_lock may
> > >>>> still be needed to examine other information inside the mutex.  
> > > Do we need to take it just for accessing owner, which is in an atomic?  
> > 
> > Right. I forgot it is an atomic_long_t. In that case, no lock should be 
> > needed.
> 
> Now if we have a two fields to read:
> 
> 	block_flags (for the type of lock) and blocked_on (for the lock)
> 
> We need a way to synchronize the two. What happens if we read the type, and
> the task wakes up and and then blocks on a different type of lock?

Hmm, right.
Since the blocked_on must be NULL before setting flag, if we can ensure
the writing order so that blocked_flags is always updated before
blocked_on, may it be safe?

Or, (this may introduce more memory overhead) don't use union but
use different blocked_on_mutex, blocked_on_rwsem, etc. 

Another idea is to make the owner offset same, like introducing

struct common_lock {
	atomic_long_t owner;
};

But the problem is that rt_mutex does not use atomic for storing
the owner. (we can make it atomic using wrapper)

Thank you,

> 
> Then the lock read from blocked_on could be a different type of lock than
> what is expected.
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

