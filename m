Return-Path: <linux-kernel+bounces-182336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D28C89D6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950781C2188F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C4012FB06;
	Fri, 17 May 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cz3rIptD"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B738412F590
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962370; cv=none; b=MEH5pUaGtAPZXULgQn8n/0++gnU+lKwJYNjSVJvr7qzOF1W6XyVA+OqL2+ev21O3QA4oJpudcpOJkRmrH8uo25jUkV/a3XDLTaoAyHNOAf4c9zpcllpxoYDkhOgH90ngnti5kbhYoD5tCcd7px6we6Vie0rQtO8TGqVNpHENpxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962370; c=relaxed/simple;
	bh=5gUro8GtU38iMRW0NhHxIp0qvlICZpEYq2lzerfQgvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I5Uy7P/JyjT7KOJFKONxMyj+y833Qp/CfDpXBQEXsWQrHCoVWgkGxMAb317TQZFe02Pb5izLvpbp1XB/cOdxp7NlmpfZ4+aQ/Ge8yn9Fwtz8XbTjAFak1bqJs6QWxT2huLNcSTREyfOkkX/hcMa0e33dRtMDWO40qTRHbTtSltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cz3rIptD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be4601434so185321447b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715962368; x=1716567168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBMN//2dzEWEm4W8Y5IMMq8lUa+WFPysYoXE9Qr+u4k=;
        b=cz3rIptDW5IdBV9G57IEiOmFo1VSmdux16+Z4cpiEWeNVSV57SajocT47ymhpw2LHt
         ZdPhNdi1xNxzpeRUbntTFBn3PahoioK22zuWkPSo7mfY8A79WgypJbjt/PBV9Lr+8mpX
         GfpH4oZLz7ExeMqHzAHYN1chiNY8oH50RxdTgfePRlUJZTBRbiPxkSNZfHqukYpKdZ7e
         EHdBHq0QFOfFggmS/BB/xDQaTh/TWj78xN1bLTPktUKJb0OmiH/3Eobtl0NY1V/B0B3t
         0wKe2hawDIghpNp1xe/6nJT4YWcupetHkjPnmmeueW22KgflYVkBVIN0d5aH7MU5CYtF
         pmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715962368; x=1716567168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBMN//2dzEWEm4W8Y5IMMq8lUa+WFPysYoXE9Qr+u4k=;
        b=bF6Nn5heUDP+5YXpFX5d+GAJImPFzX13QjN0elBCjijB5BAB0cHD8E1+1vLpGF+Cl3
         umWyaf5dUEPQnSXyXP4gm53NiEASZxGQziFIqQXb1jQTA3yKnKmbxyS6OkpZsW91/Qgv
         vE8X/uGf/StyWylKkRlg0Y9TDmW2tUpMkvaP5KzZCdtoOXzKcUIA/fBwHENXsIow+SEM
         rZdhrBcy63S7q4HpLisS1ilrsb2Q4LQKGUOqL74yAee8RiCcQQZrKW7TQ0S8Enj+xpuL
         s20vg+7vXQho5qB38lSycwclb36kxDoiXG5PN444vdajLYuCzzedf//KpDZpHZkv55n7
         7lkg==
X-Forwarded-Encrypted: i=1; AJvYcCXIv6otek/v6UcZVeo18zIOZzSb1g5nWFLI1OI9MHSnsyH8OpBLdNUIytzfs+mxm08GTTQy386p/El4ybSwWnkTkAmd1OuXq6Cmcjvu
X-Gm-Message-State: AOJu0Yz3+UXnKrHPjuhlx56RqAMst+9Pwe4Yg7GyZRTXvX9gjPo8WF85
	4PaZcL6gNNLM1jbCbJrOSdsDcFQf+9DcxdFuzmTb4KZRSkoEmR5Qd8OSMRo3k3Zw++lpFWzHW8P
	N2Q==
X-Google-Smtp-Source: AGHT+IFGzT5q2OH0P9CSzr9yrlMaLLENCNJTcHeltFHb1x5Oic5rCqblZN8M4A5Jxpu3AVVBsEkP+Rz2V2c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:338f:b0:61b:ec62:e713 with SMTP id
 00721157ae682-622b019b498mr55037307b3.10.1715962367828; Fri, 17 May 2024
 09:12:47 -0700 (PDT)
Date: Fri, 17 May 2024 09:12:45 -0700
In-Reply-To: <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517121450.20420-1-jgross@suse.com> <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
Message-ID: <Zkd28IN8KvyD4GIX@google.com>
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
From: Sean Christopherson <seanjc@google.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 17, 2024, Kirill A. Shutemov wrote:
> On Fri, May 17, 2024 at 02:14:50PM +0200, Juergen Gross wrote:
> > While testing TDX host support patches, a crash of the host has been
> > observed a few instructions after doing a seamcall. Reason was a
> > clobbered %rbp (set to 0), which occurred in spite of the TDX module
> > offering the feature NOT to modify %rbp across TDX module calls.
> > 
> > In order not having to build the host kernel with CONFIG_FRAME_POINTER,
> > save %rbp across a seamcall/tdcall.
> 
> There's a feature in TDX module 1.5 that prevents RBP modification across
> TDH.VP.ENTER SEAMCALL. See NO_RBP_MOD in TDX Module 1.5 ABI spec.

LOL, "feature".  How was clobbering RBP not treated as a bug?  I'm party joking,
but also quite serious.  Unless I'm missing something, the guest ABI changes
based on whether or not NO_RBP_MOD is enabled, as a TDVMCALL that was previously
valid would now fail if the guest attempts to expose RBP to the host.

The whole point of Intel defining a guest-host ABI is to allow interoperability
between hypervisors and guests.  Allowing the hypervisor to arbitrarily change the
ABI is asinine.

> I think it has to be enabled for all TDs and TDX modules that don't
> support it need to be rejected.

Yes, because as above, IIUC it's a breaking change for the guest ABI.

