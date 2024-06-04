Return-Path: <linux-kernel+bounces-200751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A8F8FB47F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E021C22A45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06678DDB1;
	Tue,  4 Jun 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igiEY8Bb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8622EAD0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509187; cv=none; b=YDljWl5wqEztySnCGevepH2iGH96n3raYStBUrnU/+u5Brf4jwxIF5gHVgwhGktC/qk5p38D+s2TMdkB3g/ijnwfZG+GUfe2wHUwt7j1TYmcKpjZkAeROD3H3hXfaO0IImMnN7Nf49ggKNqCtmMp7nCn2TL5NxIMdZApRVO/AmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509187; c=relaxed/simple;
	bh=/XFAEfCczlibUE70QLgqPgMQ8f45nxN8l1BnMdzrpK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV4YJ9JWWIIU7TEHtdM8jAyn1vrXmtuHyZTUu+VCGtrdVaQG+3df/iXVfL96WMbJz0Tc20ADmjED12X5migSi4kKocQfv77Tyf99/ch02k72pmxmY3jtFVlLmTm0ZtSKuiLGmFci4toT3x+aij+F/mjTVzJwuUdwsp1h0THcWlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igiEY8Bb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717509184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0VxfhH1OEgJBZVeakcTEgY15FfwsO+wwN+9uT42qak=;
	b=igiEY8Bb8kRddFmq0fDyPI/AskDDrNVuOfiJtav+tgxSlOmQ5osNJkmQi9lMHLwgaazP7Y
	CQVMD3zIfqTRteOBDhrE72vn1mZ1fYeQJP+aLsmm8RLX4Jf/IUbrvnZ0O1gqMIHCk+DhiK
	7MKAnsLZrcLO3uOc0ef87OI/LijKneg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-GvTqAB9lMauck_M8KHLNIg-1; Tue, 04 Jun 2024 09:53:01 -0400
X-MC-Unique: GvTqAB9lMauck_M8KHLNIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D423B85A5B6;
	Tue,  4 Jun 2024 13:53:00 +0000 (UTC)
Received: from localhost (unknown [10.72.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C0212166B35;
	Tue,  4 Jun 2024 13:52:59 +0000 (UTC)
Date: Tue, 4 Jun 2024 21:52:56 +0800
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
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 4/7] crash_dump: reuse saved dm crypt keys for
 CPU/memory hot-plugging
Message-ID: <Zl8cOOv9gVzdkU0f@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-5-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-5-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 05/23/24 at 01:04pm, Coiby Xu wrote:
> When there is CPU/memory hot-plugging, the kdump kernel image and initrd
> will be reloaded. The user space can write the "reuse" command to
> /sys/kernel/crash_dm_crypt_key so the stored keys can be re-saved again.
> 
> Note currently only x86 (commit ea53ad9cf73b ("x86/crash: add x86 crash
> hotplug support")) and ppc (WIP) supports the new infrastructure
> (commit 247262756121 ("crash: add generic infrastructure for crash
> hotplug support")). If the new infrastructure get extended to all arches,
> this patch can be dropped.

I am confused, what is the new infrastructure? And why this patch can be
dropped if 'the new infrastructure' is extended to all arches.

> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  kernel/crash_dump_dm_crypt.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 89fec768fba8..b4dc881cc867 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -10,12 +10,13 @@
>  // The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
>  #define KEY_DESC_LEN 48
>  
> -static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
> +static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded", "reuse"};
>  static enum STATE_ENUM {
>  	FRESH = 0,
>  	INITIALIZED,
>  	RECORDED,
>  	LOADED,
> +	REUSE,
>  } state;
>  
>  static unsigned int key_count;
> @@ -90,12 +91,31 @@ static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
>  	return 0;
>  }
>  
> +static void get_keys_from_kdump_reserved_memory(void)
> +{
> +	struct keys_header *keys_header_loaded;
> +
> +	arch_kexec_unprotect_crashkres();
> +
> +	keys_header_loaded = kmap_local_page(pfn_to_page(
> +		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
> +
> +	memcpy(keys_header, keys_header_loaded, keys_header_size);
> +	kunmap_local(keys_header_loaded);
> +	state = RECORDED;
> +}
> +
>  static int process_cmd(const char *buf, size_t count)
>  {
>  	if (strncmp(buf, "init ", 5) == 0)
>  		return init(buf);
>  	else if (strncmp(buf, "record ", 7) == 0)
>  		return record_key_desc(buf, &keys_header->keys[key_count]);
> +	else if (!strcmp(buf, "reuse")) {
> +		state = REUSE;
> +		get_keys_from_kdump_reserved_memory();
> +		return 0;
> +	}
>  
>  	return -EINVAL;
>  }
> @@ -175,9 +195,11 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>  	}
>  
>  	image->dm_crypt_keys_addr = 0;
> -	r = build_keys_header();
> -	if (r)
> -		return r;
> +	if (state != REUSE) {
> +		r = build_keys_header();
> +		if (r)
> +			return r;

Is the logic here wrong? Isn't it we return when it's REUSE. If not
REUSE, we need build_keys_header(), then add buffer?

> +	}
>  
>  	kbuf.buffer = keys_header;
>  	kbuf.bufsz = keys_header_size;
> -- 
> 2.45.0
> 


