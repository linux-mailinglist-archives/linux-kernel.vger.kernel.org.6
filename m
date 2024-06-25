Return-Path: <linux-kernel+bounces-228272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0054A915D86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FC41F22624
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD657135A69;
	Tue, 25 Jun 2024 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DWAYvYSJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A711E893
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719287993; cv=none; b=PnQ9VCyS0PHyUdpMj45+n28QqUtrSQ6ahHYLrFLn2q9tqPudq+sVw1v6afbQLTNQRrckn0iZDLZ1ghxWNwdSXwgBQMvhAaGUpoEO8BaO1dNgDIB8JxwUqyVyb21z8TrEPENfaR8/nyOCGILnarTxHQkjSTf/7KHVDT/CL/YT+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719287993; c=relaxed/simple;
	bh=yhpPFssP6oehyqazQT4Yx7kIJHIPHzgLkOi/clPB1qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP5KHTtX3sTCaD+pnKeRvLuBWXOX5KJRLEi51J/QhawO4AWj9kSIdc89/SSa5Mnlv1qD5agIdmu4SmBVOd+SUC/GBhJPY334FHrAwZX8q1axe0mcoi7Z1P6Fa6zi7HRDGvLRx78bclj2oxupLcAJQFmN3uX40prag//vr6uam+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DWAYvYSJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0483B40E01D6;
	Tue, 25 Jun 2024 03:59:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id p0aPhogJeEvc; Tue, 25 Jun 2024 03:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719287984; bh=NGE6k15yt/YA8tmLnFsWy2oVKXGugkiZpFZ4hOjBhFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWAYvYSJCvfHC46BI2hkwsEjZq3z789TA2evpZDUfGXa65tv7iupqtNf4VUf3BqQc
	 uBE5agD/82Ur/2oxWJ8yZj8c0V0bFy75jiCi2PSgR5OXxUccZA95vNL95wWTnXk+iE
	 e8gWScrjP3rXWYxjeVEloxNY3h/5P52eV2P0sAy8XO5ZrQ+A8TVVBa+w9EmsExt3oC
	 rI0JQ71Yn+UrN/7BZaUPx4mD6eEU9R7UhlO3xUrXrqupxz8iHDiD/wpojeGkHbQwiu
	 PBVRCz0z5Yo49w3rfAVLbqrVQcWa6bG+qq6G86D/jLoIgYlz3JAE5IDgsdlpYt/wrq
	 LVm2nxeb8TQeDEWjZJxfeObm8GYD1E3GrTpIbHvGURhPC0nf4q8mnRi56nc/Dlx4+Z
	 iHKnu2jSPHk0V3+GORAwR9uDDV0FINuMTTb4weEhulLPAv68ai9bDhFa5B0h0Legnd
	 SxQxPVQMG9asYIFzrG3/RFDDdn58RJ3iFBFLie+3OJB+v0BVYldz9o8jkirAnnvcNc
	 DMZv/dQ/kf3vNP52VOMA6mtU1jw3EW1FcfgdvIa2R5UJQSPYxnur1WGXJuvOagCaJS
	 OfWZs5R100mk/He9WnH8JE09B4Z5zqyxNxlNmrVvGMQfO3PnM08tknTKo+LsfInlRJ
	 2EKIhUfLKCO3JwKvMtS/YUNQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6EC3E40E0177;
	Tue, 25 Jun 2024 03:59:16 +0000 (UTC)
Date: Tue, 25 Jun 2024 05:59:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/3] x86/snp: Convert shared memory back to private on
 kexec
Message-ID: <20240625035909.GAZnpAjaV72A50kcWs@fat_crate.local>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1718920799.git.ashish.kalra@amd.com>
 <f6c0ddfd15579674bc234d6e1b84e92768531050.1718920799.git.ashish.kalra@amd.com>
 <20240624182615.GLZnm6R4hLvnlF16aP@fat_crate.local>
 <ba22b2d8-5621-4efc-8dc4-03b92408155f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba22b2d8-5621-4efc-8dc4-03b92408155f@amd.com>

On Mon, Jun 24, 2024 at 03:57:34PM -0500, Kalra, Ashish wrote:
> ...  Hence, added simple static functions make_pte_private() and
> set_pte_enc() to make use of the more optimized snp_set_memory_private() to
> use the GHCB instead of the MSR protocol. Additionally, make_pte_private()
> adds check for GHCB addresses during unshare_all_memory() loop.

IOW, what you're saying is: "Boris, what you're asking can't be done."

Well, what *you're* asking - for me to maintain crap - can't be done either.
So this will stay where it is.

Unless you make a genuine effort and refactor the code...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

