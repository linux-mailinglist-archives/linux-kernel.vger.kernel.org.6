Return-Path: <linux-kernel+bounces-248290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A5492DB45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166A01C21407
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1DA14373D;
	Wed, 10 Jul 2024 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NolPDoS"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD963AC0C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720648409; cv=none; b=Wsv1Rc7j3mejS5T9tob4Fct55Rw6gnKO9T/Gy/Xr30+JzD90CXAVZQAV7axpg/ZGcJ2lU4cxIAUJX2oIwc5YLfW4tHl8VI3rsGm/ckzzv98DjaRqggMpUrxNXoNMb6Qi6ZRUDv95QcvxXHzyBsMqOGx5r4rBQmsGEhG4ZdHRPF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720648409; c=relaxed/simple;
	bh=rn/TCVxs+XBAD6GLf+YCrx7sLDTQwt+2xP1Hu6hMNQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cbkGkl7G5p2ZbFgzO05FBbzb99p2RJ+VpdYv7bRf26uTnWrnv10OJGyUfwJ7e0is/ZeFwCOELZ1NB5v3D4OR7182kXzypSVpUR+zT1ckC5ccbpHo+yf2VUYSTtSkivOVH6N5TT0MjOXBKNqDdcPUIZ8S2mrNO/rZvIjonWuu6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2NolPDoS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-778702b9f8fso97667a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720648407; x=1721253207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=InpQCCUUg6h/c2Mju1pPG/Gh6Z0/TXgBiLbO46ZNx3Y=;
        b=2NolPDoSdZUPj/LRtoHYmH4TzWqPbpAPH5tETyTNQ1Go1j0CjCKJXm3X9EEEMUBYOv
         JXzXKzPKEqowQy26Cl1yjNJ6SObaB8x8x6MSDcurIpevo6qvLg2HnksKZ8HVx9WiCXKf
         0FsadOXEH0OfDyKnbnb64i0yH2FT9Zqs508ds6Ddimbw2KnkbYs24BdtWgI+TmBfceXL
         0OEDisYyKQumIAcPV9NAuWEkxzOFJ/DeHkCGx4RRlT5T9lFwcTQDd7jikHNaIsybTCXr
         cPwnXI2iYvuLxPxUYqQ805fMtnDbTWTWr8oqJX55xvo7e3c6/IxCrrRnO18Ry+MyuKl7
         RjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720648407; x=1721253207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InpQCCUUg6h/c2Mju1pPG/Gh6Z0/TXgBiLbO46ZNx3Y=;
        b=xU+BvpJcclhGOM1/Nh+o2e/Vwbd50Xqe7LQsEWaYUqkO98i3LsukPDGQanlVadonxJ
         UK89NAt2svFSGTJiRQqUAcb2cjkLnYDbvcFE4rTKq+sXKRJUKmmBocVGzWwrChYX3DWd
         QOklMEHP23H4Ok7PGN5LfKaZ61aHO+CsKIjQFu9s5HtuBvF9q2/0PVqEiwmE8cbiVTXh
         qtpndOgnC0SdK1ezlV+J/EAFjDatdOWnr6JUnd3nQiUfxKmqMXSZUXIT/1MnFuKMP3eF
         XOXXAPA/F65SvDKzTG+4NKrNsbFVR7T8gUicI16l101ul8NVAYuN824d/3gpb9icNO4H
         JfjA==
X-Forwarded-Encrypted: i=1; AJvYcCVlFpMg2uXMfg6i6eCt93J0Wk0Yb5reBFpZKz+fHZXgMTGI3/foXz3Vohrv1rPZhLUxFC3pvnpMeRjJgxH/RiesKt09lr9bsUD7DODP
X-Gm-Message-State: AOJu0Yy43fCM2qxQL7I7sJVJj1CchAY13giU3VJfrCSXek1ZMUKLt0+F
	PTFYfl6dDJEeLAX6jp7wUpNKKfYUMgq0nx7rgdMKxf508Pzj50OUclKdkTwTOM3JFWYLFSBaY5L
	aog==
X-Google-Smtp-Source: AGHT+IEwT2V+os5fEtYUvDtdlJeCju0gv45EdxSCP2qzxKCXe+3yA10Yig7Ufm297VojhP8eft5okw/sizI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3759:0:b0:718:84ed:abe7 with SMTP id
 41be03b00d2f7-78734697abcmr2123a12.4.1720648407063; Wed, 10 Jul 2024 14:53:27
 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:53:25 -0700
In-Reply-To: <f21d8157-a5e9-4acb-93fc-d040e9b585c8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709132041.3625501-1-roypat@amazon.co.uk> <20240709132041.3625501-9-roypat@amazon.co.uk>
 <CA+EHjTynVpsqsudSVRgOBdNSP_XjdgKQkY_LwdqvPkpJAnAYKg@mail.gmail.com>
 <47ce1b10-e031-4ac1-b88f-9d4194533745@redhat.com> <f7106744-2add-4346-b3b6-49239de34b7f@amazon.co.uk>
 <f21d8157-a5e9-4acb-93fc-d040e9b585c8@redhat.com>
Message-ID: <Zo8C1Rz1eR96gQ1E@google.com>
Subject: Re: [RFC PATCH 8/8] kvm: gmem: Allow restricted userspace mappings
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Patrick Roy <roypat@amazon.co.uk>, Fuad Tabba <tabba@google.com>, pbonzini@redhat.com, 
	akpm@linux-foundation.org, dwmw@amazon.co.uk, rppt@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	willy@infradead.org, graf@amazon.com, derekmn@amazon.com, kalyazin@amazon.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	dmatlack@google.com, chao.p.peng@linux.intel.com, xmarcalx@amazon.co.uk, 
	James Gowans <jgowans@amazon.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 10, 2024, David Hildenbrand wrote:
> On 10.07.24 11:51, Patrick Roy wrote:
> > On 7/9/24 22:13, David Hildenbrand wrote:
> > > Note that just from staring at this commit, I don't understand the
> > > motivation *why* we would want to do that.
> > 
> > Fair - I admittedly didn't get into that as much as I probably should
> > have. In our usecase, we do not have anything that pKVM would (I think)
> > call "guest-private" memory. I think our memory can be better described
> > as guest-owned, but always shared with the VMM (e.g. userspace), but
> > ideally never shared with the host kernel. This model lets us do a lot
> > of simplifying assumptions: Things like I/O can be handled in userspace
> > without the guest explicitly sharing I/O buffers (which is not exactly
> > what we would want long-term anyway, as sharing in the guest_memfd
> > context means sharing with the host kernel), we can easily do VM
> > snapshotting without needing things like TDX's TDH.EXPORT.MEM APIs, etc.
> 
> Okay, so essentially you would want to use guest_memfd to only contain shard
> memory and disallow any pinning like for secretmem.
> 
> If so, I wonder if it wouldn't be better to simply add KVM support to
> consume *real* secretmem memory? IIRC so far there was only demand to
> probably remove the directmap of private memory in guest_memfd, not of
> shared memory.

It's also desirable to remove shared memory from the directmap, e.g. to prevent
using the directmap in a cross-VM attack.

I don't think we want to allow KVM to consume secretmem.  That would require
letting KVM gup() secretmem, which AIUI defeats the entire purpose of secretmem,
and I don't think KVM should be special.

