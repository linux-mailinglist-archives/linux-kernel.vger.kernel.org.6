Return-Path: <linux-kernel+bounces-180064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756308C6997
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8511F23664
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70481155A39;
	Wed, 15 May 2024 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tw1B7+sV"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6FB62A02
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786635; cv=none; b=fN2SiyAaLb764HVhdigu7VR8Pe+PQZBqcHJC5r48314tZar0RupV37+rieKumlYUUXgREFLmvgnxxEN6xsN9+H0BBGciJ/UvZkUEgP4cva51CAuGKao8Bz3LgjvUIvg9M5pNHDqU3xojxc7yTaf7P+RQf0XGo6lGLl4NF9IC514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786635; c=relaxed/simple;
	bh=kU5haLDUlfgVHXQJnqJgdAkMMg41tQYnmCEL6k+6oDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=haBBB5eTOK9t/OIMN7F+K067i7l5KuO/+5OQfCdhgu/ek7GA9ZocFlP3FYVwxSrm/ndns3TaBIpQ0HMILEGFs3kEmZmIDQYxpY61NctVhW2SRCbuhgtst9sZi6mXKVYtJg7ABjKRoFAcI40c2j8QwB8eRf+PSWHVMvUkkR0QFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tw1B7+sV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so14989597276.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715786633; x=1716391433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vj1A9ui2SaRE/HWTW3nQNHcmp/FHeI/IPRLs6zsaMw=;
        b=tw1B7+sVFtLjslTi3HDAnFYd1iIy8cvWIarH4hCGkD6J92zscbjwLbuYGsatzPX5Cj
         KEnvLeIfSFgkSvKV/HiWjOFpFi2a2ELVLN+x2CHivUe0BjRn17aRRVqZhpcWFL8W2dOH
         57hVo9YNpfD4+ecY6Hpd1KsqbLuUezwfptRqO0sBtYHIHW4kt1Rm5bWrpIh4Y5enZHRj
         jrBrr512YcD2J/cKhbaENhvJu5cozKwDZqy6jk3e1vr/LEESnTO9bJg3nN3t/IEvy9v1
         +dabm4c3g/Qgu+DT9rjQrBCLZ2Y9mwgcT8pj9dFyQJzs8pm1I5UO78yQq7XZno5j/13N
         bM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786633; x=1716391433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vj1A9ui2SaRE/HWTW3nQNHcmp/FHeI/IPRLs6zsaMw=;
        b=TJiMXHdV2vlH5wajGuYaWsH1DqcNZaV2k/vEOIgBAtayrIfUnqh1R5Ckwrz02suv1g
         IKlGyaJhjha62JBO8SaVMmPYq2KA4u4iYz5cwZGL8FoX/CTBHscn7G9qgw/hIFtnRZSF
         fNFGPngsF9jQR0Jzqy2Y3p4MDoYHZ3ehJSSpZI5qGXk01dvu0fleWB2PDWwL+1Bx/ovh
         gBqPlZ921eZbo056s7sjH964wFxriwAzmmbcXwNT+qcYwkBi6g1vWPtnwBS547MrOM5l
         EvzkSC52EtsxcdNxxs/aKCBNAN1TOe16Tzyvi6iNpLSaeOcStEGMPb4GI6t4Fi5zqAYu
         w3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCW9JqHscdCclpFgNj5fPSWf6Vi0aRsjVx0A4QiswmJv3guKGuqKEjNBFBlOUZB8i9YtH7tZZ/xDjbs/nilqIM0ktZ7R7sPpw3uhyb/Z
X-Gm-Message-State: AOJu0YyeOyEJLCGJQOr1II5pk6kT7ZUpV8y4IsQVxZUjWkhhFeopnmFx
	lH88EeQg21dlqbYkAtFBvaaI6Jm0DxOf35AeFIlGMFWXJdIEyHPWijPUlCD8s369Y+pHkS2KvWH
	qTQ==
X-Google-Smtp-Source: AGHT+IHYglKVcDSO/IWQfJ8xI8dVwMGpQ0/ErI/yxeFoh8tCkNXcyH0VPfrlyu4AmFvEBSdW3dgM2ePXTNA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100f:b0:dee:5d43:a0f3 with SMTP id
 3f1490d57ef6-dee5d43c91fmr3707898276.6.1715786633444; Wed, 15 May 2024
 08:23:53 -0700 (PDT)
Date: Wed, 15 May 2024 08:23:51 -0700
In-Reply-To: <5547dd176122865e6a13b61829aa9c4b6cc21ff3.camel@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240508132502.184428-1-julian.stecklina@cyberus-technology.de> <5547dd176122865e6a13b61829aa9c4b6cc21ff3.camel@cyberus-technology.de>
Message-ID: <ZkTGhmfF-FYisKL_@google.com>
Subject: Re: [PATCH] KVM: x86: add KVM_RUN_X86_GUEST_MODE kvm_run flag
From: Sean Christopherson <seanjc@google.com>
To: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Thomas Prescher <thomas.prescher@cyberus-technology.de>, 
	"mingo@redhat.com" <mingo@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 15, 2024, Julian Stecklina wrote:
> Hey Sean,
> 
> does this this patch go into the right direction?

At a glance, yes.  We're in a "quite period" until 6.10-rc1, so it'll be a few
weeks before I take a closer look at this (or really anything that's destined
for 6.11 or later).

