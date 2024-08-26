Return-Path: <linux-kernel+bounces-301839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F24A95F657
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA602829B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84B9194A40;
	Mon, 26 Aug 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/i50Epr"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD631957E1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689265; cv=none; b=Y4zEvC8EpaxXw8TXVua06jBU1jFY1AR8+j6T4XleVSWh7XslGjloQIdzJesieDhvschdHjVNFP6ophY+AgkDjkHzokc+Sx7yJfIlyAoT2wTOGF9VuVAGmGMupCkgmWg2FXanr+UMR3SRc+FxN2H19OPXZnof9jKgEVLm1DlhdWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689265; c=relaxed/simple;
	bh=a6zpBBN4JQg0KhcoF4b7pBScl+jiov7IK/jGwEtOvIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bogWLG1M8LMb/A596ncykcrdxB8hVYFgRQor3ryYW86e7Ugnt2ibLurULVy3wvXnzDooQ11HBjjgnMsDfMGhCYwrw4/PEIwXTloHTZZprL6hYD+Aqsz08sSfiEbhX1oO3vy/Qlr4bx24ZuC9jdFW0Ul7n7oOq9mr3Vz9OXPJssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/i50Epr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-201f2de64ddso49528935ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724689263; x=1725294063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nH4isUs+Ak6g9QeK5QSm8EdSPs1/4ASJGA312ynuDFY=;
        b=E/i50EprUH/qrl4o7hC3vCvjuGPItwBG4BJRrWkpBX94bxJinFbMSxrYFfk8byBTaq
         pGtmJryn6VWlO7jWqe38PP2vw3MQ0oSohI9terQNOihl9PC72uTidCGcdfjVJrFuuCjy
         JRaaNtChhBj8xmxZRBGQBAtirV3djL4Q+VpHnknZxIWG0CuqWzwHFaRQFKaCIM7VHVh7
         pSt1WCPwcvEmPjj7aqoWYaxrN1y18B/FMK1WEPospWzqMlaLSaxzWKEaEWMI0i/Eneag
         aPI9dLY0oBTYNkpRt0mLjgBTM0zgC+Hh34nSWFlFiUBA1hU4isywEe3E+6b8EU1hzyJl
         i5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724689263; x=1725294063;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nH4isUs+Ak6g9QeK5QSm8EdSPs1/4ASJGA312ynuDFY=;
        b=onXHUGQhgHOebplqAUnKoJzcjdvTo0S4vEkrfASI7nEWjyvCalfWYOHot4DEqsFer2
         Yjv7kfMsjSPA3mGjBlUPR+EMPL6HruDcp2Stl1RO+BZRA6QuJGXxDtqrBJDey1vbVZUM
         bjOZ8ysy87keT/nUoipfJ4XRzp4X8MF7L4zKQ/vP79e/5/KbwpCMYBnTQu0lM26P09hQ
         XpICW47oRo9JRL4l96dmzCfv7/NoeAGTQy3xd7h1vwlKme9GxlOx/dhEG6ULfPr4zZkI
         G/oPaNvm1ZkeEOlju3Vm/YATK6Nnp7OsOB07Vyvg0yjKhObJDEao568wXrly5rjAzUFk
         Esfg==
X-Forwarded-Encrypted: i=1; AJvYcCXFoMxc9HRaYkihpfjvzjs20XHHAcqd9O6e0qZB+hcdKBABuAYUhZIBmlKBerHdlydoOSMF8IDANnAPrZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7j+ple07CA5WeO4/7Z5rJvOXITBfPrmlyHxeinl5dOX3oUOBz
	c1Gi1flLyxyPKI5TBZUI/3Os/D34dq7hLw1AlqEdhoSDuW8U/Xg29f8eU+J4rg5zDuCnravuJQA
	h8Q==
X-Google-Smtp-Source: AGHT+IFZBf/JtJOpPDhFjcRpoVVRqE7Xm33ElNPbb1hk/PhhHYsdK4hJiGWeK9hyXOPimjecXAjJkEhXV7s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1cc:b0:1fa:d491:a4a0 with SMTP id
 d9443c01a7336-2039e444afcmr6365945ad.2.1724689262997; Mon, 26 Aug 2024
 09:21:02 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:21:01 -0700
In-Reply-To: <7f15288693d0ebaa50e78e75e16548d709fe3dc5.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605231918.2915961-1-seanjc@google.com> <172442184664.3955932.5795532731351975524.b4-ty@google.com>
 <7f15288693d0ebaa50e78e75e16548d709fe3dc5.camel@intel.com>
Message-ID: <ZsyqZeTzhXk5UeSP@google.com>
Subject: Re: [PATCH v8 00/10] x86/cpu: KVM: Clean up PAT and VMX macros
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "luto@kernel.org" <luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Shan Kang <shan.kang@intel.com>, "jmattson@google.com" <jmattson@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhao1 Liu <zhao1.liu@intel.com>, 
	Xin Li <xin3.li@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024, Kai Huang wrote:
> On Fri, 2024-08-23 at 16:47 -0700, Sean Christopherson wrote:
> > Applied to kvm-x86 pat_vmx_msrs.=C2=A0 I won't put anything else in thi=
s branch, on
> > the off chance someone needs to pull in the PAT changes for something e=
lse.
> >=20
> > [01/10] x86/cpu: KVM: Add common defines for architectural memory types=
 (PAT, MTRRs, etc.)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/kvm-x86/l=
inux/commit/e7e80b66fb24
>=20
> This one has both Acked-by and Reviewed-by tag from me.  You can remove t=
he
> former.

Eh, you get two for the price of one this time around.  I don't want to reb=
ase
this entire branch just to fix that goof.

