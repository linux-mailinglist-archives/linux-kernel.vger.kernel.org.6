Return-Path: <linux-kernel+bounces-374679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FF39A6E75
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F77F1C22A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689CC1C463F;
	Mon, 21 Oct 2024 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ve5cxrmI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04881C3F3E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525341; cv=none; b=QHr98C4Qr/O/LVAY/V5oojxXm0hmvbo91UmVAGmb0sf2G5zchz8UYzKmhO9ZkSPRTEUDsGsHn1bd3UDkgPdEG7f//g4wMYYeu9bFuYmpcYKExb2mUgdD9AHtJZIKEl5GODWS/RqGu6jBuRVszH8Ci2v44CdRwPDWIyZn8mz44NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525341; c=relaxed/simple;
	bh=wAsE8LGrUEfBeXm66uKdWKnnjLKWSc1oqBzrwpuwZCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTuzaQQpMpEOocqUz0NOJfeEI14FUWQl8uvrcPOjrBjBb4PF1elaMBKkUPH+MGnouDjEvSuwt8qPITCZ5KPc0p72jj9wQKbZ15r9X8DuHn7pgj5ztbnl7qTbJPElqu1CjzJzuypIxFxKQtFPoe7c+trQfRIG8o40QHuJwDp7O8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ve5cxrmI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3EF8240E0198;
	Mon, 21 Oct 2024 15:41:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nXfe_jRvW30d; Mon, 21 Oct 2024 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729525286; bh=fDUdy3eIlzfoYTwfYO1D0gB41SS4RsAByca/KGWm2lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ve5cxrmInJIMHXSqQ4wgBjvK2nOXmqKCkZZ9/qQTQOFLmzDFDSVU352HYw3dOahIn
	 Nxxd8CvwEVR1FF5l735dascMsgFovFfDTtu2gwiag8HipoI+Dbh57NzRQTMBmEUJDz
	 B1H6ZLd45+CiIljnipBPZVCv7eBsHumUsfqaDiyy/MU0PTGfWyuXhrTMWqaG7wTKFr
	 h+ZuO6j1bd4HnnsuC/fW6iO1JiF8jKhgEYqetCsBxVzKRRne4A4WLQIuzxj59lEluj
	 C7VNx+P/AJq+gOT58Z4t0rdd0jHNFQEhKn3g293DoPy8DBlDg7JK1zeJeb0YpVIw8a
	 dnK6HPgWDAEzffOlRfSz6bD/Wyhrc3GTP8BiQDfTgUKezuADUl5bTYH6rzFOY8EeB1
	 HwYbtuuHUP3Upr9SY62ki0RzrjHe2/QljtH2a5fd5bdEbfJnE9dH/icsj7XruSdOfi
	 kh8i7V7X7QpGvP04ph5N2gMpCdZ7KW8sktVADyyGLrdwbUMHhycyV1ldfVTKohHY9a
	 vk+zpB54S53sh77dzRIvA0p+4a8ILg/2ovIbY99mXX2ZedkTgU4XI/uW0gL3e5o1Ti
	 +fBWs1AVKG5tvUKykb4pyOYtZPb/c9TFVKbgeLfsSwfPN2KVq317LPRZdwVdEQQVZ9
	 Uhu8te7Nw2SWwC0tdslKuOJQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21BD440E0169;
	Mon, 21 Oct 2024 15:41:18 +0000 (UTC)
Date: Mon, 21 Oct 2024 17:41:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 2/8] x86/sev: Add support for the RMPREAD instruction
Message-ID: <20241021154117.GFZxZ2HbUPG9ux8bYr@fat_crate.local>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>
 <20241018124118.GCZxJXbvAIcEak1gue@fat_crate.local>
 <7820cd89-f25a-4934-9597-d53e861d6e92@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7820cd89-f25a-4934-9597-d53e861d6e92@amd.com>

On Fri, Oct 18, 2024 at 10:14:04AM -0500, Tom Lendacky wrote:
> I don't think so. RCX does not change on output, the contents that RCX
> points to changes, but the register value does not so the "+" is not
> correct. The instruction doesn't take a memory location as part of
> operands (like a MOV instruction could), which is why the "memory" clobber
> is specified.

Just confirmed it with my compiler guy: yes, you're right. The rule is this:
*if* RCX itself doesn't change but memory it points to, does change, then you
need the "memory" clobber. Otherwise the compiler can reorder accesses.

> For RAX, yes, if I set "ret" to the input value then I can use "+"
> specification. But the way it's coded now is also correct.

If you set ret, it means a smaller and simpler inline asm which is always
better.

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

