Return-Path: <linux-kernel+bounces-301936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D33E995F7A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABC41C21E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3560E198E8C;
	Mon, 26 Aug 2024 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lZ/y94jr"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23E198E6C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692406; cv=none; b=ZlESHDodOB52IDcTEe7QmEhZW35LpE0iJ2M8ONsSRDIeqmHEoBCopDZCqm5kf6xgb8I+/utHI8foyDvV2HvgCRZwrx9EJh/kfKk3qi6XMSmXMSpgaACd5xaaOl4dUcB06Jz6vJRkaxZjBPnWunFrBad0aHhRL0AXZqV/SPrz5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692406; c=relaxed/simple;
	bh=CUdwSZJktH/q1DEP07BLl57arbag2rOym3j5NvBYQc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jY38trdxOwzVbODknoHwN96NFo4gHOjimzjkiLASSmFzJvNHoHxFPqS9ptEVsK7Z1GccCnt7IXN+8yTD2ofvYaSHK4bS1NJ14gjelvBQouJFYCJzc4o4HwIk3mD+8txd/uXIo210QMRh3HG5Kfpee9oJSVsx4ytYHH0OsbFuOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lZ/y94jr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so40876605e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724692401; x=1725297201; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=owbqJXu8r6ZVrIB9CmtF0sA6DYb33fLeb9l3H1ArS6Y=;
        b=lZ/y94jrYv9jPvdFFhB6dZ8HO1IVTk5yOU5POWk4RdTXpwBGHVqXgRIKhjzar0Cs9e
         SSAWAfgG8XNEntOrllvslVtJV4ZUaaARlGlPaIHc14zgbsSR+mTP0B+UuOu4nf8aPGxo
         6gKYLOeiaMe0Ntvx866VKAEynbpQfcrBOjwyqyA5M9fBZ7jzFAxcF0TkEBD5INBYehw2
         VOQWwYkea/5DkyxsWwNOD1Qc10OlFA26Rw8/2KKwfq7iggrejN4ALUTioP5YhG7lC4UW
         Rzh/QyTuS2XazRZekyvIBWmq39+qBHGsccjk5QvoYlFJVizQd0AxgU76LwZbpFtVkrhq
         CEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724692401; x=1725297201;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owbqJXu8r6ZVrIB9CmtF0sA6DYb33fLeb9l3H1ArS6Y=;
        b=xRfIUdRvvRDo9jNjNuJCjqqImDooXNGVaCrwzEV4sn/r/OwsYxarh75uSnQzmuEFx2
         FqgLmsfkpOF8BiaX2ZFAGeGA0tenh+u3xeHL0/rOB+3Y+9g+u/Pdcm8XgEI73vcxpSp4
         gBzdjE12X+PELLL3SEOV48T/UZY88OiBMpZ9ek5mLjr8n20kWzURJdvK/vFZN+w1WMIX
         tbCLnH/RA2mcOmkyg2SrsepWNdV8am0Oqx8f05vCMG9v9b08x09oJ1SAIV4HcjMM6LW9
         r92MvQ9C5W6pxrUaFaBkNFPpvXQDckNV6N4rhUatMR6UbAzXrhJ/Jq4W2s3tcX9fTJHk
         38Yw==
X-Forwarded-Encrypted: i=1; AJvYcCX29sxDIH8BVi6MQ2PWGPlHEwn/wjKUFj15lZkZ/1A5Ufqz/O+tgZw5ZNNprswlgAAg6f63ywf3VZ2MupI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYCrN425L6BwIMU0DsUKgbr2luIcjt+kMk5iAWSa+Z9+eUQCjx
	rKdrKYveE/bEjcvuQexVeaUVXqok85OPcvOg/Y/IaCXX0apEypgXGx1kv946cRY=
X-Google-Smtp-Source: AGHT+IE/SRgvK54LwpBMAx+pBV1j6adr/sKFTs5Qr83pIPvX8proSmWucvbwrmsFVhpNjSBejE38cQ==
X-Received: by 2002:a05:600c:444e:b0:428:1965:450d with SMTP id 5b1f17b1804b1-42acc8e2397mr78248345e9.17.1724692401303;
        Mon, 26 Aug 2024 10:13:21 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abed8b666sm196588125e9.1.2024.08.26.10.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:13:20 -0700 (PDT)
Date: Mon, 26 Aug 2024 22:43:07 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v8 00/17] RISC-V: ACPI: Add external interrupt controller
 support
Message-ID: <Zsy3o_N8hvc6GfTp@sunil-laptop>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
 <ZrlgVUXC_dCW9ISM@sunil-laptop>
 <87mskzcnmf.ffs@tglx>
 <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>

On Mon, Aug 26, 2024 at 06:15:18PM +0200, Rafael J. Wysocki wrote:
> On Mon, Aug 26, 2024 at 5:25 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Mon, Aug 12 2024 at 06:37, Sunil V. L. wrote:
> > > On Mon, Aug 12, 2024 at 06:29:12AM +0530, Sunil V L wrote:
> > >> This series adds support for the below ECR approved by ASWG.
> > >> 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
> > >>
> > >> The series primarily enables irqchip drivers for RISC-V ACPI based
> > >> platforms.
> > >
> > > This series has spent quite a bit of time now on the list. As you are
> > > aware, few clarifications like _PIC codes are also done now. There is
> > > no major change after you had agreed for the design. So, can this be
> > > considered for the next release please?
> >
> > Rafael, if you want to take it through the ACPI tree, then for the
> > irqchip parts please add:
> >
> >   Acked-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Yes, I'm going ro do this.
> 
> Thank you!
Thanks!

There will be a conflict in PLIC irqchip driver due to a recent patch [1].
This patch is not in latest RC5 release but in linux-next. I usually base the
series on latest RC release. Should I rebase to linux-next in this case
and send the next revision of the series resolving the conflict?

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=4d936f10ff80274841537a26d1fbfe9984de0ef9

Thanks,
Sunil

