Return-Path: <linux-kernel+bounces-201298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C5B8FBCAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9121A2846F6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F3814B08C;
	Tue,  4 Jun 2024 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N04GAfoW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D6147C91
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529954; cv=none; b=N7zMXWbsyZQ4yc3/wtIC3m/hlVUq1AO1nitVAWiB+sEm+ALjNAvvUqEJMEfDviJeO6Pg1ei+MZ1tE3QK9GHjZ0hHKOnpIci9ni7W0OFmtxmHPo3n4kikaCG1E89Uqws+5kuTZvmJxBdRlkzNrj96Ey7gGYPeHxbo4BJyMrN/IFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529954; c=relaxed/simple;
	bh=T5REOv9tw1BR0J/xEmL+OuRX5PHdlT361lXv/GL/XT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP3/eJ57ugliOBbqQPk1piF2ubJNl9FxWGsIPgxUq2P84QZU/rMCh9zc7r1NkaO0YS0Jr3bBm1gvGGHxlm0jcReyFwMRJYp86dIGr/UdWs/edt8q0SzWd9WoySA6rB0czEyuecAlWAhCA+pRoquXHh0cYchM5l6UQE+oTp/9FLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N04GAfoW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Cs1i66KM29U3v6L5ZjDjDwoxrJb+4BKxhx9GDAwj1sw=; b=N04GAfoWepoDyXO3E++aw8sFO4
	qyoaxkQHg2o8rcqYCS2/7LA6/tzRdvL+n7uqKeeI5ZPDtvD2dCkrHE22D7Q0aYGbmX5IYhDmrptMy
	v6nIYBYuobSoOtq+w8fNofjWhV3IyP2kqlK+oEbmUhUV1Erre3Ai7lwWa3PqE1SivE7dRYWiOXDDJ
	d5+kQj5p7/KpRKZXsswOCVRt8U26BZTVNIz3KGXlQa/XZPu1PS4onWGiI4Yxl0xV95fwRh2xlLpIF
	goUfizXWRVmFQHW0rVmVXQ9j/JxFV598pRXgBhJA2052gFsnrZyKb+iAecMj0WVDTRh9FDB0mc67z
	r/VLzXCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEZzh-0000000FZy4-2nTd;
	Tue, 04 Jun 2024 19:38:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 482D830068B; Tue,  4 Jun 2024 21:38:53 +0200 (CEST)
Date: Tue, 4 Jun 2024 21:38:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com, elver@google.com, glider@google.com,
	nogikh@google.com, tarasmadan@google.com
Subject: Re: [PATCH 1/4] x86/entry: Remove unwanted instrumentation in
 common_interrupt()
Message-ID: <20240604193853.GR40213@noisy.programming.kicks-ass.net>
References: <cover.1717507310.git.dvyukov@google.com>
 <1ada3be307bbd076c4ea63530cf445e7fbd0e4e7.1717507310.git.dvyukov@google.com>
 <3f15814c-de9c-4aa6-b56d-82761bb6520a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f15814c-de9c-4aa6-b56d-82761bb6520a@intel.com>

On Tue, Jun 04, 2024 at 09:00:59AM -0700, Dave Hansen wrote:
> On 6/4/24 06:45, Dmitry Vyukov wrote:
> > The manifestation is that KCOV produces spurious coverage
> > in kvm_set_cpu_l1tf_flush_l1d() in random places because
> > the call happens when preempt count is not yet updated
> > to say that we are in an interrupt.
> > 
> > Mark kvm_set_cpu_l1tf_flush_l1d() as __always_inline and move
> > out of instrumentation_begin/end() section.
> > It only calls __this_cpu_write() which is already safe to call
> > in noinstr contexts.
> 
> I've internalized the main rules around noinstr to basically be: Only
> call noinstr functions before begin_instrumentation().  Second, try to
> minimize the amount of noinstr code.
> 
> This patch seems to be adding another rule which is that all code before
> preempt_count manipulation needs to be noinstr.
> 
> _Is_ that a new rule, or was it something I was missing?

Specifically, the problem here appears to be that the instrumentation
cannot correctly identify the context because the HARDIRQ_MASK bits
aren't yet set in preempt_count.

So the preempt_count manipulations as such are not the problem, but the
fact that we call into instrumentation code that seems to rely on using
the preempt_count to determine context is.

Does that clarify?

