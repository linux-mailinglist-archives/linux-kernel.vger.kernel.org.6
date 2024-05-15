Return-Path: <linux-kernel+bounces-179769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A99F8C650B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7401C217B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ED25EE82;
	Wed, 15 May 2024 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NF9gzcOP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C95A4FD;
	Wed, 15 May 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715769749; cv=none; b=ae0AFYFighAF/8mY2LtWiI8xqXFsQdsJBKVAPu2bT2SJzUAPzRfuwu1xN2dkU84tnX3r3x87XPTep9Jv8ofGCQbgry7ZBzrcMMUbUudN9PaRQ2mdB7PnFOFEMQVksZI5ZY0QU0qpsf99FfBnGAQ8REHEchH4lnYiqYwCxvP/RWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715769749; c=relaxed/simple;
	bh=Q8M0DjRqd2IFL7aXqcSjRkvvUTFONy9etfP0lzkfc4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCBYsSFRANmF8vVbDNXWVDFBsxC8L18N7WPc2NrkgCbtVk2KcTKvjC8R1uzG3is86fPpldSYghiT5N1h7uBA+auLbDwDKgGoB5D4yPhGl/+SbCmrzVDtp9GPQFY4ifuTftKx1Er6PJ1Rdgz/XtqozF4DNYRMgmpyDxpfw7DSMqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NF9gzcOP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 794B040E0177;
	Wed, 15 May 2024 10:42:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DN6m_2lNWs-3; Wed, 15 May 2024 10:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715769736; bh=yE3F00zgM8Ec+9gOT9ropjs1xEfw03srAD/IRCzOsCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NF9gzcOPp3NEXxQP1UT1pm+893enKzfIqMDg4FkR4pUW/VdY2DPBwvTsuAF9q2/yT
	 cvemirL8rRWJ6epprTVOcMQLyuSdATdiS1B5sm7Uh4oeQrBiWWNaqXGPX2y04mV2B7
	 IwUmmPMi3Wn0VURN0/J4Ivrk2PGNu5YZPXKUdbI10ZruZTrShRiYcPeKuQ+8Pm3KwJ
	 fkiIQApQIwIPEuizLhxsaUQXWm/ZwZJZGAL7afibQBKpRP5pSea6d+LULH4M02XgAN
	 eDXwLlq+RFaOVCQAGekgDJ3aGDgTCbOWeblnxc+IwFZnB/mUcwXo1ztBG8wstAmihh
	 wAXZG3k7Hn78xuqNUN6b0pOukBQCMQbmzUeA45c2xvWj1c2Q7BTnZaKW57BzWDsbLc
	 6k/H7I1PQOUssTSKSDxTryAvBdTsq6ELtEGefmisVxs888/HFTX1GkUfQiEZYH0jxi
	 Vd4dlDKWRt/ZwziRTS033lDSDrFZAkshSAaRTjdeP3JClni+aL81VZKH86gtbiSW6n
	 Z+d0vd0VuJj77aYXEAP3shLZYWnOA6FEiOs8/+eBDjbYbGhEsU0QEva8fJ5nXjL4aN
	 x7w1U/pYSI6LuUDaKh/GScF6KHnUBNQDhwynqB3Z3GKewEOdm7W5u0ARbBAdOx4T3z
	 AZrHBIBJn+8FGNYk19MVlGME=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE9BD40E016A;
	Wed, 15 May 2024 10:41:47 +0000 (UTC)
Date: Wed, 15 May 2024 12:41:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Liu Shixin <liushixin2@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 1/1] arch/fault: don't print logs for pte marker
 poison errors
Message-ID: <20240515104142.GBZkSRZsa3cxJ3DKVy@fat_crate.local>
References: <20240510182926.763131-1-axelrasmussen@google.com>
 <20240510182926.763131-2-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240510182926.763131-2-axelrasmussen@google.com>

On Fri, May 10, 2024 at 11:29:26AM -0700, Axel Rasmussen wrote:
> @@ -3938,7 +3938,7 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
>  
>  	/* Higher priority than uffd-wp when data corrupted */
>  	if (marker & PTE_MARKER_POISONED)
> -		return VM_FAULT_HWPOISON;
> +		return VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_SILENT;

If you know here that this poisoning should be silent, why do you have
to make it all complicated and propagate it into arch code, waste
a separate VM_FAULT flag just for that instead of simply returning here
a VM_FAULT_COMPLETED or some other innocuous value which would stop
processing the fault?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

