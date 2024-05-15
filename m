Return-Path: <linux-kernel+bounces-180454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE998C6EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF0DDB21B04
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627A740858;
	Wed, 15 May 2024 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EC8VVtvZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F623D551
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715813242; cv=none; b=XLvOldoruHR9Xwhkk+ysZd7T3PFPVCQvlSJIU1fgWcoO3UPo0ccwERVALm4aTspo2iVAr4MtmMLgahZQlk7RmwzB2EV077ZRH+29IQi6b/SPgy9c0//MgbvjPe5Lz89apvBUfZ6vWebex8xKpr0bJunN8MoKJvZvzOYHmZVurZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715813242; c=relaxed/simple;
	bh=B0xv+wyaYoZnZGMhBFhf5haAobaIxUILvvnAUaDi0Oo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I9zHeKMsSonXPSA3gRapk9YtjSvhMnhKuVI6ERT9qnT8eP5hPfHMZtKHSlR1OXUGrhYbPY/ja/bmB7CqKV2Q8OqdtleK0lhZOaLeXtmlTbmZXnzgzQILJktQdg2i+1DP4wbEhDMlNuHBZHxrOhw92UFFILHPOW30BIu3uoPQWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EC8VVtvZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so140602057b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715813240; x=1716418040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+A/fyUbEaIg0FDmmDbVHWkzB7BYpWANvCsdM9DPEN8=;
        b=EC8VVtvZXu8EnW3CFKExeiSnJH08VEDzm95YuGW0JgcTFMzDG+9CZ6w6s0hmCyQtoT
         vX3rM2gUIIdShnxNO1vZ5TdQmuaQI430fQxfxlsPSc7tCD4FyVSDjkSrSdWx80Xtwmxf
         kbKxwFCFZN6KN3tFyuCvYc+S6m/87gpm1x+Flqai8FGWtTgm4R6teWXDpIbhvBOJycs5
         1/YmBqQGg/+nvycu27EXtPGQ++5gubUiIPl4/5XVBJHJ3FfOUt2zQfZUnl11Je7ZWmio
         kQjjAHJE4Qbxk1qLqV8pmd9GALhrSbPNht60LgI6J0sLT0JRuJgsGPcRKfAPa7RCuxwG
         VfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715813240; x=1716418040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+A/fyUbEaIg0FDmmDbVHWkzB7BYpWANvCsdM9DPEN8=;
        b=Kwtkm3Ii0KzIq5Ji2VF+Xxvtz2mKgW7I5DkYpyf5ZsAvdU9Vjh0aZODY04AmnH+2ft
         EV/XS0BhcevyIJ4vjEt1mQZMT/PpyAYl12tZKMLu2SFrHzYXu130IBj82jMvmB5NP+P3
         Feu42HDdOR7W7TiXOfPwmBRCu8kNq/dPsIkvHoVzlmw6BFsTc0dIXd4jjZ3iJ2To6CE4
         G7oLEgCmj9+pCfMZPILfA8YK1/aJK61S6otoBb68nsKwqV4Xc7gRO/PxgwU21bOJ3ZDq
         TwhpStWeutv82PXHhMSakzh570S4QIwf9HFwgvWVX11shqqTX2qcy9Q7KeqBTojMHfgJ
         /COg==
X-Forwarded-Encrypted: i=1; AJvYcCVWmkz4jrc60qQfmey/g5+pXCFFR0zKT6OgcYdvQ6Vbb2FDtnRwwfZZtlFxvnKYtxk2AXlakfE/Tt/7tHUPCaEdd1+RD3eC3W7wS74L
X-Gm-Message-State: AOJu0YxqkJOQNmubGqyzC2ENBV6MWUeVCt8ePgUN6rqhLcCg2CpQBqoH
	j3P6QjuuZ6Pm1sKQ92AmsQYfTgNB86QwGm8rLOYi0xUK8rlmVBb6zxX+ApODOmkihHa4GxnFlJ2
	zng==
X-Google-Smtp-Source: AGHT+IHt4rIE6WypsvVWF25hgbAMfEWYMCnxERhBAlckMm3bKn5M7lY+Ly/CavviBdfu0vUN4dd7iOOGzMQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d590:0:b0:627:6431:caa8 with SMTP id
 00721157ae682-6276431dc58mr4193627b3.3.1715813240246; Wed, 15 May 2024
 15:47:20 -0700 (PDT)
Date: Wed, 15 May 2024 15:47:18 -0700
In-Reply-To: <ac5cab4a25d3a1e022a6a1892e59e670e5fff560.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515005952.3410568-1-rick.p.edgecombe@intel.com>
 <20240515005952.3410568-3-rick.p.edgecombe@intel.com> <b89385e5c7f4c3e5bc97045ec909455c33652fb1.camel@intel.com>
 <ZkUIMKxhhYbrvS8I@google.com> <1257b7b43472fad6287b648ec96fc27a89766eb9.camel@intel.com>
 <ZkUVcjYhgVpVcGAV@google.com> <ac5cab4a25d3a1e022a6a1892e59e670e5fff560.camel@intel.com>
Message-ID: <ZkU7dl3BDXpwYwza@google.com>
Subject: Re: [PATCH 02/16] KVM: x86/mmu: Introduce a slot flag to zap only
 slot leafs on slot deletion
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "dmatlack@google.com" <dmatlack@google.com>, Kai Huang <kai.huang@intel.com>, 
	"sagis@google.com" <sagis@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 15, 2024, Rick P Edgecombe wrote:
> On Wed, 2024-05-15 at 13:05 -0700, Sean Christopherson wrote:
> > On Wed, May 15, 2024, Rick P Edgecombe wrote:
> > > So rather then try to optimize zapping more someday and hit similar
> > > issues, let userspace decide how it wants it to be done. I'm not sure of
> > > the actual performance tradeoffs here, to be clear.
> > 
> > ...unless someone is able to root cause the VFIO regression, we don't have
> > the luxury of letting userspace give KVM a hint as to whether it might be
> > better to do a precise zap versus a nuke-and-pave.
> 
> Pedantry... I think it's not a regression if something requires a new flag. It
> is still a bug though.

Heh, pedantry denied.  I was speaking in the past tense about the VFIO failure,
which was a regression as I changed KVM behavior without adding a flag.

> The thing I worry about on the bug is whether it might have been due to a guest
> having access to page it shouldn't have. In which case we can't give the user
> the opportunity to create it.
> 
> I didn't gather there was any proof of this. Did you have any hunch either way?

I doubt the guest was able to access memory it shouldn't have been able to access.
But that's a moot point, as the bigger problem is that, because we have no idea
what's at fault, KVM can't make any guarantees about the safety of such a flag.

TDX is a special case where we don't have a better option (we do have other options,
they're just horrible).  In other words, the choice is essentially to either:

 (a) cross our fingers and hope that the problem is limited to shared memory
     with QEMU+VFIO, i.e. and doesn't affect TDX private memory.

or 

 (b) don't merge TDX until the original regression is fully resolved.

FWIW, I would love to root cause and fix the failure, but I don't know how feasible
that is at this point.

> > And more importantly, it would be a _hint_, not the hard requirement that TDX
> > needs.
> > 
> > > That said, a per-vm know is easier for TDX purposes.
> 
> If we don't want it to be a mandate from userspace, then we need to do some per-
> vm checking in TDX's case anyway. In which case we might as well go with the
> per-vm option for TDX.
> 
> You had said up the thread, why not opt all non-normal VMs into the new
> behavior. It will work great for TDX. But why do SEV and others want this
> automatically?

Because I want flexibility in KVM, i.e. I want to take the opportunity to try and
break away from KVM's godawful ABI.  It might be a pipe dream, as keying off the
VM type obviously has similar risks to giving userspace a memslot flag.  The one
sliver of hope is that the VM types really are quite new (though less so for SEV
and SEV-ES), whereas a memslot flag would be easily applied to existing VMs.

