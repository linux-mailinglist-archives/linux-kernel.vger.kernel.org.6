Return-Path: <linux-kernel+bounces-238192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E25E92469B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AC92817AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074431BF330;
	Tue,  2 Jul 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zmq2BK6s"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A81BF323
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719942305; cv=none; b=sI0uLJBW02+EI/vGqLVLL38sjG2SDDy/2o5I6TaT9CO6kco1B5M1nQkYbnowS41uZVEojCI2QgfDsW5ouQZiyGz/NYF6C0mdkYBHpQXCk9A2VqQvgG5zBtyN1OcT1nE35JdJVFQLqV9r582+ukK0rEMl6DToRCTPwVvL55B980Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719942305; c=relaxed/simple;
	bh=oYqR3wLiRfWSLLApkAQi3EaN6keWhZrozeSyZ8MlMC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlOF3RHaeIYr0aa15e0CQWn5u1u6+bbUEH6kirZsBUKrZJlcctJxwA2Rd8Nl/Aiot7BC4KHJ58D47yjfFgqzo6oOpokhmdWoF5h6PX+GIoRu2sTsqcvmB9iOBkYvpC+RIgpR4cwwsGx5HlDfPPCRDARIThceFrBZaQHyI0ygg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Zmq2BK6s; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 99BAB40E0185;
	Tue,  2 Jul 2024 17:45:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5fKRksOYuIgZ; Tue,  2 Jul 2024 17:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719942297; bh=saeEPFUiOPFddDdAFi8h6suMw9zu7xx9gxAbltffxCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zmq2BK6s8VIRbdHJrU0NIAl/cTDBrZjhMVlr13bZqH1bTR1lFz8AruL2hD5qEDUnl
	 4pxvVSqP81EI0fN+9FcLm1h5bnxkZm11oPnjKlCK5O7Nag+I+RX4FQuQwC4hlr2USl
	 GfYTY4NP78rsBbuzPn1PZ5W8uVXjA7/NgKWn/BuwLckRLEcBsr0jyz6wX7zg5PievM
	 /4HSNIj6bzxmvJBxYF2Y3D6jtn/FeWu3Af1ABiLyI1krJv9d99VUI/+MB/spxeSaFH
	 C5pOC2adhGYgBXXNSIXnAIw8UbJxpEeHJsWMRZ5UTYmiNQ4ctXFWx1+v8o4T6SmxcF
	 PaNZggpEOvAD3bJTkdGWNM6mvDOpsL+bN/HL8FGjp8CVJoSh4RYFqVsQjK76OEcb8E
	 q3saS888JobkUnfJ43KQMwIBQkwNZhXQ/ey6FtPJLSbiECYQlOx79r+9y6vB4k99pO
	 rBBtdlPK1SA2Si5DXu0PTdqGzbx5KKjg28qQiq6+b5oU6w/tnyX6KDIexNhyJXpCo1
	 6cLua57D58h34OB7setVanVUosjZiA4Jrm58nocxAobqzDj97vASER0vjyiogZyNw+
	 NnHKrpqqdLXagXJiSi2fIi4zJLMrMNaARFUs6OK5QfbRCUMeO4MfgFvtP2WPRSpStn
	 V096Pby2Fh7ZHWmM1ACAzcDs=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FA1340E0187;
	Tue,  2 Jul 2024 17:44:30 +0000 (UTC)
Date: Tue, 2 Jul 2024 19:44:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Pavin Joseph <me@pavinjoseph.com>,
	Eric Hagberg <ehagberg@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Biederman <ebiederm@xmission.com>,
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
Message-ID: <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
 <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
 <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>
 <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
 <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com>
 <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
 <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com>
 <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>

On Mon, Jul 01, 2024 at 04:27:04PM +0200, Borislav Petkov wrote:
> On Mon, Jun 24, 2024 at 10:13:44AM -0500, Steve Wahl wrote:
> > These accesses are a problem because they happen prior to establishing
> > the page fault interrupt handler that would mend the identity map.  I
> > know very little about the AMD SEV feature but reading the code I
> > think it may be required to do this before setting up that handler.
> 
> Yeah, from looking at it, we should be able to establish a #PF handler that
> early too but the devil's in the detail, especially in that early boot code.
> 
> Lemme poke some things and people...

Ard, from EFI perspective and boot services exiting, do you see any potential
issues if we enable a pagefault handler in load_stage1_idt() in
arch/x86/boot/compressed/head_64.S already or is the EFI pagetable not really
"reliable" then?

Would solve the issue in this thread where the EFI config table ends up not
mapped on some hw configurations, elegantly...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

