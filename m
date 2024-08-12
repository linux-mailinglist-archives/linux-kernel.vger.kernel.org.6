Return-Path: <linux-kernel+bounces-283835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CA994F92D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB94A1C220D9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E161195808;
	Mon, 12 Aug 2024 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6sJK8QD"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA81537C8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723499640; cv=none; b=I7BAfDme5xyQyrAZsMwHtWt8jiAmW6saUJ5Kq+GQm/DPgmDUtQIQoZeqc92rBPVAC6aTP9fvwolfDkS3ujCxgT//1IMOyFXyOQBBdq8semJviV1kTV5vID6NH+X/Qk7/z9V9aguKVtyqbgPAgcmTaz7gcBL+1/t0yGWguWl23K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723499640; c=relaxed/simple;
	bh=iFb81utD+kxg5AVUC9OJqvlmXZarFcIDLBfi3Zt5x5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoBd/RzFB/R4BavwZNYZ2+v1cC1EkV9w4s4coETHuxR/cCEyPB2lL+8KurXgMoXt46w1pDCXgiDFfMJEXtS5nfkn1Xdt8+NWa2dkWAFRzeLaNtEatsrfHgeXxXo8TXr5hUvksbFTFjySqADXp01WY+6sVjWqvjDj1nJ/LPFAw2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6sJK8QD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368f92df172so2453507f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723499637; x=1724104437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imKlkkFUg+JvJB0nb5f6d/5Hvt3G5KlID+hC9c1+ZW0=;
        b=K6sJK8QDL4qjeVSaQ98zRvHUjHiN2oBZhzJS4pTe+STiY298GQXaiBErY9YcBxrxH3
         +9eJqlSeF6DdHM3wqeSXvdm95aufpCiklX4WeZs0wyuQx4ZnSnhi5kdaRTSDu05Cychg
         l38RL+tZioqSDsTjKBO2ADb4HvsMFmqXBC0CSgrJa3jlx5Tc5/ZhrZ+mY4e1R69EZmS5
         zhmP6ikv1lQWyq3dtD5kdtJwosRlkQDaNdZWZR1BpfrGMQ8g4dfB8SNjzKCACqMnsUhF
         rk6xz1lyjhvcm6uhJLadUOfYi8uKrh4497+JTY7YuvCD96FwpuZkmDjEcSMUdloPwvkm
         YT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723499637; x=1724104437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imKlkkFUg+JvJB0nb5f6d/5Hvt3G5KlID+hC9c1+ZW0=;
        b=hLE0DmkopJBuXf1C96SYEiL7CezUt1U0iV5bTAphkKbhA0lGPdop1is5zGJY0ytd3V
         BUZ5Le2b7y7i9sivrlLJiW+XPlEyzsE/Ny9NpjbqEggypZlGgkJkCniXtb9cn9/AwIVl
         rSOyFm7je4kRV450IGjOMmYTXDsS7hMbwxk+4cgG7lbAFhaJwUvVre5Hugv9BU5vip10
         Ilg06S/axKZf9r1zhTWmdr8+UemkmIrffkC8jKP2EPbuCHXLTI3atskv9lX/TCm63d3q
         7K4DiPkeEOIElxK++t+apyF+Cf9Xjd6zNGueGTAk9lKaiyjzyQeIm9T5QbJfOGpB0xeP
         Netg==
X-Forwarded-Encrypted: i=1; AJvYcCXiTcTU6dh8LaYRXxLlIzOoqs9zayhv++Sq22dp/MLWu4Sg3teImEz1T3X9x4VZqHQGgDPOrEQJ/gqGXnWhCLrayrla/u6+uORxgL85
X-Gm-Message-State: AOJu0YxYA1Acc2C3A64E4dbr3kW3gTTRRNb6UqAVRW0W/7W0HP4GHQ96
	NfbIXFHMmizJSGqiGqMdnunuhuVsQcbvrmlnJhbo7DlkrFf4a/VMzlAQJ0FC9OhNnpv1mPfLZ0s
	/MoQkEhzJsJqpUiChm7Q+KxjqhBG8/C0PMY1r
X-Google-Smtp-Source: AGHT+IEq9Z3A8c6NJnVvf2RQgYE7P88YKMQaUxK73bXmj83aH6DHf5GTXyarL8Mu9mgSiyFTWmwXtiXjB7rGW2BOKIM=
X-Received: by 2002:a05:6000:1842:b0:368:4bc0:9210 with SMTP id
 ffacd0b85a97d-3716ccf39e2mr1378800f8f.25.1723499637114; Mon, 12 Aug 2024
 14:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com> <20240809194335.1726916-15-seanjc@google.com>
In-Reply-To: <20240809194335.1726916-15-seanjc@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 12 Aug 2024 14:53:29 -0700
Message-ID: <CALzav=cYv4ZqD5q6-hP=WN8gYFxt7xYKCTm8dLaGtjk-kmCy=w@mail.gmail.com>
Subject: Re: [PATCH 14/22] KVM: x86/mmu: Morph kvm_handle_gfn_range() into an
 aging specific helper
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:48=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 0a33857d668a..88b656a1453d 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> +static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
> +                                  struct kvm_gfn_range *range, bool test=
_only)
> +{
> +       struct slot_rmap_walk_iterator iterator;
> +       struct rmap_iterator iter;
> +       bool young =3D false;
> +       u64 *sptep;
> +
> +       for_each_slot_rmap_range(range->slot, PG_LEVEL_4K, KVM_MAX_HUGEPA=
GE_LEVEL,
> +                                range->start, range->end - 1, &iterator)=
 {
> +               for_each_rmap_spte(iterator.rmap, &iter, sptep) {
> +                       if (test_only && is_accessed_spte(*sptep))
> +                               return true;
> +
> +                       young =3D mmu_spte_age(sptep);

It's jarring to see that mmu_spte_age() can get called in the
test_only case, even though I think the code is technically correct
(it will only be called if !is_accessed_spte() in which case
mmu_spte_age() will do nothing).

