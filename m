Return-Path: <linux-kernel+bounces-381824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5282D9B04F5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E0228241A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43C2745F2;
	Fri, 25 Oct 2024 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VmzAT6yg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3444204D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865057; cv=none; b=QmsUS+U7iKvwDLIUl5nnhruManwpJKY2ieLtUFfmHkBjk7He2bz76/A4MbgpEqvNROD2y6v/Q0bVivEIUZ84lwmf68JL6nQNtSa0FH6ksMU9INIT4j2xzUM728wf/qKw3i4OvLUTckfi0QWu9BQPsPufvekflDN8cQwjeLAiCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865057; c=relaxed/simple;
	bh=jhkN4Q4MjooMbIyeXXRMiCXk0C9i/QJXQNhSVF+7SsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrXtUCgVAYphczcqSXJEoOFHeQjQpH6/LlBU9QjZFPL+9Su/7A8v+iIqAsw8snzYCfeZkoPZ830JrkZ+LtzvVIf8MAg0eLeF2x/XvAL3EbIYMrV4+IhJOM89Jwt4rlLOCpus293Ky8XFQP4/xrbfrraOjoOMBLa2FKUIvAKu314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VmzAT6yg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 963DE40E028C;
	Fri, 25 Oct 2024 14:04:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 065vySKJsjU1; Fri, 25 Oct 2024 14:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729865049; bh=85rPkP8Egg53gZYF8kP9J7jpoFHGZSmykS0nh2ohL7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmzAT6ygT/CaJi7hGQahAS9VrNi83X4WWmyiasuIpJjnO5S506o6SanfGxLb+ZOim
	 q2KpEmx0U6YpcDHmrchedQ+j+qscE6P4pBpExHwRq7pherVUAB4Dqwqu9dXKxiAPav
	 0ddoNaykNCvbmDvTnqWnFCVndpQy7GnLsjj5YjDttBcjx9YsH2+S4Tjj5f75FFgtD0
	 YnMgegY1gcphFCBZS67SLoO7B6irQ0zm2B0XscDhI8fgKVFjrKz/FgQSf0ZHQwRuBG
	 3oSuB1QKaiP/Olwfrx9wHry6bPzJ6xY5J5+mrz7Gj76U20s/5oOG/E1ZyLCf5icXdT
	 GJI92764Jy7raSYu26JemhsluAhFcg9SA2DiSEQn+O2WhQSaXoJzHG0NlJI++PtwML
	 1wC96m2BpITQ+avm5zE53LSnrjpPPt4lp45o9j2/oXti0n0C/t8QcHQr2GE7wT+sSY
	 aIq9nNiB8h0ie6+7HHVC6s/o3dG0rPTsY+EAebeFVfuhOskRfJP3pPoteN+5y7G7pH
	 wpxRoXWWzwzyIKy7aX6GQB7p5fRrzsgFgcs+JCPy1W5moA4XyEXndR0mwez+2Dw8+h
	 yz2XKkq62HAcX8bR/TFMXUQNavxxLEnGnXJnkQ4oawfb6A/F8f2hUeYm/CQA4YOXrP
	 5pQVve3/08gnBrR4nXNzGOSM=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 462FA40E0169;
	Fri, 25 Oct 2024 14:03:59 +0000 (UTC)
Date: Fri, 25 Oct 2024 16:03:58 +0200
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
Message-ID: <20241025140358.GDZxulTp3VnRtxaK3l@fat_crate.local>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
 <5e8bbb786f0579b615a5b32bddbf552e0b2c29c8.1729708922.git.thomas.lendacky@amd.com>
 <20241025120920.GNZxuKcBsMvYTd0ki-@fat_crate.local>
 <2dcb1db1-fc1b-0fd0-f878-470cfd22e8e8@amd.com>
 <528f1a15-221f-6419-3f6d-7bd45f75d48f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <528f1a15-221f-6419-3f6d-7bd45f75d48f@amd.com>

On Fri, Oct 25, 2024 at 08:56:09AM -0500, Tom Lendacky wrote:
> And why am I not getting the replies you made to the v2 series but getting
> replies to the v3 and v4 series...  very frustrating... can't find them in
> quarantine or anywhere, dang email system.

You can always switch to an email system which works for kernel development
and use the corporate thing for something else.

Like I do.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

