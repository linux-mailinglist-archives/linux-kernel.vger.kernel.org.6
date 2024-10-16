Return-Path: <linux-kernel+bounces-368758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD369A1495
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FFC2844EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD11D2780;
	Wed, 16 Oct 2024 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNxerzC6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D335478E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112758; cv=none; b=s4TLyt6EC7lN/PVXc6N/QgfgkiMw7IJ/LUpzaQFwtxcQfHPKvh7ZpE4gLeaJ/fDcf/3phXX1SUUs07wT/6s9OPcruuwVGN9s0X/ID4h7BqtSxF3PKN2SBw463ai1zCEJDdGyxMMc750souP6WpMtbNViV48xJyoNLM3Att6WBPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112758; c=relaxed/simple;
	bh=WZW00TKTaoemSd6JPBFYlmG2IMjRqCAXZEuW81RfWK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mHcKqtF0wCKo+8ZBloGxeny2e9XUGwucgkEDaoY/0RDWUa0JP5kJVRAsPvRqPpEfRHxThl7CdAYL4EOjeG5r9EVg4MKsPgpX0AEQlP598RGel8XiYCLSpkPv3KGOdjJDmWs4VZWFzI8RcD8SouDTFpbOnmJDD6/owV1S7mrp4Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNxerzC6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e38fabff35so7519467b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729112755; x=1729717555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc2AnrLM2UF0S090yPZTAZNfP2OSi9FUUhZDFa9DYsQ=;
        b=VNxerzC6t86Yym04K1aLDj6fmY8rvympoix6EPXdefK7Kk8UuWLz85DhDdQwBigCC6
         BziXr/ASvqBnecGBfYUhwOuiMsGGH6oWN9bnRp8354Dz/BbneCVB0HN2I0e1SZgBFr06
         WyILTpfQeX7z4t0NgKadFfyAu2dWQFNmDAo41XpBCg4PX7xsaBMpWj5p8POgSlAXMC5b
         25yGOmc7sZjyNdk8P5sr/Tjs7lcgAjjksfQDc/chg/TxvVHtoiTHeDH1uT0GMmx22gl8
         JFFrrcL5aM4auvQ4X8OpSfXzTw4vY6vX572Zg2LH+d2Pn7e9xgHUYaar2h5nOtpgQhQM
         uKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729112755; x=1729717555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc2AnrLM2UF0S090yPZTAZNfP2OSi9FUUhZDFa9DYsQ=;
        b=Ab7KNNAxfKG6u0lynnoBOgClGl/pXgJHYzxtmoFoo0KftLJfbmU5E/jvmWBTwFg9pc
         6L+hXXqo8nTGDesOisd1Vc/LvYyiXPVgFOnXOQmwt3VdjRL3/l78bZaMszmgonJgUUrw
         39eT+EhoUTsY5TZqtOaUj4ayN8HNhJkkNM4ToSIFtNR3qGaZXJT/a1bQp84+13yvSY0Q
         PjT1A9xV9Cv8Oj7X0dderOm0MGKUyCDbOccTnnxXITCw4A37xNGJUPEcLKVyJAMt0DMd
         SN2n8hgnakPSggiWicm3GAsEQQ4zXsvRhBEyx2db0dNfnIyYdRhDi8p2pZgAmddRmCEp
         CKiA==
X-Forwarded-Encrypted: i=1; AJvYcCWCa5uaJbUIgDlFB+bCmYY71t8GqkJkp9iKklElYHG+xgTnk7Et704DTQNQ7Fmx5MCAiYKK0x+AWWdNoSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRuZCaK8cYejNY2cWLWoEwna2WV21BDJQ8hp9YaDNSsKdrEO6K
	OjRwpCLlIKpzKVmMOyFgrx18PUAHv12npFi+7BY7UAIKC211DZQHyyuFMo3zAXE73fPdIDQaQM2
	hZg==
X-Google-Smtp-Source: AGHT+IGkf38vmY/wJdMjW1LCURxYE7Ec+J9yr0i/d8iGrua/q+lp0G6QiUUZJgyY0LEomNIZeY0ALfUpKv0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:f407:0:b0:e1a:6bf9:aa83 with SMTP id
 3f1490d57ef6-e29782d5fa6mr5916276.3.1729112755243; Wed, 16 Oct 2024 14:05:55
 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:05:53 -0700
In-Reply-To: <20241015195227.GA18617@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240927161657.68110-1-iorlov@amazon.com> <20240927161657.68110-2-iorlov@amazon.com>
 <Zwmyzg5WiKKvySS1@google.com> <20241015195227.GA18617@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
Message-ID: <ZxAqscbrROD1_szG@google.com>
Subject: Re: [PATCH 1/3] KVM: x86, vmx: Add function for event delivery error generation
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, jalliste@amazon.com, 
	nh-open-source@amazon.com, pdurrant@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 15, 2024, Ivan Orlov wrote:
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index c67e448c6ebd..afd785e7f3a3 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -6550,19 +6550,10 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
> > >  	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
> > >  	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
> > >  	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
> > > -		int ndata = 3;
> > > +		gpa_t gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
> > > +		bool is_mmio = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG;
> > 
> > There's no need for is_mmio, just pass INVALID_GPA when the GPA isn't known.
> 
> Ah alright, then we definitely don't need an is_mmio field. I assume we
> can't do MMIO at GPA=0, right?

Wrong :-)

From an architectural perspective, GPA=0 is not special in any way.  E.g. prior
to L1TF, Linux would happily use the page with PFN=0.

