Return-Path: <linux-kernel+bounces-374873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CAD9A715B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E261281222
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B211F470A;
	Mon, 21 Oct 2024 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Lbet9VfK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E61EF945
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532965; cv=none; b=dzWARvH2Pai8mTmKLOV4bm9Nf3eg8o4eqzydEz8Z1D0dxS0Os1Xzep67OTwMlJSvto2JN4RbNHPcKD0rPNMLUQtu56EPfhrjHmze+cIeiNVUntiWYS0/+rZyvTjjIEyyRLrvGO5rlyzerile103922rLhk9thM29OcnpeYPtlyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532965; c=relaxed/simple;
	bh=BxD8C7xTcBAN63V/mlr+/E0VotgQJ8JRxac3WheYrXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAzj1nDPTH/Ew1FWv997YTYrq7Dm6d+QgLuJiNo7OR6INKWgWtggBWYriKyfmobdWmxXHKD3w8roSyoziqJFa0b8f7/ZM6f46ekI8lBLbIM1lUKQW1c97A8D/Up+3tA+vBzUsA6IE+l4HxCprIIzsc4a/1pVYTgj8kkRVPM5h90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Lbet9VfK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BBED140E0169;
	Mon, 21 Oct 2024 17:49:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eFkionFefBcB; Mon, 21 Oct 2024 17:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729532956; bh=Il3NU2Avn2tAufiKH5z1ZgPu9oKW+yxxlqkT61wqoDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lbet9VfKie7EKg57sTccirvs6mZAIeT3mHswFrQho0/qb8Kdg/PRKgGulq66WrBij
	 Qfg/F703G1XYEmaAW7U2NqHiUYv0poSqVN7qIbV+d59wKtSulXjx3ZOUhyhU5SendF
	 fjBE/TxqiS7Usy8jNlt9d4GfjWCINTe68EQTtmm/hzF0gTq5djQmpbp+6Mg3BHaGMs
	 YfSodLxj8yPVdmO//dYJPnuJO2f3TtC95NUSFyF/sDQprURWzbIuKxhGgryZNpAZoF
	 k5v2jpxB98gHuaJcUBsU0cZkYuiGokfSeuGE76t9OTabyXt9SyLghiYfJFKTskTN1l
	 2yn+snDV4G5gEjAAsD4nDol8hEtxlA1nD7AgnM8oRVXc/sYDslZm4x/jIjmELeEeM2
	 zCc5aaTpjP1LN0rB7rmSsuFdv2FA77ywZ3bmkG59vG3UnV9NjFlitysZDrnS0WAHsd
	 aEctWMUHHt0k55FDWKNR5RWZS28SUCgFDRAkcRpY8HZQFI4AV9Eqwf9jWuZka1Vhel
	 CcErOBxOmMBnEjukA+K5oMX7A9nHJtlG7pvGdi31SDZxOncfBWFnYEpKRCAmrpGQg3
	 7Ic3L2gjVQujZOlZFKMSc7sMFKnA5OR+yoRkdHb4PYE5LbFKqrZ/shikWgTqHz89OK
	 ehPu3fpJXxLzaF1mYM//hnKo=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 78CB140E0194;
	Mon, 21 Oct 2024 17:49:08 +0000 (UTC)
Date: Mon, 21 Oct 2024 19:49:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 2/8] x86/sev: Add support for the RMPREAD instruction
Message-ID: <20241021174907.GJZxaUE-vizLL1mSlF@fat_crate.local>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>
 <20241018124118.GCZxJXbvAIcEak1gue@fat_crate.local>
 <7820cd89-f25a-4934-9597-d53e861d6e92@amd.com>
 <20241021154117.GFZxZ2HbUPG9ux8bYr@fat_crate.local>
 <b707bf9c-14b6-e210-2da8-c5d01d36d804@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b707bf9c-14b6-e210-2da8-c5d01d36d804@amd.com>

On Mon, Oct 21, 2024 at 12:10:55PM -0500, Tom Lendacky wrote:
> The input value is a 64-bit value and on output the return code is in
> EAX, a 32-bit value. So the use of the "=a" (ret) for output and "a"
> (pfn << PAGE_SHIFT) for input is more accurate.

Oh, they differ in width. Ok.

> It's not a complicated statement and is much clearer to me.
> 
> I can change it if you really want the "+a" thing (including changing
> the ret variable to a u64), but would prefer not to do that.

Nah, it'll get uglier if you do. Let's keep it this way.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

