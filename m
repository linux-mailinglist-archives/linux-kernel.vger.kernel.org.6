Return-Path: <linux-kernel+bounces-200172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38138FAC4D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E48B237F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D31141999;
	Tue,  4 Jun 2024 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHLfYGrx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261F83CB4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486907; cv=none; b=WEeVVWsUyL1MVChuWO2NlJxIYaiQQjm9nguqZGoIq/srnxUETn2GguAoouPMyVWMOXOQS7CRma+W/RgIe0ht1n+pXaKxVJNkiq+6dY6dLjtS9QW4Tn1chcQe2qdl8rmC++znZMrab9WiVmIaol5poR7vS4ISQU/K1+qgdjhj7BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486907; c=relaxed/simple;
	bh=uqrD+mSTw2cbrHqixanYyy0kaU3D0TlQKJePcyo5e5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oppBeDqHIqB3ApjhYbIzpXSalxXeNi1M/el2yvlAlHeYKwCcNrEp8BeUk0qOUD5uOtqSrsxI56Ri75jY9uGdHajsvYv0XhBOQBMMs9yNsYSL3lE4+piFkHIEOmzDISXGlWhkYsaLIQH10hYAm/7OvLkZILL8TdC5kKTdydauyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHLfYGrx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717486904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsMImdYFRkA+pOndLmWX7p9H2qEq17QcVQSCTLk4QM0=;
	b=KHLfYGrxavJeB4PeX6w5j54jk8vFQ1+Lmt3RkpeI4ZRckXZWS+wXHZpJVRJweJaAbh3EcN
	bIcTbZWb++By278lW6bai3ejVNfM8ztK/ZSITchxHKwW+7rF8grzDtqb0A3I2APL1CsL8N
	h/aHfkMDMFqmMQkUhxBfEqNSR5zXiN4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-SJikkqORMAqbpA2TenS47Q-1; Tue,
 04 Jun 2024 03:41:40 -0400
X-MC-Unique: SJikkqORMAqbpA2TenS47Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 007853806620;
	Tue,  4 Jun 2024 07:41:40 +0000 (UTC)
Received: from localhost (unknown [10.72.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B30C4492EE6;
	Tue,  4 Jun 2024 07:41:38 +0000 (UTC)
Date: Tue, 4 Jun 2024 15:41:35 +0800
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
Subject: Re: [PATCH v4 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <Zl7FLw+YrFN/blA+@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-2-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-2-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 05/23/24 at 01:04pm, Coiby Xu wrote:
> Currently, kexec_buf is placed in order which means for the same
> machine, the info in the kexec_buf is always located at the same
> position each time the machine is booted. This may cause a risk for
> sensitive information like LUKS volume key. Now struct kexec_buf has a
> new field random which indicates it's supposed to be placed in a random
> position.
> 
> Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  include/linux/kexec.h |  2 ++
>  kernel/kexec_file.c   | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f0e9f8eda7a3..cc81b8a903ab 100644
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
> index 3d64290d24c9..06b77f9ac4cc 100644
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
> @@ -437,6 +438,16 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
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
> @@ -445,6 +456,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  
>  	temp_end = min(end, kbuf->buf_max);
>  	temp_start = temp_end - kbuf->memsz + 1;
> +	if (kbuf->random)
> +		temp_start = kexec_random_start(temp_start, temp_end);

As we discussed before, this need be limited in kdump scope, seems v4
doesn't include the change.

>  
>  	do {
>  		/* align down start */
> @@ -482,6 +495,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  	unsigned long temp_start, temp_end;
>  
>  	temp_start = max(start, kbuf->buf_min);
> +	if (kbuf->random)
> +		temp_start = kexec_random_start(temp_start, end);
>  
>  	do {
>  		temp_start = ALIGN(temp_start, kbuf->buf_align);
> -- 
> 2.45.0
> 


