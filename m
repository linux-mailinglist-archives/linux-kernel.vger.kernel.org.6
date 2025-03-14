Return-Path: <linux-kernel+bounces-561291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC5EA60FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F9197A9F59
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D467E1FAC25;
	Fri, 14 Mar 2025 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UqL5ODX+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA01DF98D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951251; cv=none; b=f7CmtE2cN+2SUH40WIFqiaUGM/D5GQCqqVAhmz5UmQ3JTfiKTwvdEWJ0v6x2Q6uHGbyzcaF8NSfriwFQYAxjkTC+KyTBoI7yB4ptca+6OX7AMFoNBGOtAOuwplP6rLqRang9e/qvjSdx5UMJXin7/fR9zScPQ6ikFbZfY+Q15DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951251; c=relaxed/simple;
	bh=GLBU19BS914GDP450Fsu7k8YR+2SI2S6y6Eug8U0YL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCGzufVyoXv2KP/fHIdgLrMvqllhzbFgLPR1PA2jQW1VahtYesiRXPAA7By5t87EI7/vG5rxWZJE1S9E9E4StT+zNGjDiQ5I9vwaVMOWVKHmFzsxHp0/hBOEb1TuoTvE1yXhpzwq/aCrptwnLTri5bWmLiAA4wrooOgnaaoUurw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UqL5ODX+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D639640E023D;
	Fri, 14 Mar 2025 11:20:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qzoQXnZ3BGTz; Fri, 14 Mar 2025 11:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741951232; bh=lRcPAYpiJ1ZQzNiz6UtfiC6wOyuTmfWQupJzg8eNHMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqL5ODX+oX5Fe5uxeY7V2y+QszXhb7lZ2/azSVl1IZPCRCv9Mu2QrrAmESURBhuMY
	 NLe9Rgw7iT4AV5OobW4i7PqP7NUTS4aCZUfIn9/cW2Xk8rqwHHwym3mSojrFZRT9SN
	 hGhm2BsIGdRHOs0H6AS7pa08d1UKR3V2qWwz5dQGB8fg9EXfVRl9eXRG9WABNJjNFV
	 SxOjFLsMfc3ukweD2cdovFTe/eHZ6iLkG+4dK5lyVB5VZsc2t4wKS6oNsCl/f5FeFQ
	 WKe8Oc29ySuWVWjpaK8rh0CZJTofqpPvdH0KpJCCz8Fb+cQttTBO386JOr+NSeTB79
	 /htGXVLQeuOFPHHzO7BbMYRkA/yW3+dcSLQ44rT8GDRBge+VyO5Zujcun/PyT3sakK
	 voHKMN1wxJOgqh0Ch2KWd7zRR0SRtqiwtS02IaLCKy5TBYs4P93lihLp1bLhM55vVy
	 l5PjF/2HBihLhqBa4XYVMmY9oXHj9kg7zNha71n2dtKElnE8ZS3HWyRxHU66vvfWvb
	 7KMKLAaULR62ndMH9W8rMQn/Eg/dFfDm9Zra7L/3M8RLESio0eeIaLVSGeRpxrIoVd
	 n/sbzP7zpTfd2IWcgwtipKVPlpPLrqq6eFqmFhJ76EJcStcpjxc5RtagocJgpMuzfe
	 qfB1Rh6iRF7wmBTepk4pTR/8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9FE440E023B;
	Fri, 14 Mar 2025 11:20:24 +0000 (UTC)
Date: Fri, 14 Mar 2025 12:20:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/asm: Use alternative_input() in amd_clear_divider()
Message-ID: <20250314112018.GAZ9QQ8hPXt2Mk22cG@fat_crate.local>
References: <20250314081453.565859-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314081453.565859-1-ubizjak@gmail.com>

On Fri, Mar 14, 2025 at 09:14:38AM +0100, Uros Bizjak wrote:
> Use higher-level API to declare assembly with alternatives.
> 
> bloat-o-meter reports no code size changes.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/include/asm/processor.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I'm getting tired of patches which cause unnecessary code churn. Please stop
this. If it ain't broke, it doesn't need fixing!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

