Return-Path: <linux-kernel+bounces-537018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A101A4871A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824413A2570
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589F61EB5EC;
	Thu, 27 Feb 2025 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="138PmLX9"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DFA1DB361
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678914; cv=none; b=AG6qKD5sAzxGDlg8K64cGsiG2HOGXQa7BWtA94kbRUwHIrzkO5ODXDMgaAPwvO3h1Vn6c90/MDW1QHuI/SAN+GIFgDnJZqkfEGHDsHaabuqGuOVob2k6S4dW4RWMcDciFFR6kPdr3ZBigwqLclO/3LZvjVz9SiKrPcVMEvQgNZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678914; c=relaxed/simple;
	bh=cYSnkHE+wx9t6OWYiWa1tes0wC6c/Dx8X16yrnsQETE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V12x/Ed35tPvkFFdn7KnHmpcXyvPtrZQC2y3RKk0RhEdlmHU+dZIzMiP5aKqzk00x2lFbgzTaL3pMVn29SxULmI/itOJIAz0FycGzvP4pHPXkdW/28/HyG6bXO+sZszIk5IDuPwSP2pkznNNbj92ivQxcRVDuWW6XroOZjc7R2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=138PmLX9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2feb47c6757so852722a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740678913; x=1741283713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/U4ADhpQSLxaAX/mw7MLAznup0G/P2ItfXuoeuEvIFY=;
        b=138PmLX9ln+0h+yIW7KB9Cp12R38wl8zZIsKmOErasztqclPwtIq0b4DZrQZ0+DZTQ
         Ms3C8jEz3r669faaO9jfx4LfaJA3kjMPx9ag6ykD9Ok93FGj3LCdJfA/IoGckDeB4tXY
         DR0PcZP1u9r/vptPLffWU2rQTUYq7gE2zuhO86OHsQptYC51Wjm22jaiSV7E2+CPkuSj
         iWDVwf/baXGZncrfB64QBwEP/dqg5nUI9Emn6935oukAw4MqWrJ1SA+hGltX6uiuh0Re
         YZfi5/HEiZd3YFs+lRzZQNRC9RCARNwncnaapjap++4Nx6xL5u7iEnS5aG2qm5c4V2HB
         V/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740678913; x=1741283713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/U4ADhpQSLxaAX/mw7MLAznup0G/P2ItfXuoeuEvIFY=;
        b=cWcy3YgRRAXt8r5oP4rhmGLKsZOP7X2BS9eCbShpmELQYHYTXx/9iatZly6vZ1XoLP
         8wMeYqzGntgdmqLhdI2+z0THX03T2Zy/K6BeyLEUcGZbExMj6/YOxzmIc7nU7smMAySz
         ZHN6L4iwptmPBhBS1/zuu+BlKvjf2yshvKpET804TSDRTB+yCcb5rAN4BER3q6GwUtHX
         zNjePcmvaUzEWDUTXIpNudVmujGrfzxqeczTmOBlHbwyy7wRKR0n5TGm/SO9fJpqz3dz
         YONkUnNK37WzDYrAIC/Nahsb637MJS8weH3phOUupbHsITAe1e59I7urGys52u00N9r1
         z9yw==
X-Forwarded-Encrypted: i=1; AJvYcCV0U/Cv3FlfGNuQZ+egbfwSbdzgwDeqlOuvv4JwPgY3o4DvOB+BkG7WgoAKFKY4r+HXHb0XK6DVFxb/rNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2bWQTRCbC9nEbUHt5gEaMT1Y7DliCcErZFpbPbEml9T1y7O9c
	zS2KZtxganjPiasE7u48zG7HQd1CbzG86vcywD3/yJX1JFHuvq5sjwmeH4ddEz/ps/nVfwesBWe
	nmg==
X-Google-Smtp-Source: AGHT+IHGTbrTn1tn2R1W7Q6/8wDfj86EBdyHlBInyb5ZX3gia9p6YPhCxbDSD+sJY5zmNZzSFX/f2zbnEow=
X-Received: from pjbqb4.prod.google.com ([2002:a17:90b:2804:b0:2ef:7af4:5e8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52ce:b0:2fe:a8b1:7d8
 with SMTP id 98e67ed59e1d1-2febabc84d9mr303232a91.25.1740678912677; Thu, 27
 Feb 2025 09:55:12 -0800 (PST)
Date: Thu, 27 Feb 2025 09:55:11 -0800
In-Reply-To: <Z8CezusUHEzOCYBF@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227011321.3229622-1-seanjc@google.com> <20250227011321.3229622-4-seanjc@google.com>
 <095fe2d0-5ce4-4e0f-8f1b-6f7d14a20342@amd.com> <1fe17606-d696-43f3-b80d-253b6aa80da7@amd.com>
 <Z8CezusUHEzOCYBF@google.com>
Message-ID: <Z8Cm_68F16TGQeZd@google.com>
Subject: Re: [PATCH v2 3/5] KVM: SVM: Manually context switch DEBUGCTL if LBR
 virtualization is disabled
From: Sean Christopherson <seanjc@google.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, rangemachine@gmail.com, whanos@sergal.fun
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 27, 2025, Sean Christopherson wrote:
> On Thu, Feb 27, 2025, Ravi Bangoria wrote:
> > > Somewhat related but independent: CPU automatically clears DEBUGCTL[BTF]
> > > on #DB exception. So, when DEBUGCTL is save/restored by KVM (i.e. when
> > > LBR virtualization is disabled), it's KVM's responsibility to clear
> > > DEBUGCTL[BTF].
> > 
> > Found this with below KUT test.
> > 
> > (I wasn't sure whether I should send a separate series for kernel fix + KUT
> > patch, or you can squash kernel fix in your patch and I shall send only KUT
> > patch. So for now, sending it as a reply here.)
> 
> Actualy, I'll post this along with some other cleanups to the test, and a fix
> for Intel if needed (it _should_ pass on Intel). 

*sigh*

I forgot that KVM doesn't actually support DEBUGCTL_BTF.  VMX drops the flag
entirely, SVM doesn't clear BTF on #DB, the emulator doesn't honor it, it doesn't
play nice KVM_GUESTDBG_SINGLESTEP, and who knows what else.

I could hack in enough support to get it limping, but I most definitely don't want
to do that for an LTS backport.  The only way it has worked in any capacity on AMD
is if the guest happened to enable LBRs at the same time.  So rather than trying
to go straight to a half-baked implementation, I think the least awful option is
to give SVM the same treatment and explicitly squash BTF.  And then bribe someone
to put in the effort to get it fully functional (or at least, as close to fully
functional as we can get it).

