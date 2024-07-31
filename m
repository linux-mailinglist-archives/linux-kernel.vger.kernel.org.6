Return-Path: <linux-kernel+bounces-268863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3C6942A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E138283D79
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A4A1AAE36;
	Wed, 31 Jul 2024 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="W4AalDwo"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AB450E2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418029; cv=none; b=Gski5GWg9s449MX1MhlzDUc55Yx/Iuhn0CkH2hyriKgTrYKHHy+y3k/3uxau45AK5Yjgu71VkTQ7NTCBpmhfft+LXgcj0fRD0X1csVi0y+z52TUWZHO9U+fDVXyWMnK7FGss78MG8HhL+6JHU4cVFCkrSb0sbULdpo5mu2hB2rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418029; c=relaxed/simple;
	bh=4txZO0NyiZJsXzMrfPzPDzAvVuqnEJKl3zlQlZLsFJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWabQSOzYKnP6X/7gzE2udvtem49ElZCUb2mfs+cdaecT8yos862w5ST99nQ9UdAiXeh0k3w5AdorIO3+NzfA8L2UB1GsEA6+jpYp0wyPxMQ2QF3wih02wA/we6nwPtRSJtZxu+9Z/IoeNi3q2BhSOT4UNZki0VonnQYv8ve3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=W4AalDwo; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f032cb782dso60484451fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722418026; x=1723022826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p7SJK2WN3L6uZyaEdLNNOcGfMCG9Ym2ay5t0xgYijf0=;
        b=W4AalDwovk4V7gdaoc2MugPS6Z/vioPnBrEO6wr9Mf54juxGGOcwZSiCsEEzypEQT0
         FiERaZqx6tXqC3Pw2nhiXPmSE7enBLGnkow9I44AJR5COqbpz7jMbeh2vhDojUqVT2Am
         UFF6X9m6ZlMOkugSE0iYwD0CnA+mtwgwaFSr1kX++ItNdVP/TMkXVveu/485kbYaT/il
         +atBNxSlSbXXpfP2N4e4cTh0fGqfE1Yk5gg1dECOvDP4GxEcArC1Kxz6GaXJhJ4TDTB4
         2KGeNPAj88ePdyINgc0uUWOmYk/1W7bbSh4tZWGaFaqEL2mWckSPjfP1TngcchRQVg1s
         9qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722418026; x=1723022826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7SJK2WN3L6uZyaEdLNNOcGfMCG9Ym2ay5t0xgYijf0=;
        b=j1KyDWLDkQGy0z5jSmSC7TBIZH8MnBScR0NqDJztQvnHDi/vwK0sYdx9vlpSkFqHID
         vQauu8sc4hYNGlNhnSoYIiQBU+l4cUxy37VYRiWxfkgO806qfRqctzmSw7sF4RXYAGZw
         z0hLCg2siz/DD69p21yXbPWHGCsRB4nY24lVzGtO7vFsGBop6QwtYPxrNZ9BibVFTVwl
         uS+BqKtx4LpC5p7N02yNa43c1dNDKoe+boJSDkgS4HbRMh7xVzN3xBw6sil3Cjhmp0jI
         wREsGws59OrzIoDtQng+0P6AadsHjZncg428cKznS/yZraV/OkrmQbey7ndBE+PPUYMO
         nOkg==
X-Forwarded-Encrypted: i=1; AJvYcCVTtmoec3r0WnEdxNbBLw5Yvy70ioP+DBW9u6gz9Sa3BaYTi+D6c0D15h2vkzhZnnvs9tnwrh0vfQ1NL+ZtPqbLN7kuTRQaplJY6Sif
X-Gm-Message-State: AOJu0YwykKKnwLKFSv+ikoZ5GidgtmeJYqnVJqnJH525/j6JJZEDPLGf
	uZFwd96vV1JR70kj9Y7HCY4bSRywhTGCy4Zot5VwR3FLWsCXXIWwuh2TGEZzi88=
X-Google-Smtp-Source: AGHT+IG3JIOtJ24DzWq2AbHse04McdP7VjBbSLZOo3eV9EeDpYpgjlKyfa2GCIpAnxuCqpt5LCi3OQ==
X-Received: by 2002:a05:6512:292:b0:52f:c13f:23d2 with SMTP id 2adb3069b0e04-5309b2803e4mr8247308e87.25.1722418025413;
        Wed, 31 Jul 2024 02:27:05 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3c1esm8451687a12.78.2024.07.31.02.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 02:27:04 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:27:04 +0200
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
Subject: Re: [PATCH v4 05/13] riscv: Implement cmpxchg8/16() using Zabha
Message-ID: <20240731-da4a7d7790e88a6b8960ad3e@orel>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-6-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731072405.197046-6-alexghiti@rivosinc.com>

On Wed, Jul 31, 2024 at 09:23:57AM GMT, Alexandre Ghiti wrote:
> This adds runtime support for Zabha in cmpxchg8/16() operations.
> 
> Note that in the absence of Zacas support in the toolchain, CAS
> instructions from Zabha won't be used.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/Kconfig               | 18 ++++++++
>  arch/riscv/Makefile              |  3 ++
>  arch/riscv/include/asm/cmpxchg.h | 78 ++++++++++++++++++++------------
>  arch/riscv/include/asm/hwcap.h   |  1 +
>  arch/riscv/kernel/cpufeature.c   |  1 +
>  5 files changed, 72 insertions(+), 29 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

