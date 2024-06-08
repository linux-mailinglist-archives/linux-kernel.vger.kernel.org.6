Return-Path: <linux-kernel+bounces-206985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604C19010FE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631221C2174D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DF1176FB8;
	Sat,  8 Jun 2024 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UIYrlXYz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50799176AB9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837927; cv=none; b=bBU7ob+Wk/cDcS8ppVQo7maWoiAONrtgu8B0Kr5qnDMQ8wOx5bnf2yLmtLaKa3oiK7gafZURUSpmbLdo5gaAMYV1fC8oL2jPhAaXm9imPRaO9qdBOIWqKekbXV7DCj+ybVXHZgLwftsTwwvjtT4GhLgz2/7R043/KqBwqlHZVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837927; c=relaxed/simple;
	bh=PEWh689hlcM34NTXM0E7lxhNvTQv48Khi94eV33CHc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9APBQoy9xg1sm8iVZuLrBOj49oy0mwcZPs1xyfrKe3W0jQgRJ4VzOTohFHfRUIqXECu/tPckiPIsF5HJjLlvyLmeKKyrkJ5JXXCEgT4VolbZ+E8i6aUjbFWs62Wpr7j+/YhWt672hOD8hB2DFd+iH6ejaXa6V48Sdgkqg0JgNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UIYrlXYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD50BC4AF07;
	Sat,  8 Jun 2024 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717837926;
	bh=PEWh689hlcM34NTXM0E7lxhNvTQv48Khi94eV33CHc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UIYrlXYz8yn2sxe7g5C7C5tbPRrdbybFeelFUwfVBb+7ZJ4ZeHZQiArKJeww7KO3U
	 LwamX1kPtQ0mnjMWBvoPoBkFJXd+J6ac7Z/FWtpHDB6007cv+smcND0TIet14cEwpa
	 fxgoctpduTvIcVZcW1Uv+7q9/Hg9hTCWtnVwJaG8=
Date: Sat, 8 Jun 2024 11:12:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v5 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <2024060842-entryway-gurgle-4ae2@gregkh>
References: <20240607122622.167228-1-coxu@redhat.com>
 <20240607122622.167228-2-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607122622.167228-2-coxu@redhat.com>

On Fri, Jun 07, 2024 at 08:26:11PM +0800, Coiby Xu wrote:
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
>  include/linux/kexec.h |  4 ++++
>  kernel/kexec_file.c   | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f0e9f8eda7a3..c45bfc727737 100644
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
> @@ -182,6 +183,9 @@ struct kexec_buf {
>  	unsigned long buf_min;
>  	unsigned long buf_max;
>  	bool top_down;
> +#ifdef CONFIG_CRASH_DUMP
> +	bool random;
> +#endif

Why is the ifdef needed?

>  };
>  
>  int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3d64290d24c9..f7538d8f67e0 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -25,6 +25,9 @@
>  #include <linux/elfcore.h>
>  #include <linux/kernel.h>
>  #include <linux/kernel_read_file.h>
> +#ifdef CONFIG_CRASH_DUMP
> +#include <linux/prandom.h>
> +#endif

No ifdef in .c files please.  This should not be an issue.

>  #include <linux/syscalls.h>
>  #include <linux/vmalloc.h>
>  #include "kexec_internal.h"
> @@ -437,6 +440,18 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_CRASH_DUMP
> +static unsigned long kexec_random_start(unsigned long start, unsigned long end)
> +{
> +	unsigned long temp_start;
> +	unsigned short i;
> +
> +	get_random_bytes(&i, sizeof(unsigned short));
> +	temp_start = start + (end - start) / USHRT_MAX * i;
> +	return temp_start;
> +}
> +#endif

This #ifdef should be handled properly in the .h file.

> +
>  static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  				    struct kexec_buf *kbuf)
>  {
> @@ -445,6 +460,10 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  
>  	temp_end = min(end, kbuf->buf_max);
>  	temp_start = temp_end - kbuf->memsz + 1;
> +#ifdef CONFIG_CRASH_DUMP
> +	if (kbuf->random)
> +		temp_start = kexec_random_start(temp_start, temp_end);
> +#endif

Same with this.

And why do you need the boolean at all, why not just have
kexec_random_start() handle this properly for you?

thanks,

greg k-h

