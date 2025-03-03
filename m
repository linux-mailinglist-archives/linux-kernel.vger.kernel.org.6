Return-Path: <linux-kernel+bounces-542198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB005A4C6DB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B335164C00
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43047215186;
	Mon,  3 Mar 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f0Vmiue8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19F215065
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018396; cv=none; b=mM9M/r8HoeVUfh33b3TGd9/VL3Asn0dNB6f7r42at45YXROD7W4MLyBtE0V0sLoIv8zOBe+dmWl+3CfYTDmyB3TogPmmFoaW8d9m7OEAiQUtcRmMLueva7c31lkG3IGqtsBKaFKvDicBpLRC11JAcxNqUxAxrD6/a64D0dY2SqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018396; c=relaxed/simple;
	bh=k7qdz5Qv7WS7LsolcJ7m5YgxU3ZRSOvH64UYTQvki20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czjCNJpcAepxFD8gfugLfdNkIlz1KN2pmOsSPIadiczdnK61SdbvWADTXl1famTSZp967sVa5Jy+7n19leZ7OCZXfrJj/Qrs498dFOeFS4HJwOs3ZrAM2+JFdyCtDaCFIz/5f7UKzMsUWBzpBi4lLzKzsr+XZao5nUSTnHPILW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f0Vmiue8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CD8CE40E0216;
	Mon,  3 Mar 2025 16:13:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IsZcfeCl6fyz; Mon,  3 Mar 2025 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741018387; bh=a7d3OQWLlYtIW0Sa9YO6WXK8u1xaFpZbNw5AxsoA188=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0Vmiue8VOK/s5vvq1xnKXZaphj2JV1kNdAUdnMehcMmXKLQXC6xz59IqwNwmq4/Y
	 fuAlUJOjGFj4GD0GWADa2kex0oQPXDPQe/9Bi4Wv+a9mRM573Ou0y5VG+loTAWFDe5
	 gVSV3ls+pwj2sRe2ZPE+77Anxv3tziyu0nBR2llbsBpGkICq1QvezWEzw0qaKihpK5
	 4bU1GUS8gBnuTXC3E81ih9KUYAnLjI6F0fc4A9aFJd0vUB53KG/M5tQPwdu7nUoxw5
	 8wwn5FZJviPvvSgcA3OMaSPjqrPPtpj4JZ+vUg3tpoJw4hNJOGFyUg2OMlDS+UKfev
	 2DGYJTTVgEeVkUhfYty+OLoc0D8ah0sweWMB/UlfU/kanwGEv3f29zA+Av6HhHL2qh
	 VxdpcuIq6NNTq2z3un8PK/+NXJmJy3TDfJvuATszxUASAht2xcRLDP0sTZGJ/qoGcE
	 no8jNudICOLMeEIAFCz/eIoffo1k7JL9Bp4heBAxH1eCmWZM63BniEOG56PTmkq9qn
	 CWjIJVG73feKBmaYK0qlPUYse+jl91sf2VoYDSescReux2iz3gkF/5RKn1KSjk8CiZ
	 6tTFp2IW0LPUqkVQTJB0hO/7skh4VYSRqBPNtfEtKZhsv14oKEIZR8HJr/Yyw/8hNf
	 XO7NGaxpOBktUAp3fztgkcg4=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E56D740E0214;
	Mon,  3 Mar 2025 16:12:58 +0000 (UTC)
Date: Mon, 3 Mar 2025 17:12:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] x86/cpu: Followups to adding setcpuid=
Message-ID: <20250303161253.GLZ8XVBbWhTG36m3vH@fat_crate.local>
References: <20250303-setcpuid-taint-louder-v1-0-8d255032cb4c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303-setcpuid-taint-louder-v1-0-8d255032cb4c@google.com>

On Mon, Mar 03, 2025 at 03:45:36PM +0000, Brendan Jackman wrote:
> To: Thomas Gleixner <tglx@linutronix.de>
> To: Ingo Molnar <mingo@redhat.com>
> To: Borislav Petkov <bp@alien8.de>
> To: Dave Hansen <dave.hansen@linux.intel.com>
> To: x86@kernel.org
> To: H. Peter Anvin <hpa@zytor.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> 
> Followup to this patchset:
> 
> https://lore.kernel.org/linux-kernel/20250218-force-cpu-bug-v3-0-da3df43d1936@google.com/
> 
> Note that some of these changes were actually a part of that patchset
> originally, but got lost as the v2 was merged, apparently due to
> confusion stemming from Lore losing data.
> 
> ---
> Brendan Jackman (3):
>       x86/cpu: Remove some macros about feature names
>       x86/cpu: Warn louder about {set,clear}cpuid
>       x86/cpu: Log CPU flag cmdline hacks more verbosely
> 
>  arch/x86/include/asm/cpufeature.h |  5 ----
>  arch/x86/kernel/cpu/common.c      | 62 +++++++++++++++++++++++----------------
>  2 files changed, 37 insertions(+), 30 deletions(-)
> ---

LGTM.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

