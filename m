Return-Path: <linux-kernel+bounces-224903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC82912870
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07E51C20A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017822C6A3;
	Fri, 21 Jun 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kCx5sqFx"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC03631
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981417; cv=none; b=kHUABCEenh3Jw+lYIBJzxtloC8TQvyuIWNa1Ts2ndSQmDCPnHHQ1YKfRUueMB/EVkZkFpqwNgGERDPBW6V7JkhVNG9FACFm9KDOWECpmlSez82bwsi6o5v6H9BtaVqshmIifV0Kp8UaADCZaNyaD0TILhqijk4pN8zo943x432k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981417; c=relaxed/simple;
	bh=DOoU8myoV2Uurk0i7zR/6lzKf0ys510aSQbKxhddcJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDKC19VVnpeBuxJEgvEGgD8sS+9wHnUFEI2bhM7quySl8KdWbJgTOW2CoHwlEJ4Rjdn+gOt9wJxvQpwOtUAm6IIsgj12OX/XiO7RvOuaqOZrDaO+zL29WugwYC1C5IZfCWFFlXiJJTVHRvAmH8YNiQTj+OqYibDasLElWGR3FYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kCx5sqFx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E4BB040E01D6;
	Fri, 21 Jun 2024 14:50:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id h9M-QsiuJkzF; Fri, 21 Jun 2024 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718981409; bh=vltHNAer8E5AtzMA/n5SbWrhcqDi3Uw/cldbjoibJsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCx5sqFxF1xbwUhNzDoIkUiMDK5y4nChC93ZaTMfWRytS37kfAytlbtMVQIViXUVw
	 zfodCmyGSYh66EaMyBRIP7ZWavRnkjhPXO2qlJ6az8fZY+B0XCbXPFEiAIkTkpBVED
	 Aqb0NQnUlYCm7JRvli313DKFXBe2AjxX+TBJTwyXxjpYy0TPyTFcAz2UEwGjf2fo4F
	 Xqx0EFhNx8qO/8OAXzO8q8oFDHAmdE+fjoxmpm2PUuAFbQZRNR8bGUkmJFT3bXk2Jy
	 rnHl2t6E+5wheT+TuiWSFzWwfEP6Je+AW1Ywts7TazAzNuMW9yRNc5amyLGa6/9j2y
	 88vlPotCLGl3qgQKB46lAXKJsiJ2MvK0SufUigb6zPvuUzZ1ompOhgH9Pbf4PR1hBG
	 yBIrO8hkeuHYqaVBg+8DCwnj7FJN/GQk8Gs2/Qmb9abOTtiEKbC3T5vZyamG6yWGAu
	 9wgF+oSu6GMQY+f3G165f+RS70NwnyvcWkYlD5DWs69d/E7hmq8nnkvpUrzBNUg3tR
	 wg8F2n7X6UllbsBESNV6Y9O4oueTEEsDrrNQMMmq8xE2dIYGZDkYL6jsPRkaMEEdy7
	 w8fFyTlK4iyNTSUvLPdFOVQ4HaYviOwwqbNaTf63aa0Drh5u8n6gB96hSizDbnufgR
	 aYFdFh9ayG9bKBtSGdnUSyEI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55DB640E0185;
	Fri, 21 Jun 2024 14:50:01 +0000 (UTC)
Date: Fri, 21 Jun 2024 16:49:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH] x86/sev: Do RMP memory coverage check after max_pfn has
 been set
Message-ID: <20240621144956.GJZnWTFLIwvAxy7bMr@fat_crate.local>
References: <92b4ba20a5afeb4aecde167bfac094d0275d8e1b.1717601917.git.thomas.lendacky@amd.com>
 <20240621135935.GGZnWHRxn08g8CkLNu@fat_crate.local>
 <4c4c8208-7194-79d0-a9cf-e625e5feff23@amd.com>
 <20240621142911.GIZnWON-Pgx4dSzlGZ@fat_crate.local>
 <187a0e4e-6e05-7da2-37bd-d75f9a6034e3@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <187a0e4e-6e05-7da2-37bd-d75f9a6034e3@amd.com>

On Fri, Jun 21, 2024 at 09:37:46AM -0500, Tom Lendacky wrote:
> Ok, I'll remove the new static and resubmit. There is also a logic error
> in the original check which should be using PFN_UP instead of PHYS_PFN, so
> I'll include that, too.

So we said this fix should not go to stable because SNP host is not upstream
yet.
 
> Do you want a single patch or two patches, one to fix the PHYS_PFN to
> PFN_UP and one to move the check?

Since this is snp_rmptable_init() and that is also SNP host then I think
a single patch is fine.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

