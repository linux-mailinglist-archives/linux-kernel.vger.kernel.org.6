Return-Path: <linux-kernel+bounces-325178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1139755D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603EB1C22D38
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3939B1A0716;
	Wed, 11 Sep 2024 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoqC8DEK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D848F156993
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065878; cv=none; b=U5s5NSwtZARUY/wKkV0ly/GZmxdJwJJebVXICkpQnFoy7QD3z1epE8ifyPXfVGy0h0EI0l+GoJQqsZ7tKrOyL+61eeBQl3a+Z5Wclrg2PNGtNS10K4uiUeUZHGH3/Cw89vbS/wn33PiKD3WLNjH6RtZ0vY/7/OtLexPnTuRCBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065878; c=relaxed/simple;
	bh=4kIT1B0JWX+pVn86U88ODnkmGN/w1KmWISdgfzBd3iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEHAPtlyKW8mjb4wTyQ9iw+zEWJCW7gm3nNK2hk/fZ7tYYLQtq0CZV8fmpeIiOZ0fbBy+ANOGy67I7hNaqQEUB5M8DsPixQ340Y+/mE57+qln+Tp0fVNssZzEAWn0B0Ogz1Pz4fzUkhkosVufjtnNTMLs3PmRFDBttm3Pc1jRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoqC8DEK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726065875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=af/nBiUfHse3CRbP2Tt5RMMzbsiKe+R9DpXW2Bslduo=;
	b=KoqC8DEKzB0BM+2Ta7CbNqiG5ZKC1DTn/+Vb/jbkiDWm48pMYkk5bSuAeB65bHzZeHe+kX
	BIk6hHfUqKdI035a2YkKZc2QPOFLQ8SSnliPIfobqS5cfWfMIFosfruFGd+qZWTa2CEL3x
	TpterLAPVOGktrPV4OPnotTXEZoEqD8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-fvx_2VdrPcy2HipLIe3Jew-1; Wed,
 11 Sep 2024 10:44:32 -0400
X-MC-Unique: fvx_2VdrPcy2HipLIe3Jew-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C801E1955D4B;
	Wed, 11 Sep 2024 14:44:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.229])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A7FBA19560AD;
	Wed, 11 Sep 2024 14:44:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 11 Sep 2024 16:44:18 +0200 (CEST)
Date: Wed, 11 Sep 2024 16:44:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: akpm@linux-foundation.org, apais@microsoft.com, benhill@microsoft.com,
	ebiederm@xmission.com, linux-kernel@vger.kernel.org,
	ssengar@microsoft.com, sunilmut@microsoft.com,
	torvalds@linux-foundation.org, vdso@hexbites.dev,
	workingjubilee@gmail.com
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc
 FS
Message-ID: <20240911144412.GA16954@redhat.com>
References: <20240909193725.GD14058@redhat.com>
 <20240910154035.1204504-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910154035.1204504-1-romank@linux.microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

We certainly can't understand each other. At least, I certainly can't.

On 09/10, Roman Kisel wrote:
>
> On 09/09, Oleg wrote:
>

> > Yet another thing in this discussion I can't understand... sorry, I tried.
> > You do not need to teach, say, gdb to recognize this pattern. You can just do
> >
> > 	$ gdb -ex 'b please_insert_the_breakpoint_here' ...
> >
> > Nevermind, as I have already said you can safely ignore me. I still do not
> > see any "real" use-case for breakpoint_if_debugging(), but I guess that is
> > due to my ignorance and lack of imagination.
>
> I've started this so let me butt in and take up the gaunlet.
>
> Lambda's would be the most prominent example to me[1]. The toolchain
> doesn't give them the user-accesible type and the name as it does for
> the functions.

And?

Once again, what I tried to suggest is a single "nop" function,
"void please_insert_the_breakpoint_here()" which simply does asm("ret") and

	#define breakpoint_if_debugging()	\
		please_insert_the_breakpoint_here()

Or, to make it more cheap,

	#define breakpoint_if_debugging()	\
		asm volatile ("call please_insert_the_breakpoint_here" : ASM_CALL_CONSTRAINT);

so that compiler will know that breakpoint_if_debugging() doesn't change the regs.

Again, again, I am not saying that this is necessarily the best solution.
Just I fail to understand your email, sorry.

Oleg.


