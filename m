Return-Path: <linux-kernel+bounces-303589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1AE960F80
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3573C1F216F9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D634D1C6F54;
	Tue, 27 Aug 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ad7wNr/c"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE681BC097
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770720; cv=none; b=fYhc/K+fJVZYynEGf+/tO9qBRXzfSY+6BRyopx4HnsqOippHWsSP/PYyFu2xiiP8W7w1yLEcACEWF35c+ugjB6xwLoNLmDRfKaZDhWz9TX6xEyWG7CySw9ZGcuZ8ch0+6uSDak5Xs9bpA6aNdWnQLCvO+yFvPuqgJtOqQj656v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770720; c=relaxed/simple;
	bh=3I2THv3dSdvEgyjGAX1XWmuy+u9ynCpNqFOiw00iQqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QzdPcXxTwfKoyQ9v8CcRLfPyHgVIu2brZO5WujttwLHehm/l4RESDDp7NCZng1AiNzxdCuLS60Bv/Yey6p4jAO4xpvVzXbE26riBZKEJccGWruqf0vvkc39X2u48ZW6AiDqfZKce2xIMn0wDX4qQBbk/QjYYmORrLWH4xeDGsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ad7wNr/c; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ad9ffa0d77so124220647b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724770718; x=1725375518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fONAJzSPXJgS2E0aa1RG3E+PnMHkS/LlRgeU//cGs3g=;
        b=ad7wNr/cHcqMDLopbveJGleObK50AajdCt4UReMRaSVH7FflnvqjAVPmE0hh+PUYXa
         hVPLUG7snUyuiHpH4ZxxNYrdxp3yi1bCTQxPytHz1JmD7cHTjsy8vsuNbwPkhP3BU7OM
         uAkZD7KU3m1TPhAKbzbPbbRvMNbDy55gMNTfjGL1KtnyrFPkt9e1jAkYB+838Ea3tA4n
         wIR8knPIB+UEGeuEFUrAijGfOwOUTcJzAvgFbLGaj+HyrWvKfBpnSvhpbJEB/DCAgeKX
         Tw0DI+PKtQXN/uaj/TLZTb0Daa503dBOho4Hrd2efdoeYl57E74q+vHEwM3SaIv0rvBl
         /yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770718; x=1725375518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fONAJzSPXJgS2E0aa1RG3E+PnMHkS/LlRgeU//cGs3g=;
        b=pHlzVEyE9vTLHKny7vKGPqvSz65jjA0Ey3YuyK91S6x3xppqCrXHrrMGtBeFid1ybU
         PHCGlQd7drtGuR7VcyV4g7hoSIGU6Dokqtz+zAG9FTM1JDNhyRXoXjH0GUD10OPP6KWw
         D8IZyyg0owgKigFYcDwUbXkO9tx/x7mhpy2BuXBO9X/BmuGfkyMEy8nKULcH0vU5HJB9
         tL45H233Gy43dHASk3A2yXqzagP7rB9c97W66l+95yozgECOOp/0K6ONNv4xvfyHlNaX
         8ja+QI++pQCfTIwS9pqZC2HuKJL8tfzAAwkYjvjBPc6KfRtMxOExPPvywZ1VCA1cEaVb
         TVqA==
X-Forwarded-Encrypted: i=1; AJvYcCUkBIuORchgekeNVZDs0XpG+dXe61hH6vEo6Mlbpg3G6mTEuevstE/M6naF2A9jjoDXLgPlOpKm7DonzjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVBjriSkjejHO0TTpsFXcqAv0x6RIO1RfcWggXgGEArJfWdnrj
	QR0S5Uftsft7H5bgVob6P4AooA1HCPlPMvTd4W6pEcoNHjrvhEGaovIVUE059iW2KPG9m3eGM+R
	evQ==
X-Google-Smtp-Source: AGHT+IGPv8KyV3YTJySaqmnO+sjnyzAX6tyncaux3vPFeGvPgqRoln41rSLX7+OwzrOwdJXPf8cjwTcd3do=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ce08:0:b0:663:ddc1:eab8 with SMTP id
 00721157ae682-6c6289a745bmr719277b3.4.1724770717699; Tue, 27 Aug 2024
 07:58:37 -0700 (PDT)
Date: Tue, 27 Aug 2024 07:58:36 -0700
In-Reply-To: <31611f4136230893bbcffc98619bfb93c5a42ef1.camel@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240823191354.4141950-1-seanjc@google.com> <20240823191354.4141950-2-seanjc@google.com>
 <31611f4136230893bbcffc98619bfb93c5a42ef1.camel@amazon.co.uk>
Message-ID: <Zs3pnCj6wUWD2K-8@google.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Add a test for coalesced MMIO (and
 PIO on x86)
From: Sean Christopherson <seanjc@google.com>
To: Ilias Stamatis <ilstam@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "maz@kernel.org" <maz@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "anup@brainfault.org" <anup@brainfault.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "paul@xen.org" <paul@xen.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 27, 2024, Ilias Stamatis wrote:
> On Fri, 2024-08-23 at 12:13 -0700, Sean Christopherson wrote:
> > Add a test to verify that KVM correctly exits (or not) when a vCPU's
> > coalesced I/O ring is full (or isn't).  Iterate over all legal starting
> > points in the ring (with an empty ring), and verify that KVM doesn't exit
> > until the ring is full.
> > 
> > Opportunistically verify that KVM exits immediately on non-coalesced I/O,
> > either because the MMIO/PIO region was never registered, or because a
> > previous region was unregistered.
> > 
> > This is a regression test for a KVM bug where KVM would prematurely exit
> > due to bad math resulting in a false positive if the first entry in the
> > ring was before the halfway mark.  See commit 92f6d4130497 ("KVM: Fix
> > coalesced_mmio_has_room() to avoid premature userspace exit").
> > 
> > Enable the test for x86, arm64, and risc-v, i.e. all architectures except
> > s390, which doesn't have MMIO.
> > 
> > On x86, which has both MMIO and PIO, interleave MMIO and PIO into the same
> > ring, as KVM shouldn't exit until a non-coalesced I/O is encountered,
> > regardless of whether the ring is filled with MMIO, PIO, or both.
> 
> I guess there is some overlap between this patch and the one I proposed
> here:
> https://lore.kernel.org/kvm/20240820133333.1724191-7-ilstam@amazon.com/

/facepalm

> Even though my test depends on the new ioctls that the series
> introduces. However, both the existing v1 API and the new proposed v2
> API take the same code path internally when trying to push to the ring
> buffer.

Sorry, I completely spaced on the fact that you had already written a selftest.
I'll take a closer look at your selftest and see how best to smush the two
together.

