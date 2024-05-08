Return-Path: <linux-kernel+bounces-173204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA858BFCF2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A185285127
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD65383A0D;
	Wed,  8 May 2024 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kr3l/QTG"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF300839F1
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170368; cv=none; b=KhzaBsnK0C9w5EaLjsQY7KqlHHn/AzTxIp8AdLsgstW8jbijArDagOTHX+6EluY/ZsRQAGVv5xXHua887KAHA6JIzGelzSAgev+2bI8LUOTPofaPwAFDA0tEF3HpEOqYlb6keAF8la8oO9pQL7TxeKQEJE67Kg0ZaJxH16EHpQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170368; c=relaxed/simple;
	bh=OB3bNfotTy94ijgLvIlZef+XSj4HmuVlV8OVyMsV6iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAXGHIV2xUCgv6MaKqPlZOH2ILQeFfr1I/kLoMBK+M8ztMJOVVf770o/fklq7RtoRcFGm90NH6192es6wqYQp0e8rCwk/oeHrg0A5B0Nk7LVMT4fOVqssOyxtgNRgLF/SIRNDMu3UEZCelIVkBeVDeRtRL5u/F/1DxoF9vneuvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kr3l/QTG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 228C340E024C;
	Wed,  8 May 2024 12:12:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZMrQa-G91QOC; Wed,  8 May 2024 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715170361; bh=qN/y9cHUEBVLV8pGVkdG+RsChyPSuLA4sQE7tRTsrxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kr3l/QTGRMA0C5rE0e/SeORwk40rtp/+BlatDIUPkby0/3PC8MCiewul76UFf2in2
	 Ay+annVxKQt1fUIKjlAE9jM5vbfVrJ7kwvX+exRaaDaWUIzhXkcrVAr8RpNie+8Pp0
	 7x+CWCVvXEIhaPQ/Rtoh5RwlmMNh/c7NKfnmguE6pss4+qMg143hA1L+zgE59wn56d
	 pvcaw0j9kCRe0Qpve8BNC0VksaR/CzY4ImhJ2ai0G4vu2euysByIjJYc9V521UBSg3
	 iBFg+YhOhwo5BfeYDWxzhpa6vdducb2lole5f6sE65fX+MOV3EAB23pc3+Zbpln3fg
	 auKQXjxDb/bB7r9n/N/djgbl9qOOte9b+EraRYAwdcYuS3+sh1v7BYbt//8nISZtOW
	 /Cv2eGLyOHRJgvvoz52LrVXv6SXFOOOIgRK8iWZB+xGDWNQfF7Ro79R1+pXEOpFVbb
	 vcRn4Hxiy1Rj1YSUmQPlDMJBJBoeTlpSPZCWODe0ar9r8JW0abP5wYTK2QA/dI1QFm
	 bpfYE2Syrw3vTkaJg1p9otjauGTDojtkVyqHowuzJvuhhxSdcC8Vb3z8Z0J3xwenIL
	 mJGdwJbme+2f7xJd7Aa8LDT2ea/zGzWzCJW8YvL/dqG6QeX0t8ZRKD7p4BjTImLPJX
	 0RKhFREPvR17HSa7OwJ2IY20=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B01E140E01A3;
	Wed,  8 May 2024 12:12:18 +0000 (UTC)
Date: Wed, 8 May 2024 14:12:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 11/18] x86/mm: Make e820_end_ram_pfn() cover
 E820_TYPE_ACPI ranges
Message-ID: <20240508121217.GDZjtsIZmROSwirNUF@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-12-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240409113010.465412-12-kirill.shutemov@linux.intel.com>

On Tue, Apr 09, 2024 at 02:30:03PM +0300, Kirill A. Shutemov wrote:
> Subject: Re: [PATCHv10 11/18] x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
						^^^^^^^

e820__end_of_ram_pfn()

> e820__end_of_ram_pfn() is used to calculate max_pfn which, among other
> things, guides where direct mapping ends. Any memory above max_pfn is
> not going to be present in the direct mapping.
> 
> e820__end_of_ram_pfn() finds the end of the ram based on the highest

RAM

..

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

