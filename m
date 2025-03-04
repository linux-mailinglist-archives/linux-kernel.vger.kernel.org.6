Return-Path: <linux-kernel+bounces-544364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DBAA4E087
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8B93A67B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD675204F61;
	Tue,  4 Mar 2025 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iugRnl9Z"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464481C54AA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097529; cv=none; b=Gl21rhBL5Bm8MwS7Vb0o2CaCDizECBsb3WwrRP3VDvOojerr2N4nDOFwqXYCuoDdZ8s2qmsnOWHGWH504u2+7voRyoaJiyT6MO6XR6qMoOUHXCFFcx4gJlOD+mAfoyIvmsuDqoO+1Or+9jCHDGFV2irZKM49lK77jC+ZLEGZsps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097529; c=relaxed/simple;
	bh=7MhembS568dGp1bHEbh56IGxZwsRxM06w96ZDrN1cbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYo8EUJ8mX3c81y3oD/62NipmBqD7U9QQ2UebpeOH0UIUbWFs0j9gVeL1ONkCvdxfNgCLwfrZ+YIcFr7BLE6GTWD/8EfMhcfyU8wsvLRN0gTfLyM5n+mtlcQRLePRt8l4Eomr4A+hivEegpRz4BIsCu6ZQxQ0uvEo3tr9imn3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iugRnl9Z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A5F0440E0176;
	Tue,  4 Mar 2025 14:12:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id siwQiVlMLFkh; Tue,  4 Mar 2025 14:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741097519; bh=Suj/DIf2WU/st+uHk8qJo9pIOoEFVqGLM7HCtKjnHLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iugRnl9ZQ/qrcBIg4fF8q694UR8RRd4RRKc5G5rnJ8QQsQZIQLMjcpvu4pMINlBAp
	 vZciO6/dh1HjuhKfAl9jz9tQW2/nvXFjyDNjvOYurYcOCOM/j6lKgPIbgKFGrtf55s
	 rxWqJb+Af0W+qTyCFKUEDpTtm1XXGkatq0I4LPjrv1icHdGp9EL9u6cHLFp86pyEb6
	 qjovicNNwW/Vqke2FrawqpGtmPzZB+jxe+z1WHSA/gNHFuqB5hFc9HSpv1SSKKejAH
	 jGnGd/A6DJfo2PFQSWjowDUfA1Lp1Zv7nrl4rranJrL27h9jv5S+5gX0KzmgzJ1ChZ
	 x4ik0YEToTzMtOAqMr42ofVwtYOyVLpb24A9Dw+w2FYtaJAeaYsC9IeQvFc0ZCvXia
	 5GQ/okeiV5mUxrlwsNPhOrSSSXYQMPzApbdI/zS40mLXUZyKruDrM6CSh8jOgXQUat
	 i+P+3W/FyzNa1lPOZXcujPAGBb1PIfTrM/pbWv2a8GM4gcOkmr0gLiZtpO5+0cLb4j
	 hAJksxDkAQV/X0qBzE0ti4aDYhW0esilWxfxKlJmxSUkqy8L9MBXYhg9blYM+i6HlP
	 IuITbTAR1FbhBMQ7z6JncfZ1aO/TmKFQuhZqF6vzZh6h68nnUGW4ZDefbY/4gSok05
	 YHnEtxJIgmIc681L3YjwMRKA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B5D740E015E;
	Tue,  4 Mar 2025 14:11:40 +0000 (UTC)
Date: Tue, 4 Mar 2025 15:11:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@surriel.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com,
	mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 11/13] x86/mm: do targeted broadcast flushing from
 tlbbatch code
Message-ID: <20250304141134.GIZ8cKFom3W0ChHiXk@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-12-riel@surriel.com>
 <20250303114618.GBZ8WWihMDjf-oy8P0@fat_crate.local>
 <7e1ca8c7-6f3e-44dc-9dd8-bd273a03a83e@intel.com>
 <Z8b3n85dpkz_-2ci@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8b3n85dpkz_-2ci@google.com>

On Tue, Mar 04, 2025 at 12:52:47PM +0000, Brendan Jackman wrote:
> https://lore.kernel.org/all/CA+i-1C31TrceZiizC_tng_cc-zcvKsfXLAZD_XDftXnp9B2Tdw@mail.gmail.com/

Lemme try to understand what you're suggesting on that subthread:

> static inline void arch_start_context_switch(struct task_struct *prev)
> {
>     arch_paravirt_start_context_switch(prev);
>     tlb_start_context_switch(prev);
> }

This kinda makes sense to me...

> Now I think about it... if we always tlbsync() before a context switch, is the
> cant_migrate() above actually required? I think with that, even if we migrated
> in the middle of e.g.  broadcast_kernel_range_flush(), we'd be fine? (At
> least, from the specific perspective of the invplgb code, presumably having
> preemption on there would break things horribly in other ways).

I think we still need it because you need to TLBSYNC on the same CPU you've
issued the INVLPGB and actually, you want all TLBs to have been synched
system-wide.

Or am I misunderstanding it?

Anything else I missed?

Btw, I just sent v15 - if you wanna continue commenting there...

https://lore.kernel.org/r/20250304135816.12356-1-bp@kernel.org

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

