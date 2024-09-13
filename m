Return-Path: <linux-kernel+bounces-328784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1C9788CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CA6284E47
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5F114D2B8;
	Fri, 13 Sep 2024 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SaMD/DM3"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C2149C41
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255161; cv=none; b=kQedRhC8xM3+FAKCjHScxEEzHAb+AE6ra8hIWd/NadfybXGfkrzmoSqiUPdDP8c8nZGJXaeLXq49/3osFsDlf6Y3+pDFM80ToZ+n7tzPbn7CpZHhxdQAVlIDjSFldhucg2MMJ3EQQ7/Ju2LIH2GtgLDd6B+rKofk0m4UEpQVun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255161; c=relaxed/simple;
	bh=KdqA4DCfyuTo+ba0MlGe2lwMx112ipnTw4TXPWoYZCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BHQpvDJulNMayqHc2okAweso0obU1moHdhl8816Nwb7DPEazpLJYi2r/5gKnApj54IPH8gfcOe73Cd/N/F8F5oFocX6J7m2lWsK+hopPrM4XM+V4EImjjqI1DN911AmM8t4mTVTYOZGU4Ne2CKUPtEtvKmYNeWTIiUJW1B/5cmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SaMD/DM3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-718d7ec6ff8so2152924b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726255160; x=1726859960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KygmwJLmIe2nR4CdVNrvjxv0ydC1BigODAK7NzKvrLY=;
        b=SaMD/DM3iHhfZq+KTOOEVbBQ3ES/g53YZwROvYvomdUUkOyr29bvex2yM7xaFYb1nW
         UqtYCwIv2+Zh51xQZarLIIupKzqic/57TMTRLQpTN+Hz9rG5ACc9yWCkQ1cJ8o4SQTgx
         weAJvEFgIajyUdVEFfJ0ps20YMwLE/9qdL8tdSVrr4SncUlwggDXLdffpVjT8go8Kd2E
         yZ+RdJYGFBHIPr0vY2aiaFZwD3TDvDTtuDb2FMPHgVSoBZFBX5QO2MwZACMm8YuCcvou
         UR9WmsjndgrP4TkJaP8FUJGs7ZzZgM8iiQNodU35X80wEFyy50KgEreQvc17LUE4LP2L
         Ccog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726255160; x=1726859960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KygmwJLmIe2nR4CdVNrvjxv0ydC1BigODAK7NzKvrLY=;
        b=l+I4vGkniVhvC7am/zLXN7UIBDalNugRnDzszM869/qj5wqjCuyGCyXjkfJ1V5bYG4
         GnnzuoBAFlL9Yhzzc/cT1Fu2iylLy1oX72vd/ELruywJRvb00+qxK7UcgImuyzGBUoB5
         deTSsSCSdqNAuSwmRZsWeznVKZuM5XwxyEMgxwG/T6YdY+lKfA5wSM0uxzt3G2gyBU4m
         H0dVLPnF461vcd5Fbj4KWlE3rzzhiHgsGA4zfJ+4mrqTuzfVkrbOTX2MgN7vWO8dOeff
         tLKerCfS808S8gz3QSc24HUZH9b7TVl7k1A64BfwwpVQvQGCDBq6h85yJx00giFY696N
         6ooQ==
X-Gm-Message-State: AOJu0YyxW+qMqQuCIYeYL75OXxLP5icmDBtTtsYMoqwN4jjZSWnaolCz
	6N0liVPn6vwa8Q+yfNFVB0IntkwTRd/U8WKS2/7N4RjhSF93pX2Le8BiyaZArbYUly7nxOPhCIn
	kcg==
X-Google-Smtp-Source: AGHT+IH/IGVZ8XQwZZNAwLj6rrOnsFpPB4v5CQ6jVNhQ4gVq1+yWAmZL7Sj8qjscTbab1nLQs6mmPd32wXk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:8d83:0:b0:718:d9ff:a392 with SMTP id
 d2e1a72fcca58-71907f308b6mr87141b3a.2.1726255159186; Fri, 13 Sep 2024
 12:19:19 -0700 (PDT)
Date: Fri, 13 Sep 2024 12:19:17 -0700
In-Reply-To: <20240609154945.55332-1-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240609154945.55332-1-nsaenz@amazon.com>
Message-ID: <ZuSQNZYWfeHTpAKN@google.com>
Subject: Re: [PATCH 00/18] Introducing Core Building Blocks for Hyper-V VSM Emulation
From: Sean Christopherson <seanjc@google.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	vkuznets@redhat.com, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	graf@amazon.de, dwmw2@infradead.org, paul@amazon.com, mlevitsk@redhat.com, 
	jgowans@amazon.com, corbet@lwn.net, decui@microsoft.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	amoorthy@google.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Jun 09, 2024, Nicolas Saenz Julienne wrote:
> This series introduces core KVM functionality necessary to emulate Hyper-V's
> Virtual Secure Mode in a Virtual Machine Monitor (VMM).

...

> As discussed at LPC2023 and in our previous RFC [2], we decided to model each
> VTL as a distinct KVM VM. With this approach, and the RWX memory attributes
> introduced in this series, we have been able to implement VTL memory
> protections in a non-intrusive way, using generic KVM APIs. Additionally, each
> CPU's VTL is modeled as a distinct KVM vCPU, owned by the KVM VM tracking that
> VTL's state. VTL awareness is fully removed from KVM, and the responsibility
> for VTL-aware hypercalls, VTL scheduling, and state transfer is delegated to
> userspace.
> 
> Series overview:
> - 1-8: Introduce a number of Hyper-V hyper-calls, all of which are VTL-aware and
>        expected to be handled in userspace. Additionally an new VTL-specifc MP
>        state is introduced.
> - 9-10: Pass the instruction length as part of the userspace fault exit data
>         in order to simplify VSM's secure intercept generation.
> - 11-17: Introduce RWX memory attributes as well as extend userspace faults.
> - 18: Introduces the main VSM CPUID bit which gates all VTL configuration and
>       runtime hypercalls.

Aside from the RWX attributes, which to no one's surprise will need a lot of work
to get them performant and functional, are there any "big" TODO items that you see
in KVM?

If this series is more or less code complete, IMO modeling VTLs as distinct VM
structures is a clear win.  Except for the "idle VTL" stuff, which I think we can
simplify, this series is quite boring, and I mean that in the best possible way :-)

