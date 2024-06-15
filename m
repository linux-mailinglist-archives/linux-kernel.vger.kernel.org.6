Return-Path: <linux-kernel+bounces-215828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF090979D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 12:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233341C20F74
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966732E40E;
	Sat, 15 Jun 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFnNyUBA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FC91849
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718447141; cv=none; b=Jmxjl1EEeRfm4uUoup5OQEoWjVQQFHjT3W2CM1GFlgtc0rFb1QcaO2K/wXitldAM5W1MckNNaeRgnrsayQLyzNFHV3IOHsm9IB1Rga5OaFz6RR7PLBMH0fR172U66cUbfcexZK0LJLeTDRZM9bkk5jXyoN5BiZ9naZy+tZH6rNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718447141; c=relaxed/simple;
	bh=vLT1nexetU0jUpbLAqbTo/BdY/uAPAOBJ/BxghVVcUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzZ77z/R+M52z2NCGQ+0pvg8TQ9mFpCwkFdjvWBghAhERhszQB1SiWlJltSg01J4zD2PJABQypelGvtMzZXY1PH6IJIS60zk/NcmeZOMfCZQFtTSI7OsB5Ni1lx+W1wKPR3mO9eEJse/2PGxTf8g9+lV0w0LUk3Uzo7Va7VA8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aFnNyUBA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718447138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GnNSNjdMX54p92/bJYR8AsWAFb/53gxjVmTvAx+MmkE=;
	b=aFnNyUBAt9h8zENbXh/RRRu6quippGiMeTsMQk2BmH2D6Zn9IJ0xqHVz8QfsyBoVUUhJkl
	wv5gjWlnwgwTqUJTsbF0A2er0m0VPplRsz39wGipFM5wJD0U3SMyYAn3uoRzG5VpumLj19
	BOYvNQR4vuC8A3s1XZREhPfBZOOvL1s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-bYp103mRMpaqrtZ-lN4Aqw-1; Sat,
 15 Jun 2024 06:25:32 -0400
X-MC-Unique: bYp103mRMpaqrtZ-lN4Aqw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7EB91956089;
	Sat, 15 Jun 2024 10:25:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.37])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CB5051956087;
	Sat, 15 Jun 2024 10:25:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 15 Jun 2024 12:23:59 +0200 (CEST)
Date: Sat, 15 Jun 2024 12:23:53 +0200
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
Message-ID: <20240615102352.GA18384@redhat.com>
References: <20240608073134.264210-1-mingo@kernel.org>
 <20240608073134.264210-4-mingo@kernel.org>
 <20240610211350.GA1613053@thelio-3990X>
 <20240611124145.GA26798@redhat.com>
 <ZmlZiHVF8w09mExw@gmail.com>
 <20240612184148.GB23973@redhat.com>
 <Zmq9ppuIZJ9IMZDr@gmail.com>
 <20240614151404.GA27644@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614151404.GA27644@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 06/14, Oleg Nesterov wrote:
>
> On 06/13, Ingo Molnar wrote:
> >
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -1562,7 +1562,7 @@ struct task_struct {
> > >  	 * they are included in the randomized portion of task_struct.
> > >  	 */
> > >  	randomized_struct_fields_end
> > > -};
> > > +} __attribute__ ((aligned (64)));
>
> I guess __aligned(64) will look a bit better, but this is minor.

...

> But Ingo, it was a shot in the dark ;) I still don't really understand
> what exactly should be aligned. Is it the fpstate->regs member? Or what?
> If yes, perhaps this member needs __aligned(64) too to be safe?

Ah, I didn't notice that fpregs_state->xregs_state has
__attribute__ ((packed, aligned (64))), so everything is clear.

From your previous email:

	 - The extra alignment attribute in <linux/sched.h> will affect other
	   architecture as well, although in practice the alignment of init_task is
	   not critical, and is very likely at least 32 bytes, probably more.
	   Still, it's a bit ugly in its current form.

Agreed, but afaics we need to align task_struct only to ensure that

	(void *)task + sizeof(*task);

doesn't break the alignment.

So perhaps we can (later) change x86_task_fpu(), fpu_clone(), and
fpu__init_task_struct_size() to use

	ALIGN(sizeof(struct task_struct), 64)

and remove the alignment attribute in sched.h?

Or use ARCH_MIN_TASKALIGN == __alignof__(union fpregs_state) which is
also used in fork_init()->kmem_cache_create().

Oleg.


