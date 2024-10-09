Return-Path: <linux-kernel+bounces-357721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE789974BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D293628ABDC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA521DEFE8;
	Wed,  9 Oct 2024 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XioKq7wF"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12A23BE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497866; cv=none; b=s8GLW5eqKYeGU2Vcn9yWo4ijZ7ABH7DJH4uOJjbEYXvmy6tWFcc33cqO6dN7zUQCUSCk6YIYl3IA0LkSfJJKS/pN+Jnp2RdThANwVZYDsUxt1XrvmtDHq7lox0BWwAw+oFCcJFfLqxzayKZaKi14CDReOmUrgbbqDAsI/SynPR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497866; c=relaxed/simple;
	bh=u4Z+d0zswEV00eEgka9l54YerDqync+/bcr9ct1nfKc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MSC+T31MO9ODN3xVGH5moFoMdeDb5x83djYIKD1K7Ad1UctlMj3MyZLS9x09pLrQJ/VA1Y1pE2DKw1Tmpiy3UtJWvDBBv3ibmdvtt3hzuE3hJb5OjgRxh8tfXVKOzF7mgo/sDA/QqOu0lE5IyFjik4i2rNaH49fRNEumoW//Y/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XioKq7wF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e22f8dc491so4002687b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728497864; x=1729102664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGkwLmUBZmzSdwcH9I89u+YORoK/3wsOAYXPoCJPeP8=;
        b=XioKq7wFfiLIr/jh2/tQTpPCiWmmFTJLeQRDvAuHc5TN2zs+9juwOTL0igN9V/YHL5
         UEJvrSIHdpancsazc1dfdQjyv+BXdej3/NWrG06Rs5jieUbQCbwhelNOtBIySxilvdUn
         NxOdikEcOUNRzCtT7gJIet7p+ocb7ohl7v6b3z12r8/WJCTFSQvosCE1C16gvLTsCXGM
         dj6+YZM4uOvpTxJ4GsQHJIxaVFCTF3BjhIMGxYbaWm4QsbxLKIVCusCWRVX45L11L5js
         7esujG0HwlKJpD+VPPthFNTsQK6fKbNZ9HwrgGPMqcC759NcdMKs8lJpQnbHRDDGW8Jx
         qhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497864; x=1729102664;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGkwLmUBZmzSdwcH9I89u+YORoK/3wsOAYXPoCJPeP8=;
        b=FNIUy5qjvQ2F6y63lBnz4qyZ0T8jspmJcGQUjdUypjhhD4dOpAeeGA4+iapM4zPzaM
         ELQd3RRBMTTfmafDo/W/xiFW/jCXnKhlz8i9jSvcweOzWAWzlHeL7u9Tf9u9imFhb3Wj
         S3FNUHCmir/CJgp3PFYK0c0HSu8hZYdYtkm2cPwrHWsRVbb9mpsFAQIke66FZlJt+tEl
         +YqLM1F0ubBEXpwEcU2nUYJPc0sWEPlgQGFr7bbt3L3hQlq+uNCIiJOPuYTrWbtljgMr
         gm/3tpnMKGDQ7LNipkk6yJiVT+bRrwdXO5mw9zRsycjO5WUE6XLLYh+3A8TRNCa2DCh4
         83Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWmfrRymLnvNgbdya9JsEx2Po/5HH1vZIxsBHtt2Bvm1Jc3teD6dvq28+OzW4KZtt2rd3uhNHG/RgJIxNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP++okG2oafMrSeuhxWVr+KU4yKkicXmFzyW8r9J5DsAI0kzda
	DrsQz3sqd0p3ZWv48DxWzgZ5cadEjRneyJgrhIEy6TwRkOGu+QamNnS+pz2mk1jeDj3mBq0VFbq
	N7g==
X-Google-Smtp-Source: AGHT+IHMOtTTNEE0OqphHiKJfCCNIOTEwynPKA5+5txdjDc5FPXvwTx2vapx9bhN6DM4b5Wgki1gEiMkqfI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2908:b0:6e2:120b:be57 with SMTP id
 00721157ae682-6e322469a89mr140387b3.5.1728497863885; Wed, 09 Oct 2024
 11:17:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 11:17:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241009181742.1128779-1-seanjc@google.com>
Subject: [PATCH 0/7] KVM: x86: Clean up MSR_IA32_APICBASE_BASE code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Clean up code related to setting and getting MSR_IA32_APICBASE_BASE.

E.g. it's absurdly difficult to tease out that kvm_set_apic_base() exists
purely to avoid an extra call to kvm_recalculate_apic_map() (which may or
may not be worth the code, but whatever).

Simiarly, it's quite difficult to see that kvm_lapic_set_base() doesn't
do anything useful if the incoming MSR value is the same as the current
value.

Sean Christopherson (7):
  KVM: x86: Short-circuit all kvm_lapic_set_base() if MSR value isn't
    changing
  KVM: x86: Drop superfluous kvm_lapic_set_base() call when setting APIC
    state
  KVM: x86: Get vcpu->arch.apic_base directly and drop
    kvm_get_apic_base()
  KVM: x86: Inline kvm_get_apic_mode() in lapic.h
  KVM: x86: Move kvm_set_apic_base() implementation to lapic.c (from
    x86.c)
  KVM: x86: Rename APIC base setters to better capture their
    relationship
  KVM: x86: Make kvm_recalculate_apic_map() local to lapic.c

 arch/x86/kvm/lapic.c | 31 +++++++++++++++++++++++++++----
 arch/x86/kvm/lapic.h | 11 ++++++-----
 arch/x86/kvm/x86.c   | 42 +++++-------------------------------------
 3 files changed, 38 insertions(+), 46 deletions(-)


base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.47.0.rc1.288.g06298d1525-goog


