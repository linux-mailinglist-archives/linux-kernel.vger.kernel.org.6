Return-Path: <linux-kernel+bounces-523148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CC0A3D2B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD953B8AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E81E9B1C;
	Thu, 20 Feb 2025 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fYwLcoQa"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB1F1A8F8E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038494; cv=none; b=IZpVF4njvdPi9YBGZAxuEzNsfPoucvxHDbG7nX+g/LVqiqvH5yUThq/7CMO9QRpni0uBmsuyljJayWhRV4FhdddENiFvSvgxrkP7H5He3fvmLFDkOFajHNL3gDERqBWxSuouyPj+c0sYfFbdBxd+ccI7aCzFVBdtErto5EqSd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038494; c=relaxed/simple;
	bh=kirYADeuKfKliqL7qNUWgrccufMUQj6DEyxaVPr/5Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHjHSlBct0E2H4mC1BQu1GLliSdsrSpTNpECU+kB+nhHjK2j45Y5YIucxKv4JI+Ap9sVOxOo6GgrZiLipOnJCtcjHlFkkAmZVQDk2ZkZlUYl8Of655TdMKci9H8RrnlYF8pZ0Q9o7n3YFEK04U8Mf840C578FjK/4e3V9A6RJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fYwLcoQa; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso272245f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740038491; x=1740643291; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qd7KqhH3kfPjHtgw/90Ms4Puk/b53LCg7WjeYOFj6kI=;
        b=fYwLcoQam0uxPFwr0VgVCWo+6kBTY5hQy7P9Bqry6+C91iWgIqGHKPk0+9Q+ammUtq
         LLfF/JecRTrMM7AzTrey135fkzNFJi8sqdyPuChvr5HaHZMW9zfrKywwLC80uwLdsu13
         SoDAxDaca1RlNyelNu149B6tAS6t8PQSIQ2dIi3oSUQkznJFUYMnWYfowK9HdCvNBhfY
         YvfVqTWTyENHraQoNQsh5yoHsL4Ze6M/6NaEWNk/x55+1m/E3RspOnJvnMrdDbHBRtUh
         Orr72jDPR8W9qb6wxBvACYNmfJGSjUG9L6FkJSUAG/L4C7PoC+LWk+LM6kfiwaSIPAVG
         Gc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740038491; x=1740643291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qd7KqhH3kfPjHtgw/90Ms4Puk/b53LCg7WjeYOFj6kI=;
        b=EjysHpTG9nUh33i+65nYWDnxqvdX9LZUPSekJ2EbDGZTtdjmntycoV9RtUi8PmZYol
         vV5b77eyFxm1+skAwTjI2weULrTvTzZTurEiFUEujgFiVQZoYArqJFSrqaV+l4dGIHKR
         xkRWJs6BIEXSA/UDi9LnN8PFowUxL/vc/hF9eQcUjSZiyzZYqqB7jflHtZCAFVzC3/8g
         ox9OGE1IhrkASmxtU+TQRlk3/QKh9ObWRI/d9uBugAZLhmYBc30YrXVP17bcF7z8c3os
         qAHXxWIzYmtaVl6bHwyUXQs+zS5J0TZky10cHtlz3yvgltONMMJAR9Dl4PRWgCUlM5P3
         o5wA==
X-Forwarded-Encrypted: i=1; AJvYcCXjeB27AIacdJPSCOxyNT5jBilyjZzs4A2FvXCkcaWEReMyw8r7uT+dvhKuO/XCzf2IDU7lIcc6CYY3n04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMFl6+vyey4TYxpDDPxMTb6q3xcWpAPkiCxUZxTdPYKNLRzxHV
	zUmTPXe75Q7K2hrmlEB+mvRXcckcVlsM80tc/IcZfNiP+3hbFkChVnxsbMXtBggSYTZGU1hUTd3
	R
X-Gm-Gg: ASbGncunRMgK+4maZejsVIRlBF7VQQjm0lXzfZMBSSJ2a3JQ5wvHdj8NKlkG8tCuelo
	iwQ/SyCes8Pb9OkdU7gJTDtst8uposylWALkMEmpfUgp3XvvHAiZVkXoni/wkpyIbDUvBLB4TkQ
	w1XKZaEv1AWSnxtIGSW2RLq4iHpwaVCeNSFI6Vp8eHuKaIkAWLatqFB3C6yUns86OB1kM5Q8YCI
	+6N/s62vzyOO8RWC4N0gbyUbk1KqnObZN3bZu3M4MHIb9VXLcKHQX0Z1V5FrgwjZLw+73+uAiZg
	pbM=
X-Google-Smtp-Source: AGHT+IFM6700LK+74HpOeXyoMgkggOf0cRqXu8y6ZzQbVQm2qqlIWdH1erTmldYEmvvOPb18VleqSg==
X-Received: by 2002:a05:6000:1f87:b0:38d:e6b6:5096 with SMTP id ffacd0b85a97d-38f33f3d4bamr20173510f8f.15.1740038490670;
        Thu, 20 Feb 2025 00:01:30 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e9esm20195560f8f.61.2025.02.20.00.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:01:29 -0800 (PST)
Date: Thu, 20 Feb 2025 09:01:28 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: xiangwencheng <xiangwencheng@lanxincomputing.com>
Cc: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	anup@brainfault.org, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, atishp@atishpatra.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH] riscv: KVM: Remove unnecessary vcpu kick
Message-ID: <20250220-f9c4c4b3792a66999ea5b385@orel>
References: <20250219015426.1939-1-xiangwencheng@lanxincomputing.com>
 <D7WALEFMK28X.13HQ0UL1S3NM5@ventanamicro.com>
 <38cc241c40a8ef2775e304d366bcd07df733ecf0.f7f1d4c7.545f.42a8.90f5.c5d09b1d32ec@feishu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38cc241c40a8ef2775e304d366bcd07df733ecf0.f7f1d4c7.545f.42a8.90f5.c5d09b1d32ec@feishu.cn>

On Thu, Feb 20, 2025 at 03:12:58PM +0800, xiangwencheng wrote:
...
> As "KVM:  WFI wake-up using IMSIC VS-files" that described in [1], writing to 
> VS-FILE will wake up vCPU.
> 
> KVM has also handled the situation of WFI. Here is the WFI emulation process:
> kvm_riscv_vcpu_exit 
>     -> kvm_riscv_vcpu_virtual_insn 
>          -> system_opcode_insn 
>               -> wfi_insn 
>                  -> kvm_riscv_vcpu_wfi
>                      -> kvm_vcpu_halt
>                          -> kvm_vcpu_block
>                              -> kvm_arch_vcpu_blocking
>                                    -> kvm_riscv_aia_wakeon_hgei
>                                          -> csr_set(CSR_HGEIE, BIT(hgei));
>                              -> set_current_state(TASK_INTERRUPTIBLE);
>                              -> schedule
> 
> In kvm_arch_vcpu_blocking it will enable guest external interrupt, which
> means wirting to VS_FILE will cause an interrupt. And the interrupt handler
> hgei_interrupt which is setted in aia_hgei_init will finally call kvm_vcpu_kick
> to wake up vCPU.
> 
> So I still think is not necessary to call another kvm_vcpu_kick after writing to
> VS_FILE.
> 
> Waiting for more info. Thanks.
> 
> [1]  https://kvm-forum.qemu.org/2022/AIA_Virtualization_in_KVM_RISCV_final.pdf
>

Right, we don't need anything since hgei_interrupt() kicks for us, but if
we do

@@ -973,8 +973,8 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
        read_lock_irqsave(&imsic->vsfile_lock, flags);

        if (imsic->vsfile_cpu >= 0) {
+               kvm_vcpu_wake_up(vcpu);
                writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
-               kvm_vcpu_kick(vcpu);
        } else {
                eix = &imsic->swfile->eix[iid / BITS_PER_TYPE(u64)];
                set_bit(iid & (BITS_PER_TYPE(u64) - 1), eix->eip);

then we should be able to avoid taking a host interrupt.

Thanks,
drew

