Return-Path: <linux-kernel+bounces-554765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68662A59C26
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886B93A8D69
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF206233148;
	Mon, 10 Mar 2025 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dP64LCSw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69922D79B;
	Mon, 10 Mar 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626503; cv=none; b=mn7Men5siZRXC0U/K2iS7t6wmZaVEtAPOcfdodt+jm4+x0NVgBXcPrZQfy7vE5HuQK9XRaj8+FtR3sIaib1gpTs9+Z7wIBlfCGySIvr9L6qO30TQ2WmxV5ecfvpC04AJ1H31KVVHqWh8WEelx84GSvxVFSM5baYvYRM5WQHr274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626503; c=relaxed/simple;
	bh=BDPwHEQJtDtD2d6bq3wswYDHcfGQePvakq3VHHuiDXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfAOkHeVIzBSd8/exBjbvSDY5d6mJ3vtwLd5F7VgU2XrArnjNafb60mstVw3ouYAh1f0h+nEr6bageGQFTQNQrsjsnP5bAbYhnJOsohZv2p64NxILpfvGmRwzTDjfvba2aFur8HXzqMyXLPxXg135vM5pzXAQLju718VDb3Hgp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dP64LCSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD209C4CEEB;
	Mon, 10 Mar 2025 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741626502;
	bh=BDPwHEQJtDtD2d6bq3wswYDHcfGQePvakq3VHHuiDXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dP64LCSwb0qvMdmxNsq4aBgEkKCWTngBOaUBShh/E456amPJ+27bT3yYrEE5Gbe2Y
	 pF1oiiVL7+YWc6JNBHa7O2WtXGhJjTJsTLGJyLtE+bAmPCfq/3Pc4kAd9bqycwPSz5
	 Adjk1OWKoidmg9OiT3mJIBc1IgB4uMqcUHbsgzJ+KzsaRTD5TKEwDpPg4x9PsZvD/4
	 EZ7Q2cZdK8XAVDyjTOEv9MAuloiaC6ai4D/YMIbH2cPTCon/hLkqajOt3wbw54YP15
	 wU2ay6wa88LQr0FNFLZu5rhY2ee46XOCZ7yoC5WtWWFs0NwciIsHg/fMOPeT7J/JrC
	 2y2dbOxSiNHfA==
Date: Mon, 10 Mar 2025 19:08:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 06/14] kexec: Add KHO parsing support
Message-ID: <Z88ccZat5wm_iXx1@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-7-rppt@kernel.org>
 <mafs0zfhs97ta.fsf@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0zfhs97ta.fsf@amazon.de>

Hi Pratyush,

On Mon, Mar 10, 2025 at 04:20:01PM +0000, Pratyush Yadav wrote:
> Hi Mike,
> 
> On Thu, Feb 06 2025, Mike Rapoport wrote:
> [...]
> > @@ -444,7 +576,141 @@ static void kho_reserve_scratch(void)
> >  	kho_enable = false;
> >  }
> >  
> > +/*
> > + * Scan the DT for any memory ranges and make sure they are reserved in
> > + * memblock, otherwise they will end up in a weird state on free lists.
> > + */
> > +static void kho_init_reserved_pages(void)
> > +{
> > +	const void *fdt = kho_get_fdt();
> > +	int offset = 0, depth = 0, initial_depth = 0, len;
> > +
> > +	if (!fdt)
> > +		return;
> > +
> > +	/* Go through the mem list and add 1 for each reference */
> > +	for (offset = 0;
> > +	     offset >= 0 && depth >= initial_depth;
> > +	     offset = fdt_next_node(fdt, offset, &depth)) {
> > +		const struct kho_mem *mems;
> > +		u32 i;
> > +
> > +		mems = fdt_getprop(fdt, offset, "mem", &len);
> > +		if (!mems || len & (sizeof(*mems) - 1))
> > +			continue;
> > +
> > +		for (i = 0; i < len; i += sizeof(*mems)) {
> > +			const struct kho_mem *mem = &mems[i];
> 
> i goes from 0 to len in steps of 16, but you use it to dereference an
> array of type struct kho_mem. So you end up only looking at only one of
> every 16 mems and do an out of bounds access. I found this when testing
> the memfd patches and any time the file was more than 1 page, it started
> to crash randomly.

Thanks! Changyuan already pointed that out privately.
But I'm going to adopt the memory reservation scheme Jason proposed so
this code is going to go away anyway :)

> Below patch should fix that:
> 
> ---- 8< ----
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index c26753d613cbc..40d1d8ac68d44 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -685,13 +685,15 @@ static void kho_init_reserved_pages(void)
>              offset >= 0 && depth >= initial_depth;
>              offset = fdt_next_node(fdt, offset, &depth)) {
>                 const struct kho_mem *mems;
> -               u32 i;
> +               u32 i, nr_mems;
>  
>                 mems = fdt_getprop(fdt, offset, "mem", &len);
>                 if (!mems || len & (sizeof(*mems) - 1))
>                         continue;
>  
> -               for (i = 0; i < len; i += sizeof(*mems)) {
> +               nr_mems = len / sizeof(*mems);
> +
> +               for (i = 0; i < nr_mems; i++) {
>                         const struct kho_mem *mem = &mems[i];
>  
>                         memblock_reserve(mem->addr, mem->size);
> ---- >8 ----
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

