Return-Path: <linux-kernel+bounces-368240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFAF9A0D22
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BB11F26BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9444420C032;
	Wed, 16 Oct 2024 14:45:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD7A208963
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089955; cv=none; b=p88VieCEr3xA74PJDt6Ge00deVGRJQaI6uZ3jZuEN4hIoncbNQrA9JZD641TppLTySeMXPlpydjN5l1RcJV4+W+8bfrNuw/sRP9o+ziEUoQlQk5xTdL1eEDQsXvgFAlF7LyMota369cQ3h9qqF3MSG7TBKhVoPDe1VrTBJb4EI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089955; c=relaxed/simple;
	bh=z63EP6ebv3ZzdpViV88CWB9S+8P3204/9ZPhTeFr8SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkhqiPcK9ppESFkcRF+SBH3j+/LW1/+OdNij6EfO3SGEL/zKOkgAZxTXGk5ooQIFQMjZ873mTBRUrQmu/4z6YluxXRuuAdnuUzSENfwTN+n+y12ope7A0PvXP+NwFJrzBkdxQgiueFzIJlW4FcmZC5lFw7MdUmIQ9UYRiTD0luY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA8C21007;
	Wed, 16 Oct 2024 07:46:22 -0700 (PDT)
Received: from [10.1.28.177] (XHFQ2J9959.cambridge.arm.com [10.1.28.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 464683F71E;
	Wed, 16 Oct 2024 07:45:50 -0700 (PDT)
Message-ID: <43395dc5-51e1-417b-8a0a-7b8482a24411@arm.com>
Date: Wed, 16 Oct 2024 15:45:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 30/57] drivers/base: Remove PAGE_SIZE compile-time
 constant assumption
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-30-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241014105912.3207374-30-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Greg Kroah-Hartman

This was a rather tricky series to get the recipients correct for and my script
did not realize that "supporter" was a pseudonym for "maintainer" so you were
missed off the original post. Appologies!

More context in cover letter:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/


On 14/10/2024 11:58, Ryan Roberts wrote:
> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.
> 
> Update BUILD_BUG_ON() to test against page size limits.
> 
> CPUMAP_FILE_MAX_BYTES and CPULIST_FILE_MAX_BYTES are both defined
> relative to PAGE_SIZE, so when these values are assigned to global
> variables via BIN_ATTR_RO(), let's wrap them with
> DEFINE_GLOBAL_PAGE_SIZE_VAR() so that their assignment can be deferred
> until boot-time.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  drivers/base/node.c     |  6 +++---
>  drivers/base/topology.c | 32 ++++++++++++++++----------------
>  include/linux/cpumask.h |  5 +++++
>  3 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index eb72580288e62..30e6549e4c438 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -45,7 +45,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
>  	return n;
>  }
>  
> -static BIN_ATTR_RO(cpumap, CPUMAP_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(cpumap, CPUMAP_FILE_MAX_BYTES);
>  
>  static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
>  				   struct bin_attribute *attr, char *buf,
> @@ -66,7 +66,7 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
>  	return n;
>  }
>  
> -static BIN_ATTR_RO(cpulist, CPULIST_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(cpulist, CPULIST_FILE_MAX_BYTES);
>  
>  /**
>   * struct node_access_nodes - Access class device to hold user visible
> @@ -558,7 +558,7 @@ static ssize_t node_read_distance(struct device *dev,
>  	 * buf is currently PAGE_SIZE in length and each node needs 4 chars
>  	 * at the most (distance + space or newline).
>  	 */
> -	BUILD_BUG_ON(MAX_NUMNODES * 4 > PAGE_SIZE);
> +	BUILD_BUG_ON(MAX_NUMNODES * 4 > PAGE_SIZE_MIN);
>  
>  	for_each_online_node(i) {
>  		len += sysfs_emit_at(buf, len, "%s%d",
> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> index 89f98be5c5b99..bdbdbefd95b15 100644
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -62,47 +62,47 @@ define_id_show_func(ppin, "0x%llx");
>  static DEVICE_ATTR_ADMIN_RO(ppin);
>  
>  define_siblings_read_func(thread_siblings, sibling_cpumask);
> -static BIN_ATTR_RO(thread_siblings, CPUMAP_FILE_MAX_BYTES);
> -static BIN_ATTR_RO(thread_siblings_list, CPULIST_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(thread_siblings, CPUMAP_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(thread_siblings_list, CPULIST_FILE_MAX_BYTES);
>  
>  define_siblings_read_func(core_cpus, sibling_cpumask);
> -static BIN_ATTR_RO(core_cpus, CPUMAP_FILE_MAX_BYTES);
> -static BIN_ATTR_RO(core_cpus_list, CPULIST_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(core_cpus, CPUMAP_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(core_cpus_list, CPULIST_FILE_MAX_BYTES);
>  
>  define_siblings_read_func(core_siblings, core_cpumask);
> -static BIN_ATTR_RO(core_siblings, CPUMAP_FILE_MAX_BYTES);
> -static BIN_ATTR_RO(core_siblings_list, CPULIST_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(core_siblings, CPUMAP_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(core_siblings_list, CPULIST_FILE_MAX_BYTES);
>  
>  #ifdef TOPOLOGY_CLUSTER_SYSFS
>  define_siblings_read_func(cluster_cpus, cluster_cpumask);
> -static BIN_ATTR_RO(cluster_cpus, CPUMAP_FILE_MAX_BYTES);
> -static BIN_ATTR_RO(cluster_cpus_list, CPULIST_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(cluster_cpus, CPUMAP_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(cluster_cpus_list, CPULIST_FILE_MAX_BYTES);
>  #endif
>  
>  #ifdef TOPOLOGY_DIE_SYSFS
>  define_siblings_read_func(die_cpus, die_cpumask);
> -static BIN_ATTR_RO(die_cpus, CPUMAP_FILE_MAX_BYTES);
> -static BIN_ATTR_RO(die_cpus_list, CPULIST_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(die_cpus, CPUMAP_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(die_cpus_list, CPULIST_FILE_MAX_BYTES);
>  #endif
>  
>  define_siblings_read_func(package_cpus, core_cpumask);
> -static BIN_ATTR_RO(package_cpus, CPUMAP_FILE_MAX_BYTES);
> -static BIN_ATTR_RO(package_cpus_list, CPULIST_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(package_cpus, CPUMAP_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(package_cpus_list, CPULIST_FILE_MAX_BYTES);
>  
>  #ifdef TOPOLOGY_BOOK_SYSFS
>  define_id_show_func(book_id, "%d");
>  static DEVICE_ATTR_RO(book_id);
>  define_siblings_read_func(book_siblings, book_cpumask);
> -static BIN_ATTR_RO(book_siblings, CPUMAP_FILE_MAX_BYTES);
> -static BIN_ATTR_RO(book_siblings_list, CPULIST_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(book_siblings, CPUMAP_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(book_siblings_list, CPULIST_FILE_MAX_BYTES);
>  #endif
>  
>  #ifdef TOPOLOGY_DRAWER_SYSFS
>  define_id_show_func(drawer_id, "%d");
>  static DEVICE_ATTR_RO(drawer_id);
>  define_siblings_read_func(drawer_siblings, drawer_cpumask);
> -static BIN_ATTR_RO(drawer_siblings, CPUMAP_FILE_MAX_BYTES);
> -static BIN_ATTR_RO(drawer_siblings_list, CPULIST_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(drawer_siblings, CPUMAP_FILE_MAX_BYTES);
> +static CPU_FILE_BIN_ATTR_RO(drawer_siblings_list, CPULIST_FILE_MAX_BYTES);
>  #endif
>  
>  static struct bin_attribute *bin_attrs[] = {
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 53158de44b837..f654b4198abc2 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -1292,4 +1292,9 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
>  					? (NR_CPUS * 9)/32 - 1 : PAGE_SIZE)
>  #define CPULIST_FILE_MAX_BYTES  (((NR_CPUS * 7)/2 > PAGE_SIZE) ? (NR_CPUS * 7)/2 : PAGE_SIZE)
>  
> +#define CPU_FILE_BIN_ATTR_RO(_name, _size)				\
> +	DEFINE_GLOBAL_PAGE_SIZE_VAR(struct bin_attribute,		\
> +				    bin_attr_##_name,			\
> +				    __BIN_ATTR_RO(_name, _size))
> +
>  #endif /* __LINUX_CPUMASK_H */


