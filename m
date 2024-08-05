Return-Path: <linux-kernel+bounces-275017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49591947F95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95511F21A46
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3301E15CD4E;
	Mon,  5 Aug 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGDDg/2c"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5094CE13
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876620; cv=none; b=e60AodF/4u8QecUDLImCEmEGjnAXaZBu9t3MYSAaTN0liPFbmP66n/20hZ70J+FpvpNlfynOYT1DXGMMFa4LO+mSPuS5A+9ft03WGIg2CWgKlxA6HTAovY0BECc++DMeCJ2bKaSkzAHzFNnNV7GBRrwWKyIPAwwOvaXPfcwc0o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876620; c=relaxed/simple;
	bh=sFpvW6EGiOzy6Y6ACTj0q4O8UueMOn4UVvTXWOLB/hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ca8CggC2mhnUEGLjVTo+42Iw55PNyT6FqcRV66Um3bGBPw6RhAHc/TSTqQvCuGds8YAe/EqXB/Z+DnIzLXOwKeXc/ou6uqjumUUD3Oi43we/vLr6FT8uuikwgmorzWpHu5JqZHGhQBGMFoPVBANhIHDBGi4//P9G+iBTBR6lb1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGDDg/2c; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4280c55e488so34506845e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722876617; x=1723481417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlYHWIkzEdl16o8qSuGjYNjZJX/eTDu80bYLE0n3ANA=;
        b=cGDDg/2c0loAnbs2siM6I5bT+iq9ZzVp3v2mhyVkvfJAmmVdrLswggXHIxcQC8K5Io
         IiFt4cvlCJ5sKfYnQ3cZIPymKFXJCkfk8pDOhfRBVrW6vPfNKKmQMgHhjD++TllvG7QM
         Q33bmzNdTb98oPyISmrpFAmTY448T/Fa2MvSdOWE7BnfGsJs0PxoqSHGJG7xvXIyEbHJ
         L/7ZWv2SkAXQtsK5yWm1rtYe8mEgD3QKUdWrrmpkbuXlPhiTQtLsarWqedy+61nimOyK
         sHPHt8tHUjP8UruU2iu+J8nzH8VHml6lEDejpc7rznThMDbdXBoxRcaF0jffTNxlINPj
         ZJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876617; x=1723481417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlYHWIkzEdl16o8qSuGjYNjZJX/eTDu80bYLE0n3ANA=;
        b=Qltoy7rPZAxSP8FeET0MrDSpK2hGVp6dAcojPQFmtx+fAPbn6/HNXFAEz485djYXX4
         WTiQYBeufOgaQn/l+RjHmJsnmdAE2r8+Ula2ljdEm0QCyfbfwg/vw2jRWtyQbhCtEhQ/
         AIPHWo+yHVoxTpgXZnUZwh0v4qOoEX1w37KjPOIYes2ZvtMJHSI7TYRhmSFamS5HuN7L
         yVSk2H1PlVuro8fhd/kgmqNZI2v70o04YBP1M36qqfe9yEOPdM/7eB9sVNR3ucfwPPfl
         LDN3gLc3www+N6GeXPGQodbXwXFHdAYqL530d+2E2uYZCQbzMjDEz2c2rqq6FghPNHtK
         KNwg==
X-Forwarded-Encrypted: i=1; AJvYcCWfra2W+6yVS+u1Y88ZFkJGVgyStXzHpV4GedCQHFBSLR1JobIzQqgnF79UOlRHmgVd2ombz32WZPI4aY8+313F6kc+po9syqYR31uQ
X-Gm-Message-State: AOJu0YxJNaQ/GPTBdm5/z3rQFQ577aDEC8j/XPug/Mf83+5lFlVyCkME
	oIxQVOR7UPmLwBJuahU0cEew+v924hy7z4uDFw8K2pJ0FPDB4S2UeHMS6wYU/f7i6TzD/H0yszO
	L298VJE1SLK2BqrWMaiTAo6wKahjYBVa11K4L
X-Google-Smtp-Source: AGHT+IHB5X8RMkMuR6nTC5GH+4Sad90UxbHWWxo4J10jCiuYpyYejoudOm5/A5D8Dga81IvgZD4iL2n8LOdbFlZXPbk=
X-Received: by 2002:a05:600c:1c9c:b0:428:9c0:2ad with SMTP id
 5b1f17b1804b1-428e47a4e36mr94354085e9.18.1722876617038; Mon, 05 Aug 2024
 09:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801183453.57199-1-seanjc@google.com> <20240801183453.57199-5-seanjc@google.com>
In-Reply-To: <20240801183453.57199-5-seanjc@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 5 Aug 2024 09:49:51 -0700
Message-ID: <CALzav=cOnS0k5RRRs4wn4jCwFKNBHuPSj+mJjbp=n-E0uvU=Cg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] KVM: x86/mmu: Use Accessed bit even when
 _hardware_ A/D bits are disabled
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 11:36=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c
> @@ -181,7 +181,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_=
page *sp,
>
>         spte |=3D shadow_present_mask;
>         if (!prefetch)
> -               spte |=3D spte_shadow_accessed_mask(spte);
> +               spte |=3D shadow_accessed_mask;
>
>         /*
>          * For simplicity, enforce the NX huge page mitigation even if no=
t
> @@ -258,7 +258,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_=
page *sp,
>         }
>
>         if (pte_access & ACC_WRITE_MASK)
> -               spte |=3D spte_shadow_dirty_mask(spte);
> +               spte |=3D shadow_accessed_mask;

spte |=3D shadow_dirty_mask;

