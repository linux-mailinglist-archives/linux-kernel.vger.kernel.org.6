Return-Path: <linux-kernel+bounces-539930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDFAA4AAF5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3545018976E1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D3F1DE4D2;
	Sat,  1 Mar 2025 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hhx/cgP0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96711DE4C5
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740832711; cv=none; b=kPTb94e9LJuJWuo2I3k3Bp9NkLuGocFj5PIn7I5QsKgXJR08/q3pTAsiJnRMDeVVEF2x10wsLyyiQGYt+IDDaeOPQtQecIKJ61ykeHYHQzcAaiaPdWFXIjVXIqKfGjnNJZMQUsod7B8VL4L6OpmRL/5ZUiV4JOM7v5fVVmO5hOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740832711; c=relaxed/simple;
	bh=/MAYFdTg2s1JIn+YeMQLNYPys6T0G0qZaPWu6aGY+Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3iRyROynGoeP2DyBAUJ/OZ1p4+P9o36ZM5QxLKtC0Nme42JhF0/BQRK28cqfs215FkmdmfzRCc0cduvd4pofaV3x43oK7MFXA/l2/JYvQOjz67YaCMQI/5Vo4SHhg3w4S8Gdz9VTVb/mXA5qCGpHUbJXRkUr0XOebkPaTinmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Hhx/cgP0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9474D40E0177;
	Sat,  1 Mar 2025 12:38:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8FIDxid9khlg; Sat,  1 Mar 2025 12:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740832697; bh=l3U5Q56h0Pc9dYo8E9WbSuPE5G7BzgNui4LMlQOWpYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hhx/cgP0bRWH+dVf84Zm34VzdOzQKLTy/rmp4n4Z8i6A5gKV5lCmh8LrURK7zHUQ5
	 x26tiCj4U7Y6xiTjxuZzU0JotrnBMDQtQE9TyiE1z2hCOGSL8sFeaJsyVnQzT2ji83
	 ax85mQW1PCljRZ3vEm/wjLohOEj/CvS9YOy/SfrMp48apQySAB5ZPszBNE0VWgU0dx
	 DklqMdS1TkQrKxO+yHOyVZzAteNpgmXSQcoB+JUFaf/oBBHmTIK4YMoQthra1KgNi7
	 GOS4OHZq31KPzffippMYUeDbmgJZbWJVDCUUTD1+odTS0i/tFPh3V2KYtD8vfI1NAQ
	 RQmFgG9WDMzA5nk1RdIGtzhhGV2oZk3wmh3NWnEMBUAxCA8KCvrRHJXPWyLDJNNyoc
	 FcmKkRbRmjwldsPNlKrJtiLdzdwhxUebu7ZHdtg+50/UrGIHp4ShSYkKtetFcEtA7f
	 r+zLh0SRMCLXU4NkHqvvTy7sDjhxvqd6e4ofCNLporJwt9zncOa3/6ZkVXrA/YPVv9
	 mdfJiE5TdGD/jdft6p+SMtt8MWMk2IadJjBQPuMuuK8ZwTf6DZJZ0MNNxLWMrs7OYS
	 ZEjFXTnJqWdCTpFRg34ZSvjEfBPaL+/30xlxWoLlsgvB/d4p82bWPD0LA2rVwAzeC1
	 4Z865wfuZYp8vdPUjzLrfdyA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEBE840E015F;
	Sat,  1 Mar 2025 12:38:07 +0000 (UTC)
Date: Sat, 1 Mar 2025 13:38:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
 <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>

On Sat, Mar 01, 2025 at 10:05:56AM +0100, Uros Bizjak wrote:
> OTOH, -Os, where different code size/performance heuristics are used, now
> performs better w.r.t code size.

Did anything change since:

281dc5c5ec0f ("Give up on pushing CC_OPTIMIZE_FOR_SIZE")
3a55fb0d9fe8 ("Tell the world we gave up on pushing CC_OPTIMIZE_FOR_SIZE")

wrt -Os?

Because if not, we still don't love -Os and you can drop the -Os argument.

And without any perf data showing any improvement, this patch does nothing but
enlarge -O2 size...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

