Return-Path: <linux-kernel+bounces-516406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FD1A370DD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 22:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAB716FFE5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 21:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970501FC0E2;
	Sat, 15 Feb 2025 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VLGcH1s2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D31151991
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739654366; cv=none; b=C2xW6O4DG2dghHq9ndtUKqpRdSW9k4HSD30g9J8c6hlXemZhKPHpH3TuU43gL8HlKbzGjD+RA3SskTvHF+GQ/LMFRZ1OKBtGK/EFgCJGZSP1s3bEV+3tUuIU/XFZWpWAbVSYCW1SKl+SY744yLdCLbuJReG3JVDFeP5thaXtgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739654366; c=relaxed/simple;
	bh=yeupGRQ9xaR4vcEQEwmDHpBddulgXx/NwCdmtnFRrcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QslgKGXSF1A7Oh9pZdosALhUpy4rUoCgdL2vRMRzIwQedWq3q7v5OqzzBBBMK3F1pzktEdreEz7DxVaS7bwn3xdOFiFCAAQwEcd9B9uUMOQSvf2yBJYbI0hMhEWpFneEf4WhIBe1KxV2sozJD0KdyndQHoJ00WYfPeX9DX5tNiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VLGcH1s2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AED7040E016E;
	Sat, 15 Feb 2025 21:19:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Dt34YWUdv0KJ; Sat, 15 Feb 2025 21:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739654349; bh=UjO8fEv4Wbfw1krkOzvNiF9TkxZm/QMNqBNHzQdvW/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLGcH1s2mp7apbCEL6ufitJu9Y8axRl1RMUV2igKxkGClvHqJ3L81OSbabwV77Rn2
	 zXh07ArOMnMx3pe+WnvCvCGQQH11FdE9qa3xCpkQOFRNzc1KHGW+UxinFdK6uSeNbi
	 Dyf+X71Z39f+CAREUfaLg376lSi1aJeTj1d2TyA1QO708wj+61So3AlLmh1b1ev5Xf
	 vQRgiZERkCZwJbhvPdj3WhHr4jbtORSwckVxBc2AwYQv0DYD3uomNePxOeSQmMNQWg
	 sXRPtMVSFEzCGyq2QWxYL75N8t1/tuPkPfr3ysKxd653LBzGh97RTBQ+dk++zKHka/
	 /qZARJJR0EF1kZDWt/0o7Uo35iK3YK7o+DdvHdG4oLdRWFhdDjNIpYvrZg+8YFMi4N
	 YE3CqbPxrKtYA5g8i9U5iKjS5rmUTTa0Oy8DgNrr2QBC6zvbh1ppukaQ9MYFwOD5b4
	 4qHaeiXUsByNeVpUAOJBECTvR48fI6gmDE/CUN0t/9kGmRws5UYRGPWgOTnxQtIaUU
	 pryBuSNF/nkLUl4mWG0wfenk0OTW9rRpjZN0qoloBfh/SxhPQSlgpMMp3wbh2bpC05
	 TmU5VCAVuX+7kJabq7uAzbDx1PCpOBTolK+EOn0tp41C0jS5PJrUtM5BEU3geo2yhD
	 GACm207fl+skDY43tZKStAwY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5524440E016A;
	Sat, 15 Feb 2025 21:19:01 +0000 (UTC)
Date: Sat, 15 Feb 2025 22:18:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH v5 08/16] x86/stackprotector/64: Convert to normal percpu
 variable
Message-ID: <20250215211854.GFZ7EEvlYTQ2USmKiW@fat_crate.local>
References: <20241105155801.1779119-1-brgerst@gmail.com>
 <20241105155801.1779119-9-brgerst@gmail.com>
 <20250215142714.GFZ7CkQtdXoUM-xKMo@fat_crate.local>
 <CAMzpN2h05N+KZzpFY6YXZjMViK+_U9gks36mOfRJpSOMY-Xm5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMzpN2h05N+KZzpFY6YXZjMViK+_U9gks36mOfRJpSOMY-Xm5A@mail.gmail.com>

On Sat, Feb 15, 2025 at 12:38:21PM -0500, Brian Gerst wrote:
> The convention appears to me to be that all caps are used for global
> variables used by the core build scripts and/or exported to
> subdirectory makefiles, whereas lower case is for local variables.

First time I hear of such a convention:

$ git grep -w ACCUMULATE_OUTGOING_ARGS
arch/x86/Makefile:213:  ACCUMULATE_OUTGOING_ARGS := 1
arch/x86/Makefile:217:ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)

That one should be lowercase too I guess.

> PS.  Please comment on the most recent patch series, v6.

Ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

