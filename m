Return-Path: <linux-kernel+bounces-322405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2C39728A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F97A286287
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D2F167265;
	Tue, 10 Sep 2024 04:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UM1YMoIy"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92131514E4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944211; cv=none; b=ReSciDsCBfsf4q5lDUg0mYLDBXTQnJAI/GKXdV+C4KzL6cMEUYeelWcGizRsbIJmUwsDQaThgQ28sZQ7GDj8AB2adKU2e961f5uCJpmC8iDxypK2ytmFoCJyk4YgK2XrZHLx/MJmWkOoISrzkLv1+nvDfAdtbCOMXTmKDmyEXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944211; c=relaxed/simple;
	bh=juCf2R0p1ORyD3x1UAE2XxSlfmLi96DIvVEcl9Evl/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gtpYF2kuAHSRNqum+vF/K574Zjym9QG71E6Jljmju95jxjXxQ5dRMkNVDeGKQpJiFqWbVnOlW5OnyClH9INPWYbAujj3aI57gzJneB2G5X3I0NEpI1ZHlI/V8fTGlFf7ABQ7Xh+k9Yt7ehedZr87VhiLVMyWoKRGGVwtjQ6KzSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UM1YMoIy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d5fccc3548so106767147b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 21:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725944209; x=1726549009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/XYg61hIXxY5ogTBVcq32zREuSNxjhSfJ6hVBl71PI=;
        b=UM1YMoIy9rKo0FN6lS1Ves5s40KHHNjL1wrNRCweYuZuwHVeuckPWjnEqY78GFqMXO
         l/QJEbiYuG9UJyj/sdcrQEsEerMfYqGy37cfHe/5LWjdr8g/RIOsqujVU3+k2ibHSmBN
         MtB2zjIB8T/Q0J8YN8jTVU5qPi57aeuFgH5fp0e9wMso1Pqd/jY/1MIZXF7xT2+wjss9
         D14UyvGT10e9Ze0Howohl8BkLrv2+k2NzIwPazrW4NRaTa+F6O7kW2ty3g84j0u5waVK
         xrOH1uqi4mRfiybQKLgO2GEr3N6qPDSzZaXFonHIFHhA9Q+dK8hb/dKGhBXuS/GHzPbT
         BKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725944209; x=1726549009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/XYg61hIXxY5ogTBVcq32zREuSNxjhSfJ6hVBl71PI=;
        b=Q2k2o4BCmGUPJERLSf0rE+Nke5L9xP5JjSYLTFJ8qq3i8TjJ8tiakn9leYON4iz8A0
         Vr4lrNKbL+xe4jK78itzkaMaNmTXQRd7DhfnzZvgCyFSsG3ZsazWwk4OI3kuW57/ZOVA
         DJLvww50d5ak6POmXc/JAIgqNtHTMC+bEJp1fSzQKAdkaC6DzvRdEJurI+I8aooL9+cO
         QH2QFma+FZ+xneUmPygVRZe2PUEu066FgvVERm7bcFEkX1nt6aCiUFFpc8jTMwXZHkV6
         NYmc8HcUoFNL3JiczgduD1+CVyiuZSpWgfmW3oMWEumOcixnSrY0ADLLzAB3GoRlLyQW
         Sr/g==
X-Forwarded-Encrypted: i=1; AJvYcCUdZG9j8cd9SZUH6rXRWwG/jzNTsP5MVJbhWKatDNVxNYROz8xZMHrsFrCokPgckvazuYDE+NtL/e9ENDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw16+mTo3wVq56bLXLNQgwgeYoA68ssHJBSQZApNL1SPOQjexq7
	ZIVprhmNOgKRtfHrVGq8gHwBlNvQRFBFBzSX+nDie6Y+rpR/FTbVI5HLRBh7sGNDQXMyvi9dg55
	jqw==
X-Google-Smtp-Source: AGHT+IEcHnWZ0cNYb9EfF6L3Bvf7Uqo3vEevZaQ0b6wgm6HG4/KKQpFGaY1BOWy6fF6vdUVdsAbTY0BbcKs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:e907:0:b0:6d9:d865:46c7 with SMTP id
 00721157ae682-6db95342e65mr521627b3.2.1725944208756; Mon, 09 Sep 2024
 21:56:48 -0700 (PDT)
Date: Mon,  9 Sep 2024 21:56:26 -0700
In-Reply-To: <20240829191413.900740-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829191413.900740-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <172594248786.1552336.13895527580291152046.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: Fix a lurking bug in kvm_clear_guest()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, zyr_ms@outlook.com
Content-Type: text/plain; charset="utf-8"

On Thu, 29 Aug 2024 12:14:11 -0700, Sean Christopherson wrote:
> Fix a bug in kvm_clear_guest() where it would write beyond the target
> page _if_ handed a gpa+len that would span multiple pages.  Luckily, the
> bug is unhittable in the current code base as all users ensure the
> gpa+len is bound to a single page.
> 
> Patch 2 hardens the underlying single page APIs to guard against a bad
> offset+len, e.g. so that bugs like the one in kvm_clear_guest() are noisy
> and don't escalate to an out-of-bounds access.
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/2] KVM: Write the per-page "segment" when clearing (part of) a guest page
      https://github.com/kvm-x86/linux/commit/ec495f2ab122
[2/2] KVM: Harden guest memory APIs against out-of-bounds accesses
      https://github.com/kvm-x86/linux/commit/025dde582bbf

--
https://github.com/kvm-x86/linux/tree/next

