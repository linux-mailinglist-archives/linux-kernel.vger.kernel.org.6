Return-Path: <linux-kernel+bounces-325342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BBE975815
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96373B26856
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BD21AE845;
	Wed, 11 Sep 2024 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/MlVmZh"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52749187336
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071548; cv=none; b=aVYeI0VNNOO+9VJqSaJbP26OnisosZzJ8hyXf/Xm536smGKLug/0wlTD0j2RLwofVKx0X8tOmDj5WbPhwvC5uR1ne2s3dy/aHFh3hENQj9dHkW84+2Y9Vtw2gCqpf9ogHVvMfL10tw9LBRoEzx63ZnJ7stGvAtNaP0cGJQhduCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071548; c=relaxed/simple;
	bh=j92VXawQX8WzgcuqvPeKn8SFNLPiwFWfUHFdzldq4Iw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pFRS+PFD0fpqwzG4RmrpEh/BQ7DEAsLJtNltCfLgwDrNn3mQn7/2Pzv1ib0Ks1zNu9VIb0U9fZ1lmC9qftej6XHsU7l/ndBFCAFg53iW/5pb1isuOuHKJZmlNaa/CZ1A/yHVe8IOsdNhVuQkVa/dc4qGWOG+y+iRkIUVtWP06Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/MlVmZh; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d4fc4652f6so78704a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726071546; x=1726676346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y/QSsEQGGdeieAAmaVdQ5+5sF3iFYqq1ut09SVrphzA=;
        b=B/MlVmZhtrKSNr48QJU688Pz0KL4YbpJp/IPTznTCm1ZPDZvYNtGxfyolyITyuDdTW
         WAdF/FUqHeVFIs5mMgGMC5yLCoLClv3DOAaHNCLzeXL637pVr4Wb0ToP5MMC6DNzf8Iq
         hNtuS0k2/1jwsk3u80T26DkWblcy3USkIpjucOoUB2/7CfJvGbtSXyvHcbZc9eSTbmms
         JeXkW72XsYOi8bzzS4iAeIfuhkshTKDoxqQOGIV0RpT+ERduvMd/9aWi0t1B6qDnoIGZ
         qSIphIU+ltSr+hKyY6kmnJ1vS+TKQpEVUA95bpcxnPhVIZPlaOK7Hn+dyNadrfaypJUW
         aGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726071546; x=1726676346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/QSsEQGGdeieAAmaVdQ5+5sF3iFYqq1ut09SVrphzA=;
        b=m/DsHCzQBBdwqmzLbkYZv/SXADN9Zo3sE0DEBs36zcAWcLzjxWe5vxhsF6zoGok9FS
         KBaChmadQFBhsY49J7LniGN39t4a5BB7C4JeCRs8GCkS5zCHGYOlKXc4BEJv/ts3xLNf
         3ARkTmKlYxVvuCvPm58mIAkYAwo9jqiwzkmpYp2cwObf3rP/L7kjeZpn4xsIN96kSheN
         i5yC9QK42t1utLlvdqEfqc18BzS6i3qBXFppyNmDCfDz9+d6WygySqGAwY+QYwoOjNRI
         cHb9ZKQg7jWBh2Kw55eDFTAuP+3dUGb1DsWU1nfYscEOkbi5lcSAAq5qhzdX1qZDpSF/
         fP1g==
X-Forwarded-Encrypted: i=1; AJvYcCUu7hhdGSiCzsWiPjBJwevX6BAwwrXX5HofjuAnQFP6jVW2OpZJ8XY5LUHE3dxoUOkxV8sGKAZn+/SAIrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5tOWraWDcXqBE5BkFclKJN/hf7vVL8m7zk8SnTlXrY+uGlnow
	nJb02NcaGP4LQXk1lMVpv04PsaPv6F1UEpyKOJ1r1ZLmZkzlRVkaH87jJwU/Ir9Fkpg2YSOXbNA
	78w==
X-Google-Smtp-Source: AGHT+IF1eyVHmrdR0suwJU7aJ9NfHqMoPPNxOdM9LJ9lqscolThGIJSPyFurGdsG0uQxxZ9hll9ugl5Y4Zc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:51e:b0:702:ab97:b7aa with SMTP id
 41be03b00d2f7-7db205edb42mr51a12.7.1726071546302; Wed, 11 Sep 2024 09:19:06
 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:19:04 -0700
In-Reply-To: <d3895e03-bdfc-4f2a-a1c4-b2c95a098fb5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1724837158.git.legion@kernel.org> <cover.1725622408.git.legion@kernel.org>
 <6c158a14-ba01-4146-9c6c-8e4c035dd055@intel.com> <ZttwkLP74TrQgVtL@google.com>
 <d3895e03-bdfc-4f2a-a1c4-b2c95a098fb5@intel.com>
Message-ID: <ZuHC-G575S4A-S_m@google.com>
Subject: Re: [PATCH v6 0/6] x86/tdx: Allow MMIO instructions from userspace
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Yuan Yao <yuan.yao@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, decui@microsoft.com, 
	John.Starks@microsoft.com, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 11, 2024, Dave Hansen wrote:
> On 9/6/24 14:13, Sean Christopherson wrote:
> > Ditto for what behavior is supported/allowed.  The kernel could choose to disallow
> > userspace MMIO entirely, limit what instructions are supported, etc, in the name
> > of security, simplicity, or whatever.   Doing so would likely cause friction with
> > folks that want to run their workloads in an SNP/TDX VM, but that friction is very
> > much with the guest kernel, not with KVM.
> 
> I think by "guest kernel" you really mean "x86 maintainers".  Thanks for
> throwing us under the bus, Sean. ;)

Heh, I would argue that you tried to push me under the bus, but I'm slippery fast
and danced out of the way, and you got hit instead :-D

> I do agree with you, though.  In the process of taking the VMM out of
> the TCB, confidential computing has to fill the gap with _something_ and
> that something is usually arch-specific code in the guest kernel.
> 
> By dragging the KVM folks in here, I was less asking what KVM does per
> se and more asking for some advice from the experienced VMM folks.
> 
> > FWIW, emulating MMIO that isn't controlled by the kernel gets to be a bit of a
> > slippery slope, e.g. there are KVM patches on the list to support emulating AVX
> > instructions[*].  But, a major use case of any hypervisor is to lift-and-shift
> > workloads, and so KVM users, developers, and maintainers are quite motivated to
> > ensure that anything that works on bare metal also works on KVM.
> 
> Do you have a link for that AVX discussion?  I searched a bit but came
> up empty.

Gah, of course I forgot to paste the link.

https://lore.kernel.org/all/20240820230431.3850991-1-kbusch@meta.com

> The slippery slope is precisely what I'm worried about.  I suspect the
> AVX instructions are a combination of compilers that are increasingly
> happy to spit out AVX and users who just want to use whatever the
> compiler spits out on "pointers" in their apps that just happen to be
> pointed at MMIO.

Yep.  Based on the original report[*], it sounds like the userspace program is
doing a memcpy(), so it's hard to even argue that userspace is being silly.

[*] https://lore.kernel.org/kvm/20240304145932.4e685a38.alex.williamson@redhat.com

> But before we start digging in to avoid the slippery slope, we really do
> need to know more about the friction.  Who are we causing it for and how
> bad is it for them?

This type of issue will most likely show up in the form of an end customer moving
their workload into a TDX/SNP VM, and that workload crashing despite working just
fine when run in a regular VM.

One "answer" could be to tell users that they need to recompile with AVX+
explicitly disabled, but that's an answer that will make everyone unhappy.  E.g.
customers won't like recompiling, CSPs don't like unhappy customers, and CSPs and
hardware vendors don't want their CoCo solutions to be hard(er) to adopt.

