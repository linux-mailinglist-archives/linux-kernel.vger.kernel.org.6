Return-Path: <linux-kernel+bounces-180480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACCB8C6F17
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 01:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2470B20E63
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010AD4EB3D;
	Wed, 15 May 2024 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tO8Vnxz0"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC94101C8
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715815206; cv=none; b=mfiS96W0STolkpqGspM7Xmov4B1FL07rS5lhIi9V88tdvhBy5tRSCYLIzJd6sCNk9pG1uZN7ppLFZopubTvhOB4FDmhjbu589t3U0RDh4JabC0zIyd1KY0bfWgOS6gc/o59lq3xjxmp+JWzFWvQmKcDkra9D4i+M0pOu97j0G+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715815206; c=relaxed/simple;
	bh=uq5jbcln+jzH/PLpZe9wXnSOTlm0FyFFVFCwKP91LGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AP5iHa861vCcdbrFwEK9CnDC8CrgRFeoF8GdN6bFq9y54s7eJvUcX3KpX9v96eJoshPh3VFQWoznAHoV11BM0BihODX2Hi7w0ffIWY6tkekzR0+hRgEbMdyRi0u1GJBejnbelYPsmmHsOPcMghyDtwO4mfJ4odB7ZC+KkjlS01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tO8Vnxz0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61c9e36888bso127579007b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715815204; x=1716420004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6YDxr3hZHHTclQ7zyLq/DlJKdNF735yaym0zXBzZRNw=;
        b=tO8Vnxz0RfBY/mNvbNtPWd4K2gSh2CgO+SRNJGPZr4rR88zouqmbr1b0UGPz999XK5
         d3xC4dMuhLcq02EWdOqAruF8Wmn/U4RJneLIY7tIuEK1rjKJWHFRck622i57C4qwFKTH
         i7xZokKgUN4cl8M+c7Dn9D7TECcH/NUQeiEMw4taLS/zXULc8spiuKW4xzNURG+FQ729
         +ir12zF7ohScN2dCHTKlQqcbb1jj9RgQuV7bTtUZ5E4+ibt33qaN/VHZSv3w6ohp24hU
         iv4SxAdGRgxCYDqQmpWKakN/qwGdi7NJHNIU89YB+mx3wUss7Fcz7Cbh0Mh/TUrkIPV/
         pisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715815204; x=1716420004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YDxr3hZHHTclQ7zyLq/DlJKdNF735yaym0zXBzZRNw=;
        b=mUQfFM6AkKegAKgnKOaulcOHQjPiRDeZSiPVPPD2B88jwwnmqTon6I8fdWyfsiCwra
         hwd7mBvtsySUFuJq6POFFHwJxD3MhHliUsLexjk5KXH5BhwE9MkeE/VFlkT1xbVXZErr
         1538qTBTSAG/+VpLneoSGxHeRRJ5NstiC6Q11RQLRoGEDl8oC/HDZnnyWFYkKNdz3uAj
         v3IHR11/+AdSxy9c7/7vDEeBz9eJaBY2IBLCtIsrBVKkRl16pvZsmrP0BXwCcYYCz0Q7
         ESM8uzq0/rx29UXxU4xSD4t6QTMZHlQHg2/M+K8+gzCKR1+IgA4nVTFOMvhHvX83Gpqg
         P6TA==
X-Forwarded-Encrypted: i=1; AJvYcCX07ODyx9+exIB2mRSb2GRgUu26PJw6j5qBpMaX+KPJHjur2kCGOsC7pBrNVYWe1+d3Ym40HLb7D2Wbvv7BimdJqv8ihj4XYAih8m77
X-Gm-Message-State: AOJu0YyVnYJVY3ZHPqL3QQyXLtXGrX2A/vQphEPZnRxxuknz1j2aaaFw
	/A6ovHs1yAX5CRbv/o1XHHIbkuWKxRCabJXo9RXGh0cb5+R8DHXvBYSpQPMFHlGEYVxj5iNPV2T
	PIA==
X-Google-Smtp-Source: AGHT+IGiMIigOSDrrlOBnbxaKLq8/8hmGFpm1Scz2UDZMrMDNsO773Ch249W9pUKNNAsjSgFGmuSjLu7ZmU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:6d97:0:b0:627:3c45:4a90 with SMTP id
 00721157ae682-6273c454b1emr4527527b3.4.1715815203978; Wed, 15 May 2024
 16:20:03 -0700 (PDT)
Date: Wed, 15 May 2024 16:20:02 -0700
In-Reply-To: <175989e7-2275-4775-9ad8-65c4134184dd@intel.com>
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
 <ZkU7dl3BDXpwYwza@google.com> <175989e7-2275-4775-9ad8-65c4134184dd@intel.com>
Message-ID: <ZkVDIkgj3lWKymfR@google.com>
Subject: Re: [PATCH 02/16] KVM: x86/mmu: Introduce a slot flag to zap only
 slot leafs on slot deletion
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"sagis@google.com" <sagis@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 16, 2024, Kai Huang wrote:
> > > You had said up the thread, why not opt all non-normal VMs into the new
> > > behavior. It will work great for TDX. But why do SEV and others want this
> > > automatically?
> > 
> > Because I want flexibility in KVM, i.e. I want to take the opportunity to try and
> > break away from KVM's godawful ABI.  It might be a pipe dream, as keying off the
> > VM type obviously has similar risks to giving userspace a memslot flag.  The one
> > sliver of hope is that the VM types really are quite new (though less so for SEV
> > and SEV-ES), whereas a memslot flag would be easily applied to existing VMs.
> 
> Btw, does the "zap-leaf-only" approach always have better performance,
> assuming we have to hold MMU write lock for that?

I highly doubt it, especially given how much the TDP MMU can now do with mmu_lock
held for read.

> Consider a huge memslot being deleted/moved.
> 
> If we can always have a better performance for "zap-leaf-only", then instead
> of letting userspace to opt-in this feature, we perhaps can do the opposite:
> 
> We always do the "zap-leaf-only" in KVM, but add a quirk for the VMs that
> userspace know can have such bug and apply this quirk.

Hmm, a quirk isn't a bad idea.  It suffers the same problems as a memslot flag,
i.e. who knows when it's safe to disable the quirk, but I would hope userspace
would be much, much cautious about disabling a quirk that comes with a massive
disclaimer.

Though I suspect Paolo will shoot this down too ;-)

> But again, I think it's just too overkill for TDX.  We can just set the
> ZAP_LEAF_ONLY flag for the slot when it is created in KVM.

Ya, I'm convinced that adding uAPI is overkill at this point.

