Return-Path: <linux-kernel+bounces-286517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF9951BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129051F24A13
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678A71B151D;
	Wed, 14 Aug 2024 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqqBjltb"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A181B14EC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642541; cv=none; b=Vw3G6NQMgJeVfZET2kq7rukFYth0HN/VmPCJSeM3lQATZlMOlgWTaoCrYqfDAOM4NBBwtf7cUlum8NMTv566i+NjnkfwRLzYy5JMKwsZe211GxILG9JBRdwIspzk4av9IQQUOU/MxOROF+kv1jmghC8Sieq6ilt+9lx0lJL+Y3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642541; c=relaxed/simple;
	bh=HArTnaIs5I706mOz1poccY5SHaZ05WHMDlgQ4maz0tE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YYIpm2iuHQbj7MJZqCjq0/bUkVefovoX9hsusR2i9elOeyKLHZ10YQ4Ydr1ohi/Fzm9ewUEgu0iHjWBC1tXcUZAfU4dxmI+KMhB0HcQ88ZddTlC4Drj0flKqUNfZLtDb1TYNpIwschThSHgKm2mQt6GwOM3pMBpR8HWH8IHpH0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqqBjltb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso686889276.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723642539; x=1724247339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2yB1fsNKU+rC23A4wdfQI4foI6aJ47uPDU6FQQvIzDE=;
        b=sqqBjltbRuqZKdl/R1S21JZS6DfsVtKax/m1ec5xJ3h4pjUACi08an6Be5wgczgXrY
         vrW76LaJ6353pXPVg8EDA9vulMoH9TDhdSH8DvTOxQ01gPvBkdPhtZ/Z2le5JBVtqmr5
         oDQ43tgOjwrs6B4sHpD5jhe4iK1lHappMzrz9CsBXyFsWyJbS0TzUitfUdZZz1WLfRUF
         HdcRWQy5bW4DRFgHBWiQNN8JpMh7QBy0Yp+flHzARl4Xx/b1fyDqTk886QxiF4ufJn4f
         YC9sS8l+aklQCN5gHCs70fkNNuLTpYBAD1czQePrrE8CZWGAL8ncxEU7XyIFxXlYI5lW
         qaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723642539; x=1724247339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yB1fsNKU+rC23A4wdfQI4foI6aJ47uPDU6FQQvIzDE=;
        b=V8lNfLufPwiTyT/WjeKdpzoEweJznh/HGXMtgftMh1q/D8HwwT0x1X9ziOfwpaGvzR
         Ztsk8qNi5ukAsRr+7gcFacosZ1zYk8kLm9DImdaWx1qhInFZsiHnmxP/vLE2PYP/6OU3
         WWCwjW7nCwNemsEHqaAVG/uHblrEEq0Dd5M5xw/04/6AHYlyYXogmKO7oujS3IqIXAN0
         zrSIpBpqiJWXCq956zs11nXQGypGiPR9D6qIShY9fd2MNFbNftW5IDM/uR3LDnwgrQ3l
         wihBEdMVCDdQ0cU2NEcUYhhRTQU0iEC69e1atrc+y5CAYE8DXnbFebwM+z6xxQtWNqtH
         faPA==
X-Forwarded-Encrypted: i=1; AJvYcCUk+XlSoEhQACJVYI9Ev5/CYWXFXToUh+/xWBEofcONXq0pp/n6JpasaFxZBkOc4DpF+Hzc8c9WAwOVzNcgFqHp6cAVu9BznNAj4miU
X-Gm-Message-State: AOJu0Yx39LQx1TnAlI0y1xxgn18syZZLkiLOxyUD0z83OE7AsRs8XDsW
	6ub5n+EynFo4LXKtwO81SLz6m08eGg/xMor2b1xC8QUqaKlv8tRLbkZLKlRoUL6SLU8pmNmI3HM
	gcw==
X-Google-Smtp-Source: AGHT+IEdY6D4ceAOiB1K58rOcRL2CYndwzpMFmSnJbi8t4xsgcKGLtqnGBvdw/DDXolwv1dqY4+g/ThZRes=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:788:0:b0:e0b:f6aa:8088 with SMTP id
 3f1490d57ef6-e1154eb1c7fmr73408276.1.1723642539048; Wed, 14 Aug 2024 06:35:39
 -0700 (PDT)
Date: Wed, 14 Aug 2024 06:35:37 -0700
In-Reply-To: <ZryLE+wNxhYHpyIP@chao-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-26-rick.p.edgecombe@intel.com> <ZrtEvEh4UJ6ZbPq5@chao-email>
 <efc22d22-9cb6-41f7-a703-e96cbaf0aca7@intel.com> <Zrv+uHq2/mm4H58x@chao-email>
 <ZrwFWiSQc6pRHrCG@google.com> <ZryLE+wNxhYHpyIP@chao-email>
Message-ID: <Zryyqe6ibAR9h-yq@google.com>
Subject: Re: [PATCH 25/25] KVM: x86: Add CPUID bits missing from KVM_GET_SUPPORTED_CPUID
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	pbonzini@redhat.com, kvm@vger.kernel.org, kai.huang@intel.com, 
	isaku.yamahata@gmail.com, tony.lindgren@linux.intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 14, 2024, Chao Gao wrote:
> On Tue, Aug 13, 2024 at 06:16:10PM -0700, Sean Christopherson wrote:
> >On Wed, Aug 14, 2024, Chao Gao wrote:
> >> On Tue, Aug 13, 2024 at 11:14:31PM +0800, Xiaoyao Li wrote:
> >> >On 8/13/2024 7:34 PM, Chao Gao wrote:
> >> >> I think adding new fixed-1 bits is fine as long as they don't break KVM, i.e.,
> >> >> KVM shouldn't need to take any action for the new fixed-1 bits, like
> >> >> saving/restoring more host CPU states across TD-enter/exit or emulating
> >> >> CPUID/MSR accesses from guests
> >> >
> >> >I disagree. Adding new fixed-1 bits in a newer TDX module can lead to a
> >> >different TD with same cpu model.
> >> 
> >> The new TDX module simply doesn't support old CPU models.
> >
> >What happens if the new TDX module is needed to fix a security issue?  Or if a
> >customer wants to support a heterogenous migration pool, and older (physical)
> >CPUs don't support the feature?  Or if a customer wants to continue hosting
> >existing VM shapes on newer hardware?
> >
> >> QEMU can report an error and define a new CPU model that works with the TDX
> >> module. Sometimes, CPUs may drop features;
> >
> >Very, very rarely.  And when it does happen, there are years of warning before
> >the features are dropped.
> >
> >> this may cause KVM to not support some features and in turn some old CPU
> >> models having those features cannot be supported.  is it a requirement for
> >> TDX modules alone that old CPU models must always be supported?
> >
> >Not a hard requirement, but a pretty firm one.  There needs to be sane, reasonable
> >behavior, or we're going to have problems.
> 
> OK. So, the expectation is the TDX module should avoid adding new fixed-1 bits.
> 
> I suppose this also applies to "native" CPUID bits, which are not configurable
> and simply reflected as native values to TDs.

Yes, unless all of Intel's customers are ok with the effective restriction that
the *only* valid vCPU model for a TDX VM is the real underlying CPU model.  To
me, that seems like a poor bet to make.  The cost of allowing feature bits to be
flexible isn't _that_ high, versus the potential cost of forcing customers to
change how they operate and manage VM shapes, CPU/platform upgrades, etc.

Maybe Intel has already had those conversations with product folk and everyone
is ok with the restriction, it just seems like very avoidable pain to me.

> One scenario where "fixed-1" bits can help is: we discover a security issue and
> release a microcode update to expose a feature indicating which CPUs are
> vulnerable. if the TDX module allows the VMM to configure the feature as 0
> (i.e., not vulnerable) on vulnerable CPUs, a TD might incorrectly assume it's
> not vulnerable, creating a security issue.
>
> I think in above case, the TDX module has to add a "fixed-1" bit. An example of
> such a feature is RRSBA in the IA32_ARCH_CAPABILITIES MSR.

That would be fine, I would classify that as reasonable.  However, that scenario
doesn't really work in practice, at least not the way Intel probably hopes it
plays out.  For the new fixed-1 bit to provide value, it would require a guest
reboot and likely a guets kernel upgrade.

