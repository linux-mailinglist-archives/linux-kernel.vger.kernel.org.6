Return-Path: <linux-kernel+bounces-182429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FB88C8B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BB4282B91
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D113DDCD;
	Fri, 17 May 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eazJ6Gy3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A40E13DDAE
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967522; cv=none; b=sTysry7YxO4h7qhNi5bBboQNBIOPZ8SvdfyOoZ1uWoTNCtn6iXROFOfXSWigo3hFNuo8RZmVK5QMJJDDXQ2doQbp+9vk5sbrTJOt2zWyIYclgpZ3rWOMUKoDb4V7LlRQdRV35EsLp6J8Pf1YWNcDe+TMCoXBxjtM60MSoL+RHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967522; c=relaxed/simple;
	bh=qO3zR2IR67bI/VE8hUvr6IQZ61FxjTclK/0mMM+9S6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qf3KRS9mTzAsW4Tm4+QQEivIIN2dzv3C2yeJpBasww+20wh9WO58/AYSXLRZb4dV+1CkwV68940RAfcFwg3jmHH69uYRYSRaeu27XlGn+qT6kmhluk3Mg7oI6Vh7oCOuomuLu33WPfcLtuazCYbgKcj0KyjhaXmsZhdww9JyZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eazJ6Gy3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BB76340E016A;
	Fri, 17 May 2024 17:38:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NiA1uMvF-qli; Fri, 17 May 2024 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715967512; bh=Fm4MJHu+W1aDSCsQMe46M71qET3de9is9QO4v/d39ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eazJ6Gy3gNhDigdpBddnxY1jNRqswEZWDGQLwNsOLGHG3ifPikTxfdTpFUlHBtAuy
	 LQi6zYj9VHFbPYAIfScY5Mzx/5QipVYOsxCYeSv9IwQgcQk5ns8gSqNN/t7NZWc1W6
	 lnOyg/mMY46RbR0lB1LQbEXl0Uon83PlQFPEorSbmyPwRsrcDEhlicIQWqk5/bPd/9
	 fwwdqepmGJG1btTi1yil4vRLmg+uendcLolyU4Tp5IrrnpCYSwc5RcNJ2Dl26783Gi
	 0iFXku1nstlOuMFNrSK2iih7iZT8kZgfmHBGy4qgEDfHRdCHce+yzQ/3Hu7rWTgF2F
	 rRiZXWT6pYl5P5LEpud0ecix+HI/soCEjO448kOHLlL8dBN0Iu6E8zznp9qkiMtt5I
	 enZHvM8d2oIgddr3my8Vy6RqT3p03KLJsSGeYoCb+J4MRVHgRCWVE5mOYlZAS5A8kl
	 M4s/1ILg+VI7b0ZIMqAIUfJ57542tzyfsVDbQQM1ztrhVOVMgI0/HdrNQIjUIx8TEV
	 UXid2h/rkgCAO5y7eCJ3LSzk6YjivK2sNLzhNYwOadoXhIuR/4OcdiJiD1lGyTxRy+
	 nUlVOs7JAqpPicGRl4OHpsZlveOtP/E10D5B1KCj60Az8VylLFArk+kyX+IgphG6KZ
	 J+tSk4rEPGdu7XY7ny5k14gc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 505A340E025E;
	Fri, 17 May 2024 17:38:16 +0000 (UTC)
Date: Fri, 17 May 2024 19:38:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Mateusz Guzik <mjguzik@gmail.com>,
	Thomas Renninger <trenn@suse.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v3] x86/cpu: Fix x86_match_cpu() to match just
 X86_VENDOR_INTEL
Message-ID: <20240517173811.GFZkeWAzKjYtEMwe1e@fat_crate.local>
References: <20240517172134.7255-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240517172134.7255-1-tony.luck@intel.com>

On Fri, May 17, 2024 at 10:21:34AM -0700, Tony Luck wrote:
> diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
> index 8651643bddae..996f96cfce68 100644
> --- a/arch/x86/kernel/cpu/match.c
> +++ b/arch/x86/kernel/cpu/match.c
> @@ -39,7 +39,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
>  	struct cpuinfo_x86 *c = &boot_cpu_data;
>  
>  	for (m = match;
> -	     m->vendor | m->family | m->model | m->steppings | m->feature;
> +	     m->vendor | m->family | m->model | m->steppings | m->feature | m->flags;

I think this should not do anything implicit even if it is correct but
should explicitly check

	if (!(m->flags & X86_CPU_ID_FLAG_VENDOR_VALID))
		continue;

I don't have a clear idea how exactly yet - I need to play with it.

Maybe this stupid flow in the loop should be finally fixed into
something more readable and sensible...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

