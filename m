Return-Path: <linux-kernel+bounces-446149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A52A39F205B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 19:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FF41888065
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1027194C61;
	Sat, 14 Dec 2024 18:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c7dZwC5V"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C828B4C70
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734201998; cv=none; b=akBGKRrRQ1lVHMe8ROdvGdFjz44AiieUYFd0/UH2LaJ0701cAyZjNHHJqiYXVDl86Dwr8mGaEBUGxUbppP7GzXOBIUABeC+aVTFMunH1HY0m3Cq/vcwUfVbBZkvYH6mTaEb6btqzqA+hsJISpLz8BeGi8dGjvo37I6Da25i8Mv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734201998; c=relaxed/simple;
	bh=+/vsE0RTiV0RGezZoK6RYc1wZ1Qg8mhhW+a0HaJN4UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG42sJMOce0mfrzbtPSgICcwqOI8B/0BttJwhnKsPB1yGKVqViUzHKAseIYJkklvn1lMBJoOFgwCwym0BN4L5pgRH4mWD9W1ZmqYTBxyp/TawhBoNyU7UEHf2sAlXEueAVgAihGjbakTc9X0WmTzZSzV/qpiws4u/ufr6tam8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c7dZwC5V; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bYU0gnwwLL8Z6Ths3CBwCaNbHH5loDfzGARUYm9wAAE=; b=c7dZwC5V6aXvheQ7uJdBOTJktP
	SzG+ZvGzVe0fqzUfZDVKe0S0JjZwxOkefu5farixPs+b33cxrbqczxkBUiMaG87zAZPMTuhRASjSp
	koAcfvw3vwMh/DPR2AIgtfOcwQ91jgPxV4eaqvKQcw+Zak/9w72pojoFJi7UB4+3eYBht/XUhjKSL
	S7FLhcehl+yZXWxoBgTsOBcall9pTQJ+5R8Prw0DUSn4QWjxcYrXxRJgYjVrIvZCMu2q/cCTj/ogw
	ds+HprFQ1igxN4+b9TyxH/4VeGzVDzgM6lVX0L+DRnU3MB0QKJaofhRcvzIsyUgR0uLYdTToCLDX4
	vzXdwFhg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMX9s-00000004YSh-0lRa;
	Sat, 14 Dec 2024 18:46:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 808F730035F; Sat, 14 Dec 2024 19:46:31 +0100 (CET)
Date: Sat, 14 Dec 2024 19:46:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bert Karwatzki <spasswolf@web.de>, kernel-team@android.com
Subject: Re: [RFC][PATCH] locking/rtmutex: Make sure we wake anything on the
 wake_q when we release the lock->wait_lock
Message-ID: <20241214184631.GD10560@noisy.programming.kicks-ass.net>
References: <20241212222138.2400498-1-jstultz@google.com>
 <20241213124614.GA12338@noisy.programming.kicks-ass.net>
 <CANDhNCo0W6cYhVQm7TQso=E9evhYy2oxSLnVz-KxbOdfomZFgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCo0W6cYhVQm7TQso=E9evhYy2oxSLnVz-KxbOdfomZFgQ@mail.gmail.com>

On Fri, Dec 13, 2024 at 06:39:45PM -0800, John Stultz wrote:
> On Fri, Dec 13, 2024 at 4:46 AM Peter Zijlstra <peterz@infradead.org> wrote:

> I think all of the calls are tied to the unlock (the one you quoted
> earlier was removed with 82f9cc094975240), so would something like a
> special unlock be reasonable:
>    raw_spin_unlock_irq_and_wake(&lock->wait_lock, wake_q)
> ?

Ha, that's what I started with :-) Then found there's two irq_restore()
variants for raisins and it all turned to shit.



