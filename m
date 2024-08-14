Return-Path: <linux-kernel+bounces-287178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50205952453
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842C41C21977
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0DB1C7B85;
	Wed, 14 Aug 2024 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2Y/TxA6"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341811B1505
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668933; cv=none; b=mth7VI3Lxth+znEXVAezhjZZI/jtZhMG/VzAzuNFWxQ9Spg3bqCiP15q2JwdQdC719kv6gg1YCSMf6w9v98CnbVA+u0beBVy0YS7lu17Mta85l70/GzTbCaDp/hBYQuP6bdWftmOSQeRqbX6o9UkoQwGMhfeQIuxvvZjpf//jYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668933; c=relaxed/simple;
	bh=MKookjIC7ErVzxhCR+2X6dR6dpWIA1qx77AP/HEFQAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h/y0WnHO1j4IsJxsjcU7cCUJMCfqBAfjQydrLdovVTaYQ9Yez9kNahOx0qufYdCe9GgySjiysVc9ChxJljw39q9jVxv9wre2NddyU9yVqTVwjagTb3z+TqyMPhmoelXmVLBecZ5mfhu6P8UzM6V9Nb51ZcBuN3Qd6boCgE44rqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2Y/TxA6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71050384c9aso212005b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723668931; x=1724273731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6gSEyP0JBX/LKrmKCZstJhKB3NuQApPBew6eB4HEaPY=;
        b=L2Y/TxA6VIATQx+YD0lq1Ty1UERD6ufN3Xmd/1yRPMKhDPnQfd1H3G+yFqHeCm1Vld
         NPJ3BRz95PS21z8S/IAtiJOccudDunKBiQB7W2lRHbvzAFl8wLeMjqGIa4z2Cyytp+3Y
         r3XewuxwNxv6S0lmuCKSntqaAjPuYyYxltazwJyAmrDdtDRvTCAVUHeW9kqSFlBw1wZu
         RpUJYLY3SzoxutNHPzEzewYKwpnaEhlJ2EHlQLmffcM6jDs5n3vgTF0hBRo2z7pw7xpB
         YlcG4ykL77J7zxsj8bHKUiVrbC3JEwBdFnsLMTqjy3GWyW8wJ0jaJKM3sof9327lWF3K
         eF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723668931; x=1724273731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gSEyP0JBX/LKrmKCZstJhKB3NuQApPBew6eB4HEaPY=;
        b=AJK/jhNVrzwgA4w6cpyqlPHu8OuhoJkGkarw3kG9fa7MSeKskikAkwK3OpwjmD2T0l
         u0IFL7RiPByj3hViF7OMBV25PCy6XTdWkEFe+P5xJt+ojiV8+lDgAnNmwDMuoy1zmuyh
         7rYMdpw6kPjItuhRVHw3hIZsmJjemEWNvGROQU/R0h4AnRcsaVcQ8gU2YDdlILFsS4Ug
         EiCTLu8rfVLxW/yQw6GNGKVZgYHFyYCAztV7E2gfcnkz/U4/iWOb6cDfo//vPfuCANk2
         d8h2md5iSTgwW7HJqa03AVQLVoRO4cgw1yayE7ew4mGyVodDrrC30Y7O74kQYA9Tqxus
         +9Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWvfP2w/ppzuF5DTTWjYgtqLGQh3BuzZ3E4cJy6/911QDyW2taOAn3iinBX55j38eUPBOYb2KjaTPd1mYUVLr+cYwqbR5YrOgTg/Ytb
X-Gm-Message-State: AOJu0YwMcVfDksCVR0RTbSMAcbR6WsOJ0ByPJezoAtZfM39dU702Ndsb
	xjk0OMdTwbzKpwLxWrWtkcwZeMDrtlknM/DnoGG7lOuyPeSUR9NphR/yA9BG02gyesIMoScOm6x
	dYA==
X-Google-Smtp-Source: AGHT+IEqFuKACosSCrZ0xhAm3jch7GTVdBLETVOQ6stfpsrJCuiDxnbUTd+onFhjn8Z88sgu2LatVGpv3QM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:91cb:b0:710:4e4c:a4ad with SMTP id
 d2e1a72fcca58-71276c8a229mr9434b3a.0.1723668931235; Wed, 14 Aug 2024 13:55:31
 -0700 (PDT)
Date: Wed, 14 Aug 2024 13:55:29 -0700
In-Reply-To: <76605c6e-37f8-4abc-ade3-3ba381d6c9c4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240608000639.3295768-1-seanjc@google.com> <20240608000639.3295768-3-seanjc@google.com>
 <76605c6e-37f8-4abc-ade3-3ba381d6c9c4@redhat.com>
Message-ID: <Zr0ZwZsSEqSH5mQN@google.com>
Subject: Re: [PATCH v3 2/8] KVM: Register cpuhp and syscore callbacks when
 enabling hardware
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 14, 2024, Paolo Bonzini wrote:
> On 6/8/24 02:06, Sean Christopherson wrote:
> > Register KVM's cpuhp and syscore callback when enabling virtualization
> > in hardware instead of registering the callbacks during initialization,
> > and let the CPU up/down framework invoke the inner enable/disable
> > functions.  Registering the callbacks during initialization makes things
> > more complex than they need to be, as KVM needs to be very careful about
> > handling races between enabling CPUs being onlined/offlined and hardware
> > being enabled/disabled.
> > 
> > Intel TDX support will require KVM to enable virtualization during KVM
> > initialization, i.e. will add another wrinkle to things, at which point
> > sorting out the potential races with kvm_usage_count would become even
> > more complex.
> > 
> > Note, using the cpuhp framework has a subtle behavioral change: enabling
> > will be done serially across all CPUs, whereas KVM currently sends an IPI
> > to all CPUs in parallel.  While serializing virtualization enabling could
> > create undesirable latency, the issue is limited to creation of KVM's
> > first VM,
> 
> Isn't that "limited to when kvm_usage_count goes from 0 to 1", so every time
> a VM is started if you never run two?

Yes, "first" isn't the correct word/phrase.

