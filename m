Return-Path: <linux-kernel+bounces-548665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB30A547CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9993AFEF4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A85D2066E1;
	Thu,  6 Mar 2025 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="c/q5TKDr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD92045AE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257108; cv=none; b=Y76jnDF9s6j1M25syUnfCepfLGVrL08pPByO7Mtm6gBASZbKK7o2Lya1nI99evSDR88GqVTivarlabImfqaX7AKgWs6s2qnz32k9tzjeHA+Z7yt76/bDxpsXxu8MvMKjcfj7XMhgEABdTAYKz0N5NXEVpxjD/ec+G2h//EhHllQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257108; c=relaxed/simple;
	bh=1QsIEcrVpiyeXDCBAwVZ3638py3lMinhi2XPJ7F4Vk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNkac+0QFbWX96xj9L9gDdU7EKBxi2mp4WVDGe1c/Zw6SB5XaKP8s3U7QBYpqoLP8rcLymXQteVoBXWDkWDbam8U+7crMI0uBkOLfhwlOi7V1oM7LAarY/VRTh+O6SjLP8PZIuDDV5IL8Yr0oepEHB11Vf5SyEWpJIYidXBGMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=c/q5TKDr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 466DA40E015E;
	Thu,  6 Mar 2025 10:31:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jJWXBi9D3OQt; Thu,  6 Mar 2025 10:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741257098; bh=Zhtj4LaJVPSYExis1nic+olhFZobgUXgyMEdG1bLYSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/q5TKDrmT3SJt0E+CidZU8ZHvQezbqNLAjGocaLXI0obwF8QSlY9S4/KFZVlyKwf
	 CvddNc1Ke1KEvNkMjViGNRBuwlvp/oqnjaHHQbTXpM8jQg26p+u+Rr0/6b+RCP8bJo
	 S4JDIunrF0kgJ53gB5z6fSp5D5zKNCdpcmXWY+PnnCmKkqPlZLbzKPPhdROTBMLEMH
	 L7vvIO0arVGDaR6CUaVnxrNqw1FCDtPAtnu6hhLQsNergY36gSafJklMq8cRZRtR5V
	 bcx8cbCnx/LnQj+4SbvGGnf6Gb5d1T0QWC5U0q0JfTJIOUuwuDA4L6e6oXrmnFhaqV
	 2/Ereswds9RkrRo7xO8BIrlWqfoPBMpuprzRDKJcGdUI66BcGrsX4jP0+t2BOM9JIZ
	 2I118rk7IcfycaF/o3YK62y3QnBNPVLh5J0QdhQgGWqoHw/AZTiIz1MOwEBbXFWUWe
	 HY6EAlrlrbXSKV/bQJlmHVEurtpMCo0tuGQidFYSV+jcqKzghYnRds4qOpnobF+Fjq
	 ebo/fTrBhGmUHfjJTKnee3wXKv4/2p/7s5kSendPsmNtCYYH2vIsfFzm3gg7H2ilVz
	 891Cvea5HBxmPttvjCYeOFWJa5lfKTkktSAoMOmPSO8wmElQXw46EC/AnyOjoPYHpY
	 mxx3N62sApzKIPbZdsLZhgz0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F20840E01A5;
	Thu,  6 Mar 2025 10:31:26 +0000 (UTC)
Date: Thu, 6 Mar 2025 11:31:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250306103119.GAZ8l5d-brstBbLDEH@fat_crate.local>
References: <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8le_TWUJNebrfs7@8bytes.org>

On Thu, Mar 06, 2025 at 09:38:21AM +0100, Joerg Roedel wrote:
> On Thu, Mar 06, 2025 at 10:01:17AM +0200, Kirill A. Shutemov wrote:
> > Alexey looking into exposing TDX module version in sysfs for both guest
> > and host.
> > 
> > I think it would be useful for guest to make attributes and TD_CTLS
> > available via sysfs. So far, we only dump them in dmesg on boot (see
> > 564ea84c8c14).
> 
> Okay, do you have ideas already on where to put this information in
> SYSFS?

Right, I was thinking about it: sysfs does a one-datum-per-file thing and that
would go nuts very quickly.

I'm thinking we probably should design something like /proc/cpuinfo where we
have a single file with coco-specific infos per line:

SEV: ...
 * fw_info: ...
 * features: ...
TDX: ...
 * TD_CTLS: ...
 * features: ...

I mean, we'll agree on what the most optimal format is but having a single
file would make this a lot saner for everyone involved.

So maybe stick it in /proc...?

I'm not sure if /proc accepts any new files - I can't find anything after
a quick search but this would be the perfect place for that...

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

