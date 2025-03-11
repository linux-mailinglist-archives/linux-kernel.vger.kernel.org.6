Return-Path: <linux-kernel+bounces-556224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9AFA5C2D2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACB4174147
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FA1C5D77;
	Tue, 11 Mar 2025 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8ackYSB"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE445680
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700223; cv=none; b=UzbgtrwH8QX2CsL3XzeqMhGQg2Jjm+3CNfZ2m0jobf6JBeFLvUGhIarI2Qy0K3PDGQVuJV7U1TIE8sYCu6x0bU3qcotRBT1UtyqRh7oMGI+Yj1tZLA+A3ipEdy2wDLT+FoL6CPvuctUDucp7mAcHy19JQarq/tyO9915On9y1RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700223; c=relaxed/simple;
	bh=y/QQH6mqm+8Ho9Aa1K99xXG1QESr4asCjdKr3JIx2Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwJFaOQ1CFwduyzFUoDGHMfxr7nDgAHuopWyztNSiqNK28lzjJVgPk/f4/3CAzTuv7oJ04sCnJwk2SdoujqfxBCoO693pWdvgq0kYJJJviq0jhMkk/t3WpzuWzOyYBZFvPNXWrqltlXufLVUJIZfKy9BiXwHlj/gehQpEhta64U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8ackYSB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe808908so44835e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741700219; x=1742305019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIICvZUAuF3f8dZklYxLa0v6cPMJSO6jrRsSfDmTFwU=;
        b=o8ackYSBoySwe7rxifFc0DflvVtOpEQHI5aGJhbk4xtqvv41wH8H3JmCxeWUdO0YsT
         6klLwzF9S4qlVeKHOLK45ePhPc0se8QTwAbWytvnWB/7EDIjallMbordAsAEpD+TCqeN
         I87kSHRXB+OG/5H3fxtqIl9NJwGrhz/mq1WQn/NlB5TXl73+3tsUNq7KnqDZsCcyJj4d
         kbOP+usR1/6D5Vmp8dwoRNM38KpNmeDwfMDC1/55zIm0jafqNtepVgWUCvNnn6wARrgV
         7oHm+8LXyJdUaPgS3xPvEblUTtr6bkyTaWBJG1UoeOJL3TbD+O4H7qZi0VntPxkcfqEv
         pdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700219; x=1742305019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIICvZUAuF3f8dZklYxLa0v6cPMJSO6jrRsSfDmTFwU=;
        b=EYiWAaF8+wVResCW0ktk3JL4Rl/O2SHgfCzH6keNmrSButSTZA7g8k8kMY5CXaLwq1
         +mQrF19Kxs5nK2Dh/kweZUty1urRZ4YYFaFoWjGkZqKlqPX4mXnJ7H/iGSpA8fZScC2D
         1k1WG+1gEtRmXZO6fzB4dM1Of+rFcp7jElqcfQ4eXrg6vSaJdK7NEU4bRwYVZ8HVQjRk
         k6cj+DiaUHTW+qHlJMuEdhq3fAOQsZxPiXseyUu5huoN3A5XMUUtVWuFlxEkRvqTPZwE
         S1ueouuwTV0kUZIFUTFji5K6tEk7HluGO6QFi56uluLMaxFHfYY0tcaorbmvNGw5Btpe
         FSNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7fj9zhlSx10oWO2kkhddegF1FRVZ32bDjGK181tHsSkP68u30xURhNw6BXUZADKZIE2TzEj/fdDXFmqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybK2DzKfreGGk+IZ4ieHPCncWpKBjjzAS4NITNt98IPNLC6BC5
	sRqfVsP5EydmH+MRNd7cAuCRk3Rz9+IqoQRaVTAliTD0SWa0VdXsZ1+A6b7WmQ==
X-Gm-Gg: ASbGnct2XI44ZKPeGPTJABoN0XKouQTk+Mpf6FBhy5aw1txx0MoPR5cOqN1ihcp9Eeg
	cH7/3sc22S2g2Is1RppF6+fKFJcfZOvIRxokOy0aDi7LL2hFPeiiI0jzfc7IApb2je5HMKWLZUu
	uANx5ctpkXSN3+d2YBq94I9afPHHetVVQNf177Vk/Qs35HPThtQ1eF5c9NqW+ejfJ/LXPmMEhH4
	zI8F9Bcf8V+ziQOqJV9rxb+FGeTZLd/aUIBs+xy8Jvf/3VNssWEZ8rRr3JlVSYT/xcJIECQw0P1
	FkkyHkrQuJ4v+XpQeJNqSTkZCuaThYXTkbhJAvdZM3/pAKGvqo4+P8+u9hmCSMZClf75WDEGQIO
	gsV82cyk=
X-Google-Smtp-Source: AGHT+IE85f6Sug78tXLPKOdprCo2ei71bex/CBY062wy6JnIWa+O1MeYF2KGYxUN1KWTV+KXujzTgA==
X-Received: by 2002:a05:600c:6002:b0:43b:c744:1b39 with SMTP id 5b1f17b1804b1-43ce90989c3mr4155125e9.1.1741700219431;
        Tue, 11 Mar 2025 06:36:59 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c11e9desm17876951f8f.101.2025.03.11.06.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 06:36:58 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:36:54 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Patrick Bellasi <derkling@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Patrick Bellasi <derkling@matbug.net>,
	David Kaplan <David.Kaplan@amd.com>
Subject: Re: [PATCH final?] x86/bugs: KVM: Add support for SRSO_MSR_FIX
Message-ID: <Z9A8djMzajTAOawM@google.com>
References: <20250303150557.171528-1-derkling@google.com>
 <20250311120340.GFZ9AmnAcZg-4pXOBv@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311120340.GFZ9AmnAcZg-4pXOBv@fat_crate.local>

On Tue, Mar 11, 2025 at 01:03:40PM +0100, Borislav Petkov wrote:
> On Mon, Mar 03, 2025 at 03:05:56PM +0000, Patrick Bellasi wrote:
> > That's why we are also going to detect this cases and set
> > SRSO_MITIGATION_BP_SPEC_REDUCE_NA, so that we get a:
> > 
> >   "Vulnerable: Reduced Speculation, not available"
> > 
> > from vulnerabilities/spec_rstack_overflow, which should be the only place users
> > look for to assess the effective mitigation posture, ins't it?
> 
> If they even look. The strategy so far has been that the kernel should simply
> DTRT (it being the default) if the user doesn't know anything about
> mitigations etc.
> 
> So I have another idea: how about we upstream enough ASI bits - i.e., the
> function which checks whether ASI is enabled - and use that in the mitigation
> selection?
> 
> IOW:
> 	case SRSO_CMD_BP_SPEC_REDUCE:
> 		if ((boot_cpu_has(X86_FEATURE_SRSO_BP_SPEC_REDUCE)) {
> 			select it
> 		} else {
> 			if (ASI enabled)
> 				do not fall back to IBPB;
> 			else
> 				fallback to IBPB;
> 		}
> 
> "ASI enabled" will return false upstream - at least initially only, until ASI
> is out-of-tree - and then it'll fall back.
> 
> On your kernels, it'll return true and there it won't fall back.
> 
> We just need to sync with Brendan what "ASI enabled" would be and then it
> should work and your backports would be easy in that respect.
> 
> Until ASI is not upstream, that is.
> 
> Hmmmm?

This seems like a good idea to me, assuming we want ASI in the code
eventually it seems worthwhile to make visible the places where we
know we'll want to update the code when we get it in.

In RFCv2 this would be static_asi_enabled() [1] - I think in the
current implementation it would be fine to use it directly, but in
general we do need to be aware of initializion order.

[0] (first half of)
https://lore.kernel.org/all/DS0PR12MB9273553AE4096FCCBBB4000E94D62@DS0PR12MB9273.namprd12.prod.outlook.com/

[1]
https://lore.kernel.org/linux-mm/20250110-asi-rfc-v2-v2-4-8419288bc805@google.com/

Of course I'm biased here, from my perspective having such mentions of
ASI in the code is unambiguously useful. But if others perceived it as
useless noise I would understand!

