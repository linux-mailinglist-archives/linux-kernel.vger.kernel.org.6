Return-Path: <linux-kernel+bounces-188408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90CD8CE1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED3428107D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEACC1292DD;
	Fri, 24 May 2024 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeXJaPjK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A316328DB
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536437; cv=none; b=Psff/KMo4sfqwbHTNXmsxjbi5QjjY7nAmQozpw4Jke/JebSZyJOXo9+1FP/LifTeCfc1z0GX18u/1F2ef2Y9hdJstUIaqm6U2T1j0guTOJQoH9tQf4m4HqW87uYHAp2K1wkfCZ/wZmmWR98AXD7myd/UopNFlkl4mabRN+v/fng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536437; c=relaxed/simple;
	bh=VGZ4F79Z6aBD2yasaUBYYvEj2xZ7NAf2OTG5tZgYV7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Chzz+9lXBa7Kj+J8sQv1TfGZ7f3v6KBqYTLjHNmZkQOl4FhBU5w8WUmwO6NB94cbu1g4kjCjHsTZ6Q46CDbs+DeORh/8LTDXn9gsjMLMaOhvmlTBLUWwyeMbi1hZo2A80OvGNautUPWsj1PTX4ToJi31XFSl42vjhJ3vLMqOiSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aeXJaPjK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716536435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vuXQQ/QoUSZ0kyXep/CDerc5KOfI2DPPitPZJXtY6YU=;
	b=aeXJaPjKJXvFCEH+VY8PfhhZGluB3gEp3qcEBpX/9pmh3j/fWKO7asu5DzdGUGnPldNpg9
	oZa0TZ6U5Gtq07OC13ywMZ5W2gVgXjPoeNMVWO4qNO72Q6iCe2OsBuSrTAValspRDyXIes
	rEWRncPKxy3Xyn4npVJHVb0cLRhFptE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-LILXIoSIMeSbK38DOu3v0A-1; Fri, 24 May 2024 03:40:31 -0400
X-MC-Unique: LILXIoSIMeSbK38DOu3v0A-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-68197de746fso709346a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716536431; x=1717141231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuXQQ/QoUSZ0kyXep/CDerc5KOfI2DPPitPZJXtY6YU=;
        b=XDPEwRGSEqqPDN7nzq76kY21ck2dav2eE4Y3FLskmfQpviXZiw8imf7gGnr+YnIJU8
         YiXB8NB8FKf13Tov54WK8Ienb2In+cZGOUXsqLTJ3HNzwvFtqjdZ/89jHKl1RolU5ddz
         RqAvpp26sEikzQahe4X5wdg24q5HVTjVxDXaK5vVRCXfBvsQZQiiSW/FxE3wlexfLMo4
         qLj+HE2VwR3ILG/4Gz+0xXwQjNfRSZucx2WcrLR9jtmTNA313EqWvIv+5Ys8lvhQQTKe
         +PiH3IKBYrdtTs6jDYo5YTkgomxj2DDNz4TWl406bv0zmUg40MAVa/dMlTfnSLDJqLu+
         jLLw==
X-Forwarded-Encrypted: i=1; AJvYcCXOqdKpY0xuAWqIaOrHZnxa0ay5c1UdUr3Hjqs8CGIZxWcqtEGWM7NMLn9vSGGv3HUxSdtDxy9WzeI8cajUoGAxEKWyIS9lhVgLjKt5
X-Gm-Message-State: AOJu0YxyXJv2zOJMfl6XPUTEcJQge/tefsgzuaZaXdkZJvjs7jzkgb+4
	AXxANaSj3K+6u0m7SXUsSatqKa5UiiSnZs1svsLmdwZCe3CI7rZsn4YWzhG5+P+6GUbHQYCZlRF
	8dgUwShNEBId/FFr6jQzpjbvnKPKVefiyRXzYzg1d4fz6Psu4/FzcwWAchI1ARA==
X-Received: by 2002:a05:6a20:72a8:b0:1b1:c745:5c66 with SMTP id adf61e73a8af0-1b212e64d95mr1966611637.54.1716536430401;
        Fri, 24 May 2024 00:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbzJ7TOEma3egtZUW4/Iyf8YftdGpWRVHtOR5RI9TYfnNeXR2I604J6lA6g/IZDb6x1ehPzQ==
X-Received: by 2002:a05:6a20:72a8:b0:1b1:c745:5c66 with SMTP id adf61e73a8af0-1b212e64d95mr1966565637.54.1716536429531;
        Fri, 24 May 2024 00:40:29 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-68221891986sm613441a12.22.2024.05.24.00.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:40:28 -0700 (PDT)
Date: Fri, 24 May 2024 15:38:18 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	 Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 3/7] crash_dump: store dm keys in kdump reserved memory
Message-ID: <akqkcxxeg35lwxgd2nszgul7zpzkcfjzdx7zw5udsm24vcjbiy@vvtgme6nizjq>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-4-coxu@redhat.com>
 <ZkwYIf2YgDfSZ1y8@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZkwYIf2YgDfSZ1y8@MiWiFi-R3L-srv>

On Tue, May 21, 2024 at 11:42:52AM +0800, Baoquan He wrote:
>On 04/25/24 at 06:04pm, Coiby Xu wrote:
>> When the kdump kernel image and initrd are loaded, the dm crypts keys
>> will be read from keyring and then stored in kdump reserved memory.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  include/linux/crash_core.h   |  3 ++
>>  include/linux/crash_dump.h   |  2 +
>>  include/linux/kexec.h        |  4 ++
>>  kernel/crash_dump_dm_crypt.c | 87 ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 96 insertions(+)
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index 98825b7e0ea6..1f3d5a4fa6c1 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -37,6 +37,9 @@ static inline void arch_kexec_unprotect_crashkres(void) { }
>>  #ifdef CONFIG_CRASH_DM_CRYPT
>>  int crash_sysfs_dm_crypt_keys_read(char *buf);
>>  int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
>> +int crash_load_dm_crypt_keys(struct kimage *image);
>> +#else
>> +static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
>>  #endif
>>
>>  #ifndef arch_crash_handle_hotplug_event
>> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
>> index acc55626afdc..dfd8e4fe6129 100644
>> --- a/include/linux/crash_dump.h
>> +++ b/include/linux/crash_dump.h
>> @@ -15,6 +15,8 @@
>>  extern unsigned long long elfcorehdr_addr;
>>  extern unsigned long long elfcorehdr_size;
>>
>> +extern unsigned long long dm_crypt_keys_addr;
>> +
>>  #ifdef CONFIG_CRASH_DUMP
>>  extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
>>  extern void elfcorehdr_free(unsigned long long addr);
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index fc1e20d565d5..b6cedce66828 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -368,6 +368,10 @@ struct kimage {
>>  	void *elf_headers;
>>  	unsigned long elf_headers_sz;
>>  	unsigned long elf_load_addr;
>> +
>> +	/* dm crypt keys buffer */
>> +	unsigned long dm_crypt_keys_addr;
>> +	unsigned long dm_crypt_keys_sz;
>>  };
>>
>>  /* kexec interface functions */
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> index 847499cdcd42..b9997fb53351 100644
>> --- a/kernel/crash_dump_dm_crypt.c
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -1,4 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>> +#include <linux/key.h>
>> +#include <linux/keyctl.h>
>>  #include <keys/user-type.h>
>>  #include <linux/crash_dump.h>
>>
>> @@ -111,3 +113,88 @@ int crash_sysfs_dm_crypt_keys_read(char *buf)
>>  	return sprintf(buf, "%s\n", STATE_STR[state]);
>>  }
>>  EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_read);
>> +
>> +static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
>> +{
>> +	const struct user_key_payload *ukp;
>> +	struct key *key;
>> +
>> +	pr_debug("Requesting key %s", dm_key->key_desc);
>> +	key = request_key(&key_type_logon, dm_key->key_desc, NULL);
>> +
>> +	if (IS_ERR(key)) {
>> +		pr_warn("No such key %s\n", dm_key->key_desc);
>> +		return PTR_ERR(key);
>> +	}
>> +
>> +	ukp = user_key_payload_locked(key);
>> +	if (!ukp)
>> +		return -EKEYREVOKED;
>> +
>> +	memcpy(dm_key->data, ukp->data, ukp->datalen);
>> +	dm_key->key_size = ukp->datalen;
>> +	pr_debug("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
>> +		 dm_key->key_desc, dm_key->data);
>> +	return 0;
>> +}
>> +
>> +static int build_keys_header(void)
>> +{
>> +	int i, r;
>> +
>> +	for (i = 0; i < key_count; i++) {
>> +		r = read_key_from_user_keying(&keys_header->keys[i]);
>> +		if (r != 0) {
>> +			pr_err("Failed to read key %s\n", keys_header->keys[i].key_desc);
>> +			return r;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int crash_load_dm_crypt_keys(struct kimage *image)
>> +{
>> +	struct kexec_buf kbuf = {
>> +		.image = image,
>> +		.buf_min = 0,
>> +		.buf_max = ULONG_MAX,
>> +		.top_down = false,
>> +		.random = true,
>> +	};
>> +
>> +	int r;
>> +
>> +	if (state == FRESH)
>> +		return 0;
>> +
>> +	if (key_count != keys_header->key_count) {
>> +		pr_err("Only record %u keys (%u in total)\n", key_count,
>> +		       keys_header->key_count);
>> +		return -EINVAL;
>> +	}
>> +
>> +	image->dm_crypt_keys_addr = 0;
>> +	r = build_keys_header();
>> +	if (r)
>> +		return r;
>> +
>> +	kbuf.buffer = keys_header;
>> +	kbuf.bufsz = keys_header_size;
>> +
>> +	kbuf.memsz = kbuf.bufsz;
>> +	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +	r = kexec_add_buffer(&kbuf);
>> +	if (r) {
>> +		vfree((void *)kbuf.buffer);
>> +		return r;
>> +	}
>> +	state = LOADED;
>> +	image->dm_crypt_keys_addr = kbuf.mem;
>> +	image->dm_crypt_keys_sz = kbuf.bufsz;
>> +	pr_debug("Loaded dm crypt keys at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> +		 image->dm_crypt_keys_addr, kbuf.bufsz, kbuf.bufsz);
>
>Please use kexec_dprintk() instead to print debugging message.

Thanks for pointing me to kexec_dprintk! I'll use kexec_dprintk.

>And you don't worry this printing will leak the key position and the
>information?

Thanks for raising this concern! I'll remove the key position info as it
seems kernel dyndbg can be easily enabled.

-- 
Best regards,
Coiby


