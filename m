Return-Path: <linux-kernel+bounces-374008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122CB9A608B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A29B1C21D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44461E3DCE;
	Mon, 21 Oct 2024 09:46:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AAA39FD6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503971; cv=none; b=n4+57nNyqp/StAI7D+j9ICNoTwNJx+Bixtk/52STvwpx66yU1lYfjr15xdWVgbRIPrllWwhkgwRGxr2z/Q8Ye2FWS/NAuGB4UjH8XnNMxwPz7AOkjQKMk7OOM6vXiQwGDV9MdkykM+z2lIdoZTfFcxbXOXaTu94B+YxBFOz0UsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503971; c=relaxed/simple;
	bh=ANH7dMUW2oDRLvZOr2ZNaeRVDShM/erBpV7zejCdWqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyZWCokPh9JRHqOQWZfovWDxonXg6gw2TiTzIucsAkqOZ0nEVAl3FFXeHodMjCzUNsCvsLy9V74J5sPhqifnz49hrFScybCbb29Of7EbMZCk+lpD9KC5JZT+rdP0Gv1hbHjPcBxM/1mDu8iPT09h+xM9qzLlzv535YBHrgsZtOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E305DA7;
	Mon, 21 Oct 2024 02:46:38 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1E0A3F73B;
	Mon, 21 Oct 2024 02:46:05 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:45:56 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
	tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
	kees@kernel.org, wad@chromium.org, rostedt@goodmis.org,
	arnd@arndb.de, ardb@kernel.org, broonie@kernel.org,
	rick.p.edgecombe@intel.com, leobras@redhat.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] arm64: entry: Convert to generic entry
Message-ID: <ZxYiyiKJm-6A6poG@J2N7QTR9R3>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <ZxEsZBvsirXJz2dT@J2N7QTR9R3.cambridge.arm.com>
 <0b5e67da-cd23-5159-250a-9f4722655784@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b5e67da-cd23-5159-250a-9f4722655784@huawei.com>

On Mon, Oct 21, 2024 at 04:30:51PM +0800, Jinjie Ruan wrote:
> On 2024/10/17 23:25, Mark Rutland wrote:
> > On Sat, Jun 29, 2024 at 04:55:58PM +0800, Jinjie Ruan wrote:

> > Patch 3 in particular is very hard to follow because several unrelated
> > complex systems are updated simultaneously. It would be really nice if
> > we could move to the generic sycall code separately from moving the rest
> > of the entry code, as the sycall handling code is a particularly
> > important ABI concern, and it's difficult to see whether we're making
> > ABI changes (accidentaly or knowingly).
> > 
> > Can we split that up (e.g. splitting the generic code first into
> > separate entry and syscall files), or are those too tightly coupled for
> > that to be possible?
> 
> It will be hard, but I will try to split it, they are surely tightly
> coupled which make the 3th patch too big when I try to switch to generic
> entry.

I'm confused. The point I'm making is don't try to switch to *all* the
generic entry code in one go: split the 3rd patch into smaller,
logically-distinct separate steps. The 3rd patch shouldn't get larger as
you should be changing fewer lines in any individual patch.

The regular entry state management (e.g. enter_from_user_mode() and
exit_to_user_mode()) is largely separate from the syscall state
management, which is pretty clear given
syscall_enter_from_user_mode_prepare() and syscall_exit_to_user_mode()
wrap the regular entry logic:

| noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
| {
|         enter_from_user_mode(regs);
|         instrumentation_begin();
|         local_irq_enable();
|         instrumentation_end();
| }

| __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
| {
|         instrumentation_begin();
|         __syscall_exit_to_user_mode_work(regs);
|         instrumentation_end();
|         exit_to_user_mode();
| }

... and while exit_to_user_mode_prepare() is called by
irqentry_exit_to_user_mode(), that's also just a wrapper around
exit_to_user_mode():

| noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
| {
|         instrumentation_begin();
|         exit_to_user_mode_prepare(regs);
|         instrumentation_end();
|         exit_to_user_mode();
| }

... so AFAICT we could move arm64 over to enter_from_user_mode() and
exit_to_user_mode() without needing to use any of the generic syscall
logic.

Doing that first, *then* moving over to the generic syscall handling
would be much easier to review/test/bisect, and if there are any ABI
issues with the syscall handling in particular (which I think is
likely), it will be easier to handle those in isolation.

Thanks,
Mark.

