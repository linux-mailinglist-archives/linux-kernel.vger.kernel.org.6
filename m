Return-Path: <linux-kernel+bounces-245482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C281992B322
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389631F233FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD7B155744;
	Tue,  9 Jul 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bXSSD5Zy"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2564B152E06
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515826; cv=none; b=h7cmIs4BBvvpIMpQ1KAWJdHnNa1Vg/ropZrIPs18YUWU+sFUVHV4/erxsFXLFObmGd+Ut1Xj0Oj5DojEJlxP2B9EZsrxmt7CAS6jd+6DHQLLlTVN7F6ZrjfCeWQpbbAC9eI6My3j2Ul83MW/sg1wtYUwvRUmqql6ifgydNtcBAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515826; c=relaxed/simple;
	bh=Be0OxpiF4l0g2Nx0Zup/E/OnO4lWax7/UPJwkt/ZAj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8WC9mD/ysmqY0+GHWiCxfIzWy7r4lZxDzTGA0n3G9zB21tViJuryGd3mgj5IQx1s6RbanTVoylDOWWNb8P+cJIczl3d61y5Z5IyMI1hzqy6vLXZGn8mcHVzqElHzLESnsx/A1I9E7ye9915VehCfVl/VkzFl5ygIEfJ3TJyc78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bXSSD5Zy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B2A7640E0185;
	Tue,  9 Jul 2024 09:03:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VZLJ0jV_8muB; Tue,  9 Jul 2024 09:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720515816; bh=xFWAiSJukpl6RZf0FetnsddcwaTvZjDXqv9fR7Y10Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXSSD5ZyqmN1v2/WtDpOXiJpUno2brEr2I++pBjkEZAF1G+sq5gaes6WBfz0cR6hw
	 Jsh3Oo1TrSUuL70AI1M1ghI636uq88Bp1x/x9938Bl5tKPd8y257TVuCjEdFa5Y5dv
	 s0YPM7UX/t4T6mDYZpqLaOsarWdAaTCuR1b+XuM0sn1OJvp+fHvRimCWUwCr7rpFEc
	 +ey8TzNaivj/zUhzyA0oopysfOtGO2fG+Et6NHXpuAnanYjgxhFOpPhf4ejEvxUX1v
	 i7dNB4sNoIvhO9qKwUCiG4rFh899A6QyiqX+tCBD81LKOBUogOTDyHhy9rAgULsK9X
	 wGMP+sgUFKHLsepQn6XCCFkmM+axvUp/BRowPi/Ch5CizD+/DVOeEx/nX1oNbgl2wd
	 R6tzveXkTqEXuK7yVkbe+MaaKcv4l1HTgq9Uij+6VnRZR+GXokPYKSBY8msIO33VAH
	 y9GEj4DiNrKNukZOOfsCLL9f83jdAIYqchMPIJMqy3quK+6rOYFeV7xg1Ee+qEtGIL
	 ypD96JBlGOSbOgsOvCmDCX6IxNxp0eIYQx9/pJREefAGe6uKK4Bk+UQEoeksFdqtQa
	 6DpUKRwLVlRiXHzwZor+JiUognWy1iALSs1EYndRhqNigw99E+3NQ2uPIyLuajJ4Og
	 kFkmz5dD5Y3OLBd06LnQQxnQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8D3640E0192;
	Tue,  9 Jul 2024 09:03:29 +0000 (UTC)
Date: Tue, 9 Jul 2024 11:03:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, Nikunj A Dadhania <nikunj@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [tip:x86/sev] [x86/sev]  06685975c2:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <20240709090323.GAZoz822G64Mr9M9lV@fat_crate.local>
References: <202407091342.46d7dbb-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202407091342.46d7dbb-oliver.sang@intel.com>

On Tue, Jul 09, 2024 at 02:43:29PM +0800, kernel test robot wrote:
> kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)" on:
> 
> commit: 06685975c2090e180851a0ff175c140188b6b54a ("x86/sev: Move SEV compilation units")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/sev

Does it go away when you try two patches after it:

a7e7185ccd2a ("x86/sev: Move the instrumentation exclusion bits too")

?

I might have to merge the two if so.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

