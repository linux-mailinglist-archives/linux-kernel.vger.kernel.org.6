Return-Path: <linux-kernel+bounces-277933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098C394A861
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B664B26498
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09A81E7A35;
	Wed,  7 Aug 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdGBNWUC"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B56155C83
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036206; cv=none; b=j1llrLgUKldaB8J5YtZNq+H4cJUUX4dMy4gcoA99bqRlxKq9lVGVgv1Lk2AMSy8AO+1aplI1OX5eQRWQOJAxprqBM5yCNlrdQk7p5cjTW2EW0ka07I8KiquXn8KYXnm6zFNz622L6T6X1Wi6c/CNNrbEs7pxtoRHHg40QFfjnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036206; c=relaxed/simple;
	bh=+eZhBjSmjCvbGRPfzlj09DpLXMmDSZBMnkw9b2jdTR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u/IBeqDJdY68W9IbLlsJfxIBjghRHctRT/Zkxh4k+AQcqNrvJW3ZXMr3EKD1pMQ6dtIMmxu5ddpoTSJW6AcTCRajwW3TV7HHlifNFf0E6zYKH+mabB5wV+nHlqy0vQnoQ8Yl2LcEo86WojkLnFFjpY/8T09Cywfg2xVvimng+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdGBNWUC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a28f78c67aso2016370a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723036204; x=1723641004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeNfd38uETkIH61CYDkuc4TtszXpvrSFcKS3wi21Vds=;
        b=UdGBNWUCMP8F0seUlwGHMvrHWgf0i9Bmc+epuYM0KqtfzWEh+jxga1ea+Snt2UJOdP
         0E+gh81QB9FlGWAf3QDHgTxbneEiGbQfjoDmRttzavF3LblX2dauSeo1jyb4gZHVAPve
         q9tZxaqy6Z5iuXJPwaWZUu8oe8bdDg2G2pfAtZCgxEpJTRKTwPSMjh7sn8bXAgJdmLwc
         IoyOcuQJwh6Zhyt7h9lGyDSVeTUmOoYJVseZWV7ur3UqVaO5oia+aewUxcM3ossXAaQB
         JErG+gwsVof4Y7DZcDbxIHhUsUmQm8efFCydZH5ADBKbCFuaD3QfBFpAsJZ79PWkkttu
         AIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723036204; x=1723641004;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FeNfd38uETkIH61CYDkuc4TtszXpvrSFcKS3wi21Vds=;
        b=UlwtO+bd6iSW0ebTVxj5k99QnqB0WkAuxq1PuJBAgp/UzaqQaFvz509MUV3UCosmv6
         4vgC7gFUJwOJsBS9CpNfdlHHVrqvK5RWLfqG7mzm/SkZ01cPuAzIfKH0a+u7v80SLxvm
         et2uXda1z1+Jjzn+5t6nW+AmXWHKyAOm75Bk0DbcR59MW+OpAyu3T9rZF4JhpIVRbf9K
         4MMeekC/+oSDUHBfFRGHmBf2qRjaVMhG/3Py0bZXQFGAwH94RxnHy50ftiuq6FxhjsH/
         1P0eA3NX/MwABA/7bxycOasNSbctX+GH+mdwy9VR6568+1k3Y+sKyuZNOf/dEw8nQXt7
         MSAw==
X-Forwarded-Encrypted: i=1; AJvYcCV5hL363pRulRu4J3sYj1HpEyB3jTZ7cwswclQy6rX6gvWeV1r/M6NaKec2PPU5kaMN+ZAu2UQdMQSM5KrssDIyB5H0xJvf5zekZoKC
X-Gm-Message-State: AOJu0Yy4HpuVyxExThO3DkAvuj2MEhwaMd3T8Z5zLtP+dJQhjbwlMmjf
	71XwMt2hax/rfRf06QVfk/MDVqeRtgk4wGJPh5T39YjbLcGLVjVrKRLFnLsXsDFvb62m5GQSTfr
	acA==
X-Google-Smtp-Source: AGHT+IGpZQvns4Yv1Ia7UPGh54uJfN/xbxbZf9g7hwoRt6m+NYgzW4Xj758L8HuOWnwP714lqGXrlndPbvM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:f07:b0:7bd:91f4:e07c with SMTP id
 41be03b00d2f7-7bd920429c2mr6356a12.0.1723036203694; Wed, 07 Aug 2024 06:10:03
 -0700 (PDT)
Date: Wed, 7 Aug 2024 06:10:02 -0700
In-Reply-To: <CABgObfZQsCVYO5v47p=X0CoHQCYnAfgpyYR=3PTwv7BWhdm5vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806053701.138337-1-eiichi.tsukata@nutanix.com>
 <ZrJJPwX-1YjichNB@google.com> <CABgObfZQsCVYO5v47p=X0CoHQCYnAfgpyYR=3PTwv7BWhdm5vw@mail.gmail.com>
Message-ID: <ZrNyKqjSiAhJGwIW@google.com>
Subject: Re: [RFC PATCH] KVM: x86: hyper-v: Inhibit APICv with VP Assist on SPR/EMR
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eiichi Tsukata <eiichi.tsukata@nutanix.com>, chao.gao@intel.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, vkuznets@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jon@nutanix.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024, Paolo Bonzini wrote:
> On Tue, Aug 6, 2024 at 6:03=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > > As is noted in [1], this issue is considered to be a microcode issue
> > > specific to SPR/EMR.
> >
> > I don't think we can claim that without a more explicit statement from =
Intel.
> > And I would really like Intel to clarify exactly what is going on, so t=
hat (a)
> > it can be properly documented and (b) we can implement a precise, targe=
ted
> > workaround in KVM.
>=20
> It is not even clear to me why this patch has any effect at all,
> because PV EOI and APICv don't work together anyway: PV EOI requires
> apic->highest_isr_cache =3D=3D -1 (see apic_sync_pv_eoi_to_guest()) but
> the cache is only set without APICv (see apic_set_isr()).  Therefore,
> PV EOI should be basically a no-op with APICv in use.

Per Chao, this is a ucode bug though.  Speculating wildly, I wonder if Inte=
l added
acceleration and/or redirection of HV_X64_MSR_EOI when APICv is enabled, e.=
g. to
speed up existing VMs, and something went sideways.

