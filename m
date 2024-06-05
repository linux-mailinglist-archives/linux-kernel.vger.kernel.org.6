Return-Path: <linux-kernel+bounces-201895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D398FC4DE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3131EB23E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9BC18F2EC;
	Wed,  5 Jun 2024 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FM0WGn32"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B5A18C34D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573423; cv=none; b=UUltcsrrMjuFhTLaHx6BWIHpsC10g9LjX5R0xl/ZZufi0058vmNbiwj6tX4mrqGWNBVNjQVSxeoN7NMlorhmHaGB5lSHxUQXp31rdUo9bLFgoWDXNOUT3qiCUg+8QQumPgMWlwvheM7IF66RMD3JbL5VAv9QVT7YvYt1mMEDrCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573423; c=relaxed/simple;
	bh=K4ipkLOt9KtZ0MgbWhiY8FJ4E0gH2Q8E2HKKiqSvnP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5vjSmxD5LlpDyekrA8xrO/oDPI6E3m8dIdDUdDOhNzxliLBJegKHRzZ4be04r1CoZQxMYUYgzQ4elJIFc6xKdjSiz0Bx4bftogqKllcy/cj1wroThrJ0/pvRj58aoGBtBIcx51H+2D9w03jn+gW305piHI/bBsmZUc14zNon0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FM0WGn32; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 06FDC40E016A;
	Wed,  5 Jun 2024 07:43:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XbvGV92rLO8V; Wed,  5 Jun 2024 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717573414; bh=Y4I52v2EdsdONC4N7gjTDK8D0wPbQuWZeLOqmwGhn9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FM0WGn322/ny214BmEwVjVnMOYmHgCEwiKQQuKobottnnNKZk07U2UJj/i+xiY30H
	 vP4RFQsF2bqDxyM/LcFfl1yVDhgMXASLvfRwJS3AJwi32vS0aSv756doMNTezzjHiq
	 UlAXEd8tmlWM27uVBNSkeG/6FcS2H1Gi0/bLgKqE12dgT2B+2PqNeAgong+xjL4O+p
	 6zRuUGvTmtt1f3IU3Xpo8CYIavgEiTBN2Wxdd5GrdiBZRp/TkMONV7teJ+gwmaSok3
	 gHoPkeKd18aMk0rpK5Y/4+oqkqvfgYSAyLTp3l2C0fTtNZFptbKRSQtJYuz+FScFPn
	 TTM580/Ns5aqPRGZfVWMyok5n2JD/SYR6b4xdkKJ8K+e2G8YNp0M2qnv0I2O3ztNok
	 7Fc5nLwBdrs7QBbwMu1xSjgVpungA3fv2rlLK4YuBaMz2beGerAPeWVqUueLbnLfPB
	 POW+X+0M5Qv5Wgz4Mw5zaMoEqmknbhmxs0crNfiy3YMZRBciIqI8NpKiOsxozQemvE
	 3Qy7Jn3AklIAHFCQYU8rfgKzgo6SsHIi4Nb+NTPptGvzJuXZ5SeoiacS2/upGki754
	 LP13oUm9t5yaGRaiZt35SKALvA+cs86cFNjtH4HmRY+hnrKJuyZF5S4dvDLR04VJ1O
	 Tbz9jmdl7GAVCUV8FcBE3FMc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12F0340E016C;
	Wed,  5 Jun 2024 07:43:05 +0000 (UTC)
Date: Wed, 5 Jun 2024 09:42:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Young <dyoung@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, "Kalra, Ashish" <ashish.kalra@amd.com>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240605074257.GAZmAXAbkc5TGVds5u@fat_crate.local>
References: <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
 <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local>
 <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>
 <20240604180212.GHZl9WpAfNVERTjMqw@fat_crate.local>
 <CALu+AoRqNmsWXi+HXYNYTY=pXJ3sLTLKyXNeJz9EoxEsHzFdQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALu+AoRqNmsWXi+HXYNYTY=pXJ3sLTLKyXNeJz9EoxEsHzFdQA@mail.gmail.com>

On Wed, Jun 05, 2024 at 10:53:44AM +0800, Dave Young wrote:
> It's something good to have but not must for the time being,  also no
> idea how to save the status across boot, for EFI boot case probably a
> EFI var can be used;

Yes.

> but how can it be cleared in case of physical boot.  Otherwise
> probably injecting some kernel parameters, anyway this needs more
> thinking.

Yeah, this'll need proper analysis whether we can even do that reliably.

We need to increment it only on the kexec reboot paths and clear it on
the normal reboot paths.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

