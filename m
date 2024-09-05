Return-Path: <linux-kernel+bounces-316262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C9696CD2C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC134B24174
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF22145B2D;
	Thu,  5 Sep 2024 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4OUNgPW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CD31A89
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506614; cv=none; b=oQwt8KXELAiKpDALvySuaQ7khAAWLw5kwgCXIFYblY4NfxX6sTMOkBxFoW/UsKlS5X6EoT0S+ye9y7F8hDM/y8lMSKMwVYTDi54ZPPB3h+IeFoltejN1AvqSjB4iZVsrG65x2oFX5ibHSmUftkDdNeH5I3CNvMCLS0rLU91sVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506614; c=relaxed/simple;
	bh=5AaEcoNV9j1SRoWP/YiH9so7VP+RnZlAxDet4kTONbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azyeo75aK7RlRlfnnpc9KVOOCC0AJD9h3N5etWappI4VJWVOhHudFAkgxlESqZxlcQIGE0Wc4ihUEDGYvgs4LyQIvUjEmBoilRTz4uAlz6NV/W+95+rdzj/zp2SF+ci38mqt1f7dJ+AFefNNQLjg/a2MRu9fZTptqn8NpVnn+HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4OUNgPW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725506610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTNSGL25zCLG+PtyocxhqR9poI911nBZG+X7qZt1q6o=;
	b=C4OUNgPWvE5a8RSX3ZZtaXPPa4AhPWY2M1Lo1rq3CN9wYESFxhXctvBWC5obMRUt8JmDYB
	eIlF86w8R4R3fFVaYX8bpbfVTuAVSGl/IxtZh4bHpjMT2Jrne/rZJ36qjBxFK8270WfrN0
	W+E334jK84PItpJypxT8tSnYWocdUno=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-xc-9i_YyNRWBh0VIswKbpA-1; Wed,
 04 Sep 2024 23:23:25 -0400
X-MC-Unique: xc-9i_YyNRWBh0VIswKbpA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 884571977021;
	Thu,  5 Sep 2024 03:23:21 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C7A41955D53;
	Thu,  5 Sep 2024 03:23:18 +0000 (UTC)
Date: Thu, 5 Sep 2024 11:23:14 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
Message-ID: <ZtkkIoUIu8shp/ut@MiWiFi-R3L-srv>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
 <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
 <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
 <1e4a8e18-cda9-45f5-a842-8ffcd725efc9@linux.ibm.com>
 <ZtGqTSMvx6Ljf5Xi@MiWiFi-R3L-srv>
 <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/04/24 at 02:55pm, Sourabh Jain wrote:
> Hello Baoquan,
> 
> On 30/08/24 16:47, Baoquan He wrote:
> > On 08/20/24 at 12:10pm, Sourabh Jain wrote:
> > > Hello Baoquan,
> > > 
......snip... 
> > > 2. A patch to return early from the `crash_handle_hotplug_event()` function
> > > if `kexec_in_progress` is
> > >     set to True. This is essentially my original patch.
> > There's a race gap between the kexec_in_progress checking and the
> > setting it to true which Michael has mentioned.
> 
> The window where kernel is holding kexec_lock to do kexec boot
> but kexec_in_progress is yet not set to True.
> 
> If kernel needs to handle crash hotplug event, the function
> crash_handle_hotplug_event()  will not get the kexec_lock and
> error out by printing error message about not able to update
> kdump image.

But you wanted to avoid the erroring out if it's being in
kernel_kexec().  Now you are seeing at least one the noising 
message, aren't you?

> 
> I think it should be fine. Given that lock is already taken for
> kexec kernel boot.
> 
> Am I missing something major?
> 
> > That's why I think
> > maybe checking kexec_in_progress after failing to retriving
> > __kexec_lock is a little better, not very sure.
> 
> Try for kexec lock before kexec_in_progress check will not solve
> the original problem this patch trying to solve.
> 
> You proposed the below changes earlier:
> 
> -	if (!kexec_trylock()) {
> +	if (!kexec_trylock() && kexec_in_progress) {
>  		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
>  		crash_hotplug_unlock();

Ah, I meant as below, but wrote it mistakenly.

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 63cf89393c6e..e7c7aa761f46 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -504,7 +504,7 @@ int crash_check_hotplug_support(void)
 
 	crash_hotplug_lock();
 	/* Obtain lock while reading crash information */
-	if (!kexec_trylock()) {
+	if (!kexec_trylock() && !kexec_in_progress) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
 		crash_hotplug_unlock();
 		return 0;


> 
> 
> Once the kexec_in_progress is set to True there is no way one can get
> kexec_lock. So kexec_trylock() before kexec_in_progress is not helpful
> for the problem I am trying to solve.

With your patch, you could still get the error message if the race gap
exist. With above change, you won't get it. Please correct me if I am
wrong.


