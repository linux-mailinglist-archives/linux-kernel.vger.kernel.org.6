Return-Path: <linux-kernel+bounces-169954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C45538BCFCD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632581F21267
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90A13CF8D;
	Mon,  6 May 2024 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="G0tlY3Vz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56A13BC04
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004895; cv=none; b=eSvaJ04QZgMxeSzy2A8k67Goid8wo+2rpDVhewBwq9L1QTZccRSk7lxLspgsJcDIFy8IvMwUsH36h6B0uCq3oItSZCyhAj2YdKu0TRhBjGrG7tMiTY5QC0sx4ukDhns7WyJRE4y/6ijHxlb45oSt4+K0/Ex4fWhCyXZ7+KvlzQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004895; c=relaxed/simple;
	bh=o3khOYd3PwvSQuTqNQGOIWO5Gc4L0D6qdPe8N/HPXaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqgHcS+8JleNUrZMip104y+lv1vQYPmXNOhdcEKabVu3JFs+VgE8Of2lB6SXDBQQDPRQFuxCwhaUCA/OSujuNrSyYMr0ixIEEpHe+Ji/baFukkZkMNiZXQuO/J5gEsNGxmRwx3xofdUc/Bmb+f5vNGFLXKJWQEz/PrH7frkSEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=G0tlY3Vz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 721DE40E024C;
	Mon,  6 May 2024 14:14:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id R3fD3o6YRpqj; Mon,  6 May 2024 14:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715004886; bh=fL0jWz0y0MdKTiR0U8jxUn73zBq9bUhbVTopKlDLfd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0tlY3Vz5Xk6BIUXL6VJT6blz9r12hsvfG4elX4H4AzRdPrFwRYyZUlDg1rbozuhZ
	 4UWPvtgiZY7Yu6tDYoLgrh0QYcwCFXtRN6qYq5FgrJ2/uWCN5dmYQP2QR9lKlOyaDI
	 xvncVN/sbMcKtIScUkCOkJrbE1Xhgn4tufWkkfviqJNQan2qijp90xTkaEFih55Sci
	 it8etOB4NTMeWG24XemazBZb024RkQAEFK+0nvhLucPqxCte55SHlURN0eMGttLsFn
	 F5XWDudwGUdPNvkrbAZpWyqDKEuSeknRGIV4/Uc9UE7APc+wZHyTSxC/HiNNjIfhES
	 xwnE4Z2w9TKlXNbvUVAOqTbuNLdwaxZVaQF2Unr7nGExI+kmAv9aA65MmS8xlTGa0K
	 9kHd0936W2XxOwnBjP2EebQyQaGniA1xBBpd6oI7zxoefmBOcbRUDfb/vu4TdXkCmy
	 bupelxG5AOqatUKS8+x5jeCGXNg8EMZ/iQ4XUtfqU2BawEFZ0VRQbtApYU9dkATkUW
	 mNO0kwRrEyRaB+alkZSCtQGD5DFsaSUm3RSKwSWHGVSt77BYOBMPn0cJ2YvgLfG6tw
	 bE0USZunZvpA9d1YD9RQM6HRaafFiSHJlj8crUDXBke48o5XAeDp8SItWd83sv3+Kf
	 UKJ7ZgRm/pts2Rd6t6N+Sb6E=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C4A2440E0249;
	Mon,  6 May 2024 14:14:31 +0000 (UTC)
Date: Mon, 6 May 2024 16:14:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 05/15] x86/sev: Use kernel provided SVSM Calling Areas
Message-ID: <20240506141426.GJZjjlwuQryahOmSJS@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <07266b47e749267ef9a9ccbc9e8e9df78ed54857.1713974291.git.thomas.lendacky@amd.com>
 <20240503103407.GSZjS9n-XMMKi5ZOek@fat_crate.local>
 <20240506100905.GFZjisQTQwbkv2eKsh@fat_crate.local>
 <c4640af2-a791-848a-bacb-071f0bc8f9b1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4640af2-a791-848a-bacb-071f0bc8f9b1@amd.com>

On Mon, May 06, 2024 at 08:14:34AM -0500, Tom Lendacky wrote:
> This isn't quite right. The xchg has to occur between pending and
> call->caa->call_pending.

Right, you can fix that up in your next revision. :-)

I only wanted to show the idea of how to make this a lot more
readable.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

