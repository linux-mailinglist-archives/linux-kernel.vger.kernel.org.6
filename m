Return-Path: <linux-kernel+bounces-518923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC0A3961D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E817D188774F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F0E22C336;
	Tue, 18 Feb 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bKKdcgpH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD81EB1A6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868747; cv=none; b=kKV3jpTSTnvAZqYNn4stDUIBKX4OW+LUJ0zyjuTyFTYBxjjjQshcVLDZjO3NWIaqHQqnpkFgE1Mq/ucyKgG2vxveamSpX7ktWdwUzNPQkHEvqPEhW/DDPqJngGbAjcCDjCUrYCK/JN0C8Fp6ZgMIBUUM2xyRgzvDqj2kbPNlnTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868747; c=relaxed/simple;
	bh=aKJBr3Dd2EAHMdbQa3POvki4e+uMax+JgUvBzWoMvz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpMGf1sQrs5y6146IkUsPe1gvl0rrpuj4E99G8TgMtWyC79EpCarIF6eDzPoJbMiyoQ/2SfZkVUzHGNefyR5/4Z+g7Uej8z/Q0UiUfgF2F3v7z/8O//mBksfsXNEY/joAVWNMgO8mAKndln+fag6qZVlCyzdbtSG7PhEXAmb92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bKKdcgpH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7083740E0192;
	Tue, 18 Feb 2025 08:52:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Zsra0a39qJQn; Tue, 18 Feb 2025 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739868739; bh=Jsv8YmgNP20b7Ra7WyYeyfLNrpRy0hgEpMyauFp6jlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKKdcgpHlDIMFrM6gac2tjqGDX7/0SV/LsGU911pdapy+cH8cRzfDSBK52ENIAQkH
	 euUCA7dmZBFEygIp1FKcywXfBgbJyN/A4SS1VpWcFwqqVryPXib01GT3816jqjNSE0
	 De5wwlmumBVhET+am3gEwruYZdq/e2kxZ0n9KGNRgUxVDnX2+r9nxbJ0rVIoXgNyNg
	 qKRXZug8CZJIj8x0RhoRQ2uT/8Pc2OwDCWpmdyCFMaiWTDsXFpHhEUQ7pmFd88SeuO
	 Ca2/uGHlVFUU/uxFeWOmPJMw5I7jva1eQWL1LNPYdJHLKqOaLaC7sITt9AIt8NImmY
	 /vYSkCOhQTQXvud1vcYJtZOLFHvvfCqEGqCeAJDf5E5gAZXT4VtaQ9twgyidPBf+uk
	 hgXYWvAXZTjM+3bywMtaNNtmLE7CnOO9DlrzRcBIc7JCRLqiaosGiLRTIhff+kXtC9
	 iJa3YbyEQ6pzo4WAqxjx6Ws8jurI6lu/pPYcjYuvehwHw3L1g7YysvjJbCbyikRy7B
	 zb4r7N14uWlNovtcXMNqxHJOzVlSFjekvnMsPxbe75nHFACXgBcDAsYe3KpMYkeTB+
	 Y7sCVG09TRG7Q/1ZKK7XQF170rpKmKdr6RVx0vpFyIJgVN1dVA+rg34qsiOqTHYb3Q
	 9fMKMfJMIoTodeqvRfEC/SoA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2033B40E00C9;
	Tue, 18 Feb 2025 08:52:09 +0000 (UTC)
Date: Tue, 18 Feb 2025 09:52:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-21-david.kaplan@amd.com>
 <20250211180752.pfsjvz62bztpnmoi@jpoimboe>
 <LV3PR12MB9265804700AB74A446F5220F94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB926524EFB64F6FB361046C5E94FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
 <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218070501.7mwcxqgsuxl3meef@jpoimboe>

On Mon, Feb 17, 2025 at 11:05:01PM -0800, Josh Poimboeuf wrote:
> IMO, make them generic from the start, then there's less churn and it's
> easy to port the other arches.
> 
> If we went with putting everything in "mitigations=", making them
> generic would be the obvious way to go anyway.

Just to make sure we're all on the same page: we obviously cannot enable
and test and support a mitigaion on another arch like, say, arm64, or so.

This needs to come from the respective arch maintainers themselves and they'll
have to say, yes, pls, enable it and we'll support it. We should not go "oh,
this would be a good idea to do on all arches" without hearing from them
first, even if it is a good idea on its face.

That's why those are x86-only as they should be initially.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

