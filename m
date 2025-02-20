Return-Path: <linux-kernel+bounces-522827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D1DA3CED5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B261F17A1D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50824146D53;
	Thu, 20 Feb 2025 01:41:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83F12B73
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015691; cv=none; b=bXi5whVkif6qt4NHE0BhJOu1zdzO5JZkkTjrcOz7n4FHmRdTOKKeihDvErNUGYtBRzuGXeXdPGMblxfW0wP7/rfEjbSX5YX/D9OoZkmRb/+Ysdo0vumrKkk3SOK3YHp7IGZyMGpCVQDDPrzVzqJaN85QL2Mlm4waL5SKUTsQTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015691; c=relaxed/simple;
	bh=pYjj+gFd2vdjYlfISiHxmqLovAym7WCh77IkmovYhoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgMvkNdSC5Ih2UZ/BmSngwPHk2G83d2oVsLEwW+Dof7dlnDoLFbOTCJXbB/yA2QHbzdTPjZWl6swkGa3JtKP2PIDpNMGZRHh4lkWwnRx8jCUnWVX3ENguloLAQXDgr3dIh1C+TkVIbKVgoNQ3BSutmemkznA/tjqdCkyExOwniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CF6C4CED1;
	Thu, 20 Feb 2025 01:41:28 +0000 (UTC)
Date: Wed, 19 Feb 2025 20:41:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Waiman Long <llong@redhat.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>, Anna
 Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, Linux
 Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <20250219204153.65ed1f5e@gandalf.local.home>
In-Reply-To: <d8c01f69-34c0-45cf-a532-83544a3a3efd@redhat.com>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
	<20250219152435.35077ac3@gandalf.local.home>
	<db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
	<20250220075639.298616eb494248d390417977@kernel.org>
	<d8c01f69-34c0-45cf-a532-83544a3a3efd@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 20:36:13 -0500
Waiman Long <llong@redhat.com> wrote:

 
> >>>> this field, we don't need to take lock, though taking the wait_lock may
> >>>> still be needed to examine other information inside the mutex.  
> > Do we need to take it just for accessing owner, which is in an atomic?  
> 
> Right. I forgot it is an atomic_long_t. In that case, no lock should be 
> needed.

Now if we have a two fields to read:

	block_flags (for the type of lock) and blocked_on (for the lock)

We need a way to synchronize the two. What happens if we read the type, and
the task wakes up and and then blocks on a different type of lock?

Then the lock read from blocked_on could be a different type of lock than
what is expected.

-- Steve

