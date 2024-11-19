Return-Path: <linux-kernel+bounces-414177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135D69D2453
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A1CB268FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BA91C9B7A;
	Tue, 19 Nov 2024 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP8UbEcU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BB1C4A0B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013763; cv=none; b=AJjBcLcxwepPtnlqGuQkoHk8ujqbDOgdYFtENYcNGrceHjxKCWEjP6v1YB+JsrUrVN75zYIX3Kk/DS9a9y6WQn45o5I0J8v7cbyMieEHGV8rhxcGABOaJeDXp/J54xkuhhgCRiwt5mlVLTItQCPzI7MlfiC9K1nHb3aQC70NdeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013763; c=relaxed/simple;
	bh=sZhya7dJN7fSueqddx3nsemrQDCDXWzo7Or9nNMJmsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyE2wmwiGi0cHgqi0Mn4m0/2I943qYzMBFUy1aEhomaddzNv9LVIbJEMmNAUVv0masxG0Azam/8Z3doHe9xo2wRW9MEAzJ8EQscPJ66wChp4v6O3PhksS7pyzV5mBfoCf/ilwP03WqPHTeQM0ZNtmpEXxij9AqiC5gJS6FIuFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP8UbEcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABBCC4CECF;
	Tue, 19 Nov 2024 10:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732013763;
	bh=sZhya7dJN7fSueqddx3nsemrQDCDXWzo7Or9nNMJmsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TP8UbEcUBG+vykgtUUQ7PzP/cI6pTlMw3cP184PK9EPIakpQdwPAImh38p3rtPdFu
	 UL6EuO+tGVqKpU0nRbEF87Zd6dxJJ7V8CM5AULPmjIa19id7rrEosvy5b9F4FW+stI
	 waLBi9iwDi7AiWUFuYj7oBc3mcjsNF1ozziUpwsbBkg4CiqHq/8uDPQOk5EfFFCwnn
	 FR2xYJpfJ05UYBrKbwXnwhEBkEj4vDWSmCk+txUbJl7frNN/hkuHl15bUvPIEz99Al
	 W94ifwt5N+JSK6UoqOxLmE52VlBirBUSL3y2fJRmRH9GMW+KEX//DOGCRs6C9lIpvu
	 XiPHTowFMsLcw==
Date: Tue, 19 Nov 2024 11:55:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	bp@alien8.de, x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/ioremap: introduce helper to implement
 xxx_is_setup_data()
Message-ID: <Zzxuv3FFmCxmTtS-@gmail.com>
References: <20241118010819.46602-1-bhe@redhat.com>
 <20241118010819.46602-2-bhe@redhat.com>
 <7cc5e26c-42fc-a700-ae19-608920cafe44@amd.com>
 <ZzwA53x3KYQgDbeQ@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzwA53x3KYQgDbeQ@MiWiFi-R3L-srv>


* Baoquan He <bhe@redhat.com> wrote:

> On 11/18/24 at 09:19am, Tom Lendacky wrote:
> > On 11/17/24 19:08, Baoquan He wrote:
> > > Functions memremap_is_setup_data() and early_memremap_is_setup_data()
> > > share completely the same process and handling, except of the
> > > different memremap/unmap invocations.
> > > 
> > > So add helper __memremap_is_setup_data() to extract the common part,
> > > parameter 'early' is used to decide what kind of memremap/unmap
> > > APIs are called. This simplifies codes a lot by removing the duplicated
> > > codes, and also removes the similar code comment above them.
> > > 
> > > And '__ref' is added to __memremap_is_setup_data() to suppress below
> > > section mismatch warning:
> > > 
> > > ARNING: modpost: vmlinux: section mismatch in reference: __memremap_is_setup_data+0x5f (section: .text) ->
> > > early_memunmap (section: .init.text)
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  arch/x86/mm/ioremap.c | 108 +++++++++++++++---------------------------
> > >  1 file changed, 38 insertions(+), 70 deletions(-)
> > > 
> > > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > > index 8d29163568a7..68d78e2b1203 100644
> > > --- a/arch/x86/mm/ioremap.c
> > > +++ b/arch/x86/mm/ioremap.c
> > > @@ -628,12 +628,13 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
> > >  	return false;
> > >  }
> > >  
> > > +#define SD_SIZE sizeof(struct setup_data)
> > 
> > Nit, I still think you should use "sizeof(*data)" in the code instead of
> > creating a #define.
> 
> Thanks for reviewing, Tom.
> 
> Boris suggested this. Both is fine to me. If there is indeed a tiny
> preference, I would choose SD_SIZE. It's going a bit far, but not too
> far.

Yeah, I'd prefer Boris's SD_SIZE suggestion too: while *normally* we'd 
use the 'sizeof(*data)' pattern, this particular size repeats a number 
of times and not all contexts are obvious - so abstracting it out into 
a trivial define looks like the proper cleanup.

Maybe such material changes should be done in a separate patch though:

   x86/ioremap: Introduce helper to implement xxx_is_setup_data()
   x86/ioremap: Clean up size calculations in xxx_is_setup_data()

... or so, where the first patch is a trivial refactoring that keeps 
the existing patterns - which would make the series easier to review.

Thanks,

	Ingo

