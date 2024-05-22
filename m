Return-Path: <linux-kernel+bounces-186546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353938CC575
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF798284484
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9741420CC;
	Wed, 22 May 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cMHO8hH4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC4C2B9C3
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398672; cv=none; b=JZ/MbGJuSWpMK5Nw7DCl2auXF2DwSwN60j+996cTPJUx6LLw9Pu6cVsZ2QRKK02tU2tCTJY3BsXehvrWm43GDymjE99rdMGUiSMS1zEhm1VCZLFLw4eRZUlnZWyWQiI0waLRqjtO/02knhgOSfRBffvick5QaBp889tZKKalCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398672; c=relaxed/simple;
	bh=hP1Z2FDFPH5zL6xA1ZQbp/UR/Dfo+V9WY/rhd5xdIsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NR5f2i9ka3FiY0tjesX4rQTG54akkH7w/unh9YJvaZEc3bynhaQM1J192sjd40BXmAga4uIgMvbPROvWAj15ubtVGnxpiftKUgiNCjoaqVs5wRyhl52l0Q+B4jSna5+KouJX9TlAisQSVJvp3X0bRhUzFuy2GLD7lY43iBJs3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cMHO8hH4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6EB4940E023A;
	Wed, 22 May 2024 17:24:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YE80kfy6i0mS; Wed, 22 May 2024 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716398658; bh=OkmktzNc00ntQw2BsQ19qpyYFz/AoKH6dxQyfRiptFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMHO8hH4ssfSqsU1OAbbgBrd4Ma8Tpbb9JDVoOyTM1oYRCpfhcM0FNJxYV+uSuKTw
	 zXOft5R97zUjo7bChKgNqIJMeSFxpqsZpX12ehTE09SXjuA466qY+NeTraP8redG1O
	 XvAwqJc1CqdSNakpIeQx26CNAjyA8MjFZpZCHLGcIU+iJoqtMgiqZxoYultTyW3qZa
	 91L630VPsx00LRE/TRMIfkMRV/NSG64wIG9xgosCT1XVY1Zg1WFYBZ0wR4YzA6oVYJ
	 9rBpq0l0M65R8yDqYdTUHJEvKhXHBJHqdnXRt8X5AO5BoUll/FuIl8/WskxSULg207
	 IeVdNqM+hcIe5/RZlYwbTjQdEN6oyQE6HXI4jc45VwFD7+zasQ18s9PXp07iSCT+dd
	 gt14eXb6YNIs16pcFm8Kql+dlLVJ0htx3Mh1+AyWtGuWvl8MvJdoZTazWXmPxHgTVw
	 xH1AHivx9+9UEsjhmZRDpu0erAD6EQd4yutl8BH4I8PraJb5J2KzUFPMnC2T0dCt5D
	 l41mhg9OqN2CUoeK025VRDHP1uZKNJB3qhn4+bVuelvWAcEgWFiLQPw7whbrRJi8R7
	 G4w9kvLMawU0fDIw+tfo8EGAC1sBV2UuGK84h6K92yst+4JGEJZf0Mw4Gttrz50/KH
	 C1vbb/Dzx6F8lI7dznbIdieE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF42440E01A1;
	Wed, 22 May 2024 17:24:04 +0000 (UTC)
Date: Wed, 22 May 2024 19:23:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 04/15] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
Message-ID: <20240522172358.GEZk4qLmzc0HklUsaL@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <6cf54cac47f212f4c2b59b123855d8c183989022.1713974291.git.thomas.lendacky@amd.com>
 <20240502093520.GRZjNeWLXU5j2UMOAM@fat_crate.local>
 <66928741-aa5c-4bbb-9155-dc3a0609c50a@amd.com>
 <20240517155858.GDZkd-wkWmYegos-eT@fat_crate.local>
 <f8a92b19-9090-40ea-c2cf-707005f583a5@amd.com>
 <20240522152712.GBZk4O0LIl2r0dH--H@fat_crate.local>
 <db4d1dee-b25e-f28e-e8dc-9c9bcce68dd4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db4d1dee-b25e-f28e-e8dc-9c9bcce68dd4@amd.com>

On Wed, May 22, 2024 at 11:15:28AM -0500, Tom Lendacky wrote:
> Or what I originally proposed:
> 
> 	if (!IS_ALIGNED(caa, PAGE_SIZE))
> 
> Which also works without including mm.h.

It works because of the same nasty reason:

$ make arch/x86/boot/compressed/sev.i
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CPP     arch/x86/boot/compressed/sev.i
$ grep align.h arch/x86/boot/compressed/sev.i
# 1 "./include/linux/align.h" 1

The include hell pulls in that linux/ namespace header into the
decompressor. Which it should not to.

So no, please use the open-coded thing. I probably should start
untangling the decompressor slowly and do small sets because otherwise
this'll never get split properly.

;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

