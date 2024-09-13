Return-Path: <linux-kernel+bounces-328557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536019785BD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189FF287FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46C56F31E;
	Fri, 13 Sep 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/B1zepu"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD7E4A21
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244887; cv=none; b=PPgCNWsMdJPwhCyKvmbNVnDTDVAYMfHfpKHC4fAU643EYndkGQu/yHVOPNjfG2YwJuRevGMWk8lG7u8riIakS9suHzIlc62JqgvZHzYylkv6TpwbDhOfXCJ+QUbUXaIZBGwTZ9bDHTmzaqIg3Ikz59NqPG+jRQ0UxDwrc8AWlYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244887; c=relaxed/simple;
	bh=Dz4ycnfvKoef37mAeFE+o6mhEPp3GIZ2MGXjJvSfPUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J+7fdQd1ycf3MjJBbZFdRkRzHNN0H8bg8jSOVo5PMVlkH9hpqHwi8/FyVfR1eezDVc/DEEQrdZWgo59oLz7i+YsFYbsMcpUxSzUCMI4Hx/XVh3Gz0g4rqF1Rbd3KECnNJW/6qHyan06Z4sTzGDpL8TzcewglrC8poLw7ojRkxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/B1zepu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-718e82769aeso3595752b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726244885; x=1726849685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cN9LbXKrRTawqhLxdUzFmP/6lGNimEaJ6R6JDJd4qJ0=;
        b=B/B1zepu96JZ3LGmQZZtIh+OlVUs8TEsYwtex+YmKSZBkkoU40r3DgG4gsZfFGhYyH
         HCVvFJ1vmJoExf/JPsrAu9b3YUvg4Yudyp4si90BUS9L6MNav91PxDBhOKmTlPweM8yW
         4uAD74cS2iMtFr8/ylw8R0/q54Y0S9/gd4rBsQVr3NDcjDuB0H8EhucoZcwuvw6ohEzC
         Is8zFeUiyJboOoocYnS7ETOn3wBr2gbS7tR0zZVVr4RzW08M2Vbsp4vxegEyMo24x36k
         HVm8cYrS6RNyRZ7kqSKdaxVjyGKN/19J5ak/WNgAVF0MWNZjdEAvz1NXgXrkdTRjJzwy
         w1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726244885; x=1726849685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cN9LbXKrRTawqhLxdUzFmP/6lGNimEaJ6R6JDJd4qJ0=;
        b=AtAqUwwAv9WCmS5nm8TAu/CmqtXiylZJHxhCEJo8SPZ/7zp30Jwlij7Pf86c1WcY5q
         YFZgyJE5AAkmlS/ORjqTZ0AN4UrhzPNNJpU28KIhGFxSasnaic5ux9gqRnBAVWPGSSh9
         Wqfrv0bWO9rmcdOsu9MSzgR/U6MZjcIQPUoGKkx/9oSYOEb7KG8AlxfgA1xnv2BFhYVS
         TMPA6okzVZZ6jnPTGySPbKxJ5gkZFXHl4GNGMkvP3J7rY16+LKkBRY3mWnc0s0ygRMdq
         tBQZ9P9chkdaG/NZnJzDVD/HJx4yoHs97nUFx42SGfdnilNNCFt3CQbPqIG4j4e7eO/j
         Eorw==
X-Forwarded-Encrypted: i=1; AJvYcCWd/smSzPdMMcpR+1JUyNw3ip7FCms4IheFde8DBzpBXPUj71f66Jjt/fDbZWppysdH6tm3r4WhWzhPR78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyyzX+iMr4++NKAdi++qyjJMyVqjOMP5odKCAgIpqXPA4QnLjn
	qi7mveuJriulDch5cyDmwTxHzqrMWnhvwz4K8w9X9j4GyDc9iye/swbTaTlYItHpoWmv1xshLNA
	tpA==
X-Google-Smtp-Source: AGHT+IEyFXub8qnBjI0i5iQfgEPlsRdkIO3FIrijTVZf40RVSEUHkYTCWRuRVG3w2Em0cQHn4IDy8Vj2t8o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:91d0:b0:717:92f2:d50b with SMTP id
 d2e1a72fcca58-71925fa5ba1mr22049b3a.0.1726244885020; Fri, 13 Sep 2024
 09:28:05 -0700 (PDT)
Date: Fri, 13 Sep 2024 09:28:03 -0700
In-Reply-To: <c0d9ff5f-85d5-4df0-94a8-82e3bf6fe21f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1724837158.git.legion@kernel.org> <cover.1725622408.git.legion@kernel.org>
 <6c158a14-ba01-4146-9c6c-8e4c035dd055@intel.com> <ZttwkLP74TrQgVtL@google.com>
 <d3895e03-bdfc-4f2a-a1c4-b2c95a098fb5@intel.com> <ZuHC-G575S4A-S_m@google.com>
 <h5gp6dgcfazm2yk3lorwqms24c2y2z4saqyed6bnzkk2zhq5g2@rf3lj2a22omd>
 <039bc47c-9b5d-41f3-87da-4500731ad347@intel.com> <2v2egjmdpb2fzjriqc2ylvqns3heo5bpirtqm7cn32h3zsuwry@y5ejrbyniwxq>
 <c0d9ff5f-85d5-4df0-94a8-82e3bf6fe21f@intel.com>
Message-ID: <ZuRoE6P3DxxK_3C9@google.com>
Subject: Re: [PATCH v6 0/6] x86/tdx: Allow MMIO instructions from userspace
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Alexey Gladkov <legion@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, 
	cho@microsoft.com, decui@microsoft.com, John.Starks@microsoft.com, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 13, 2024, Dave Hansen wrote:
> On 9/13/24 08:53, Kirill A. Shutemov wrote:
> >> Basically:
> >>
> >> 	New ABI =~ Specific Kernel-mandated Instructions
> > If we are going to say "no" to userspace MMIO emulation for TDX, the same
> > has to be done for SEV. Or we can bring TDX to SEV level and draw the line
> > there.
> > 
> > SEV and TDX run similar workloads and functional difference in this area
> > is hard to justify.
> 
> Maybe.  We definitely don't want to put any new restrictions on SEV

Note, SEV-MEM, a.k.a. the original SEV, isn't in scope because instruction decoding
is still handled by the hypervisor.  SEV-ES is where the guest kernel first gets
involved.

> because folks would update their kernel and old userspace would break.
> 
> Or maybe we start enforcing things at >=SEV-SNP and TDX and just say
> that security model has changed too much to allow the old userspace.

Heh, that's an outright lie though.  Nothing relevant has changed between SEV-ES
and SEV-SNP that makes old userspace any less secure, or makes it harder for the
kernel to support decoding instructions on SNP vs. ES.

I also don't know that this is for old userspace.  AFAIK, the most common case
for userspace triggering emulated MMIO is when a device is passed to userspace
via VFIO/IOMMUFD, e.g. a la DPDK.

