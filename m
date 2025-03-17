Return-Path: <linux-kernel+bounces-564388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6FA653FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A2A189A5E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799A245022;
	Mon, 17 Mar 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QetxBCOh"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20152441AF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222451; cv=none; b=Awys86ohgsZag/gSh1Se0ZFbEzaLHrPoyE5eStJbq36WBBHmC6ya0sDNei1yo69FP6Nl6oZDDeC37a948yTbui1w1z+gfE8+hp1as9rjCIyTaTq2o3yPP/Ob7Vve1WaKK+i2xiWUEz2j9krShnmKSjNV93Zn48nQqAuo+N9lxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222451; c=relaxed/simple;
	bh=SiJ2klyd3QMOZEszlbBWWZLO7h1PWWEX9OVTdnZEqqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2rLgrqzlSFjc69kTau21pweulAf/ov0/KOTBDzyraLzFp20KUpH5/rrZL6FodtLFNHm0MeK0iUIvHwtvCFjAeGKHNQC5bw5m1GpgLrl2GuBbwxJ/BQoK8DWDZqoAnKov6hmbjUtqxBOphN3OJc6nn1+Yb34l2PS2TRAUQ6tyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QetxBCOh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 66FBF40E0196;
	Mon, 17 Mar 2025 14:40:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Xu59JE0CXiy6; Mon, 17 Mar 2025 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742222443; bh=G0aiYt4PbQNHxT9E7eVTZxUeovbVTDiCdWodYUTCRUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QetxBCOhJCEL7VnG09RFjoyujTwVRc+CIRlINRoOHf7dOoAzRLFvVyAYhGeDA42w5
	 uxyY8XZXdaTqCBJNte0Hmhno+nbP+FuWJeHgiVmIjgsuC0JeF21X/Dw5NotqmTlVsz
	 Ks/ZLWbkaRQa4ZjZkqKD0q02fEaVH6yPPtKRE0otzzLlDBpCHbecGLHmFfM4fOG+G5
	 AKdY5gbWgJsHtMsS4/uYS17iUYgvdLGvqY9LDqO9k29smnAC7lS3PwUjp3X/H2iT35
	 2qEJtLXAm8+WDBrwxy/R0AM86h7tE1rEUxLbO+7iz/UVeVSTPya/JgAs46QlzTU+U8
	 vTaOuCYKjBOo4qK5l05ZiZYdPeAvdPdO4sMUgePzANi0yntsB0w9vImRcZiI9P4rWl
	 hQLsNic/bBv20hFaxyaNIJbUpTPOyOZHLPdc3JG9AB17mgm58/AaOmR/5eFSsw3Q/S
	 wAZ6QVSIEYpEjJ1j9BxxxIpUcBU2xzI3N1wunUwlXPzadWecChoBmGlIEKbo89cqRa
	 zS+VlEEl2X7ULww8Xyvdp+eMBV5ODsd8oJQrrkxSBgGTzEzHbTAPC5lZP+KNFtZG49
	 NwlAd4sbjazvOnQCrwy+1VAmkQbqHV6gDQpDlElk6IhLo3rEOr+BFmpIydhTTfYjS7
	 ShpLOt+MjojUS/yeOjbt/nqw=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC6A440E021E;
	Mon, 17 Mar 2025 14:40:33 +0000 (UTC)
Date: Mon, 17 Mar 2025 15:40:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	kernel@gpiccoli.net, kernel-dev@igalia.com
Subject: Re: [PATCH] x86/tsc: Add debugfs entry to mark TSC as unstable after
 boot
Message-ID: <20250317144028.GEZ9g0XPSkOQU7A-nO@fat_crate.local>
References: <20250226132733.58327-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226132733.58327-1-gpiccoli@igalia.com>

On Wed, Feb 26, 2025 at 10:27:13AM -0300, Guilherme G. Piccoli wrote:
> Right now, we can force the TSC to be marked as unstable through

Who's "we"?

> boot parameter. There are debug / test cases though in which would

Which are those test cases?

> be preferable to simulate the clocksource watchdog behavior, i.e.,
> marking TSC as unstable during the system run. Some paths might
> change, for example: the tracing clock is auto switched to global
> if TSC is marked as unstable on boot, but it could remain local if
> TSC gets marked as unstable after tracing initialization.
> 
> Hence, the proposal here is to have a simple debugfs file that
> gets TSC marked as unstable when written.

What happens if someone marks the TSC as unstable and comes reporting to us
that her/his machine is kaputt? And we go on a wild goose chase ...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

