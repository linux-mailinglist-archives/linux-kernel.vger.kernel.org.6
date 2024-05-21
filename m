Return-Path: <linux-kernel+bounces-184468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181A8CA71E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169091F217DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8611B299;
	Tue, 21 May 2024 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuQoyH+Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19F617758
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716262984; cv=none; b=QgmRPqFlB/pJ24/xUbr8f+aV2wDX0SGMada8x9D35ivXMoLK/ZrmzK+FkroDF3omQ/MW/RoRY7elAd1lmC2/RWtqpXJfKq3BI1IX1IA9+Z3m2PvS6cYgvinK6Q3ry5IT1W4eZHUkrEXXb+U310VihSGsJ6UN3+4ROTREA5PEq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716262984; c=relaxed/simple;
	bh=eqzecykSsbdtgklapdjOdkmHhn7FtSpdZVO4Ckgl5V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/kP05wSeF5Lnf1pPMg1JtDigSi66KW1eweG6arSJfgiYQllWstdvRis9KFwwOtFQ/NBAeKd+1UdOWT4nXy6RQqs8HDt97bKnJFPUR5KaqtGolXCvPEc8AvRLDP9u7zuSIeCJqPLd3c/DJvnMh9ImvUJRFRyGrTmKZBsCtl3j8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuQoyH+Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716262981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+4hb9T144pRnSD0bqliSqOFgjUEo88DEawCLUSReYM=;
	b=PuQoyH+Y80SrOowowMPL9bNTA7s+gZfpLJC1QUZHW2/wlr4lcSQY7OHwApmxpd1OPnjdgJ
	a3fdxV1QDdfyMkToxJVs6QJNPWSrKLxljP7udXWHmdZDEItx7iUXIlbPYelfFL4zR/LC1Z
	vTysoNQAeMo8tqjRycat856KJ6GjBPk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-xECivWtDN1e3wfVpZZ_k8A-1; Mon,
 20 May 2024 23:42:58 -0400
X-MC-Unique: xECivWtDN1e3wfVpZZ_k8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B64B43C000AA;
	Tue, 21 May 2024 03:42:57 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 776D740C6EB7;
	Tue, 21 May 2024 03:42:56 +0000 (UTC)
Date: Tue, 21 May 2024 11:42:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	 Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 3/7] crash_dump: store dm keys in kdump reserved memory
Message-ID: <ZkwYIf2YgDfSZ1y8@MiWiFi-R3L-srv>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-4-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425100434.198925-4-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 04/25/24 at 06:04pm, Coiby Xu wrote:
> When the kdump kernel image and initrd are loaded, the dm crypts keys
> will be read from keyring and then stored in kdump reserved memory.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  include/linux/crash_core.h   |  3 ++
>  include/linux/crash_dump.h   |  2 +
>  include/linux/kexec.h        |  4 ++
>  kernel/crash_dump_dm_crypt.c | 87 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 96 insertions(+)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 98825b7e0ea6..1f3d5a4fa6c1 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -37,6 +37,9 @@ static inline void arch_kexec_unprotect_crashkres(void) { }
>  #ifdef CONFIG_CRASH_DM_CRYPT
>  int crash_sysfs_dm_crypt_keys_read(char *buf);
>  int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
> +int crash_load_dm_crypt_keys(struct kimage *image);
> +#else
> +static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
>  #endif
>  
>  #ifndef arch_crash_handle_hotplug_event
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index acc55626afdc..dfd8e4fe6129 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -15,6 +15,8 @@
>  extern unsigned long long elfcorehdr_addr;
>  extern unsigned long long elfcorehdr_size;
>  
> +extern unsigned long long dm_crypt_keys_addr;
> +
>  #ifdef CONFIG_CRASH_DUMP
>  extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
>  extern void elfcorehdr_free(unsigned long long addr);
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index fc1e20d565d5..b6cedce66828 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -368,6 +368,10 @@ struct kimage {
>  	void *elf_headers;
>  	unsigned long elf_headers_sz;
>  	unsigned long elf_load_addr;
> +
> +	/* dm crypt keys buffer */
> +	unsigned long dm_crypt_keys_addr;
> +	unsigned long dm_crypt_keys_sz;
>  };
>  
>  /* kexec interface functions */
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 847499cdcd42..b9997fb53351 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -1,4 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/key.h>
> +#include <linux/keyctl.h>
>  #include <keys/user-type.h>
>  #include <linux/crash_dump.h>
>  
> @@ -111,3 +113,88 @@ int crash_sysfs_dm_crypt_keys_read(char *buf)
>  	return sprintf(buf, "%s\n", STATE_STR[state]);
>  }
>  EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_read);
> +
> +static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
> +{
> +	const struct user_key_payload *ukp;
> +	struct key *key;
> +
> +	pr_debug("Requesting key %s", dm_key->key_desc);
> +	key = request_key(&key_type_logon, dm_key->key_desc, NULL);
> +
> +	if (IS_ERR(key)) {
> +		pr_warn("No such key %s\n", dm_key->key_desc);
> +		return PTR_ERR(key);
> +	}
> +
> +	ukp = user_key_payload_locked(key);
> +	if (!ukp)
> +		return -EKEYREVOKED;
> +
> +	memcpy(dm_key->data, ukp->data, ukp->datalen);
> +	dm_key->key_size = ukp->datalen;
> +	pr_debug("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
> +		 dm_key->key_desc, dm_key->data);
> +	return 0;
> +}
> +
> +static int build_keys_header(void)
> +{
> +	int i, r;
> +
> +	for (i = 0; i < key_count; i++) {
> +		r = read_key_from_user_keying(&keys_header->keys[i]);
> +		if (r != 0) {
> +			pr_err("Failed to read key %s\n", keys_header->keys[i].key_desc);
> +			return r;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int crash_load_dm_crypt_keys(struct kimage *image)
> +{
> +	struct kexec_buf kbuf = {
> +		.image = image,
> +		.buf_min = 0,
> +		.buf_max = ULONG_MAX,
> +		.top_down = false,
> +		.random = true,
> +	};
> +
> +	int r;
> +
> +	if (state == FRESH)
> +		return 0;
> +
> +	if (key_count != keys_header->key_count) {
> +		pr_err("Only record %u keys (%u in total)\n", key_count,
> +		       keys_header->key_count);
> +		return -EINVAL;
> +	}
> +
> +	image->dm_crypt_keys_addr = 0;
> +	r = build_keys_header();
> +	if (r)
> +		return r;
> +
> +	kbuf.buffer = keys_header;
> +	kbuf.bufsz = keys_header_size;
> +
> +	kbuf.memsz = kbuf.bufsz;
> +	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +	r = kexec_add_buffer(&kbuf);
> +	if (r) {
> +		vfree((void *)kbuf.buffer);
> +		return r;
> +	}
> +	state = LOADED;
> +	image->dm_crypt_keys_addr = kbuf.mem;
> +	image->dm_crypt_keys_sz = kbuf.bufsz;
> +	pr_debug("Loaded dm crypt keys at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +		 image->dm_crypt_keys_addr, kbuf.bufsz, kbuf.bufsz);

Please use kexec_dprintk() instead to print debugging message.

And you don't worry this printing will leak the key position and the
information? 

> +
> +	return r;
> +}
> -- 
> 2.44.0
> 


