Return-Path: <linux-kernel+bounces-442286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE429EDA3C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6A328211C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D0D1F4E5F;
	Wed, 11 Dec 2024 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9HKNs6d"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2C1F2395
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956543; cv=none; b=pjVDQM6ZkqWzSbbfqzM/ZLSZ+DgA8gMS3qywQcNroPTljgsXVG+2xcp4onEtR8Voyx1zbbvnsgAdZDqN43dYzA0T8E1SZGmuZe1zrHZq71SLdZDfIfywnIvs6xWuMR6yh6RFlXX1UsJAbcoxfdaAk9Cx2rG5SfmoEvncd2fEChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956543; c=relaxed/simple;
	bh=lt4zBLD00go+8ZTh4scuZr6KDyf46ul1zxnocObd+bg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L/0uHCRvOBYyvPk/nGWL6/zrwwzvedgYLiQ+eiKBBawIG3IvnyfMBjpcN05ZAkS/9j82ZIIXZeSNc5Q4+FnIKjNKlm3pvYDfZh6GP3mmfUkgEvCFz9Z0dzLbx9SjGdKVkx7qXTJiWdD8KNc8O5jtHMScDG/D/IqpnuASvi0/NvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9HKNs6d; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efc4196ca0so3271798a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733956541; x=1734561341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVG8ahP/XXrJwp/ghgbGxkrwSNTwBGi72igr84vZWsw=;
        b=f9HKNs6drD3an/kEN0U0KNQZ2s8TSHVJn8UBfCQG3ol9STtymLOxDq7PVvsX3vyp66
         gwZQIlx6pVpYU1qaakSdbjLDxf5iTEKcBlCAeUHx4HF6EUFy8tGr6bBMVB0RHvU+lOSi
         henWblFsm84YO8qsL1mjNV7rUwWDNXWCJfHBlLObyo9xWUhjB9ly0Z7O7SxOAv5+WmxG
         XtSNODavZ354qcn4xqceJdcijWA/ODdy65/W7T4CyLF2xuodYWftbeZC2P1o836waytB
         KinTQYoIqD2Kl/cTtzegT/bksVOTJ+e570OXSb203TeA+2lfA8qkAcTy0SgIbTC5hiAM
         /AGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956541; x=1734561341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVG8ahP/XXrJwp/ghgbGxkrwSNTwBGi72igr84vZWsw=;
        b=evJOWvY1mWhR1x0cUZ9UtXYm6th/rt+zvd0bgDkYROKHsku321SFO7CFr5MnjYbJ0o
         0eUEMrwlM9LI8ZFssRud3Vxlk8Dksw5V6z61443ELmkt3x+KMgNIsoMem/iTxs2SdgyU
         CULKPTBb4UqNCoyel8QNLn68va26NrX4ba59oOPjC1MSBY3tJB9YSIk0vv7f8nXVVttc
         WdCSAZL1+HUvxRLqWryiSoCodH4kuKUu5lsU6HdJigfOy2lsnizhfK8LouQpyAmPzgif
         bsU+2lY03v3TDBuIgTGSqkMUnPqfOvQpgqkGtonnC2Aex0Vd7K6jyHtDtdQPS7uFKn7o
         a54g==
X-Forwarded-Encrypted: i=1; AJvYcCWASW0+O5NazbRjhpXUtzCmQ+ZEsISt1Rq94aGow5CaajJPLGWnrBqN7yDh2kiQ2dYF2uU/y08ZwtVuOIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMStzE2MPrJuQ/eYP0CydeLp3GiPgP5mpqDMNfemrPoDEkwUR
	8CX5deAqO7FCy6VW+StriVhYGkbFi50te+0RX8L0P07Sregge6JcspeCbXC92eTDS8iUodkpe5D
	C+g==
X-Google-Smtp-Source: AGHT+IGOKgLtrZFpctzdhq5n5IysWDqxKWjxJrTJsdkk765OEG8e8e8bmISVxnp1jIvzrNIQtklA1qJsYYY=
X-Received: from pjbqx4.prod.google.com ([2002:a17:90b:3e44:b0:2ea:3a1b:f48f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e48:b0:2ee:741c:e9f4
 with SMTP id 98e67ed59e1d1-2f1392938a2mr2342276a91.11.1733956540841; Wed, 11
 Dec 2024 14:35:40 -0800 (PST)
Date: Wed, 11 Dec 2024 14:35:39 -0800
In-Reply-To: <20241211203816.GHZ1n4OFXK8KS4K6dC@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202120416.6054-1-bp@kernel.org> <20241202120416.6054-2-bp@kernel.org>
 <20241210065331.ojnespi77no7kfqf@jpoimboe> <20241210153710.GJZ1hgJpVImYZq47Sv@fat_crate.local>
 <20241211075315.grttcgu2ht2vuq5d@jpoimboe> <20241211203816.GHZ1n4OFXK8KS4K6dC@fat_crate.local>
Message-ID: <Z1oTu37PmOvK6OlN@google.com>
Subject: Re: [PATCH v2 1/4] x86/bugs: Add SRSO_USER_KERNEL_NO support
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	KVM <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Dec 11, 2024, Borislav Petkov wrote:
> Btw, Sean, how should we merge this?
> 
> Should I take it all through tip and give you an immutable branch?

Hmm, that should work.  I don't anticipate any conflicts other than patch 2
(Advertise SRSO_USER_KERNEL_NO to userspace), which is amusingly the most trivial
patch.

Patch 2 is going to conflict with the CPUID/cpu_caps rework[*], but the conflict
won't be hard to resolve, and I'm pretty sure that if I merge in your branch after
applying the rework, the merge commit will show an "obviously correct" resolution.
Or if I screw it up, an obviously wrong resolution :-)

Alternatively, take 1, 3, and 4 through tip, and 2 through my tree, but that
seems unnecessarily convoluted.

[*] https://lore.kernel.org/all/20241128013424.4096668-40-seanjc@google.com

