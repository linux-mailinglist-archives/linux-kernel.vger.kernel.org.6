Return-Path: <linux-kernel+bounces-182358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509EA8C8A35
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9DA281946
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC43B13D8A7;
	Fri, 17 May 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pU5YeO8H"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231913D625
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715963893; cv=none; b=YY2HjZJneERVk+RFtGl6H0i9PbJSAKGpFdpjLikkr5iqVxjDlmNX+WajBnIrQzargE2TcK++JMUi/a3x9uYot2YzPyRGokyyBuFiHl4FmxU/UdQ4fm72h5I/PvWs5kM/y7N3rlWZkmMHS65w0DfnVutoza8iwA4CNud+OfcSbIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715963893; c=relaxed/simple;
	bh=BZ1BDAxsb+ELKe8160sLktY1ER4EDr9oqSJLPNna2NQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UgFrtJMXldaNll5Eno1cDVTbqc0Hfr6LXkh/CQBZ9vI7UV7ihSgi9LcWZNQcRD/quZsv11hwl8V42lCsNkX4YM9TBQq2YVmNU/0kmArByl5VkZN+3lWujydgDo9cQJ1P96wO/MQMzuLN6p/x/4Yz2b//NbWsCv61Dw2Lu9nrrUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pU5YeO8H; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de468af2b73so16890793276.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715963891; x=1716568691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Rmi2OkZMH5QZdYYuvCphZHTTfn19TkxZp9MFoDCGOE=;
        b=pU5YeO8HBmmq2U9vMvOghGJOaIv/d4XyZQZIOvKUiBjt0BqM7u7AAeQFlYVbFxQtqq
         fTe3n9T2jbMya3C1Ucxg2yT1JMsB0AeBGyrS4aY4k7GCSkUcH9NIrRPj9KNR4GFCvKz5
         bo/VzHBUeuRgUDlQpDAARIGlV1pJbwdTpz/hK+VgsvGticz7qCXjbNt2wxcI1s9s2TXF
         S3Ip9qCpzcHf46DcBB3h0Ccr4xGIg1sjJV9If01InXcpmSF/nkSn1Re+r83mPrLjHA6r
         cwuSgzWHh61G+tepkws/gNbpAlvtlpkBpxM2qRUVLLOWQfJQLY/KUl7nVXJLFwHxMMVs
         KNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715963891; x=1716568691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Rmi2OkZMH5QZdYYuvCphZHTTfn19TkxZp9MFoDCGOE=;
        b=bMcZrNnNMSS57hi4s6rX3ij8XT2Y+o4wnXRZ6hh1YQLxbs4JPOa+lNYhWAY9jr82j0
         IhmnISz8EYGtVTS3bRFl0I99unQ+92TsdsCUs98ZXOZ+G7FXqiaRFR155m0+5KgXhJ7m
         3GNw9qUo878EooX3uAW4/mfnSVy1krpNb1tVxqlgDRcg2krqWvn6Z2+ryFlMSuRxYj7L
         8TRuMM+4T9qE8h3QmzugR3fzFb8bXz/wK8QPkosdyxeSccV10NQOPCjc7hmfEc5qC0bR
         uXUUY8nIsQwkZH2VXlvkzXUoM8ohlhKxtIkP7ySX/jxG/CVpMeBwCp0DaGgD5HxA+1jo
         0Zmw==
X-Gm-Message-State: AOJu0YwMiHJJ/2ptUnXG2aNrLxVzmy4EGAiS4zxNUr7dGXK8OQJgezxa
	2bENgTtZGZtgE7rAZp4q3QyO4EpgvbMuxPfkuG9tdgkfko4DHbG5lD0D7iNhUW1zlnceyJCRMhT
	W7Q==
X-Google-Smtp-Source: AGHT+IF/9Aa72Ydb5eP7L+GfU+usv8RTuvVFoLdOPlX0aPRURze+Lq0YYeF5kTUSbmO7ywgdiRN2J9qpQoI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:18d3:b0:de6:16d6:2f34 with SMTP id
 3f1490d57ef6-dee4f2cf908mr5519340276.1.1715963890888; Fri, 17 May 2024
 09:38:10 -0700 (PDT)
Date: Fri, 17 May 2024 09:38:09 -0700
In-Reply-To: <7c0bbec7-fa5c-4f55-9c08-ca0e94e68f7c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507154459.3950778-1-pbonzini@redhat.com> <20240507154459.3950778-8-pbonzini@redhat.com>
 <ZkVHh49Hn8gB3_9o@google.com> <7c0bbec7-fa5c-4f55-9c08-ca0e94e68f7c@redhat.com>
Message-ID: <ZkeH8agqiHzay5r9@google.com>
Subject: Re: [PATCH 7/7] KVM: VMX: Introduce test mode related to EPT
 violation VE
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 17, 2024, Paolo Bonzini wrote:
> On 5/16/24 01:38, Sean Christopherson wrote:
> > On Tue, May 07, 2024, Paolo Bonzini wrote:
> > > @@ -5200,6 +5215,9 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
> > >   	if (is_invalid_opcode(intr_info))
> > >   		return handle_ud(vcpu);
> > > +	if (KVM_BUG_ON(is_ve_fault(intr_info), vcpu->kvm))
> > > +		return -EIO;
> > 
> > I've hit this three times now when running KVM-Unit-Tests (I'm pretty sure it's
> > the EPT test, unsurprisingly).  And unless I screwed up my testing, I verified it
> > still fires with Isaku's fix[*], though I'm suddenly having problems repro'ing.
> > 
> > I'll update tomorrow as to whether I botched my testing of Isaku's fix, or if
> > there's another bug lurking.
> > 
> > https://lore.kernel.org/all/20240515173209.GD168153@ls.amr.corp.intel.com
> 
> I cannot reproduce it on a Skylake (Xeon Gold 5120), with or without Isaku's
> fix, with either ./runtests.sh or your reproducer line.
> 
> However I can reproduce it only if eptad=0 and with the following line:
> 
> ./x86/run x86/vmx.flat -smp 1 -cpu max,host-phys-bits,+vmx -m 2560 \
>   -append 'ept_access_test_not_present ept_access_test_read_only'

FWIW, I tried that on RPL, still no failure.

