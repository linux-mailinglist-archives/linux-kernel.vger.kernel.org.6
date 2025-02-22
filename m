Return-Path: <linux-kernel+bounces-527255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A040A408DF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C71700EE3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A3014A095;
	Sat, 22 Feb 2025 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS88dhkh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8C3139566
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740233579; cv=none; b=LY9shQARwR3RNgqBQB/CQFRdVpyNVP7wmpBL2SBNItlmBSxvWs/kHcmTZYl4NYY1jNgTI49gh8TZzthR4fHF/pbcKbfvkAjwuZ5WVZkh9uPbLBrVhIJPBvgVbZivOI1aHBrgIROF9D0gettaenDN7qlZvqQEVOvZAMebAKaH4jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740233579; c=relaxed/simple;
	bh=ldcFVBNXx/8qw4SF/6XwHq5JzBl0MYR9vWzP3iYBIOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxcdDjIFc7KkOEDjM7FvTgIWHZozw9DG2H8E71Vu3DuGE+JmumR4Tpwfs5aF0Ugi+kkp+qYcH7ZxLBP9RToGmZxtPPtV4EfpcEE7qhb+fk2MWoyldEyLrDAgjbEbDInzHWPJ2VCG4oTKIz+f8cX5tF6NvYDShCMBotrf8pjLxtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LS88dhkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066D1C4CED1;
	Sat, 22 Feb 2025 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740233578;
	bh=ldcFVBNXx/8qw4SF/6XwHq5JzBl0MYR9vWzP3iYBIOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LS88dhkh7rWCzsstIt2KYo2fDnVtc89S6VmpUJZ7wlbqh5K9Ku6r/bhrkZadCBDCQ
	 WHIBCf3fguhZ7uncgpNoMgCcFzQWpnffLwmTGif7Ra0fCF/JY+yVqvPGFxveX+FrPS
	 0kC6A8epAWCcRxmMwOx/ot41eYtPyDLi/t7WzA7B9KsYKRsfM/4Y3pTSdfOSqXDu2b
	 oLVMdHUnEXfaqMIg9YOdC/G1K4adanH/S7qQTKx3RB5P1INMl0vX9XWgkyiZP+Jsd2
	 sZAbi/I5BziGEtUTn4dRtqs6DvmGEKoUvqji1V0zOA6Gj0QHhAfyP9EIGlHKjKHjkn
	 2VAGp+37hKqhQ==
Date: Sat, 22 Feb 2025 15:12:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michael Jeanson <mjeanson@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rseq: update kernel fields in lockstep with
 CONFIG_DEBUG_RSEQ
Message-ID: <Z7nbYcdRKXspX8o2@gmail.com>
References: <20250221191401.464648-1-mjeanson@efficios.com>
 <Z7nQzOQT_-9-Rbr5@gmail.com>
 <974359d5-43f3-483a-89cf-79e9b4965785@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974359d5-43f3-483a-89cf-79e9b4965785@efficios.com>


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > > -	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
> > > -	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
> > > -	unsafe_put_user(node_id, &rseq->node_id, efault_end);
> > > -	unsafe_put_user(mm_cid, &rseq->mm_cid, efault_end);
> > > +
> > > +	unsafe_rseq_set_field(t, cpu_id_start, cpu_id, efault_end);
> > > +	unsafe_rseq_set_field(t, cpu_id, cpu_id, efault_end);
> > > +	unsafe_rseq_set_field(t, node_id, node_id, efault_end);
> > > +	unsafe_rseq_set_field(t, mm_cid, mm_cid, efault_end);
> > 
> > Could we please name the new wrapper rseq_unsafe_put_user(), to make it
> > clear it's a wrapper around unsafe_put_user()?
> 
> If we do this then need to make sure the order of arguments becomes
> similar to unsafe_put_user for consistency.

Absolutely.

> I always find it odd that the "source" argument comes first and
> the "destination" argument comes second in all put_user() APIs,
> compared to memcpy, WRITE_ONCE() and all assignments (e.g.
> operator "=" LHS vs RHS). Choosing a different argument order
> therefore made sense with a naming different from "*put_user",
> but not so much if we use a derived naming.

Yeah, put_user()'s oddity is a random historic idiosyncrasy that we 
want to preserve in derived naming to reduce the potential for 
confusion.

Thanks,

	Ingo

