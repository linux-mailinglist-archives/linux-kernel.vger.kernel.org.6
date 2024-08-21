Return-Path: <linux-kernel+bounces-295676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A812959FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953F3B21075
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1955919ABAF;
	Wed, 21 Aug 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FB2+wOS3"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CAF136328
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250770; cv=none; b=RT76jmPiaHdEn2ar46+mQSzXSdjP/88NzcYts6JAZlqKNUfV+6L3ilKOu9qMgM8B44poAdrFyUcgMYMn4OiN+t0piuJm0CioZQBUDJh3oddJFjZ+bR1VukDrW+saSYHsgR1Mz57hSzHZbVnOseWiLkRjgXS9p/JRzlcmuQM7Bnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250770; c=relaxed/simple;
	bh=adHmya+qZ0f7dKCPtfUCV+Zzi7NsBk9BKZjxCyAllf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZO81744SHrJAOngwU4hSv4PTCOJdJ+P+lDxKcnsAf52RqqYA0iOl6SKOvxTIJUfbJb6FMXUPBL8summ4eai0lBYPGuObV3FjSGeo71IblNVGjp2tokxan7yxzSw0SKLxYsh0LocXfB8stFb92BFpGNLlYVN8Ne1sbXk+fo8S+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FB2+wOS3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso56090965e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724250767; x=1724855567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BzH0Ti5/cSa4VdiVvC7Ftff2LpcTCcyPmlVuI+QhSpA=;
        b=FB2+wOS3bCVVLxvwT2kJfqtsdBPNbl6cuA0Dfb2aNHqlr5lBUbJbddIZhjQhofeHUW
         kO1ARGbAv6ak6P71WcoEiWMPfSoff6ZBu3bqPW36URNflxae/osgax6kuFqh+lkwI6zl
         lERzKdrR63PWzRCBwWarFSX8BRQ1YFRvMU717xaHBmiuqGfO3SsU9fRt14tjTiHxqFP2
         o9dg3kbGmeZiTpQtp6uSKvtqRlsz1Zh1hrQOF7LCsKYT8P53JyJuIrUFtFqEwhy5QC79
         C4qxj3UMjSonngsIAI5gJt3o4f3PxcwmwFDp3+YJoU87/wjvbj5vbLXm93CjndgWu8Mk
         XLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250767; x=1724855567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzH0Ti5/cSa4VdiVvC7Ftff2LpcTCcyPmlVuI+QhSpA=;
        b=K1BjcvKnoqGRRrl6+LDKmGhOcKQm3O6aiVilGf4S6CwDnzdZAg5B9ODkUjflifnmJ3
         4gkNhIHs8V24ntcsm6CqymnjmOr4n+ueiEM4/TDzzkDWfeYv80QmKCqT6YrAuxlwffb7
         Q6/E7EZKidFT43J+DKYDHHw1IGfCzR8dN7zzusfRoDnIr2n+UZgzCtzNS+Kp8nvdZ+ND
         KH7WL0i9yJ0XTICCmKzjRBP4+MB0/NnD7BroBl36zAmi9clNQLRmtOZIhbGCDjQF1LdZ
         CQ++l44DYxDOT6ehsrL6UZBWKLvfmen3sw5sDmdUWnjVhh5Ey3hOvbclU5xynZijezIt
         fg4g==
X-Forwarded-Encrypted: i=1; AJvYcCVHZK1kE7FzQDSG8Y63E7mjP4JBeef/Vv8Cyh0Hn8JEwlTK0eihITMqoupSw2TMdVMFpDr6GH4Mp/m2yys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2A9sgALsGdPugWBHRBHjvyuzMTpItP1BPk3K29VqvCNRiQIQ
	VvCUZK4or4AxEcg44Ar+lWBRd+dcUU11g7f55W7TDe8mHtBoOCdf6k/dF6pXaYI=
X-Google-Smtp-Source: AGHT+IG9h6I3OGfk/BYjIhaBWJg+eWFf3tj96tXLfu1MoIVwYfpY3HO/tLKYhUHQR2BfZETfuvcMOA==
X-Received: by 2002:a5d:5184:0:b0:368:65ad:529 with SMTP id ffacd0b85a97d-372fd5929f0mr1701638f8f.17.1724250766402;
        Wed, 21 Aug 2024 07:32:46 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefcb674sm27234295e9.32.2024.08.21.07.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:32:46 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:32:45 +0200
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
Subject: Re: [PATCH v5 10/13] asm-generic: ticket-lock: Add separate
 ticket-lock.h
Message-ID: <20240821-8dc1f3151679f2e35255683b@orel>
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
 <20240818063538.6651-11-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818063538.6651-11-alexghiti@rivosinc.com>

On Sun, Aug 18, 2024 at 08:35:35AM GMT, Alexandre Ghiti wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Add a separate ticket-lock.h to include multiple spinlock versions and
> select one at compile time or runtime.
> 
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/linux-riscv/CAK8P3a2rnz9mQqhN6-e0CGUUv9rntRELFdxt_weiD7FxH7fkfQ@mail.gmail.com/
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/asm-generic/spinlock.h        |  87 +---------------------
>  include/asm-generic/ticket_spinlock.h | 103 ++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+), 86 deletions(-)
>  create mode 100644 include/asm-generic/ticket_spinlock.h
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

