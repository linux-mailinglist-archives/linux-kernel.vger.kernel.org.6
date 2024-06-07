Return-Path: <linux-kernel+bounces-206726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7646D900D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F072A1F26B01
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B2F154BE4;
	Fri,  7 Jun 2024 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fPWryk+s"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B4233EE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792505; cv=none; b=inmPRBZBFwOK0M7Suijg0Z7kS8N7+qSaY0dfp6VrXJJqk5SWw3rWf0n9NWWXu7QEhO6mhySWRFn2OYV2evR7tyVu/DZBE1Gs2T2fqMJ40LVwUwI5eJrnCnk99rTH5RVokoBaKL1MIzum5T4Yk9Ui9z5S86y4uZwNqeJQdIfQqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792505; c=relaxed/simple;
	bh=xEFU2zSTb1izVVHOW614ofveL2cN/IiLF3LT9MwPLjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAnDfvOF0oJmZaXfo8+UjQJTKGi0zuCo5Math8mZsAL5LtlanWKZzYXpVLZuGFk601bhiWZUUkx2AzzYujHWjC3JffXieR3C7e4AUxrwkqUtmPAMvyuBrCck3wWMOjY62z1T44NfrWQ5lAKlvYH/cGCnMqnE7YTWYOO1vDwlk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fPWryk+s; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-702508bf0a9so2122986b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717792502; x=1718397302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLToHBNr/z+D9LPjVFlPmqNBuwl70ZStg9nQgfuU29g=;
        b=fPWryk+sb8CpZjGc0e5prV9EGPcrlDqodYiidVOrE/sUHfhCCQuY0Bzqa58mDNaLHu
         ikDopfX/La177ac8Nnyh0VSdLPcBhmFJweqBPURVD3cIzfdEVM0TNzTECo/NIcA9prZT
         8VBo0TAXacjKVUt1LvsJWPv2ZEKYsImayGj6jq8YgdtJ2nOppbny04tEHaP0QHH963jH
         4FVRXhMMketmeXifwtb0x4dPNShDIDvHVbIifCaqdUwaoIL4uFod28PCspMRiKIEKGgz
         G3230UdgMeounNYQ+NCwvcjR2rU99550HDtcU03jAM0I7aSK7wQPHI15y+JdmeXIZJ2y
         XB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717792502; x=1718397302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLToHBNr/z+D9LPjVFlPmqNBuwl70ZStg9nQgfuU29g=;
        b=c6Fs1nahFDb39+QuilXo7L4AgfAvRI6WATxHf93vgmXfnTrPpqCB9zc7pXF3G0DNCX
         n1OxqhXIJ1ldi73Sf2cU9V38v/l+pwcw3yAF9TfNW7fcoK9cxnMUvX5ZeZgklEdSRjf7
         HaoE7e6lOHWQyW5W98Iv7LA3ppVgoNjiUwAOQ5z33PhCLsq0g/jVBByX8xDc7U44SQK0
         1x7PqtgbdcnlSbKzEVzZAGz3UdMRNJOBAyvvdtPeXEOjAc7JMfYEXoYQtHOTde0pIrWp
         9K5qInhsIVYTeWol2AWO3x54JwucUh63LYwrpVJV5e38LCqT32FRqu2NL4M81OxckFWW
         /mEA==
X-Forwarded-Encrypted: i=1; AJvYcCWK2JsEbUBcmtBKET1BWIUiICVICdmSviGQp7xys+c9YOu4NDpGj9PGnKTenfJ+Yj0zdsL53+lfcB0ES4TlpxcuXSRrYBasEa+OtJ1q
X-Gm-Message-State: AOJu0YybwU91guM+CccND1sTzk2fF8G/DUCXDjnJsqBEn94oJWb4F3bQ
	R/X4r8zGi6UTXVBYp7jwjqIVD6E9FBmF+mL1FEF8l3fEkdvZvVveV0yS9giLOQA=
X-Google-Smtp-Source: AGHT+IEkCP2WsqBCckWanMFkCe+YhsGIPJ7GAX0xrzeDP2u/J64Ggzg47HO7Pjwmg9u0t5/f1aOJ5w==
X-Received: by 2002:a05:6a00:182a:b0:6f8:d4b8:b215 with SMTP id d2e1a72fcca58-7040c615a61mr3601298b3a.6.1717792502530;
        Fri, 07 Jun 2024 13:35:02 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd3b187fsm2944633b3a.85.2024.06.07.13.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 13:35:02 -0700 (PDT)
Date: Fri, 7 Jun 2024 13:35:00 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] riscv: Enable cbo.zero only when all harts support
 Zicboz
Message-ID: <ZmNu9AkHOTGj9uvw@debug.ba.rivosinc.com>
References: <20240605205658.184399-1-samuel.holland@sifive.com>
 <20240605205658.184399-2-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240605205658.184399-2-samuel.holland@sifive.com>

On Wed, Jun 05, 2024 at 01:56:45PM -0700, Samuel Holland wrote:
>Currently, we enable cbo.zero for usermode on each hart that supports
>the Zicboz extension. This means that the [ms]envcfg CSR value may
>differ between harts. Other features, such as pointer masking and CFI,
>require setting [ms]envcfg bits on a per-thread basis. The combination
>of these two adds quite some complexity and overhead to context
>switching, as we would need to maintain two separate masks for the
>per-hart and per-thread bits. Andrew Jones, who originally added Zicboz
>support, writes[1][2]:
>
>  I've approached Zicboz the same way I would approach all
>  extensions, which is to be per-hart. I'm not currently aware of
>  a platform that is / will be composed of harts where some have
>  Zicboz and others don't, but there's nothing stopping a platform
>  like that from being built.
>
>  So, how about we add code that confirms Zicboz is on all harts.
>  If any hart does not have it, then we complain loudly and disable
>  it on all the other harts. If it was just a hardware description
>  bug, then it'll get fixed. If there's actually a platform which
>  doesn't have Zicboz on all harts, then, when the issue is reported,
>  we can decide to not support it, support it with defconfig, or
>  support it under a Kconfig guard which must be enabled by the user.
>
>Let's follow his suggested solution and require the extension to be
>available on all harts, so the envcfg CSR value does not need to change
>when a thread migrates between harts. Since we are doing this for all
>extensions with fields in envcfg, the CSR itself only needs to be saved/
>restored when it is present on all harts.
>
>This should not be a regression as no known hardware has asymmetric
>Zicboz support, but if anyone reports seeing the warning, we will
>re-evaluate our solution.
>
>Link: https://lore.kernel.org/linux-riscv/20240322-168f191eeb8479b2ea169a5e@orel/ [1]
>Link: https://lore.kernel.org/linux-riscv/20240323-28943722feb57a41fb0ff488@orel/ [2]
>Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>---
>
> arch/riscv/kernel/cpufeature.c | 7 ++++++-
> arch/riscv/kernel/suspend.c    | 4 ++--
> 2 files changed, 8 insertions(+), 3 deletions(-)
>
>diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>index 5ef48cb20ee1..2879e26dbcd8 100644
>--- a/arch/riscv/kernel/cpufeature.c
>+++ b/arch/riscv/kernel/cpufeature.c
>@@ -27,6 +27,8 @@
>
> #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
>
>+static bool any_cpu_has_zicboz;
>+
> unsigned long elf_hwcap __read_mostly;
>
> /* Host ISA bitmap */
>@@ -92,6 +94,7 @@ static bool riscv_isa_extension_check(int id)
> 			pr_err("Zicboz disabled as cboz-block-size present, but is not a power-of-2\n");
> 			return false;
> 		}
>+		any_cpu_has_zicboz = true;
> 		return true;
> 	case RISCV_ISA_EXT_INVALID:
> 		return false;
>@@ -724,8 +727,10 @@ unsigned long riscv_get_elf_hwcap(void)
>
> void riscv_user_isa_enable(void)
> {
>-	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
>+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
> 		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
>+	else if (any_cpu_has_zicboz)
>+		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");

`riscv_has_extension_unlikely` will check bitmap `riscv_isa[0]` which I think gets populated
by boot cpu (correct me if I am wrong here). So as long boot processor has the extension, it'll
try to set it on CPU which doesn't have it.

How about doing this

`riscv_fill_hwcap_from_isa_string` checks and enables bitmap for all CPUs.
So make a check there and if any of the CPU dont have `Zicboz`, then set a global bool
`zicboz_cpu_not_homogenous`.

Now in `riscv_user_isa_enable`, check following

If `zicboz_cpu_not_homogenous` is set, then you already detected that some of the CPUs don't
have support for `Zicboz` and thus you wouldn't set for CPU which even has the support and
print a warning message.

If `zicboz_cpu_not_homogenous` is clear, then that means all CPUs support the feature.
You simply enable it on hart.

> }
>
> #ifdef CONFIG_RISCV_ALTERNATIVE
>diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
>index c8cec0cc5833..9a8a0dc035b2 100644
>--- a/arch/riscv/kernel/suspend.c
>+++ b/arch/riscv/kernel/suspend.c
>@@ -14,7 +14,7 @@
>
> void suspend_save_csrs(struct suspend_context *context)
> {
>-	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
>+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_XLINUXENVCFG))
> 		context->envcfg = csr_read(CSR_ENVCFG);
> 	context->tvec = csr_read(CSR_TVEC);
> 	context->ie = csr_read(CSR_IE);
>@@ -37,7 +37,7 @@ void suspend_save_csrs(struct suspend_context *context)
> void suspend_restore_csrs(struct suspend_context *context)
> {
> 	csr_write(CSR_SCRATCH, 0);
>-	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
>+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_XLINUXENVCFG))
> 		csr_write(CSR_ENVCFG, context->envcfg);
> 	csr_write(CSR_TVEC, context->tvec);
> 	csr_write(CSR_IE, context->ie);
>-- 
>2.44.1
>

