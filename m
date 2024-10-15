Return-Path: <linux-kernel+bounces-365939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEE399EE31
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E7A1C21AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5EF1B2186;
	Tue, 15 Oct 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jdkft+J3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6209B1AF0CD;
	Tue, 15 Oct 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000385; cv=none; b=aVsgmHQdPsMXfy6+r04jqCMZV/DZ2a+aDypda33fVOuc2D0w5ZVd3XUpQbFSBzXp1MLKggsOozdSffU3vOH2dXIa02kOOQfHigIYB/EWcUwQWlMWXcstJsxA38HIuxqFpdLOUJRJUU2nnTaaBbshik4mvZr+GE/IvKuCvDgEMoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000385; c=relaxed/simple;
	bh=H2j8tAxArH59yBDbzIrl/MGCWx5bBjQgQoB0i4mdJuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl3wNXJNTA00d1Jcp+t+Gb6MCYUvXpC6IQYfjjjFo0yPC24hPuXQXZtJYQFbUIzB9HY1GDEsOdGd6gABLlh7BMeu4/D638fIy0a2dRu5wQb4/rNW3z2sFWXdBi8jTcZBL/XQbp8qvd8pmNSr2oeGC22BVOdI5WfwrWr7MOtQyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jdkft+J3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D8BF340E0198;
	Tue, 15 Oct 2024 13:53:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fRYxJ-Jjmc2o; Tue, 15 Oct 2024 13:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729000376; bh=IndR389A56EgJLmSWnnTj3gROCafm4Xdw9n+uR2RGCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdkft+J3SSI5ZXcvcV/k5hX3cOtNWyBIEvTpdM2GoZrSE/jn4WoU69GIN4e52j/wq
	 /PRHj1ovwgYX7fRy9ZthF0WRFR/6vxUDs5SfOsdLV4l86xTmEyE3MUDYuPXcJD5j3M
	 sNij5PdsnkO/psDzydolB6nvMkepsXfV5JkVJpKo6ImwvqO9oH8XoT+QA34wLpwlxL
	 /EMfBxinh0RQSy1R5NQpJGrjAyrxq2YiSi7oPQp/DUXXIBRpVw/jeeAzsP7SehrQoN
	 arRDdbAyDW3xsxpnJRDYjRX3+39kSTLk0uM0yaevYUZ5e3ZnTt2RP0brVd0gKJYxq/
	 u6Isbz5PPh/lGtgo+3R7vzfEMvvB45fW4yr9N5aseWkDXfJsFXs761FrHdsZsTKNcz
	 yicGbCQd4GWmYNKS5V4aoDSjoLocyMCRcD/2pVYqwFhQ8azfsU7l5knK60zw6clpJW
	 BRC1QYxVgI5zd2KOiO6NJW4ftNrb2KQoarT6nGy+kTk4NNNfNZbQbaZZchKgEzeRgl
	 4HZTFTjS/svrSQDPapdTDTHPOOaM8/FE2TidJjbw9iEycQScZqWvXxUqR2z0JqdPdG
	 6R/1Y5JLlKPdlVVKiJDYmhV1nU4marIkRR4GtOevV1yw8eHuKhBXIpg3l5hs8RC4J6
	 QI6uqckTWiOyOkTlrhjxZZ4M=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 576D240E0169;
	Tue, 15 Oct 2024 13:52:43 +0000 (UTC)
Date: Tue, 15 Oct 2024 15:52:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kaplan, David" <David.Kaplan@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
 mitigations
Message-ID: <20241015135231.GCZw5zn0fnI8dXpHtw@fat_crate.local>
References: <20240924223140.1054918-2-daniel.sneddon@linux.intel.com>
 <LV3PR12MB92651F4DF654C886B9F2BCF7947E2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20241010045219.vgpcl7nfqaimqrne@treble.attlocal.net>
 <20241010145737.GOZwfrYaGxCOOlaVhy@fat_crate.local>
 <88baaae8-d9fe-4c8a-a5e2-383d6b641e2c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88baaae8-d9fe-4c8a-a5e2-383d6b641e2c@linux.intel.com>

On Mon, Oct 14, 2024 at 08:42:26AM -0700, Daniel Sneddon wrote:
> The reason I did the patches this way wasn't so much "need" as it just seemed a
> simpler way to do it. Why have 4 knobs when there is really only 1 mitigation
> under the hood? My question for you then is what you mean by "proper sync"? I'm
> guessing you mean that if any one of those 4 mitigations is set to off then
> assume all are off? 

Well, up until now at least, we have handled under the assumption that not
every user knows exactly what needs to be configured in order to be safe.

So, we have always aimed for a sane default.

IOW, if a user wants to disable one mitigation but all 4 are mitigated by the
same thing, then we probably should issue a warning saying something like:

	"If you want to disable W, then you need to disable W, X and Y too in
	order to disable W effectively as all 4 are mitigated by the same
	mechanism."

And problem solved.

IOW, I don't expect someone would consciously want to disable a subset of
those mitigations but leave the remaining ones on. What usually happens, is
people do "mitigations=off" in order to regain their performance but not do
this selective thing which doesn't make a whole lot sense to me anyway.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

