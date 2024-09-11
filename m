Return-Path: <linux-kernel+bounces-325213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77F2975648
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CCE282C82
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6921AAE24;
	Wed, 11 Sep 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0JUTmdCa"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F94518EFC6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066762; cv=none; b=MSswTONluqfksL+qcUMgc2fROoQUz9reip3ZfCP92SBDth+DNRUKX3blyx7L8u/cKzBOV1US9pRlMjCEsVymNqJtcSl4hk3MqkSQZcY+Mbd0wNHH6W92bgUTBI/PPq2qZzlZxaDVY6PjCh5SOsHm+AhkSVtLXAW39Nl+qzcnMNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066762; c=relaxed/simple;
	bh=J/5zZEaliOfnL1P3B4YTxXiDwDtbcLhUhGApH82wU50=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aj1L3g3r/C9aAzsc3Oa1Ua1qnCHEuLVvmGystnhs0QHWfDlfVoNZa7ITR1VcFjY/zU/sfriO2RfZjVmXc73eTKY/318s/etFP0cP/jiWx/kMo5rUudQGBeiqyI5By3bRDZV7WmsVTOIB7uOLnqbDYtEDQCWlbuoi2XoUDBmsjlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0JUTmdCa; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-718d7ec6ff8so928214b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726066761; x=1726671561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=frp1Y3T6vQF2wlWEbm70GuMFnSr57Wi+zpQI4YWKQdU=;
        b=0JUTmdCaSU9AZSmJW5uWzUiH7afkpYI5wMa7uj4do44nLqY4/GX6vwF/s+8w3JUYdq
         tm2uhUvbbC2AeDc8LLn06KRUkDinp+OS7rz9iA3+I2mbjWUgrV8do1QLvogXAxawBVVc
         fbwBBHp7ou2QGBEyt9bV8hZQ9T5cQmEk8QmO4iH+/Ga1bnnItU8mTvKNjvDCLduVwZ0Z
         udEn4cTdPUSpjdSuqtoVNIBaZTQqwtkJd//JjwPGSdgZt78KNnFtfxyyR03rTvafnoDs
         /wVt/ISoCyMzUeLV5QeV11HKzH0isL9jkvaNmbxmGDVMVomI7sicvdazl6QaTNGjhS2Y
         spAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066761; x=1726671561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frp1Y3T6vQF2wlWEbm70GuMFnSr57Wi+zpQI4YWKQdU=;
        b=H/aBQ2wPk1UMGDSTH7hHeDy7bwPdbre/9aibSrjJrrW3DK4oev5Mg8g3GRdQ15WZYS
         3TDmzxms2QG8oP2DfYZH077gV6b/+l2eT4w+Tucwt15FgS7S35+3Bn/0jtq1t75JADmQ
         KIGuCy9VQl2K72iWvbZsGpJl3EFuntQdw+CKhm5a0N4JBsu45/xGVtI/XCtOu6w6498e
         qUeTmdrTAOXQHtWmpsT53nSlE2sgXfDaRalTsXNJjFFIR6p5FyFzVKhfHOHkloTNZs02
         eOknOi1XvM5muC1QgH/9MrB7w7Nh5HnsA85+65gaLGF+ngrGcz/KXnmzMt1uLcVYzgFT
         EtOA==
X-Forwarded-Encrypted: i=1; AJvYcCVwM+Gv8l+z+Mrh5z+jkHtczRD+4o2mzyEkiBlbxIbgE+IXEg1MBtxUD0UxrdftZEyPzdUZVg2yTTJjTtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWII/sBiIYJSk1Zs/z8E29KasuOjrCUX6FtO8Q0td7yTM7PyMJ
	P+492CLD4yYA/04N91lMLt/BDQRm6KdGMpnsyJpC6bu4rW+dM4EcBjt3iYGObGcem7vucSbxGr7
	ypQ==
X-Google-Smtp-Source: AGHT+IHZmaSOa2ig9dKgw9qLSBpwbyeQxDyRh4zS1XsNXX8slVxtHF7lukYnloZmaiCG5F/yRSuo6g5If6I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:b618:0:b0:718:e06c:6866 with SMTP id
 d2e1a72fcca58-71907ba29b2mr29556b3a.0.1726066760315; Wed, 11 Sep 2024
 07:59:20 -0700 (PDT)
Date: Wed, 11 Sep 2024 07:59:18 -0700
In-Reply-To: <b4829ed2-5a34-4b5c-8770-3571a9381b19@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509075423.156858-1-weijiang.yang@intel.com>
 <07b0b475-9f45-4476-a63d-291f940f9b4d@amazon.de> <ZuGpJtEPv1NtdYwM@google.com>
 <b4829ed2-5a34-4b5c-8770-3571a9381b19@amazon.de>
Message-ID: <ZuGwRnF3__jrkpwJ@google.com>
Subject: Re: [RFC PATCH 1/2] KVM: x86: Introduce KVM_{G, S}ET_ONE_REG uAPIs support
From: Sean Christopherson <seanjc@google.com>
To: Nikolas Wipper <nikwip@amazon.de>
Cc: Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com, mlevitsk@redhat.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 11, 2024, Nikolas Wipper wrote:
> On Wed Sep 11, 2024 at 04:36 PM UTC+0200, Sean Christopherson wrote:
> > On Wed, Sep 11, 2024, Nikolas Wipper wrote:
> >> Having this API, and specifically having a definite kvm_one_reg structure
> >> for x86 registers, would be interesting for register pinning/intercepts.
> >> With one_reg for x86 the API could be platform agnostic and possible even
> >> replace MSR filters for x86.
> > 
> > I don't follow.  MSR filters let userspace intercept accesses for a variety of
> > reasons, these APIs simply provide a way to read/write a register value that is
> > stored in KVM.  I don't see how this could replace MSR filters.
> 
> Nope, that would be an entirely different API, but if that uses one reg IDs it
> could be unified to cover CRs and MSRs all in one.

Oooh, gotcha.  Yeah, uniquely identifiable registers would allow for a generic
filtering API, though I'm not entirely sure that's actually a good idea in the
long run.  Most x86 registers can't be intercepted; having a generic filtering
API might incur an annoyingly high maintenance cost.  Hmm, though it should be
easy enough to explicitly allow only MSR and CR types, so if/when we get to the
point where CR pinning/filtering is desirable/ready, then a unified API probably
does make sense.

