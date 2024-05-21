Return-Path: <linux-kernel+bounces-184416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904D08CA6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20F81C21052
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526217BA4;
	Tue, 21 May 2024 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQvEDn+k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4517722
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261232; cv=none; b=ERw32rF/hzVu+CwtxeO629RwUxGkYwJTqZ0hj8F1Glds6JJVuco8NimznxdUTNNkwbyNNBwtz6wK63yWYl5wnYibQUJO4wMiyEmHzgnU/hm7OCALGfqfLpqUw+amR7viN2avJBkb5FcfVl76fFZyD8s0S3l7qVNFMRXs+BwgzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261232; c=relaxed/simple;
	bh=L6WVvuL+gFvZL0110Lldc+1hgtwVEmdlAqsIL6YHMe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmFJET6qMG0or2Gz54e/wjK+cnC1UgveDuyHUQBUgij41PN2PSBpvXkmkaKtsRuD8JBQSW7rvry/u2dOrTInJsXgrm1xrIYVtodfCWNLbX2BxrusXv3l/n6RDj8yRGFcw+zK4GEkvq3HicMqSUwPkzK5QVgGzAAX5RBCklUIsQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQvEDn+k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716261230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/HzK1apeoYY0DujLj2rbx8MJd+TQtas5Uof0p135Ck=;
	b=MQvEDn+kYWtnJ7xzsJW9XzEZ+zBO5K30hu0Kv8OmZLZcmHyYnYR22WrrhmBUAPIQMsjlto
	ei4wjpMAGH59qz4VeHZ5lSbzOuUPJePtXehfl3Rx87rDa6c/lEV2lN/dnk4S0RxQcKWjNr
	6c6pvk3bT/4lA6ulnuMbGL6OykVmO+I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-ugmp0PizN2unNesMjqUHGA-1; Mon, 20 May 2024 23:13:48 -0400
X-MC-Unique: ugmp0PizN2unNesMjqUHGA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FE3C101A54F;
	Tue, 21 May 2024 03:13:48 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 28DF440C6EB7;
	Tue, 21 May 2024 03:13:46 +0000 (UTC)
Date: Tue, 21 May 2024 11:13:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <ZkwRZxGw2dWStd1C@MiWiFi-R3L-srv>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-2-coxu@redhat.com>
 <ZkrqkzJlW2RZkmH9@MiWiFi-R3L-srv>
 <y5ogivx7qbdm6u37t5o6na4jewn6qofzrbibnsneoqlwns63y5@eg62cytuvwql>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y5ogivx7qbdm6u37t5o6na4jewn6qofzrbibnsneoqlwns63y5@eg62cytuvwql>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 05/21/24 at 09:58am, Coiby Xu wrote:
> On Mon, May 20, 2024 at 02:16:43PM +0800, Baoquan He wrote:
> > On 04/25/24 at 06:04pm, Coiby Xu wrote:
> > > Currently, kexec_buf is placed in order which means for the same
> > > machine, the info in the kexec_buf is always located at the same
> > > position each time the machine is booted. This may cause a risk for
> > > sensitive information like LUKS volume key. Now struct kexec_buf has a
> > > new field random which indicates it's supposed to be placed in a random
> > > position.
> > 
> > Do you want to randomize the key's position for both kdump and kexec
> > rebooting? Assume you only want to do that for kdump. If so, we may need
> > to make that more specific in code.
> 
> Thanks for the suggestion! Currently, no one has requested this feature
> for kexec reboot so yes, I only have kdump in mind. But kdump depends
> on kexec thus I'm not sure how we can make it kdump specfic. Do you have
> a further suggestion?

I remember you said kexec reboot doesn't need the key passed from 1st
kernel to 2nd kernel because the 2nd kernel will calculate one during
boot.

kbuf has the information, the similar handling has been in
kernel/kexec_file.c:

#ifdef CONFIG_CRASH_DUMP
        if (kbuf->image->type == KEXEC_TYPE_CRASH)
                ....;
#endif

> 
> 
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 060835bb82d5..fc1e20d565d5 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -171,6 +171,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
> >  * @buf_min:	The buffer can't be placed below this address.
> >  * @buf_max:	The buffer can't be placed above this address.
> >  * @top_down:	Allocate from top of memory.
> > + * @random:	Place the buffer at a random position.
> 
> How about a comment here saying this is currently only used by kdump.

No, it's not good. Please don't do this, let code tell it.

By the way, can you rebase this series on the latest v6.9 and resend? I
rebase my code and can't apply your patchset.


