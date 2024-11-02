Return-Path: <linux-kernel+bounces-393319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182179B9F23
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCA61C215DB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8351714A8;
	Sat,  2 Nov 2024 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b0xL7oy4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480112C54B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730545603; cv=none; b=kq9ONsNjwTLY7Pi+HZRTZ1kdAj58/PO/ZdN7jOtOI0uT58YH4dNo+gKxTId6K9qyxi30jeSVecaadWKq3iHXwjtbMSR3k3jR/OQUTo5xhOZon1NvsHeQHQjNw3w94U84lhwGm5XGlp9DDjW6DJFhLoEExTbnmRw668kau69B2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730545603; c=relaxed/simple;
	bh=Vjjt0F+MkTMBrDnmhH5YZFacPqfr+Fn/vQZvJGdUiBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxV8QcMJVZ55MWuxSjakzvbEOo/ghjpOM7ClgUpT7OL6+k2ztlpsuMyDVUfaBC3Jo0xinKDK4eueTIE4h9YEXaYjiuJjGaRluI1HcIq0EL3hDtTysv+hpBYF6ZmS/MADPf8MBzacjKplP+MVbXgPbiK/JNoP3tkICsrOZdxQrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b0xL7oy4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 93B8C40E015E;
	Sat,  2 Nov 2024 11:06:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zVC95o_iZJqe; Sat,  2 Nov 2024 11:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730545594; bh=x5gVCnlDPcjJpvinoTgtzzj3bTuvqlm+qfztO2S0DfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0xL7oy4TjWweC/cUd8U180n7dU8PfIVkEWQvkNW+zPsbqJ67DiR94E3U7pqfWTiA
	 TzKQzSAnRoV+oclVKjZ7aD9x27hUGCj/WV7XWHxaanbkboZ28vVZWeHA/XJjEYoghF
	 BfSB9fbr19WKycHThUmD6UknCaI1ImDgs3cXXtE0DLAlDHtPEYIrErQLPHaDq4thpz
	 84jKJBvl0Bhh4oabkVyZGdZ1OG2ysa1EKN2w3Pcu7jq1VfJ6dd7V+Aivh4dofnJjEy
	 xkK5BoFrY4aDgZN8iSW4ikIxBw2/SPzvDATXhWhp6h8E3OLHXC1cpnCsHq5ko/QNAa
	 Dp53ZHTGDiiIZH5//d3rqHcPhjzDJGC+ByP1s3HtljecTiiZMVIU3WvNbDcju4eXpu
	 Oe0fWvjzfIEDUEluMkvU/h2Ai18GfTuEPZRtrnpFYf94E7QeA3YS3iHG4YFjjzZKsE
	 JLvpqyeOxuEqnBCMCc4SU/TmAW0it9NmWheWpierRXkJQZWuvz/Tz32uUdebY4sirt
	 BSLtozhNKpfKo1SwofXJ11soVsChbg/L1jFZCJWMA+YM5hbzvS2sFYEvnIodzf+boM
	 IldXHFAytgr4zo4+/G37lHnrcS2j82z8yLhvcSLRmvichPqpvv3WMIUVlI7cHp3ewS
	 mbdLHTiK2budTmgrwIewyfjo=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B35940E0184;
	Sat,  2 Nov 2024 11:06:25 +0000 (UTC)
Date: Sat, 2 Nov 2024 12:06:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <20241102110618.GAZyYHquhmVJd4yM9O@fat_crate.local>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
 <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
 <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
 <ZyVxBbGYsEjifLgp@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyVxBbGYsEjifLgp@MiWiFi-R3L-srv>

On Sat, Nov 02, 2024 at 08:23:33AM +0800, Baoquan He wrote:
> Yeah, it should be added to stable. Distros may get both SME/IMA set not
> as early as the bug introduced, while anyone doing so in an earlier kernel
> will see the problem.

Ok, I'll take your 2/2 next week and you can then send the cleanup ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

