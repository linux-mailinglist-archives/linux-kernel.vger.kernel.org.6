Return-Path: <linux-kernel+bounces-244743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE492A8C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD13928271A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFCF149C60;
	Mon,  8 Jul 2024 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CmaD9auL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0953A149DEF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462336; cv=none; b=dE9Edou5TqbiMZEmC+ZhlFi1uTI5FVxvOCLnUai29ar6wlGhcSOeNJon8zKO887DvZe+Zus2s9C5clrq8hXe9Ns6sbAFYP9IMeeN2sh6FPzMDZtY/jg0IlisR5nDvd7c3Njo8otpuznQdOptt+Wf142ojI3LsDJE8amWI0ltU9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462336; c=relaxed/simple;
	bh=3SRN07gW8KadA07WMWKLIZWwgaoZ2seUB0z5+wWRPjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eipQ+I9p7HGV/8YuoO6OdiJxcCpoldMuIqc8PV1+H+ptBwsJQ9drLRnmOqhNrH7dAXAZO6+iA46b2+G7QWPirqeGeHGRxaiJNMltkBO4aqW2mQ116T32tiaxeNh7aahY9f1YRp4JcE//PkCybi7kBRzjky3eqMsFHCYBrSoRJOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CmaD9auL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0AA3A40E019D;
	Mon,  8 Jul 2024 18:12:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DFr0AByshgNo; Mon,  8 Jul 2024 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720462328; bh=iX4Q3ez4xLSCHud0GhEsaXKGZ96Mpi5r9OTimi4q+9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmaD9auL69GOeBgiiE8OrA7wGSx8/r1tUP+hB7Z0ZWXm4YOfw3QOPKd+QIqB7oJEX
	 FE5D/QrvmpIDmk9VHv/V42IbqSveZV4ZemfHkH3tszj+2OWHci41giKBbWQqD0MZqq
	 wNKJpDG+acBx1UkxNlYrPcW+3SRPL80UthZAW/KqHplxb7ryGfdB31YWu/jdOSKrgr
	 5AKISE4wl8PzjdmzvYAFP9iH8y3p+Rc01wBfrldS+P1bXP/Ki4INGgF0PJa6ba5lKK
	 MiAGzMQXI/H+kkoyPoOwm4sAX/2NOtiOXVhnAI5EJlb0cwO5MX1tYpGz0gjF3fAKRx
	 0yrc79j+r9smxfaRlrEjTO5yaDG16vPhdgSfFn3/3gVW99Mp6hy0yOlxq1QDBWWqxw
	 CH1g38CoCTR1uCvG0LMbKyPP4K32T/yttwj7QTnB6BoEc7FlZJfvqwXYcAcctC0Vr2
	 wPPU0PawaTps0qk3yvPTEfc4ktmm1EPRk6517+ftTvOCJOVgTxn+IL++63zxCnlI6Z
	 CAiwYxMQF7eM9VVI4J/JASniUFmjtHm2PMKpLv+hylbLraBQUVKFUueWgmMI1+Xzi1
	 DQTf65HpfF5GrQsK7nvpSRjNW3tz6PPXhH+LKO+oiMmv5EEt2OitrmS3wm6GKoPOss
	 nI2Qpjr+OHKEptZKqajJkFZ4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B9C140E0192;
	Mon,  8 Jul 2024 18:11:41 +0000 (UTC)
Date: Mon, 8 Jul 2024 20:11:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>,
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
Message-ID: <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local>
References: <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>
 <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
 <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com>
 <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
 <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com>
 <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
 <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local>
 <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
 <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local>
 <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>

On Mon, Jul 08, 2024 at 10:42:47AM -0500, Steve Wahl wrote:
> So I looked at the code more closely, and I don't think boot_page_fault is
> going to work prior to the call to initialize_identity_maps.  In the current
> flow in head_64.S, that comes after load_stage2_idt, where here we were
> trying to use it just after load_stage1_idt, quite a bit earlier.

But still after setting up the #PF handlers in both cases. So it can't be
that.

> Is there a reason you want to avoid having these areas already entered
> in the identity map setup by kexec?

Well, imagine my one-liner worked. Can you think of a reason then?

So, theoretically, this should be reproducible in a VM too, I'd say. If we
could manage to get that EFI config table placed at the right address, to be
outside of a 1G page so that it doesn't get covered by a Gb mapping.

Or use "nogbpages" and then maybe perhaps with Ard's help hack up OVMF to do
so. :)

So, can someone with such a box boot with "efi=debug" on the kernel cmdline so
that we can try to reproduce the memory layout in a VM?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

