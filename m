Return-Path: <linux-kernel+bounces-555012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF460A5A478
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA717A55BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E12C1DE3BA;
	Mon, 10 Mar 2025 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b0r/kc0g"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181B1DE3AE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637572; cv=none; b=K3Fg7nLB9+PA85DwbB+9k4qe93WvMfr0YWjWjZJoMtGvjFqu/S7lp/djt8Fu0SfUOIRen9fPdE0WnWOsh0EYTjY/OSQbkbC7CzQVtR68eTchhRfsAztYJZeSofJLmbOyVtNt828J/pWZc0SQKYRQCsMOYGurXDaBwlF3CB1mrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637572; c=relaxed/simple;
	bh=182EpiWo/kl4L2mKJCem+bFN7+CZHjnUfcRnHmqS7Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTFFVK0sg2ilkpdAaw7UTP+UVfsRkjitJ1Rrq0KHxZnOBv7l4B5v8n4ejZeHXkXEV5PW8untBKo1JZrYpWwWlS7fPeTKFYr+AdueA6R7pY++VlyAw17phOp6ldvkHTUKjBcqyw/OswNDgg9Vvp0GmVrWL3s16liM/QjuvyopjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b0r/kc0g; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3356A40E01AD;
	Mon, 10 Mar 2025 20:12:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g50mHX8ulJWN; Mon, 10 Mar 2025 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741637564; bh=R20WGuVqN6hFXKq0tFVjy0bRwbA0Sdp/yEVYgIpqPNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0r/kc0gyBA8IzzBXXJb7FA8z6jmxSPhO+PQPV6/WwKahoBhq70OuXYVX85jvJ5hr
	 /CbowhcfDlUPD9JMdhb99/nslzUzSuSogKxkxRDjK54ldn61MZs6R26KWXXRVo8ykD
	 rQNIOyuAB7Jf24VrI6X+woa/DpZBy8VTIj85gdAfxFNu1KDSQOp6MVp5SMQ9sAesld
	 hk6R/oGbY/wwhQ2Va0ilmyk81uBBpf5pYRYJuH1oZskYYqBLI91Xn8PwzK+QdchrZ8
	 h6ksbvRBzTIVNlgMv5a/ZKBC+w0mKMwou6eZHoGqDFZ0VqsdJ6s75JgbRYKJ7+Izkg
	 zpZ8hUdPGD+hWE1GjeR7WMgH+jSkEvBgN6m79ihPzJaSvkuat7j6RMTpWkCCxXGYA+
	 1ltADS65WFFT8q393DH4BuQchOkh1T+YRuFIw0K5V7ke585gtorxsr33HX/Dqz1Hzg
	 Z8/vLKld6z20XEn2L3v9hVclmWyZuirrpVN+jz7w8vd49tB6Msi6HiEmLPLjnDB/G8
	 l2f1/wpjWvLBssFk/LYqoCBDnQzWvhWoDIl2S0G1iReS48gnhKRBKsk+AvJF9ZfPPg
	 6pMDBwc5XWHYMfncpr/Q5tPbrOJUaRHR1PjEi+Zvxtrz3Z+2hh16B+knLG3nTxIzVB
	 SOtc5dni6pBO1hfSlVUoSd+I=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3342840E0176;
	Mon, 10 Mar 2025 20:12:37 +0000 (UTC)
Date: Mon, 10 Mar 2025 21:12:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/hweight: Fix and improve __arch_hweight{32,64}()
 assembly
Message-ID: <20250310201227.GXZ89Hq5LVWKHjHBeO@fat_crate.local>
References: <20250310200817.33581-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250310200817.33581-1-ubizjak@gmail.com>

On Mon, Mar 10, 2025 at 09:08:04PM +0100, Uros Bizjak wrote:
> a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
> instruction from being scheduled before the frame pointer gets set
> up by the containing function, causing objtool to print a "call
> without frame pointer save/setup" warning.

The other two are ok but this is new. How do you trigger this? I've never seen
it in my randconfig builds...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

