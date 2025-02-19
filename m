Return-Path: <linux-kernel+bounces-522735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF5CA3CDF9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6491898046
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4925EFB5;
	Wed, 19 Feb 2025 23:57:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9D81D63E6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009468; cv=none; b=tjtU8oBES48N9zLhlW9Y3/Is7s35XELroCKuJbE3PV63TdxENOZPSg1qzGoR2rAQ0IM9y/VqRd3zGzc4+Yp4iPD8Gy1mr0Zqp7k6shraCwi/yX5aqkBHATbyMm7U+976bMxold119DpGZnqoYFy8YTMjdhd0LNzMOLFe7cZR+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009468; c=relaxed/simple;
	bh=/GRWYC90xwLM6F52KAnvtSN66kvgTdhs/W50basMdU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PR4ee4FZNqP9AIRd5TdCf6tGE9O+fSxn/wCkQG2tM4gAaqQezqIX4CaXXea4Yffq8w5VBBg3EJj0oT6VDC76CFP60/Q3GRW1QuFbQhWIG36oV/VCDnInj5RmCxpquZ9mzpuJxS2K6M8/Z5xhdINuNS3XD29ke81uECUV5NDnBck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB9AC4CED1;
	Wed, 19 Feb 2025 23:57:46 +0000 (UTC)
Date: Wed, 19 Feb 2025 18:58:10 -0500
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
Message-ID: <20250219185810.57561c69@gandalf.local.home>
In-Reply-To: <20250220080908.fc1494f0f7c611b48fbe0f8b@kernel.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
	<20250219152435.35077ac3@gandalf.local.home>
	<20250220080908.fc1494f0f7c611b48fbe0f8b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 08:09:08 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> So something like this?
> 
> unsigned int	block_flags;
> union {
> 	struct mutex	*mutex;
> 	struct rwsem	+rwsem;
> 	struct rtmutex	*rtmutex;
> } blocked_on;
> 
> enum {
> 	BLOCKED_ON_MUTEX;
> 	BLOCKED_ON_RWSEM;
> 	BLOCKED_ON_RTMUTEX;
> 	BLOCKED_ON_IO;
> } block_reason;
> 
> For the safety, we may anyway lock the task anyway, but that is the
> same as stacktrace.

Why not make it into a single entity?

struct blocked_on {
	unsigned int	flags;
	union {
		struct mutex	*mutex;
		struct rwsem	*rwsem;
		struct rtmutex	*rtmutex;
	} blocked_on;
};

-- Steve


