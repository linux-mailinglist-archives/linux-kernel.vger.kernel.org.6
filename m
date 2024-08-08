Return-Path: <linux-kernel+bounces-279394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6147B94BCC3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849991C22777
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771EC18C331;
	Thu,  8 Aug 2024 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGzr8n4p"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6A18C344
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118407; cv=none; b=bGx3jdC9vXIYtgHPR66Wr+dhcFZxR8SvRMsTsVuRdp8fyqXEYOMQy7MkfkDf2+vzqw7sqqLPxlNYtDO5PnDSFXUp7gMLyTQ7oRXi3uWaU8Z4eVgIqpb1fxI0QCyDx/HEVZdK4T+g+uzkFw94sL4BOv2iq0mAJMHM+N7QA75/Bf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118407; c=relaxed/simple;
	bh=4VJkCGOnJpRwR4YKBH81A1uxdWFs9jOzqwkiDCMslRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=COWwSVER0HqJZuoqv7GgFE4u01OdI3wz0L//ZQdjvuWf3sVkVXfQ3FtYgmi6myh2YHhpn34e0kvInHf6Lsbr1NSalP+mAo6UAxhCuu9sLRWgzES3GjASLRAKcSOidI6zMriwld2f9Qg9ryn6zPIarhCo/7sc/s0/fWGgEF0VFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zGzr8n4p; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-369cb9f086aso502645f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 05:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723118403; x=1723723203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8fBZbfSfQMp8/8SurSvfBz+MaimrqNdI2CubOLP3Ew=;
        b=zGzr8n4pjD1TW6J38rzhxbkp5A4UhJhcFdUMRoKC3AgIdDKG2mBpMVtI2x8AIu+OtB
         OJOEaNvB7kyLOtwoP++6Zr4KHWs+zkEtkJrybjLqj6rWkyzSWVQmtfT4aSKVynVFFXF/
         FxuWOUho+LZFi6bwbE9Szd8vBaxRU14uaXRno+lkKiZzW4rl0Nrpa3w/B+3aEtWDpTAz
         RPKWqaM4yQzdqZuJq3KdXHdpPUBrxSZRC6sl9+nmBmdhRsS4qxiFmRnXkLZP1T2nUoUJ
         JbEaJkPwA4k0anB6nltN2kLKtUIkSmkt3puWFpa3P80Up9yFxsjN35NDDX/eXqftEhcq
         /7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723118403; x=1723723203;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8fBZbfSfQMp8/8SurSvfBz+MaimrqNdI2CubOLP3Ew=;
        b=ot2fObLYP9Eapf2mSekFXe3JTajODH70/d0eHJOKK8osXqAcgcvQ6EE/m7eG3jPi5g
         +IPLWgd+RozQ6n//GDI3kjFgEkg9NmlFP7N54WrSNkPOobcK75/hDwj0mfwoabBO5Rkq
         JfSoqIuWm78icCWcytBJJ9E8pAAQfB31EYIHcxXZv/yhBNMX6OBeJUuqe/KQm6dkUQKm
         jGi0Lp37IIEO79qdBNjkbhg1jzDDnhelRHOgk2Vw0Cdww9Fd9A3riJRfnKDG5Uw63agK
         JTLp3DGgcsqsuNK+Ue38NVCUNcUxmcMurOXRBASns5Cj+sLedNw7sayOqcdjjNRGaGHj
         RU6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVl1LH7FbwlNhDGgQG9Ls0H+w9nM+S2OusaYcUxoCWyzHIu8+PnPCJ/68JGcFISXYeQI4K7MYm2UIrEo49vnFc4AjMw+z/j5c1pgyWp
X-Gm-Message-State: AOJu0Yw+olKvOCWC5rfqbWPhpMRau9Ufp8l+/9RLacOk4c7quAm3frOM
	Mzy34ZEdMdOSGmmuI8fdyYPDAab7aQjm7d6C/YeZ9jbhKrXzA31iZ9LkH7i5S5E=
X-Google-Smtp-Source: AGHT+IHHX2fBYyF3bzrkIN6FI+lRc2WcNWD9HizbtFbwpwdbf6zDJoYFHOfDyhNaZKL5sM+Jijm6XQ==
X-Received: by 2002:a5d:698f:0:b0:367:8fee:443b with SMTP id ffacd0b85a97d-36d27561461mr1129489f8f.41.1723118402280;
        Thu, 08 Aug 2024 05:00:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27156c8asm1700288f8f.24.2024.08.08.05.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:00:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 751635F769;
	Thu,  8 Aug 2024 13:00:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Marc Zyngier <maz@kernel.org>,
  Oliver Upton <oliver.upton@linux.dev>,  Tianrui Zhao
 <zhaotianrui@loongson.cn>,  Bibo Mao <maobibo@loongson.cn>,  Huacai Chen
 <chenhuacai@kernel.org>,  Michael Ellerman <mpe@ellerman.id.au>,  Anup
 Patel <anup@brainfault.org>,  Paul Walmsley <paul.walmsley@sifive.com>,
  Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou <aou@eecs.berkeley.edu>,
  Christian Borntraeger <borntraeger@linux.ibm.com>,  Janosch Frank
 <frankja@linux.ibm.com>,  Claudio Imbrenda <imbrenda@linux.ibm.com>,
  kvm@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  kvmarm@lists.linux.dev,  loongarch@lists.linux.dev,
  linux-mips@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
  kvm-riscv@lists.infradead.org,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org,  David Matlack <dmatlack@google.com>,
  David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v12 13/84] KVM: Annotate that all paths in hva_to_pfn()
 might sleep
In-Reply-To: <20240726235234.228822-14-seanjc@google.com> (Sean
	Christopherson's message of "Fri, 26 Jul 2024 16:51:22 -0700")
References: <20240726235234.228822-1-seanjc@google.com>
	<20240726235234.228822-14-seanjc@google.com>
Date: Thu, 08 Aug 2024 13:00:00 +0100
Message-ID: <87bk23ql6n.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sean Christopherson <seanjc@google.com> writes:

> Now that hva_to_pfn() no longer supports being called in atomic context,
> move the might_sleep() annotation from hva_to_pfn_slow() to
> hva_to_pfn().

The commentary for hva_to_pfn_fast disagrees.

  /*
   * The fast path to get the writable pfn which will be stored in @pfn,
   * true indicates success, otherwise false is returned.  It's also the
   * only part that runs if we can in atomic context.
   */
  static bool hva_to_pfn_fast(struct kvm_follow_pfn *kfp, kvm_pfn_t *pfn)

At which point did it loose the ability to run in the atomic context? I
couldn't work it out from the commits.

>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/kvm_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 84c73b4fc804..03af1a0090b1 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2807,8 +2807,6 @@ static int hva_to_pfn_slow(unsigned long addr, bool=
 *async, bool write_fault,
>  	struct page *page;
>  	int npages;
>=20=20
> -	might_sleep();
> -
>  	if (writable)
>  		*writable =3D write_fault;
>=20=20
> @@ -2947,6 +2945,8 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool inter=
ruptible, bool *async,
>  	kvm_pfn_t pfn;
>  	int npages, r;
>=20=20
> +	might_sleep();
> +
>  	if (hva_to_pfn_fast(addr, write_fault, writable, &pfn))
>  		return pfn;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

