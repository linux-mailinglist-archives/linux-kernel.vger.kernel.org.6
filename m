Return-Path: <linux-kernel+bounces-235626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2613191D7A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582B21C222D1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6727E42056;
	Mon,  1 Jul 2024 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NQCaENbu"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F613FB01
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719812988; cv=none; b=s/p6vkfXYsO9mv+C3ij0asHwzpOLFlrFWL2Qo4bQ1uVwXMbd0O7lqW/XN855mQTvE9yKtZxVEJU8MY/8oXJxcbJlDLX5QsNzMiyyd+8t5Q7trpqOA+6M0U8E2sU7G275Wq+ILOY1DmvfkmCFjEp2ev/Pd/h6GcdXYVZn9T0vvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719812988; c=relaxed/simple;
	bh=mqqGdxTAEmXRIjGTDLRjrJRNNyk8TOJ/9inqH08rFms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnIYpSXlHZxcChZaB9kD6ELWjf1nAXxOM7Fj3JOIQtBylPvUY3wfY9z87VDF3fdtJNlX3tRFftyBlRJ6GEiGmOT46QecpBDq+YCSvyiCpLfqZKKRx8MP+makt81g3ybIzfMjIp1udxswRiTBknljpSk4iG6ixRLacW8lM4mI2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NQCaENbu; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d564919cd6so1712264b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1719812986; x=1720417786; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4s/WBvVl/dst1lHjWFZpMEMdrWEWEKJym4uGaWtNax0=;
        b=NQCaENbuY22ees4p2Z4dKnlXLHK1hiHxuS9HYo2/1vL/sRXH050PwZ3ArdngMJXiXG
         MfI+vlsmVSiPqFC5tV/87IkP63vgZbpQEb5yBcP8CaOXWrnIYWyF1DdD6FpQQFTsE0+0
         5hFRhtuggvSMadFf3KYbsMoPsuKvs+KXPN4m2Tsd18KxC2SPEeuoCifdkR1pXrOyBwy7
         TsOOV9gMR9gpPdbhU9jT3e2Zv65URBKh5gYmbZkDvXQL83UX0goK/I7CnWDL6P51biZ+
         V40W9vLc/h/FsNyRMA153bl7Pce4Qg0setvvwND8aGQD/URWU1sT/+dw+uyFgJBhpabZ
         do8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719812986; x=1720417786;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4s/WBvVl/dst1lHjWFZpMEMdrWEWEKJym4uGaWtNax0=;
        b=bEHIiY/tFN5LMaYNipQ+mz9cfgazmQDEhlOlRtXHYvEhl0sau0/bmGxeEnisw2/EMs
         iTnhBtELiID6Z3iqj/b9fWhqhH40cX5Xg0kUvK6GV9yr8XgBGLgWsMSZzOLi+vIX+NqY
         xUlIXYP3YdQ2HYT8WswRRxQQy9BMSZPJXB6R6btdKXcUPX1f1d/KQkKYQgAUTmgZU1dP
         u3izZEgPv14LYlWcWwXkLNSSdz06kGXvHRrPKsjQrVQgGMvvIravduliDjiB3VK0mkPc
         Z+w49GOvXm/7PzfSi817iHJOEFvfOxz2PoWSOGirOs0uSee5iVc4HNtNACjIZ3W7nFF1
         G/lw==
X-Forwarded-Encrypted: i=1; AJvYcCWHcIRTxN829M3xidhjrVSekCGu0FZedy3M9G2KfdRevnlvyA95EWLBKrSc/yL3sY2Pq8nPcXRis1yfddx6qMc4ShHpjYlpe+PlaMpI
X-Gm-Message-State: AOJu0YxkO1qnFTO81/X7zxwgARh+e3xj56rnuno8ioohqWzxw/8yRpks
	Btfs08rs6s1rsiWnMKmlr1k6mVqJL2N6YSyXQ/oiP34AdYBD8YswkODupobveKw=
X-Google-Smtp-Source: AGHT+IFkbfzSyeGbbMoYBWXleU/NPIjZpuMJZvhBR4F8gn5oN8vBjv/YM3Be+WxqxSc8Jn7yn+W2+w==
X-Received: by 2002:a05:6808:1706:b0:3d6:32d2:2c15 with SMTP id 5614622812f47-3d6b5686a2dmr6011108b6e.59.1719812985837;
        Sun, 30 Jun 2024 22:49:45 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62fb48ab1sm1228661b6e.54.2024.06.30.22.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 22:49:45 -0700 (PDT)
Date: Mon, 1 Jul 2024 11:19:35 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, bhelgaas@google.com,
	james.morse@arm.com, jeremy.linton@arm.com,
	Jonathan.Cameron@huawei.com, pierre.gondois@arm.com,
	sudeep.holla@arm.com, tiantao6@huawei.com
Subject: Re: [External] Re: [PATCH v6 3/3] RISC-V: Select ACPI PPTT drivers
Message-ID: <ZoJDb9PQX2oEISrI@sunil-laptop>
References: <20240617131425.7526-1-cuiyunhui@bytedance.com>
 <20240617131425.7526-3-cuiyunhui@bytedance.com>
 <CAEEQ3wnkQsfmLbyMrG_YBvWvhHJdSTg7dG5W_mxv_wxCjatgCA@mail.gmail.com>
 <ZnLY3mNxyv9QOmGn@sunil-laptop>
 <CAEEQ3wmarOoWWYrdpf7YNQdZG4rf_O4dHkeiO3W1cuavVh8TMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wmarOoWWYrdpf7YNQdZG4rf_O4dHkeiO3W1cuavVh8TMQ@mail.gmail.com>

On Thu, Jun 20, 2024 at 09:28:18AM +0800, yunhui cui wrote:
> Hi Sunil,
> 
> On Wed, Jun 19, 2024 at 9:11 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > On Wed, Jun 19, 2024 at 07:32:18PM +0800, yunhui cui wrote:
> > > Hi Sunil,
> > >
> > > On Mon, Jun 17, 2024 at 9:14 PM Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > > >
> > > > After adding ACPI support to populate_cache_leaves(), RISC-V can build
> > > > cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
> > > > configuration.
> > > >
> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > ---
> > > >  arch/riscv/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index 9f38a5ecbee3..1b4c310a59fb 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -13,6 +13,7 @@ config 32BIT
> > > >  config RISCV
> > > >         def_bool y
> > > >         select ACPI_GENERIC_GSI if ACPI
> > > > +       select ACPI_PPTT if ACPI
> > > >         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> > > >         select ARCH_DMA_DEFAULT_COHERENT
> > > >         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
> > > > --
> > > > 2.20.1
> > > >
> > >
> > > Gentle ping.
> > >
> > Actually, my RB is still valid. Anyway, here again.
> >
> > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> >
> > Thanks,
> > Sunil
> 
> Okay, thank you. BTW, when will this patchset be picked up to linux-next?
> 
Hi Palmer,

Can this series be picked up for -next? Looks like it has got sufficient
reviews.

Thanks,
Sunil

