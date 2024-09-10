Return-Path: <linux-kernel+bounces-323850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551A6974435
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30C61F27531
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE641AB512;
	Tue, 10 Sep 2024 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3Q5nrco"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FBE1AB519
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000923; cv=none; b=aAEaO1UDfrJtfLaf/MfKRnGZATF5T1/xNri0b68R5Ru/QpSgvpBfKDf8oAKnxBhFuz3DtRu8aRsrK8TIMCx0TKHnUpx7pg5MAODaDIgQQm3mUb8voxvOM3DSNpzN0Kw37TwslhUBQOGXTtuXCCHU51K6Iui6z4+PMZt5QSztMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000923; c=relaxed/simple;
	bh=/B6ktjls9e8sahrf4f9YjYTnkS2AyJU2YCdJDde3Pcw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rq+iwAq9qw/hHSj8I1SWHID9sGZRIgjKNHfraDP5DxwvzQ+k3VbV5uxcjntKd/ahoue6EqURcqqZQVt87DBXg6vFGINYaA50Gj1R6LzX9wcroNZ70f690KXSP9QXoGX4tNl5mJ66a0DTkUAfAJ/vxtSk0jDrDsvEPuDWaS+a+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3Q5nrco; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726000921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXWc8YwViA5zWo54WjIEfGW+8+5CIqabuJJ/r7VO3GE=;
	b=T3Q5nrcooMM1ZL+n0wtIUqQLFNVhcGZrKQhR4gXScw7d58K8w9dkGwM/Z6d9lU42aKfVWv
	FtVlLjGINfA35YGdAlVCffvjVDR5jJpij2a+wx4p4p7X/W31kgtt/bI31FMg/KwA/glFy9
	UPtHiiXfO+KGTapMH8vfCeWhgEugMes=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-q8orGefQPUaeSCUIOLGVoA-1; Tue, 10 Sep 2024 16:42:00 -0400
X-MC-Unique: q8orGefQPUaeSCUIOLGVoA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4582e9502bbso30530941cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726000919; x=1726605719;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXWc8YwViA5zWo54WjIEfGW+8+5CIqabuJJ/r7VO3GE=;
        b=UxrjibsmN2xjFg72TVrQg2D9fGxC5Kiv49dZfGYiuza6E5V9KJLurBMtFMfXq5oeFx
         gcehC1dDgpcRf4oLOJjIdOMN+7vFE3LNojXyzSFsKV3gxNcFhqgq3W1/77r+08G1zvvp
         XzK7b9rmGKA1V+e163vruCG1MM3FojCUOPQsWNWHAzke2d3k8NV4BAzrz+Do8wYLGys4
         hWdTTykxAoVKBbcgfIa6zfxunepRkNkqduV6rkbUYttWgQLeors9jGkB1fO58ojewGbK
         XmfFv4OjecpPCyf623Mt/VRTDyOmoZj5qqvdan92QoGjo3I/FznILlo61EoCvYcfyZ0G
         unlA==
X-Forwarded-Encrypted: i=1; AJvYcCWCpn2xqFhy7QmARV/4G623CFOC6Un+EFWbgbiYyfj/Eo134dlA79SvaW9mj/sj+Ph7enpfYLRhc3AjssE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+BCP+Lg6s0o/yZx3XobdZFx9Qr6HZz47ZrTGR4dDVsE50WM/7
	obJYoG64gM7U7hzKtpFuTrjTVqcEw+fmzpK1UH9X0Iaqad2qLGkSyddqyqcjlsEQLTDAbLYCLgy
	eT7wYplAR8m3IbFelu74kOsBLuTEoryzPmXxyTvuSF4MFT8WvtBMUSM+0bjDgjm8ZqE5oCOTF
X-Received: by 2002:a05:622a:18a2:b0:458:2c40:e08b with SMTP id d75a77b69052e-4584e90021bmr10728081cf.30.1726000919655;
        Tue, 10 Sep 2024 13:41:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6g4A4JvYd5H/gkbWbjJoXbDr6NCaKNFVqZ4P3NxyUw79k0kFE23eV1CPcOhxAh3JabLXj7g==
X-Received: by 2002:a05:622a:18a2:b0:458:2c40:e08b with SMTP id d75a77b69052e-4584e90021bmr10727791cf.30.1726000919292;
        Tue, 10 Sep 2024 13:41:59 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:760d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4583636e38esm17482701cf.33.2024.09.10.13.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 13:41:58 -0700 (PDT)
Message-ID: <b9cf0083783b32fd92edb4805a20a843a09af6fc.camel@redhat.com>
Subject: Re: [PATCH v2 44/49] KVM: x86: Update guest cpu_caps at runtime for
 dynamic CPUID-based features
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Tue, 10 Sep 2024 16:41:57 -0400
In-Reply-To: <ZoyDTJ3nb_MQ38nW@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-45-seanjc@google.com>
	 <2d554577722d30605ecd0f920f4777129fff3951.camel@redhat.com>
	 <ZoyDTJ3nb_MQ38nW@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-07-08 at 17:24 -0700, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > > -		cpuid_entry_change(best, X86_FEATURE_OSPKE,
> > > -				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
> > > +		kvm_update_feature_runtime(vcpu, best, X86_FEATURE_OSPKE,
> > > +					   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
> > > +
> > >  
> > >  	best = kvm_find_cpuid_entry_index(vcpu, 0xD, 0);
> > >  	if (best)
> > 
> > I am not 100% sure that we need to do this.
> > 
> > Runtime cpuid changes are a hack that Intel did back then, due to various
> > reasons, These changes don't really change the feature set that CPU supports,
> > but merly as you like to say 'massage' the output of the CPUID instruction to
> > make the unmodified OS happy usually.
> > 
> > Thus it feels to me that CPU caps should not include the dynamic features,
> > and neither KVM should use the value of these as a source for truth, but
> > rather the underlying source of the truth (e.g CR4).
> > 
> > But if you insist, I don't really have a very strong reason to object this.
> 
> FWIW, I think I agree that CR4 should be the source of truth, but it's largely a
> moot point because KVM doesn't actually check OSXSAVE or OSPKE, as KVM never
> emulates the relevant instructions.  So for those, it's indeed not strictly
> necessary.
> 
> Unfortunately, KVM has established ABI for checking X86_FEATURE_MWAIT when
> "emulating" MONITOR and MWAIT, i.e. KVM can't use vcpu->arch.ia32_misc_enable_msr
> as the source of truth.

Can you elaborate on this? Can you give me an example of the ABI?


>   So for MWAIT, KVM does need to update CPU caps (or carry
> even more awful MWAIT code), at which point extending the behavior to the CR4
> features (and to X86_FEATURE_APIC) is practically free.
> 


Best regards,
	Maxim Levitsky


