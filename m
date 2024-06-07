Return-Path: <linux-kernel+bounces-205762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267FB8FFFEE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7C31F213ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D366157489;
	Fri,  7 Jun 2024 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gt92rqS5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365413C69B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754294; cv=none; b=sZC5tdmarNXFsGCFqfbsej7rjs2TrxnAAaRmb1NPbmrbTUMSKw8ydQKq460EzsziybwwcFYQWyEQ4BfoJfG9SinEaHeq0d5e5EZwIoMwRtrPqYlHdbD3f9HdO+9DawQH/5Dr3zCbrehZFhAP3xGhlh6a7WpJf8L4SLXV/alMWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754294; c=relaxed/simple;
	bh=OUp4arWnBEk08gC3O38TwKeJW7NLAT5ABWE4KhMq2rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzR0/UTJA2kvFQ7brObqEMRoECipctMm+XsrDUqz8mCSmfm5j13nye6s0gRp3OHygTQbbRYTca+J/pdvXPYkb7nXCJ01bu58xclDX3AAGum8ClvWu5Erctn1NsQFqlKeHzoWki29zcmyR6psWjH/9Zi6Y8oYPtE1jhnvRW5SOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gt92rqS5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717754291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYY4ZJyi1ZBeDq5DjfhbsKQZnYv0J07Ec85K0cG2tqA=;
	b=gt92rqS5fAqMqqfANKegtkqoq6tpEdLrj4w3bporF2xbtpTnJThNtXaTSjFSQx9DoDzuB8
	VE0iU9i8L1mFxMujbWlmh4pc8eMtbJXkiTo3kPWo52WZ7hR0NTR0L7Fn1kgX6ItWh+HkF3
	ggSk30qFd/bWphY2Kj8pXN5t2PsmJg4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-ietjylPLPgGuBOoONC0jvQ-1; Fri,
 07 Jun 2024 05:57:58 -0400
X-MC-Unique: ietjylPLPgGuBOoONC0jvQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C10A1955E7F;
	Fri,  7 Jun 2024 09:57:56 +0000 (UTC)
Received: from localhost (unknown [10.72.113.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F42E19560AB;
	Fri,  7 Jun 2024 09:57:48 +0000 (UTC)
Date: Fri, 7 Jun 2024 17:57:38 +0800
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 6/7] x86/crash: pass dm crypt keys to kdump kernel
Message-ID: <ZmLZkvYRJvdRVqwr@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-7-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-7-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 05/23/24 at 01:04pm, Coiby Xu wrote:
> 1st kernel will build up the kernel command parameter dmcryptkeys as
> similar to elfcorehdr to pass the memory address of the stored info of
> dm crypt key to kdump kernel.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/x86/kernel/crash.c           | 15 ++++++++++++++-
>  arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index f06501445cd9..74b3844ae53c 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -266,6 +266,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>  				 unsigned long long mend)
>  {
>  	unsigned long start, end;
> +	int r;
            ~?

r is only to contain the returned value? Then you can call it ret as
many do in kernel code.

>  
>  	cmem->ranges[0].start = mstart;
>  	cmem->ranges[0].end = mend;
> @@ -274,7 +275,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>  	/* Exclude elf header region */
>  	start = image->elf_load_addr;
>  	end = start + image->elf_headers_sz - 1;
> -	return crash_exclude_mem_range(cmem, start, end);
> +	r = crash_exclude_mem_range(cmem, start, end);
> +
> +	if (r)
> +		return r;
> +
> +	/* Exclude dm crypt keys region */
> +	if (image->dm_crypt_keys_addr) {
> +		start = image->dm_crypt_keys_addr;
> +		end = start + image->dm_crypt_keys_sz - 1;
> +		return crash_exclude_mem_range(cmem, start, end);
> +	}

You need adjust the array length of cmem->ranges[], I believe you will
cause the array overflow because the keys are randomly set and mostly
will be in the middle of crashkernel region.

> +
> +	return r;
>  }
>  
>  /* Prepare memory map for crash dump kernel */


