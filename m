Return-Path: <linux-kernel+bounces-199852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12D68FA6B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C361C225D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CC62AEE4;
	Tue,  4 Jun 2024 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/UbOzGM"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426D2F5A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717459238; cv=none; b=obRUsExZ72z9WRLETFZ6xQ+vm1uuWk6GW3ZbPJrNfVEZ8ZHr72EtD6IXq3fuH4Vn+/NcwJxbXGqPgxVMCdGjiwAwA0p+lHs3SPj+wRyp5/z3BafIocZdNfRc6lq0hbKGcdFqlPEdPXBv/Fc3QT9fvEjBZRST8pn+taRYAR2jYr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717459238; c=relaxed/simple;
	bh=qmzipbdBY6KqUjrHfBG3VzqriXpHdWHYlYyt1ENKvq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IfDq3YB9vzIPclX2DgxABrF9wnzxYyZPYXjvsFzQTFc+tRgUR35Kz9bbvJAMtECTXNPCdn+Q5qWG7TnliCZHE0JJxR+Ak4Bp3wbQAaJs2ZzaWIYBKV9ggdqO8KY10Y9r6jgUugInD6Bs3jtd3w5/frZGE57cvxwZH2v+TbrhOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/UbOzGM; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c380e03048so4172970a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717459236; x=1718064036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X9TixsbS4vucV54Qx239yWNe5AZLJZTOJio74oth8eo=;
        b=L/UbOzGM+TfjsttBDwqw33Jk2b3DMth2bsOfI0nx0kMDL9mricxF3qHUygEPoIVJsI
         kmKU5HFZfHxPgqZKx+Ookt7D93FVhWNcs4pldtc3MJVpo4ASkqhxFtWk+q0DNW1Q7HE5
         +g79iYBtGE24rwLOqTvKBYIzgjp+edcJP9K6RzhJWskZOrlHcajJAt/TsNTLbM1mVrY+
         RrXlLlo97JYib8+godLvSKWCK/hl5GE8/eD8Rpxgjv0i+cwjSboSQchZ0Dva88BJR3C+
         XwwzcOq+XkBIX8gYMWWMRKt2CmPNQ9MP5k5oBklF0WBN/3laSaLvCOQRU6NolCxs7zWc
         IrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717459236; x=1718064036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9TixsbS4vucV54Qx239yWNe5AZLJZTOJio74oth8eo=;
        b=HG6/0HnvIgEpsBpqOXj/uE/0Ywr/FVtUqXM6FidszoYwoNPsKWCFKne/PDfdxbuH/A
         B5Y6/MNcztDv/qi+h3Ljd02aOfWbwOdQyNOMq/jzdYW9sMd4N1MRmrwrC7fsSCm0qMJK
         aZg+RNoIipg578vR+uosMKSiwgzhS8qBesVI8w7KTOIch/wcUB7bS1DGNgZ0Zz25+97d
         wngYILxUXpoPPTE6arP5OK6TIoAhcsnApCK51UktAlQcWJwJgDICAq0CRiWfTLZ7aT2I
         DUyrqNgftLKfkszNrhNETXOnqU8Z4pSXom+B/do2f2P0A9Ko9n9H3gEfV8gJcmka1dRo
         8G0A==
X-Forwarded-Encrypted: i=1; AJvYcCVO8mqSsYxu+H4RyeE/7cYMfI3jCCXujLF4nuE+KDEQKiisaF4VBhrxcbAv7H1uZ7W+7BiKZbQbiqbUgeodlDqFSx0ahOqwJJ4z7FOe
X-Gm-Message-State: AOJu0YyQC2daf1d0GdjvUQrPPe5xvSgeEouHw+VdKyEm+NDVGyVCvelq
	673+bOv9oZ6zFNc3W7ihEIV9WZYWrlns7gthlJ2rhi8xQwQKSAdjyJsTHQs2wrGf0kqToNs8puO
	i2A==
X-Google-Smtp-Source: AGHT+IEZPsEeD1Zd/VZMKCyFxGi7l593WU5W4++SYV2nnpe1UGIt5x3H32mkoIcyVAOGihn5nlLRW2Z7atY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:ab0a:b0:2c2:4117:2409 with SMTP id
 98e67ed59e1d1-2c241172c69mr8738a91.8.1717459234737; Mon, 03 Jun 2024 17:00:34
 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:00:33 -0700
In-Reply-To: <20240520143220.340737-2-julian.stecklina@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240520143220.340737-1-julian.stecklina@cyberus-technology.de> <20240520143220.340737-2-julian.stecklina@cyberus-technology.de>
Message-ID: <Zl5ZIXOXzaTryibL@google.com>
Subject: Re: [PATCH 2/2] KVM: fix spelling of KVM_RUN_X86_BUS_LOCK in docs
From: Sean Christopherson <seanjc@google.com>
To: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 20, 2024, Julian Stecklina wrote:
> The documentation refers to KVM_RUN_BUS_LOCK, but the constant is
> actually called KVM_RUN_X86_BUS_LOCK.
> 
> Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> ---
>  Documentation/virt/kvm/api.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 2d45b21b0288..5050535140ab 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6418,7 +6418,7 @@ affect the device's behavior. Current defined flags::
>    /* x86, set if the VCPU is in system management mode */
>    #define KVM_RUN_X86_SMM     (1 << 0)
>    /* x86, set if bus lock detected in VM */
> -  #define KVM_RUN_BUS_LOCK    (1 << 1)
> +  #define KVM_RUN_X86_BUS_LOCK    (1 << 1)
>    /* arm64, set for KVM_EXIT_DEBUG */
>    #define KVM_DEBUG_ARCH_HSR_HIGH_VALID  (1 << 0)
>  
> @@ -7776,10 +7776,10 @@ its own throttling or other policy based mitigations.
>  This capability is aimed to address the thread that VM can exploit bus locks to
>  degree the performance of the whole system. Once the userspace enable this
>  capability and select the KVM_BUS_LOCK_DETECTION_EXIT mode, KVM will set the
> -KVM_RUN_BUS_LOCK flag in vcpu-run->flags field and exit to userspace. Concerning
> +KVM_RUN_X86_BUS_LOCK flag in vcpu-run->flags field and exit to userspace. Concerning
>  the bus lock vm exit can be preempted by a higher priority VM exit, the exit
>  notifications to userspace can be KVM_EXIT_BUS_LOCK or other reasons.
> -KVM_RUN_BUS_LOCK flag is used to distinguish between them.
> +KVM_RUN_X86_BUS_LOCK flag is used to distinguish between them.

There's a patch[*] that does this clean-up and more, which I'm going to grab for
6.11.  I am planning on grabbing patch 1 though.  Thanks!

[*] https://lore.kernel.org/all/20231116133628.5976-1-clopez@suse.de

