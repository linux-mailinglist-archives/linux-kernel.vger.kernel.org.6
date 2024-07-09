Return-Path: <linux-kernel+bounces-245650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049B92B57B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76ED41C22EC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE445156968;
	Tue,  9 Jul 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SJtfNySh"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34052E62D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521497; cv=none; b=WNfL/z1Mo5BLssShI9R6Krxco0meMODfk3zGSYdW8ngmaLR0zKFRdSTaAffnxXDPoFUW+yTKL1tpXFq7Zw7+IMoPRsBmq43BDm+8Rzn2pB2ZVOMeJ4btj9pNMnRPAcsn8vVp83uXCJ2Ud0d1IX6kf5ygPvrksHF7d59hD76YyI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521497; c=relaxed/simple;
	bh=hb7ypSaWD0r0znVQHRKLVtNi37VawD10KbVQbJWnXIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEB+I8qyX3HZow2pA1ZHx2NjYuDciyxNZh/OpPP2T43wBzrklzH59ltiCEZxCEdvZWwhCxyoNBO6AdHpm75+ItZwXkSF0PNojodv098Mg1t42N0iWHDdNGoG5j2zjxL7wwVnbMXcn4b159s+b+Z+9aA3ysV2WXF67XfOQLY94dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SJtfNySh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 66BD840E0185;
	Tue,  9 Jul 2024 10:38:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sWJM1MyZEvjd; Tue,  9 Jul 2024 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720521489; bh=UNDneBSJbjM12Og34Gwp05M0THiPowrY/QmV7biK58s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJtfNySho3hYEIIu6H7+fvYFIXi+HPu8gIsqf0FwJT3in4q0T0tDvedUq2iUhpMaI
	 ovvXMyr1YLtqWCG0eAsz8O0nFKJ6bZFGsFB6dQS15MI+90hs6qNIhYfaPtCmqxrzkB
	 7xhXJLm1mmNZcz/B16uWTqYT79HF8ckhphG3qB3kgdvivWaZzvIzFCZzKBaWWUFf9n
	 CPt57VGRkU7wbYDyaLy3mfTuQASUoXZ6ZbZaMItJqX80zDa6dgzg5I+I7eAiYWuGhz
	 PY27UMYXAyfhFs854RVWx/bwZBRSUYusmp+lHGtvGge78Jyvasnm8TuqtN55PZUiOe
	 0tJ4WilE06a2KHUUHOE6pA8itQesg+xoJY055Mn8mmS9oMKF0VaQQ4ry5m7b/n2WwX
	 GqV5SAmg4A+GJ09b1BKJ0EbbfAnRLqgYxdAGr7gJhrJ9eT5bs9iVInKsY9WJuaZwlu
	 +TWcQOga0kkiS2NhbLU7tLls+LY0ADCQiJ24QOQADdmvcCSNp5hlTckae/HlbDnrbd
	 c3wTu6S/A8wvWX18vTxJAsvHt1zCGF7pC+AhGeDVd0xdbG2YxHU5tPEIICNqKFhBbY
	 knVncfPIa56EjWMBEbulhv0i9riM96U0qJDDp1mBPJJQKpAP+qF05cnbbDPHsevgF2
	 1dREayApYAZZpWikqZFVsHGo=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 159FC40E0192;
	Tue,  9 Jul 2024 10:37:43 +0000 (UTC)
Date: Tue, 9 Jul 2024 12:37:42 +0200
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
Message-ID: <20240709103742.GCZo0S9md7YyeevRN-@fat_crate.local>
References: <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>
 <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local>
 <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
 <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local>
 <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>
 <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local>
 <ZoxOt1_w7nblRQCv@swahl-home.5wahls.com>
 <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com>
 <ZoxX9mckeu046zed@swahl-home.5wahls.com>
 <CAMj1kXE5OYTxxBEO38dRyYt_J1FNpU-tdkaU8rxvrMLd_k_beg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXE5OYTxxBEO38dRyYt_J1FNpU-tdkaU8rxvrMLd_k_beg@mail.gmail.com>

On Tue, Jul 09, 2024 at 08:49:43AM +0200, Ard Biesheuvel wrote:
> > Patch #2 adds the CC blob to the identity map as well, if present,
> > since if present it is also dereferenced before the page fault handler
> > can be put into place.  Given what's been discussed, this patch might
> > not be necessary; I don't know enough to say whether kexec-ing a new
> > kernel within a SEV guest makes sense.  I'm pretty certain it can
> > cause no harm, though.

No, keep it in the bag until it is really needed. No proactive "fixing".

> I'd prefer it if that is addressed within the context of the SEV guest
> work. The memory setup is quite intricate, and dealing with individual
> types of EFI config tables is something we should avoid in general. I
> still maintain that the best approach would be to map all of DRAM 1:1
> instead of mapping patches left and right (as this is what EFI does),
> but if we need to do so, let's keep it as generic as we possibly can.

Sure. There's the kink that coco guests need to accept memory first and
mapping it all is the least performant one. But we can deal with that later.

> I wasn't cc'ed on any of the patches so I don't know exactly what was
> discussed.
> 
> Please cc me and linux-efi@ on your next revision.

And please update your commit messages with what was discussed on this thread.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

