Return-Path: <linux-kernel+bounces-199496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E55158D87B9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3EF1F22731
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A39F136E26;
	Mon,  3 Jun 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UoaF02iA"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9889E12E1F9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434788; cv=none; b=iHTOU+LKvh4UFXFDGVx/ytuVnLSIB/V+ewfIBtAtt037cEPCYzSXkihhJrpI7i42hwQIbWRfglXnZadvJwDlnF28qrajv7EZJR7Al5UO1nhPWvTm0utAOrwLo6aaHcjXeAcsxPZyskjuV6ADUmpvQoGmNk+Jn8bFWEKnbZ/7g/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434788; c=relaxed/simple;
	bh=rarbm4FivPkK3sgMveXhHZcTE4JvgYqXKWIDIqdUVhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sq2DKvy1Rg4/uoBM6b0yIMocnQHL5otl3Demb1bHtGlR3GbrS420s2VohBiYw51xpMp0LvaQuoI0Y5PvG6rptMlkLVMZ1MOOpezUKDGuWG3Ar8JxYGOz1fopCBAS+F9+40H7O/F0Hm87XR64lGA708yzSevJe64WnyZfm4zFeCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UoaF02iA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6CDD140E0177;
	Mon,  3 Jun 2024 17:13:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zLdRqpM4nFQ2; Mon,  3 Jun 2024 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717434781; bh=wOb77vMkzvVjJuhfqxH+VEthZC7Q6K8Sm8HZ2/2VE40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoaF02iA3K/R2Ga4rSD8TjWmvRmhPDxfX3vDeaXd+3U9e5ZSUahv33jd7fe/EXJJM
	 8FTXfVfhfDQ4u+ust1pO7uax3JgQB5Uy44DW5H0XNR2lM4uBglT0SYhpNdQfMFj9qB
	 k0p9ZBF7cXCZMVWwKeNuM4XF5sM6uu4n3WfmKQ81sXI7yr2lBKmGDYgoaeSTMsGYYs
	 K2PA9a7pxIqXSvg1/+10b+ty69rzST/Zxs2Zcc6OrhoS4wljm2MTV/KBFKTGiA52hf
	 ONf5o4GGnDJQy6MKh97jSpYf6SdlTqR2OyYNR1cUbO+Z7YCoQexsCcuGXASVFspuEM
	 jGXqeZp6cHr3WIcHxQNJTH1jPIj/A7p96BHaU2FtwDkolplAUBoPsC31O/DnJSdB5v
	 IVDfUcdNnyxZBmfkhHsndJMdywSZ1ZapwYxABiZ6HNZfxs8yvqmOB+xKhG3fBlDuIM
	 la4gCiMeTcbV9X5vmPNcpFoPDuaDNiH0+8uED+H9Hwe4J2gmUbf531rX6Ep1y3yuMy
	 +NIPKYBNT8e8/wcXaeLzVN2mBe+kCUM3n9EYAUBlLs62YERvkpwRJKpUoQfKoZcRQC
	 j9nOG6K/KO1JGOpwggSeu95jo3dbAmo5xBRBi91Ag8xR3he86BMG6WLrTrqrdUV0CV
	 Dz1+sR6jE5uHY8WXwPpf0LsA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5AFA940E016A;
	Mon,  3 Jun 2024 17:12:32 +0000 (UTC)
Date: Mon, 3 Jun 2024 19:12:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Mike Rapoport <rppt@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
	hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
 <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2343889c-887a-49ce-86df-343737d70d37@amd.com>

On Mon, Jun 03, 2024 at 12:08:48PM -0500, Kalra, Ashish wrote:
> efi_arch_mem_reserve().

Now it only remains for you to explain why...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

