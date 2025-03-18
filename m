Return-Path: <linux-kernel+bounces-566561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE41A679C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E6019C39D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CDB21146D;
	Tue, 18 Mar 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iK6yxAWC"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D9A210192
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315721; cv=none; b=K4z9aAU6T2y8n9ldOB8XTXYz84nzbUJSWEqkJtlKBAs1Z8iMargahRnAtFnSeolvuKVhhsgLWFoJV2BiPBjVxUtwr4LYLXjaWYNxkktMLHQohYZr7+ZinpOgeXI2yA17m/bRe9z3s7SzJkfS9XpJB6lAqV7rvw78JZBTaWojVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315721; c=relaxed/simple;
	bh=AQIVXPZEENnQ9IFxHB3W4UszQu7Huv7yd1lANNtGaO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEwHRfkdanUyPXGegE0c2hQS8xC8VbAkvi0JghvTUrqn0kJIJlLzmskdORDi3aTV6Pks+lEuHw8XsaTxyIGT6heCyELvvBX1jUOt6xBSIaka+SriklfjP1e2grbQypy34XjuGOAgCRzMQS2NLqbdcDOWKg5MA21MSMcGB83pugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iK6yxAWC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BB2CF40E0215;
	Tue, 18 Mar 2025 16:35:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EkqJyW11GZKw; Tue, 18 Mar 2025 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742315709; bh=gkwjJxXEprO6PPh6kY828z+RnmJ2tw3wS5FUTaCU2dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iK6yxAWCM5yYF0B271B6eOct2FnVFk2NwAalSUhioea507HKrC+l0zfWMm9GIGZKT
	 XQT9+VDHhY9JHszs/9SbxCoM2YjvCEUCYfpBbFqDjDVUFTMfwwvEWl6ujGd49qgZgi
	 5ozRbKJsSr7rgLa0jdPsb+fz8Yb+HbupOa+yG2QvAFAThjXcsqibgryk+asu090tBs
	 YoqKWxQCA71lek0J09UA/5H8AroXAd9rt067vO8/H9pBaMEfzxlSAijEWKi52oHFnb
	 IqvB4YCElqDrNhARoyK16t85VNn9Z94YiyBaWuxWagjfR1MWU5HOAiZbkNJ6+rk59B
	 WU4GCQUQFkjA858YDb2uykLK8YxXo5ly+OwJffDuK37AW6LslJQUO+2pSKYVFjg51a
	 py3JSNztq7h34bT9wTmwbWvXIh57DZTS//IhFBH1PbwuegzIqaixRcn0DtZyhyMCnT
	 D0CTS796qvB5iCpXsqY8TpdfWpkUomPXqYRQWTtNUFBAqsTml7GnW2MmOOyKLRArT2
	 dC9V3E8NisBdO5UTqr64emv1tkhvwdHIkXvtnnSlqZJS+mrnsGEnYpCO2sNdyMutsR
	 YL5e0pcL2qeGugTELzLbAwtDb2PaZMuu8bb7KUEmdh1fy8S6elhdMnxWXBqfQnNwTJ
	 He3luq3YqaGCE7v0xd+DPFhE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A3C0040E0196;
	Tue, 18 Mar 2025 16:34:57 +0000 (UTC)
Date: Tue, 18 Mar 2025 17:34:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: David Kaplan <david.kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: Re: MMIO and VERW
Message-ID: <20250318163451.GEZ9mgq7XsE1kIyiSy@fat_crate.local>
References: <20250310164023.779191-1-david.kaplan@amd.com>
 <20250310164023.779191-4-david.kaplan@amd.com>
 <20250313093617.GHZ9KnEXpdM4dwLYFz@fat_crate.local>
 <20250313192606.iijythngqtpx4tyy@desk>
 <20250318141659.GDZ9mAWwa3dkQDHkCk@fat_crate.local>
 <20250318162505.3ptnegnjz46hchep@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318162505.3ptnegnjz46hchep@desk>

On Tue, Mar 18, 2025 at 09:25:05AM -0700, Pawan Gupta wrote:
> Rocket Lake, Comet Lake, Ice Lake with tsx=off only require VERW at
> VMENTER. There are other MMIO affected CPUs that are not affected by MDS
> and do not support TSX or disable it by default.

So all those CPUs are only affected by MMIO and not affected by neither of
those:

TAA, RFDS, MDS

?

Or is that the case only when TSX is not enabled/not present there?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

