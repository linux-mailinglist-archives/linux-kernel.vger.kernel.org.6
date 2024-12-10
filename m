Return-Path: <linux-kernel+bounces-439909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D739EB5C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A82281E22
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520DF1BEF81;
	Tue, 10 Dec 2024 16:13:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F51BEF74
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847196; cv=none; b=GqyVSEn0/pIUTdjXZV1jb3nAS+ZRGEz7kdTyJrdGEUWR1C2sUgbjSd+Dkbx5BZfAlbmNdJra0kFIdAAWyHyiE4BDRSqbDO76pjL/efQLcOdTL9KXxUdA+V6WO5MLUrO7IUxe7BIZAKhDAW4zDUbggGjugzaF5juIkpnpfWC+J9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847196; c=relaxed/simple;
	bh=17xOSUUtS1137TZ8iRma+L87sDR4HvTq/+mhVWculgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIWdkM1X6BeqZMZWVM+d2fmqOtJaCfVcpy4Mz9wYFMjp8Go8+MoIeypN2sqz94cmxWRmCzA/YdlDJBE9yuKe8etmx/rgEM66gb58nmsjXMnHcuoLlh3mvNApJTuN2Yz2DlqNS3RafqKscPxP1qHl+ihbF0e6dwOVYX4Z+//g2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8ACC4CED6;
	Tue, 10 Dec 2024 16:13:14 +0000 (UTC)
Date: Tue, 10 Dec 2024 11:13:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de,
 efault@gmx.de
Subject: Re: [REGRESSION] Re: [PATCH 00/24] Complete EEVDF
Message-ID: <20241210111313.514b3f27@batman.local.home>
In-Reply-To: <98294066b3a0a7a77220e18ab9db5d3c3cb57341.camel@codethink.co.uk>
References: <20240727102732.960974693@infradead.org>
	<16f96a109bec0b5849793c8fb90bd6b63a2eb62f.camel@codethink.co.uk>
	<20241128105817.GC35539@noisy.programming.kicks-ass.net>
	<4052c4e7ed0e02d11c2219915b08928677c88ab8.camel@codethink.co.uk>
	<20241129090843.GB15382@noisy.programming.kicks-ass.net>
	<98294066b3a0a7a77220e18ab9db5d3c3cb57341.camel@codethink.co.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Dec 2024 19:46:21 +0100
Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> wrote:

> Unfortunately, once I trigger the failure the system is completely dead and won't allow me to dump the trace
> buffer any longer. So I did the following instead on the serial console terminal:
> 
> tail -f /sys/kernel/debug/tracing/trace
> 
> Not sure whether there is any better way to go about this. Plus even so we run the serial console at 1.5
> megabaud I am not fully sure whether it was able to keep up logging what you are looking for.

If the memory of the machine is persistent (it is on several of my
machines) you can use the persistent ring buffer.

Add to the kernel command line (or enable bootconfig that attaches a
command line to the kernel if you can't change the parameters):

  reserve_mem=20M:12M:trace trace_instance=boot_map^traceoff^traceprintk@trace

The above will create a "boot_map" instance with tracing off on boot
and trace_printk() going to it. Start tracing:

 trace-cmd start -B boot_map -p nop

If or replace "-p nop" with any events or tracers you want, including
function tracing", then after a crash.

  trace-cmd show -B boot_map

If the memory is persistent and you don't use KASLR (may want to also
add nokaslr if arm64 supports KASLR it and you use it), you should get
the trace right up to the crash.

See Documentation/trace/debugging.rst for more details.

-- Steve

