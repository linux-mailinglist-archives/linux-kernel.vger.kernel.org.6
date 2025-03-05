Return-Path: <linux-kernel+bounces-546655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B84A4FD50
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E46718858E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEEB21D5B5;
	Wed,  5 Mar 2025 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="U5t7kJc8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EE6205507
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173196; cv=none; b=MSrlCCrCmzCIWHksYDs2Ae2IKU0/IVekX6YbiZ3GpYem9pRQAUw2rAc/5TbvpmfsgCjjaGT4r2VWl59gT3n0Dv7aHqZuMrKAGM209GlCqJi9ubJAQzD9+kpj8AjgQiGCcyJIPGXaewXPP2/xqsURTvlUcvcfJFS3ysXoIyGWPbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173196; c=relaxed/simple;
	bh=9iiejX7bcnB5IL/2VAypf8VtH6P7qLfJ2UJwicPwqX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1coidKAN2P/pVHXeTMK4eNlAddd/879kDkvCB3PZlc90Od0n2+hWRW03V+NIjU/IXpzrJkBxGLMfWmECWkWdCDTOeosnrlpp7doQJqifjl4VvAEDxcWwXtQyOzufxQiHYMHgJ6o/qpjLB9VKjlV79M1tucIlKPoyw5aKYsPGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=U5t7kJc8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1CEC640E020E;
	Wed,  5 Mar 2025 11:13:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YNvjDKnvhgzQ; Wed,  5 Mar 2025 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741173184; bh=kyccvlhP2iZyFElYqL1iI+uGJBsxaqbwYOGzAFr3vio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5t7kJc8JCQnur9ihAD9+6LsnFzGWfyn4PuZ8dMhkyHRB1DRo2zrpV3pbFt3OfXnH
	 V5ViC1QQN2Tt9Wq++M9TJsU+tahV/bXdKt8ajnv2rusgVbFT3GKllZF2PTsnbcWqtW
	 X9Yrh3plNTs2MEj0Ud84oKPc7Y6w+CYxneXOli/gw6DvLlhbjwCzf5Sd0EKTX4PDG4
	 Da78ifH4BHU7SYlhzVMp/rOUfNvAVtjtUA6aqF+KFen45VWsqF3mkh1vJ1hzYKf+uS
	 WsOnvFdALi3cp1f6gl58aMOTNc+xbQjqF8JXlSPittLi1wdlJBPn35ohuz8osCbCFu
	 H3piZ2/JD4s883zLJanv9G0NaKz8zr6vZWqk0y3x7+b/eAv2JyUYD4v9/7vFXrzb0K
	 8nZ1zmufSIE0IUbbO20Kh+KsvoQd/LHU8M/puM2dRY6uOJ8Jehu1EJwNGHs2BpiQYn
	 ChnXoWM0YnY66SKzHi7HL0aGgC+G8ldWwK7RMVw0+BsULrlYIsywJ6kcJM6NLnG4fU
	 D717ZelDs8jXu1OY2jQkTMYBNoTg6U+SYbS4NuG6oOgLHPCWih5M9L4ilIowjPOpQ+
	 rpReb7c+oMUoC94aBlQLl8C9ZBEYjqjm66Ui5uVD21ews5vmA706e7Wl6uZ2uI5G1m
	 ENcS+lWHWU8M0UZPlHbVrY+o=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6E43D40E016E;
	Wed,  5 Mar 2025 11:12:56 +0000 (UTC)
Date: Wed, 5 Mar 2025 12:12:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
References: <20250305105234.235553-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305105234.235553-1-joro@8bytes.org>

On Wed, Mar 05, 2025 at 11:52:34AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Current user-space tooling which needs access to the SEV_STATUS MSR is
> using the MSR module. The use of this module poses a security risk in
> any trusted execution environment and is generally discouraged.
> 
> Instead, provide an file in SYSFS in the already existing
> /sys/devices/system/cpu/sev/ directory to provide the value of the
> SEV_STATUS MSR to user-space.

Right, to continue this discussion on the ML, like we said yesterday, I think
that dumping a raw MSR value is not really user-friendly.

We could stick a

Coco:

line in /proc/cpuinfo and simply dump SEV_STATUS there and TDX can put the
respective TDX-specific feature flags of what is enabled there and then we
have a good tested and well-known interface to communicate such things to
userspace through.

I'd say...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

