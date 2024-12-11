Return-Path: <linux-kernel+bounces-441325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0241C9ECCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBED167D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE45225A54;
	Wed, 11 Dec 2024 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2EynhJT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853A423FD14
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922538; cv=none; b=PuFL+r/Z/6Johd+AuU6pTIuyQs7w8MwPF1ylLIQtTN5FExRKfZEHIyK6vNVlYQ5mOWlxwjFjBe2OS6AxGOjmjs9dI6+6QTewWtxmxtgI12cKH3Iv3kin9gawnPCcCaZ+oGHS2xuOjz4vpsM/a3SAP6NhHstUgGpWMYbC4gTrdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922538; c=relaxed/simple;
	bh=Ebz3euWpnZ0Kqf348nGW60YTIYxuZehseC+Dz0+3ze4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghag51cge1QWzXzAKuNvtAarz21txWTBFdxOiWvQg7WuzPSAKDRCU5m/6z+2j5QHw1BCXzDLRWqRIaR7GbSt5G76CQZ4EBh0Jb1ysjs6O5686Vq++rgW28Niv/3Pq7mnia+J2tvhJj/zyOD04KbEAC1xWcBja0Cf4AQ48IySzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2EynhJT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733922535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FbeRezV5hm2/6lW9aLR5qCafBn2p4lCy6fln0nBStoM=;
	b=Y2EynhJT7Y6lgfQcNoW/6jgTyzYD0U4EaQA7gP3xsrELgk80jzAf2SepW8HOeseNqCHknG
	0JNYGtRIBNEv7GFrjLH48xL+nxlKTsbIMc47zLxv2skFp8uYUD0Y0UBSElftwFSWNueL1U
	lq99N83mB27fzT8881kCjXf/7cAjSbY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-UOhrJCgMNMWUresYsBYRLg-1; Wed,
 11 Dec 2024 08:08:52 -0500
X-MC-Unique: UOhrJCgMNMWUresYsBYRLg-1
X-Mimecast-MFC-AGG-ID: UOhrJCgMNMWUresYsBYRLg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56938195609D;
	Wed, 11 Dec 2024 13:08:49 +0000 (UTC)
Received: from localhost (unknown [10.72.112.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 078A819560AA;
	Wed, 11 Dec 2024 13:08:47 +0000 (UTC)
Date: Wed, 11 Dec 2024 21:08:43 +0800
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
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 4/7] crash_dump: reuse saved dm crypt keys for
 CPU/memory hot-plugging
Message-ID: <Z1mO2wp6zlPCV6JJ@MiWiFi-R3L-srv>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-5-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029055223.210039-5-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/29/24 at 01:52pm, Coiby Xu wrote:
> When there are CPU and memory hot un/plugs, the dm crypt keys may need
> to be reloaded again depending on the solution for crash hotplug
> support. Currently, there are two solutions. One is to utilizes udev to
> instruct user space to reload the kdump kernel image and initrd,
> elfcorehdr and etc again. The other is to only update the elfcorehdr
> segment introduced in commit 247262756121 ("crash:
> add generic infrastructure for crash hotplug support").
> 
> For the 1st solution, the dm crypt keys need to be reloaded again. The
> user space can write true to
> /sys/kernel/config/crash_dm_crypt_key/reuse so the stored keys can be
> re-used.
> 
> For the 2nd solution, the dm crypt keys don't need to be reloaded.
> Currently, only x86 supports the 2nd solution. If the 2nd solution
> gets extended to all arches, this patch can be dropped.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  kernel/crash_dump_dm_crypt.c | 52 +++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index ec2ec2967242..51431f93fc1e 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -28,6 +28,20 @@ static size_t get_keys_header_size(size_t total_keys)
>  	return struct_size(keys_header, keys, total_keys);
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
> +	memcpy(keys_header, keys_header_loaded, get_keys_header_size(key_count));
> +	kunmap_local(keys_header_loaded);
> +	arch_kexec_protect_crashkres();
> +}
> +
>  static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
>  {
>  	const struct user_key_payload *ukp;
> @@ -150,8 +164,36 @@ static ssize_t config_keys_count_show(struct config_item *item, char *page)
>  
>  CONFIGFS_ATTR_RO(config_keys_, count);
>  
> +static bool reuse;

Give it a meaningful name since it's a global variable, e.g
is_dm_key_reused?

> +
> +static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
> +{
> +	return sprintf(page, "%d\n", reuse);
> +}
> +
> +static ssize_t config_keys_reuse_store(struct config_item *item,
> +					   const char *page, size_t count)
> +{
> +	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
> +		kexec_dprintk(
> +			"dm-crypt keys haven't be saved to crash-reserved memory\n");
> +		return -EINVAL;
> +	}
> +
> +	if (kstrtobool(page, &reuse))
> +		return -EINVAL;
> +
> +	if (reuse)
> +		get_keys_from_kdump_reserved_memory();
> +
> +	return count;
> +}
> +
> +CONFIGFS_ATTR(config_keys_, reuse);
> +
>  static struct configfs_attribute *config_keys_attrs[] = {
>  	&config_keys_attr_count,
> +	&config_keys_attr_reuse,
>  	NULL,
>  };
>  


