Return-Path: <linux-kernel+bounces-192890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBE18D2394
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0663C1C22E56
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D1E174ED0;
	Tue, 28 May 2024 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvKLadwi"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB516F8F0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922607; cv=none; b=s0b91mSkQuepBf1RbjiPQ47y0cWtLAbx2+ESTKwAVSP0GVpNVCb13suKiakapqVsEQd7G/UMw0Af49cPNvGCebpzx1xIBBfcwySOJuPdd35F7kRMcnt3ZPncG6BfgXFBt8JT0BxptR/4OY+DdYpuG63gQ3xRhb4MiRhKnqUWq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922607; c=relaxed/simple;
	bh=7VzGZDtBSooFkxUd9OAZGtectfy+uwG4/bUmSmiL7y4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hqIWXWJQfI1HjOGrlzIc2AAKx6+A0cX9WuwLChiBTvE1cuaH9GHMv7D2aNaEM1+KKVkknB+Coy4FqAYWcGEjy5Xa/U9fREgFByT85xrAq0vhhNd7hrnf4XXQjuBRKXBoyonFev6PT4ykG2TKSVvV5K8wAlbxMTELFSxyLrzyWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BvKLadwi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2bdf44bdb46so1087979a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716922605; x=1717527405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S4Hp5OPdGF5QAC5ejV2ec7ZNjyRf7XQzcBDRWuz3U2Q=;
        b=BvKLadwiu1EUp6B/W7QzDf0vC1qmVA4xA9GlGAhJTIYmUKR4aXx37KdHJfazVVcYXD
         LLY9oCg8xuQPAia6vvNwmi1CCDxqQJSO1yTVcISCtOoGx9SDFcCC/IP48sK3kwIWB5d2
         DgdKyyPXggomEr1PFGIzaciu026AyQHfCJvMeigaEaxyk3QadlQnJD4B32EX5d+6Otxx
         tzwLKy0NSNrGJ+3tkXscX7t3VocrA/StXLCGgiqbAerBwXMNqGREOfD/GX+pGSr4jRQm
         5z8kyuogd933XlZzGOAeuaAf7Y76xitBVzPHskHuqoJ8rksyBLfnOwwVb23u7//VuZbo
         4Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716922605; x=1717527405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4Hp5OPdGF5QAC5ejV2ec7ZNjyRf7XQzcBDRWuz3U2Q=;
        b=KvfwMjNVXx8plq6qiO71u930OS/GnPtIZD0MkqNXo3L7CGUSmCceMxUkdhRColYD1l
         sJy+pQckY2lN8tXZxh3X+G++aBvN5VvrRSvn6/A9jVfnsCA98jzrgj263baX1aYoEJDM
         WBzv24l/gSAmqtQqbPovQpKMDpd26OYs+ESsHpCRgqZYKTpKPk8pi238rf9jeIs11CjR
         V227aBjInlSnrdO3IfMaa2DnF90n08TY+8IVaP2gkQgJHBgIbFjYJ2yJ5fAcT5R/kqXl
         GhL63AgNRGdKCHl1oL8MzDRsOORWw5PwhCO+MG63+eiu3KmngrjWr8GsURfKt2QyU01A
         T2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXGUJTN3a+FaKNRAbAfRYPXfIdK6B667nTaCCxa42lWGG9DOFML0pF8uUzFmsnUGN2Uvt4Z5GlsC3hMfsX67rJY3EmRJHxmPZCPa15u
X-Gm-Message-State: AOJu0YzMX2Z+HGbT1Ga6418jC1KalOoZ+vpQ9MIVnbLoldmycJAbXYlg
	DHgrPCYHilJ/59qZsvZUf2OqlL07aDkcxeBPyzAkasqGJZO3iU7xPeCGIlKoFRJNpizrpSpaCPS
	Baw==
X-Google-Smtp-Source: AGHT+IHoqr+ISQcH8/FCagbfJ2nL98ZUcD/8qvK2Uon7Hq2ULc+/vLDNTGE1sbxP/IfziOZcYq1e9FeGTCM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:19ce:b0:2bd:6abb:e9f7 with SMTP id
 98e67ed59e1d1-2bf5e09d490mr35783a91.0.1716922605104; Tue, 28 May 2024
 11:56:45 -0700 (PDT)
Date: Tue, 28 May 2024 11:56:43 -0700
In-Reply-To: <18f52be4-6449-4761-a178-1ca87124c28d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-13-seanjc@google.com>
 <18f52be4-6449-4761-a178-1ca87124c28d@linux.intel.com>
Message-ID: <ZlYo67vO5JJ6aCAK@google.com>
Subject: Re: [PATCH v2 12/49] KVM: x86: Reject disabling of MWAIT/HLT
 interception when not allowed
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 22, 2024, Binbin Wu wrote:
> On 5/18/2024 1:38 AM, Sean Christopherson wrote:
> > @@ -4726,15 +4740,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >   		r = KVM_CLOCK_VALID_FLAGS;
> >   		break;
> >   	case KVM_CAP_X86_DISABLE_EXITS:
> > -		r = KVM_X86_DISABLE_EXITS_PAUSE;
> > -
> > -		if (!mitigate_smt_rsb) {
> > -			r |= KVM_X86_DISABLE_EXITS_HLT |
> > -			     KVM_X86_DISABLE_EXITS_CSTATE;
> > -
> > -			if (kvm_can_mwait_in_guest())
> > -				r |= KVM_X86_DISABLE_EXITS_MWAIT;
> > -		}
> > +		r |= kvm_get_allowed_disable_exits();
> 
> Nit: Just use "=".

Yowsers, that's more than a nit, that's downright bad code, it just happens to be
functionally ok.  Thanks again for the reviews!

