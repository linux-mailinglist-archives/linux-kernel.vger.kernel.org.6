Return-Path: <linux-kernel+bounces-527976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C471A411EE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 22:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908B01732B9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 21:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9115A2405F5;
	Sun, 23 Feb 2025 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="V9OUaemJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD713E40F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740346202; cv=none; b=Gp/32l8ZnYdMlM3jPL4Jyq8V++4TTtvJO1vaaThcV7EcAyXEqSAUQ8r0YiFZD9Lj1ywW6xIaimscr2i4tRYAswVs1diilOj2hhGUgt1WlhhxoxHusrlV1/ygvl2JbayZ8Hn/8zNv4EFNzFb2QXT8TNfSduJqNU79LIc7j3EFvdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740346202; c=relaxed/simple;
	bh=4L6DSnz+tObCW4PmaZf0qwsIRphrsUwyuTj7I/5cLps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKi/4ZV3GHr8DGLM6HKg/jfpgqj3/z2ZcrFxGwV1Vblq42zujWc/xWB3ooxft8UukP80RA/NgpBGdB1DKhX/4DRO2XP1N6HnCQegfb22ni/tuq1fxTvu229QQ4IHwWfB5pSzZ1+osn2bo8NNMJWDD5TjF2BtMa/OZ786XmvOJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=V9OUaemJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0763A40E015D;
	Sun, 23 Feb 2025 21:29:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id v_c-veJ0AqzT; Sun, 23 Feb 2025 21:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740346186; bh=Hc5yFnWzGsBkVlSfIJPlvS3P8iZU5vXLB7RJIiiBjqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9OUaemJc87wfNuIjd9bU7Iofvv3ddC/4iSPzhbvs5V81SMejlNpNYYYB5COvgIAX
	 tE4IXdHQSCD4e24o7cyfGd1cq9wKlgpPPUbjOad1OIjCqZd+Uajf5ZPWM8hGtBSuGF
	 BdhIJtUu7XWmcCsTEkXd3RSy2EcWnksAJ1CNTlHHCvjNds5aHBeRleZqSPwYKbc4zH
	 IBOFfL6nEJabZd6aDI8BqTrOBg5dDj5lPTLTUE/I6h92uZrWr3gEDPfSJAVPshdcsV
	 GfVryXs58xTwe9gWgCsVl9YohDEKT22UjvF6kehkJfjJrhRHIK9FNgAsUnGFoMF/9Y
	 JwoU9YDMWO6qagpT4Sro+S+7j/gKQo/BRsqOB5cujalqWyCPPIabMClt+0gvbqzKQQ
	 SEG0SU/se6QA1B9ywek+DLTqZ+sIGZ1LCFzDRBiR0frhMcVJyIS4NWu/hiQP2Jo2JN
	 rcWYTXj1u/SeIfI7qKmINukDBNTMmsAvQGusdY9WYeXaU10qssMxJBAI6PyE9lHY1N
	 7clkgiQSjltofzEcUfNKYRmZCZ36ZeFMtgM/b9SSVKIXn/Lhcrz1ikz+qEQ10XPAex
	 vjJSdJGBy1P3Fj8qVu6WzBkEwapOn7pFsH4/yMCVf2sKlxUC2lqWqA1YcLBFKkjIYs
	 gRuFfuLDSiI6vhoWRa6GQ7Hc=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87DD240E01A3;
	Sun, 23 Feb 2025 21:29:29 +0000 (UTC)
Date: Sun, 23 Feb 2025 22:29:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v13 14/14] x86/mm: add noinvlpgb commandline option
Message-ID: <20250223212917.GAZ7uTLZL7ygSHayYh@fat_crate.local>
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-15-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250223194943.3518952-15-riel@surriel.com>

On Sun, Feb 23, 2025 at 02:49:04PM -0500, Rik van Riel wrote:
> Add a "noinvlpgb" commandline option to disable AMD
> broadcast TLB flushing at boot time.

See if clearcpuid= works too pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

