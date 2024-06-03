Return-Path: <linux-kernel+bounces-199536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55D38D883B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78841C2182B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D830B137924;
	Mon,  3 Jun 2024 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQaZBCmA"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B557E579
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437254; cv=none; b=neYOWF9MY+lU39UJ6sNvNas3eBYjECYcmFblBScODw+5jCv+RGiOOuiS9s53QNZM15L0YZ0Jc0M8AtPeRLAvHgY35YgXzPi5fR8Ht80aFAcDVRFsNjAVdEFms03uytOSWSvQoOG+ZCWIr5HIxIuQS5B78ljmXduU1WFIrI80wf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437254; c=relaxed/simple;
	bh=+HcwjQSL+RH4eju+p7WhKT/i2G6gK7x6izjjaW+dhoA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I5PhpdJD8+4iOOXY5jC1whp4PVN5Kd9OYFitzX8Htlf896+H2OcqhC0J9XES7/1c9HuGlIZp6MofEMtssX9iCqrteQkCVPAWliKn9i1mJGPO7Bs0P7Gf9i3WPc86U4yPQygWVSU7vg7jwkZ4ASGEdzscVoOaZm3C1VxsK+ilUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQaZBCmA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c23f2dcf46so768134a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717437251; x=1718042051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/lO7kVJqDu8klxE57Sosz93cXrU6AFAsjPa7DJZGD8w=;
        b=BQaZBCmAcGpI+AorcsT4PtAxQ6GkcO1lANXYD9CeZ93hjcrV/AdLL8vgbIJ0zno9u1
         wbTgAk77napmdmTs6WVJxQwU/rQ4eB+xshDVpK70GGfuSIcFEzZLq5GEmEYUyCgN+ZxN
         +iqJDia5wpHb7EbIe23h00QtIxfVzzGO4O8H3ecquVP81XGtg9vSUvxr9RT5qlB94tXc
         SUPMfh981CmTt/4fgEeXUYGk3NO6XGyZJ3JJVXWs7UbNUs+o9JYLQEgYST7b1GczHpeF
         lFnnHsM9nFI3fS+LdepohJjc7jSXIqKqnSOrIg6gqsTT950vlf7xKrNi4JQU0LW5yUF2
         0u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717437251; x=1718042051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lO7kVJqDu8klxE57Sosz93cXrU6AFAsjPa7DJZGD8w=;
        b=DLrtswXkSm0pJd7qeWrWJLPGmQqUHD2zvPH6ihuqsamcshcOdiBrsy5VnYD9iJ6HDU
         d7XMiFqnAmYarLoIlJdUpIP57h6vriWuQp/faeN3DN/0tKEtsqEl9g+VtItRJPxU6iyJ
         UJoXJeg0VjHRj8GOajU0NWAXM6QgXTxBMcGAFOacRPkgBDSVDgycN5/s19tg2/An8XvA
         3J5/IuhBAqNIXqnQnZxkp5jXBeN9mic0d0mH6c5Lc7CzE/gclZLZzy0Wx0PawH1MS3g0
         4jjBC7vJHBS+PCxNB5a+NyMConFI84+iyzZvG5Hjq/Lj20hf7hAuInbpZkct8gNEjRQz
         xVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn4w9l7F7nsUdm1uD7eFn0VLNZkEo+6fp7yMmGEqcoMslA2sli8Jf4ncAuuuHMNHkNJqN7z9vugAhg/yLBNt3Uwb+o2cKKkxf29ZaY
X-Gm-Message-State: AOJu0YyhjYLIe/3aBuqSqsORGbBHtC9yWUbUskYvoOt+GgkOeclj2xAo
	slGsuCDjfIq8qyLuqaEH26XhiS5Khp2oYAFLejetfGSu3IgUU1YOsmaH5p8gEIBtiUzDhrtf3RO
	v5Q==
X-Google-Smtp-Source: AGHT+IGP3Bco15WQ8lgi7mzkwCZXoCegoWn5aCooQ4eWgv1ZeKVLwL/1OAcxLxqLastPxBXy0NJ6E44Iow4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:354:b0:2bd:6abb:e9f7 with SMTP id
 98e67ed59e1d1-2c1dc4b118cmr29663a91.0.1717437251075; Mon, 03 Jun 2024
 10:54:11 -0700 (PDT)
Date: Mon, 3 Jun 2024 10:54:09 -0700
In-Reply-To: <98ad0dab3a2c66834e50e6d465dcae47dd80758b.1717436464.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <98ad0dab3a2c66834e50e6d465dcae47dd80758b.1717436464.git.babu.moger@amd.com>
Message-ID: <Zl4DQauIgkrjuBjg@google.com>
Subject: Re: [PATCH] KVM: Fix Undefined Behavior Sanitizer(UBSAN) error
From: Sean Christopherson <seanjc@google.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 03, 2024, Babu Moger wrote:
> System throws this following UBSAN: invalid-load error when the very first
> VM is powered up on a freshly booted host machine. Happens only with 2P or
> 4P (multiple sockets) systems.

...

> However, VM boots up fine without any issues and operational.
> 
> The error is due to invalid assignment in kvm invalidate range end path.
> There is no arch specific handler for this case and handler is assigned
> to kvm_null_fn(). This is an empty function and returns void. Return value
> of this function is assigned to boolean variable. UBSAN complains about
> this incompatible assignment when kernel is compiled with CONFIG_UBSAN.
> 
> Fix the issue by adding a check for the null handler.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> Seems straight forward fix to me. Point me if you think otherwise. New
> to this area of the code. First of all not clear to me why handler need
> to be called when memory slot is not found in the hva range.
> ---
>  virt/kvm/kvm_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 14841acb8b95..ee8be1835214 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -653,7 +653,8 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
>  				if (IS_KVM_NULL_FN(range->handler))
>  					break;
>  			}
> -			r.ret |= range->handler(kvm, &gfn_range);
> +			if (!IS_KVM_NULL_FN(range->handler))
> +				r.ret |= range->handler(kvm, &gfn_range);

Hrm, this should be unreachable, the IS_KVM_NULL_FN() just about is supposed to
bail after locking.

Ah, the "break" will only break out of the memslot loop, it won't break out of
the address space loop.  Stupid SMM.

I think this is what we want.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b312d0cbe60b..70f5a39f8302 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -651,7 +651,7 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
                                        range->on_lock(kvm);
 
                                if (IS_KVM_NULL_FN(range->handler))
-                                       break;
+                                       goto mmu_unlock;
                        }
                        r.ret |= range->handler(kvm, &gfn_range);
                }
@@ -660,6 +660,7 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
        if (range->flush_on_ret && r.ret)
                kvm_flush_remote_tlbs(kvm);
 
+mmu_unlock:
        if (r.found_memslot)
                KVM_MMU_UNLOCK(kvm);

