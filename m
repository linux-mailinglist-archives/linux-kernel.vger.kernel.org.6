Return-Path: <linux-kernel+bounces-359377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46416998ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A3828C152
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9571CB51C;
	Thu, 10 Oct 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EGQLqWX7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52311CB338;
	Thu, 10 Oct 2024 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572285; cv=none; b=PNpiH0M5ec3/qJlzgOZbLLRgVSRNdaWZ8qL/TyOL+o4wBxFKUekzOn4NvIxk1H24NLJRViOubP622yrcfQKJFn1LPNAkcjQ49FJWThsvTqBJP3P1jRDfKEfbaejJ4l7CZBB91xB8CHghSsQBhSnjWyWzHMhYsilbKrINF7psvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572285; c=relaxed/simple;
	bh=2qVVIZc/Hg3mqrXpd14OJqee8rkzrK2WlkPgmkVkiJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGedYIKZFtQT8SU7ms2h/KFtZjmubaZUn7e+ssAbluQckvlVUiBr7WqUTVM7pYeZvsNxTXBhC1jAqZ72yL0O+NbF0lEK8LPhJUBadVgqOJPJJeV0KD9Tj1bXWvaMqwaanYr6UoJxpP7EpB/CuPsGfzoaPuu0mWxAD/MUwjm0J/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EGQLqWX7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A991440E0263;
	Thu, 10 Oct 2024 14:58:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F1EDNV7stv7i; Thu, 10 Oct 2024 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728572276; bh=52fOy72l/0R5V2ZqlnXurKwqRWctf2EGFcc5EouBbBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGQLqWX74RZRntxxXo2z8ByESZy1Q1BIl1lPm5LZWJf0vvu/J6THYwFGUQBpqAY08
	 ryMm2t1XBwYlIDC68XKtmSxtXrAQJprkAg6KE/b+vdjU+l+rCuuupvTHXuj7Rcah3c
	 hO1IVRB+cwV2sQ70J3vl0AFoGKv21d4zNwAHgvgdnySF9WH9BiAPosTM6rfcCK+YsV
	 7MaRmkgjyoSDoCXpKqBjmN0x0kLcDuE4FYYM16ev5jaFuA90AFiVQbEVymyW6eigrl
	 ukrdtasJgw34XTjdQxg1ABGe33UO1G3+Xd3cYwM612Y64nl9YBalPvXNjAQ5OrouO/
	 eRkMFoY8NqKVay/Mrv0mnEnqhohV+E+bqqgFa1//cBm/MWf8b0Vk/L21HBILwsXtzX
	 2PCjMiL4aSyeRLPZ0BcUuYTbKmeoK7DO0/Bl+sqSUwyXPYg4+g4m+adSledtlPArom
	 8seVNJUJN8Gv7UPsPjqAipCHVCIe7tFIADF2TYlN8uaSQj8ZFJOwftVjLuJUXFRmwm
	 sIRkiLrinn90CGyGZWYdxi/l0P38dB2kawfH2HJ4X/cxWPxAcmcFpmpYj2BD5rYwBa
	 HaAmrAsPjidbUOgZePPrRJiW1yvoWvutluvT+atlbDXZLiPbyws9tNwaN+BkgOGSA/
	 2E0xv3eNYOZfTQSu1O7Cjawo=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7728140E0191;
	Thu, 10 Oct 2024 14:57:43 +0000 (UTC)
Date: Thu, 10 Oct 2024 16:57:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
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
Message-ID: <20241010145737.GOZwfrYaGxCOOlaVhy@fat_crate.local>
References: <20240924223140.1054918-2-daniel.sneddon@linux.intel.com>
 <LV3PR12MB92651F4DF654C886B9F2BCF7947E2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20241010045219.vgpcl7nfqaimqrne@treble.attlocal.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010045219.vgpcl7nfqaimqrne@treble.attlocal.net>

On Wed, Oct 09, 2024 at 09:52:19PM -0700, Josh Poimboeuf wrote:
> Is this a realistic use case?  Are people really going to want to
> enable/disable VERW mitigations as a group?

+1.

David's per-attack-vector stuff will simplify the user side of this
considerably so I'm trying real-hard to find the point for a new option.

IOW, the reason I requested this cleanup is to have proper sync between the
different mitigations all using VERW behind the scenes. But there's no need to
change the user interface, is it?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

