Return-Path: <linux-kernel+bounces-434341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D42C99E6539
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC78188555E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13554192D9C;
	Fri,  6 Dec 2024 03:56:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B866FBF;
	Fri,  6 Dec 2024 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733457403; cv=none; b=I2bfYO/GQNP8dO8XkyZSMUi22ijEslNxrj8VTMl7o92HFK+ETRE3MdED9+HC/lpTJY9qwhQYGysxT97P3eGe6SY0jArpuDZ6CTonwjlNVDgoQxmyAJuLSMwBxVcZrazRdUZ9i+yOxe7xkz/BKHbU8u5Pcq/DLX15DCF/L5CgmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733457403; c=relaxed/simple;
	bh=2OrVg2wTjxGzF3gX1FKhWEV4gZ2+cqniMAPHcV+eQlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ME7htC8kwi4SIfV0zSeUP7mrU32LyuTDxbtOKeMm+ZKlqT3HdsiLt167Hwbl1Vrm9TYWpHSid6b1fLa2Bghsoor02SvhGOOx79iM2Z3lSjGCh4KQTqglSbdT7bZqwXR6+irWBDvvP6bBEUZCYuHL/25415tRLyBKjewLdREtjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DF41169E;
	Thu,  5 Dec 2024 19:57:08 -0800 (PST)
Received: from [10.163.50.12] (unknown [10.163.50.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 201353F58B;
	Thu,  5 Dec 2024 19:56:34 -0800 (PST)
Message-ID: <e48df345-0946-4b34-a463-e89aa89680f9@arm.com>
Date: Fri, 6 Dec 2024 09:26:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: add a new document for the fine-tuning tips
To: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: patches@amperecomputing.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, ardb@kernel.org, steven.price@arm.com,
 suzuki.poulose@arm.com, mark.rutland@arm.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 cl@os.amperecomputing.com
References: <20241126085647.4993-1-shijie@os.amperecomputing.com>
 <20241126085647.4993-5-shijie@os.amperecomputing.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241126085647.4993-5-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/24 14:26, Huang Shijie wrote:
> Put some fine-tuning tips in this file:
> 	1.) rodata=noalias
> 	2.) slab_strict_numa
> 	3.) CONFIG_SCHED_CLUSTER
> 
> We can add more tips in future.
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  Documentation/arch/arm64/fine-tuning-tips.rst | 23 +++++++++++++++++++
>  Documentation/arch/arm64/index.rst            |  1 +
>  2 files changed, 24 insertions(+)
>  create mode 100644 Documentation/arch/arm64/fine-tuning-tips.rst
> 
> diff --git a/Documentation/arch/arm64/fine-tuning-tips.rst b/Documentation/arch/arm64/fine-tuning-tips.rst
> new file mode 100644
> index 000000000000..70ef1cef92fb
> --- /dev/null
> +++ b/Documentation/arch/arm64/fine-tuning-tips.rst
> @@ -0,0 +1,23 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +fine-tuning tips
> +================
> +
> +This file contains some fine-tuning tips for arm64 machines.
> +These tips do not gurantee that you can get better performance,
> +but you can try them with your workload.
> +
> +rodata=noalias
> +----------------
> +It can provide us more block mappings and contiguous hits
> +to map the linear region which minimizes the TLB footprint.
> +
> +slab_strict_numa
> +----------------
> +In NUMA, it will provide the local memory allocation by SLUB.
> +
> +CONFIG_SCHED_CLUSTER
> +----------------
> +Some arm64 machines have cpu core cluster, enable it may
> +helps you get better performance.
> diff --git a/Documentation/arch/arm64/index.rst b/Documentation/arch/arm64/index.rst
> index 6a012c98bdcd..36d1ef09bd71 100644
> --- a/Documentation/arch/arm64/index.rst
> +++ b/Documentation/arch/arm64/index.rst
> @@ -16,6 +16,7 @@ ARM64 Architecture
>      cpu-feature-registers
>      cpu-hotplug
>      elf_hwcaps
> +    fine-tuning-tips
>      gcs
>      hugetlbpage
>      kdump
Although the idea for such a file makes sense, to help system admins
tune the kernel command line for required behaviour, I am concerned
about the overall structure and scope for such a document. Should it
contain tips regarding all the subsystems on the platform, till what
extent these details should be described in there and then there are
so many aspects for a required behaviour etc ?

Besides maintaining such a document might also be very difficult as
well given how implementations will change over time thus requiring
different tuning etc. Hence kernel source might not be a place for
such a document.

