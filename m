Return-Path: <linux-kernel+bounces-320625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAED970CEB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD73281D72
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726D71ACE00;
	Mon,  9 Sep 2024 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRxMLm0f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7960B658
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725859398; cv=none; b=ZAJZ/nBBqlJy2HJQkNaBJ2UtSnlL2r7dto1oajx39T79uzBcokdbtQScSAU81uhRSCMT+2OH0DxdJ7CW6PiwKRRxb1W5PRqNaMHb3k9fSFobLBFT50Rm2BQT5hVzB8TMyijKzhg2Mz2P3a0p35RLnp7AQWYvRFFvcbFxej2Goys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725859398; c=relaxed/simple;
	bh=RPMp4FRmCftcWlzdRjP4eKzAarDOOFiTRxyH0fgiwoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVd+Anqxx79aRzg2AR4EgmFJc4R3RN1UcSMuhpUsad9hz0H4gNlAzRsCtwDR4T+1kD9W+ipgQJP4ccyXlDgBB1WbHA60k11cfY7OGxFiSnp6fHQFAz2UEtfNPxcNrKnifsQxyHr+u34BaBUwVYTAg/PSzTHQ9x45jcRZe7BdZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRxMLm0f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725859395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzLkUxdBpwgP0gzmAUnHOrx/rBDL95koWZdpypmHSGY=;
	b=LRxMLm0focrbQzkAyda4ngoMDPveIgZphbCraMTfPCbmteEECzscjWkBCAq1gXjNntKjqS
	Z31IxJF3PQagfbm4js/78kvKvTkl7KsP024maAXsVvTVbloYqx4INALlyvzUqNrQa+z1VG
	8VG1r5iTYU5AB7ols0SZolynLD3u3gg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-Ag5vyR1NOH6F5UWm4Ua-FA-1; Mon,
 09 Sep 2024 01:23:12 -0400
X-MC-Unique: Ag5vyR1NOH6F5UWm4Ua-FA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FD2B1955F06;
	Mon,  9 Sep 2024 05:23:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E18191956054;
	Mon,  9 Sep 2024 05:23:07 +0000 (UTC)
Date: Mon, 9 Sep 2024 13:23:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
Message-ID: <Zt6GNqIUbEl8M4QD@MiWiFi-R3L-srv>
References: <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
 <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
 <1e4a8e18-cda9-45f5-a842-8ffcd725efc9@linux.ibm.com>
 <ZtGqTSMvx6Ljf5Xi@MiWiFi-R3L-srv>
 <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
 <ZtkkIoUIu8shp/ut@MiWiFi-R3L-srv>
 <c6f30e31-69fe-4ece-b251-c49f1ab59a04@linux.ibm.com>
 <Zt18yUCWRK8178uv@MiWiFi-R3L-srv>
 <9eba8dc4-ceb3-4234-b352-aeb34c840e70@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eba8dc4-ceb3-4234-b352-aeb34c840e70@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/09/24 at 10:35am, Sourabh Jain wrote:
> 
> 
> On 08/09/24 16:00, Baoquan He wrote:
> > On 09/05/24 at 02:07pm, Sourabh Jain wrote:
> > > Hello Baoquan,
> > > 
> > > On 05/09/24 08:53, Baoquan He wrote:
> > > > On 09/04/24 at 02:55pm, Sourabh Jain wrote:
> > > > > Hello Baoquan,
> > > > > 
> > > > > On 30/08/24 16:47, Baoquan He wrote:
> > > > > > On 08/20/24 at 12:10pm, Sourabh Jain wrote:
> > > > > > > Hello Baoquan,
> > > > > > > 
> > > > ......snip...
> > > > > > > 2. A patch to return early from the `crash_handle_hotplug_event()` function
> > > > > > > if `kexec_in_progress` is
> > > > > > >       set to True. This is essentially my original patch.
> > > > > > There's a race gap between the kexec_in_progress checking and the
> > > > > > setting it to true which Michael has mentioned.
> > > > > The window where kernel is holding kexec_lock to do kexec boot
> > > > > but kexec_in_progress is yet not set to True.
> > > > > 
> > > > > If kernel needs to handle crash hotplug event, the function
> > > > > crash_handle_hotplug_event()  will not get the kexec_lock and
> > > > > error out by printing error message about not able to update
> > > > > kdump image.
> > > > But you wanted to avoid the erroring out if it's being in
> > > > kernel_kexec().  Now you are seeing at least one the noising
> > > > message, aren't you?
> > > Yes, but it is very rare to encounter.
> > > 
> > > My comments on your updated code are inline below.
> > > 
> > > > > I think it should be fine. Given that lock is already taken for
> > > > > kexec kernel boot.
> > > > > 
> > > > > Am I missing something major?
> > > > > 
> > > > > > That's why I think
> > > > > > maybe checking kexec_in_progress after failing to retriving
> > > > > > __kexec_lock is a little better, not very sure.
> > > > > Try for kexec lock before kexec_in_progress check will not solve
> > > > > the original problem this patch trying to solve.
> > > > > 
> > > > > You proposed the below changes earlier:
> > > > > 
> > > > > -	if (!kexec_trylock()) {
> > > > > +	if (!kexec_trylock() && kexec_in_progress) {
> > > > >    		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> > > > >    		crash_hotplug_unlock();
> > > > Ah, I meant as below, but wrote it mistakenly.
> > > > 
> > > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > > index 63cf89393c6e..e7c7aa761f46 100644
> > > > --- a/kernel/crash_core.c
> > > > +++ b/kernel/crash_core.c
> > > > @@ -504,7 +504,7 @@ int crash_check_hotplug_support(void)
> > > >    	crash_hotplug_lock();
> > > >    	/* Obtain lock while reading crash information */
> > > > -	if (!kexec_trylock()) {
> > > > +	if (!kexec_trylock() && !kexec_in_progress) {
> > > >    		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> > > >    		crash_hotplug_unlock();
> > > >    		return 0;
> > > > 
> > > > 
> > > > > Once the kexec_in_progress is set to True there is no way one can get
> > > > > kexec_lock. So kexec_trylock() before kexec_in_progress is not helpful
> > > > > for the problem I am trying to solve.
> > > > With your patch, you could still get the error message if the race gap
> > > > exist. With above change, you won't get it. Please correct me if I am
> > > > wrong.
> > > The above code will print an error message during the race gap. Here's why:
> > > 
> > > Let’s say the kexec lock is acquired in the kernel_kexec() function,
> > > but kexec_in_progress is not yet set to True. In this scenario, the code
> > > will print
> > > an error message.
> > > 
> > > There is another issue I see with the above code:
> > > 
> > > Consider that the system is on the kexec kernel boot path, and
> > > kexec_in_progress
> > > is set to True. If crash_hotplug_unlock() is called, the kernel will not
> > > only update
> > > the kdump image without acquiring the kexec lock, but it will also release
> > > the
> > > kexec lock in the out label. I believe this is incorrect.
> > > 
> > > Please share your thoughts.
> > How about this?
> > 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 63cf89393c6e..8ba7b1da0ded 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -505,7 +505,8 @@ int crash_check_hotplug_support(void)
> >   	crash_hotplug_lock();
> >   	/* Obtain lock while reading crash information */
> >   	if (!kexec_trylock()) {
> > -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> > +		if (!kexec_in_progress)
> > +			pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> >   		crash_hotplug_unlock();
> >   		return 0;
> >   	}
> > @@ -540,7 +541,8 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
> >   	crash_hotplug_lock();
> >   	/* Obtain lock while changing crash information */
> >   	if (!kexec_trylock()) {
> > -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> > +		if (!kexec_in_progress)
> > +			pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> >   		crash_hotplug_unlock();
> >   		return;
> >   	}
> 
> Yes putting pr_info under kexec in progress check would work.
> 
> I will rebase the patch on top on next-20240906 to avoid conflict with
> https://lore.kernel.org/all/20240812041651.703156-1-sourabhjain@linux.ibm.com/T/#u
> and send v2.

Great. When you repost, can you please also add why ppc will hot add cpu
into patch log when crash triggered? Otherwise other people may be
confused when reading code here or trace back the code change.


