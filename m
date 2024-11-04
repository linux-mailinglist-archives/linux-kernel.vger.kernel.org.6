Return-Path: <linux-kernel+bounces-395072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4DF9BB817
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C69D5B26B73
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7FB1B4F1A;
	Mon,  4 Nov 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bt8ykE+e"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905EB1AF0AB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731215; cv=none; b=AttZ4R0aNqSN/drM5rzkTVRIAvqofX11WnfbOaMSMI8bFj+psKbfNG1Mmf++BYKH8m1D6+CM8VV5IaGhGyIZEYAuRyU7CAM0bXhIjT1lATZ+SNlUrw5icjYk/VT56bihWaYfshOVvRWuHEN6vgWWX0cKgCZVXKpK+HW7L+5imVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731215; c=relaxed/simple;
	bh=mbEFcTeLpazBklu86dgTbWQBAzM+hhojW18HHKuO5uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxiKfOrR+OUChOjDsr6DzdKUFlLIt4JhgLP5Ox2w8R0Chjb7yZHqqxomF/OvjQF9hlO2WWEa1dDUZotnVeCRylDoFHQ4kExDgCSl5gbSsTTdsDDgFds26St8Eua+TzNXuZQO7bFhlXMgfjm3izVM7lE5wmhU63rPhKp3+NyNI4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bt8ykE+e; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7F57A40E0266;
	Mon,  4 Nov 2024 14:40:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vvcktfFJ5mVR; Mon,  4 Nov 2024 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730731205; bh=IpXSULfYxe5S67eIZOhoJ9H56CTaTw91SbykTtWOlYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bt8ykE+e/EQta5ZNxa7q803WzLJ04JgUMIVhYuFyEDf0bAMllP9C0NV68VXJtWePE
	 RwhYlIs4qEnW7dOoJrwymAL2sxTjJdZcK3SKCMjqIuVBSH5Ioej0IiwWt4bpxFl3yW
	 Hmk1rh+buMZxCoOPA7Yoe8r3aspRMwDXFWGsI9ipxUHEXvgXbMeEKl1lHdhYIe1e7Y
	 fEtMsGZUOtx668nviAvKdYsfyuFGu4k4/KAX3Ox4PFl0iFPcCLUzr0OeB5NFaVmJfc
	 6RzzeKq9nHqSBAEeUEj79UDslqnd/t2tSVZn/iO54ice5wTnoKfD7XUGVr1TlUyghk
	 RP5yvBgBQ1mJ80OdLYcK+7JR7uecOtdVc8blT9rV5wk+l7sP+5Rp1NE2LTnF2jSbGm
	 oDjnv59ThOqo5r78feWD+tAKY3czh5J4IVQJmMonR+7T61x8FpWDB4WMezf+3Jscqv
	 nU7CyMvK9Oq1enmNlfPUdL6tSLFPzeshQPH7VnBICcb1J2cR/avApgCRaXQOGF6uZJ
	 q5fpq8uBnGlqNtstOCXk3Heen3JTjYGxu3YRyeg6PNp8jEFPqTXM+1cZvsCqKOxphr
	 uUYDZqnl/Ii9jI29bzKFS1zfgkhUYpetl5A16q9BjONdEmB8iAUaJXm5V1SFwvmdIQ
	 rPzmMG+F7wnYKh3NXs4aQJsc=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 887F440E0163;
	Mon,  4 Nov 2024 14:40:00 +0000 (UTC)
Date: Mon, 4 Nov 2024 15:39:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: david.kaplan@amd.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC][PATCH 2/2] x86: Clean up default rethunk warning
Message-ID: <20241104143959.GCZyjcv-UMa84hYM-i@fat_crate.local>
References: <20241007083210.043925135@infradead.org>
 <20241007083844.119369498@infradead.org>
 <20241104114728.GTZyi0UHYKx-ZHL4kh@fat_crate.local>
 <20241104142953.GG24862@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241104142953.GG24862@noisy.programming.kicks-ass.net>

On Mon, Nov 04, 2024 at 03:29:53PM +0100, Peter Zijlstra wrote:
> I just realized all the rethunk crap is 64bit only anyway. So it don't
> matter.
> 
> But the reason I did this is that we never rewrite thunk calls on 32bit
> (really, we should just strip all mitigation shit from it and leave it
> to rot).

Perfectly fine with me.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

