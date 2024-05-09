Return-Path: <linux-kernel+bounces-175051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDADD8C199C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53455284831
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4312EBD6;
	Thu,  9 May 2024 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbA9rSby"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060112D771
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295186; cv=none; b=Fm4N5eXAUGVNt2lXbTYe2qpY5WjucxTStFtPaxY3o2dQ786SJsBG9RhREbMc4/KnOXxPryDd50n8GW8EpmwWdrhife+TSvm4zHx/FGf0K8aPsfZSSKSTwyxAReDHs1Ph6pDzhh7XG+v+TlZRyJe3aCiMig+ZaHKChdkwdm8gXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295186; c=relaxed/simple;
	bh=ckYw/fPw8cWuIIDpNf0IHTJPYm/aVSFzE+XL4Y6KroU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f7g+o8ZMo+J7G84Q61zkhJaMa+HFLIPwKYp/w3RAUrbiaU+ki4jZ8H0StR+xJE0ux6KYxOK2h071mv/9WBbdXzZkKjX5907WvVbzY80v1IkUlLqsHSMqXLqh/l2U+uqdNCAV/KE6S8T1xNLDM62as2wc6tg9NPCPHVZ4OD6Cdo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lbA9rSby; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bb09d8fecso25021167b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715295181; x=1715899981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ME9lJAyFxkTypmVhuXddPd71uqtDTvwVdbPhhkE/e0=;
        b=lbA9rSbyzy2PIdwy/vfC3n/t52/iwGRLJu1WIdUfI15uZP/COYHH4gVERHgRqoUmAG
         YjuX0xPXQUJ4crWBpHusszKQlFHyd2Nv1noSznZVadZpR2YjYFEZt5QknQd4/uLfohO+
         ycJkDE3Oj4McIuIfqHh0H+6xMkq0Xtl4H3drqv9Y6NTUKDK3q/gUoiqjp+mZxNfXBiDm
         Gq8RoOGOK9oPPiSG++okJ58mKtft3FBAOnjOmSRNHM+Mx4Lwf57zNmwB83+7rbsGug1t
         B24+ljkLPqH3YnpnoI2nZgoypidF5jztIDOFtvy0r8zPRsFWeZjl42xUFQ6zoutRXaFM
         o3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715295181; x=1715899981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ME9lJAyFxkTypmVhuXddPd71uqtDTvwVdbPhhkE/e0=;
        b=FQvA2DPY9ffUOGSLRqLGs0l5zypXZ44+rWt84h741b2mhcYILqlFdfzofSkOKbxjEC
         GPG9pbGncPWCazRQgLjkUcFFQKuPLdNPA9xCIOmN8+Fngeq6blEA0v1FPZlPIHmQD+b0
         tZgjjlRg1zkrtMOCzmsV5bX8839YlmrnrtgSQmMUJb6nokVVVrtMzbeaJQxGuidHZNmg
         5CxrwT3sFWV+Uj5gYqSlMwjiPxaq7GESyibmhosk7r6RW5W2LFka06y0DujeK7vX0z2Y
         OWfYuIxkdfs9uDb6ioKpZhmCGue7LKcZHf4Cu3tvO7CmJi7gEENSDAjJtCgT1wjeja0S
         yb3g==
X-Forwarded-Encrypted: i=1; AJvYcCVitcMzrjaNnM9Mbt5huClBQPUl6EJDhy6mdhGuhKmA2ucByS0jdm1wgAAdkvp1536QjtyuSHqKiaB8Ce+E3JWvpn48wcvBq+VqiKmb
X-Gm-Message-State: AOJu0YwjRDFYFolIFlwKc4mcnm85DSCRZr14cUw1FcUsyIdU+7DfkxOC
	PB1cUfZEHnWshSpCn19Wi93KWcjAVtW3sYMNjGwpl8PLSMJqnjtvSkNbWZsvEZINq85nb6SwCrx
	JaA==
X-Google-Smtp-Source: AGHT+IHXr0Ip/gr6px7u8Lg8iBTMhb3wftkpSHicRh3tOfJA2tQ77XzCrUEIalKFLIbFCTu3T9uH74i0hXc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6010:b0:618:876d:b87d with SMTP id
 00721157ae682-622b013431emr2114887b3.5.1715295181353; Thu, 09 May 2024
 15:53:01 -0700 (PDT)
Date: Thu, 9 May 2024 15:52:59 -0700
In-Reply-To: <5ba2b661-0db5-4b49-9489-4d3e72adf7d2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1708933498.git.isaku.yamahata@intel.com>
 <9bd868a287599eb2a854f6983f13b4500f47d2ae.1708933498.git.isaku.yamahata@intel.com>
 <Zjz7bRcIpe8nL0Gs@google.com> <5ba2b661-0db5-4b49-9489-4d3e72adf7d2@intel.com>
Message-ID: <Zj1Ty6bqbwst4u_N@google.com>
Subject: Re: [PATCH v19 037/130] KVM: TDX: Make KVM_CAP_MAX_VCPUS backend specific
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: isaku.yamahata@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com, 
	Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com, Sagi Shahar <sagis@google.com>, 
	chen.bo@intel.com, hang.yuan@intel.com, tina.zhang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, May 10, 2024, Kai Huang wrote:
> On 10/05/2024 4:35 am, Sean Christopherson wrote:
> > KVM x86 limits KVM_MAX_VCPUS to 4096:
> > 
> >    config KVM_MAX_NR_VCPUS
> > 	int "Maximum number of vCPUs per KVM guest"
> > 	depends on KVM
> > 	range 1024 4096
> > 	default 4096 if MAXSMP
> > 	default 1024
> > 	help
> > 
> > whereas the limitation from TDX is apprarently simply due to TD_PARAMS taking
> > a 16-bit unsigned value:
> > 
> >    #define TDX_MAX_VCPUS  (~(u16)0)
> > 
> > i.e. it will likely be _years_ before TDX's limitation matters, if it ever does.
> > And _if_ it becomes a problem, we don't necessarily need to have a different
> > _runtime_ limit for TDX, e.g. TDX support could be conditioned on KVM_MAX_NR_VCPUS
> > being <= 64k.
> 
> Actually later versions of TDX module (starting from 1.5 AFAICT), the module
> has a metadata field to report the maximum vCPUs that the module can support
> for all TDX guests.

My quick glance at the 1.5 source shows that the limit is still effectively
0xffff, so again, who cares?  Assert on 0xffff compile time, and on the reported
max at runtime and simply refuse to use a TDX module that has dropped the minimum
below 0xffff.

> And we only allow the kvm->max_vcpus to be updated if it's a TDX guest in
> the vt_vm_enable_cap().  The reason is we want to avoid unnecessary change
> for normal VMX guests.

That's a frankly ridiculous reason to bury code in TDX.  Nothing is _forcing_
userspace to set KVM_CAP_MAX_VCPUS, i.e. there won't be any change to VMX VMs
unless userspace _wants_ there to be a change.

