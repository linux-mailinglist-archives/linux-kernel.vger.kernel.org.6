Return-Path: <linux-kernel+bounces-320120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FA097065E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE973B21748
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2E11494B8;
	Sun,  8 Sep 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2ripcD+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2C1366
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725789879; cv=none; b=bCbrxz2s39au9RTe+1nKGpAr5iUvx7DAB9f81Tz6kARV5wvnng5Kf0Iv/pR/7x6YZ4FWStKMYqi1UG6Iuhn5OuMrgasPDFFEeUeEvHwKRDW5LPLof6sfpVtNXdddDPGqqE07oofUPEE2kgz7drAw9rTk4Cu8Gqq1F4vG7gtZpS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725789879; c=relaxed/simple;
	bh=Z+9F2lHpgbWkNhUVte7tPdFaS9QNuslBa1JAB+xG520=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2AK8aAVQkusYXSYURMjltmD7G8VlMr4ieRuJ5wAzCbIhxIngMi+2cshSHQbS/X8xo5z0zo9e6yiowf/F2tMVTACL6tJ5b53o4PRP6ygykrsub3IE2YP/6RwRS6YMXFrRhRbQ0Z2VCKGVJpzhHNagnaukHOVIpoYIgm7zbBFbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2ripcD+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725789876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4s6L1b6UTWwXIgN+h2ZkyoLWzDj1bmp+8k4owaes3c=;
	b=i2ripcD+m8VbXyVQ1nLHNXcONtm4WYnWYsmdgkyGVnwTDxmCiwWN5Cq0VwkGoOmTie/Jcf
	wW/l5zjsdX0ZDb9gQCwmqkRlvt8t8flzPadQw0ZEJWQmVUv7GIbwdEYfflSJYWei1Mt8ba
	IyiJ1sUXroAzhqt/v6O1CEmaUoxjJBM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-ADwoEIdTNxK39xifeSiilQ-1; Sun,
 08 Sep 2024 06:04:33 -0400
X-MC-Unique: ADwoEIdTNxK39xifeSiilQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1466119560AB;
	Sun,  8 Sep 2024 10:04:31 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6D951956048;
	Sun,  8 Sep 2024 10:04:28 +0000 (UTC)
Date: Sun, 8 Sep 2024 18:04:23 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] [RFC] crash: Lock-free crash hotplug support reporting
Message-ID: <Zt12p/eOCO0D5/e6@MiWiFi-R3L-srv>
References: <20240823115226.835865-1-sourabhjain@linux.ibm.com>
 <641be54a-440f-475b-a62d-fac157ecbbcb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <641be54a-440f-475b-a62d-fac157ecbbcb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/07/24 at 10:30am, Sourabh Jain wrote:
> Hello Baoquan,
> 
> Do you think this patch would help reduce lock contention when
> CPU/Memory resources are removed in bulk from a system?
.....snip...
--
> >   include/linux/kexec.h | 11 ++++-------
> >   kernel/crash_core.c   | 27 +++++++++------------------
> >   kernel/kexec.c        |  5 ++++-
> >   kernel/kexec_file.c   |  7 ++++++-
> >   4 files changed, 23 insertions(+), 27 deletions(-)
> > 
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index f0e9f8eda7a3..bd755ba6bac4 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -318,13 +318,6 @@ struct kimage {
> >   	unsigned int preserve_context : 1;
> >   	/* If set, we are using file mode kexec syscall */
> >   	unsigned int file_mode:1;
> > -#ifdef CONFIG_CRASH_HOTPLUG
> > -	/* If set, it is safe to update kexec segments that are
> > -	 * excluded from SHA calculation.
> > -	 */
> > -	unsigned int hotplug_support:1;
> > -#endif
> > -
> >   #ifdef ARCH_HAS_KIMAGE_ARCH
> >   	struct kimage_arch arch;
> >   #endif
> > @@ -370,6 +363,10 @@ struct kimage {
> >   	unsigned long elf_load_addr;
> >   };
> > +#ifdef CONFIG_CRASH_HOTPLUG
> > +extern unsigned int crash_hotplug_support;
> > +#endif
> > +
> >   /* kexec interface functions */
> >   extern void machine_kexec(struct kimage *image);
> >   extern int machine_kexec_prepare(struct kimage *image);
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 63cf89393c6e..3428deba0070 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -30,6 +30,13 @@
> >   #include "kallsyms_internal.h"
> >   #include "kexec_internal.h"
> > +#ifdef CONFIG_CRASH_HOTPLUG
> > +/* if set, it is safe to update kexec segments that are
> > + * excluded from sha calculation.
> > + */
> > +unsigned int crash_hotplug_support;
> > +#endif
> > +
> >   /* Per cpu memory for storing cpu states in case of system crash. */
> >   note_buf_t __percpu *crash_notes;
> > @@ -500,23 +507,7 @@ static DEFINE_MUTEX(__crash_hotplug_lock);
> >    */
> >   int crash_check_hotplug_support(void)
> >   {
> > -	int rc = 0;
> > -
> > -	crash_hotplug_lock();
> > -	/* Obtain lock while reading crash information */
> > -	if (!kexec_trylock()) {
> > -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> > -		crash_hotplug_unlock();
> > -		return 0;
> > -	}
> > -	if (kexec_crash_image) {
> > -		rc = kexec_crash_image->hotplug_support;
> > -	}
> > -	/* Release lock now that update complete */
> > -	kexec_unlock();
> > -	crash_hotplug_unlock();
> > -
> > -	return rc;
> > +	return crash_hotplug_support;


I may not understand this well. Both kexec_load and kexec_file_load set
hotplug_support, crash_check_hotplug_support and
crash_handle_hotplug_event are to check the flag. How do you guarantee
the cpu/memory sysfs checking won't have race with kexec_load and
kexec_file_load?

And here I see taking crash_hotplug_lock() is unnecessary in
crash_check_hotplug_support() because it does't have race with
crash_handle_hotplug_event().

> >   }
> >   /*
> > @@ -552,7 +543,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
> >   	image = kexec_crash_image;
> >   	/* Check that kexec segments update is permitted */
> > -	if (!image->hotplug_support)
> > +	if (!crash_hotplug_support)
> >   		goto out;
> >   	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index a6b3f96bb50c..d5c6b51eaa8b 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -116,6 +116,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> >   		/* Uninstall image */
> >   		kimage_free(xchg(dest_image, NULL));
> >   		ret = 0;
> > +#ifdef CONFIG_CRASH_HOTPLUG
> > +		crash_hotplug_support = 0;
> > +#endif
> >   		goto out_unlock;
> >   	}
> >   	if (flags & KEXEC_ON_CRASH) {
> > @@ -136,7 +139,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> >   #ifdef CONFIG_CRASH_HOTPLUG
> >   	if ((flags & KEXEC_ON_CRASH) && arch_crash_hotplug_support(image, flags))
> > -		image->hotplug_support = 1;
> > +		crash_hotplug_support = 1;
> >   #endif
> >   	ret = machine_kexec_prepare(image);
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 3d64290d24c9..b326edb90fd7 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -378,7 +378,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >   #ifdef CONFIG_CRASH_HOTPLUG
> >   	if ((flags & KEXEC_FILE_ON_CRASH) && arch_crash_hotplug_support(image, flags))
> > -		image->hotplug_support = 1;
> > +		crash_hotplug_support = 1;
> >   #endif
> >   	ret = machine_kexec_prepare(image);
> > @@ -432,6 +432,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >   		arch_kexec_protect_crashkres();
> >   #endif
> > +#ifdef CONFIG_CRASH_HOTPLUG
> > +	if (flags & KEXEC_FILE_UNLOAD)
> > +		crash_hotplug_support = 0;
> > +#endif
> > +
> >   	kexec_unlock();
> >   	kimage_free(image);
> >   	return ret;
> 


