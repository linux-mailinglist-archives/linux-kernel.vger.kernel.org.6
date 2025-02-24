Return-Path: <linux-kernel+bounces-528241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714E4A41559
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C753D3B3F09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBC31C6FEB;
	Mon, 24 Feb 2025 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cmTI5j1G"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5F1624EB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378629; cv=none; b=SmuX2nODQkT37TeKV+945Y5fug5GnvwjhcBy6ZmVIUvr2wizZKjRYWe/W0M7Vt11hxmDO6RsmTgOnDgwlRmLoGTkCqUpwBBYYaNfCWLVJtR/URKVczhqxqavOJuoMjEU/f9+eIHJQXALPWJZ52iDR4C/5PzJv+SAIDgXJlhvIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378629; c=relaxed/simple;
	bh=RqhGGBRE5NFbYJTRzskFzv1kA0HI0CgUTLnqy6ueVuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSk03HNd/UOno09Gtcy4OtY7WnaUAKKs887EAqNWE5950TmJo+odv3TR5mbRWIx0lO4vleLowttPyj9CYbxUQk9y7LO2u3dHCdiEPGzWbbCxBQ+VXuZXmZK8JrLQBVGQOO4WZKd9qODh82eHTimWSj1BrKyGTzWX1d4xAAkXbCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cmTI5j1G; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7840640E0176;
	Mon, 24 Feb 2025 06:30:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vLzVJvdtOWMP; Mon, 24 Feb 2025 06:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740378617; bh=Xh/A6bAFXSwHVpEzrZFO/0i85+oRM4n7APgf9n+PLUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmTI5j1GNQ/5BcKWOpzk3f7pC0lNvaC/Jp5gEZEj8Tdhzp1id65o0HtgdUNwYQ92d
	 /uHVKqaPzNjH6m+lzfcflJv2f31TK/AJ2O2KFxqBdcdQpQi3nIyDXEjKxTya9+48OU
	 oTLBn8e8fvI/jv0VxUQkW1KoHPV1HX+w5upR+ws47awBj4vvfYuoc/tQRP6qEyre8P
	 Za/PzEi4bOgaMkfOmwr2sQc2il084WRLaHAmyIGAJTbSwn3qkSyuj7ccbGzeKZuCG3
	 tDy1gw8Bw+ujIoFbUoN1tu3a6QBLvenVJVFb6KIfl6909PTCdvM1dOK+/E/LGAeU3u
	 UnGCgXJPPDfdZLZt6aPAdsrpxyo9htmYMWTq8X+4aPSLc6P2yhUFMVW5Xjwq51ko9e
	 mZLsM8R1jut+dRhnfgY0cPqrc3ZNDLcWLtuU3Q9Dw1qNBeurfhLiZCXKDmQaAju/9J
	 v86Q0FVdIDj8w1BqDj3uBtFU4OpSacM6B7T6G2jkrsAKVb9z8dZot6VezsrRvm0cfa
	 3O72xRFnlPr5lHG3Zjq7Ct4QiRR8BxJ3DPTTWczW6bBuxbL/ZLyawSeYaoHAOdY9qn
	 ZzvkQmvAWbzP6jycRMP+h6wC89C7XsLSUfBThM5wmvMtyZYaV9OamNBjmv1x1tot7e
	 ufusDzRWJnz33DA4TG2HHbQI=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE01B40E0177;
	Mon, 24 Feb 2025 06:29:59 +0000 (UTC)
Date: Mon, 24 Feb 2025 07:29:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v13 14/14] x86/mm: add noinvlpgb commandline option
Message-ID: <20250224062952.GAZ7wR4LGabATvh2z6@fat_crate.local>
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-15-riel@surriel.com>
 <20250223212917.GAZ7uTLZL7ygSHayYh@fat_crate.local>
 <79d279294bd9dc6e8385495b1ec9abfcfe03856a.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79d279294bd9dc6e8385495b1ec9abfcfe03856a.camel@surriel.com>

On Sun, Feb 23, 2025 at 07:34:03PM -0500, Rik van Riel wrote:
> What specifically are the things you want me to test here?

If clearcpuid= works too, there's no need for yet another "no<bla>" switch
which I'll have to janitor away a couple of releases later.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

