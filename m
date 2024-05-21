Return-Path: <linux-kernel+bounces-184471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 120EF8CA724
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B1B282371
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B881F959;
	Tue, 21 May 2024 03:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiOsVNjU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E62DDD7
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716263384; cv=none; b=OpvUkIHby271rUXn51ua6CBsJDeaKKbu1Q07uz8211mmCZSwbC6dA4DbIFrl2NRWhP6SdlrF+4uoFZqLEOqhEnTyKkHQs3LF6dN40Rdu06/9LsxIhSaK2uodABrZxWkTdt5QR9u50MqR1/BHRXU+eD/B1BXNhg5MOj7/zHK3/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716263384; c=relaxed/simple;
	bh=buDMIUMP/mQLrTA7c6+3ac8cH8jaRMOdz9QqlsfD4Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffYj5CYkjYPpAu9MULJqYL/QfNVQbjwUXd47UkWU4rlRFuKhAhKgwWlvFxlXzSPItoC8D/mevrXP9XFPQAC4o+hFeqn1nwdLNOcvgjjOLVhSMQYcGBRywy+hHdTxrqSeKNEOlCiwJAfC0KCJI35TGz700ELymedfn2pG8aLcMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BiOsVNjU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716263381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84fW/dirVXf5VBFqyibcvwX/hKqHiB6YLgeewDy6EUw=;
	b=BiOsVNjU0y534mFtW16/6vRDnCpzdFKp7giz/Kf17T3BXaZpo1mZtEZQeEDgEGU04QwASP
	qB6kwb5aQyIH/G2J0qXPDIXOpKUmZqGy9IWmJ3Gm7wI29TQs3VdgXA8ot+KGf7RRHUjYLe
	+qjOueU/D1eO0alaxBl4b6D0FWdFgus=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-hZPXxrt6Ov2PCqM5ZY3_8w-1; Mon,
 20 May 2024 23:48:55 -0400
X-MC-Unique: hZPXxrt6Ov2PCqM5ZY3_8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D43F43C0BE36;
	Tue, 21 May 2024 03:48:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E60157412;
	Tue, 21 May 2024 03:48:53 +0000 (UTC)
Date: Tue, 21 May 2024 11:48:49 +0800
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
Subject: Re: [PATCH v3 4/7] crash_dump: reuse saved dm crypt keys for
 CPU/memory hot-plugging
Message-ID: <ZkwZfcfTOL1UGKJb@MiWiFi-R3L-srv>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-5-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425100434.198925-5-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 04/25/24 at 06:04pm, Coiby Xu wrote:
> When there is CPU/memory hot-plugging, the kdump kernel image and initrd
> will be reloaded. The user space can write the "reuse" command to
> /sys/kernel/crash_dm_crypt_key so the stored keys can be re-saved again.
> 
> Note currently only x86 (commit ea53ad9cf73b ("x86/crash: add x86 crash
> hotplug support")) and ppc (WIP) supports the new infrastructure
> (commit 247262756121 ("crash: add generic infrastructure for crash
> hotplug support")). If the new infrastructure get extended to all arches,
> this patch can be dropped.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  kernel/crash_dump_dm_crypt.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index b9997fb53351..6ac1fabdb6cb 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -10,12 +10,13 @@
>  // The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
>  #define KEY_DESC_LEN 48
>  
> -static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
> +static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded", "reuse"};
>  enum STATE_ENUM {
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

I don't see the corresponging arch_kexec_protect_crashkres() in the
following flow. Aren't they a pair when used?

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
> +	}
>  
>  	kbuf.buffer = keys_header;
>  	kbuf.bufsz = keys_header_size;
> -- 
> 2.44.0
> 


