Return-Path: <linux-kernel+bounces-575889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5611FA7089B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC07188871D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2F2641DB;
	Tue, 25 Mar 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wq9omJhu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE35C263F41
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925464; cv=none; b=YwrS9t4A7IEFw32QgVU269AmE2s7Zq+wcqNaJvT/y4rfFI5etO+P6FOPanN7E0DyfhNxReZxwEYMCFLmoEiOG2cXqrBkL+GlZb2A4LJxdIeQm1n1r0qxMcW+hSBmYVUxpee/Hw0TzNbFR7AeVxcslnlb8eU7yWOHJ6o+cPvNZd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925464; c=relaxed/simple;
	bh=iXKJI7frR/WJ9T8HTzkkqnB6FGvLrKm4hwAI4I7qny4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=At3JDTpLMCC/CSO0lMsEhpmCp4ncBEhrBfiN32ZsQwORpmbB89ciRrDCBAGk4Jt+GjKyc89U8Ayjf84+U5grvf6crt0I1VfZcz01ZZfkVgm0bu5p0E0d9cKlJAYiUqr1Trm5OKN2zoKoQpXwxb9UCJ0/BL46lrTD25frdbjBrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wq9omJhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AB3C4CEE4;
	Tue, 25 Mar 2025 17:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742925464;
	bh=iXKJI7frR/WJ9T8HTzkkqnB6FGvLrKm4hwAI4I7qny4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wq9omJhu0gfFxyR2kTpr7Di25ThdUixSHxY2eVb0/Z83aztrulZ5bT1qMPLgBGtWp
	 VIkzRFA2kXypyhvlquxgd/X/bGaHZb3XpvTTJh4Gb5mztdMYz7iegItPIt+PrLx7EY
	 /ZUtcMizguNGFiiLJLQontxfv8Tp/pZ56aRr3nho=
Date: Tue, 25 Mar 2025 10:57:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Oleg Nesterov <oleg@redhat.com>, strace-devel@lists.strace.io,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO API
Message-Id: <20250325105739.402681c2e8e7c95a7b7c6b54@linux-foundation.org>
In-Reply-To: <20250325104122.GA19416@strace.io>
References: <20250303111910.GA24170@strace.io>
	<20250306020222.GA24365@strace.io>
	<20250325104122.GA19416@strace.io>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 12:41:22 +0200 "Dmitry V. Levin" <ldv@strace.io> wrote:

> On Thu, Mar 06, 2025 at 04:02:22AM +0200, Dmitry V. Levin wrote:
> > Andrew, could you take this patchset into your tree, please?
> > 
> > It has been under review for almost two months, the last reply was two
> > weeks ago, and by now all activity seems to be over.  The ptrace maintainer
> > approved the ptrace-related patches of this patchset more than a month ago.
> > Admittedly, most of architecture maintainers ignored the
> > architecture-specific patches from this series, but this is expected,
> > so I don't think it's worth waiting for their reaction any longer.
> > 
> > v7: https://lore.kernel.org/all/20250303111910.GA24170@strace.io/
> 
> Andrew, could you take this patchset into your tree, please?
> 
> Nothing has changed since v7, so I have nothing new to add to the text
> written above.

Yep, I'll take a look for 6.15-rc1.

