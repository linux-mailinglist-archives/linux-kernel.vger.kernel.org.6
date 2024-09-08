Return-Path: <linux-kernel+bounces-320142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3980E97069B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC6B281854
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F34814C585;
	Sun,  8 Sep 2024 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRZWTgIt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF971742
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725791449; cv=none; b=dnZgU440SnL9w8RDg65BANNIuuGw3KvE9euoVGq2pDed0CjwXpIiY6VuNaf5i10d2xzt3GyMQoBdMOV7PR/14BsOh4i9AlNcvJcKK2jNlZIaDk9PK/yn6pX5u838GTFBdqcsVlHlbbBC06f5ggzhmJOo/g4vp1/bh9FQVmIWZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725791449; c=relaxed/simple;
	bh=BaELaY8cg6cEOAQWaxrPFpr4EaviwT3pJYTbPOjdaSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av439cpdtaStjDdKvjP8u3VZap/xGpN5olM9cbdmO5RC7fQC53qUlKoxuhhjYE5q1HPAtzJGT/lRlxV5KMLIMKFkQylzDCWbcYNVW89Bnjmbd7vswhMvFgm8rBf5eFurgFpQd0Vvp36igJflC6IdnZxAGT7TNQ63bh3bA78s6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRZWTgIt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725791446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5OMd23lOq0TQ1xex/NXYk3jY8jVWK0MlC2mTgfKJm8=;
	b=XRZWTgItqatABYQtL/NNGGSvGv6bKza6yGwmiLvobVKYaIvEPXOHuNOHrUf6ogHy6JtT71
	s8n+AI1rzBogkUwnvWhT8sQJ89IjsBLm6NxCRD8w5GufhkN3uVW+chIDTIQJVeXVANqDr3
	JU1LNRzILJZbjQPh6JiuZYkgyTKqrhw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-3_IErx1HNZWPkhjP_PcxIQ-1; Sun,
 08 Sep 2024 06:30:43 -0400
X-MC-Unique: 3_IErx1HNZWPkhjP_PcxIQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76F5F19560B5;
	Sun,  8 Sep 2024 10:30:41 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91F211956056;
	Sun,  8 Sep 2024 10:30:39 +0000 (UTC)
Date: Sun, 8 Sep 2024 18:30:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
Message-ID: <Zt18yUCWRK8178uv@MiWiFi-R3L-srv>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
 <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
 <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
 <1e4a8e18-cda9-45f5-a842-8ffcd725efc9@linux.ibm.com>
 <ZtGqTSMvx6Ljf5Xi@MiWiFi-R3L-srv>
 <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
 <ZtkkIoUIu8shp/ut@MiWiFi-R3L-srv>
 <c6f30e31-69fe-4ece-b251-c49f1ab59a04@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6f30e31-69fe-4ece-b251-c49f1ab59a04@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/05/24 at 02:07pm, Sourabh Jain wrote:
> Hello Baoquan,
> 
> On 05/09/24 08:53, Baoquan He wrote:
> > On 09/04/24 at 02:55pm, Sourabh Jain wrote:
> > > Hello Baoquan,
> > > 
> > > On 30/08/24 16:47, Baoquan He wrote:
> > > > On 08/20/24 at 12:10pm, Sourabh Jain wrote:
> > > > > Hello Baoquan,
> > > > > 
> > ......snip...
> > > > > 2. A patch to return early from the `crash_handle_hotplug_event()` function
> > > > > if `kexec_in_progress` is
> > > > >      set to True. This is essentially my original patch.
> > > > There's a race gap between the kexec_in_progress checking and the
> > > > setting it to true which Michael has mentioned.
> > > The window where kernel is holding kexec_lock to do kexec boot
> > > but kexec_in_progress is yet not set to True.
> > > 
> > > If kernel needs to handle crash hotplug event, the function
> > > crash_handle_hotplug_event()  will not get the kexec_lock and
> > > error out by printing error message about not able to update
> > > kdump image.
> > But you wanted to avoid the erroring out if it's being in
> > kernel_kexec().  Now you are seeing at least one the noising
> > message, aren't you?
> 
> Yes, but it is very rare to encounter.
> 
> My comments on your updated code are inline below.
> 
> > 
> > > I think it should be fine. Given that lock is already taken for
> > > kexec kernel boot.
> > > 
> > > Am I missing something major?
> > > 
> > > > That's why I think
> > > > maybe checking kexec_in_progress after failing to retriving
> > > > __kexec_lock is a little better, not very sure.
> > > Try for kexec lock before kexec_in_progress check will not solve
> > > the original problem this patch trying to solve.
> > > 
> > > You proposed the below changes earlier:
> > > 
> > > -	if (!kexec_trylock()) {
> > > +	if (!kexec_trylock() && kexec_in_progress) {
> > >   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> > >   		crash_hotplug_unlock();
> > Ah, I meant as below, but wrote it mistakenly.
> > 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 63cf89393c6e..e7c7aa761f46 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -504,7 +504,7 @@ int crash_check_hotplug_support(void)
> >   	crash_hotplug_lock();
> >   	/* Obtain lock while reading crash information */
> > -	if (!kexec_trylock()) {
> > +	if (!kexec_trylock() && !kexec_in_progress) {
> >   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> >   		crash_hotplug_unlock();
> >   		return 0;
> > 
> > 
> > > 
> > > Once the kexec_in_progress is set to True there is no way one can get
> > > kexec_lock. So kexec_trylock() before kexec_in_progress is not helpful
> > > for the problem I am trying to solve.
> > With your patch, you could still get the error message if the race gap
> > exist. With above change, you won't get it. Please correct me if I am
> > wrong.
> 
> The above code will print an error message during the race gap. Here's why:
> 
> Let’s say the kexec lock is acquired in the kernel_kexec() function,
> but kexec_in_progress is not yet set to True. In this scenario, the code
> will print
> an error message.
> 
> There is another issue I see with the above code:
> 
> Consider that the system is on the kexec kernel boot path, and
> kexec_in_progress
> is set to True. If crash_hotplug_unlock() is called, the kernel will not
> only update
> the kdump image without acquiring the kexec lock, but it will also release
> the
> kexec lock in the out label. I believe this is incorrect.
> 
> Please share your thoughts.

How about this?

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 63cf89393c6e..8ba7b1da0ded 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -505,7 +505,8 @@ int crash_check_hotplug_support(void)
 	crash_hotplug_lock();
 	/* Obtain lock while reading crash information */
 	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		if (!kexec_in_progress)
+			pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
 		crash_hotplug_unlock();
 		return 0;
 	}
@@ -540,7 +541,8 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
 	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		if (!kexec_in_progress)
+			pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
 		crash_hotplug_unlock();
 		return;
 	}


