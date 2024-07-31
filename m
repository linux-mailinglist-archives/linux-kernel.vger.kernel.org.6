Return-Path: <linux-kernel+bounces-269336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D66859431B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917D7284215
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8691B3F04;
	Wed, 31 Jul 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="elfMgnTT"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC881B3744
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435013; cv=none; b=QGF/SrR5ma5kG18+GxSR9pvXXvaycYIVoIHxDnRgJQem+De4FoegQ0KG+SnQReMwUqXETqLWLN5w8DzVPRf3qvEu8QYnWqfGe4kBE9oIlyYEnmOauQ/ynD4fnhkiRoRyQoDvr4K5kwj+FjeE6Jg2QJJ1YwZBp2ZcUSa9fTmwzb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435013; c=relaxed/simple;
	bh=dmVOCIu8kbYlKl/Cr9b5rGbdHU19hBCDOxflVjQyj+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDMFo3FHA11T8optlk2xB2Z1drhpIoo6Sa0GyH4E+8Twxltx0p0W4klikbBRP1iF9eCFKP4TDWvjeGm8yCEFuMpu+le+/wduWjLELlHBjP8qm5v9dYLCXwNyrLrjVGF01f54ugbvsYIVgZWiq8BpFnVdeZt3SextASLIlLj10us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=elfMgnTT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7ab76558a9so177680566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722435010; x=1723039810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqyqw/nHSlejBJnG1P+gVR7MBqt6hfQ4M9UtXPV7Jj8=;
        b=elfMgnTTjCM3UmWuyHhfZduzBYb7necRHX8q8rotq4qZO09Q/crQGEbfimYIdPi5VE
         Xul8wBlWaOEj6sFDP+OzNGu0+61bI38lGQzhub8drJMJw1474Hwx9WlEcaDFtKYwdJ+u
         mPgoizyjvEfyNQLMLaG+5nsrSp5j2qmpV4evpmt+AJ1VRtuDQ1+5urj6eyhqisHWOb/9
         X954oagG0F8vyrx4ff6BecFsllcL5c4fwt+P6V7A6vUSFHWqhC2b45V7GYYrvZYVwRWN
         cysllFHa2xVeCHPp1nb3bnQPk7yYxtUDHYG1JZPXd/zrza1jI8q3kj1NFn52K7d3gCXW
         bUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722435010; x=1723039810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqyqw/nHSlejBJnG1P+gVR7MBqt6hfQ4M9UtXPV7Jj8=;
        b=gcnPVu7Nxhz4DnncWQdz879CbVBKw3YMQvYtSPSopMxNd3Be34Czky0OmqA32vNxJI
         KWZESeJpsnruD4c2iw4MojEPmTPhzP30AHPB5SBsMZi83LTY4jN6mkdGjN97jwFM6HDu
         EAC7hujedsiEH9QA9iw/W1Ol7RIoEZ6k7+jsMQOk0ewQ/70hVGXld1d6fzjwaGH3shhb
         xai15rFdvZFCd3MPi55U983UE0CpUyg3vZO6YG9y6OdL9orNKDtxaVFRyNgeBMEjX7yI
         5lPSSQeR40a+Gqu+qlSAeMu7ZFPiTcitTdEL67z5DaGU0FNqX0ze+JUtvJE7Kngazaig
         5nkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXByX7wQgKGzprzQG3SZHV/P8yoPI8T15evfUnyfT204Emdi03CSCPBzXM+Ba/rUlwI4dydRmSPngBZ9tMJWH9TUiq9Pqy43dMkDh4i
X-Gm-Message-State: AOJu0YzgR/MmA7fpT65EwepA29aRubyxVB8Mm1bueUP72efE1cr4x5NI
	nzskYq23rlffCsg/BAuv+i5w90322rrbz5/rHKx1q9mL+SyvBrmZ//T85JzWCMY=
X-Google-Smtp-Source: AGHT+IF2QCYCUqjPekfpSqYJ4AImkm365cVwJfODis1nmhKBhNr8Twq9mBAr+HyjSZ/Z5pxT2z9Qdg==
X-Received: by 2002:a17:907:60cb:b0:a7d:88c4:2897 with SMTP id a640c23a62f3a-a7d88c437b8mr345160666b.2.1722435009133;
        Wed, 31 Jul 2024 07:10:09 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad416basm772297966b.104.2024.07.31.07.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 07:10:08 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:10:07 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 02/13] riscv: Do not fail to build on byte/halfword
 operations with Zawrs
Message-ID: <20240731-56ba72420d7f745dacb66fd8@orel>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-3-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731072405.197046-3-alexghiti@rivosinc.com>

On Wed, Jul 31, 2024 at 09:23:54AM GMT, Alexandre Ghiti wrote:
> riscv does not have lr instructions on byte and halfword but the
> qspinlock implementation actually uses such atomics provided by the
> Zabha extension, so those sizes are legitimate.

We currently always come to __cmpwait() through smp_cond_load_relaxed()
and queued_spin_lock_slowpath() adds another invocation. However, isn't
the reason we're hitting the BUILD_BUG() because the switch fails to find
a case for 16, not because it fails to find cases for 1 or 2? The new
invocation passes a pointer to a struct mcs_spinlock, which looks like
it has size 16. We need to ensure that when ptr points to a pointer that
we pass the size of uintptr_t.

> 
> Then instead of failing to build, just fallback to the !Zawrs path.

No matter what sizes we're failing on, if we do this then
queued_spin_lock_slowpath() won't be able to take advantage of Zawrs.

Thanks,
drew

> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index ebbce134917c..9ba497ea18a5 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -268,7 +268,8 @@ static __always_inline void __cmpwait(volatile void *ptr,
>  		break;
>  #endif
>  	default:
> -		BUILD_BUG();
> +		/* RISC-V doesn't have lr instructions on byte and half-word. */
> +		goto no_zawrs;
>  	}
>  
>  	return;
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

