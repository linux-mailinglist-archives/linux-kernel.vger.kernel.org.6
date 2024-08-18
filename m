Return-Path: <linux-kernel+bounces-290908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5993955B0F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D1A1F218CD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD656C2ED;
	Sun, 18 Aug 2024 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rlo9R4+r"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01C223AD
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 05:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723960702; cv=none; b=USytZSKqmwaIfRiDWRxLQJfAod4f9/JLvIunazr37D4wMgm/xak0H259y/SW/I6+BemO4xjhRFE8A4VlOvawdeoJUWjkTFMbcEUMeCQgOhcEv0ImVA/uYe2WYaJH0KJV5hl85/H/liMCy54TW6BuoI8rNGEF01xz0JM6E5HwGGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723960702; c=relaxed/simple;
	bh=Pd5zVRa2BxL9VRvKqJTk9LALSmuk610bG30lN1d93uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTpRThz+qc52UuAjv+yVAjrvptsLzT+0IjGKBzBU4zAolPhH2rWUrqXeIuIzI0Vbhoz60iFjEnbkHKoAEy/rcR0svd9ws7cwFIiWqSvYiHveCYEWG5Hs0uOBAwFXeV2dnD/YyLxxNa4RbmW3xjIpngjTsT0LoyFHdoWkwPSGMDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Rlo9R4+r; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ADDE140E023A;
	Sun, 18 Aug 2024 05:58:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8pWNL87LZZqS; Sun, 18 Aug 2024 05:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1723960693; bh=lU15jTPoX4edFZPDxB5jGPp0bDvR7Y5rlAKU0cGjiJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rlo9R4+r7A1OLKzwbaJmYWwQTXk0U4nAlXCdq/nq8N8ag85/kyoIFWrxvJhsbdIMW
	 GG2NCD/qsbKv1QELjZlO+aaBnCGotSH8VL3hV+D2Ud1BhbxEi74A7D/PtlfMz/1wyl
	 4pPvfvBpNLraFml/6JdSZ75fgZSc7wYQULxcFN3cAbFnfxClnMIc9//WQ2edyt0NuZ
	 ZeyVXiX3hAeaPQ28NjJ2P3vZ8vL3s6V5mZyYDyKh8zY5zw6wY/WE2xjMaA1olsOwXO
	 sJsvsT2ITPGYGxt2O1iGjYTW5nT3XM4HhPTypepSunVoT6VSPrIUVNvgFtQOqNvKHy
	 m7BGP4U0fBPmh/wS2QO0bnAxXr2alBeJsumDCAXwsTyzJicEHZKO9BrHwE1vgE7VrU
	 b4WucHIpeh8K7+hBPXp1k2E/13msiHhm0bKTIW23ewqnI9EZlnPP4POuMueCehP4nY
	 F/M5xEqDp/J6jT6G4Dgse0ln94NhZi9scftuE5eDka8EtW/Ag0fDwHGcmvz2F+J1eK
	 x/eTKX+IV/ndaJplG5/vskHcL3lMnbnqgyiSmbOboxBr+fAVr9DWrAdd7OZQcSm/gg
	 RUuzDpWZ7NoWCbNuYs9vCb02CrjoBJTb05e+kRqr8bbtnBKwzP3kV0l6IXbSG04o7A
	 bso9+OmzV9UkbmLLkgVysud0=
Received: from nazgul.tnic (unknown [87.120.165.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31F7840E0185;
	Sun, 18 Aug 2024 05:58:03 +0000 (UTC)
Date: Sun, 18 Aug 2024 07:59:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xin Li <xin@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
	seanjc@google.com
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with
 the alternatives mechanism
Message-ID: <20240818055904.GBZsGNqJA2Cdl2P0mt@fat_crate.local>
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-3-xin@zytor.com>
 <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com>
 <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com>
 <DAC74A8B-DDE4-450E-93A1-EFD7D47B25F7@alien8.de>
 <20240817144316.GAZsC3BOm7anUPdJGe@fat_crate.local>
 <46CAFA22-2EB9-457B-BD14-864CFD71ADBF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46CAFA22-2EB9-457B-BD14-864CFD71ADBF@zytor.com>

On Sat, Aug 17, 2024 at 12:22:56PM -0700, H. Peter Anvin wrote:
> Only if the call goes to a C function.

Aha, you have a patch in the thread which calls a by-hand asm thing.

I haven't looked in detail but we have a THUNK macro for such stuff.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

