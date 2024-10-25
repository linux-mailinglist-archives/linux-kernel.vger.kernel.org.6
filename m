Return-Path: <linux-kernel+bounces-381642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051A79B01EC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4112838A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F882022E9;
	Fri, 25 Oct 2024 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Z7xLYX+T"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19641F81AF
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858191; cv=none; b=QEef00QDl8kaDXDNVmcDEuajczoy84c99RT37rVTTiA6c6qPymXuSOT9TOlV2j6zPaQWHsDZ2mopEwfa8wkII1Rl1dzFrWbZI6oVO5ah2J20yfexflaXb9K4SGI+5HSoD9Ku8WfIj9yNWPBoYVlUMiYK63RwxcrgfmWI31NV8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858191; c=relaxed/simple;
	bh=QSqIp6r4ccaY1oM36iLizOPg9O6q8ZsIm5aAN5CBlCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ummudiw5OXGUbmWTR5Nrzb3gDWQrzTRMaFOkGUuYBEumBKvpU/B+NLTba7h4r/wVpuUYjEc89O08qzZcus+bFIxhWcF6M1vLYEsQ5dumY+6l4sAHvIG9vldOhptYLVvU/H17aDZR8Q2D2yvMqbkMpyhP7iLujCqBHuXgHbdyL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Z7xLYX+T; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E876140E0169;
	Fri, 25 Oct 2024 12:09:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fJUtCPrt8Ui9; Fri, 25 Oct 2024 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729858177; bh=RqnEXtnTmpXT6VkJxQWJF9ZhpvnTU6bjBIgOLGamDBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7xLYX+T1s42ytLAxXIjY8EdT8DdCvPhvP65lye67OfVRBHIGXH2fVnBFTgV4+6ka
	 +m91sCUKoh1Ain51kPihYG2LslRXLh+OGzYShssJ2UjoMz7ZSuIF3ZanxRZBHH9aJx
	 Ne1TSjaLzdv8aSgrf1ICQ3EuaOdZgotoK+k5FAKm5EE8OCo09GG0PwYIKCdSmydTcv
	 iQ/8ZiB+DU7hsMSH2jnoKvfNjnMdjEYtyFqQZUwxzyUGWri+bLhZFaYOY417qS2owg
	 1F2FXQJuVgWosV0Enkt0yXFoMGK+LuCyvRQ6BiSznthUdo5UaduWdgf+1CCHsGKJHe
	 nAZA8n9Y1onWc3sRniE/rqQBvFh7DiaMgkw/2B6z9+PXZ34jQu4P7chT/NTqodBNK3
	 xtD28iBJmXnl33w7V0e34d9lzt0TvJl8YhorwlXgc+iBUIlV/MvoPFhbb+EweQ0DhS
	 IPx4caxTZEImBR1u7sbsGlJsTvalb1a1kBne4RKZc8LnVZlgee74v/EIXY/A1zN/F0
	 uYO74/pOpXE2UwWK6l/PsE6oIEIS8QVX4X2woRgQdiAo07WftAEi2IsWBQ6ROA9YuS
	 K0sT9pqrypvngJ5jAT+sg/A0rr04NIXlbxZSJw3/l8K/KbAQg8CdxC/JNrdzr8L2ZV
	 l+sG+0UexOWtl7FnbsCXhmgc=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0365840E0191;
	Fri, 25 Oct 2024 12:09:26 +0000 (UTC)
Date: Fri, 25 Oct 2024 14:09:20 +0200
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
Subject: Re: [PATCH v4 1/8] x86/sev: Prepare for using the RMPREAD
 instruction to access the RMP
Message-ID: <20241025120920.GNZxuKcBsMvYTd0ki-@fat_crate.local>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
 <5e8bbb786f0579b615a5b32bddbf552e0b2c29c8.1729708922.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e8bbb786f0579b615a5b32bddbf552e0b2c29c8.1729708922.git.thomas.lendacky@amd.com>

On Wed, Oct 23, 2024 at 01:41:55PM -0500, Tom Lendacky wrote:
> +/*
> + * The RMP entry format as returned by the RMPREAD instruction.
> + */
> +struct rmpread {

Hmm, I'm not sure this is better. "rmread" is an instruction but then you have
a struct called this way too. Strange. :-\

I think you almost had it already with a little more explanations:

https://lore.kernel.org/r/20241018111043.GAZxJCM8DK-wEjDJZR@fat_crate.local

The convention being that the _raw entry is what's in the actual table and
rmpentry is what RMPREAD returns. I think this is waaay more natural.

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

