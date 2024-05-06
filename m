Return-Path: <linux-kernel+bounces-169644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4376A8BCBAB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 421A2B21868
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2F142E66;
	Mon,  6 May 2024 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fxhWNI7x"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002C1428EA
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990174; cv=none; b=f6D+B/kAxXx7j+7xMbEi9qGr3fU95T7k2fUSfsSaX7IYWRie3ePDlfl7vTNiaOqjY5uZtIdFug0WOXSbP+KlAPGpgbWbbOSrjnE4OHt0avZuFmILYvswcRhgm9aPGdQVlFE4QEFzrpy+k31Yq2GRQaPT/DodAa6+9aQgmc02UjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990174; c=relaxed/simple;
	bh=c0xjj+ANGz4MxBBiLBwLKEfespYcrDozzderIyQtxCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tA5K6lcIk0jgfNDjhSWpYiGQX/t1L8kchUfs3d3SHO7nikOSQWq6Xn/IawSQqfLKkTz8vmjHAT5m+1NwTxvgADTzOti43ZOld+2kwFQ1edPuh3kZ+3uZbgXd3YoqNzhXTGGXvY3TzmFCKUOSDqmUpr+NT7ws5FQdduMmxxSuCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fxhWNI7x; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8261040E0244;
	Mon,  6 May 2024 10:09:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y3q0j_RtuwX7; Mon,  6 May 2024 10:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714990164; bh=yDr1d+Rpi28/rr/NTeMKaEESBQG5/hCp8YbpHq/FNGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxhWNI7xGUuq0TG29EfWKa5XsWgrwrDf2hRgnywI43wzMluTYjWUhLK5ZxvxRioSg
	 n7H3ltxQAeorYssA1r1X2pSBy+frVvUUNI1WbivXZTbsHSotS/Coyw1yQBJzPzQ81K
	 PIceAxUp03s4B31aKNKOS1h4sZWFk4O/rr4CXtFetht3Uz1FzNlSaFgOvAY66S7sIf
	 glW3SIh/ArL5JI0cksjKl10wv/tO8Ex5uk5ALqRXdSXxymFykLCo2+cWcY6qkomyDg
	 aSxI/jHkB+R31dXBir8T4sZfAupVHAMk5P6hcZiiDsJurW00ReYO6aFWx0LIdHFGHf
	 pOtp86zOzXxbrn1VUeglMRPAw3zwufJi7nxNmozsO87CzLcgsz7OpugYjUYcWu3HgV
	 acKjH5VcCci/ltJLmIe20OIY3Z4HmHRcW8QbLuDIcYNqvSbbn6U+/z3SCc7yzRecqf
	 UslWq7pgPFWzqVfYbkjxuBqVIkCcOAZZz2ZqB6/1G19g3o/copT54byFAmjy4rr3QX
	 DhVNKV2AjqMoEkWelMJxSuf3o6sLo6BTcCZjDkar05YAcGYgldbdvjirC3NbDrRHU0
	 olZtmUhC/f89T1ARPEPyCPf8b29nnqeZ/Kya3rAuUkcX2kVPmajVL72haNoSGRVZel
	 xemUn1/hlC8sVdWKVXj2xYC4=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E38A340E01A1;
	Mon,  6 May 2024 10:09:09 +0000 (UTC)
Date: Mon, 6 May 2024 12:09:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 05/15] x86/sev: Use kernel provided SVSM Calling Areas
Message-ID: <20240506100905.GFZjisQTQwbkv2eKsh@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <07266b47e749267ef9a9ccbc9e8e9df78ed54857.1713974291.git.thomas.lendacky@amd.com>
 <20240503103407.GSZjS9n-XMMKi5ZOek@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240503103407.GSZjS9n-XMMKi5ZOek@fat_crate.local>

Ok,

I think this is very readable and clear what's going on:

static __always_inline void issue_svsm_call(struct svsm_call *call, u8 *pending)
{
        register unsigned long rax asm("rax") = call->rax;
        register unsigned long rcx asm("rcx") = call->rcx;
        register unsigned long rdx asm("rdx") = call->rdx;
        register unsigned long r8  asm("r8")  = call->r8;
        register unsigned long r9  asm("r9")  = call->r9;

        call->caa->call_pending = 1;

        asm volatile("rep; vmmcall\n\t"
                     : "+r" (rax), "+r" (rcx), "+r" (rdx), "+r" (r8), "+r" (r9));

        xchg(pending, 1);

        call->rax_out = rax;
        call->rcx_out = rcx;
        call->rdx_out = rdx;
        call->r8_out = r8;
        call->r9_out = r9;
}

and the asm looks ok but the devil's in the detail.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

