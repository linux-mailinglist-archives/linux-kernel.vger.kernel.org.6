Return-Path: <linux-kernel+bounces-292983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE74957764
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CA91F22736
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B9A1DD396;
	Mon, 19 Aug 2024 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzy06zf9"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32FB1D6DC6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106224; cv=none; b=ougmyjWZ6tHu62nUoZO6UkbD/kY/Zsr+gEr3UP0lijTbjShGJp3O2Twfyz4irhSLgWQMAxAnIKU+knN6Vou/p0lwn5eSTsfojvKYrAQuWBbKOxN86MbwwM/pu3sJEcAEcoSSY0gJPSINZT0y3dNla8hVKiC4KtUwbh+1VfnyVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106224; c=relaxed/simple;
	bh=/dWuuqJx6//alwTKkRAoRjouRCsQ6n8uwYXDiZcr204=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DuKTdm0udOnPfJtv+YGquIfNrqc54X29iTKJyib8kxBUh7F/TLJHrjYvxd4a9v6bbtAnbeuVzmdx93W4gZhZQIEEO8dLJiqsA7yW3q26WY0P776E7TktGnFNRPv70SSUUkXoL9IhIIQIP1NOaLRpGFz4G1liDGk78Mwqqz4aCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzy06zf9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7bc8bb2f6f5so4254389a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724106222; x=1724711022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QraVn1YFVIm9p1pLoG75UmtSb9Y9IZMVlgQbMonr5gA=;
        b=fzy06zf9cYR8tcH4kf9W0+Vfyo3xas3O6/fw/S60MDN7QrhZpQevdPxOsXtR1gnPdf
         QNa4QovaLsz7xZbyjj/KuLjNAqU00jTWCZGZXMIYKHrJO3l56Dk4yQqqO5X1IJIDSjyu
         frYs45ObiG0yLvZooLQx6Z6bZClsSLTK7P8XX8prsWZ0wurSUWh1INhJfNWmCkZ+8YZU
         hhhg2AjmOL89WRGZhxjljvvHUT1XO7FuZS2khXi2sa3qHpIjf3lB9mbbz38nsR7Zh3f7
         dGBfEwY+cxFy6MjS02eCEZ+gqPkHncxvT6BRfs7CQnhURgPtnr0qI0zw5ROkd5nKBKpW
         qppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724106222; x=1724711022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QraVn1YFVIm9p1pLoG75UmtSb9Y9IZMVlgQbMonr5gA=;
        b=GtFQLlBRmcPMCRJj+3UzqXtYxAVrPXLkHogGbFuViMULn/EuZ5rspiomZYDUUUSef1
         RHiMcJ94K6IuEfUYcFsXD7TTVpKVL2A/fJhPs9xAYyL30V5GCc2hLoN7BMsGAkwlAr+a
         TIKhinPNg36qu29yfIU97G3/3QZbIOGcEoBVvQSd5XJ4ayn7ni5WwUnRVkwQv+q24w3b
         m/jlQ5CFbLqHEdoJyUutgiKdL4VpFNAkeiA8Wgw1WMW2SToMUEh2qRyUF/UMPz6you4K
         Xc2Xyh9DvkF97sHpaI7pHhEsUbYH0QP10/s4hXdyaepega5vulNzF/70BkymK7QQi0+9
         WIPA==
X-Forwarded-Encrypted: i=1; AJvYcCWE3CqwcE9AciRZpBVoEplr5ZKxtqejhLuq53GYJF2Us7HaY4FtD0bxy97tXKZWBTYUQijE4pLeH0nq7uxviFKivcKM2uQNQxjLblWE
X-Gm-Message-State: AOJu0YyyUx4ClkFXUmhX1pYgJJNTBfteUP9ydVj7bNEBYTCrqPwc/fqa
	CjUMJGFFY5jLW6lhnGU04EBXrO+o/epQGniLEjp5tkeksuR8mntdKVB5seFeZ5HxqadRb8X/fYW
	BwA==
X-Google-Smtp-Source: AGHT+IEfTz4hLw2X3jgxGkXc0FGTTTxdn8/F6SltD4DQ4SjqMZIhumVipiAYqbvYgJdjDnEqJaAA6kOzbm8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:5ec5:0:b0:760:76b9:ade9 with SMTP id
 41be03b00d2f7-7c9791e4e77mr24563a12.1.1724106221794; Mon, 19 Aug 2024
 15:23:41 -0700 (PDT)
Date: Mon, 19 Aug 2024 15:23:40 -0700
In-Reply-To: <7208a5ac-282c-4ff5-9df2-87af6bcbcc8a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802015732.3192877-1-kim.phillips@amd.com>
 <20240802015732.3192877-3-kim.phillips@amd.com> <Zr_ZwLsqqOTlxGl2@google.com> <7208a5ac-282c-4ff5-9df2-87af6bcbcc8a@amd.com>
Message-ID: <ZsPF7FYl3xYwpJiZ@google.com>
Subject: Re: [PATCH 2/2] KVM: SEV: Configure "ALLOWED_SEV_FEATURES" VMCB Field
From: Sean Christopherson <seanjc@google.com>
To: Kim Phillips <kim.phillips@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Kishon Vijay Abraham I <kvijayab@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 19, 2024, Kim Phillips wrote:
> On 8/16/24 5:59 PM, Sean Christopherson wrote:
> > On Thu, Aug 01, 2024, Kim Phillips wrote:
> > > From: Kishon Vijay Abraham I <kvijayab@amd.com>
> > > 
> > > AMD EPYC 5th generation processors have introduced a feature that allows
> > > the hypervisor to control the SEV_FEATURES that are set for or by a
> > > guest [1]. The ALLOWED_SEV_FEATURES feature can be used by the hypervisor
> > > to enforce that SEV-ES and SEV-SNP guests cannot enable features that the
> > > hypervisor does not want to be enabled.
> > 
> > How does the host communicate to the guest which features are allowed?
> 
> I'm not familiar with any future plans to negotiate with the guest directly,

I feel like I'm missing something.  What happens if the guest wants to enable
PmcVirtualization and it's unexpectedly disallowed?  Does the guest simply panic?

> but since commit ac5c48027bac ("KVM: SEV: publish supported VMSA features"),
> userspace can retrieve sev_supported_vmsa_features via an ioctl.
> 
> > And based on this blurb:
> > 
> >    Some SEV features can only be used if the Allowed SEV Features Mask is enabled,
> >    and the mask is configured to permit the corresponding feature. If the Allowed
> >    SEV Features Mask is not enabled, these features are not available (see SEV_FEATURES
> >    in Appendix B, Table B-4).
> > 
> > and the appendix, this only applies to PmcVirtualization and SecureAvic.  Adding
> > that info in the changelog would be *very* helpful.
> 
> Ok, how about adding:
> 
> "The PmcVirtualization and SecureAvic features explicitly require
> ALLOWED_SEV_FEATURES to enable them before they can be used."
> 
> > And I see that SVM_SEV_FEAT_DEBUG_SWAP, a.k.a. DebugVirtualization, is a guest
> > controlled feature and doesn't honor ALLOWED_SEV_FEATURES.  Doesn't that mean
> > sev_vcpu_has_debug_swap() is broken, i.e. that KVM must assume the guest can
> > DebugVirtualization on and off at will?  Or am I missing something?
> 
> My understanding is that users control KVM's DEBUG_SWAP setting
> with a module parameter since commit 4dd5ecacb9a4 ("KVM: SEV: allow
> SEV-ES DebugSwap again").  If the module parameter is not set, with
> this patch, VMRUN will fail since the host doesn't allow DEBUG_SWAP.

But that's just KVM's view of vmsa_features.  With SNP's wonderful
SVM_VMGEXIT_AP_CREATE, can't the guest create a VMSA with whatever sev_features
it wants, so long as they aren't host-controllable, i.e. aren't PmcVirtualization
or SecureAvic?

