Return-Path: <linux-kernel+bounces-379053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 640B79AD912
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25621283A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D75F9FE;
	Thu, 24 Oct 2024 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="GntUxvsy"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472244C66
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729731661; cv=none; b=gtKD2SsnGiHaNfKGBjd4zC6zho7neH/nZSKh2vDN70LBHujH+eaxfKTXx6NCwUSfshdZXfrE+durza3leVQAfd5YKghQsmR99p8Yzo6olfJ049q3SVx6JW8JXsBQ/fw9MHS/BfWEgVm60BBhxGH0K9wcPYqoLCCXnYxpfSiwbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729731661; c=relaxed/simple;
	bh=6ihKQ7lG45h7E9i0XlQf+nAKsNgsUSzNkxAxGJpUe8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nHYnBYY8bt5smESj1cQbnfgRjFuD8eV2h8/0DItCguePXX8KhAJOhRW21bnkQ5ML2MW63wiYpZUuO/KLRC8CVUTZYJBaTqfrMS2oDKkctS0f0qiC/swKDr8z3XPWOZ8s1On77HlWpQnFAR1oi7U0clm/wIIeFLR0iA1TW42NEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=GntUxvsy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1729731655;
	bh=QPP8lMdImGnpze+KLmb8tb9ZW/JrJc8aKQY7EcZ6aeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GntUxvsyQdRW3VfYIphe+gObilkKDKMv+qFKK0StjmO1Vedbrka55JqmXjpfvSWyz
	 tVoOQDpsnXzgUb1mK5TGlCys0cQVFIF67F2pRlBOEqMLt905bgcjTf5cRCScA+4KNH
	 mWf1yst7JW9o2TPNw8cComNZtbqNiNXkAylmC2vbM3wvpKj4Ks3vbNY8lmBZyVxiCh
	 t76Ba8ozScVi0gJe2sE1NbNurDcBf7RGHfZND0OIeZKpDunAAuELp96NacsCKd3roa
	 bKROttIuAVAerBOHOsjskk4GFEvDsfrpGd82Y9J4n8ySP77tVICjBJt5l7Ovla9/QP
	 mysekkA0fVpYw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XYnfG3qnsz4w2N;
	Thu, 24 Oct 2024 12:00:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 maddy@linux.ibm.com, peterx@redhat.com, groug@kaod.org,
 sshegde@linux.ibm.com, mchauras@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/xmon: symbol lookup length fixed
In-Reply-To: <20241023212225.1306609-2-mchauras@linux.ibm.com>
References: <20241023212225.1306609-2-mchauras@linux.ibm.com>
Date: Thu, 24 Oct 2024 12:00:53 +1100
Message-ID: <878que2u2i.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com> writes:
> Currently xmon cannot lookup symbol beyond 64 characters in some cases.

Can you mention which commands? It looks like it's "ls" and "lp".

> Fix this by using KSYM_NAME_LEN instead of fixed 64 characters.
>
> Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
> ---
>  arch/powerpc/xmon/xmon.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index e6cddbb2305f..22b8b5cc4df0 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -3662,7 +3662,7 @@ symbol_lookup(void)
>  	int type = inchar();
>  	unsigned long addr, cpu;
>  	void __percpu *ptr = NULL;
> -	static char tmp[64];
> +	static char tmp[KSYM_NAME_LEN];
  
I think you could use the existing tmpstr buffer.

It is global so it's a little hard to track down all the users, but I
think it's only used briefly in get_function_bounds(),
xmon_print_symbol() and scanhex(). ie. none of the uses persist across
function calls.

We don't want to have two 512 byte static arrays lying around if we can
get by with one.

cheers

>  	switch (type) {
>  	case 'a':
> @@ -3671,7 +3671,7 @@ symbol_lookup(void)
>  		termch = 0;
>  		break;
>  	case 's':
> -		getstring(tmp, 64);
> +		getstring(tmp, KSYM_NAME_LEN);
>  		if (setjmp(bus_error_jmp) == 0) {
>  			catch_memory_errors = 1;
>  			sync();
> @@ -3686,7 +3686,7 @@ symbol_lookup(void)
>  		termch = 0;
>  		break;
>  	case 'p':
> -		getstring(tmp, 64);
> +		getstring(tmp, KSYM_NAME_LEN);
>  		if (setjmp(bus_error_jmp) == 0) {
>  			catch_memory_errors = 1;
>  			sync();
> -- 
> 2.47.0

