Return-Path: <linux-kernel+bounces-319471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7A596FCF1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E4D1C219AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2381D6789;
	Fri,  6 Sep 2024 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9Wr/Eoi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C020EAE7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725656135; cv=none; b=Kg6R49Mqf56avpl8b4EXdM8stDgGNJm0NfX5YdpQMKiU0zBMHBmxZCFBgjIUqwsZNtJ6UyW5rmIQEgPkQkZqez07zFs1WD3li9CPtbIRww01IJ6DrK0eAmM00P3MNv5Ez7TtRL9gArqJxu/7H8ccUkDASLkuD/9G2qqxJljf+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725656135; c=relaxed/simple;
	bh=5njwdOk3TNfBSKxifh68TZZM6jHoTAXOxatEVpmLHys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYfKjDVv0rrHMkpI1Tyu+jCN4trMxnAYHVhbgN2T3WqZdefPT9Nym7R5Z8R4QicOxYDPKCHm8GkvM5stFJIEiNSnMhN+oTGW4cLS9EGBeZMv5iOeKaJam8jzHHDHqvipYaBMNxHH5ArM10hsUfb7J6admMHhrnBrF0kXOVZpAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9Wr/Eoi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725656130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xo3grFhI2uQRXcZF9zH10dPv1P1lkQZgkcMob6qJdeY=;
	b=X9Wr/Eoib0zGupXXk8fFhaFR+Mbf3kFuU8ON1aiI4om6DE9kNSlXn7ua2h7AAPFQRv8Ewg
	0y38hoxYCocd7vkof//MBsN9LV2DB7IlTGbuc0gr9rCBXVYH81/mvzAmC10uuMVVEfMBm3
	P5j/RwEWagpciKS7rdWluqdjf16x59o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-EtAVEsDJMmqZztgu23rExg-1; Fri,
 06 Sep 2024 16:55:26 -0400
X-MC-Unique: EtAVEsDJMmqZztgu23rExg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD0F619560AD;
	Fri,  6 Sep 2024 20:55:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.3])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 503B31956086;
	Fri,  6 Sep 2024 20:55:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  6 Sep 2024 22:55:14 +0200 (CEST)
Date: Fri, 6 Sep 2024 22:55:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc
 FS
Message-ID: <20240906205436.GA2417@redhat.com>
References: <20240905212741.143626-1-romank@linux.microsoft.com>
 <20240905212741.143626-2-romank@linux.microsoft.com>
 <20240906112345.GA17874@redhat.com>
 <CAHk-=wjtMKmoC__NJ5T18TaRCqXL-3VFc6uADJv_MzgR1ZWPJQ@mail.gmail.com>
 <da4baf5b-19e9-474c-90f6-fe17dd934333@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da4baf5b-19e9-474c-90f6-fe17dd934333@linux.microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Well, I leave this to you and Linus (and other reviewers), but if it was not
clear I too do not really like this feature, that is why I added cc's.

Perhaps it makes sense to discuss the alternatives? Say, a process can have a
please_insert_the_breakpoint_here() function implemented in asm which just does
asm(ret).

Then something like

	#define breakpoint_if_debugging()	\
		asm volatile ("call please_insert_the_breakpoint_here" : ASM_CALL_CONSTRAINT);

if the process is ptraced, debugger can insert the breakoint into
please_insert_the_breakpoint_here(). Otherwise breakpoint_if_debugging()
is a cheap nop.

Not that I think this is a good idea, but std::breakpoint_if_debugging()
looks even more strange to me...

Oleg.

On 09/06, Roman Kisel wrote:
>
> All told, let me know if I may proceed with fixing the code as Oleg
> suggested, or this piece should go into the waste basket. I could make
> an argument that providing the way to get the tracer PID only via
> proc FS through parsing text is more like shell/Perl/Python interface
> to the kernel, and for compiled languages could have what's easier in
> that setting (there is an easy syscall for getting PID, and there could
> be code changing the logic on the PID being odd or even for the sake
> of argument).
> 
> >
> >                Linus
> 
> -- 
> Thank you,
> Roman
> 


