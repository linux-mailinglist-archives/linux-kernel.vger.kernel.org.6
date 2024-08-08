Return-Path: <linux-kernel+bounces-279519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9B094BE63
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27FB28D4C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC84018E020;
	Thu,  8 Aug 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Vx6V86H"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016818DF7B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123010; cv=none; b=j++W1qTkvvorjHFUA52X+Sr9mN5ur6xwmORILDr+/2gC/CPElzEHy0SvdP6Br4L98EVqBlK5SbXt/e24X0QD8svG5/lHj6irrvl1pcy8tQyWtxawFopwBS5DZvdnlfThAJu0ibuqd9JCwSgdKdnwE0ypnHGd1hrqlwzIOoc5EEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123010; c=relaxed/simple;
	bh=SIRHTk+m4P1RNpcxL6rwR5xC8tZQja2BIbrMKp2HGV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XbhNpKlVvKyap+C9ThE7Uoorq0Dku4W6ubjVp1PumEyudO5sD6a/AGxRXpsW2sXOjmcPiwkcNh+YKKBpXxroYq0hO7qvsqq8Wlv7YsP9QPwck8q7Grb/0KItX7wCX0jqTJBFBtwvgvGKzoy24bw/fJ4MKibdlIMp6G1+9QplF1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Vx6V86H; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d34fa1726so1100428b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 06:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723123008; x=1723727808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ep+xfrS41+80V4sejFNz0q3mTB6TQE8jTTfF1Jh5lTI=;
        b=0Vx6V86H118QZzXcLuXx5cYVlvtaxqcOyrEg1LmwlwoYluILVqVhvw4NdH/wOqy9U+
         H5h7eNi89+utF3KtdQa4FTY3sbEnU/T6+qf1gJS4TBXAw7DKi0pfiFGEMIzcFGFPH5TB
         VCZYiJHltvK5E3aBWqhUqBbAmg/3tUkSwqiPN8MGnh4zIMNE4au8CRz6Yb5Tfb9Qt9Ks
         zLLx9xL8arVUeRVArC8q2H1CmGM67bZorbKF9rk1vISHe30dby37R9w7fYgVN08m5lS8
         4ER8KzaWJIwKYgNSWl33nMf6q2En04mPh0ihepoA3Jif2xIofNF8YrG9ceG9gQWcmjJ2
         0xOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723123008; x=1723727808;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ep+xfrS41+80V4sejFNz0q3mTB6TQE8jTTfF1Jh5lTI=;
        b=XGWkrX2JCCIjxHEfgCtfiwSXy7E3MuXka6TSJeFfRdOo+5+qqFnW40Mu4IQjYkteV9
         JXPUTFcl0Pmky9a63maIeasb93sbdvQKXAA3whI7A6kkw8zuzejv+s1z0CnuXFFYHpMB
         Q+gxv1yOzD9uInhkXXPhNMtnvMEKtewjEhyn2YQ9aMUVcCPeagGeP8E6cw+q/8BBY+ZF
         vviCHjW/QPJsxr6MI5y/Jeqr0AKz69T26VQzRLWGhMnqEFLOM5Tpg3nkjjzQAaQGSaDA
         K6gJksfLdzzZP7VkoWN00TcQAm4/C9E58ZppHLkkCwT55VooOcuyAYpefpxgKAMniAo8
         qQAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKaDiF2mGvjDN/rP5C/0QZmToK4Rp2hcOdc22sc/PvqmAogqbVdMDmuHuawEIR1Qqcee1kkgvQiXKcjuPpbQFuHuxqBZgW93pVsFfh
X-Gm-Message-State: AOJu0YwctlSEyEZayWtoHUHwWQ9aPX/ElIdlUJuGNxkApDD77+dJw7j0
	LvMspQzS/fOW0+LucGZfL2hs0Jnq5jrbuRaKpccL1VVIWGx2JZ6T4zfJCNGZuRMBHI9feIXiEdo
	DiQ==
X-Google-Smtp-Source: AGHT+IHJBsGw5UgR/iugxzmSr+QeSrp5dZN/v/XODES4sTP0wn0G9d+/VHKS2R50We/GZxKaCQexvWJSP70=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d8c:b0:70d:2a24:245d with SMTP id
 d2e1a72fcca58-710cae763e9mr108614b3a.3.1723123007877; Thu, 08 Aug 2024
 06:16:47 -0700 (PDT)
Date: Thu, 8 Aug 2024 06:16:46 -0700
In-Reply-To: <87bk23ql6n.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com> <20240726235234.228822-14-seanjc@google.com>
 <87bk23ql6n.fsf@draig.linaro.org>
Message-ID: <ZrTFPhy0e1fFb9vA@google.com>
Subject: Re: [PATCH v12 13/84] KVM: Annotate that all paths in hva_to_pfn()
 might sleep
From: Sean Christopherson <seanjc@google.com>
To: "Alex =?utf-8?Q?Benn=C3=A9e?=" <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024, Alex Benn=C3=A9e wrote:
> Sean Christopherson <seanjc@google.com> writes:
>=20
> > Now that hva_to_pfn() no longer supports being called in atomic context=
,
> > move the might_sleep() annotation from hva_to_pfn_slow() to
> > hva_to_pfn().
>=20
> The commentary for hva_to_pfn_fast disagrees.
>=20
>   /*
>    * The fast path to get the writable pfn which will be stored in @pfn,
>    * true indicates success, otherwise false is returned.  It's also the
>    * only part that runs if we can in atomic context.
>    */
>   static bool hva_to_pfn_fast(struct kvm_follow_pfn *kfp, kvm_pfn_t *pfn)
>=20
> At which point did it loose the ability to run in the atomic context? I
> couldn't work it out from the commits.

It didn't lose the ability per se (calling hva_to_pfn_fast() in atomic cont=
ext
would still be functionally ok), rather the previous patch

  KVM: Drop @atomic param from gfn=3D>pfn and hva=3D>pfn APIs

removed support for doing so in order to simplify hva_to_pfn() as a whole.

