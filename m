Return-Path: <linux-kernel+bounces-220028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0104D90DBA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26ECE1C225D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB1E15E5D6;
	Tue, 18 Jun 2024 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fc5dIQSc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FE156F25
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718735822; cv=none; b=c14hyvZIFowiJw5EvVWqR11Igts+orm1GZB1fPY1bsJWupnENDMfd/54GMcCdm2UcWt1Ius7XUefPvCtI/nj8G9llv9xkVm3ZZ2ZCZ8yB0YjN+QWD+VBO+g/vSfYIOyQuJQ58xwKxgabI37R+6zjW+XFx6ff1o/gU/W7Q4i+Yc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718735822; c=relaxed/simple;
	bh=6dqI5FMicCFOtzWkymzM/4W739wxDKCyS1QKnMAJiE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzYRYaB/4aMDwTqbJYDq9duBtOWsf6Dg0liAjO+ZT/EmMC2eD/+rV566LgtwJVZTwnZbU28x5tOD30NXtu7hViv5Rt3P3VbCh05c3T1hUdX685HzxkEgQomgVPETeH8pEXZKWlobelHUqYmV3jJD/Njv72l/rV4rTTvopk/qgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fc5dIQSc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 877C640E0219;
	Tue, 18 Jun 2024 18:36:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LRW06gXU3vjC; Tue, 18 Jun 2024 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718735812; bh=v4ekNk7M9X1ZXaB//Hg4UEVPT3/BcXHuBouv1vwQ6ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fc5dIQScYhhPk+Y6M37kp6LIA3gBSoFpIOfuwav9kNLME7pOyQm6O1G4ZuuoxT4OO
	 jZAjPtiC8657tnCcNFp3ncr+F/sRfhvztGfo+RjMdaKk0OdLSeOzEaOEiu6LZLYo5u
	 lXnyXpNcjNFy68bGGN4vbxhZBoKNXVunW5ANJZE/6HHI3sRU8t7vVPVyGrJ3WjDBVR
	 VdpL1JITEYa+rB2omsfq2t5pxNjqvsBzaae7FI9afIfJOOghM/XeicAbICLbeh5dTJ
	 1vGFfiGRZeASt3hMTE+fExhK6elB7JU9e6x+QXOeUC/KAyCETSQrNVMwQPfaZ4jfDi
	 JY8Li8mGQU/KY2kqqBilmdmkqrLTPojuQ7fessgl61QVvS7q1vr82Fr/spnm0wMFmK
	 seGN2ZAjqEM5Uo68JGd9tXyqM4obsH9DmMfUuBHhPPnI/VCTszCLFFAS2DJLKw/bvP
	 j3OnixlED7Mgo6kS08vGY3DrBYznHIpGXNDChqRB9KxjQds5Rk9ZkgXY1+a5xEnu05
	 AfJxeEjTvzRIHdz6W6ELobQZnoRqnq4n7nPMCcPeLgQz0qReNbQ9x+/1p0YzfZnOQh
	 JyFtqT2hpbdBG/INE5arUsQL5MNvXpaoxdk02CAre35ixncyLO6RTSwOfA3Y6rcw3C
	 MoHa3XDl3oHvGMMgtwV8qu3A=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E166140E019D;
	Tue, 18 Jun 2024 18:36:46 +0000 (UTC)
Date: Tue, 18 Jun 2024 20:36:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov <bp@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/cpufeatures: Flip the /proc/cpuinfo appearance
 logic
Message-ID: <20240618183641.GGZnHTuS2zS4e1fPv2@fat_crate.local>
References: <20240618113840.24163-1-bp@kernel.org>
 <ZnGUVcEUUF_1Vqmi@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnGUVcEUUF_1Vqmi@google.com>

On Tue, Jun 18, 2024 at 07:06:13AM -0700, Sean Christopherson wrote:
> If we're going to churn the whole file, why not take the opportunity make it more
> structured?  E.g. use a variadic macro so the name doesn't need to be buried in a
> string inside a comment, and so that each feature doesn't have to open code the
> math.  Lack of third input omits the flag from /proc/cpuinfo, and a magic keyword,
> e.g. AUTO, uses the feature name.
> 
> There are quite a few games that could be played with macros, and IMO pretty much
> all of them would be better than comment+string shenanigans.
> 
> #define X86F(word, bit, abi_name...) ((word) * 32 + bit)
> 
> #define X86_FEATURE_FPU           X86F(0,  0, AUTO)
> 
> #define X86_FEATURE_XMM		  X86F(0, 25, SSE2)
> 
> #define X86_FEATURE_K8		  X86F(3,  4)

I'm always open to those things, sure. But it'll have to go ontop ofc.

"X86F(3, 4)" is not very readable but we'll get used to it. I like the aspect of
not having to open code the word math. But then having it opencoded is
maximally readable...

Yeah, we'll see what the others say too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

