Return-Path: <linux-kernel+bounces-522842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E78DA3CF00
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE913167F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1843987D;
	Thu, 20 Feb 2025 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC3uTsfT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99D2862B7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017283; cv=none; b=O/TLHCz7vhHyeQDF9z0RrLEa/XN4aCAmiE0XbFtUaotL7NTn1yZoASRVGTfZcIbUCVdAdGMJcO9nmyv6HLpKjsemDZsIGNfnjuhNzO+PNnwVPpONDDbBlZBgpzixLbAUmcROxOjEPxbOEZimoY/oC3O82DfijVWBspmd/MRWh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017283; c=relaxed/simple;
	bh=6i5jjOaoUXUHcS498uRlSh4cJeJHp7DeQs1PtpfGi6Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mTmixCrjcN1SIrU3k3mVSO4gG2SF3S5Po9HLV3hMdPyHwsA9jq6VrpNfu3qyUEq6ZUChfltbTNAU2lCROCnGB2BEHR32McuGgRz3v9qPjnspEjtptKTLPouZuturB6C/c/dWLPIVdwKTidGbwjNBj6IkzOygF1C0jWx0e7ESCa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC3uTsfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FF9C4CED1;
	Thu, 20 Feb 2025 02:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740017283;
	bh=6i5jjOaoUXUHcS498uRlSh4cJeJHp7DeQs1PtpfGi6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oC3uTsfTyKDIqZaisG0WKKVB9EmpHhBOnOWHaWAApxwTgMVn/0QkZo2931uJNYAwq
	 BbaussuEh0GEfRSPvu9n5LqvBmGjar+0gKreZCMQXomYlI/6vZ+cPa+IY+3mY85xwY
	 /JV5W6iIEQcQKRvuls3jvAagU2NjEVN26aOw0o1KQuYuQ3wxEqW3wA3uQdmrLhJZK3
	 45uVyOllo5Rg1GKGSKyCx+3xbycfWE/+dnvmgeeJyI/82eit9khgZ8E6eZdbidd3Iy
	 0IG2oHhRKvZHhboVqRj0Wwrjh1okHLHd+mPSU3IgU46AZVJgFZ0xYLhCz23FoqXrY9
	 2Epl32jaS4kJg==
Date: Thu, 20 Feb 2025 11:08:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20250220110800.42ce6b1b8e94a3b998d533a5@kernel.org>
In-Reply-To: <20250219185810.57561c69@gandalf.local.home>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
	<20250219152435.35077ac3@gandalf.local.home>
	<20250220080908.fc1494f0f7c611b48fbe0f8b@kernel.org>
	<20250219185810.57561c69@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 18:58:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 20 Feb 2025 08:09:08 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > So something like this?
> > 
> > unsigned int	block_flags;
> > union {
> > 	struct mutex	*mutex;
> > 	struct rwsem	+rwsem;
> > 	struct rtmutex	*rtmutex;
> > } blocked_on;
> > 
> > enum {
> > 	BLOCKED_ON_MUTEX;
> > 	BLOCKED_ON_RWSEM;
> > 	BLOCKED_ON_RTMUTEX;
> > 	BLOCKED_ON_IO;
> > } block_reason;
> > 
> > For the safety, we may anyway lock the task anyway, but that is the
> > same as stacktrace.
> 
> Why not make it into a single entity?
> 
> struct blocked_on {
> 	unsigned int	flags;
> 	union {
> 		struct mutex	*mutex;
> 		struct rwsem	*rwsem;
> 		struct rtmutex	*rtmutex;
> 	} blocked_on;
> };

Yes, and we also merge current mutex_waiter too.

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

