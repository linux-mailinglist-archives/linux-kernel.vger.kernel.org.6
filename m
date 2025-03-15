Return-Path: <linux-kernel+bounces-562769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49385A6329C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 22:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D357A34E9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2397B199935;
	Sat, 15 Mar 2025 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Aj8jBUq2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1863D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742074639; cv=none; b=KPYg6Kzt3rVDYs/UUWDpAjtjq4PEN3OP5jP5XnyGiQLrJWs+Er/Pr495q0aZyWfGJR0K3D+8HatIahmm7jAAgHFW+iA25bfk35fnoSuc94wcZSGqVj8KjJ8GMqZGu7niMfnricVL04CLb58F+qTZomEz6qY54XkBXnAGfp2/gZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742074639; c=relaxed/simple;
	bh=NY8vbyCKlVsEq74R6YYfAHqecEmthAsvxwBcPXyfYPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrwtVCnmAhxuG8854dZpKfgAObF7UJRvVyx2H2f1TM/6808PzuUkNXFn9+cxh4JRDTSjWR66GgCpmpfMzErtAselSJY4bDIWl57NRzZDxhnigUj2PMeH/5+sxpEzx9QC65qmKjvWl/7Ftmzdf54eTTKQ2FcBRsovELmHI8FuC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Aj8jBUq2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6E28040E01AD;
	Sat, 15 Mar 2025 21:37:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cZ6DHpAqc7Pa; Sat, 15 Mar 2025 21:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742074628; bh=r8Y+i7BAyP/Aiugn4EWtzpB5XheB/doWKXmLKsr+72s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aj8jBUq2a5g45jDtsmZOu6pDzHNFOyPuqp/EGNROQxatPD0agE8inB3g8of8NBI6b
	 +lyJOhf1cbJiegSzpF5quP4y+AqYgainb1lE/XNzQQt7s2f3kfpLWo2K9la6FOYqif
	 9gUEi7BSEujj42ScVqmHX4LVxl6HWV4oydwAOhnd9frEHDBvOLdh1LPHs1kmWYePlE
	 TKzd0NzIv5dcz0h2LisYth6N0+8cKxec5gFe8niUxpUBdp8nXbqEusuPFPbY5VAOu7
	 2MBfAqubwO4UlwtWMho8Pyjx/aCecW6K+XERXYin+MRPprM02H74f6FarQrL6Dib73
	 8F0sEarSWhivxONpOUtClSjCZPIwL3FUBNuQ2vwDnm7lxfW0MM7Vls/vtQmq36zLjG
	 QPxolUBmaAq75DG5Ja8rDKJTxHS0l95casHI9Zz3dbFnGokZcB6Ki+AAsn2b//U3PE
	 MQTViB/oLcbictqT6f3yr5bnFxxo3VkzLqoIEVaWerKAbV8JeGE77L9UrA2at++IBG
	 1wVP9ybbIoF2s6b/EXr6uYKzeeR7SOfeia8hXVnCtUDX5RwiasN4/X+oxKoXwfS/gE
	 QK+X+wCvvPZhd1CCQEDRO3WQWSwbPRwD4LCRUyPODw3FJix19hm+DHC0gPO1YOWs4T
	 dv5aftdkKQwK2uy5s6CxIvFQ=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F40240E01A5;
	Sat, 15 Mar 2025 21:37:01 +0000 (UTC)
Date: Sat, 15 Mar 2025 22:36:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/asm: Use alternative_input() in amd_clear_divider()
Message-ID: <20250315213655.GFZ9Xy986YQZCeK4iX@fat_crate.local>
References: <20250314081453.565859-1-ubizjak@gmail.com>
 <20250314112018.GAZ9QQ8hPXt2Mk22cG@fat_crate.local>
 <Z9XxNbdLCZFiK1NG@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9XxNbdLCZFiK1NG@gmail.com>

On Sat, Mar 15, 2025 at 10:29:25PM +0100, Ingo Molnar wrote:
> So why does the higher level alternative_input() API exist? If it 
> shouldn't exist then we should remove it. If it exists, we should use 
> it consistently instead of open-coding its equivalent.
> 
> Cleanups like this, especially if they are clearly part of an effort to 
> improve x86 code generation in this area, are not 'code churn', why 
> would they be?

Because this is not improving anything, IMO. It is simply writing it
differently, perhaps obscuring it more in the process.

And I, just like hpa, would need to go look at alternative_input() to figure
out what really happens there.

Dunno, maybe we should really remove alternative_input() instead...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

