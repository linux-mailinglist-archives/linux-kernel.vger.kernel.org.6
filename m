Return-Path: <linux-kernel+bounces-206783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3F6900DA4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697FE1F2383D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26497155393;
	Fri,  7 Jun 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NvswjED7"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024515531E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796509; cv=none; b=P1bv/Gei6s6yBkKO0X2xMj6VrOMnlw50fGSmEY8qejvyDg0Ruh0YXTN8owIDjSJIiQ3sjBT2jLnifBJA5JZ7tYaNfeSxjIEKuVxpfeNKJDQrvXIEpv/o9l4tA+K1G4ln0892ImUzXeC2KjbIoR0UUvQQtObMkZPS+oy1PcVrBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796509; c=relaxed/simple;
	bh=I6OYdME4YyKGdESbO9vXata9GaCPYs9hOxorFf2GH0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/BmQjGZAcbF8UKTsTHxt8zDA/AIAZSFcu7ClblyWDLicA+qAA4S4li/FtInrqJP02gfhltFlmoBVzVX4u6+CCK9baCmVWpwIwTn9W4DBBc6e4+2+jTjcsO80rTZlgEim3SeY7LgfFfYlp1Fq+zBDyFLB9uQyV76zKBUpsp5jDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NvswjED7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70257104b4dso2155073b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717796507; x=1718401307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVMBxgOZvhcZ4lZh/IEF1Kc1tCSw0EaERqV8JO3osOo=;
        b=NvswjED7vo4EJovy3/1NKlgd9EboxkanTiTP57CZX1CIVJxKp2G7fVhOKkF8FxaLCr
         fTa12SoQ7DFVBsLcxU3dPTZatq3WzhDo/OXED/qgfwT8QYaN5f6NPMwlWXwHMCJLBkxs
         MINf3K+J4i23Mx1/hhlqzjQ2EctUWUmdkoXJzM3Deu905xkx8nGlfH3zmBNCSSAtXxvt
         SyIHX/REWNjBffU54jf9O7uvkpfqCYXFiackTAYPmCF4t4D8KzZoasPBQKj4FHfOBMaZ
         lcQxq+94WqnGUZYmDdbfqbSVKLo83NMuULmHPEjg2fKpxT5z0mYkQP0Wr127fXhWX72s
         +wLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717796507; x=1718401307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVMBxgOZvhcZ4lZh/IEF1Kc1tCSw0EaERqV8JO3osOo=;
        b=wZh931TNbpzn3przV6K6NIhBxyVOrjSoFSVZ0muVPNCwSWkWREXZIMm2RFJJ6L7JGU
         PQi2bP8KiHB1Zkn9Ep9G71GZMNyDPi3fIcuxYgwYYAdNadzmlGTGajio1QTTDq2hByPX
         7xRdAl8AIMEP4EG9iNhQvaXILiLhFrcpWfc9kaMQcTQbAidTJiKXVim9Ukby6w33R1kQ
         aW6GCJdk02jgW7INi4oOOotKI6I3JoLTshmU3+KHX/ZIYNcaN8ywMLy5ONsLYPxhH4L4
         EG5Q29eTg/6C2mcUu4rjoCAs8PPyFrfVmH1jOHNokGLyvxhNVSbbAxWfJ/z9MeeWWcDY
         /9TA==
X-Forwarded-Encrypted: i=1; AJvYcCXwDcvwauueXXhlW/clAqZbg8vj/aqIVeL4DOdziN0nRYCN2+RsnyuabDhKdtxXSqGEbga4AsZkobTO2ez98rzV8SEsl8qj2YV8BFw4
X-Gm-Message-State: AOJu0YzaPTOFfmU+4q7Zv8o7feEoEysQL8Pn+yDz6ZGQ4tihjuFyVAjG
	TMu/un4RVUs00XJBq2HDJglz/7NwLBFzfo73a+VxfJNPgrZzBEiUt3PttjoA4W8=
X-Google-Smtp-Source: AGHT+IEON1DUv8NlmIa4hw9K9kVfTrFWzqHWzvt9nCJEWjhynBx9I0jhBPbJAq1+9gf/doFtH0t1RQ==
X-Received: by 2002:a05:6a20:6a07:b0:1af:6911:7ff4 with SMTP id adf61e73a8af0-1b2f96b3617mr4004313637.7.1717796506812;
        Fri, 07 Jun 2024 14:41:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd3b2e71sm3087103b3a.90.2024.06.07.14.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:41:46 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:41:44 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] riscv: Enable cbo.zero only when all harts support
 Zicboz
Message-ID: <ZmN+mKC3Mr213rvU@debug.ba.rivosinc.com>
References: <20240605205658.184399-1-samuel.holland@sifive.com>
 <20240605205658.184399-2-samuel.holland@sifive.com>
 <ZmNu9AkHOTGj9uvw@debug.ba.rivosinc.com>
 <20240607-unwound-ethics-b6bf97cddc3e@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240607-unwound-ethics-b6bf97cddc3e@spud>

On Fri, Jun 07, 2024 at 09:39:50PM +0100, Conor Dooley wrote:
>On Fri, Jun 07, 2024 at 01:35:00PM -0700, Deepak Gupta wrote:
>> On Wed, Jun 05, 2024 at 01:56:45PM -0700, Samuel Holland wrote:
>> > Currently, we enable cbo.zero for usermode on each hart that supports
>> > the Zicboz extension. This means that the [ms]envcfg CSR value may
>> > differ between harts. Other features, such as pointer masking and CFI,
>> > require setting [ms]envcfg bits on a per-thread basis. The combination
>> > of these two adds quite some complexity and overhead to context
>> > switching, as we would need to maintain two separate masks for the
>> > per-hart and per-thread bits. Andrew Jones, who originally added Zicboz
>> > support, writes[1][2]:
>> >
>> >  I've approached Zicboz the same way I would approach all
>> >  extensions, which is to be per-hart. I'm not currently aware of
>> >  a platform that is / will be composed of harts where some have
>> >  Zicboz and others don't, but there's nothing stopping a platform
>> >  like that from being built.
>> >
>> >  So, how about we add code that confirms Zicboz is on all harts.
>> >  If any hart does not have it, then we complain loudly and disable
>> >  it on all the other harts. If it was just a hardware description
>> >  bug, then it'll get fixed. If there's actually a platform which
>> >  doesn't have Zicboz on all harts, then, when the issue is reported,
>> >  we can decide to not support it, support it with defconfig, or
>> >  support it under a Kconfig guard which must be enabled by the user.
>> >
>> > Let's follow his suggested solution and require the extension to be
>> > available on all harts, so the envcfg CSR value does not need to change
>> > when a thread migrates between harts. Since we are doing this for all
>> > extensions with fields in envcfg, the CSR itself only needs to be saved/
>> > restored when it is present on all harts.
>> >
>> > This should not be a regression as no known hardware has asymmetric
>> > Zicboz support, but if anyone reports seeing the warning, we will
>> > re-evaluate our solution.
>> >
>> > Link: https://lore.kernel.org/linux-riscv/20240322-168f191eeb8479b2ea169a5e@orel/ [1]
>> > Link: https://lore.kernel.org/linux-riscv/20240323-28943722feb57a41fb0ff488@orel/ [2]
>> > Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> > ---
>> >
>> > arch/riscv/kernel/cpufeature.c | 7 ++++++-
>> > arch/riscv/kernel/suspend.c    | 4 ++--
>> > 2 files changed, 8 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> > index 5ef48cb20ee1..2879e26dbcd8 100644
>> > --- a/arch/riscv/kernel/cpufeature.c
>> > +++ b/arch/riscv/kernel/cpufeature.c
>> > @@ -27,6 +27,8 @@
>> >
>> > #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
>> >
>> > +static bool any_cpu_has_zicboz;
>> > +
>> > unsigned long elf_hwcap __read_mostly;
>> >
>> > /* Host ISA bitmap */
>> > @@ -92,6 +94,7 @@ static bool riscv_isa_extension_check(int id)
>> > 			pr_err("Zicboz disabled as cboz-block-size present, but is not a power-of-2\n");
>> > 			return false;
>> > 		}
>> > +		any_cpu_has_zicboz = true;
>> > 		return true;
>> > 	case RISCV_ISA_EXT_INVALID:
>> > 		return false;
>> > @@ -724,8 +727,10 @@ unsigned long riscv_get_elf_hwcap(void)
>> >
>> > void riscv_user_isa_enable(void)
>> > {
>> > -	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
>> > +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
>> > 		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
>> > +	else if (any_cpu_has_zicboz)
>> > +		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
>>
>> `riscv_has_extension_unlikely` will check bitmap `riscv_isa[0]` which I think gets populated
>> by boot cpu (correct me if I am wrong here). So as long boot processor has the extension, it'll
>> try to set it on CPU which doesn't have it.
>>
>> How about doing this
>>
>> `riscv_fill_hwcap_from_isa_string` checks and enables bitmap for all CPUs.
>> So make a check there and if any of the CPU dont have `Zicboz`, then set a global bool
>> `zicboz_cpu_not_homogenous`.
>
>That is what riscv_fill_hwcap.*() already does, we track both what each
>cpu has and what is common across all cpus.
>riscv_has_extension_[un]likely() is a test for whether all cpus have the
>extension.
>

Thanks for clarifying that.

Samuel,

Ignore my comment then.
This patch lgtm.

>> Now in `riscv_user_isa_enable`, check following
>>
>> If `zicboz_cpu_not_homogenous` is set, then you already detected that some of the CPUs don't
>> have support for `Zicboz` and thus you wouldn't set for CPU which even has the support and
>> print a warning message.
>>
>> If `zicboz_cpu_not_homogenous` is clear, then that means all CPUs support the feature.
>> You simply enable it on hart.



