Return-Path: <linux-kernel+bounces-568471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4F1A695E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF307A66BE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086941E2611;
	Wed, 19 Mar 2025 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="R8ruQfdV"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF691D54D6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404128; cv=none; b=Dk6DhdaxpEZJPHIRZoiPneQ+oG3hJ9LbN3fb+TiZ6qNlfY4mmUrhhtCumfaEyXsPsvIVJvsBSNVaBrKlP7g91p8CEIGD4Vmo37LhFcojlTmWobKFUeaxT5+ErAvgQN4Vk4L/KaOjXqzI/ZQr2fljoVZLnjWjjPtyw+J97/nnSwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404128; c=relaxed/simple;
	bh=qvScHooneL5DI59/Z5QMDLLjruYAtO1DzHQR2nT15v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEhWQsuBxjGTxqwY6bYEKb5R6EdR9ILQSWF+DErqUZdzyrZ7fCBGUqvfSYMWzEM92L3WlR8kf2RhLnCNN50/8mrL7gkmhejcwetiLyIu/nrrztiw1DlvyQxbiLukUx/QW/Qcyiji1A3xxfoma42RY1Lo+Vj/k7iwqdSr4arttjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=R8ruQfdV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso35258995e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742404125; x=1743008925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G1ouuKQSE2VEpWtfA+MIBk/TTstCzh3+p28q16wuqE0=;
        b=R8ruQfdV9VS9GzGnX2MnhECHd1FL8m2UbyAwUyAl9F+YWS39hxXpK4Tgl4CtmThqA5
         LgpqWDL79CufynK9WSSwroZhPMcJuczZZM8Ac56/uFIQCvFTjSKWBOnXlUsa5WwRc3k/
         i2TbL3TGVYf2Tr0+cKvkZSW/pRXFXau6+D9GUXgGGucJjwIcxkOdTsSYwzWhhDZBJLGj
         lQqgzWlfGZ8FDGDzKCi7hsPc+PEjkRnIxcdX1w0tjT95dXN7e6LRZX9tuCf/nuUuAOcm
         Y6F6lYA08dRo/cxK0vwVi6vNkGZ4NIL0jsHwNEAKjW/Mp+iOvWav0VqXK/2jKcmQ6qOd
         lZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742404125; x=1743008925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1ouuKQSE2VEpWtfA+MIBk/TTstCzh3+p28q16wuqE0=;
        b=YAtrJZOnOAymmw8/L02xHFYW7Khs7GLz+FtAsWlqjvBy7+dkw9by4KbUNID2QWQHzL
         TBZTzZghr4m+Ydho8kOjuoSj2fsBrIiRVKkpncaShv7tcMxoGPkybYVJnMD/67UZj+rq
         Rs10XuYT5eJiMuh4CxX2zWKABSlVMraUG98vTWgjd+RXF2cpBQlMDzpFz+Qo2tBjINS6
         aeCW+fRpGhRRdmLVBGn/mj/juNmAbrYox1Ti2N9LKv5w6Vgy5ndX59okrOnpzkKONwSy
         Oh+YIyQDHJ1a/NP8Tr2mBuVAJ5H85m5avhNKewql3LvtjokpOKmHTDTyo4gYymlsSL7f
         wYKg==
X-Forwarded-Encrypted: i=1; AJvYcCVUICVxjLJCUCXdxZEOMNfzJMlp2TWfZBh2F94WeWzkkXPHjG7ZgZYV+6uKOC/ywSJN4aN7DmutzW49rd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNRbTMQR0bt/07X7U+orQQ/skQpKLlCHX9AFnMZ3bUdWLnlKby
	G4vgWVFSjkuLq4nM4hgc1skRoKJW5mKX/fTvvvbNzQ27v6eu2gkrK9rhDqpgHK0=
X-Gm-Gg: ASbGnctCzTBIq9WtpYTfBaXx3fduFh7etqnpJUeVl22llrYVb6BcWOau5u3C4SjywhS
	2nGsTnk1TbdMWzS1QK4NCPxKVRhph0swD7Oiqz2tmObR3bXSiL9JuQPyZSXIIwBmEFw3KOXO3kz
	DddkaiIbgpYcqfi09T9YIIVu8beYjDgdwvCJ/DjsdDtP+qm1YZyYdTxH0lfRUF/401Md3uNFa69
	D+cN3EQ5DG+pFruvoq2xxj6RFEtr+Kcbz+hHtimelpYk2vXAxja4brwAFeytpE++XUU84xZ/McY
	1LnP19qdyYy6rj/D5cSW2Ml5zEj0P/tR
X-Google-Smtp-Source: AGHT+IGPifbnY9fgJZ0p0hOK7b2VosZ1UqTOiKpbP4FQw26n9tMmWYULhtHyH1vn12fopbDb6l3rdw==
X-Received: by 2002:a05:6000:144d:b0:390:de66:cc0c with SMTP id ffacd0b85a97d-39973b31a0amr3816811f8f.46.1742404124592;
        Wed, 19 Mar 2025 10:08:44 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b748bsm21797789f8f.39.2025.03.19.10.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:08:44 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:08:43 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Himanshu Chauhan <hchauhan@ventanamicro.com>, 
	Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>, 
	Atish Patra <atishp@atishpatra.org>
Subject: Re: [PATCH v3 2/4] riscv: add support for SBI Supervisor Software
 Events extension
Message-ID: <20250319-46b625cf8b771616d4c7c053@orel>
References: <20241206163102.843505-1-cleger@rivosinc.com>
 <20241206163102.843505-3-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206163102.843505-3-cleger@rivosinc.com>

On Fri, Dec 06, 2024 at 05:30:58PM +0100, Clément Léger wrote:
...
> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id, int cpu)
> +{
> +	void *stack;
> +
> +	arch_evt->evt_id = evt_id;
> +	stack = sse_stack_alloc(cpu, SSE_STACK_SIZE);
> +	if (!stack)
> +		return -ENOMEM;
> +
> +	arch_evt->stack = stack + SSE_STACK_SIZE;
> +
> +	if (sse_init_scs(cpu, arch_evt))
> +		goto free_stack;
> +
> +	if (is_kernel_percpu_address((unsigned long)&arch_evt->interrupted)) {
> +		arch_evt->interrupted_state_phys =
> +				per_cpu_ptr_to_phys(&arch_evt->interrupted);
> +	} else {
> +		arch_evt->interrupted_state_phys =
> +				virt_to_phys(&arch_evt->interrupted);
> +	}
> +
> +	return 0;

Hi Clément,

Testing SSE support with tools/testing/selftests/kvm/riscv/sbi_pmu_test
led to an opensbi sbi_trap_error because the output_phys_lo address passed
to sbi_sse_read_attrs() wasn't a physical address. The reason is that
is_kernel_percpu_address() can only be used on static percpu addresses,
but local sse events get their percpu addresses with alloc_percpu(), so
is_kernel_percpu_address() was returning false even for local events. I
made the following changes to get things working.

Thanks,
drew

diff --git a/arch/riscv/kernel/sse.c b/arch/riscv/kernel/sse.c
index b48ae69dad8d..f46893946086 100644
--- a/arch/riscv/kernel/sse.c
+++ b/arch/riscv/kernel/sse.c
@@ -100,12 +100,12 @@ int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id, int cp
        if (sse_init_scs(cpu, arch_evt))
                goto free_stack;

-       if (is_kernel_percpu_address((unsigned long)&arch_evt->interrupted)) {
+       if (sse_event_is_global(evt_id)) {
                arch_evt->interrupted_state_phys =
-                               per_cpu_ptr_to_phys(&arch_evt->interrupted);
+                               virt_to_phys(&arch_evt->interrupted);
        } else {
                arch_evt->interrupted_state_phys =
-                               virt_to_phys(&arch_evt->interrupted);
+                               per_cpu_ptr_to_phys(&arch_evt->interrupted);
        }

        return 0;
diff --git a/drivers/firmware/riscv/riscv_sse.c b/drivers/firmware/riscv/riscv_sse.c
index 511db9ad7a9e..fef375046f75 100644
--- a/drivers/firmware/riscv/riscv_sse.c
+++ b/drivers/firmware/riscv/riscv_sse.c
@@ -62,11 +62,6 @@ void sse_handle_event(struct sse_event_arch_data *arch_event,
                        ret);
 }

-static bool sse_event_is_global(u32 evt)
-{
-       return !!(evt & SBI_SSE_EVENT_GLOBAL);
-}
-
 static
 struct sse_event *sse_event_get(u32 evt)
 {
diff --git a/include/linux/riscv_sse.h b/include/linux/riscv_sse.h
index 16700677f1e8..06b757b036b0 100644
--- a/include/linux/riscv_sse.h
+++ b/include/linux/riscv_sse.h
@@ -8,6 +8,7 @@

 #include <linux/types.h>
 #include <linux/linkage.h>
+#include <asm/sbi.h>

 struct sse_event;
 struct pt_regs;
@@ -16,6 +17,11 @@ struct ghes;

 typedef int (sse_event_handler)(u32 event_num, void *arg, struct pt_regs *regs);

+static inline bool sse_event_is_global(u32 evt)
+{
+       return !!(evt & SBI_SSE_EVENT_GLOBAL);
+}
+
 #ifdef CONFIG_RISCV_SSE

 struct sse_event *sse_event_register(u32 event_num, u32 priority,

