Return-Path: <linux-kernel+bounces-392830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BE39B9899
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62EF1F2494B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AF61D0E14;
	Fri,  1 Nov 2024 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z+chgdOb"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD801CEE84
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489326; cv=none; b=YJn8FczHiFi5DmMLc3YyhcF1yCw6Mvnl9sNAXPHbQiORkOL0w5quvzcM89Zqd70dQieeSrSDauIa6OJcBr6C2ij39iY89BL95Oj1AtE8821IwCe/psP9o6kQBK4BgJhO8mybaP6/IDBL/qmgSPzfx1wdnI+7u8k4yYFTVtosZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489326; c=relaxed/simple;
	bh=QYMoFeTxUGOO5P9zHc1Yw6Ch3laB+TBFlt2b43Fl9Xc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GcDTDcTHx6Zps2jsugngKCShNLgxL+1iJIM40ADOSd05pJFyIMDxS8+EhqdLCfn5zgCT3ZxJUdo2v1cuV8ETMu9rVFGEpCuNV/kBQvQ9K2RrBbKfjHQ5fjsB+2cpE4JxgjaqBpZ4H2vb12UrgHryS0ekd5qsUBlcR6ozGffkw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z+chgdOb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so44887147b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730489324; x=1731094124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHqjs2CWPbla3bx78NBZn/Aq6Iz5K05gv+DiEMvLcXA=;
        b=z+chgdObFGSiyAeJCwpjFqGYq4k0Ud+Riu0v8H7Im5pHqQyPCSq8Y0Us1zNoEPj0Oq
         lvrMcmUy2sJ/AnWVgb93a1XvQp2OdNXox3Gd6n05X9tfJ2JMg3trpmJ2H4cz/MN6rmhD
         10OJEhNh6pSk4CeEVf7voO1AOL6gZOEzqN4L8BzC8IOM+3NEyoUV/r/dkvjUKsmG1+Wp
         bBwQxhiE4bewc80aYqGZ0uJ7e5oI7KA1ogoDgaQoZhjBuPA/NisPyGHQQcJR62h1Lv7r
         s/+8Cl1RE5qv4V/fT12pJFhZ0YKkqil+Mi6E6/nho3SiC7hKXL5LdI8rf4aeElyVg69N
         LGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489324; x=1731094124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHqjs2CWPbla3bx78NBZn/Aq6Iz5K05gv+DiEMvLcXA=;
        b=R23o4zARknUyoFrQLtyXLH/J3Y3EmNPtREK0D084n7k9QWczQT/EDLWNyLZdG8pOxt
         afBG0ztFNY+8y3erz8wr8ToqYEY2Gzh3Jr6gYZgQClE22A1PLm7HFQKA5ZxpfWFUIDwD
         WqTJrrsJ7cbruEgP/DXKZJY6jQz7H6NGWtVAHGXcGL3ZYzrTUuDhFPEixZSQYy0qjOOM
         x6rae+oef7Ejvu1uwpI7HqCRAVqYVYkfRSGX8LqmAU348K6rqdZLaThZisUkHLcHPSGv
         dxXmCSkMqKczW+zPiMEPATU8aA/YfzhiHeucuQU952qGOOmbSHdPtz+7ILVBWJJ08OAn
         TTVw==
X-Forwarded-Encrypted: i=1; AJvYcCVJokc/UZsHbD9gVHUVmqEJkkdUVrxX/5yfWcJ6qZ38MOEtx8uivHdhQQ6cS+5t4uToI3ntTyGDCQZMGU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjsCp6PE+neAQpYCvf4nFGfyok+QpWzZoEzXqhIWUY05NFzWpR
	QIdL+gF8rTf1cmE4aDVEsisr0aVdeB8oyO8Iw9nlWIJpGAFHPvi5+/xdNFUBVXkNana07YIXVml
	o1Q==
X-Google-Smtp-Source: AGHT+IF8HLLTOuTCNq7vh6SdOkqFvsj1dyHQ1QM611ov8SmP4NWwxRqDVQZ0yGsjshQGf+9BUmJlS42aWrY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:11:b0:6ea:6872:2fe6 with SMTP id
 00721157ae682-6ea68723031mr479037b3.4.1730489324538; Fri, 01 Nov 2024
 12:28:44 -0700 (PDT)
Date: Fri, 1 Nov 2024 12:28:43 -0700
In-Reply-To: <ZyT7uDqK29J46a0P@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011214353.1625057-1-jmattson@google.com> <173039500211.1507616.16831780895322741303.b4-ty@google.com>
 <20241101153857.GAZyT2EdLXKs7ZmDFx@fat_crate.local> <ZyT7uDqK29J46a0P@google.com>
Message-ID: <ZyUr64wRvSbSB378@google.com>
Subject: Re: [PATCH v5 0/4] Distinguish between variants of IBPB
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>, dave.hansen@linux.intel.com, 
	hpa@zytor.com, jpoimboe@kernel.org, kai.huang@intel.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 01, 2024, Sean Christopherson wrote:
> On Fri, Nov 01, 2024, Borislav Petkov wrote:
> > On Thu, Oct 31, 2024 at 12:51:33PM -0700, Sean Christopherson wrote:
> > > [1/4] x86/cpufeatures: Clarify semantics of X86_FEATURE_IBPB
> > >       https://github.com/kvm-x86/linux/commit/43801a0dbb38
> > > [2/4] x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET
> > >       https://github.com/kvm-x86/linux/commit/99d252e3ae3e
> > 
> > ff898623af2e ("x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET")
> 
> Doh.  I think I'll rebase the entire misc branch onto rc5, realistically the only
> downside is having to send updates for all of the hashes.
> 
> Thanks for catching this!

New hashes after the rebase:

[3/4] KVM: x86: Advertise AMD_IBPB_RET to userspace
      https://github.com/kvm-x86/linux/commit/71dd5d5300d2
[4/4] KVM: x86: AMD's IBPB is not equivalent to Intel's IBPB
      https://github.com/kvm-x86/linux/commit/de572491a975

