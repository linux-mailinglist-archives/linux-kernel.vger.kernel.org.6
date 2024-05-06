Return-Path: <linux-kernel+bounces-169475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E375F8BC938
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38DDAB20AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6041C140E4F;
	Mon,  6 May 2024 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ieS//Zr5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E98BF3
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983175; cv=none; b=gX2cYbSewDCCQpKC9NFQ3w1taS5tLER/SwdpNJxIIwyZrrGn/k+5vufBJf9hR8EiIU6FOLiDxW8Xe9Aa7JwbDlz5zCYKczhP53+Z1m3pzLcOWbDIYlzK0yMFD99Mem+Mb278xCCD//JC6O+SOpIzsk9PwCB6JHP8fkzUca4mjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983175; c=relaxed/simple;
	bh=tlifZld/ZHFHDP1x96eddbXPDbjSerp7vz4ooq3f81Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeTE+avI3Rz94JMlvLooxVV6VybiyXY6PFTaVZRilCQYBKl84qD/hyjHu+ZgY8tsH+ncwOuvy43FkEBTunh6N7XjBidIqEIuWR5FqSUv+Nos+lCP4KSicnJpFWjmYsO/SbcOkVZMkvih+qLwjjczuZncur2nsGRbcSS4g/H5FqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ieS//Zr5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2736040E0249;
	Mon,  6 May 2024 08:12:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KCmLlzc50hcT; Mon,  6 May 2024 08:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714983169; bh=Fn+uWTiXlU6mRzHVG81vOdF0e7pbYvi3kVePuR9cVmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieS//Zr5/nS/TScQYOATgoiakxb0kMbDAYEfanMgbOqiRUBWMwNSOpwLwH0VVBllN
	 1rxkWWM51Y1Fb2SErdhl0GWdPgYRpMZ+MNwv00hKi5aWLvxOvq6D49TxBvRyx/iEN4
	 xZZA+TumXNs4mKa0bJmPu+OyM7J6SWm+nQiqF1ljYQI7XASHsGsyGx95nMTL7D5WwM
	 qBy6csN56ZTg/W64fx50jdGR0Wzz5QUaivhXBCK6j1pm5MJRGCUEaPHr5kyDiGErhG
	 sy4qJ5QhO5HfI7zlT77j3GmDf9PbWroho0tQm5/kWh3ghaw8yKNBgGLDFyhnJieHjN
	 eNVKTW7hwwiWRYjvvRQivs9vDbp4i9ArU83glESsPGmHXOOhZv7gcyAfJUz6JnPvII
	 jZ45GZvRplXc6Cw32U+ZRxM1lG9kKyUVUyK2IyxA+7N2MRt6Rez11WN6oUOV0R2cE6
	 cJnEwKqWSUEWQbr/U82cRpCP8/4Ga7ZjiYyqS43ghGUhfgq8RPBitL5qpsKNZUqBP1
	 5aFJXVV/sZISnuZ0uuyAwSCsJAiY/8F3IIl+CeKffpZ4+SgzdTt7wsz1ks6njGhfkc
	 HJr8NIkwl1+eZcTDYQAWctN3VUCeK1avKFLlp5cthL9+qUWtMuJ4T+UQXIHEBcuTq0
	 uwQeqcppAt2f6YdYlmfjAyxs=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8E5740E0187;
	Mon,  6 May 2024 08:12:40 +0000 (UTC)
Date: Mon, 6 May 2024 10:12:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <20240506081235.GCZjiQ8-MC7wL7Ue8z@fat_crate.local>
References: <202404302233.f27f91b2-oliver.sang@intel.com>
 <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
 <ZjE7DkTBSbPlBN8k@google.com>
 <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com>
 <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
 <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
 <ZjiCJz4myN2DLnZ5@xsang-OptiPlex-9020>
 <20240506073903.GAZjiJF7BQyjYJQLYx@fat_crate.local>
 <20240506080156.GBZjiOdHjn-NdmbnTw@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240506080156.GBZjiOdHjn-NdmbnTw@fat_crate.local>

Oliver,

does the warning go away when you run *only* the second patch?

I.e., this one:

https://lore.kernel.org/r/20240504125040.GCZjYvIAK9_DzKuHXh@fat_crate.local

?

I think in this case, it'll make sure that the misconfigured system is
"reconfigured" properly wrt VMX etc...

Can you pls send dmesg and /proc/cpuinfo from that run?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

