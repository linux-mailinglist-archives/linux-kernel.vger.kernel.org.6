Return-Path: <linux-kernel+bounces-409112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE989C886B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2FFB349B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4084C1F9ED5;
	Thu, 14 Nov 2024 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NV33Lm0B"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99931F942E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580130; cv=none; b=OY0ghsWLh1zCWdHvKQxIX0HNZoOS7karSqTnmn2c/gjqkVisXz1+uFDn4E62emmTMI2d6uXBdqBttc7Y8P8JmVYimLZBytqFrCqPx/hKisOE2ZYIf9CAPiI+C02MUhOlQP4BXIXt6lWmykhop4FeGKIojqTTViGNQXezRUkb7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580130; c=relaxed/simple;
	bh=TeMw+aXbnBK0lT4e+B2X2butRByI5GNTO/ViCME3Vp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCeeHLrhKIHGXTcj+NWNoE7PGMQiEJAlCF7lLd3w/6JYWT0tSAQIETyyUlBF3PhhdSVcOCTODv7vhw5PcNe45CMNrZ8QUgSYKOW4cYPiZbcHLwUqGWG8QrZDmuIKx8XHPq/N39xJQfBTcq1ARichPkBlvikS3u7cevYq8t9KcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NV33Lm0B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GI+tUfYh0DgdrEgOOUUfzYsQZR496Wy/ZZYW+tZ4ofs=; b=NV33Lm0BYFCPGQsgLEQnfchZtk
	r2o6Gb1q0oBvSP5BMda2fzegVojlzd5RsngBNjBYLfE9Bq2X/UyD25jxj+oS1saPWc2NCWDkBstae
	N0P/KhtuORkoyE5V1WmCn7NCGyWggXryWkizzJZt1Q+nGCrPApWyhD1zUCIKkBVJDOulgEJTYDEwB
	6GjX5ps6sRblPoSvWVjzb7DLhuoBBGESAr0Rcnyjph9WNbWXgk3P5op+gd1n3YUHUJcNTVpFlTaH5
	A3jm4vhcPJ4dzxNNEorN6bEjAOMKX/tsYbSNxnhOtemmSrkSu0Y3QSBLL17vaAJTO5LcuBHASKpXf
	rAW5k05Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBX5X-00000000Wwv-0ipp;
	Thu, 14 Nov 2024 10:28:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 63077300472; Thu, 14 Nov 2024 11:28:34 +0100 (CET)
Date: Thu, 14 Nov 2024 11:28:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
Message-ID: <20241114102834.GM6497@noisy.programming.kicks-ass.net>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
 <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
 <896BA407-E19C-4CEB-BF5E-9707543BA365@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <896BA407-E19C-4CEB-BF5E-9707543BA365@oracle.com>

On Wed, Nov 13, 2024 at 08:10:52PM +0000, Prakash Sangappa wrote:
> 
> 
> > On Nov 13, 2024, at 11:36 AM, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> > On 2024-11-13 13:50, Peter Zijlstra wrote:
> >> On Wed, Nov 13, 2024 at 12:01:22AM +0000, Prakash Sangappa wrote:
> >>> This patch set implements the above mentioned 50us extension time as posted
> >>> by Peter. But instead of using restartable sequences as API to set the flag
> >>> to request the extension, this patch proposes a new API with use of a per
> >>> thread shared structure implementation described below. This shared structure
> >>> is accessible in both users pace and kernel. The user thread will set the
> >>> flag in this shared structure to request execution time extension.
> >> But why -- we already have rseq, glibc uses it by default. Why add yet
> >> another thing?
> > 
> > Indeed, what I'm not seeing in this RFC patch series cover letter is an
> > explanation that justifies adding yet another per-thread memory area
> > shared between kernel and userspace when we have extensible rseq
> > already.
> 
> It mainly provides pinned memory, can be useful for  future use cases
> where updating user memory in kernel context can be fast or needs to
> avoid pagefaults.

'might be useful' it not good enough a justification. Also, I don't
think you actually need this.

See:

  https://lkml.kernel.org/r/20220113233940.3608440-4-posk@google.com

for a more elaborate scheme.

> > Peter, was there anything fundamentally wrong with your approach based
> > on rseq ? https://lore.kernel.org/lkml/20231030132949.GA38123@noisy.programming.kicks-ass.net
> > 
> > The main thing I wonder is whether loading the rseq delay resched flag
> > on return to userspace is too late in your patch. Also, I'm not sure it is
> > realistic to require that no system calls should be done within time extension
> > slice. If we have this scenario:
> 
> I am also not sure if we need to prevent system calls in this scenario. 
> Was that restriction mainly because of restartable sequence API implements it?

No, the whole premise of delaying resched was because people think that
syscalls are too slow. If you do not think this, then you shouldn't be
using this.

