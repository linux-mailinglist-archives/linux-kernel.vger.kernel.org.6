Return-Path: <linux-kernel+bounces-224810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6103C91271D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C051C24B38
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789381B7E4;
	Fri, 21 Jun 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eiKTfF8+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B7617C7C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978395; cv=none; b=t1zTuLxo1+mSGNyouR4IM5YRK6ab4rnPHaWNrr6ImfmraHxPG58I7FUer4V+TYvltEcsQWO8/Z+sfcRi4WcLqDlg6WACW8J5I6ux2duQzx0NAp8ItApMl9Yv4f79CADpFY61b97MuC30BMxcFIXqQ6NaTi7UMiNcoduqBIemU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978395; c=relaxed/simple;
	bh=R6thlS0x1E1zBTrrCYsgnVo6p2konSAE8rI953pepXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caFvvKulN3wic5SZa5gk4PuQbsD1XWTAtL3IU3CuD4aVa/esNbawQEdk4oqwjtrQm7xZzdQFzxEPFKUp9Jy4Qil3IQkFzm8hR/egtWTrCiwACtMYNaJzRXToCUt7TH6pSPdsUMx/SLs728LTuwoHZ6YclM92j48UhnsHAgFNlAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eiKTfF8+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EEA8A40E01D6;
	Fri, 21 Jun 2024 13:59:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ygjh53uCUTwV; Fri, 21 Jun 2024 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718978388; bh=QrRynN2EKbRX+uPBHkN/98xH4MMeOTgGtdCfaaNvi9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eiKTfF8++hvGlczD6asPIb2yUjNMSdu5vFh9qN93TFVipd/Oo1/mDxUzuocSfA+vq
	 RfU/mzBhZYGUGYrVtamU6meH6pzhJxpQYFeFItjFQe4olTRdbF9YTh7ak4IthEVsrh
	 0/aKgpnw79qaA30AXp5ahbxPTY8TIXT1rY3ueHMnGuxMltcSgOf4ZWKxlKjAq0C24G
	 jkjj5IsUPAajZqtK+f3pXCm8NnY7seNIqID6+WHP4xdJJ/SVu/8LChlrVijWf6lsgb
	 tZVoLIkCpFA0qyKXLvbWP07JTai5/bvdGelNdu6Bqe3HGpI0Jbiyezet1T+Erfb78W
	 uXkjL53V44igFjBbshCcCGaBbjD8405w/bbTrsIT7lR6n1rShjBCjPy5yCgsrDR4DX
	 z3OvW5UYegxjuCv/yz1NbvSdJIuLUtO7V4laT4ADTI9hCbnBy95vV30pYo9NIwhHoU
	 XoFeN0ZKjDUgWNAZwX8POjM/EJ8iBlXudXCF5TK0IB7QPle3ZCBxThfEQqpbP6H6fb
	 Rpp4U49+hgFNSUMq3L0dXrsqgNNJFYawvENhmp9BUT+bp1kfSJx1G27/ogjZkiBW5o
	 mNeXsvxeH3OQmrIy0spP9P3Sz5PknHGe0jXxyjUBaY1SS6IlLfmVxDnq0goPgx5LM5
	 hKKibroyA7zcoNVTA8vVKefY=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 997A240E01A5;
	Fri, 21 Jun 2024 13:59:40 +0000 (UTC)
Date: Fri, 21 Jun 2024 15:59:35 +0200
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
Message-ID: <20240621135935.GGZnWHRxn08g8CkLNu@fat_crate.local>
References: <92b4ba20a5afeb4aecde167bfac094d0275d8e1b.1717601917.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92b4ba20a5afeb4aecde167bfac094d0275d8e1b.1717601917.git.thomas.lendacky@amd.com>

On Wed, Jun 05, 2024 at 10:38:37AM -0500, Tom Lendacky wrote:
> -static u64 probed_rmp_base, probed_rmp_size;
> +static u64 probed_rmp_base, probed_rmp_end, probed_rmp_size;

Why do you need _end if you have _size already?

IOW, please compute _end where you need it instead of adding yet another
static.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

