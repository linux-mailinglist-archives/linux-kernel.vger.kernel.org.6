Return-Path: <linux-kernel+bounces-295671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1166959FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48C91C2275E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892D31B1D68;
	Wed, 21 Aug 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="S00iSIad"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6358E1B1D75
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250516; cv=none; b=sS987jyAfwt2mmbo94T06c9fODtvo8M+zUzEmod4M/cwq89EsChNLNfZ1HljILUACXDTgugwIdYOXC8WGPFE8UMi4dK/KYODUJqLN9z06CYh1m5s4Vtefidm2AbLHrXzao2WfXdJ6EyLdH4Dn+h7lKnJAsI/rfjJMpzN8jTIFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250516; c=relaxed/simple;
	bh=whWJEhEz/ceBCzVTBacQ5uRoKcxLKWFvP+QauRDZ8oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E88L1B6c0YYskSJFn9pBkHWFOb+Bafv+JbO0No1PrBKWzk14k+cZ5wOQCpE2/zsE66ykSuR2EfJYvtDmxWmvBeP+Okmdhn+O4Y9YqdcnE1wlgyCFNyPddrlQczuY0X9FYAXINnJnbh6m+gCvHSPmpVYlRxoJe5UhGeaA4Uhqf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=S00iSIad; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42ab99fb45dso19904885e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724250512; x=1724855312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=33YdeC3iT8CR+j1SZblDhoqx85c1E/nanH/Mxt/0lc0=;
        b=S00iSIadWQoRvIh8IOGi1hZa6zCUQE2ituR6ZT/5Fr1LNkVey1w+ttwD/cwj/0TA41
         HIpqBrxoJrb6xdKffOYuJeQH/g0Bocz0UqdzBkwVvtuEI7dClS4ndVRsrbkPlqqXe7Mz
         mN6vpSHWcDXs4A1LqlclV9/m0HH5KfxSZJFjGIF+ZN6UVLqW5mTjOSN9YwsMQYDDlhSK
         bK7kpMddwUtIMP0kMiCX39TTFIV+uWgQ+quVCbNnHXkt2+39PLBQQbN3Ms1+ih6wwd99
         VR8zlYgKFyal+YCG7tJ13BXefp/Qj88M6tPtAUHKHl+gJjx7P3UKWEsootDxtZ0g0xKH
         yDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250512; x=1724855312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33YdeC3iT8CR+j1SZblDhoqx85c1E/nanH/Mxt/0lc0=;
        b=ojJM9BTjKVQYnZysjaq3QZ0W9TUFOQI6pdJJ93dgXGpG5WRACZ+Q78Qgb49FA3tMVV
         0wt/A7va4oZbYLUtWQoNklFzS//hBBY/St0oP9ztILt8O+oq0qTpsDnOlg8VW5oVEMeb
         pUsPcamWm4nUGLgHpRPh+0r8iSrvILgL8fkeWU8Jx22ee/msoY3uJmvF5sJg9+uLG7qv
         7sCo+PkJ5D/l+ZSV28NTgcczPhtMWftoOjTGOa9ovZFOsBbxyeRQJH15RDC8K2RRx9+U
         83htngAXQY1SZLLH5cArB9f3c+B3+br5rK8j8SuYnOwyBIbJqfhPmVZ9lPcNmD3C6Cgg
         k8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXK3KcHeFrAZNXsyrdHfe0WfXSNVQDti2/7Wi2+UewwD/ikEYpNLry1wNOj50x2YWdyw0W2tUnnTfTFg9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZRBwfOwcKShU/718peXUq1q0Zn8GWuWQ0i4h96u8vlbGsgsF6
	Vm2g9CcYVyQ6fFGgv+xgNKUHmYt8VHriTQkBUFH++eYbrzoXO8AZlCchZPIQOZM=
X-Google-Smtp-Source: AGHT+IGfr36ocwDwn4or9Mf+dw2bDUy4gQ0Y1c7nRaSul2nHYfbm8Q0aRagSkky5/eY78AVRXeTy4g==
X-Received: by 2002:a05:600c:198b:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-42abd21517amr21696485e9.11.1724250512150;
        Wed, 21 Aug 2024 07:28:32 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abed8b6a8sm28505615e9.2.2024.08.21.07.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:28:31 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:28:30 +0200
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
	linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH v5 09/13] asm-generic: ticket-lock: Reuse arch_spinlock_t
 of qspinlock
Message-ID: <20240821-e350a1485008ee3263fae985@orel>
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
 <20240818063538.6651-10-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818063538.6651-10-alexghiti@rivosinc.com>

On Sun, Aug 18, 2024 at 08:35:34AM GMT, Alexandre Ghiti wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The arch_spinlock_t of qspinlock has contained the atomic_t val, which
> satisfies the ticket-lock requirement. Thus, unify the arch_spinlock_t
> into qspinlock_types.h. This is the preparation for the next combo
> spinlock.
> 
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/linux-riscv/CAK8P3a2rnz9mQqhN6-e0CGUUv9rntRELFdxt_weiD7FxH7fkfQ@mail.gmail.com/
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/asm-generic/spinlock.h       | 14 +++++++-------
>  include/asm-generic/spinlock_types.h | 12 ++----------
>  2 files changed, 9 insertions(+), 17 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

