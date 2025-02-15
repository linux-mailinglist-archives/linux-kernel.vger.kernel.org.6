Return-Path: <linux-kernel+bounces-515857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0EDA369E8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2B31727DD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017E8142624;
	Sat, 15 Feb 2025 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2DO5y6Ax"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBAF5B211
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578729; cv=none; b=T0hyhjnHs1ps9m1Mequ1ayTYxTVH8gTiJ3McHktoHSiPeCc0C+Tw+r2hta4NRy/6ntuEhPgrLFhap8L0tZy38o+f3CQDVeYTVYOgrgPJLVHg0RvJn6YC9lweC7TaOKMSR3rIqbx6nX9JMSKtargC5awMU/UcsaH5Fnc1vuyNkZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578729; c=relaxed/simple;
	bh=LBAJCUPYJCA2TRcJxjqvWB6FzkhZPiCg6HIahBiWHVY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qjBdMw80t72JGnE8fTi/aWttZZt+g8yhI90sTnXs7FDLswesGXsd1U0SApCqzYU7DgKexqgqSE7TC6r5pcdXKh01yQ34CMLRRC0tnTPpFMemPJ6vKcCw2fAz/H7ePmeSbUx/klpbM58avZ8aIDjHPGC/WWf4VW84OoxGX0X6e0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2DO5y6Ax; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1e7efe00so4142922a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739578727; x=1740183527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i3a0TGsAUIBu018CD+hYblNeJ5zu28OsdVMzDvpLRuM=;
        b=2DO5y6AxljwSDAxxJQcxFKSkbIFSrflBga3G3FBaV7u4eTEOTpseLmyAcIqWTHDU+l
         OdjWcOYxMGzK5cRa8VhN1YO0l5HKJGnWcnNQ8ppZWe/Y5FvrJj98QHWdKLY+66k5EHEg
         j81wmY2OB73zmEErx+rwgruOjmVXm057xBNoBgAsyfmFp8psqxKw37E62pWRfxgW8Wo0
         r+U8rARYNdiNibjsbVzdy2yyHqBikuIPzGaCMLu/GFW0NL1QCAZkvPEJFwP0x5NK0axp
         9ZRoTq46bN0ZSPjDFozCfZu5nFEkEgpYWLR2qo9LUsuHRsgIX9ExlD0uUsOZVR0HPZX7
         3SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739578727; x=1740183527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3a0TGsAUIBu018CD+hYblNeJ5zu28OsdVMzDvpLRuM=;
        b=xJp/X2JIoUz0kZFM11bOMn6Gt3Hd8IKUAZxAKvke62Jzn1zJwgO+I6WUZd0c4Cft5D
         iPrrKUt2UkHe4G+KiPSpg6LwU3qx5KSYVPGK2isbOuc0ZyWwSrhYf0CWv6xOxMA1RpV6
         jcWEjD33+0OVrRiDVZqknH8iHY2cmwD61ngeb63/or7Vs5HWnWvce1n5HGg5q9Fo++zo
         TS8fld2RQEvMvouNhIvu1SPDlusVKrAlbBhe/1s5u0uZJzfF3E7kwJ/J4DA6T+A3A678
         mhxK16DsehCRPgWMmNxHn9D5JXDtgTxnHWt06pmJzjqkiTpKFiZj9A5o91TmluR8oA4p
         WaIg==
X-Forwarded-Encrypted: i=1; AJvYcCWE3XW1QMNjtQVVgQ4gWWNrftZ/1/SPBV9yb+NFTcTtDOGMqK6rM5kymklZj0B3Igugf+9xj0uorH6eq9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+8qJWq4HSvW8FQO383Q5134C6iNyst7Qt/YuFrPwW1rSe1GN
	U3VBkbHkzOdv6P9aXyelFx8mQLRguRn2ux60EmqoDmdj0fhlZ6Adv+zp/fNvdYqYBPgeerwcyut
	5PQ==
X-Google-Smtp-Source: AGHT+IE0yvOhD2bUFD5Lv2k7Idz48+lVu+WWA4hpucain2GNHamWszZo07q9krpHCcUcAamUI27M8dS4Mm0=
X-Received: from pjbdy13.prod.google.com ([2002:a17:90b:6cd:b0:2f9:dc36:b11])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e46:b0:2fa:157e:c790
 with SMTP id 98e67ed59e1d1-2fc40d14e35mr1645220a91.5.1739578726956; Fri, 14
 Feb 2025 16:18:46 -0800 (PST)
Date: Fri, 14 Feb 2025 16:18:45 -0800
In-Reply-To: <1db73488-4095-4ac1-ad10-139615981de2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250125011833.3644371-1-seanjc@google.com> <20250214234058.2074135-1-pbonzini@redhat.com>
 <Z6_ai1HdLWiTJ2Pf@google.com> <1db73488-4095-4ac1-ad10-139615981de2@redhat.com>
Message-ID: <Z6_dZTbQbgr2iY6Q@google.com>
Subject: Re: [PATCH] KVM: x86: Load DR6 with guest value only before entering
 .vcpu_run() loop
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Stultz <jstultz@google.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Feb 15, 2025, Paolo Bonzini wrote:
> On 2/15/25 01:06, Sean Christopherson wrote:
> > On Fri, Feb 14, 2025, Paolo Bonzini wrote:
> > > Queued, thanks.
> > 
> > Drat, I was too slow today.  I applied and pushed this to "kvm-x86 fixes" and
> > linux-next (as of yesterday), along with a few other things, I just haven't sent
> > out the "thanks" yet (got sidetracked).
> > 
> > If you want to grab those, here's a semi-impromptu pull request.  Otherwise I'll
> > just drop this particular commit.
> 
> I had "KVM: nSVM: Enter guest mode before initializing nested NPT MMU" on my
> list, but not the others.
> 
> I'll just pull these, thanks.

Heh, while you're here, here's combined pull request for the selftests changes
that missed 6.14 due to the pmu_counters_test snafumi[1][2]?

I'm a-ok if you want to hold off until 6.15.  I have them sitting in a separate
branch (selftests_6.14), and don't anticipate conflicts, so it's no trouble to
carry them until the next merge window.

[1] https://lore.kernel.org/all/Z6qN3wPXH4cbRzLP@google.com
[2] https://lore.kernel.org/all/20250117010718.2328467-5-seanjc@google.com

---
The following changes since commit 10b2c8a67c4b8ec15f9d07d177f63b563418e948:

  Merge tag 'kvm-x86-fixes-6.13-rcN' of https://github.com/kvm-x86/linux into HEAD (2024-12-22 12:59:33 -0500)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-6.14-2

for you to fetch changes up to 54108e73344480c3e5f3799129970009f52c59f4:

  KVM: selftests: Print out the actual Top-Down Slots count on failure (2025-02-12 08:34:56 -0800)

----------------------------------------------------------------
KVM selftests changes for 6.14:

 - Misc cleanups and prep work.

 - Annotate _no_printf() with "printf" so that pr_debug() statements are
   checked by the compiler for default builds (and pr_info() when QUIET).

 - Attempt to whack the last LLC references/misses mole in the Intel PMU
   counters test by adding a data load and doing CLFLUSH{OPT} on the data
   instead of the code being executed.  The theory is that modern Intel CPUs
   have learned new code prefetching tricks that bypass the PMU counters.

 - Fix a flaw in the Intel PMU counters test where it asserts that an event is
   counting correctly without actually knowing what the event counts on the
   underlying hardware.

----------------------------------------------------------------
Chen Ni (1):
      KVM: selftests: Remove unneeded semicolon

Colton Lewis (2):
      KVM: selftests: Fix typos in x86's PMU counter test's macro variable use
      KVM: selftests: Add defines for AMD PMU CPUID features and properties

Isaku Yamahata (1):
      KVM: selftests: Add printf attribute to _no_printf()

Sean Christopherson (7):
      KVM: selftests: Use data load to trigger LLC references/misses in Intel PMU
      KVM: selftests: Add helpers for locally (un)blocking IRQs on x86
      KVM: selftests: Make Intel arch events globally available in PMU counters test
      KVM: selftests: Only validate counts for hardware-supported arch events
      KVM: selftests: Remove dead code in Intel PMU counters test
      KVM: selftests: Drop the "feature event" param from guest test helpers
      KVM: selftests: Print out the actual Top-Down Slots count on failure

 tools/testing/selftests/kvm/access_tracking_perf_test.c |   2 +-
 tools/testing/selftests/kvm/include/test_util.h         |   2 +-
 tools/testing/selftests/kvm/include/x86/processor.h     |  47 +++++++++++++++++++++++++++++++++
 tools/testing/selftests/kvm/x86/hyperv_ipi.c            |   6 +++--
 tools/testing/selftests/kvm/x86/pmu_counters_test.c     | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------
 tools/testing/selftests/kvm/x86/svm_int_ctl_test.c      |   5 +---
 tools/testing/selftests/kvm/x86/ucna_injection_test.c   |   2 +-
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c        |   3 ++-
 tools/testing/selftests/kvm/x86/xapic_state_test.c      |   4 +--
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c       |   5 +---
 10 files changed, 151 insertions(+), 83 deletions(-)

