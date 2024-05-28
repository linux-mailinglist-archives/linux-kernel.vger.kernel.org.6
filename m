Return-Path: <linux-kernel+bounces-193202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6950E8D283A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8115E1C24B81
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E14A13E41C;
	Tue, 28 May 2024 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6idNiH3"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C113E054
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936635; cv=none; b=DTISS8v0aHc3kQ4L7AIRAijRZj/70ZVzLOX8G+7hvmtz/jRbDdGrdmTrSiyD/EGD6dmicpmJlD2JjHys6m1aXfpKhLzgC08ufHSAArtvWBExdrDjF+1NqGWFMJ+Ms2UgALbghA9dUguuYDQabbCtPZvQ87X+FDbp4jYO8YaUnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936635; c=relaxed/simple;
	bh=gHbpfeSgkDfVxwkYwenrZjhrUWC3V/PMjbQDgO81FQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dTjt5DMHOo+HELVI0LKyOJcc8egP2c2Sbbl1/Hn/XXCKzm5JPGKyZtRkSQyinzHRQCxyPTTIZnHN5jYfAuT105dY1ltxXlv52oqK4hML2AOCxb/N4/nrMZTBRdZXDTqIqhchNpDLneR35D1yy3wV/07uULTUV0AigAIKVba852g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6idNiH3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f8f34babd4so209107b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716936634; x=1717541434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTOH3e/EfW+pY1lF/i3FXaQ/pSIJmaxop4NhBeQiFYU=;
        b=L6idNiH37diLwjehmgo9dJ6wWrSW9rJ7seR9p+j2RMPPcVAX75e8svzoPFzRna/t51
         KM1vC5iBhZ4RAhXLnsSBdGjfXet+EZG015rWVYzs5ASva4MBXrpDfExe12GHKbX4S2rP
         fLYaICQw2lb5QdqTMVtzZGzZuj6GSzmw623mGTQDRWiHj/cKEICImwwpeO5sqoI2XFJR
         ptTr/CsuTKWuIXgiqra0KGnGHTqaKJiVCtLJ0nIVhv4v2xo5qno0f8uMmSbcl5RmNW3b
         1LkRaeEogfnX03hk4Y0yPC09gXOj9DTqf9jbp2tSyfyXfSs9sFIEkFRv3yOxKkPz2PDf
         a8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716936634; x=1717541434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTOH3e/EfW+pY1lF/i3FXaQ/pSIJmaxop4NhBeQiFYU=;
        b=Up+kfhNPMyG1McSZfbCb7DVRCBJlAooA9HIWNHGd2TvMaxhI/J8BcDzehLFGLrHbG4
         EtJv+dx1TDq4KQxXBWmXWW5Odr6LPGcSKZ5kg7ZZYRw0JuXPwgjOcBNmINzh20+PcnxF
         2oeXxQCcAnOwD+IOcpe5xGTS+jpMQYRcVCwbTfn0bVQ4PIQNv4jLkwOE8gDOVC1zZDcO
         BewcIrxXYr91DU+YMrtxdHmsapGNvD3mv1lIUNl9PD92PGKbTvCDv4bEzEYZy8Tqm0Ax
         SyHw93ZrTh+Vdm1ct+F9n/KB6irkk4LBpIG6ZUgIcUnrssSYJhWYHtPeqvmUhSsdRZQS
         kjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpjtpBuR89mzXJRlqGHw0WG/bxUQSJhCj3vb3zerV3KRrOL7z2qR57+xfhxLHLZdHq3sNKcoupGhPJ4sHbtTnmp3q8+g1SNsOUuTGb
X-Gm-Message-State: AOJu0YxIqnr98/pEXF/RvomofJXfBxj01ETC/zTa8UQGe62uEVLKnUpk
	oi99qAFAt661/V2umD1BddkK/kGuItJXcikfe86CdBKUPW+YE0Rne8Lj0BrRuxp/obFvbbFiVMm
	6KQ==
X-Google-Smtp-Source: AGHT+IE3ANcFSo4euu0zbXpca3MbcUJ+ZlvRED7hUs1VWjND6y66XDhsptVuXUjsU+9B6EI4YXgVUsKh6U8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:28cf:b0:6ea:df4b:86d0 with SMTP id
 d2e1a72fcca58-7020306b721mr1477b3a.2.1716936633742; Tue, 28 May 2024 15:50:33
 -0700 (PDT)
Date: Tue, 28 May 2024 15:50:32 -0700
In-Reply-To: <2d873eb4-67d2-446d-8208-a43a4a8aba14@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522022827.1690416-1-seanjc@google.com> <20240522022827.1690416-5-seanjc@google.com>
 <2d873eb4-67d2-446d-8208-a43a4a8aba14@intel.com>
Message-ID: <ZlZfuCI77O9wmHh0@google.com>
Subject: Re: [PATCH v2 4/6] KVM: Add arch hooks for enabling/disabling virtualization
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 23, 2024, Kai Huang wrote:
> On 22/05/2024 2:28 pm, Sean Christopherson wrote:
> >   static int __kvm_enable_virtualization(void)
> >   {
> >   	if (__this_cpu_read(hardware_enabled))
> > @@ -5604,6 +5614,8 @@ static int kvm_enable_virtualization(void)
> >   	if (kvm_usage_count++)
> >   		return 0;
> > +	kvm_arch_enable_virtualization();
> > +
> >   	r = cpuhp_setup_state(CPUHP_AP_KVM_ONLINE, "kvm/cpu:online",
> >   			      kvm_online_cpu, kvm_offline_cpu);
> 
> 
> Nit:  is kvm_arch_pre_enable_virtualization() a better name?

Hmm, yes?  I don't have a strong preference either way.  I did consider a more
verbose name, but omitted the "pre" because the hook is called only on the 0=>1
transition of kvm_usage_count, and for some reason that made me think "pre" would
be confusing.

On the other hand, "pre" very clearly communicates that the hook is invoked,
and _needs_ to be invoked (for x86), before KVM enables virtualization.

So I'm leaning towards kvm_arch_pre_enable_virtualization().

Anyone else have an opinion?

