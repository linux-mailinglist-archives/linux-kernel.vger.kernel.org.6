Return-Path: <linux-kernel+bounces-443329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314B49EED78
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3F41881CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FC74F218;
	Thu, 12 Dec 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Vse3fTTr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF5822332E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018134; cv=none; b=C/A6T+pXa2dI31Yy+Aq9GgWLlJOgi0ELR0Ffrz+NMoVSEJoeZ2NCQRAmWcbLHtYaVSn6tVU78XPNDxjvFHq0mCzce9UCmyn5kX40L0rbkr+NLd03Jm54GgP79z46CysrWgNkt+N5VRj2+nM4FZLMzc1GdZEbbT+D04E3cN6wrtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018134; c=relaxed/simple;
	bh=0q8mlQEy0J+I4DWwpUxeu+0EtljdiPHM6OnTkMleXwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWnFpX0Ok6/uUpQy/zMQW/UNA3cYlUwerPJ0ptCV+XOQXLDRAfdiXDgUD6ybt68osvZxbla5umT0cydnVTsoA1HFRT7WvgbHLnnuh2oGg7IfirFYm9IMa6fTwmCX1zs5h08jS9YULZ2BPoM25qpr3ARAHzIn20c2ROKTGal5pSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Vse3fTTr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7EB3140E02BF;
	Thu, 12 Dec 2024 15:42:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Hox2oPTNzDA5; Thu, 12 Dec 2024 15:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734018119; bh=Q8eUsO5h4j8d3CiWORqehW6Q+X/HXCg0642KKtarsxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vse3fTTr3vE9f9RAgi3cdRCfTxqKukQaqAasP0EXWLSyjPTA4RKUwc6Kn465+mR26
	 1bbgRDqe3Zz/DHxRyZvZAUQ1pQvobf4ja32LX43oY6n3k48pv7Ks7URgiLIZ4Yvw7H
	 Dcr/0hC3VoAQtmzRaTfx0iIid1uJb31jJYrNuP6rFLpnzZ7uTXU4jmujti22/jifLR
	 F6RwriY+Przvc+srLBkat5ELd37vTkFbXYxcZjsuCeUaEEq03vNQlMSvUe6uN59VMo
	 voIDxGK56DHXWG+h+kdNSHsmwkyG3lS+vOZ+rHEmufRUMYNxmZauxyHdQWFB+4ooQm
	 yQ9B1lxthsv1j1VWeN+k3Wweda9F4ohughPGO+fqfwWcEBDrZHg6lOCzEcA2IItCAo
	 rirl3ZKnj5kdiELN8xIPxi7ahJv6q87eNjhxuGJoWFVR4gOmY+OWRrWGAohIjEBdMB
	 4olVdYVRi5box/AoobVAwJdv4NYLQXUvLxM8oG3Vt84z7j70KmRv1qaUDM5vEuq7r9
	 DSXSH/9zmG7jpu0e4RMn2OkU2y4zQCIlQU4uHAra2vYuJbUhIAl/nRh32KzsmXb2cC
	 Vzgj+7JWiV+28SSZ2Y+EVI6Pv3VeqDsI12A1qa4bXcInIJnyhC3Zak+bffhLGS9e+p
	 ZPj8bvqmlJM9pdlP8uWjtWHk=
Received: from zn.tnic (p200300Ea971F93c0329C23fFFeA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93c0:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 41EDD40E02C1;
	Thu, 12 Dec 2024 15:41:49 +0000 (UTC)
Date: Thu, 12 Dec 2024 16:41:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v6 7/8] x86/sev: Add full support for a segmented RMP
 table
Message-ID: <20241212154143.GDZ1sEN_ANTQrd1GAW@fat_crate.local>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
 <c3c5acb445f9cdea6d5c0f16ff961aca65c05528.1733172653.git.thomas.lendacky@amd.com>
 <20241212091152.GEZ1qo2CJgP_V7Xvma@fat_crate.local>
 <b1ba3ffe-4336-4901-fe35-03971ae1f82b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1ba3ffe-4336-4901-fe35-03971ae1f82b@amd.com>

On Thu, Dec 12, 2024 at 08:46:21AM -0600, Tom Lendacky wrote:
> I find it more readable :)

I know. :)

> But, ok, I'll switch to the if statement, especially since you want the
> probed_size check moved here and that only applies to the contiguous RMP
> table.

Bah, I misread.

contiguous_rmptable_setup has:

        if (!probed_rmp_size)
                return false;

and the segmented:

segmented_rmptable_setup:

	
	if (!probed_rmp_base)
		return false;

Forget what I said - keep those checks in the respective functions. Sorry.

> Just matching the way it's done in the contiguous table probe, but I can
> redo.

Please.

The pattern is:

	do thing
	check above thing's retval

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

