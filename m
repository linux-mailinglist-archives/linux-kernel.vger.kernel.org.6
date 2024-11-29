Return-Path: <linux-kernel+bounces-425166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F839DBE66
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B557281ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 01:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2F117C69;
	Fri, 29 Nov 2024 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdtnOufd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33198F5A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732844353; cv=none; b=naokdnGbWRMW5q1H7ODWlo3UPlkwIW0RHOq5ky/jFO/OmV9w9T34u0uCl5yhAc6mMLTMfVWta6PqsF657NY9nb41agRY2/1lB3KF9B67elaKZ1yu9HqkFpzCcLlZ1/ZDuBEHxnxih+++XsOEnN/tTDFCE/ooBRfiQil+24S+d9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732844353; c=relaxed/simple;
	bh=ud0X1H84PIMDw3Y8TWqE/jS8kkxbv3q7MWM5VIPBmWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ+j+CzdMquYLIsXC7is2qKEw+iRpOeBudx8sfl3aaaUrdwiCAbnJB9fjMVPIodEBnpLp4yex97uBqD8/4F12pYPLPru486iOxcVEH6a9fSA3dqkZ+Tr+v/n/VtO9b5X/k84UlbPsACz19vDFuwbNxeLGyNBtVGAtgGmc5fKh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdtnOufd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732844350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AcoPBJqPfnrqXfE0kcWaR5Iv2I/oXQF2u1YaC3xN78U=;
	b=bdtnOufdRy9uDYAeYRVflbjnCMEHQsahgVS+HgXZ1g6mZ4jq15rzO17uq6tjMyXx1wU9u0
	BaP9/75tEMv5B9NBNCXRJyMEP/FHPsUjC6fyfA+dn57vXrSguVZKR5/0LUONvmkmbi1pf+
	gky1DhnC5piR1ggdmqf+V/vjbX1ER3I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-aGobfphdNmyZWDPCBvHQVw-1; Thu,
 28 Nov 2024 20:39:07 -0500
X-MC-Unique: aGobfphdNmyZWDPCBvHQVw-1
X-Mimecast-MFC-AGG-ID: aGobfphdNmyZWDPCBvHQVw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 513CC195609F;
	Fri, 29 Nov 2024 01:39:05 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B91DB300018D;
	Fri, 29 Nov 2024 01:39:02 +0000 (UTC)
Date: Fri, 29 Nov 2024 09:38:58 +0800
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
	Greg KH <gregkh@linuxfoundation.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v6 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <Z0kbMm0HCZQcD2bI@MiWiFi-R3L-srv>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-2-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029055223.210039-2-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/29/24 at 01:52pm, Coiby Xu wrote:
> Currently, kexec_buf is placed in order which means for the same
> machine, the info in the kexec_buf is always located at the same
> position each time the machine is booted. This may cause a risk for
> sensitive information like LUKS volume key. Now struct kexec_buf has a
> new field random which indicates it's supposed to be placed in a random
> position.

This change the generic code, but you don't mention this only takes
effect in kdump case, won't impact kexec reboot case. I got this from
code, while this should be mentioned in log.

> 
> Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  include/linux/kexec.h | 28 ++++++++++++++++++++++++++++
>  kernel/kexec_file.c   |  3 +++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f0e9f8eda7a3..0dc66ca2506a 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -25,6 +25,10 @@
>  
>  extern note_buf_t __percpu *crash_notes;
>  
> +#ifdef CONFIG_CRASH_DUMP
> +#include <linux/prandom.h>
> +#endif
> +
>  #ifdef CONFIG_KEXEC_CORE
>  #include <linux/list.h>
>  #include <linux/compat.h>
> @@ -171,6 +175,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
>   * @buf_min:	The buffer can't be placed below this address.
>   * @buf_max:	The buffer can't be placed above this address.
>   * @top_down:	Allocate from top of memory.
> + * @random:	Place the buffer at a random position.
>   */
>  struct kexec_buf {
>  	struct kimage *image;
> @@ -182,8 +187,31 @@ struct kexec_buf {
>  	unsigned long buf_min;
>  	unsigned long buf_max;
>  	bool top_down;
> +#ifdef CONFIG_CRASH_DUMP
> +	bool random;
> +#endif
>  };
>  
> +
> +#ifdef CONFIG_CRASH_DUMP
> +static inline void kexec_random_start(unsigned long start, unsigned long end,
                      ~~~~~~~~~~~~~~~~~~
This function name is very confusing. I thought it's a starting to
randomize at the first glance, then realized it's to randomize the
starting position of range.
> +				      struct kexec_buf *kbuf,
> +				      unsigned long *temp_start)
> +{
> +	unsigned short i;
> +
> +	if (kbuf->random) {
> +		get_random_bytes(&i, sizeof(unsigned short));
> +		*temp_start = start + (end - start) / USHRT_MAX * i;
> +	}
> +}
> +#else
> +static inline void kexec_random_start(unsigned long start, unsigned long end,
> +				      struct kexec_buf *kbuf,
> +				      unsigned long *temp_start)
> +{}
> +#endif
> +
>  int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
>  int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
>  				   void *buf, unsigned int size,
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3eedb8c226ad..06565d867b69 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -445,6 +445,7 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  
>  	temp_end = min(end, kbuf->buf_max);
>  	temp_start = temp_end - kbuf->memsz + 1;
> +	kexec_random_start(temp_start, temp_end, kbuf, &temp_start);
>  
>  	do {
>  		/* align down start */
> @@ -483,6 +484,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  
>  	temp_start = max(start, kbuf->buf_min);
>  
> +	kexec_random_start(temp_start, end, kbuf, &temp_start);
> +
>  	do {
>  		temp_start = ALIGN(temp_start, kbuf->buf_align);
>  		temp_end = temp_start + kbuf->memsz - 1;
> -- 
> 2.47.0
> 


