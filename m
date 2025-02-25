Return-Path: <linux-kernel+bounces-531737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB63A4444B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA41B19C43AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0E26BD87;
	Tue, 25 Feb 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CpLrUep1"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303526BDB9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497099; cv=none; b=eMx+R7od6EFrMG+wx/U5Zt1ofYJVJ/UlCalNYPXu2xfvbTa171gFRweRhRgrmScnbgbzV0gLijzxO2+vbc8PBEF74ORiAIEqAR11/pBRu/jLLV33cLvQEXmHvFR+UYhRWwRbAvWmHOZ9Iq3+pUhvl2RhXwOgUpdE0Vn00myxXSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497099; c=relaxed/simple;
	bh=/kEmc1RisEmZzLUP6Bb9mGVdImTgWmIIc9sRmzZjAb0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NJWu5MY4QeyU2rALi9G1VALEnornbqs31kuHpe03qStCtXlsxY0QuiaIeN+AyQuw1aVSZ8ICA+BEhj/Ej/CdY4cvIphqkrdxNgu78+LE+dEq6f0002KGpDXJEtFRq/5bmyh2fff/uGl3mezc1lcZogfhQbH5Pj0oul5R8m9uwO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CpLrUep1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1e7efe00so11842507a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740497096; x=1741101896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=htA+KOz3hwOpVDUGhryEfyIW89CbLqdlKndxYP8BGHY=;
        b=CpLrUep199DOdagcEmyW/NLD8D91tT8cvWgdBy+wZB+nSiFfuesOpVS7JzbWJRI4gP
         L4gfkE0NQ8tfTXxxwAu+zT8pwoDq5EFHhLgv55QzvdyGrJxCjmUqBEGMSWvzivBNTcdU
         HGvhm7kRzknwG3bQUjYUl2B1EOpdj7+C1DhfJ9IZ8p+jkf1Ya8rfSmrnhfKJbmjDKt5q
         llKoUkNFvy2GJK7pmtnkMTlN2mbjijr5rhJ1h5KN/LsB3qAxIN+jgIolzNdvIVL79UmN
         GORHAH/pHbwRABIShDzRf8YQuqEOdYAez/dEewyAHYCvk8ETOT2dwEOHrwtbdyYfGXAr
         /7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497096; x=1741101896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htA+KOz3hwOpVDUGhryEfyIW89CbLqdlKndxYP8BGHY=;
        b=mMI2KuJHstk9UyLOEdG/w/8QNw0KMIfEZoWz387xDvydIe1GG89rw2j5ThG2AhxoDG
         yg8uVf9x4jI0qoaLWeXoF58vF29LPr3YVQeSJ3ghO0sJUyzRj05eRX4dSp7Lphrnu+xj
         lDp6PNMfSvO5b5h5XAFfhDWL/QtuLLy7ONw17jw6bty22S/4H+HOrfojiqg1NnVHJu7x
         pXKM6I1HrBbjYK5d5sLWhCTFa0Do5Leb1OruWZwGwXyblhceHveuDntxWF1b7jtG7VPV
         ptLlL5tl1w4+VTPUtAXPNCZFXjT7fa/tR0nKcYF9FE2ccRGt1SIXegp6qSNNzfFwkpCU
         P9OA==
X-Forwarded-Encrypted: i=1; AJvYcCVXS/eJ7myE4d2IB+JlrtRwgQlFxUN6zYIE2nRN3f8jK3+pCxxsXTtEXueJi+TlFPToBDY/cbvy2DBxHc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz30tHorH9z3dUN8cYRLleXR7JrSdT1B/deuJRnKiDKgVKrHdGR
	YjQanUxw3LlM3wYUWuQpTktJ9iUM1haFlFIZeFtwic9CIOFgIWcltt+L5OYyrgjGnXQrNnpCwyy
	+TA==
X-Google-Smtp-Source: AGHT+IEfGwMFBrSc1PtpNIxEeqJE1KnFkO2G8V6lYOf7bmlh6CIlg9FiV9Y9zAZ7X+CiVfk9lHXS5gclkAA=
X-Received: from pjbtb3.prod.google.com ([2002:a17:90b:53c3:b0:2f4:465d:5c61])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5202:b0:2fa:b8e:3d26
 with SMTP id 98e67ed59e1d1-2fce875bd28mr27277979a91.30.1740497096080; Tue, 25
 Feb 2025 07:24:56 -0800 (PST)
Date: Tue, 25 Feb 2025 07:24:54 -0800
In-Reply-To: <22d4574b-7e2d-4cd8-91bd-f5208e82369e@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001050110.3643764-1-xin@zytor.com> <22d4574b-7e2d-4cd8-91bd-f5208e82369e@zytor.com>
Message-ID: <Z73gxklugkYpwJiZ@google.com>
Subject: Re: [PATCH v3 00/27] Enable FRED with KVM VMX
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Chao Gao <chao.gao@intel.com>, pbonzini@redhat.com, 
	corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	peterz@infradead.org, andrew.cooper3@citrix.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 18, 2025, Xin Li wrote:
> On 9/30/2024 10:00 PM, Xin Li (Intel) wrote:
> While I'm waiting for the CET patches for native Linux and KVM to be
> upstreamed, do you think if it's worth it for you to take the cleanup
> and some of the preparation patches first?

Yes, definitely.  I'll go through the series and see what I can grab now.

Thanks!

> Top of my mind are:
>     KVM: x86: Use a dedicated flow for queueing re-injected exceptions
>     KVM: VMX: Don't modify guest XFD_ERR if CR0.TS=1
>     KVM: VMX: Pass XFD_ERR as pseudo-payload when injecting #NM
>     KVM: nVMX: Add a prerequisite to existence of VMCS fields
>     KVM: nVMX: Add a prerequisite to SHADOW_FIELD_R[OW] macros
> 
> Then specially, the nested exception tracking patch seems a good one as
> Chao Gao suggested to decouple the nested tracking from FRED:
>     KVM: VMX: Virtualize nested exception tracking
> 
> Lastly the patches to add support for the secondary VM exit controls might
> go in early as well:
>     KVM: VMX: Add support for the secondary VM exit controls
>     KVM: nVMX: Add support for the secondary VM exit controls
> 
> But if you don't like the idea please just let me know.
> 
> Thanks!
>     Xin

