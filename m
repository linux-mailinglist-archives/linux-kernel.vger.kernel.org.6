Return-Path: <linux-kernel+bounces-569645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91082A6A58F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A204816E9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD14221F3A;
	Thu, 20 Mar 2025 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nyHGPu9E"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD8221F16
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471578; cv=none; b=bV5KBdC+7Q+FHrvKIspW5d2Fsc4F4FzSBVWLIiRRKDt7X6Q4z0AG0qlCcqU7apUqtRRYgeDkq2vL4s3QbUKwV7bC8t575ohq645O0ltK6VAKYJFDu8npexdvvynrmMlOw2iudOG9xFmDoOXtxdZ7ZWxtC3ZEICyMLk+yWb8tvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471578; c=relaxed/simple;
	bh=OjN9wGOAIpjmQa7W63iYZMm20wHgFG2lfSL6golGLFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9eAccDTf+HShS0638bz+CRY86jxAawLHJ008Ubgv+RYzJiMQTLXf4t/QQJACHuayv5yOJC3nyJwSNkuassoVIigZiOsF00ZUbUHq9Rv3Ay5H5GiIbSZoKGU80LS5pgc5OAi2CsBMTXjvSByqTvjVTjZh8SQZ4Bh024nSHBLFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nyHGPu9E; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-399744f74e9so398859f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742471572; x=1743076372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W7Q+Uv9PP7IrwTG/eBced107V/Y8wAy3D1YQ6SsCvek=;
        b=nyHGPu9Eo3AB27mSotro2qA4qAzML0gNfUXxqyx7QQb/WXDHYh5N2UsywJuJwrk1jq
         W9gMvXIERbofA7sD2fQ1m0T/OWVl69aLMMP9XWiMKo+I9Me/C5lBIcb1rb+eQ8rzSXKa
         SR7bIOp0MGVoNAKQYscBf4abvkxeBuuo0lXvoEBeqK5m00C7SGqX/8O4oqowpGYDzuo2
         0o0YZnV1IKRKqymbl/vVjo9L2Z0REtOJQhAie3Q2Ukipn9a5/vCcV5wHEkSTtCljArDH
         Cy3wgrSpU5OHxGHc6do38386Grq1ndbNCd7TaKReG9Tkl31oLe2Q6J53xXQ/2y2wFEuj
         oVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471572; x=1743076372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7Q+Uv9PP7IrwTG/eBced107V/Y8wAy3D1YQ6SsCvek=;
        b=bgY3NXCht1ux9TcwDkTrFBisoLZxZjyQEMaPX47oj/B0MHq67zxwbEs/8pfiUUHGG+
         O2WnF1OJRy/vv89OkJ+Wi5OV2/qxvqRj3n8sZEqq2PF/VmAhuUZ1/f3qJQuDcpAR/IT9
         NbE6A9DK2Eowg78GXCKFS9B0bf/vFgb9I+LJpAOTv29R4nbtHBWZ3hx/jrq70bknSP51
         jPLdbbKDdMeut6aBIF4KrViEG1dRqAJtTfC5asOBKNdAmS07xrMJ7a3B0SrLkE3jvKiN
         sDISxXG/+HAJZfvTrCLvEa0xPbPFIamtRSLR7Re947xRtJ6ZysuIQlh3TwNfe1SxRu0R
         sh/w==
X-Forwarded-Encrypted: i=1; AJvYcCVw3aCf7viScINW1htBbq2Y3hVbPHQiuB7y2OsGVkeNvl5yqcvGPaVrgWilPdl1P2Sl+XCHS9DIyhqD8iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmirWp7Wuv5hIyhhT/2DYQdt8lZiBkku1RHf5IBJDQSQH6iSj7
	nTL3Gfsf0AKE9MtkNLRphvY6EDTDLX7pvjoazZPp42DqGovBzK6TAiYIuzs6slA=
X-Gm-Gg: ASbGncv8Zwb/cWdbccEF9Ud2rCQ5Q1i8qJ0CX2817xTqmHUW6nIHX730+Tf4ByYLvc+
	jjGtESR/N0gWC4YVBnQgq3yv4GDX6J9Bo44bP68FAmMC7h9eiG/wz/IWAa3zZ5iZzi4IxSkrw1K
	F1iWIbpVlX87RmKcaZa9Esf+3OGZEJkce0+f91AvOM3jhDHNDIg9Ahmbt6jluA12djNgg0XvW5m
	Mul4qSQNg68ChkUeY6kuGbIBX4AmN5FO0guLmFxNFwvU2QSqs16/lWPKObnYeiNtGSWA6hmF7IT
	iVDIxmTK7GxYUgD0hUWA1/9AgEvNNAqE
X-Google-Smtp-Source: AGHT+IHeyTD2wSXlAOfdAKS53YepR+/8W8LiJeiUCHJdoX9DdjQszAGbC8mMUKoCZx6XO5JpwnfZmg==
X-Received: by 2002:a05:6000:188e:b0:391:2e6a:30de with SMTP id ffacd0b85a97d-399739beb10mr5536213f8f.19.1742471572182;
        Thu, 20 Mar 2025 04:52:52 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997e3eb672sm404452f8f.95.2025.03.20.04.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:52:51 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:52:50 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Himanshu Chauhan <hchauhan@ventanamicro.com>, 
	Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>, 
	Atish Patra <atishp@atishpatra.org>
Subject: Re: [PATCH v3 2/4] riscv: add support for SBI Supervisor Software
 Events extension
Message-ID: <20250320-5f9612f1b503c79c9b185b10@orel>
References: <20241206163102.843505-1-cleger@rivosinc.com>
 <20241206163102.843505-3-cleger@rivosinc.com>
 <20250319-46b625cf8b771616d4c7c053@orel>
 <b3fbd730-295f-4491-b0d6-d4e258941ae5@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3fbd730-295f-4491-b0d6-d4e258941ae5@rivosinc.com>

On Thu, Mar 20, 2025 at 09:16:07AM +0100, Clément Léger wrote:
> 
> 
> On 19/03/2025 18:08, Andrew Jones wrote:
> > On Fri, Dec 06, 2024 at 05:30:58PM +0100, Clément Léger wrote:
> > ...
> >> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id, int cpu)
> >> +{
> >> +	void *stack;
> >> +
> >> +	arch_evt->evt_id = evt_id;
> >> +	stack = sse_stack_alloc(cpu, SSE_STACK_SIZE);
> >> +	if (!stack)
> >> +		return -ENOMEM;
> >> +
> >> +	arch_evt->stack = stack + SSE_STACK_SIZE;
> >> +
> >> +	if (sse_init_scs(cpu, arch_evt))
> >> +		goto free_stack;
> >> +
> >> +	if (is_kernel_percpu_address((unsigned long)&arch_evt->interrupted)) {
> >> +		arch_evt->interrupted_state_phys =
> >> +				per_cpu_ptr_to_phys(&arch_evt->interrupted);
> >> +	} else {
> >> +		arch_evt->interrupted_state_phys =
> >> +				virt_to_phys(&arch_evt->interrupted);
> >> +	}
> >> +
> >> +	return 0;
> > 
> > Hi Clément,
> > 
> > Testing SSE support with tools/testing/selftests/kvm/riscv/sbi_pmu_test
> > led to an opensbi sbi_trap_error because the output_phys_lo address passed
> > to sbi_sse_read_attrs() wasn't a physical address. The reason is that
> > is_kernel_percpu_address() can only be used on static percpu addresses,
> > but local sse events get their percpu addresses with alloc_percpu(), so
> > is_kernel_percpu_address() was returning false even for local events. I
> > made the following changes to get things working.
> 
> Hi Andrew,
> 
> Did something changed recently ? Because I tested that when it was send
> (PMU + some kernel internal testsuite) and didn't saw that. Anyway, I'll
> respin it with your changes as well.

It depends on the kernel config. Configs that don't have many
alloc_percpu() calls prior to the one made by sse can work, because,
iiuc, alloc_percpu() will get its allocation from the percpu allocator's
first chunk until that chunck fills up. The first chunck is shared with
the static allocations.

Thanks,
drew

> 
> Thanks !
> 
> Clément
> 
> > 
> > Thanks,
> > drew
> > 
> > diff --git a/arch/riscv/kernel/sse.c b/arch/riscv/kernel/sse.c
> > index b48ae69dad8d..f46893946086 100644
> > --- a/arch/riscv/kernel/sse.c
> > +++ b/arch/riscv/kernel/sse.c
> > @@ -100,12 +100,12 @@ int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id, int cp
> >         if (sse_init_scs(cpu, arch_evt))
> >                 goto free_stack;
> > 
> > -       if (is_kernel_percpu_address((unsigned long)&arch_evt->interrupted)) {
> > +       if (sse_event_is_global(evt_id)) {
> >                 arch_evt->interrupted_state_phys =
> > -                               per_cpu_ptr_to_phys(&arch_evt->interrupted);
> > +                               virt_to_phys(&arch_evt->interrupted);
> >         } else {
> >                 arch_evt->interrupted_state_phys =
> > -                               virt_to_phys(&arch_evt->interrupted);
> > +                               per_cpu_ptr_to_phys(&arch_evt->interrupted);
> >         }
> > 
> >         return 0;
> > diff --git a/drivers/firmware/riscv/riscv_sse.c b/drivers/firmware/riscv/riscv_sse.c
> > index 511db9ad7a9e..fef375046f75 100644
> > --- a/drivers/firmware/riscv/riscv_sse.c
> > +++ b/drivers/firmware/riscv/riscv_sse.c
> > @@ -62,11 +62,6 @@ void sse_handle_event(struct sse_event_arch_data *arch_event,
> >                         ret);
> >  }
> > 
> > -static bool sse_event_is_global(u32 evt)
> > -{
> > -       return !!(evt & SBI_SSE_EVENT_GLOBAL);
> > -}
> > -
> >  static
> >  struct sse_event *sse_event_get(u32 evt)
> >  {
> > diff --git a/include/linux/riscv_sse.h b/include/linux/riscv_sse.h
> > index 16700677f1e8..06b757b036b0 100644
> > --- a/include/linux/riscv_sse.h
> > +++ b/include/linux/riscv_sse.h
> > @@ -8,6 +8,7 @@
> > 
> >  #include <linux/types.h>
> >  #include <linux/linkage.h>
> > +#include <asm/sbi.h>
> > 
> >  struct sse_event;
> >  struct pt_regs;
> > @@ -16,6 +17,11 @@ struct ghes;
> > 
> >  typedef int (sse_event_handler)(u32 event_num, void *arg, struct pt_regs *regs);
> > 
> > +static inline bool sse_event_is_global(u32 evt)
> > +{
> > +       return !!(evt & SBI_SSE_EVENT_GLOBAL);
> > +}
> > +
> >  #ifdef CONFIG_RISCV_SSE
> > 
> >  struct sse_event *sse_event_register(u32 event_num, u32 priority,
> 

