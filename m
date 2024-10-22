Return-Path: <linux-kernel+bounces-376736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 090C79AB546
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43461F2109B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357A51BF324;
	Tue, 22 Oct 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZd31Coj"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE51BDA9F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618792; cv=none; b=bXS2pMBlmMWDmWmivJA/L2sLgHQg6ymW3lqHqIUw0Aq+AqXtFsMXPpt5hUpUDEL5jLDkIAf47vTn3UKXSRs1/PxisGxDSMeUlPzorGUDkN20ndBMDOCAOwUx1bK1RIvq9nv4pqUZmiPQH/E2Zanr1/3hDR+rsP/RilrvI9By54U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618792; c=relaxed/simple;
	bh=h4MIPBEL4V9WAYqdDHnPysjEyy+AelhbALPsCcTQfEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rxr3AhlHf3ZrDtoJzvhrdSyDo6iyiSYJR4hN6XjhgsMyNZv/6JjcoUOuzo/1m+RXlK8ebm78DtkAuAOS+mFc98pYNpB+dWJz+czcoyXOa3Zol9Ra/S0+Kl32+ITrNl6fNcfExh6VxWvaYYP4x4yi/TJ+mV04CMvqj1P37WGaHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZd31Coj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2e3321aae0so1053140276.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618790; x=1730223590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jr7QRncEkRO5SGsMaaqDvlhl7ffAWX+JklGyW9eHR0=;
        b=PZd31CojS6UNRkWZsQP+AjmrEKYOc0KQtY1WsKWrGOWDQCze+2O1FdJHGQUEbtke6O
         qn4PrTOHulIey9Zsg4T2xfQCiH6drbbCZatjr8fBbQfIm9++NxXI4RfOHaDUSr5vEAXO
         1hwdKapJJXPHt0HokkFT1ntSLJg/hDem5fR2p0GwKq4MKDse83uwuMWlR4dpJxPRcqxF
         3G4N/XegNJFy/Zr7+R3kkcqgpFJzVFErRiKBxa1h+cJ5/DnewyoGXPOrhxE0RQZ5I8uF
         3EvAu+hE+0rXkvXgwx+TmaJNEAqVmYXmkGtCfDr9XpNUIY9rLUHP9g8fqZCUpOljDo/v
         cw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618790; x=1730223590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jr7QRncEkRO5SGsMaaqDvlhl7ffAWX+JklGyW9eHR0=;
        b=eXKzhJPsB/w/Z8blOAVIJ+wyneWt7LtXM7XAo1R6Q7/p0TDDOEsZvOGBHxlfhxYx4Z
         0lB8ZLiHDFg436rjdlVi9KeyEeKiEYY8iCtvMfV98Dz8sk0XxN/AX0ZdEjhsBccG3yNT
         yl4c1kKUeswU3t7g0OoY0dPtTl5hQX/9A+MIcPj0KKcwgry1COdducSma95zm5vJGMob
         QzvRTzpknJ+UbqSecnaKtan5dfhi1d79dvybosdA5TVSemoyhte42C/6XNBW7OIWWwaH
         APSlIq5scUJc5hU+8l1f4NRt2PVG38BErkxy2LsY//TsrHSrCwxkcArSrzwEIfu2Susg
         b9yw==
X-Forwarded-Encrypted: i=1; AJvYcCXVRZK7XyMgHc3yc/M4ytNDEnhthJYZIMgyPLFg9qhG3JNiGG+aietDDuaxhQXM4qmcbq4J0WREkGoMMCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjvMAmayzh7S0I0NNp8YBnwVmNokwMtqFhYHC1QpILQcmXIiAj
	XZS2Dc1juZRsWlIDVBg7MQo/uLoJvoJSAWzWgydxfjLgCHQTQFPSnYHhR+v/w4gGJYXIxNYFElO
	NJg==
X-Google-Smtp-Source: AGHT+IHdcr2KhjJfi0r4/pv863MLMN/g4e+rJOpfIkh1PjtUb3WAG+XrA2IzFLb2akxoRH6w2udzXx0f8U4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:7485:0:b0:e2b:cd96:67a6 with SMTP id
 3f1490d57ef6-e2bcd966c76mr6652276.5.1729618789765; Tue, 22 Oct 2024 10:39:49
 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:39:48 -0700
In-Reply-To: <202410201716.n8f4T911-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202410201716.n8f4T911-lkp@intel.com>
Message-ID: <ZxfjZDVjgmBF918G@google.com>
Subject: Re: arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect
 type in assignment (different base types)
From: Sean Christopherson <seanjc@google.com>
To: kernel test robot <lkp@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Sun, Oct 20, 2024, kernel test robot wrote:
> Hi Steven,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   715ca9dd687f89ddaac8ec8ccb3b5e5a30311a99
> commit: 59cbd4eea48fdbc68fc17a29ad71188fea74b28b KVM: Remove HIGH_RES_TIMERS dependency

I highly doubt this changed anything.

> date:   6 weeks ago
> config: x86_64-randconfig-123-20241020 (https://download.01.org/0day-ci/archive/20241020/202410201716.n8f4T911-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410201716.n8f4T911-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410201716.n8f4T911-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [assigned] ret @@     got restricted vm_fault_t @@
>    arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     expected int [assigned] ret
>    arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     got restricted vm_fault_t
> >> arch/x86/kernel/cpu/sgx/virt.c:60:20: sparse: sparse: restricted vm_fault_t degrades to integer
> >> arch/x86/kernel/cpu/sgx/virt.c:354:36: sparse: sparse: cast removes address space '__user' of expression
>    arch/x86/kernel/cpu/sgx/virt.c:385:24: sparse: sparse: cast removes address space '__user' of expression
>    arch/x86/kernel/cpu/sgx/virt.c:385:43: sparse: sparse: cast removes address space '__user' of expression
>    arch/x86/kernel/cpu/sgx/virt.c:385:58: sparse: sparse: cast removes address space '__user' of expression

These are all easy enough to resolve.  If I find myself twiddling my thumbs, I'll
send patches.

>    arch/x86/kernel/cpu/sgx/virt.c: note: in included file (through include/linux/miscdevice.h):
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
> 
> vim +59 arch/x86/kernel/cpu/sgx/virt.c
> 
> 540745ddbc70ea Sean Christopherson 2021-03-19  32  
> 540745ddbc70ea Sean Christopherson 2021-03-19  33  static int __sgx_vepc_fault(struct sgx_vepc *vepc,

LOL, I can't outrun my past.

