Return-Path: <linux-kernel+bounces-196823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460C48D622A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C781C21B12
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFCA158A14;
	Fri, 31 May 2024 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="O8jCgTB3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360EC1586D7
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159735; cv=none; b=EH+pduiErF+2yIHKY0jX63Au2FY3QyPr1Gv55tyISWgvfsiMl6B1JQu7SVE23edsFX70EZyqU0N7N+5goDP2qyc2QljdbE564pY8x0WQPAR7pvx2lwIDp31wQwwJXie1KTun7MItzvrP4/PVYnQncdsBESpkPDEM7u4JpkAEGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159735; c=relaxed/simple;
	bh=iiuNGBj2BQDkNZVFjcFc9hllPApGtuUWnv+F9HYgOWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrY4V+DPuQmEO747w53632Om3AijXLYtOxsCjrngTkWqoxfcCC7bvbiGHppfMgseUhK0hWkN3Zupzyy4CsDrwKz6t2ebDr0I6EjtV31qflV7ZV2wG7zxARhA6BkGAdp8QtFH4XFzozK4hmNFs0Lagc884yr8zSTx2lV1+CMKS/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=O8jCgTB3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 03C2040E0241;
	Fri, 31 May 2024 12:48:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q1fJjZY8sWNT; Fri, 31 May 2024 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717159728; bh=TY6VcibxdweZqQIFn+missxQLP+1JlXnv47ORNzMTiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8jCgTB3M9+aX8bNkwCg0eDZjy3e61S9TpWBS4rXqtIFK5tHcEisjKoDJkMKniRTt
	 J5tKGvpDW9cyPvfbHuYGCB/5StUYCosPiPP+kLK5WSKrTW/suSamhrl2y93/yZfiCZ
	 urjJFBvdZ9C3QiOaNz+wKLSBOj4eppaBXXQanyV/fBDqkNWcu0Qy1swCjsPJaW/diT
	 z3nbzVfAM27LJKIVeiaSLd76N29aLGFcIl4dIEW9ht8BKSiD49R6BUsKylLg+kLZ/H
	 3INm01Y4fKvSs0+JWhhtEwXWiBZHTMOIaY5OIhkL5L4qDDkaX3+JY6PRqr0jW+VLTT
	 sJLJrNwZuWhPiRTpBLWeS7yHtH03dutxd+uhRAJEGpndy/xNlJlC8iClHA2LiT6POJ
	 NHJVDxGq6BfZgf5NiCwMbMlQqsWxahJmAKe8IT1rQzMHo8N93slh21gHEEgc7kBuW1
	 DplDRryDV73XWsPJZ1TV5h6iOyU9oS2XE1Xq14OrGMGruFX8YEbhB5Mteb/uqkrtyR
	 y8DZCL6zFAMFHdKl+LWPQoOs2/mvrEHhEUDed9TvVvx65XRcIi3FK5dfnXVf+iSfv4
	 ELhhHEYR2X7Ocm0u2G/zjbHViL+d7zas/uklR4VmP604uKOmr4V+LnCdp3Gpk6lDjX
	 3S8VCws3pa+z7iLCS6KlQZQ0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4D6240E01E8;
	Fri, 31 May 2024 12:48:34 +0000 (UTC)
Date: Fri, 31 May 2024 14:48:29 +0200
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
Subject: Re: [PATCH v4 08/15] x86/sev: Provide SVSM discovery support
Message-ID: <20240531124829.GDZlnHHZnj-oByMTIK@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <0b460ba621d39fda47694332f09301b440619efc.1713974291.git.thomas.lendacky@amd.com>
 <20240527131022.GAZlSGPm_s0FAu_BRB@fat_crate.local>
 <ab9e93f0-132e-b7cc-48e0-f83463003e21@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab9e93f0-132e-b7cc-48e0-f83463003e21@amd.com>

On Tue, May 28, 2024 at 03:57:10PM -0500, Tom Lendacky wrote:
> The alternative method is really meant for things like UEFI runtime services
> (which uses the kernels #VC handler), not the kernel directly.
> 
> Some of those checks have to be made very early, I'll see if it is feasible
> to rely on the CPUID check / cpu_feature_enabled() support.

Put that in the commit message.

> We can separate out SVSM vs VMPL, but if the kernel isn't running at VMPL0
> then it requires that an SVSM be present.

Ok, I guess the two things are identical.

> I'll incorporate this, but probably won't change the way exit_info_1 is
> assigned.

Oh, but we love our '!!' construct:

git grep -E '\s!![^!]' *.[ch] | wc -l
7776

At least so many, my pattern is not precise.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

