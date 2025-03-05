Return-Path: <linux-kernel+bounces-546708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8CA4FDE3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1483A4E75
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A12235BE4;
	Wed,  5 Mar 2025 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hvt0LQXZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859151F416D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174910; cv=none; b=EkTsrOWY5tQ9HJNI0W12VoPpkTs2u6hWU1sdp2P2ZQqtJLHOv3YBHdco+OCGnpsPEPnFtIHjnbzRdBcWmoCevTiZkMUwInc2tVTG6pnqPznjYlpCIuTUS3B560X03Dm6gOlm/dHHZthxFW2+BcMl1Y5mSsd7pA+Dp7wDL2ZKo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174910; c=relaxed/simple;
	bh=Ix6+zWUy+wsyjkEdT9sYo+bKSda2qRQJVEd8XIpvfFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9vClrHSBZNm0/gZnWuT/mzX5XUpQC1eX2iEYPhpLedZHLN5EMcGFZ8fryyrIJYOUBlTiiURR20N05h8ZWIY3Kw8yA7J+DpGTbbLaXrQYRCBeYDz2Q7lj37YNl7yJ+YLVZ7XKiOmT7mSKOChVhiZDq36CjZ+VUI+TFw2y6XDbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hvt0LQXZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4267E40E016D;
	Wed,  5 Mar 2025 11:41:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id acIKaiN7WiLg; Wed,  5 Mar 2025 11:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741174903; bh=b7ydvhwef3fSck/dj2FTh/NTP16NlTYshbu0jRt3ovM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvt0LQXZoD073TJLlFenZTu6wZWsT2ACGfHyK1rPdoNkqF/P9wV1Lg3EySG+H0wFf
	 Nm86UaYd9g/li9gMEmdmKSCPGI9dE8kTbkq+jwjckM9C+AXuDlhfzcnf1xwil3fQK4
	 T9zODP7lgTZHWSMDh8H0NLFSaaMRvnhWoGnurwA7PaTTiBjyzY9G7BDmdNskooBXvs
	 z1cLLEfVjLR8pSa++1jrLisaqMivq80groMdDusS0C8ceRayIt/WFDtdxav8H42blA
	 wdmNFUUVEwTk9jPFbUt/ZpJGNZBfw1GqkCl6D3CmFuMg9mGx2MBW1H+K5ZK0yg1eXa
	 4sb7UNWKy0q+RigqnxxDGejfkoM+uw/oMPbf305GtUP2L6UjQxC1gpGBre8uvbE82H
	 /CiTXhvvbQ7pyPYan/ct6V6is8OvghPvViwopmHCILq8B4l9yyAYT48zrKaWoVAfzj
	 nk2fLuNi10q4I+kBwc1C/KaZclAZb45wES1pRf5kEU5x2XNuH8AlCCfpAWIwd2KIqj
	 1RElAHOPuzwM1qZVRrCOoULvwgMkDhcEkqiIJXIZwmmgXD68Sl6gIdWYI6wrFRaKB/
	 hthctIASjvUzqaav/DpM9ZTwM6g2rBnen1O5V80NmZmqr5T+qRIzzx7y4zn9RiISDQ
	 ZiY5WcMWGVajet6idZq/QMrk=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D70040E020E;
	Wed,  5 Mar 2025 11:41:33 +0000 (UTC)
Date: Wed, 5 Mar 2025 12:41:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250305114132.GDZ8g4bNdM-I5OQd4B@fat_crate.local>
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <d9a1a460-2982-429c-b29d-cf2483e9380a@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9a1a460-2982-429c-b29d-cf2483e9380a@suse.com>

On Wed, Mar 05, 2025 at 12:35:56PM +0100, Juergen Gross wrote:
> There is /sys/hypervisor/
> 
> Why don't put it there? Maybe under /sys/hypervisor/coco.

It's a guest features thing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

