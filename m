Return-Path: <linux-kernel+bounces-332673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF09597BCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AAD283C38
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E0E18A92D;
	Wed, 18 Sep 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMrdCGKy"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B88D186E3E
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665184; cv=none; b=SFtxcUFpKfm8IFA3sDs114dC6FkyIo33b2IyQuu/5O7INsmNIZ7aN2zkEKPkXic7XenVcaURiEbCIXzZiJkiZt8VIv5f9joWRG+fuBmX7/QR2C14yAuXwwY9UkR7mSQdPOfBj1P1Ll2UaAIkIxXZjs3a0KARoBxP8RhYHn2ggFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665184; c=relaxed/simple;
	bh=t1BTgFJSuELqW46e+hZA6MBoAE+CKlGmnWti3rAyLDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5b+wY95bhR86FjWcY4keDNNDj4EMhf69jdOncuv6Gv4423Z71HMIogN3Yc5cz+yxCFHT3yUrK74UeP3emyeYamwird16uSbo5qVZT1yk0gvzXmN+lcMPf1iIDOLKDfYFhbXRUzzojyDfBMc2kMxMIIqxcFaav0ENf4Uh3guE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lMrdCGKy; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f77fe7ccc4so59675021fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726665180; x=1727269980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1UIao/Jz5H8HMYQFxpoEYcHdlz/BHFAG+1NToY/M7y4=;
        b=lMrdCGKy0SRwCTaB5zekixs48dnTZwasXy36Cv4MRBwh1P/ekOaQXyU1MhHedUfYhu
         JoB2K2G3hBkQjNyfFeiofaqF3XvVP9dlpq1lrhGY/ar9LnHXwo/P/5lQFPvr0YnJXxyp
         V/GGh9sMRY6r7ZxB4EDib/h3bG4bGpGOsrMfzTznUJBFLGzHRniloGGbPncod1PCtTB0
         9tVUP3cB48cH/oHq57s+n8nFJRQuCBms+gjWYvSK6C6UkEluiBY7PnUCukXSujsmU4Pc
         2ptDVKG8D1IHwOa8vtG1mt8dQ5sNttkVMd56sxG1Qx1M9SbmlAGKDrseCI45tMcImdWx
         x3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726665180; x=1727269980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UIao/Jz5H8HMYQFxpoEYcHdlz/BHFAG+1NToY/M7y4=;
        b=g2o7Y/sW7mf3UjjGncC6n1BGyyZMq6mTFROnofjxeWvTs35d1x71LY/UNoqUu63IWg
         LtZKKHKxJYdPFvE2kYB5m8e3ipCHWTWvSAdRcJ/s2WnKkYBaT/BP8zi65o7O3HQZej4d
         fsfFdas52lyxSXYiweQVA08g7FCYQJKB3xjOg6nkq0S/Py/T8IPwAQBvuLi7Xt3bbpJj
         GIm5FdP3q3rn/ksXEt4J0PxhG7OJI3x6f9MxvBF7HcOWN8hoTOmkfnhe531lG9ODwqtr
         IA6njfNdygK+YSy/+TUrCVH4Rcp+t0vg/zBkNNCIfrE+LnzyI12QrE9WbcvncWk/2EYE
         6PHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Qcck0FoKmxbp2S/2lEnsDZPEjRExvc7zTFM8WorlZ/1jwukeCOE4ZGpph/C59+EXUE1yK1genE5pRiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTo30p3R0Zgx9yiiOHLdSLtfYNhm3bJyXzet18fDkcysViDa1x
	+tb/jNGRk5axTnAT36IF16HaAJQOUxN46CYSy47kBGN9yEjw7II3P7SS5imYAjtijOlLHQ+EDZM
	EKNaJQf10AmNKT9aRmVV0Pc3OEJ7xTEucYCoi5Q==
X-Google-Smtp-Source: AGHT+IF5izfJa+xhgK0mjYVqlKJIK89IcU1cb1NpZfcXm0pryp2o/BMT6N8z0wfXVAWqfUbW+2JjG7UdxmVTGR7xheE=
X-Received: by 2002:a05:651c:509:b0:2f3:fd4a:eac6 with SMTP id
 38308e7fff4ca-2f7919fe8d6mr81760011fa.18.1726665180209; Wed, 18 Sep 2024
 06:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel> <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
 <20240917-b13c51d41030029c70aab785@orel> <8b24728f-8b6e-4c79-91f6-7cbb79494550@canonical.com>
 <20240918-039d1e3bebf2231bd452a5ad@orel> <CAFEAcA-Yg9=5naRVVCwma0Ug0vFZfikqc6_YiRQTrfBpoz9Bjw@mail.gmail.com>
 <bab7a5ce-74b6-49ae-b610-9a0f624addc0@canonical.com>
In-Reply-To: <bab7a5ce-74b6-49ae-b610-9a0f624addc0@canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Sep 2024 14:12:48 +0100
Message-ID: <CAFEAcA-L7sQfK6MNt1ZbZqUMk+TJor=uD3Jj-Pc6Vy9j9JHhYQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, 
	Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 14:06, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> Thanks Peter for looking into this.
>
> QEMU's cpu_synchronize_all_post_init() and
> do_kvm_cpu_synchronize_post_reset() both end up in
> kvm_arch_put_registers() and that is long after Linux
> kvm_arch_vcpu_create() has been setting some FPU state. See the output
> below.
>
> kvm_arch_put_registers() copies the CSRs by calling
> kvm_riscv_put_regs_csr(). Here we can find:
>
>      KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
>
> This call enables or disables the FPU according to the value of
> env->mstatus.
>
> So we need to set the desired state of the floating point unit in QEMU.
> And this is what the current patch does both for TCG and KVM.

If it does this for both TCG and KVM then I don't understand
this bit from the commit message:

# Without this patch EDK II with TLS enabled crashes when hitting the first
# floating point instruction while running QEMU with --accel kvm and runs
# fine with --accel tcg.

Shouldn't this guest crash the same way with both KVM and TCG without
this patch, because the FPU state is the same for both?

-- PMM

