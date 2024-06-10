Return-Path: <linux-kernel+bounces-208328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6510E9023A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF168B25BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B66D135A4A;
	Mon, 10 Jun 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o1mVvMLF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F194St29"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F58527D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028246; cv=none; b=Ok24as1riqLFmrz1T0pilxw+AD1gKbWgUinUcKWByG8qTQ3aNxtJC7YBd+nwnFq8uuqcpTSk+KgGUoTzzvGQJAvZJrTu22YT2ek4SejZ30nzeHM3iGgjpSOTV5vaS3rMnhfglUsX3MyTAbm2jL+fh2vatxrnorQ5eZqwCMZqVs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028246; c=relaxed/simple;
	bh=ZrqKQLvRm7mDxthHCvl12TNzBKe2zN8dQWa+nPd+8E0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IZ/oYlxCmWmEOujay4XOJlPMEesFW+MLlYR3EK+93yZf9IoOIgGzUizpghaqYiPlpx0jv9iq7r9W2nh+7epyGiQM8RR9a447+Qtd7jxJ6MuhPXYuQ3+hWn9MIZVVuegTtaW0ZmHfHcqT7kT2r7wtpHR6474sYbDYrAPc4mMDuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o1mVvMLF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F194St29; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718028239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUxSHg5fKffszCYYNK+5yxGvTT+l7ZVvoo60IT9JNjw=;
	b=o1mVvMLF1umJ5sr/CQoy5qPCuL8Y2dhkd8iX+WnXHnFp633Gykk2MnPETUpAoxAr7Ek6FG
	euMeaA45INlkIUK0L5eIF0DMuDyfMmiRFL0KaYGw02HF970pemPhl5bB1OzODP1IGOx6sx
	0gSU1EchLHlCL3KbqGbGoNEegmbyXb4v2/Lyb+qFiUdrdpZrnEwmxsLd9+zF1cTwxVHG1J
	8AciTjLlxSFFlOHBmyWD7h7fi7DWHd9akK3F9RPs0rZDArU3UgJbDFsKPKAKUbo1c+Rg1y
	3XKC5QktNsi3XucasM+mOygRI4GZ4qRC4azFd52gbMWy9fxWbxg1E3D18/kLyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718028239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUxSHg5fKffszCYYNK+5yxGvTT+l7ZVvoo60IT9JNjw=;
	b=F194St29QZDEkx/oe8qmwuXvjrXpmv1L/SzGUv/mKr7pfc3QyOSOECYILPBKc9gXRb3//h
	a6+Ax2LdhOy4PFAQ==
To: Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH] x86/cpu: Move identify_cpu_without_cpuid() into main
 branch
In-Reply-To: <20240521124823.486372-1-nik.borisov@suse.com>
References: <20240521124823.486372-1-nik.borisov@suse.com>
Date: Mon, 10 Jun 2024 16:03:59 +0200
Message-ID: <87wmmwx5bk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 21 2024 at 15:48, Nikolay Borisov wrote:
> No point in duplicating if (!have_cpuid_p()) check. Simply move
> identify_cpu_without_cpuid() into the else branch. No functional
> changes.

You wish :)

> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  arch/x86/kernel/cpu/common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 2b170da84f97..69265c0acaea 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1578,9 +1578,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>  	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
>  	c->extended_cpuid_level = 0;
>  
> -	if (!have_cpuid_p())
> -		identify_cpu_without_cpuid(c);
> -

You might look what identify_cpu_without_cpuid() does and how the
comment right here might be related:

>  	/* cyrix could have cpuid enabled via c_identify()*/
>  	if (have_cpuid_p()) {

Thanks,

        tglx

