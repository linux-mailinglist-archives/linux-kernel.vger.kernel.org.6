Return-Path: <linux-kernel+bounces-215135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F69B908EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F4ABB2C3CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4936315FA88;
	Fri, 14 Jun 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ds/wFUcH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43919D8B2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378316; cv=none; b=LCC8QM5yuDrqUnGFPUph9kO06yTO1Nk34ALgq/LKbzI7klSU3DRMLaAjDyIBclgGF1+XovifE8YER/xkWSlOeJTdtdkXWR91guBlJkAnbduuIV4y2sTTepjoql6ty8sQnZKUljvDpQ7ss22vQQ6FnDArEyavHPBHfLdM5fYH9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378316; c=relaxed/simple;
	bh=c/Yb0F0WHCXYlkdOM9UYtspRJ0q02tFTEdH4RZ88v0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiAo7PiK26huEc2YaN9U+KQSNyGYtJ+W8M7IWsrtIXnL2/+2Cc0IR2Tc6xVvMJFfBzppq4m/vwUNcEkkYiHr9LadM65XcFtKn7DhFBk5scBrRBDM4vIBI30bP84bwEvP38jf97BcXqeLmZI8hWCK35AdgodsteXbuFivjvRz7yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ds/wFUcH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718378314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ShPU3+qy8bdD0vwOsgy2HhMz94KcM4uraJBHpdUlzug=;
	b=ds/wFUcHGT4fBfEYhEoSl5/LqZm8QeJskw7we+bmsZ6/4fw/C8M8twQc+Rf57Qly1Xj8ZR
	1StTeLpyv/oug5EGNLehY4V+sgwV5E/h1tNchJVmALuIghLpiWphyleZYsMKBUzVm3aehl
	InxQPtWk3/2nCjtOr5mRKnvVjzxC/IE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-al5Z-aAcP0Okb7wLXN7gOg-1; Fri,
 14 Jun 2024 11:18:27 -0400
X-MC-Unique: al5Z-aAcP0Okb7wLXN7gOg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D45D319560B9;
	Fri, 14 Jun 2024 15:18:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.80])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 02A713000222;
	Fri, 14 Jun 2024 15:18:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 14 Jun 2024 17:16:53 +0200 (CEST)
Date: Fri, 14 Jun 2024 17:16:47 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 10/9] x86/fpu: Fix 'struct fpu' misalignment on 32-bit
 kernels
Message-ID: <20240614151404.GA27644@redhat.com>
References: <20240608073134.264210-1-mingo@kernel.org>
 <20240608073134.264210-4-mingo@kernel.org>
 <20240610211350.GA1613053@thelio-3990X>
 <20240611124145.GA26798@redhat.com>
 <ZmlZiHVF8w09mExw@gmail.com>
 <20240612184148.GB23973@redhat.com>
 <Zmq9ppuIZJ9IMZDr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmq9ppuIZJ9IMZDr@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Ingo, sorry for delay.

On 06/13, Ingo Molnar wrote:
>
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1562,7 +1562,7 @@ struct task_struct {
> >  	 * they are included in the randomized portion of task_struct.
> >  	 */
> >  	randomized_struct_fields_end
> > -};
> > +} __attribute__ ((aligned (64)));

I guess __aligned(64) will look a bit better, but this is minor.

> What happened is that due to my series 'struct task_struct' lost its
> 64-byte alignment attribute, which broke the fpu struct allocation code on
> 32-bit kernels and made the 64-bit one probably unrobust as well.

Yes, and note that struct fpstate has the same __aligned(64), that is
how I noticed the potential problem and decided to check.

But Ingo, it was a shot in the dark ;) I still don't really understand
what exactly should be aligned. Is it the fpstate->regs member? Or what?
If yes, perhaps this member needs __aligned(64) too to be safe?

> ... and would appreciate your Acked-by or Reviewed-by for the eventual
> final version of the series, but I don't insist. ;-)

Thanks ;) will do.

Oleg.


