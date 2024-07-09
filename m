Return-Path: <linux-kernel+bounces-245019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 177AF92AD15
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52B51F22132
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3219A2746F;
	Tue,  9 Jul 2024 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prgNSuxX"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33827186A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720484687; cv=none; b=N7UWM39DZymiGQDz5nlMmtRUn1mNP14NoFxkVx2tIoW5dw7UkHUzFkLoX9sW7yCQGxxOosmnDqba4Siu+ViQinDNXA5AHxdYAZXMcLKvu7TkB/R9bSwU+3Mbtm/k4bsZB6V/JiusSCufXj279HQal8ScS7QJf3DaUZgdabxNGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720484687; c=relaxed/simple;
	bh=ikX1ysqZqoOXa5cAnw2HENW09LRgovdR8HIOFlmOUy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SEwCDvkho51Jbsl77DpLnXzzQ2CfolN/s6G09zo6AGn4XxLkZ+HbJhRGYOudOtLmgo0xVM88wM1+Cva1mfzQZvXAEOcpeLXxnUtJUDbZXHe8v942vX20MSREgU+5ev0Vd6wF0II2jb0fCxXtzdBm96Vfg+m17YjVGHh8W2CftzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=prgNSuxX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-77f37c59abdso43989a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 17:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720484685; x=1721089485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pBGGRes1mrWQeMbELTNS4P0PcSj+YnzufefkUsBhwY=;
        b=prgNSuxX+fDiA0nm/oPLk3RBE/Iu2X5SQLOfcK2YXMB30FRq/A9CpGAYYCzVV6+c8w
         s4XXb2qgehEtQ+Mf9S1DepoAhGgM3702yRySLZxGbWGzgeRxCeGVtW15oqQny1gZKp77
         j1TCDVJKAYNp/zRBatOZe18KHUwvPiqcUxm+MGRR7KOuwvmuLqe9sncmLzyGv5cqdjwp
         5J92Z7zEycXrieSMSoMXM3cZu/y6iSnb0xh5eiL9UUdEgemOVcrucCts7M1D+JZg53O4
         8vgPXvARvFEMIam5Yoc4J8nf6Gs9eKCT2woLlQanT3UhnFeYolG5VpVBsVcTirlbxm7p
         4tdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720484685; x=1721089485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1pBGGRes1mrWQeMbELTNS4P0PcSj+YnzufefkUsBhwY=;
        b=R0n6Wy24uy8rZlKcfOJ5ZQVt70G3g40vSTbWSJlWXJNzmQE66UzTS4pkDJLuYwR/XZ
         zXRbMH6+QhB2R5nHkMMeGg213bN+Stwbi88YrnFuILiH+jRe/mWnw371yQiZ4uLbP4ji
         lsM7ieHduoEEjWrwIirEpt/3KLk3g3S4489pSK5Ul1WHj52weBFACT9+i0qzfOyk6uxk
         IbepD97I39KfgTJw5C0L/YhZp2QX/86T4A8unv6UzAIcP7KFQ4GD1DnEFpfqGGcsG8Zn
         b6maDMjlfPzpaL+1nv3+E2m40Z7F4+wmCPKnGfSQrJDXsm8rvm5+yx3JSmWrzRY2QKs7
         F+9A==
X-Forwarded-Encrypted: i=1; AJvYcCVjnx0eXm98H++ApAgVLDD3o5RFgQj6cQCnGIBwImA6MCqj3hXB3LX/0PAerTwPutyG1Lau2Wd4KsiQnhCpY6x4X0yO0iDED/5Yzwyu
X-Gm-Message-State: AOJu0YxsoCZWo9wD1/j/xCWrSYg/9Mk8eW0EUV6KZHbcpsWYETNuG2L9
	tZjFlThMwZXVW5oe1Ua75fNW2p+p9jzmvhgHO54KvKytGehVzUUK8fvT0ZHe26VoIIaYfSyfJkj
	Ynw==
X-Google-Smtp-Source: AGHT+IG+bGGkXKt/uhQFrXoIpC76RCFXg0XPeUZS5sLfx0YBtAuW/9UGDeUxjHBA2PYP+j+znBiRzqsiqU8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:68c2:0:b0:680:1416:e803 with SMTP id
 41be03b00d2f7-77dbe51498dmr2241a12.10.1720484685505; Mon, 08 Jul 2024
 17:24:45 -0700 (PDT)
Date: Mon, 8 Jul 2024 17:24:44 -0700
In-Reply-To: <2d554577722d30605ecd0f920f4777129fff3951.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-45-seanjc@google.com>
 <2d554577722d30605ecd0f920f4777129fff3951.camel@redhat.com>
Message-ID: <ZoyDTJ3nb_MQ38nW@google.com>
Subject: Re: [PATCH v2 44/49] KVM: x86: Update guest cpu_caps at runtime for
 dynamic CPUID-based features
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > -		cpuid_entry_change(best, X86_FEATURE_OSPKE,
> > -				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
> > +		kvm_update_feature_runtime(vcpu, best, X86_FEATURE_OSPKE,
> > +					   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
> > +
> >  
> >  	best = kvm_find_cpuid_entry_index(vcpu, 0xD, 0);
> >  	if (best)
> 
> 
> I am not 100% sure that we need to do this.
> 
> Runtime cpuid changes are a hack that Intel did back then, due to various
> reasons, These changes don't really change the feature set that CPU supports,
> but merly as you like to say 'massage' the output of the CPUID instruction to
> make the unmodified OS happy usually.
> 
> Thus it feels to me that CPU caps should not include the dynamic features,
> and neither KVM should use the value of these as a source for truth, but
> rather the underlying source of the truth (e.g CR4).
> 
> But if you insist, I don't really have a very strong reason to object this.

FWIW, I think I agree that CR4 should be the source of truth, but it's largely a
moot point because KVM doesn't actually check OSXSAVE or OSPKE, as KVM never
emulates the relevant instructions.  So for those, it's indeed not strictly
necessary.

Unfortunately, KVM has established ABI for checking X86_FEATURE_MWAIT when
"emulating" MONITOR and MWAIT, i.e. KVM can't use vcpu->arch.ia32_misc_enable_msr
as the source of truth.  So for MWAIT, KVM does need to update CPU caps (or carry
even more awful MWAIT code), at which point extending the behavior to the CR4
features (and to X86_FEATURE_APIC) is practically free.

