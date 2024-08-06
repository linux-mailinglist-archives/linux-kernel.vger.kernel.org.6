Return-Path: <linux-kernel+bounces-276464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4784E949421
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038F5282FC7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD0D205E1B;
	Tue,  6 Aug 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="mMWwz2HZ"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27161EB4AD
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956662; cv=none; b=BeflCbQQePOM/42Ydqmii4sxMarUuqkpHOVB0eLw4hg5fNoaOHTqSUoZ/Ya9XZH5YDcDiCR0TON/X/OlOCg7VB++jQapjhEkxA5AZJ1TwYN+rWdTUC61ErpaKYzTzrTHiVk9pc+TBtmqG7BS4n/kWux22qTeG3h5fLEkWmqbW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956662; c=relaxed/simple;
	bh=weU0/ygthEVhph5l+8/dKvcNrdBMCRxTJh5fbqP3ZFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQE5v6KhuCOPvpIUwty+DaXo1TiCgQoywMCC5EzM0QfuignpcqSX5hfvxQR3/CD/iwKXg0gosNJYH9zXx/EzqjNFhhYAPM8r9LjUrAlODqstF0x6yV3e1e75kBBTv3k0sQASPcMt0qA2JG74wxslX/PucxYadc0KuOTdJcWHd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=mMWwz2HZ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39adbfafde5so3003135ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1722956660; x=1723561460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLks5Q0iPBrgmJrvgcvS8LOwX/9jLhdRfGiAtwiNPmc=;
        b=mMWwz2HZoV+88ZnGUtD/Ac1qa4ACQkojhOPJpIT+8v4Xdq6SN2eF0y8UuQ8TBO4IC8
         p9ZwaKi2jeEPRRZHun3m2xIy6zxOxZUw+Uc/lPYBpD4L+w4kanAk/+30UtI6pYNlBq7O
         NgqymUSXc5zoBJCMU7q9ibmt1P4wTg4N2GFl4HR9e0+UMz8QU/4bh9yo1VExAiJfuMmZ
         wsk2UCeU+YNZfnhGcT/wf5WDM3NUxaln8U1HjdxoQEidk7VD5srJ152O9qGI3fPXR4hT
         R8EzEjT9ZH4DPiruTdtAMlwVuy0djg5obwRihK260KeLBPrfvdGaI95TLwjD0ppB4oi5
         nzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722956660; x=1723561460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLks5Q0iPBrgmJrvgcvS8LOwX/9jLhdRfGiAtwiNPmc=;
        b=eoQtJ4bLZSMxEcqlYkOfQYWC2FLkDpe7DTA3f7lYWGAJljn25eXbsICt5SPJyr0Jeu
         TPYJqN8mOH7qn7ONTzLYA6sQKYTOAv3LeKnKLDyXNoCHfS5IW/WLq6RBmvAQMPXKyA4j
         osl4MMEiToDBevg7d6FrfMm+1EMfGTRAt2JYSjkVuoFVondkAHZWS7a3o/E8OSSHAh5B
         3a6PjxUJtuc1lAwHTRRhbNQfi/svruXEdP+b/6zFl4Jgky4z2b6wsPFAIp1NxkG5Az0X
         q7mJX+zb2V66qKwaBVmGmoYe1Q6mpGQvVE3+/5Fty4riM+I+Hg1SeLybSRQU4S927TNd
         BVeg==
X-Forwarded-Encrypted: i=1; AJvYcCVYdplipwayAshaZjzytjt4w72Z7das1qAx7CNT2do/euRpV+/Akj+lSSIvsbbhk2BiiQMeS35QMmb9EL+37tD7BKQaKY5n/vwy1sZg
X-Gm-Message-State: AOJu0Yybojh7dP2Z6IHn5WkwDxCMT3dcPAGkl0e1TUq6TopGiOg+5EUP
	Fe50azWSsU1jg3090LdoEqvakmbEQC4bEGfCbXIJTq0r3nHENSIbjKHEDwXeRadI+ydA4bLn/U8
	d6Vk2CNq+uqPs7WE7XjvkqdogOQ74EBDIPafv8Q==
X-Google-Smtp-Source: AGHT+IGyDNkeg1CkpECSQ0akll4U0MAQSWPOL8L25sxstJveeDCZd19K8yTTFoue56gvit0ch8aH+2CGmbmtibK8NQ8=
X-Received: by 2002:a92:c0d1:0:b0:374:9c67:1df6 with SMTP id
 e9e14a558f8ab-39b1fc23546mr155430195ab.22.1722956659564; Tue, 06 Aug 2024
 08:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com> <20240726235234.228822-58-seanjc@google.com>
In-Reply-To: <20240726235234.228822-58-seanjc@google.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 6 Aug 2024 20:34:08 +0530
Message-ID: <CAAhSdy2rvPCuN7ROU4k9pAuyCZUnyDf2DhHjfSa_pA5SG6Q5DA@mail.gmail.com>
Subject: Re: [PATCH v12 57/84] KVM: RISC-V: Mark "struct page" pfns accessed
 before dropping mmu_lock
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 5:24=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Mark pages accessed before dropping mmu_lock when faulting in guest memor=
y
> so that RISC-V can convert to kvm_release_faultin_page() without tripping
> its lockdep assertion on mmu_lock being held.  Marking pages accessed
> outside of mmu_lock is ok (not great, but safe), but marking pages _dirty=
_
> outside of mmu_lock can make filesystems unhappy.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Regards,
Anup


> ---
>  arch/riscv/kvm/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 06aa5a0d056d..806f68e70642 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -683,10 +683,10 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>  out_unlock:
>         if ((!ret || ret =3D=3D -EEXIST) && writable)
>                 kvm_set_pfn_dirty(hfn);
> +       else
> +               kvm_release_pfn_clean(hfn);
>
>         spin_unlock(&kvm->mmu_lock);
> -       kvm_set_pfn_accessed(hfn);
> -       kvm_release_pfn_clean(hfn);
>         return ret;
>  }
>
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>

