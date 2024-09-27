Return-Path: <linux-kernel+bounces-341981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E8498893C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA171C226C3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26931C1753;
	Fri, 27 Sep 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2YsbGfSN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D471613AA47
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727455263; cv=none; b=p05euaAPDo7/4Ga9MNztmmxqAYIITRTNg5ox9pL2nbObePkRw/SvzZ5yxuI7jdsVO0JgGCi1NFIU5TAIUzsYGO4yGFgKjuNZE5u9ybudJ0CWAFUGDtn5uUUAqps2rAH0Q6kk+xHZQErQpC15ADjl/w36qdHqi9jKWu8xVFHiH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727455263; c=relaxed/simple;
	bh=8ObVtIZ+UJHNr5088o2tQ6P8qxaunfkuhXf2P3pFZrU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aiuO/PfZdxhGdAXc6X6DLDzjuG9rnJqTOrHNJpkxvVVx09RsgagT3sywWGbSZ2u8ixjdWX+8w09Sf04eTXuOk3WKholkoljvh7jdTw0YuDm8aXDx0HHdC561QtEF94xNxSRT6W2vQnd7VkzRmoJddHOTci5YYF+OyENxN4RD1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2YsbGfSN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25cba4c68eso3636760276.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727455261; x=1728060061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pd5lh7JLuf3aCdh6awjMGA+eiHlMKt4pDNu1P6/6DGQ=;
        b=2YsbGfSNrcFZNOLF/5PoRW1Q0io4LNlMXtWW9sWwBTm6p6ifLf2C7TmF9HCdGb204W
         /RdWkU9aYO1N1+HQ5wS/VcH+wdLuNCHxhI+W86E/6YpTul658eZ8XClEdVrOrZYxI1j7
         ep4ySYitT8erqEu/c56dlUOvkFG5Zce/79h+6B5PfAn0n/ayh0H0N5Ok9EBDfdIF3x9K
         kSkc2tJDe8WKxW9IKeXlmipx9OVeKEx0zMouwKlWfpPjnCrDXV4fXaAq5Mf5yI7ip0T2
         qLvre+OBpA5Te7lD5uJ9H4e3OO5xuVh6wGWbAN/31x75gEtC4wzCIQcC54kjBsgvcD5d
         ilTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727455261; x=1728060061;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pd5lh7JLuf3aCdh6awjMGA+eiHlMKt4pDNu1P6/6DGQ=;
        b=OTP2UcD75cN8jubasf1f24jqKmCPCDBVujgrau7CGac1C7Uea6xGU4Y8HKHXkQ88VE
         H4z094zQK5ulQsj3c9h2KMNMNVugAtLeS16Kvr9pQAbWuWanTWKJhHCEDSSBIQhGXYpy
         39yg0/uIvQhnEgtjjEJ6OGTO7CLaGXVf6SN/JaIxV9Tg+c2dYbmLgvSsu15QE5NwhmCK
         ZTEoD5+QZMMP1oY2lNVuB0uIfzIN3BB1QuLiCasLyTpzOGRrPNIUqvDxie4QWvsDCxEv
         TxzxI3DETMmm0pxB4Ephiis7BcOsXlTvkPEm7h0wvW1LVM38BKD4a+Khri+ejaIM2WNx
         ahzg==
X-Forwarded-Encrypted: i=1; AJvYcCV5E4f9jjKx80/V6SZ4iq3b+vN3sfi2PF+lcKdBOx83CXxKbFuQ72w5AroJwhyARW2WA7SvGrqTFOL/D5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs11GOjYFV6jGesSOpd7OFM4LlJqhU/2XvcTUH5NhYcXVMQcfl
	HgGgeIliVVPNrlTHM+bgqraKz6GOzxp5GJlmKiBqX0SAACBZmt0GkJRF/cu+4Gk/ZLtxFie4Zg8
	sIg==
X-Google-Smtp-Source: AGHT+IGzN/iJoSyKupIZzhJVlVgfect+jrg1VTPfRFBnX66cr5FLio6KOONGPDE6VR5u3Gj59NiUEUOgtpU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:69cc:0:b0:e24:c3eb:ad03 with SMTP id
 3f1490d57ef6-e2604ca607bmr2516276.10.1727455260887; Fri, 27 Sep 2024 09:41:00
 -0700 (PDT)
Date: Fri, 27 Sep 2024 09:40:59 -0700
In-Reply-To: <de586a25-1ede-482a-8317-cb700be697b4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240927001635.501418-1-seanjc@google.com> <de586a25-1ede-482a-8317-cb700be697b4@redhat.com>
Message-ID: <ZvbgG95G3Fp9Zq98@google.com>
Subject: Re: [PATCH 0/4] KVM: x86: Revert SLOT_ZAP_ALL quirk
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024, Paolo Bonzini wrote:
> On Fri, Sep 27, 2024 at 2:18=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >=20
> > Revert the entire KVM_X86_QUIRK_SLOT_ZAP_ALL series, as the code is bug=
gy
> > for shadow MMUs, and I'm not convinced a quirk is actually the right wa=
y
> > forward.  I'm not totally opposed to it (obviously, given that I sugges=
ted
> > it at one point), but I would prefer to give ourselves ample time to so=
rt
> > out exactly how we want to move forward, i.e. not rush something in to
> > unhose v6.12.
>=20
> Yeah, the code is buggy but I think it's safe enough to use code like the
> one you wrote back in 2019; untested patch follows:

...

> (Not too sure about using the sp_has_gptes() test, which is why I haven't
> posted this yet).

Heh, I was going to ask about that too.  Luckily I read ahead :-)

To be 100% safe, I think the zap needs to purge everything, even invalid SP=
s.
I doubt it would ever cause problems to leave dangling invalid SPs, but I d=
on't
love the idea of avoiding UAF purely by relying on KVM not consuming stale =
info.

The other thing that makes my head hurt is how SPs are tracked by direct SP=
s in
the shadow MMU, i.e. by the effect of direct_map() and the guest hugepage c=
ase
(it would be weird, but legal for the guest to create a hugepage that strad=
dles
a memslot boundary) rounding the gfn for the level when creating SPs.

Hmm, but I suppose that's an argument against being paranoid for the !sp_ha=
s_gptes()
case, as KVM already creates SPs with a target gfn that isn't covered by a =
memslot.
Blech.

> With respect to the choice of API, the quirk is at least good for
> testing; this was already proven, I guess.

True.  I do think the documentation should be updated to be less prescripti=
ve,
i.e. to give KVM wiggle room.  Disabling the quirk should only _allow_ KVM =
to
a targeted/partial zap, it shouldn't _force_ KVM to do so.

> Also I think it's safe to enable it for SEV/SEV-ES VM types: they
> pretty much depend on NPT (see sev_hardware_setup), and with the
> TDP MMU it should always be better to kill the PTEs for the memslot
> (even if invalidating the whole MMU is cheap) to avoid having to
> fault all the remainder of the memory back in.  So I think the current
> version of kvm_memslot_flush_zap_all() is better than using e.g.
> kvm_arch_has_private_mem().

In practice, you're probably right.  Realistically, the only memslot remova=
l that
would be problematic is the deletion of a large memslot, at which point SEV=
+ VMs
are in for a world of hurt no matter what.

> The only straggler is software-protected VMs, which I don't care
> too much about; but if anything it's better to make them closer to
> SNP and TDX VM types.
>=20
> For now I think I'll send the existing kvm/next to Linus and we
> can sort it out next week, as the weekend (and the closure of the
> merge window) is impending...

Works for me.  Thanks!

