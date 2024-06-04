Return-Path: <linux-kernel+bounces-201546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E54F8FBFD5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED8F1C228F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E85714E2F7;
	Tue,  4 Jun 2024 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxg8Z/vR"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B8514D6E1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717543793; cv=none; b=XhpQUqFjDNlayaxshb+JGQWJDG8MosWqQerwQmACtMsy/7lt9aYdFrDoEtlyHuaHq8V1b+rjEzW6C7xIi/mttYZVxq1/GO2Zfjdc7YJ6PvoCRpR9OzWDZv5HaFBmbHfBDGnUzE2qOmLtvmAoFeWgRtA+VP5b8/dxoXmz6Wmcaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717543793; c=relaxed/simple;
	bh=cMsCRivM5/rPaUXeSQ7yCaavw/L076BTyvOx6aLWSUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o/arZWDCGExCXXOHxAVkqRdf4loRJqIElV77aqE9D2QUlButMka6BT346owqflgs2cK6Z7zfENa4+5RLKo85XSb4nc2ma3xuItTeBOdIhOsupYxr2tg/vw8PixxbBDQWs1CGa4B/nRNDukl48R8X36VFJHVJMGu+dpGSFkhDTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxg8Z/vR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c1ad1ee431so5608244a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717543791; x=1718148591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yn29SGEL/4hxpbDH7DFjKmYshmIBVrIAEi6P1l/UqBc=;
        b=sxg8Z/vRPkXVGtuMRGNK02uuFb8oCbsfUX7usb6Y8fxFfDwCPbgkjXM/vtQa0xALs/
         SPFTYnkuXCkCxxiwwbVy4Zk8nCCM/alSvjOMjvJHaEcKegxKi+YidlVGOlnKchNHaMK3
         p3pASX3Czdet+nAARn2J1awvkrUj96Qh3JLMqcfoZZfkg8qT34y3OLQS9TtjBtMXv3fV
         A0sNhSovtHnUQSfhnX459tCBir5/v6rS0JEwVNp2GDaT96SfBZqiclqtP1xfKZZYgbx2
         IHeDSvcoCNb3iaD+cUDfuoViMbJZhITgx5aV/M5h7XWrXEbqH/f71xigtLFqriki7ZlS
         dlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717543791; x=1718148591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yn29SGEL/4hxpbDH7DFjKmYshmIBVrIAEi6P1l/UqBc=;
        b=hIZSAWGDbraqI4ty9MmQon2uLnFJNKZ1HqYCSXymcAX0OwBUooZYjyKYZyRXFAoCGi
         8zL1FaprvUZ/wohnmKGtnzyjyQw199wTvafrBKWHO1dj86eW9fnLH7gpGsoYfbYpGfnE
         IabHJaEpHNYZpabFgkwct2s5myxJ+JBP8F2buCXWLbH3+oxLhgTAlpmke9g8bRLe+yUb
         hEYkpP7jVPTLao6knLPhSw+hUQfBEEQJQbtloIak69OPMziuRcAN6fP8Zw6Pr3f9Onfs
         qalB3W9pPDGQvju3uURRSq6i3S1qSRAgXUE6NZqcIwWqiVso0PIocFVGbzro7IMaod3T
         63Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVUpJ7P0DmNgBPn6Cc9OqvivfC+1xOnQkT5nbDdR4z0+34CbTnlDRgp1ztq4I7ocZCPwzRqOSkUDVFU11uQOrlgVCm4C49+LYCWukGw
X-Gm-Message-State: AOJu0YzeNkCqT70V8/9Av51zapoEd7qogLjAR/+u7ujfR5PXJOOd/ymw
	c4lglb5iEF5fUx0anZ+mQcW7qTof5uuWsKqQIOYKJv8am3SDScRID2WK0vRj52ZI607d7kVJ2Ta
	wMw==
X-Google-Smtp-Source: AGHT+IHIJmGm0d7thB5hublwsNRV8ES1Xdkm1Wkz06dkR9yMo3R2cAI4IJXA4h56EOAexg6aGnDzmt2FYH4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:de82:b0:2b2:b00b:a342 with SMTP id
 98e67ed59e1d1-2c27db579d5mr6046a91.4.1717543791515; Tue, 04 Jun 2024 16:29:51
 -0700 (PDT)
Date: Tue,  4 Jun 2024 16:29:19 -0700
In-Reply-To: <20240510092353.2261824-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510092353.2261824-1-leitao@debian.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <171754269008.2777502.9202264224544350112.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Rik van Riel <riel@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Avi Kivity <avi@redhat.com>, 
	Breno Leitao <leitao@debian.org>
Cc: rbc@meta.com, paulmck@kernel.org, stable@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 10 May 2024 02:23:52 -0700, Breno Leitao wrote:
> Use {READ,WRITE}_ONCE() to access kvm->last_boosted_vcpu to ensure the
> loads and stores are atomic.  In the extremely unlikely scenario the
> compiler tears the stores, it's theoretically possible for KVM to attempt
> to get a vCPU using an out-of-bounds index, e.g. if the write is split
> into multiple 8-bit stores, and is paired with a 32-bit load on a VM with
> 257 vCPUs:
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()
      https://github.com/kvm-x86/linux/commit/2b0844082557

--
https://github.com/kvm-x86/linux/tree/next

