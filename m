Return-Path: <linux-kernel+bounces-185527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF39A8CB64B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CC61F21C62
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9777149DFC;
	Tue, 21 May 2024 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sO6x8+ui"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5AB36134
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716333410; cv=none; b=Dh1brHyu7yBHbUIdUsfLs21/XhWku2Yfcs3+ijxw8G4bT4kZUiPhVURgOcstrzP4u0Pqw9J0YcasHOxveBATdKoV2dkJgDG8vw6Whpim5+pJfDw4F4RrF5AAd24QB8Z3fAqiK3goRkFG7UXSyX0tV/4cpFyiMQchiPc4TdhGZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716333410; c=relaxed/simple;
	bh=Ry2b6kPu+p8kFrAdVbxwjoeTuHCP60XH1ZnfrYTGACg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gz3hCiku9N1BozFebTtKDax33YuCJ06qoIecWQPItzmZLVuh0GWIbPJFVSLOEkrlev30EO2M6J6UUOT6MkCHqD7zd4c4vxzND/5gR7jXZyIY1iSHQflt+90vsuHpx4xcsSl59Zno3hp+6sYw4jjAbWir3xZ4dRUn3gHhMaABxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sO6x8+ui; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-61cb5628620so13228837a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716333408; x=1716938208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWx4tDap5TnZgWN5L1koc75NADyLaUKfEEEhuyV4lik=;
        b=sO6x8+uicoxNklsL2/aYHgIbUc7fISL8tdierG5vn525pY0EBb/36Y87Lg6ztoDkqW
         8fbVmUdn3cRbOB036HaCtrARvhgXCWmE68MAhJW2pTRnHN0GU33tWelogC/f9gw732VX
         kBBtcyBbn0Jr7vUfj4UtOWMjv6D5kxIu6aUsSgStMqV1eTaWLjaeI2Zq8IvSPuJGi/x6
         61poF7EXA4PEOV5DGK1GdalVBBg3RpatoxxeiGIpt8XKWnD7NcXvApC5JxKxEoIpgzBE
         RDzgcTlVZ8e8tdCcScO54UqdP8V1d6988RjbFHmUzmUtZZw+3+6tWax3Q8QzgcUEq39n
         NvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716333408; x=1716938208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWx4tDap5TnZgWN5L1koc75NADyLaUKfEEEhuyV4lik=;
        b=JVmViI7q1nt91glGT0L1x2RhiHiOovpAlpt1X1+/eRTyBlw7h7Rf/M0nY2oY+avOA2
         Ooaa8U7oLuHTIJX1fIp07xSSaL9DksbwhvdUSUPPYGuJwF5xQ7yY6q9Lv4PFBFnCTbWr
         v/QYscoqc/GetBdz2wXZLK5FrS9NiZHQ2RQmASZCvnX5UmP3slkZPek6NV7xyttW66tP
         9jkAGW/62WC5andNpHYxIpgJVfM72MEATpNuogFeqEN+8PeYLs1MuKuQW0chBdsBuGMC
         UiyUuLRY403JAlAJcxZ4J7J8PdSbw1Rxv9eodfyLCrLqRv+9O5zAPtk9C8Iaj+7L/hj3
         Iz6g==
X-Forwarded-Encrypted: i=1; AJvYcCWR48/hNYsIQcNKqsZQOicP8vUP9zSPuX04lgqOUDWsWZ+58ol2HMrtAuz+ByBZj2xvekzOWyDcCrZ4X3pvuqEcWvP40A2QyLBrvBvt
X-Gm-Message-State: AOJu0YxKLqR74mDIb4l8/EAXZT7dnCs1X7hUIX904NBsx67iV0AOyI94
	fH7uJCxVupMiGg2EgFSg3dn2hYaODjslgOH+6zuoziETr+Dc8xF7Bos5q2b19yIqT1CyTrd7PzK
	Yvw==
X-Google-Smtp-Source: AGHT+IHnzE+ZthCssIlHmxg20CnLlKr6bsQKxZ55A80mzM4vh3TMlx+g+JnYoV4TUMf74JNjUWU33z9Lcwc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f7cd:b0:1f3:97f:8f13 with SMTP id
 d9443c01a7336-1f31c975cd3mr10815ad.6.1716333408149; Tue, 21 May 2024 16:16:48
 -0700 (PDT)
Date: Tue, 21 May 2024 16:16:46 -0700
In-Reply-To: <00c59dce-e1e4-47cf-a109-722a033b00d8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425233951.3344485-1-seanjc@google.com> <20240425233951.3344485-2-seanjc@google.com>
 <5dfc9eb860a587d1864371874bbf267fa0aa7922.camel@intel.com>
 <ZkI5WApAR6iqCgil@google.com> <6100e822-378b-422e-8ff8-f41b19785eea@intel.com>
 <1dbb09c5-35c7-49b9-8c6f-24b532511f0b@intel.com> <Zkz97y9VVAFgqNJB@google.com>
 <00c59dce-e1e4-47cf-a109-722a033b00d8@intel.com>
Message-ID: <Zk0rXkXkchNnRxwQ@google.com>
Subject: Re: [PATCH 1/4] x86/reboot: Unconditionally define
 cpu_emergency_virt_cb typedef
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 22, 2024, Kai Huang wrote:
> On 22/05/2024 8:02 am, Sean Christopherson wrote:
> > On Wed, May 15, 2024, Kai Huang wrote:
> > > How about we just make all emergency virtualization disable code
> > > unconditional but not guided by CONFIG_KVM_INTEL || CONFIG_KVM_AMD, i.e.,
> > > revert commit
> > > 
> > >     261cd5ed934e ("x86/reboot: Expose VMCS crash hooks if and only if
> > > KVM_{INTEL,AMD} is enabled")
> > > 
> > > It makes sense anyway from the perspective that it allows the out-of-tree
> > > kernel module hypervisor to use this mechanism w/o needing to have the
> > > kernel built with KVM enabled in Kconfig.  Otherwise, strictly speaking,
> > > IIUC, the kernel won't be able to support out-of-tree module hypervisor as
> > > there's no other way the module can intercept emergency reboot.
> > 
> > Practically speaking, no one is running an out-of-tree hypervisor without either
> > (a) KVM being enabled in the .config, or (b) non-trivial changes to the kernel.
> 
> Just for curiosity: why b) is required to support out-of-tree hypervisor
> when KVM is disabled in Kconfig?  I am probably missing something.

A variety of hooks that are likely needed for any x86 hypervisor (especially on
Intel) are guarded by CONFIG_KVM.  E.g. the posted interrupt vectors (though it's
definitely possible to use a different model than KVM), the entry point for
trampolining NMIs (though again, a hypervisor could just do "INT 2", at least
until FRED comes along), and probably a few other things.

I'm sure it's possible to workaround any issues, but I would be quite surprised
if out-of-tree code went through the effort of functioning with a kernel built
to play nice with KVM.  Who knows, maybe I'm entirely wrong :-)

