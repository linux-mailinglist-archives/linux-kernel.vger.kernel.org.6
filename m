Return-Path: <linux-kernel+bounces-185401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2EA8CB484
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1B71F222FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C59149006;
	Tue, 21 May 2024 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGrTax9z"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ABF1DA53
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321779; cv=none; b=uUyrAushZ+SE+LMKjeEhC5BlFC44eg/OFYvsdxsutOr85L4ONe/1tolwu+eoJFNK5TCL8TsQtVqwkG7Qd/wQaK58VIom0Tc5bPpMvhQR5r+3Yr2JTBLnUYodig70vXGmL+V12OHWD1kY1qqpmOq/SzNO7fReQn/zTUaJjSBdOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321779; c=relaxed/simple;
	bh=iIAKgcqkrQku6Mr29zl/Q3Aq3+KvXVwIDxnt8qxjWcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X2LphUT6ccjfzfKN21Y/zbHlGRcf1a/jGKb29vUL1caNv1C1jKXkZOTxLBDbw8x1kpdgOFziOWeiotw8sJyd0Aj231vPmqbQ7zZsHtLBidasxYCQOFJHjjnSv32BM0ad4TcOhVGQJDvjfhEKgCGYb4dFhhrai8dUxHSct724PN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TGrTax9z; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ba0fd5142dso141191a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716321777; x=1716926577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z2y/OBkKxgzmvSuCRJlFU+1HEUO6FATvJsnEDlaTHY=;
        b=TGrTax9zbcNDUbLBxHleJWLVRommRaTHeZ7MtchmGSTapWxyg0608eh8SjanQ1+KS4
         C6MQ0fEKgnZ1ltX8uqYQXDvd2gFUdnq4qr86GVgPZDvMJVsbtHEhYLP7v/hlKXHs6p2O
         Vfn0iNyc4Wt1XxIzIio9x76UFxDw5WZuFF6Nk8I/bKVpPl57Dm4oi0gkw1kGiW8jPx7o
         bavfnYkzSLtKZse6MR4ngDAjzhb8wTJJCY8O7O9PEW/sZImXQAZP6K8ntW9uYLIPcvyJ
         KmZeezt0idsCVTokFhmd+bigDde/6/ZzEu424tfqxvfT8xER+NCwIKaHTLDmxicgDLWF
         wDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716321777; x=1716926577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z2y/OBkKxgzmvSuCRJlFU+1HEUO6FATvJsnEDlaTHY=;
        b=LCgPkjKPxP+ghxI7p6RpHvHHe2dasXZxyY4hEF+LuzCzmezTzLcx3e9TcJwpYUFTyN
         P5MIitUYSjo0ySfbL0RuYcNBqBJbUwFZv7iyZDgsrgQg/OnBls6HT1USnwjMTcp2UuIP
         MFp1utS9t+T94EqmsGmxk6TmkV0CGGFcOPFXntKsGJFFNPpqb3Eop+JKooAFhDJeGqUN
         TrohdQZho/eI7VsQDa5z7pBK/dIzyRHXoegFmaZepGKvnqwyLjjCO+3HqZlpjNnl+Efq
         HlX5ZOOwHFpgkk7cABOp3znrJFcdN20Uk+8zmSfBspQYBrdTE6qO0ATQXW/eYHCNzA72
         KDYw==
X-Forwarded-Encrypted: i=1; AJvYcCV7YSwaEikjlcAafNTe4BkwNs8AF/OUkObDvGjkaczCVv7tvXwmXATq2I7qNCocK+OvjqT2I/IkUs9JVIpmV9/tGmWWqiE9I9QdajQO
X-Gm-Message-State: AOJu0Yysb8zc7e9PkQ6nTKfK2ibqNoGTggxBxdLKwOKlm6QSwH5UQa6d
	exQ2TpryfgiIM/xDignkATYkIwxf2Xz149KMUnDbSh9QIQPljaiT5MvYpkrHt8g2WJs2HWlJkCl
	eUQ==
X-Google-Smtp-Source: AGHT+IGc8AMfLKM+eg0g6UQUcqfUBCYk4fTqnxjiZdUzMhtJbdwzeQwWLJW3iNG9Bbk6zyIuCWPv8Gd0+4Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5384:b0:2af:b21b:6432 with SMTP id
 98e67ed59e1d1-2bd9f5c1a8amr520a91.2.1716321777329; Tue, 21 May 2024 13:02:57
 -0700 (PDT)
Date: Tue, 21 May 2024 13:02:55 -0700
In-Reply-To: <1dbb09c5-35c7-49b9-8c6f-24b532511f0b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425233951.3344485-1-seanjc@google.com> <20240425233951.3344485-2-seanjc@google.com>
 <5dfc9eb860a587d1864371874bbf267fa0aa7922.camel@intel.com>
 <ZkI5WApAR6iqCgil@google.com> <6100e822-378b-422e-8ff8-f41b19785eea@intel.com>
 <1dbb09c5-35c7-49b9-8c6f-24b532511f0b@intel.com>
Message-ID: <Zkz97y9VVAFgqNJB@google.com>
Subject: Re: [PATCH 1/4] x86/reboot: Unconditionally define
 cpu_emergency_virt_cb typedef
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 15, 2024, Kai Huang wrote:
> How about we just make all emergency virtualization disable code
> unconditional but not guided by CONFIG_KVM_INTEL || CONFIG_KVM_AMD, i.e.,
> revert commit
> 
>    261cd5ed934e ("x86/reboot: Expose VMCS crash hooks if and only if
> KVM_{INTEL,AMD} is enabled")
> 
> It makes sense anyway from the perspective that it allows the out-of-tree
> kernel module hypervisor to use this mechanism w/o needing to have the
> kernel built with KVM enabled in Kconfig.  Otherwise, strictly speaking,
> IIUC, the kernel won't be able to support out-of-tree module hypervisor as
> there's no other way the module can intercept emergency reboot.

Practically speaking, no one is running an out-of-tree hypervisor without either
(a) KVM being enabled in the .config, or (b) non-trivial changes to the kernel.

Exposing/exporting select APIs and symbols if and only if KVM is enabled is a
a well-established pattern, and there are concrete benefits to doing so.  E.g.
it allows minimizing the kernel footprint for use cases that don't want/need KVM.

> This approach avoids the weirdness of the unconditional define for only
> cpu_emergency_virt_cb.

I genuinely don't understand why you find it weird to unconditionally define
cpu_emergency_virt_cb.  There are myriad examples throughout the kernel where a
typedef, struct, enum, etc. is declared/defined even though support for its sole
end consumer is disabled.  E.g. include/linux/mm_types.h declares "struct mem_cgroup"
for pretty much the exact same reason, even though the structure is only fully
defined if CONFIG_MEMCG=y.

The only oddity here is that the API that the #ifdef that guards the usage happens
to be right below the typedef, but it shouldn't take that much brain power to
figure out why a typedef exists outside of an #ifdef.

