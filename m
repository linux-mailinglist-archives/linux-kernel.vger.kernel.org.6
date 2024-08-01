Return-Path: <linux-kernel+bounces-271714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188D894526A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89301F23FF7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBD31BA866;
	Thu,  1 Aug 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1gTXcblx"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4521B4C49
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535075; cv=none; b=uMTitxaD3SBtaHYB2Trp7+zEqL37QmFZNXjD4adp1p/qcCnkpIn2OLakuUHIAxt/64haTDVfy8tN6PtDnx8+5+aS7+h7lPzZFV3iNrKoLAtAoeRitSet/S96w+X3FSspDbMgxqFlepBLCAQzIFU70LcefSVApBae5IH4JK/JmSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535075; c=relaxed/simple;
	bh=RRnVrODlIXwb4KTZdh1i8JoY9YJHVgr4QPTd7lqZ8sc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XrtoLeW+JtT37HRPnRze25NAGE2rjDflxV0Er4UdGiWk7rVTiksj+kZ7tjA4vcjA28T3Q9lGUC+xkWlDG4NJCUkPsLlp6LuLfSU83WyrgCzNm5YpnuCSHTkAK8ACDd8UJAdJgKhyKtUnZD4gavDWSJdCVXsc+1YduMJF/0Wn/1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1gTXcblx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2cb5ab2f274so8762277a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722535073; x=1723139873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZsjMORWNMLw4A5ZHbitxpDYHrl9my8e/hfGilOpgU0=;
        b=1gTXcblxCkia0kBomrawj1uNO4++9SAjhMjPZ2MuZ8GZuSBaQ93kNnJraAVl2Sw+mO
         kHXERg66AoBKsUYykay5a5tnFOjvW1Ljdnxuxl8BjuIcHumul+uy2YMDZu60vJr6H06E
         d5544MKImHtVM401dgS1KqaPOObb/Ya2ma9/DDTrse2dkX0s1+mCwxODr1A8CdsnNp2Y
         YGeUNz5RpXqygfIwAZheyhepX1NWYP5Yp+l933VJylJiMoVcMZYvjM0woRqTMbM60NyT
         W0fxYTuP8L1JSJbbF4HhbadTzedDKV+HLyEQeBhL8SOGBxn4Hh+rKaZ7zDceEb3oJK4z
         HdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722535073; x=1723139873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZsjMORWNMLw4A5ZHbitxpDYHrl9my8e/hfGilOpgU0=;
        b=fhJ4Xq3mXEHgeiOy0hWgR29ddXTNrgUtSkG6EpgAUDwtWATvi9AkkuXcpaqbr4+AuD
         nJnjALrp827Ho1EKxqqoSEWI3feENW1ScToQWhmsHCAa99pGUF8BBNazBIEO4AGO97EH
         WTkO9BKcmrgP+Dg+FnHT06JvT4eEulzMBEdb+YOUamgawJ6r4QYX0rekkQiKnIixmuvT
         xde34QO8enD/5JBmjn28Xn/mg40jM5xbFtMdWI8wfKtEaqp4OFDN9fhUMq935xLY/ZsG
         hHSAsRT9NlLFzX55xEYUyW1LD92N1jMLKVXit9qi9Yv44Sa3sELSoMw52ujoU3ZEyIFA
         rULA==
X-Forwarded-Encrypted: i=1; AJvYcCVBRqeBgqCQ+8sxGuYpeFln+bdQFF1ibgm40/drHG0GWS3CTlp7nCrDIqA6X8B1rjN7VKt3RGJxqy7Lzc5xAr5HWWexmaeMKo7y5fxy
X-Gm-Message-State: AOJu0Yxf3FtbtyF5uslzDnjpcsqnAcf0rHuJYQhaO9Gh7ZQXue+Slfdj
	+OA42emULLvljfOIRpxGE1lQoaVwbzLGLuLPyDO7dxo4//taKJQgQrJoBWiKzLSVjoLySLuY7EG
	q7A==
X-Google-Smtp-Source: AGHT+IFR+iUgu+QKJU7dkP2vun0rHsyzYS+V01y7jiTTuZQWqm44psgY1ZYc8q2GM5amzUuj4CJmeyx9mEs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:314a:b0:2cf:6730:9342 with SMTP id
 98e67ed59e1d1-2cff93d3415mr54282a91.1.1722535072537; Thu, 01 Aug 2024
 10:57:52 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:57:51 -0700
In-Reply-To: <20240801173955.1975034-1-ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501085210.2213060-3-michael.roth@amd.com> <20240801173955.1975034-1-ackerleytng@google.com>
Message-ID: <ZqvMnz8203fJYr5L@google.com>
Subject: Re: [PATCH] Fixes: f32fb32820b1 ("KVM: x86: Add hook for determining
 max NPT mapping level")
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: michael.roth@amd.com, ak@linux.intel.com, alpergun@google.com, 
	ardb@kernel.org, ashish.kalra@amd.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, dovmurik@linux.ibm.com, hpa@zytor.com, 
	jarkko@kernel.org, jmattson@google.com, vannapurve@google.com, 
	erdemaktas@google.com, jroedel@suse.de, kirill@shutemov.name, 
	kvm@vger.kernel.org, liam.merwick@oracle.com, linux-coco@lists.linux.dev, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mingo@redhat.com, 
	nikunj.dadhania@amd.com, pankaj.gupta@amd.com, pbonzini@redhat.com, 
	peterz@infradead.org, pgonda@google.com, rientjes@google.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, slp@redhat.com, 
	srinivas.pandruvada@linux.intel.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, tobin@ibm.com, tony.luck@intel.com, vbabka@suse.cz, 
	vkuznets@redhat.com, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 01, 2024, Ackerley Tng wrote:
> The `if (req_max_level)` test was meant ignore req_max_level if
> PG_LEVEL_NONE was returned. Hence, this function should return
> max_level instead of the ignored req_max_level.
> 

Fixes: ?

> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Change-Id: I403898aacc379ed98ba5caa41c9f1c52f277adc2

Bad gerrit, bad!

