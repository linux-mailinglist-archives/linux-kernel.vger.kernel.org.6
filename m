Return-Path: <linux-kernel+bounces-557736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 432F2A5DD09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E10B7A7F59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572A124339C;
	Wed, 12 Mar 2025 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RdoUpfOn"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30B12356D8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783573; cv=none; b=SG0TFvwQWwjV7owVsG8N94cqr1nhcIcAG2146eznrslvesIxuKsgttwDtoOy74TL/VZ/k2GLjD42cxN3z7cXdDDrXYB3+g3uE2Tnzt3a59H9kjaI4cPwj4Ypccgo9MdpwAAayohcYeCOLnn32u3p1kMJKst9ALnlIddZgsz/8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783573; c=relaxed/simple;
	bh=B+qedQ9BPFQGW3J0khu8zBQfZvjtxhEh7jY3x2JZRBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wnx+Lp0yLTO1vN6v0E/NOnRnGVsn5lYtsfxF4SY0gacq2yZbr1l/78Lj4Mk8hsW6U7B1ogSd6w0ES1+Am9a7UO8/mRuwY3M7qDbkXoOSu8Za1RjTKLhfJur0VoWgEs1q5ks+qIc1Tg0I+qsNM9yduk3hf0Alj/WjGw71RVDigzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RdoUpfOn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A936240E0217;
	Wed, 12 Mar 2025 12:40:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i32IavrGJKHu; Wed, 12 Mar 2025 12:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741783220; bh=gZaH1Pl/yqZHDpOS25EIdgOwXhH8hvtxT3pmoNFopcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdoUpfOn4Fi5tDUmSmNolpSbaptx5fjMJ4mWpCKdCa1xvxr8jPsy1FKb0S5r/qxQT
	 Sz+4O8paZT1cMuUSjZnSIEWNiVf5GrFRItfkClVq6zf8r6jfk3jj86eA4daV0XhlyN
	 EqQOC4cZ24AI+Dnkw3iEmByXU7cQ/7jMCBZJeUWl+yRCznjo+rQSK4PvQwwkWdySqc
	 u2aYx5JDA6fTxuYnsgnqgFASojfC7kG1slRfzDBLDOQFmhlY/T8CfGBW0SdzBy8Z9R
	 6QKJosSaUujjaWMHdn9sdjeWz3IeyKKMCTDxbe6t6dmnnwpPoGHKDuDmewl4kxHSxQ
	 4pla3vvuSP9iatGrXa0uJ0kvrPfRmasiklzQK0lLXjGhHbjPJNSXo983azf5EZ0MVb
	 5BcH0vgM1bqKVi1fq6VErH2jviCkMjoo8IsSXIBAD1a+Dy+rVnEgc0ahPU0fGDcWxc
	 +OboJbuDVjyPB6p7slehmuOcwCMc7AJpFxnkH1C+WCDcpGtr9s92SFlG6QVSIuJfmf
	 Tc2LrGjX4+ofkvz24dufpT+ZceVb7mqB9hq31xGljFLPhmr4tGaPCzAi6ZsHePzgBg
	 GXnJhlTeqC9f/ZUyqxLamz5Up8MmXPMVl68fOO5FYSL0RecuacrWuXuTLgIEvXXwUB
	 8vd6uoPkf/YRRNUZGsntJi2A=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC33040E0218;
	Wed, 12 Mar 2025 12:40:12 +0000 (UTC)
Date: Wed, 12 Mar 2025 13:40:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mikhail Paulyshka <me@mixaill.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 0/2] x86/rdrand: implement sanity check for RDSEED
Message-ID: <20250312124006.GCZ9GApgQQ49dO_BMW@fat_crate.local>
References: <20250312123130.8290-1-me@mixaill.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312123130.8290-1-me@mixaill.net>

On Wed, Mar 12, 2025 at 03:31:28PM +0300, Mikhail Paulyshka wrote:
> On the AMD Cyan Skillfish (Family 0x17 Model 0x47 Stepping 0x0), which 
> is a Zen2-based APU found on the AMD BC-250 board, there is a situation 
> where RDRAND works fine, but RDSEED generates FF. This leads to some 
> applications that use RDSEED to generate random numbers (such as 
> Qt and KDE) into a nearly unusable state.
> 
> Although AMD has fixed the Zen2 RDRAND issues in 2019 with a microcode update, 
> no such update has been released for the Family 0x17 Model 0x47 core.

What's the microcode level on that machine?

Also, send

cpuid -r

output pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

