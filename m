Return-Path: <linux-kernel+bounces-339179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A6998611D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8241F26CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F37C18891F;
	Wed, 25 Sep 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZXhBq6C"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF8188900
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272487; cv=none; b=QTbh+KJBOBfEiE3z0IthlOIivOosccPK+sQ+aD09kwWBWoFgyV+enA/ARGEiCOFBbGfvrwOpAAV7d3ANQzAajsG7tAJf3O4w+i0U3WN/Zy+krvu7rBe1PUVKXKx8hPJedAPsCCbqGc2Z8Z2QsGAiHrLMS7bGZJeCUz31CVdbzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272487; c=relaxed/simple;
	bh=auo8uEeKyWNAzNHUp26PfITSjFYNhRSuij1t+uvKJ+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bz0pdQv3OtKP2I514Rxu/dQSvaXXCjAIhNZswqumr0F1FWYe/tWpRpvf4CxTMIsKav5Tcii+GNHwhvQV9OA/E9Ob+pgXeJ/aav9hSYwonyoURD522ct28/RzpL3/q3fQNzeW4KhN9u2Dy2s7PaiMIU3hB+eX3+bjh3vVAJS1www=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZXhBq6C; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e20b046922so39835147b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727272484; x=1727877284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lk7odMaYNjZ3G3yZ3a1OOv4D2tbEjCMBdR1l/GbHUKE=;
        b=wZXhBq6ChZ40/3s6Le8FR0ru0peSTpOHuaUK6zSdLGQClMIOaL23w7adC3dWuu6jae
         mm1QNfV8jBeptzuFlrJZH1FBKSRlXA25Agfa7a5a/hE3b4magq4mBU6O7zlT71qq5T1q
         zTHfbTJE3Rb0Q1kOB3m1fbdqtKhcd1T/0AUBiyKmPRiFmDkvJjCcgu+ZGhCckKfLgIwL
         J7H0TRPampAnZbMsSDh4Ac7msPuqJZhGbos7fOB43JMXkeA1kF5462wvUY4Gn//wtKm6
         FDgGCg6LyvS6HDVaLRLcP/00c5vJR7v0EbQBbaQyVgN0COgovryU4Dcxn/k6yQlxIukh
         KanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727272484; x=1727877284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lk7odMaYNjZ3G3yZ3a1OOv4D2tbEjCMBdR1l/GbHUKE=;
        b=KLcAtl6yTmO5pDAuieU+rHmelWAn3M0IAhJefUUvZbAsYp/yFW4VlgfvxVICMRP4ZA
         bQQc8yy8iZfRlS26T7CXTb8bLOVoKLD9CkV3EUp52CdJI96MHQfcN/KtlY9dO+f70gVg
         b2UKXucL5iQzveLpKQN2NdyRY/taXVGNU4MpN2DKdpVm63GAmhpGokbs7xZr6bqX5Bgd
         upZB0E3bnu+FI00E6ncIx9eI6Uk1bcVX5wg+FfitLgZjnWcYGC4UkKV2/Ca2rBO0aQlB
         wvIB4skgAedg9TsUehuenFmQbNJLUQzlVexx4jD/xalY0BSwA6GOefVkThTLOERrgS5B
         jqAg==
X-Forwarded-Encrypted: i=1; AJvYcCXfoyDUSyEVEUkohmtEulojP4nOomiMsZDDLoQIJoVQF8OFO7UcgZkJSJQqQmjA+QUdJ4BQ/v9dhAUiBRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb83bdDMcIFU5/8M2BMWTSA98Drbad+DkkpPOq36BFK3ZgQgPU
	LTzPriYlz5w4QxUmeV2bwEMgaOsc1C8IoU8dpqUzGhNS14kLlWVhz1Wp6e/+TzsFRhzSTFmeEGv
	qng==
X-Google-Smtp-Source: AGHT+IGNnn1aj0UHP4wBrW71FUTe7T79UNAeqYjqD4o0lNABDe6DdiB/r+Nvqs6lAjXf1a9NIwYM5CX11Cs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:5086:b0:6dd:bc07:2850 with SMTP id
 00721157ae682-6e21d9fc145mr46697b3.6.1727272483918; Wed, 25 Sep 2024 06:54:43
 -0700 (PDT)
Date: Wed, 25 Sep 2024 06:54:42 -0700
In-Reply-To: <20240820043543.837914-1-suleiman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240820043543.837914-1-suleiman@google.com>
Message-ID: <ZvQWIsRlrmHsB3DB@google.com>
Subject: Re: [PATCH v2 0/3] KVM: x86: Include host suspended time in steal time.
From: Sean Christopherson <seanjc@google.com>
To: Suleiman Souhlal <suleiman@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ssouhlal@freebsd.org, 
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="us-ascii"

+David W for his input.

On Tue, Aug 20, 2024, Suleiman Souhlal wrote:
> This series makes it so that the time that the host is suspended is
> included in guests' steal time.
> 
> When the host resumes from a suspend, the guest thinks any task
> that was running during the suspend ran for a long time, even though
> the effective run time was much shorter, which can end up having
> negative effects with scheduling. This can be particularly noticeable
> if the guest task was RT, as it can end up getting throttled for a
> long time.
> 
> To mitigate this issue, we include the time that the host was
> suspended in steal time, which lets the guest can subtract the
> duration from the tasks' runtime.
> 
> (v1 was at https://lore.kernel.org/kvm/20240710074410.770409-1-suleiman@google.com/)
> 
> v1 -> v2:
> - Accumulate suspend time at machine-independent kvm layer and track per-VCPU
>   instead of per-VM.
> - Document changes.
> 
> Suleiman Souhlal (3):
>   KVM: Introduce kvm_total_suspend_ns().
>   KVM: x86: Include host suspended time in steal time.
>   KVM: x86: Document host suspend being included in steal time.
> 
>  Documentation/virt/kvm/x86/msr.rst |  6 ++++--
>  arch/x86/include/asm/kvm_host.h    |  1 +
>  arch/x86/kvm/x86.c                 | 11 ++++++++++-
>  include/linux/kvm_host.h           |  2 ++
>  virt/kvm/kvm_main.c                | 13 +++++++++++++
>  5 files changed, 30 insertions(+), 3 deletions(-)
> 
> -- 
> 2.46.0.184.g6999bdac58-goog
> 

