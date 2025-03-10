Return-Path: <linux-kernel+bounces-554050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E68F3A5922A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE46167A20
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00FE225775;
	Mon, 10 Mar 2025 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PbtAwsUG"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87A17A2E7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604548; cv=none; b=JdaOR9gr2t6+l3pJ4l8jW06NS+GMQ1lMcrAjjYkQYzWstyTf4TsbP8+1WtUrBNIvmjCkYjXH77dxZk0ekL9B9SmyUWkQvyFCztSuFyvnYV8/+R6KFCIFJyR5qUq3uEwyrmt/hanGOb7qQ7VxkJZuXIda0PvQWVdegjAsT8YLFko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604548; c=relaxed/simple;
	bh=9c0pogv6+pgnVH4UVm5hFkIsP+ctZeK4oklW2cMVsKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NW5sZ2DqbK3hcJXUcpbFkSV1xItWYmyi2UHT82pHzW250ni8Tmcbmxiwd/dz29jgM13Gk8+XHLq5S3UDhOl3nkt8tEhgVqGsQ52F3MKCrSboAhHmfwZFnH4QCsS7MoI0rrjDAw59MkOCEQEWTs994WVep7Mk1ILF9HR+zB8kIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PbtAwsUG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EC88340E0202;
	Mon, 10 Mar 2025 11:02:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HlT8alIDAqO8; Mon, 10 Mar 2025 11:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741604539; bh=+7YrF1iHbAng6oKRbPTV9bQ6SamyZ5P0YQHkrJk41Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PbtAwsUGxG5rKb/54fVeLk9kr1gnJtjwV4MlnDCiwwOGVBBwIiuYaphteEDHT/n8H
	 ohM3Q/lBoY7h2PTH5KgPqQxSzzTvPNalJXkTdL8nO77Lz37P2OErWcv5ItAzbiacvD
	 aTbKWKLFqYhDo+mSyvMf0PaUggWnvSM5R8P9noOFoKJBd3uIO7z+AP9URiU/JmfMPW
	 PFBf4NR6L7IDpcN2jujt5dr+1BAoFx4LuD7DtI9SJiiZ6Br4Q6oUcbT6cFbDlVL2NM
	 zoP7zaUt+4gRL7QWtw2LFpVUPbXoZ5SKr5CNDZNLzEpVrWjC/HWyqwGrzENhNG3jPu
	 qcF7lYhAG/h3yxYz0fphSV0QddqhM4GkmV3meubXbU7U3YIV4woluRD8dF7qnmIXAG
	 HgKOWt/Ev2HA/kTPWirifQRj9WADw4nvNkOFWt80MoZFn7PV4ifgEyyZW1F/PyRSQd
	 c5ObyQRLkYLLBiTK1OC0XehaaokOSbf4eICczfgLgkgWqsXhIOQt6Yr4UXdnrHJM2z
	 MEZcRWFCMavO0IhnMIkftM/BeSEcCy6/ThqDndIDjtfzWI1mJP30TnK8qMPagtCpYz
	 ZKUj1bWRGnDzcuxrKzMycRnmtX29f5dOqFy3YpGTdRvKIrBtIAN+O/5udAH9Px5WJn
	 HxKtwkB2CLxH2OribfPHj454=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B28D40E0176;
	Mon, 10 Mar 2025 11:02:07 +0000 (UTC)
Date: Mon, 10 Mar 2025 12:02:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250310110202.GEZ87GqgEJyhJtde0I@fat_crate.local>
References: <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org>
 <Z8l66FFgPu5hWtuI@agladkov-desk>
 <Z86-3n1-MArVLM9Z@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z86-3n1-MArVLM9Z@8bytes.org>

On Mon, Mar 10, 2025 at 11:28:46AM +0100, Joerg Roedel wrote:
> So on a second thought I'd like to vote for the /sys/hypervisor/
> hierarchy. The `firmware` term is a bit amibious here, the TDX module
> can be seen as a kind of firmware for the guest OS, but realistically it
> is more like another hypervisor sitting between KVM and the guest.
> 
> Also the settings on the SEV side that need to be exposed (VMPL and
> SEV_STATUS) are CPU properties, but on the other side also set by some
> form of hypervisor (either KVM/QEMU, the SVSM, or some other paravisor
> in-between).

Dunno, it still reads weird because if you wanna put guest-specific things in
there, /sys/hypervisor really sounds like the wrong place...

> Overall /sys/hypervisor/ seems to be the best-fitting location for all
> this data. To avoid ambiguation I propose:
> 
> 	/sys/hypervisor/common/[coco/]tdx/
> 	/sys/hypervisor/common/[coco/]sev/
> 
> Using `common` makes it clear that this directory does not point to some
> sort of Hypervisor, but to data common to all hypervisors. Using another
> `coco` subdirectory is not necessary in my view, but if people think it
> should exist I am fine with that.

... or you can drop the "common" thing and use only the "coco":

/sys/hypervisor/coco

and then you kinda denote that while it is the hypervisor hierarchy, it is
related to confidential computing so it could be consumed by guests too.

But I still don't see why we can't simply do

/sys/guest

It is just another sysfs node. Or is there a particular reason to stick to
/sys/hypervisor?

And putting it in sysfs still doesn't solve the human-readable aspect: dumping
a raw SEV_STATUS might as well be simply reading the MSR and if someone wants
to read it, someone would need to go count bits. Imagine the following
scenario: a user reports a bug, you say, ok, send me

/sys/hypervisor/coco/sev/sev_status

you get it and you dump it through your script or start looking at the bits.
Yeah, we all have scripts for that but it ain't too user-friendly...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

