Return-Path: <linux-kernel+bounces-396147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D029BC885
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75051C212D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0AB192592;
	Tue,  5 Nov 2024 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="On7RINGJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29208210FB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797256; cv=none; b=MAv585dMD3+ey0G8WlWJ3Vie6SLgwoykI68ZeeJro6cAPjPFCTe0FNZSxnCsOeU0T2yHxz4oGeI+npjR6WWIn0kHtAxPtgqX5kb/NT2FD4O3yJwKZ0zC+Nc+6/IgTDRk10QeNX21umBYcYXsjPXzs46nX/Rb9HTLLvxs1bHUV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797256; c=relaxed/simple;
	bh=+dWEKSiPPKe9Q4qzIuFrKujHrXBnfZ+n49kfE4w2F4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IX4hQgWhYgrI4blPjcLUoUkXVUPGSOPOk/nK4JOIJevgZ66yJyZKt4/B4V1J2j7QQDAJvk73MF4Vv+pvWVAgQ/NrEXxn9JTGz4VNLbQCj3F/YZTOq1ZCFz0DNIY77J2bDj+hWxeDiareLnNOhFmLQeLZCdfXbJJTMS9X95crYhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=On7RINGJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eeoMFL25vDDA8pxNB3Ui0X8lscyZM7U+W5OCb3llIrM=; b=On7RINGJZstraBa/hh1hggiwfG
	QQx8mrDCifCGGMcbCh5FGd9MQ+eWnr9kGiMUlcGn4UF5LmKrINrfV1LbFI2Exb3kIS1PMg2WG3LHt
	BHC5diWQVnEkoxn1UdNaAbXrDlkr0OCkcUNadl0wtkgRu+K3E1VQ7/1FXzBSj1VVaF7x06PaHGWJF
	8zunzwovpNplEOjQ0sCcKwyvnLkEI7k0luCyMqvp/+E+pYM/RKeYHm9ghik6pLS7NsV77vWLFyIYv
	FL/QkUVl0dAZI3eCaSQ+N3X9pbqH6dCJjrDbGm5JHVBaYCMKgUdQp1kwFVDGYYgYHSyU174fG5Wsa
	UqBAzQyw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8FQf-0000000BhyN-3XAf;
	Tue, 05 Nov 2024 09:00:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E6CA330083E; Tue,  5 Nov 2024 10:00:48 +0100 (CET)
Date: Tue, 5 Nov 2024 10:00:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+56dc65adbd1d2ae1f844@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [syzbot] [mm?] WARNING: locking bug in __set_page_owner
Message-ID: <20241105090048.GZ9767@noisy.programming.kicks-ass.net>
References: <6727a996.050a0220.35b515.019e.GAE@google.com>
 <20241104193345.94e0d057a6b16dfb9d83a3fc@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104193345.94e0d057a6b16dfb9d83a3fc@linux-foundation.org>

On Mon, Nov 04, 2024 at 07:33:45PM -0800, Andrew Morton wrote:
> On Sun, 03 Nov 2024 08:49:26 -0800 syzbot <syzbot+56dc65adbd1d2ae1f844@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> 
> Help.  I don't understand this lockdep report. 
> add_stack_record_to_list() is taking spin_lock_irqsave(stack_list_lock)
> from within softirq. all seems well?

spinlock_t from hardirq context, which is not fine. Should be
raw_spinlock_t.

Anyway, I send a proposal for this one yesterday, and so far nobody
seems to have screamed murder, so I suppose I'll make it compiler and
send out proper.

https://lkml.kernel.org/r/20241104114506.GC24862@noisy.programming.kicks-ass.net

