Return-Path: <linux-kernel+bounces-200278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83548FAE00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D965B1C2132D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31184142E66;
	Tue,  4 Jun 2024 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWNdRJ/0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5281411F9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491083; cv=none; b=OSA84VT9CpJ/7S9GyjWjF6sRI6Qa0Rps3/r27FPumxyS1fFNJpTRodbVLS4y8FcoIdr7FswJ1vz7dJ6JeuEqbcF6nt0pjtMVI620SAc2hPERsfyhxuinoBwPYgCvswYDLkI4pWvjug2yNRpUonpf0ZdzvQc7dpKEQ6WW/Uo//Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491083; c=relaxed/simple;
	bh=ndt/Lo4v6zILLmSOCPQBBlzeEH8xtV1Wk8mzZdUrUB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS2Qc6ghYnnRZmZKajUfUlvbAtLUHjOm390bPdAEuqbKFXfmqg9xWkXRDNph6oc6VfcbtzuF1vYBf6dlpLmlsZ5rfiRFIH/TJ0aQadh9m6aVxLvSxbhnAxIZ9D1ThsRMiZeB8E9V09O4d8B0bYfLyVWq4jaWKP17GE7w9Wyd/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWNdRJ/0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717491079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5z7HNV48kp54OxKkcQvGwgewNYNdSMm8024Uw3SQs94=;
	b=IWNdRJ/08K1mQZRxF3q++oWmweIw8xq9nN0rb1vxWqeeAfUbpBo5WB0/Lnv3LZTpToYgMI
	5MMWPkz3YozsbAa67FgmuGiFSJ3bemVRvW/nbzCoN8mwbvdfs/Gs+1m1t2s+L/58LKb9oq
	klSVUgfw7dtU6PdIy8c5wqSiDkrXdgE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-9jUjf59UNh64OOkq7HiiZg-1; Tue, 04 Jun 2024 04:51:16 -0400
X-MC-Unique: 9jUjf59UNh64OOkq7HiiZg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73FE685A5BC;
	Tue,  4 Jun 2024 08:51:15 +0000 (UTC)
Received: from localhost (unknown [10.72.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 07F76408DA22;
	Tue,  4 Jun 2024 08:51:12 +0000 (UTC)
Date: Tue, 4 Jun 2024 16:51:03 +0800
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
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <Zl7Vd3BqxDXdMHkL@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-3-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hi Coiby,

On 05/23/24 at 01:04pm, Coiby Xu wrote:
> A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
> the dm crypt keys persist for the kdump kernel. User space can send the
> following commands,
> - "init KEY_NUM"
>   Initialize needed structures
> - "record KEY_DESC"
>   Record a key description. The key must be a logon key.
> 
> User space can also read this API to learn about current state.

From the subject, can I think the luks keys will persist forever? or
only for a while? If need and can only keep it for a while, can you
mention it and tell why and how it will be used. Because you add a lot
of codes, but only simply mention the sysfs, that doesn't make sense.

> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  include/linux/crash_core.h   |   5 +-
>  kernel/Kconfig.kexec         |   8 +++
>  kernel/Makefile              |   1 +
>  kernel/crash_dump_dm_crypt.c | 113 +++++++++++++++++++++++++++++++++++
>  kernel/ksysfs.c              |  22 +++++++
>  5 files changed, 148 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/crash_dump_dm_crypt.c
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 44305336314e..6bff1c24efa3 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -34,7 +34,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
>  static inline void arch_kexec_unprotect_crashkres(void) { }
>  #endif
>  
> -
> +#ifdef CONFIG_CRASH_DM_CRYPT
> +int crash_sysfs_dm_crypt_keys_read(char *buf);
> +int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
> +#endif
>  
>  #ifndef arch_crash_handle_hotplug_event
>  static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 6c34e63c88ff..88525ad1c80a 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -116,6 +116,14 @@ config CRASH_DUMP
>  	  For s390, this option also enables zfcpdump.
>  	  See also <file:Documentation/arch/s390/zfcpdump.rst>
>  
> +config CRASH_DM_CRYPT
> +	bool "Support saving crash dump to dm-crypt encrypted volume"
> +	depends on CRASH_DUMP
> +	help
> +	  With this option enabled, user space can intereact with
> +	  /sys/kernel/crash_dm_crypt_keys to make the dm crypt keys
> +	  persistent for the crash dump kernel.
> +
>  config CRASH_HOTPLUG
>  	bool "Update the crash elfcorehdr on system configuration changes"
>  	default y
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 3c13240dfc9f..f2e5b3e86d12 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_VMCORE_INFO) += vmcore_info.o elfcorehdr.o
>  obj-$(CONFIG_CRASH_RESERVE) += crash_reserve.o
>  obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
>  obj-$(CONFIG_CRASH_DUMP) += crash_core.o
> +obj-$(CONFIG_CRASH_DM_CRYPT) += crash_dump_dm_crypt.o
>  obj-$(CONFIG_KEXEC) += kexec.o
>  obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
>  obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> new file mode 100644
> index 000000000000..78809189084a
> --- /dev/null
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <keys/user-type.h>
> +#include <linux/crash_dump.h>
> +
> +#define KEY_NUM_MAX 128
> +#define KEY_SIZE_MAX 256
> +
> +// The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
> +#define KEY_DESC_LEN 48
> +
> +static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
> +static enum STATE_ENUM {
> +	FRESH = 0,
> +	INITIALIZED,
> +	RECORDED,
> +	LOADED,
> +} state;
> +
> +static unsigned int key_count;
> +static size_t keys_header_size;
> +
> +struct dm_crypt_key {
> +	unsigned int key_size;
> +	char key_desc[KEY_DESC_LEN];
> +	u8 data[KEY_SIZE_MAX];
> +};
> +
> +static struct keys_header {
> +	unsigned int key_count;
> +	struct dm_crypt_key keys[] __counted_by(key_count);
> +} *keys_header;
> +
> +static size_t get_keys_header_size(struct keys_header *keys_header,
> +				   size_t key_count)
> +{
> +	return struct_size(keys_header, keys, key_count);
> +}
> +
> +static int init(const char *buf)
              ~~~~ A more interesting name with more description?
> +{
> +	unsigned int total_keys;
> +	char dummy[5];
> +
> +	if (sscanf(buf, "%4s %u", dummy, &total_keys) != 2)
> +		return -EINVAL;
> +
> +	if (key_count > KEY_NUM_MAX) {
> +		pr_err("Exceed the maximum number of keys (KEY_NUM_MAX=%u)\n",
> +		       KEY_NUM_MAX);
> +		return -EINVAL;
> +	}
> +
> +	keys_header_size = get_keys_header_size(keys_header, total_keys);
> +	key_count = 0;
> +
> +	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
> +	if (!keys_header)
> +		return -ENOMEM;
> +
> +	keys_header->key_count = total_keys;
> +	state = INITIALIZED;
> +	return 0;
> +}
> +
> +static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
> +{
> +	char key_desc[KEY_DESC_LEN];
> +	char dummy[7];
> +
> +	if (state != INITIALIZED)
> +		pr_err("Please send the cmd 'init <KEY_NUM>' first\n");
> +
> +	if (sscanf(buf, "%6s %s", dummy, key_desc) != 2)
> +		return -EINVAL;
> +
> +	if (key_count >= keys_header->key_count) {
> +		pr_warn("Already have %u keys", key_count);
> +		return -EINVAL;
> +	}
> +
> +	strscpy(dm_key->key_desc, key_desc, KEY_DESC_LEN);
> +	pr_debug("Key%d (%s) recorded\n", key_count, dm_key->key_desc);
> +	key_count++;
> +
> +	if (key_count == keys_header->key_count)
> +		state = RECORDED;
> +
> +	return 0;
> +}
> +
> +static int process_cmd(const char *buf, size_t count)
                                                  ~~~~
If nobody use the count, why do you add it?
> +{
> +	if (strncmp(buf, "init ", 5) == 0)
> +		return init(buf);
> +	else if (strncmp(buf, "record ", 7) == 0)
> +		return record_key_desc(buf, &keys_header->keys[key_count]);
> +
> +	return -EINVAL;
> +}
> +
> +int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count)
> +{
> +	if (!is_kdump_kernel())
> +		return process_cmd(buf, count);
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_write);
> +
> +int crash_sysfs_dm_crypt_keys_read(char *buf)
> +{
> +	return sprintf(buf, "%s\n", STATE_STR[state]);
> +}
> +EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_read);
> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index 07fb5987b42b..2ba4dcbf5816 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -167,6 +167,25 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
>  }
>  KERNEL_ATTR_RO(vmcoreinfo);
>  
> +#ifdef CONFIG_CRASH_DM_CRYPT
> +static ssize_t crash_dm_crypt_keys_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	return crash_sysfs_dm_crypt_keys_read(buf);
> +}
> +
> +static ssize_t crash_dm_crypt_keys_store(struct kobject *kobj,
> +					 struct kobj_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	int ret;
> +
> +	ret = crash_sysfs_dm_crypt_keys_write(buf, count);
> +	return ret < 0 ? ret : count;
> +}
> +KERNEL_ATTR_RW(crash_dm_crypt_keys);
> +#endif /* CONFIG_CRASH_DM_CRYPT */
> +
>  #ifdef CONFIG_CRASH_HOTPLUG
>  static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
>  			       struct kobj_attribute *attr, char *buf)
> @@ -271,6 +290,9 @@ static struct attribute * kernel_attrs[] = {
>  #endif
>  #ifdef CONFIG_VMCORE_INFO
>  	&vmcoreinfo_attr.attr,
> +#ifdef CONFIG_CRASH_DM_CRYPT
> +	&crash_dm_crypt_keys_attr.attr,
> +#endif
>  #ifdef CONFIG_CRASH_HOTPLUG
>  	&crash_elfcorehdr_size_attr.attr,
>  #endif
> -- 
> 2.45.0
> 


