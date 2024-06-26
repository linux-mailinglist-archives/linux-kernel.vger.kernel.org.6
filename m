Return-Path: <linux-kernel+bounces-230211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 241BE9179E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDFA1F21280
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B2615D5AB;
	Wed, 26 Jun 2024 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UgbXCGIP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736715B115
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387545; cv=none; b=sg5av84C62YnClFVNsJZN+Yew5UHn4YNB3eDjwbQ0t0MEAkbmgsCroeIfbRMf3oWGCUYc1Sm4pMnyfRbxPwTtzTo6t5O6J0GKNgp8Wnujx5qBCcIZPj1Y5Eqkdnh67DEYqaOVoHNPXom0oWAULX+Xwq9juAxjZ4uEoxLamrWaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387545; c=relaxed/simple;
	bh=obMllH7JVqZ5QKsgwKwdcDXXw5cA9IXGchQ3KcBiTrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6EApO9ypYlkv0lRA0Jjd4qh8uQyKeT6o1hE6gHpcqM5+kZPMvOj2jyWHdU+a6pJDaPOkvVqov+v7AkSnuVWvhI78BkroI62gzkwoIU7TYNAhvJwnuwnVlEDpPWV5BStUZoaQ66PXJnKqZaBfDxjtnrxLRFEkqBmzgrMQ6sTpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UgbXCGIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B218CC4AF07;
	Wed, 26 Jun 2024 07:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719387545;
	bh=obMllH7JVqZ5QKsgwKwdcDXXw5cA9IXGchQ3KcBiTrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgbXCGIP7kq6Rg3W+N4kyshjEVXDwN6ZmG2QUYwryIh+0cJGYQmKw3hXZe5leu9nI
	 mChltdU0PP7YOSEitwBrlsXtygsMIuokFqeiJqtRJKmg9YUHSE5QiSyjOB+Ylt51dV
	 qMMfyCZxqbBkKCSAZe8n0AAmgxIg6Sm1CFH0RLTE=
Date: Wed, 26 Jun 2024 09:39:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] numa: Add simple generic NUMA emulation
Message-ID: <2024062658-unmasked-degree-2f80@gregkh>
References: <20240625125803.38038-1-tursulin@igalia.com>
 <20240625125803.38038-2-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625125803.38038-2-tursulin@igalia.com>

On Tue, Jun 25, 2024 at 01:58:02PM +0100, Tvrtko Ursulin wrote:
> From: Maíra Canal <mcanal@igalia.com>
> 
> Add some common code for splitting the memory into N emulated NUMA memory
> nodes.
> 
> Individual architecture can then enable selecting this option and use the
> existing numa=fake=<N> kernel argument to enable it.
> 
> Memory is always split into equally sized chunks.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Co-developed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: “Rafael J. Wysocki" <rafael@kernel.org>
> ---
>  drivers/base/Kconfig          |  7 ++++
>  drivers/base/Makefile         |  1 +
>  drivers/base/arch_numa.c      |  6 ++++
>  drivers/base/numa_emulation.c | 67 +++++++++++++++++++++++++++++++++++
>  drivers/base/numa_emulation.h | 21 +++++++++++
>  5 files changed, 102 insertions(+)
>  create mode 100644 drivers/base/numa_emulation.c
>  create mode 100644 drivers/base/numa_emulation.h
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 2b8fd6bb7da0..1f60cd4dd057 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -230,6 +230,13 @@ config GENERIC_ARCH_NUMA
>  	  Enable support for generic NUMA implementation. Currently, RISC-V
>  	  and ARM64 use it.
>  
> +config GENERIC_ARCH_NUMA_EMULATION
> +	bool
> +	depends on GENERIC_ARCH_NUMA
> +	help
> +	  Enable NUMA emulation. Note that NUMA emulation will only be used if
> +	  the machine has no NUMA node.
> +
>  config FW_DEVLINK_SYNC_STATE_TIMEOUT
>  	bool "sync_state() behavior defaults to timeout instead of strict"
>  	help
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 3079bfe53d04..34fcf5bd7370 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
>  obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
>  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
>  obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
> +obj-$(CONFIG_GENERIC_ARCH_NUMA_EMULATION) += numa_emulation.o
>  obj-$(CONFIG_ACPI) += physical_location.o
>  
>  obj-y			+= test/
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index 5b59d133b6af..6ad08f681b3c 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -15,6 +15,8 @@
>  
>  #include <asm/sections.h>
>  
> +#include "numa_emulation.h"
> +
>  struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
>  EXPORT_SYMBOL(node_data);
>  nodemask_t numa_nodes_parsed __initdata;
> @@ -30,6 +32,8 @@ static __init int numa_parse_early_param(char *opt)
>  		return -EINVAL;
>  	if (str_has_prefix(opt, "off"))
>  		numa_off = true;
> +	if (str_has_prefix(opt, "fake="))
> +		return numa_emu_cmdline(opt + 5);

You did not document this at all :(

