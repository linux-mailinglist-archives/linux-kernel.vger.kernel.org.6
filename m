Return-Path: <linux-kernel+bounces-511100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1D4A325DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9326A3A7133
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC00D20B803;
	Wed, 12 Feb 2025 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RPqGCMmK"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE71271829;
	Wed, 12 Feb 2025 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363355; cv=none; b=ZQaPEblryaVYYUWYf9zfo8x5RT9A6WgnkQcBeMpPDxQ8PuglN5brH/xENX19ess8OjB+kTQN0WM/oAyBF7LX3Wwves97/RHeUFYlj9AleekYV+Z9ERuVo92XdVoyqzFhd/PrBGxjNoG7/XPL/dlzHPiLYM/qcwjQna7nt0hVjWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363355; c=relaxed/simple;
	bh=CQ3SUXjx0/f8m1n41c4a7SuLTF0PmDTDTSkoGsVR/Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDlhU8aPefd/R4BxP6lPHKhc/Fi86Nz8WVgu7bDcCPM2sxrm/3K6Oqc4e2NjwAt/IQCHD9dtZHfh4KTvNuct4ViOoNYO3l27vkM2HIXsaAc8b6GH3jRYBSeIuJOVFd5aOtnR8d+rF809eQL7HX5JIoW5+GyLgA2BUv5QEB78aFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RPqGCMmK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739363341;
	bh=CQ3SUXjx0/f8m1n41c4a7SuLTF0PmDTDTSkoGsVR/Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPqGCMmKw9maDfoACsq5XCW1kNFM6USyJeTgaD0ZKnBDjJTzkCAXYBi0J0p/zs+gW
	 CqjmKFSFDdJ1G1DqeLIdoAIUzFk59nzTIK1L5fU/sV+967mEPcUqwhoHA45Q4Y6o++
	 DEc57IMn3o42I47CfAucVGa1HdoUC+cRjFDTaZ2E=
Date: Wed, 12 Feb 2025 13:29:00 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ashish Kalra <ashish.kalra@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@redhat.com>, 
	James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Pratyush Yadav <ptyadav@amazon.de>, Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Usama Arif <usama.arif@bytedance.com>, 
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 05/14] kexec: Add Kexec HandOver (KHO) generation
 helpers
Message-ID: <ae80c1b9-bafb-401c-9789-37a774c702c0@t-8ch.de>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-6-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-6-rppt@kernel.org>

On 2025-02-06 15:27:45+0200, Mike Rapoport wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> This patch adds the core infrastructure to generate Kexec HandOver
> metadata. Kexec HandOver is a mechanism that allows Linux to preserve
> state - arbitrary properties as well as memory locations - across kexec.
> 
> It does so using 2 concepts:
> 
>   1) Device Tree - Every KHO kexec carries a KHO specific flattened
>      device tree blob that describes the state of the system. Device
>      drivers can register to KHO to serialize their state before kexec.
> 
>   2) Scratch Regions - CMA regions that we allocate in the first kernel.
>      CMA gives us the guarantee that no handover pages land in those
>      regions, because handover pages must be at a static physical memory
>      location. We use these regions as the place to load future kexec
>      images so that they won't collide with any handover data.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-kernel-kho    |  53 +++
>  .../admin-guide/kernel-parameters.txt         |  24 +
>  MAINTAINERS                                   |   1 +
>  include/linux/cma.h                           |   2 +
>  include/linux/kexec.h                         |  18 +
>  include/linux/kexec_handover.h                |  10 +
>  kernel/Makefile                               |   1 +
>  kernel/kexec_handover.c                       | 450 ++++++++++++++++++
>  mm/internal.h                                 |   3 -
>  mm/mm_init.c                                  |   8 +
>  10 files changed, 567 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-kho
>  create mode 100644 include/linux/kexec_handover.h
>  create mode 100644 kernel/kexec_handover.c

<snip>

> --- /dev/null
> +++ b/include/linux/kexec_handover.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef LINUX_KEXEC_HANDOVER_H
> +#define LINUX_KEXEC_HANDOVER_H

#include <linux/types.h>

> +
> +struct kho_mem {
> +	phys_addr_t addr;
> +	phys_addr_t size;
> +};
> +
> +#endif /* LINUX_KEXEC_HANDOVER_H */

<snip>

> +static ssize_t dt_read(struct file *file, struct kobject *kobj,
> +		       struct bin_attribute *attr, char *buf,

Please make the bin_attribute argument const. Currently both work, but
the non-const variant will go away.
This way I can test my stuff on linux-next.

> +		       loff_t pos, size_t count)
> +{
> +	mutex_lock(&kho_out.lock);
> +	memcpy(buf, attr->private + pos, count);
> +	mutex_unlock(&kho_out.lock);
> +
> +	return count;
> +}
> +
> +struct bin_attribute bin_attr_dt_kern = __BIN_ATTR(dt, 0400, dt_read, NULL, 0);

The new __BIN_ATTR_ADMIN_RO() could make this slightly shorter.

<snip>

