Return-Path: <linux-kernel+bounces-534577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1524EA468B5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8824D18891CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9488922A80B;
	Wed, 26 Feb 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="U6nW5cz1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852222A7FA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592618; cv=none; b=i+WAFc+ntRK2DpX0l6tP1O60P4og/sB9L2TA/QhLwoeTY0ng9xW7pyo0qyE3pdXHpvn8LHukpnY0l96A0BkwePwl5WmJJfCC7gDWmLEzRbpPgDVH4RzcFdpfCrTMCBze8y7FKwzfp+zeVDtHzQNCO/cqEHjS7O7d/b08tZgrfVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592618; c=relaxed/simple;
	bh=QhD4jDPZc1chgngu+R6RYZfudmSognn5cWoZ1UV82xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMo/OMY8xIUUQ0GIk8Yzz8c+aWaXrrjSoOsqkGHvk6bdI6lP8MpmqRpoUpm3qknF0dyTBLLbPJjq9CmPkau20hBpc5RbPhs2oM3iIEbuEVe7fgvokhkyQ7N0uJcC7c/vso1GtMXlqwlEhUC3zvazHUsVSY6Hm7AxrfmGhqgf3pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=U6nW5cz1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6B03040E0221;
	Wed, 26 Feb 2025 17:56:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HZ6nsa4EsGhx; Wed, 26 Feb 2025 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740592609; bh=pMkRtsHsna1qfm03zkpbLsqqii47KE6ChVcTR01OeHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6nW5cz1sWFXJBjUIg9hcBXngFxHbbNZG1HZppjgjzhrHvpOxoUYB7VGG+6O8xjzA
	 kWBo0/E43h0g/lgPHwTNCFncI5SUH+VybOvN8ufFnZ3s1u+QSz2wSi0VqV2gnFqB+a
	 vhemqNSdwOiUMyUHxeVP7F380LhR+oWp/ynkmeHg/zuxfWUkHrG+oxnpuvinTY1k+h
	 5KJqudz3YoqJuSghvPhJH2NWbc39PQl6VwdS5XhQVxR3DR9dsnERG3eZk7KmazcNzr
	 vraatYfpH8OgkgWGQwpmfzHFUYy/ys+5Z8s2GjrfRmciF/gL4XtQbbS7K4yuPDupYv
	 hKwED5egC2ruGq+32LlIt4bQLOiADfIYtyYlyVn0NJisST8Ln0v4CbZC+UTq2dcz8H
	 j5UITSWHHUEW6AP5X7is6KRynMj86BDRkvOZ0Zk6iAjMGpRT8kKYA7uBD7skBKr1PE
	 6ZUUmoT+WXcn68AYx49y+LP/nfXx3vb46ZxpliDt2Ui7bQEs8lf3IkmLyd79XQTW/M
	 /CVemy2CyCbIhN2cRoGHvjiTnHowGrDTgz6aMpO08nqOFs4AWQ4UzSQUARmdaCicn+
	 rCho56GoJbskDfj1Hhy4lnC5afR6SFIrYMqBCTfdLDXcYuockGfgCfzapfiKaUGtDM
	 F3xFkHhCkEvKVUryl/6P+r6w=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0F4240E0202;
	Wed, 26 Feb 2025 17:56:43 +0000 (UTC)
Date: Wed, 26 Feb 2025 18:56:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 4/6] x86/microcode/intel_staging: Implement staging logic
Message-ID: <20250226175642.GOZ79V2jWQTH5rbuXo@fat_crate.local>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241211014213.3671-1-chang.seok.bae@intel.com>
 <20241211014213.3671-5-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211014213.3671-5-chang.seok.bae@intel.com>

On Tue, Dec 10, 2024 at 05:42:10PM -0800, Chang S. Bae wrote:
> diff --git a/arch/x86/kernel/cpu/microcode/Makefile b/arch/x86/kernel/cpu/microcode/Makefile
> index 193d98b33a0a..a9f79aaffcb0 100644
> --- a/arch/x86/kernel/cpu/microcode/Makefile
> +++ b/arch/x86/kernel/cpu/microcode/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  microcode-y				:= core.o
>  obj-$(CONFIG_MICROCODE)			+= microcode.o
> -microcode-$(CONFIG_CPU_SUP_INTEL)	+= intel.o
> +microcode-$(CONFIG_CPU_SUP_INTEL)	+= intel.o intel_staging.o
						   ^^^^^^^^^^^^^^^

No need for that guy - just stick everything in intel.c

> +enum ucode_state do_stage(u64 pa, void *ucode_ptr, unsigned int totalsize)

static

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

