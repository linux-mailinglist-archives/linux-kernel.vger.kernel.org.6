Return-Path: <linux-kernel+bounces-169977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557688BD013
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCFC2885E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A213DDAE;
	Mon,  6 May 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="F4Y+fW3Q"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8413CF8F
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005310; cv=none; b=YxhhFLGYSp5IS36a09PdprHQJ8tokVZx9gidcs8rR0o4rKxyhbNgMZwItpHe4GHl8imZN/20lOQRkHRK8P1bN3F5JBCXzJTD07cfD9ypzdq/THYRL0SL8EHD6LX9yI7THoKH4tr0ZpM86YxHu6LJNcUUKkEPHzzZycufQj8KY7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005310; c=relaxed/simple;
	bh=ZRr6fPqYoTH0sclRmuJEZqEKQMy0r1Bck1MinrSVNpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIMOGa+I0FMZtO/OkkpnbtJ6cZQJfFe7Gv1O7DFXgt7n3E83cIi1QJ2ij1fnaLUR9gB/mGQ92cateyv63omV3a5EPEIZV8TR9NtsoBnTV5Wh1FuAoqlsX5RdRpl6tZqGISj/MCfmXQPUS7bbPgVfggQejvRGow2MSBc29iwSSxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=F4Y+fW3Q; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BEB5C40E024D;
	Mon,  6 May 2024 14:21:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UryTxnO-LRmz; Mon,  6 May 2024 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715005303; bh=b+K6cieeRgzZWM9C6IkS52nAd027DkJxG87ZipG8Sho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4Y+fW3QTaJ9FV2dDcBUpEOnzrKcNwfhgwOdIB3xCvhdM4huoa4p2KYMwSN2wNmwD
	 PurLG1CyOa67XmIA7Pxjr2Sq43TnxBriydtwUVv225ZGWLr8aRIerdFKLvNAEki9Ev
	 QXnergGYbpM8+T3qhaX9/x58MrcWwD71J6vQsKEnlV8KncUGgWfSc0z0LVq8pAhSPA
	 jhRvlK1uhx3ePYkx9TN9Pnrto+jT1IMuDnXrJB5nW+PpFqOIWkIya0hHmvBcQghQxV
	 Qpcy4sW0eigQF2LhqQTtyg+uUpaA4mgngA8rRUjITTzYMxjhNPyMZTnIW07xurGum0
	 EFPpsRZXQJUtWe0+C/HGe/nc6XB0yAZPrv1Vs0Sxr+v1BKJWnv/5mnfPlMEOl9DXQZ
	 WNWXaDv0Ykm6m+6/KKSSXAT4xuzr7YY8i3V3fOOhqtSIvR8d2wWumKRJLjDrYNUk2H
	 wsEOEPFJWyHmHsADUmFJY/mHG2hpgpMdKtvSSnaDSQw/dzm+hSfRo6uzIZiqwrD1Y/
	 1hYGDOpptHLNwXDiEYJSWcNV980028nBBUkVgrWNlt8tJcqln08J8EaS98VWRSAywf
	 lyf/szhCvZVMfnyBCbRiPEu/QgL4G3rSTsUsaKzxv/5Ezg78hEYQ1docvNMEYS9P6J
	 FpbHijWXXqLmCFJnbwN3lyRY=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5342240E0187;
	Mon,  6 May 2024 14:21:21 +0000 (UTC)
Date: Mon, 6 May 2024 16:21:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: adrian.hunter@intel.com, ashish.kalra@amd.com, bhe@redhat.com,
	dave.hansen@linux.intel.com, elena.reshetova@intel.com,
	jun.nakajima@intel.com, kai.huang@intel.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, ltao@redhat.com, mingo@redhat.com,
	nik.borisov@suse.com, peterz@infradead.org, rafael@kernel.org,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv10.1 09/18] x86/mm: Adding callbacks to prepare encrypted
 memory for kexec
Message-ID: <20240506142120.GKZjjnYGMcZkuTLlzG@fat_crate.local>
References: <20240427164747.GCZi0sM6HBCBYtgWqF@fat_crate.local>
 <20240427170634.2397725-1-kirill.shutemov@linux.intel.com>
 <20240502134506.GDZjOY4guvlKH9-73J@fat_crate.local>
 <ch244dd4k5nu5rcryuwqp4pztl4dduhciqunin5drr7a3yls2h@siisliaoc2f6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ch244dd4k5nu5rcryuwqp4pztl4dduhciqunin5drr7a3yls2h@siisliaoc2f6>

On Mon, May 06, 2024 at 04:22:02PM +0300, Kirill A. Shutemov wrote:
> I do. See comment just above enc_kexec_stop_conversion() call.

If you mean this:

        /*
         * Call enc_kexec_stop_conversion() while all CPUs are still active and
         * interrupts are enabled. This will allow all in-flight memory
         * conversions to finish cleanly.
         */
        if (kexec_in_progress)
                x86_platform.guest.enc_kexec_stop_conversion(false);

then no, this is not enough.

I mean this:

/**
 * struct x86_guest - Functions used by misc guest incarnations like SEV, TDX, etc.
 *
 * @enc_status_change_prepare   Notify HV before the encryption status of a range is changed
 * @enc_status_change_finish    Notify HV after the encryption status of a range is changed
 * @enc_tlb_flush_required      Returns true if a TLB flush is needed before changing page encryption status
 * @enc_cache_flush_required    Returns true if a cache flush is needed before changing page encryption status
 * @enc_kexec_begin		Begin the two-step process of stopping
 * 				page conversion... <insert reason why it
 * 				needs to happen this way, blabla>
 * @enc_kexec_finish		...
 */
struct x86_guest {
        int (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
        int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
        bool (*enc_tlb_flush_required)(bool enc);
        bool (*enc_cache_flush_required)(void);
        void (*enc_kexec_begin)(bool crash);
        void (*enc_kexec_finish)(void);

And calling them a _begin and _finish makes a lot more sense to me:
_begin starts the kexec process for encrypted guests and _finish
finishes it.

Just from the names you now know what needs to happen and in which
order.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

