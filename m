Return-Path: <linux-kernel+bounces-183427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4C38C98EF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4BD281666
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 06:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA19171BB;
	Mon, 20 May 2024 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnD1YvU6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B498C06
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716185816; cv=none; b=MzUAAuXD3/aGkrnY34Qy0/KTJ27VgOYcQ2dEbOT9kvpMjza4trJSq9vYGIEsp18UOoodpO7x20kXb2wuYSJuOHpY4MV8bowYMqvVU6l0s/ce9Jdg2IoCkk8vyqYcKSG1xmgEBLPP7FniuVV4l1bRryvA0o00V6Id5gk9sDROSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716185816; c=relaxed/simple;
	bh=lZViBqaBQzSXDNMNymhxGYFnehGLUXzWo8b2VXnn/aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4dwqbOD3dX746BMRTYgz9KUCfFNzyn5mNTY0CIM3+vO+PwJoL9ug+8ov1UT2OgjBzBpesyU98vlX9nQen2Zd4KZuPx5U7mzxGlaQ+hQQb73MiqkQkiK2DzRFX3EQh04GiaaPPvDpGwkEe3Y/WnnFsDgw6FqF9ml7mCvmk5a9rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZnD1YvU6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716185813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q31sDE/zOMOC9EHzt6I6xPHg9+oaIupdXfLzTJ+v32I=;
	b=ZnD1YvU6hyTL8zzoC1raL1B3+vH7gI7LfppWbZDht2168AFP0WTwb2WP4QTrWnYt6X9BRV
	8N/RIlTBypJNTVv0MVdkKwFpCRh/hgd0N79JV22leIZh7VNWDNjvb/XvT81bYATYltmnlG
	kjrtNUpvaJa1lZ21+gmfrxxMs3Fn52M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-vZXOS9U_NI-BI7y0BRnSCA-1; Mon, 20 May 2024 02:16:48 -0400
X-MC-Unique: vZXOS9U_NI-BI7y0BRnSCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0A4D800169;
	Mon, 20 May 2024 06:16:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DC6071054824;
	Mon, 20 May 2024 06:16:46 +0000 (UTC)
Date: Mon, 20 May 2024 14:16:43 +0800
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
Message-ID: <ZkrqkzJlW2RZkmH9@MiWiFi-R3L-srv>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-2-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425100434.198925-2-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 04/25/24 at 06:04pm, Coiby Xu wrote:
> Currently, kexec_buf is placed in order which means for the same
> machine, the info in the kexec_buf is always located at the same
> position each time the machine is booted. This may cause a risk for
> sensitive information like LUKS volume key. Now struct kexec_buf has a
> new field random which indicates it's supposed to be placed in a random
> position.

Do you want to randomize the key's position for both kdump and kexec
rebooting? Assume you only want to do that for kdump. If so, we may need
to make that more specific in code.

> 
> Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  include/linux/kexec.h |  2 ++
>  kernel/kexec_file.c   | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 060835bb82d5..fc1e20d565d5 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -171,6 +171,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
>   * @buf_min:	The buffer can't be placed below this address.
>   * @buf_max:	The buffer can't be placed above this address.
>   * @top_down:	Allocate from top of memory.
> + * @random:	Place the buffer at a random position.
>   */
>  struct kexec_buf {
>  	struct kimage *image;
> @@ -182,6 +183,7 @@ struct kexec_buf {
>  	unsigned long buf_min;
>  	unsigned long buf_max;
>  	bool top_down;
> +	bool random;
>  };
>  
>  int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 2d1db05fbf04..e0630fe30d43 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -25,6 +25,7 @@
>  #include <linux/elfcore.h>
>  #include <linux/kernel.h>
>  #include <linux/kernel_read_file.h>
> +#include <linux/prandom.h>
>  #include <linux/syscalls.h>
>  #include <linux/vmalloc.h>
>  #include "kexec_internal.h"
> @@ -432,6 +433,16 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	return ret;
>  }
>  
> +static unsigned long kexec_random_start(unsigned long start, unsigned long end)
> +{
> +	unsigned long temp_start;
> +	unsigned short i;
> +
> +	get_random_bytes(&i, sizeof(unsigned short));
> +	temp_start = start + (end - start) / USHRT_MAX * i;
> +	return temp_start;
> +}
> +
>  static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  				    struct kexec_buf *kbuf)
>  {
> @@ -440,6 +451,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  
>  	temp_end = min(end, kbuf->buf_max);
>  	temp_start = temp_end - kbuf->memsz + 1;
> +	if (kbuf->random)
> +		temp_start = kexec_random_start(temp_start, temp_end);
>  
>  	do {
>  		/* align down start */
> @@ -477,6 +490,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  	unsigned long temp_start, temp_end;
>  
>  	temp_start = max(start, kbuf->buf_min);
> +	if (kbuf->random)
> +		temp_start = kexec_random_start(temp_start, end);
>  
>  	do {
>  		temp_start = ALIGN(temp_start, kbuf->buf_align);
> -- 
> 2.44.0
> 


