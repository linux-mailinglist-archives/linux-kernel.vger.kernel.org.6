Return-Path: <linux-kernel+bounces-261332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D33293B5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819071F249C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B117161915;
	Wed, 24 Jul 2024 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPOMUvFg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5B515FA92
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721842127; cv=none; b=guqu+CK0KaANamCmxHgD36e+Hux0GPUtTGk+1ewTOtZj5/bXNJC4WQOEX3jxgRMgMxhkQtol88tVKS75ztQCWZn7DwjOWANf+K5EXhFduuEwRLFN/cTSR1zodFZCCQZx357LgSnV2DETxjb64E36TyttQgJQSwVreSHQQdub3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721842127; c=relaxed/simple;
	bh=Gf8NC4hNI68SCJ0Y4qE7o7qwZC2N5ZJUkUWwjBcujgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CGAgbwX3DQDEOgSsT9kXR7SQmEfiHxTE8K3zLVVrVUD27ZsMwQ54vWURZL0dkq5pCCZMnvLWtCtMwgRC1x/LCp6tOuz84ettG+xWbPjzGTrz0xcpR+h8QiEmHsXslli886p3D/sWML4g5/KPtjLPmrqreSdNBFokyM2egv7RNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPOMUvFg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721842124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6USsBwoV9M3KFY+WBK9s2N+vuzz8so6DiVIYEeyT4Kc=;
	b=cPOMUvFgZAh0L6kyiD/sL3dbZDjcjNJ6S2gECm3jHDeNtCBySVgdyON25OPW50cWQsIf0o
	85wupFztO+poMSYAiuHp0q9+r5MCB+61rJswteRwsepTIO3fD0EwjTMF0vB3uVFlk0pZ8b
	h+oovZOpfY8Fa9utHpNxIqR2nSjM3ZI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-88bvrnTOM4WZ2u18tdwCdA-1; Wed, 24 Jul 2024 13:28:43 -0400
X-MC-Unique: 88bvrnTOM4WZ2u18tdwCdA-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-70377dcee38so8283452a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721842123; x=1722446923;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6USsBwoV9M3KFY+WBK9s2N+vuzz8so6DiVIYEeyT4Kc=;
        b=Z4NkEQgTeopx6JABzJyRaXy689Vee7fXJbAjrcNkzR8ui3f0yyLMcAz9sp0sP59uZ2
         G+LQz3oUsypESDLw4m+N6NLvxwkXUSa8TElX9LB/AzUL9k097PIC6I4hjS5QbCYgCnog
         fbB8gsSBbr5IZQVRCgItFMfaW1lkNEB4kBQL9lRbYv3iqgBbU3G5cHCyqPr5GvsNuGPW
         vzrz9OZY+CQPCo+R64as0FcE+9PWUw7VkgtFnt6lH+IixaJCL9lMiLrLyB48Bm8/Ml6i
         Y26Z8Dfu+W0MGkGFFMrulvFB0uIsBDTOvzhYoIXybspv4L2JSPGUsvbRMc9yNIMJZWCL
         AUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbzfk9T6EDNRP3eoj1FIJuwE35YNYI7nzYRyiNiR0eGzECybhnd6kiZiz9VTUYu/gIWcFJKnjkD8CkSlo3HBWGz3AtkLQF3N4ovbXi
X-Gm-Message-State: AOJu0Ywe68yo1KudM2hG9Nh70aCx9ElQgjdXKMWA4vuRonp15ZV/aXqE
	pfwpYJg2zkhXAFGnXswOtLA0+2n60uSeOlRs/qofDxq73PLt5G6Qu6iqykEBuzeVzS08uTr2Teq
	7rx4EoJb2CTCyiKoe0roIlf9BmNwlj/PgZS/kC0q8BtnN/R/XhFXgQ1KkYf8cuA==
X-Received: by 2002:a05:6830:601c:b0:707:1794:6ec1 with SMTP id 46e09a7af769-7092e6ff277mr516352a34.20.1721842122847;
        Wed, 24 Jul 2024 10:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPZbqluukEE1AadcZKoCfk5TGeIyBkcAZ0s+oqYQD37sNNbHTo5lIDWZdKiIUpa/Tftdljpw==
X-Received: by 2002:a05:6830:601c:b0:707:1794:6ec1 with SMTP id 46e09a7af769-7092e6ff277mr516336a34.20.1721842122559;
        Wed, 24 Jul 2024 10:28:42 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19905a909sm595995285a.73.2024.07.24.10.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:28:41 -0700 (PDT)
Message-ID: <3aeeed2f4ccca6ddd404553984f22bf1b72e45cf.camel@redhat.com>
Subject: Re: [PATCH v2 05/49] KVM: selftests: Assert that the @cpuid passed
 to get_cpuid_entry() is non-NULL
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Wed, 24 Jul 2024 13:28:40 -0400
In-Reply-To: <Zow_BmpOGwQJ9Yoi@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-6-seanjc@google.com>
	 <6a8aee9425a47290c7401d4926041c0611d69ff6.camel@redhat.com>
	 <Zow_BmpOGwQJ9Yoi@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-07-08 at 19:33 +0000, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> > > Add a sanity check in get_cpuid_entry() to provide a friendlier error than
> > > a segfault when a test developer tries to use a vCPU CPUID helper on a
> > > barebones vCPU.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  tools/testing/selftests/kvm/lib/x86_64/processor.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > > index c664e446136b..f0f3434d767e 100644
> > > --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > > +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > > @@ -1141,6 +1141,8 @@ const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
> > >  {
> > >  	int i;
> > >  
> > > +	TEST_ASSERT(cpuid, "Must do vcpu_init_cpuid() first (or equivalent)");
> > > +
> > >  	for (i = 0; i < cpuid->nent; i++) {
> > >  		if (cpuid->entries[i].function == function &&
> > >  		    cpuid->entries[i].index == index)
> > 
> > Hi,
> > 
> > Maybe it is better to do this assert in __vcpu_get_cpuid_entry() because the
> > assert might confuse the reader, since it just tests for NULL but when it
> > fails, it complains that you need to call some function.
> 
> IIRC, I originally added the assert in __vcpu_get_cpuid_entry(), but I didn't
> like leaving get_cpuid_entry() unprotected.  What if I add an assert in both?
> E.g. have __vcpu_get_cpuid_entry() assert with the (hopefully) hepful message,
> and have get_cpuid_entry() do a simple TEST_ASSERT_NE()?
> 

This looks like a great idea.

Best regards,
	Maxim Levitsky


