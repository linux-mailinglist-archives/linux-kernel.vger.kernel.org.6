Return-Path: <linux-kernel+bounces-302926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA79960519
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790621F215E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B955E176FD3;
	Tue, 27 Aug 2024 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0+YL/b/"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F5198E92
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749580; cv=none; b=VnlacsogZ28D9zA/VInFMZY54zKMUenF96T/cp9cJR1HcNmnGiyLJiDJsceQzvg36g/1tVnORlYd102+qLrgndLzy7RD0qnWniTQoX65v6P73J9kr+ZM7xOQrB1KoMbYQv6tqxCEhzbb5Stmf4hxfWGazHs5mfZY0/FrBpeqJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749580; c=relaxed/simple;
	bh=td6TsY+x1jF2bYWtgW1QVma5ZvKvJwuhzTvVDhTcxRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dNvrn/T7PnRGiNjMz3FFUdQUQW5K459vy2vGdHZaHxylVd+A6HAiyNna/CJtpUQWTGt6VZoLI34qPBsKGgnPjaAWWrM9cf8+GtgeksXzP7N6z7RiOBlhPrsaVBQhEPV3ucjj3uWU6yWmS5a6SMJkBHkIA7tnQ+VyueWwOHPtA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q0+YL/b/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso57954725e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724749576; x=1725354376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ys5q7+xt7V4u8ZvUMbFPxHX+g0yKhziPVMVNXUTaajE=;
        b=Q0+YL/b/rl5j1EuCKgYUI8/1tv7hP3ynaUFvOc6LAh2q5WZWdaUTrVCnPuqVCMYMq+
         S29T2gYKSix5SIxrO6CryQW41Ci0QM6WVoGegsHxJVF0ABvKxkNvmdUHdQriV5Hspnau
         24wrg+mqJt6J4ClbsIRvrt+h+Eh/bUdAWJWp13Ybp/CCsAcQPxOb53Qczsr4Qy8LqFoE
         ZJsrfekr1cC6qSLWHDCuIAPy/cPmNmmux9yYVjqQyYsc3BV8SzdQVJQx93xnyv16c33q
         S0KjBE4oScqKwwqaKgq8E4nBtMWdZEsx43skUVvqHD7vCmUsGe87ab3S2h7EHFRn8XJL
         /Uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724749576; x=1725354376;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys5q7+xt7V4u8ZvUMbFPxHX+g0yKhziPVMVNXUTaajE=;
        b=LR8rJvlJJmUQSTRRKsm9Duu6ibIJVq2W6xYH2irLbRPCQdyUkpadr0coT0YO4fAhSb
         jqHw+e51w/XzZydKi1moDkU9377dJgO82d1d/STlKg6sYLNeIECCl9pBpnp7EP5IZ6Yn
         nDs3BnRPRz8uYEPMqlcq1lnNuHjaOrqGvYdLHxY6iZCg5txLqIe7GjW3c4azenXSLHDX
         f8GyJjdGN/ABbhqX07h9QXmXqvFTmUxwXOeMk1LFWgvG8VAzLK4T8yuKWZk2ofXysmX5
         +i3MnCYjBwElcW92apLma90oUOzvKtfRlEx0mxqqNf9DitHZYtRP2vFt8lZd/TXvGj80
         u9QA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/Y54mfUikBBJretUsPGQfnAZWvJNmG0D/FiwmEZdrYKo7biLIRY2DPqOQV6pnznmhte6fNrOUeLl4M8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx96fHIkGv9IKIInzmMrsN2K1YGsTJVlkmic3TzlHSTgD2A8svb
	ERyhR7zSe+6YeFPf1WlA3i+XYUxuZkh552BkNm0OKN5X3ujTr7IFg1mFnCmzIuY=
X-Google-Smtp-Source: AGHT+IE+VDn5FOe01bWlunlr3Q/efu0PB9LC4RFl5VPjT0A0kz6PEXEkfZYstnAt53OJLkCDA/f1HA==
X-Received: by 2002:adf:b311:0:b0:368:3f6a:1dea with SMTP id ffacd0b85a97d-37311840050mr9300691f8f.6.1724749575912;
        Tue, 27 Aug 2024 02:06:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730826a3f7sm12533503f8f.112.2024.08.27.02.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:06:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 507E15F7A2;
	Tue, 27 Aug 2024 10:06:14 +0100 (BST)
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
Subject: Re: [PATCH v12 00/84] KVM: Stop grabbing references to PFNMAP'd pages
In-Reply-To: <20240726235234.228822-1-seanjc@google.com> (Sean
	Christopherson's message of "Fri, 26 Jul 2024 16:51:09 -0700")
References: <20240726235234.228822-1-seanjc@google.com>
Date: Tue, 27 Aug 2024 10:06:14 +0100
Message-ID: <875xrme3nd.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sean Christopherson <seanjc@google.com> writes:

> arm64 folks, the first two patches are bug fixes, but I have very low
> confidence that they are correct and/or desirable.  If they are more or
> less correct, I can post them separately if that'd make life easier.  I
> included them here to avoid conflicts, and because I'm pretty sure how
> KVM deals with MTE tags vs. dirty logging will impact what APIs KVM needs
> to provide to arch code.
>
> On to the series...  The TL;DR is that I would like to get input on two
> things:
>
>  1. Marking folios dirty/accessed only on the intial stage-2 page fault
>  2. The new APIs for faulting, prefetching, and doing "lookups" on
>  pfns

I've finally managed to get virtio-vulkan working on my Arm64 devbox
with an AMD graphics card plugged into the PCI. I'm confident that the
graphics path is using the discrete card memory (as it has been mapped
as device memory with alignment handlers to deal with the broken Altra
PCI). However aside from running graphics workloads in KVM guests is
their anything else I can check to see things are behaving as expected?

The predecessor series did break launching some KVM guests on my x86
system but with this series launching guests works fine and I haven't
noticed any weirdness.

So for those caveats you can certainly have a:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

However if there is anything else I can do to further stress test this
code do let me know.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

