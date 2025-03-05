Return-Path: <linux-kernel+bounces-545895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037EFA4F338
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CD116ED8D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC23F1519B8;
	Wed,  5 Mar 2025 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTBHuufH"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034FF13D26B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 01:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136748; cv=none; b=mY7dMTaHddMcgGlxA51q7GnjEjr7+K/sW/YQNeorDln4SQBF/0kyWSMX3YklciYvKjLN/DjCONfSw3huDsRZNfFGAoj+yW6ZRfwGxVihlt7dabWrLqMxtrWfQgXYFZY7dSKcUu2rFOVzf2EzWfZ/9udnS1c9mPpo8F5d2VGERAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136748; c=relaxed/simple;
	bh=+MuQymkPvSHXZsgm1lXYQi7Jvrv7xbuEriYb3Z+IedU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DIDkA1oZa/+WAr4D4560edLbmR5NYc0MbqnN30zIQe6fKozMX3zCMp5t2GJ8g0LeFS7WAvt0LYhwswoDmAim35NHB5dugewIETyXTHYqi5z65oMS556gGa3UMbKMehBfNMZIdj5NJ1LYQD6wyHLHIGQVLkUHeToYy9LqtfQCpMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTBHuufH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe8de1297eso670200a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 17:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741136746; x=1741741546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NNX6vH12pYMK3VyoT3q3MRD9hVixADS4zVQV9SN8avY=;
        b=vTBHuufHoDkxBi+/JeiCfMhqKI75H46nIcGPMxi+Ku1QURbUPerdG4DoT/1cv+ZY4L
         /oyTOgWmfqBRk8S0ydjbBTBymhWvB3yFsKkNPNoBz4v9/CRJK9q1J2DJ2uAd5EN+m/pp
         NpQC9pJdkriCZMhQftU6WCzpmfw8qiyJ256m6MSfpjPHHFUvSCNCB+nnFeaHDN03hWGo
         ioIfeiunLXCunkFl1g2wb1o1DTSiTRz/SzA75xFj4PdqXtk0aSCqpsXDyeneK0T+iNjv
         /dILGDQjPl+H5p7fTQvpSX183rF/LoUGcK0iFnhOSqDcfA52XhLmgg+Tk/kFb/ZQgekz
         kA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741136746; x=1741741546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNX6vH12pYMK3VyoT3q3MRD9hVixADS4zVQV9SN8avY=;
        b=BHtPgy1OpAUaG6oYwa65Pt+wJJdK+ZZm8fAeY5BPYA0REGwrnqtQJZeaLhllER1oi/
         qB3lv1ont/2vhjUX1GUzVwIYgcdRc/TJ3sfjEr96RB18morNahhenximTBFvyf93K0nf
         nmxQSP3uPXaISqYNr09jWXzW8zPpvuVIsmV45ngvBxACd6nNwUFOQ/4Eqm/pfvrZHMe3
         bObgh8Fm8SsAiTwiOiSSuyWIVzHAnKYKLCMc3wiY94CLM6pHy1oQjKLMo+TWRETxAGZQ
         GRWnSkeyG8BXih8T6jY7Cm0LVRPUS7M14b7Us46YCQLBTyBs0hhk+AS42MNA/4f4r9Sg
         RxWA==
X-Forwarded-Encrypted: i=1; AJvYcCWgtsRPAOfESMa3U3G1wSFMNpVWE09opJdX7BkYqg9zc90Jo636enhderjHA2COhu4CdRf1fNs/n4slTVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUXURRhIbYnRNriIAB7pkGj0MLt9G8mPNCJLpCHdpUGJA+sNUp
	rWEHTlTu/zqo52cocqyMz22k5m4nE6OA18BJS799t3I9qOJYdH4/6LzgnFJUGrqGBfd3ouxEBDl
	4Dw==
X-Google-Smtp-Source: AGHT+IEQQzqVhfJxOgHOkMbN4KViM02emhSFsqxk/o7BP+xd9QQa4Wlrdd5/eK4O2MhvjeCbxbYdiDp43lE=
X-Received: from pjbph16.prod.google.com ([2002:a17:90b:3bd0:b0:2f9:e05f:187f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5684:b0:2fb:fe21:4841
 with SMTP id 98e67ed59e1d1-2ff33b937f1mr9676522a91.8.1741136746296; Tue, 04
 Mar 2025 17:05:46 -0800 (PST)
Date: Tue,  4 Mar 2025 17:05:14 -0800
In-Reply-To: <20250224174156.2362059-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224174156.2362059-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <174078620474.3857606.12481651463517277322.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Always set mp_state to RUNNABLE on wakeup from HLT
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 24 Feb 2025 09:41:56 -0800, Sean Christopherson wrote:
> When emulating HLT and a wake event is already pending, explicitly mark
> the vCPU RUNNABLE (via kvm_set_mp_state()) instead of assuming the vCPU is
> already in the appropriate state.  Barring a KVM bug, it should be
> impossible for the vCPU to be in a non-RUNNABLE state, but there is no
> advantage to relying on that to hold true, and ensuring the vCPU is made
> RUNNABLE avoids non-deterministic behavior with respect to pv_unhalted.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Always set mp_state to RUNNABLE on wakeup from HLT
      https://github.com/kvm-x86/linux/commit/2a289aed3fcd

--
https://github.com/kvm-x86/linux/tree/next

