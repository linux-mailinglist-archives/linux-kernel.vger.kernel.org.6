Return-Path: <linux-kernel+bounces-325545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F51975B26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4537E1C21E33
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702BA1BAECA;
	Wed, 11 Sep 2024 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAPcWLIU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128C17DFFC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084443; cv=none; b=sApbQbptNoFlbewK63gfPXTlqln8aG7+2BPc1/BabJ+D2VQsr6VqE21bida0KD3KS5HQb0E/bEgoRKBmKeaCh0fxEFFnqZXFUaXMy3NlF/HN65wfhfNRw/2iOA2Pw1PO7LzB9+kRPooIUV5TR2jxBX1Odbjg05EZ1Yrcsc/BiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084443; c=relaxed/simple;
	bh=pHlkQ6ypIZDzwKm06NWpMCd94Ru37rolDgKvTxFDjQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ele/gTfcP5u0gegreOdV3onLuUJ/mhCiT/SK/KdjN4hKIzAQ05hCJWNDXexO5tk9uhDyqHS/K5+Uw2iRIQ0q3Bf/SvYn5c5o/cjdGgONFBcuCek+/GC7fDyAPrsAent8ruwMmnXvYu9lPpkMFN1WI6rHlh40CefufMQYoqEG5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAPcWLIU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726084441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lBLW5x5QxN4WN47Z2LIKR2ks99S8dKSDYhoZXe/aZx8=;
	b=LAPcWLIUiXTQTeq/3/BmMkwsq/Dy0UF8GW8v4cRafbZj7EXWrHErp5kHTRC/EyJRlzY4as
	/+CDuSZTmyfYFCeyHjEawfwvL3dBmiPRiHWMCeOv6ZGgA2M5d/9eM5bpvDixr7wy2WIdHz
	IvDdbWAPgVcS71VBS9HR3ljA7nlzOS8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-TfFlXB4ONC-c_pVlMahkdQ-1; Wed,
 11 Sep 2024 15:53:57 -0400
X-MC-Unique: TfFlXB4ONC-c_pVlMahkdQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7E92195608C;
	Wed, 11 Sep 2024 19:53:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.43])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7781A19560AA;
	Wed, 11 Sep 2024 19:53:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 11 Sep 2024 21:53:43 +0200 (CEST)
Date: Wed, 11 Sep 2024 21:53:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: akpm@linux-foundation.org, apais@microsoft.com, benhill@microsoft.com,
	ebiederm@xmission.com, linux-kernel@vger.kernel.org,
	ssengar@microsoft.com, sunilmut@microsoft.com,
	torvalds@linux-foundation.org, vdso@hexbites.dev,
	workingjubilee@gmail.com
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc
 FS
Message-ID: <20240911195311.GA16757@redhat.com>
References: <20240911144412.GA16954@redhat.com>
 <20240911174107.1217693-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911174107.1217693-1-romank@linux.microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Roman,

I can only repeat that we can't understand each other. Quite possibly my bad.

On 09/11, Roman Kisel wrote:
>
> On 09/11, Oleg Nesterov wrote:
>
> > On 09/10, Roman Kisel wrote:
> > >
> > > On 09/09, Oleg wrote:
> > >
> >
> > > > Yet another thing in this discussion I can't understand... sorry, I tried.
> > > > You do not need to teach, say, gdb to recognize this pattern. You can just do
> > > >
> > > > 	$ gdb -ex 'b please_insert_the_breakpoint_here' ...
> > > >
> > > > Nevermind, as I have already said you can safely ignore me. I still do not
> > > > see any "real" use-case for breakpoint_if_debugging(), but I guess that is
> > > > due to my ignorance and lack of imagination.
> > >
> > > I've started this so let me butt in and take up the gaunlet.
> > >
> > > Lambda's would be the most prominent example to me[1]. The toolchain
> > > doesn't give them the user-accesible type and the name as it does for
> > > the functions.
> >
> > And?
>
> You wanted an example of '"real" use-case for breakpoint_if_debugging()':

Then why does your email explain that c++ lambdas don't have a good name?
Why doesi it mention lambdas at all?

> > > > Nevermind, as I have already said you can safely ignore me. I still do not
> > > > see any "real" use-case for breakpoint_if_debugging(), but I guess that is
> > > > due to my ignorance and lack of imagination.
>
> I have provided them, and illustrated how it is tiresome to set the breakpoint
> in the debugger in these cases so can add a call to breakpoint_if_debugging()
> to these places instead.

Instead of what??? Instead of

	#define breakpoint_if_debugging()	\
		asm volatile ("call please_insert_the_breakpoint_here" : ASM_CALL_CONSTRAINT);

plus -ex 'b please_insert_the_breakpoint_here'???

If you say that this is ugly I won't even argue. But instead of what?

Roman, I am leaving this thread, sorry. But let me try to summarize.
Your patch was buggy and you seem to agree. Feel free to send V2 and I will
be happy to review it correctness-wise. But:

	- please keep Eric/Linus cc'ed

	- please try to make your changelog more convincing. And in particular,
	  please explain why !!current->ptrace is not enough and this feature
	  needs the tracer's pid.

	  If possible, please provide a clear/simple/artificial/whatever example
	  of the (pseudo)code which can justify this feature.
Oleg.


