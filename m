Return-Path: <linux-kernel+bounces-291515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790EE956384
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6A81C213B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A508E14A4F9;
	Mon, 19 Aug 2024 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0dFYkBe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3710E0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724048172; cv=none; b=XhDfADtzdXJoQk8CFrUuWpVwVz2vdKlS2s+pgMVDsrYCT7ZyGQy+Rp5yv69qBGnPQKkhSyNSmRa3YeC3tR/PjG2SnSDg7GZfKDiCG4XxyrtRzE9rnjU7GW6KBBzBewmwZBB/ZqU0+4J0MdAElbwQE4VRsGPrksMZSBZi6BEJVsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724048172; c=relaxed/simple;
	bh=zMpl/AKC48nfInm2wePJYQN2vkIXa6gulnZnPDwprDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1fo/xKErUO+TPOUJOSwl8R3jueddGM+2sQDnqMpbj75bX9tUZs+d0M/NblAKvCNWRqi6Kzkob1qas0Gc202XJ57iu+ki2OqbjWEqzMIM/3lyfVSTCtR+Nuh8ggIagqqkb6osGLSwbVRnZnkQsyLoHi7HblAYcTYMWRHvWqJZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0dFYkBe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724048165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcJLl/Fp3h6jQcz16e/hG76KVnOut/BqwVl6XHyRN6I=;
	b=S0dFYkBehoCsRyJEV/tlcOsoDp4j+1ql1+kd7LriDg6gyZG/2f8D7UPS2SSBfRfDNJAz9l
	ff+8gK0B3AurHHdGBMh4gvXsTev63Ju/Lxjg8McelBIgde2objotDWuwRkt6EBdPbfb9aF
	URTM65fZISK8XUioyi3zVRqFRrzPxeY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-UEOZI0jQNFyoDul8YmFjXw-1; Mon,
 19 Aug 2024 02:16:01 -0400
X-MC-Unique: UEOZI0jQNFyoDul8YmFjXw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13E011955EA6;
	Mon, 19 Aug 2024 06:15:59 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB58419773E0;
	Mon, 19 Aug 2024 06:15:56 +0000 (UTC)
Date: Mon, 19 Aug 2024 14:15:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
Message-ID: <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
 <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/19/24 at 09:45am, Sourabh Jain wrote:
> Hello Michael and Boaquan
> 
> On 01/08/24 12:21, Sourabh Jain wrote:
> > Hello Michael,
> > 
> > On 01/08/24 08:04, Michael Ellerman wrote:
> > > Sourabh Jain <sourabhjain@linux.ibm.com> writes:
> > > > The following errors are observed when kexec is done with SMT=off on
> > > > powerpc.
> > > > 
> > > > [  358.458385] Removing IBM Power 842 compression device
> > > > [  374.795734] kexec_core: Starting new kernel
> > > > [  374.795748] kexec: Waking offline cpu 1.
> > > > [  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may
> > > > be inaccurate
> > > > [  374.935833] kexec: Waking offline cpu 2.
> > > > [  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may
> > > > be inaccurate
> > > > snip..
> > > > [  375.515823] kexec: Waking offline cpu 6.
> > > > [  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may
> > > > be inaccurate
> > > > [  375.695836] kexec: Waking offline cpu 7.
> > > Are they actually errors though? Do they block the actual kexec from
> > > happening? Or are they just warnings in dmesg?
> > 
> > The kexec kernel boots fine.
> > 
> > This warning appears regardless of whether the kdump kernel is loaded.
> > 
> > However, when the kdump kernel is loaded, we will not be able to update
> > the kdump image (FDT).
> > I think this should be fine given that kexec is in progress.
> > 
> > Please let me know your opinion.
> > 
> > > Because the fix looks like it could be racy.
> > 
> > It seems like it is racy, but given that kexec takes the lock first and
> > then
> > brings the CPU up, which triggers the kdump image, which always fails to
> > update the kdump image because it could not take the same lock.
> > 
> > Note: the kexec lock is not released unless kexec boot fails.
> 
> Any comments or suggestions on this fix?

Is this a little better?

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 63cf89393c6e..0355ffb712f4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -504,7 +504,7 @@ int crash_check_hotplug_support(void)
 
 	crash_hotplug_lock();
 	/* Obtain lock while reading crash information */
-	if (!kexec_trylock()) {
+	if (!kexec_trylock() && kexec_in_progress) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
 		crash_hotplug_unlock();
 		return 0;
@@ -539,7 +539,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 
 	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
-	if (!kexec_trylock()) {
+	if (!kexec_trylock() && kexec_in_progress) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
 		crash_hotplug_unlock();
 		return;


