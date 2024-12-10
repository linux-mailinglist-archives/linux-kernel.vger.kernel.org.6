Return-Path: <linux-kernel+bounces-439470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB149EAFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CAD290D55
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E3923DEB3;
	Tue, 10 Dec 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QE6YN6gM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A6423DE9C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829620; cv=none; b=GHJs7P8lKh8n8Qts0ccQkNMixIRlMwukfSGAovrwPHf1xMxxyyyY57iGL+bj/2nFgzg5c7NPL1iC8T3luCC58tJ+40u8jvGNmJx8NcWa8L/vHKQhdiYsi8cPQJ+xSw4e47rOOE2+HznUf2XZ8eZZaUjJipFUt+yteodIENRx+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829620; c=relaxed/simple;
	bh=W0wqDE1eNTDceSkvX3MAWUoINe+RPPUvgtKfG1Ov17o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uh9ZZVbw/dH2brbfiD0vZHBCf8NZByNguaYWZ6+iB2ZERqcyWwt9HaqgmxsMzAPZYMbn6LxtNUX0uTtdyayJnk8Hs2DD3pvvF1q0ERtQhmnARy0PrgCRUqFyeE/aTPN3i89n8CWDQZ2UtMnnOV4Uve1DXtzMYkooWiKhnWXhqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QE6YN6gM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5C31E40E0289;
	Tue, 10 Dec 2024 11:20:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PaYuvzlpCGQ8; Tue, 10 Dec 2024 11:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733829612; bh=1PYU4dHxQUS70TXWteMY1f9WtRJra5O+J7ofe+daY84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QE6YN6gMdJOUAIN30bm7JrZCfXTYKl+orIqUw/76aae9mkr3DcXySx5iazcCk4kgp
	 DBtOPCtztqvqWxW8HJyrOdGnHDSPX218R23093itbFDRzA10chXIOLJtqN+IXvNoPY
	 ACOY/CQt+w0sFcEf3d41T2DtYKrG4Wpnf3ADXb5IH5FXTtYJ+zen4ey5TuU59dALRC
	 WFt/SaL40fpJldFQl3zeg9XIrKcnICWJS2rBWU0yytFLVg6bT7KGJb3Ms3BlptKJFU
	 RW1F77YorZozQTnwmAIb16olM5/fQbdE2frxWlarHlceMrGzhFBcrN1HjPf8c3GAoo
	 mE9SpIY0W/IjPEfuV2M6o3tJNkBXgi4klaQoQzI9SZb4oZSDngBLM2fJYhjR1LKaiE
	 5TWuPyAIRPS5ByrHoMbExUS5nEHQo0XTKqDbLDsgSY3gGRaKPwOuKBkXPFeoacdlPL
	 TSAHZODbE9/KXJkTJl/2w2pVqOG76vcesFtJB+B/+ySvnfnL7P7i2O9wvcD0cqI12q
	 osT81g0QXwugRgzvd9k4GMfa2g3RH9lsaQ8gUAbGuMpE24PGsKXPwiCS4RxgjXu4sd
	 Sf8Vf/DxhMbqsW5d08EQO24KvLNPNm7LIRIwP4Md9hIBxQ/WKOdWEy17Upg8cKX5t+
	 eu/5fmmYY5gPNHihtbR/X/4A=
Received: from zn.tnic (p200300eA971F9307329c23FFfEA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9307:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2DB440E0286;
	Tue, 10 Dec 2024 11:20:05 +0000 (UTC)
Date: Tue, 10 Dec 2024 12:19:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, rafael@kernel.org,
	lenb@kernel.org
Subject: Re: [PATCH 11/11] x86/cpu: Make all all CPUID leaf names consistent
Message-ID: <20241210111959.GEZ1gj36ksqWNoBO0b@fat_crate.local>
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
 <20241030213329.3253F5F3@davehans-spike.ostc.intel.com>
 <20241031101834.GGZyNZejzr5A9bNL8J@fat_crate.local>
 <4d606240-a8c8-40e5-80da-57c9b4d48179@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d606240-a8c8-40e5-80da-57c9b4d48179@intel.com>

On Thu, Oct 31, 2024 at 10:19:37AM -0700, Dave Hansen wrote:
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index a5f221ea5688..b44dbb952d8c 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1001,8 +1001,8 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
>  	}
>  
>  	/* Extended state features: level 0x0000000d */
> -	if (c->cpuid_level >= 0x0000000d) {
> -		cpuid_count(0x0000000d, 1, &eax, &ebx, &ecx, &edx);
> +	if (c->cpuid_level >= CPUID_LEAF_XSTATE) {
> +		cpuid_count(CPUID_LEAF_XSTATE, 1, &eax, &ebx, &ecx, &edx);
>  
>  		c->x86_capability[CPUID_D_1_EAX] = eax;

Yah, I'll take whatever I can get. You should add this hunk to your set.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

