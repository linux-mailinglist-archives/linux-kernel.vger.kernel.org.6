Return-Path: <linux-kernel+bounces-251239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747C1930288
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2122A1F22AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201DE13667E;
	Fri, 12 Jul 2024 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gyqAPOKt"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C3133402
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828628; cv=none; b=TCK0/2d35QwZ0ffw+7PGmmpIwWd+X76WjrtC4GB9XCa4czUvG8f5DZ3kxf21plchm4mCzz2x470z/r3MYyFIj8dJV75z2z5rlvaLDLicyQMCDR/Gr5iIEOe1obQmh+3ThLgDJC3Ilt1yK7LXAQjgMsS5CMdSL2rkqu6Ph/nc4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828628; c=relaxed/simple;
	bh=PPbs85Xr93LPkWh/ukScSpYJTvw+/60F8PPXDJV6wTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W0FiWW4SByhh2UJ9BEOlXLAN8Mh/UWEhvWb6T6sZlqi/5qZq88GDcYDBGvnfgcmuwPlmWl3ZTuxBXtV70FQeMx0ABzpenHTj6c3dkZKwF3WJvW35x2mKrYl2kxLuXoJ/Dt0YvvKC07kxwHYLGJ+hWz9Dzr6N8Wc3r2c7wSn3chY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gyqAPOKt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fb1c206242so19684095ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720828626; x=1721433426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iyA9y22et3aPVofN6lk67YcTJqeYEQiTdMNcp/wmhvw=;
        b=gyqAPOKtSPxy21aWvNUdf1hGdMIqvSoEzJjVeljuLyE7mkxZZd2Ds3Ry57r0O66mVO
         9wzKdUlwPC3dcYRZeApui5PzcoHAQQ+EscsNkKDJjgaHeXE02let6hIWz6KFuPjOr74r
         xupIkz+x/NpMEJKUg2e4CKKmKKVw7fZ55QMORlc5FxO+PaSK3pMj96PW9YD9OJwQpSXd
         kLZCzPQHFKxocEoSN3UY/UNg0HfGSlqpDMyPw5pxVAK056ZvcTIMNKyLytkEkqsOgFjO
         ZuipoJYrdeDd0QFuk9hKgOE9IuPqTZoxCeel1iEtzcni1T5UEzdhk0uhmW5NXyRZg5CC
         RDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720828626; x=1721433426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyA9y22et3aPVofN6lk67YcTJqeYEQiTdMNcp/wmhvw=;
        b=Y8EiBTrd/Eww1CNXegJQQDFDmtl22QJfC6XZdtmheFytlFEOiewmdvodvo1AYiTo4+
         2KEgk4K+Pgu+Z0yAIx9Mby2bRRE5A57frUJnhtLRkADT1HKVDa2+9nga95BVpsWJV753
         0xxfbM84Fcr2ne5sOhtzSnLLHV8GWDWx8jlL7i/MaRFNoWUwJixTwZD/2Y/BIFO/2vM5
         VM5FyYaKJ5U3H16f6xJanAom4Te4oMZGXDOUFXHaeH0AEJTf66FhIEUWItF0fIfHH5SQ
         /+fpBiVRzAoDpV0MWjf0EpK1M0Z9z1NWJpX8XjEU5uKZqWAmq02l7w7iz6F5yfn6e9m4
         0KjA==
X-Forwarded-Encrypted: i=1; AJvYcCXCydmSfWLFpfISzasbAeUr8tpuaf1LsxZHFqAF/7ueUloE+8e4xVrtgbIW0HKWIg6JAnOlv1yRVVQ8uUSGeVo9mer/rb5gNAjQGiX8
X-Gm-Message-State: AOJu0Yyj8s0oz0a95BZ7SN8xXCS28EUPZQP996BVYb6a6sAFeotibUDj
	+g7/SHon/k86cQ1SkMWS6OygR6Lqaylh1WN9/ei1zOyjkaa/BnP39hMOa1bV7voLfDNwg15/2N6
	+6A==
X-Google-Smtp-Source: AGHT+IF+0/8XomBseSBMK9G+u6kE65Tl8v0FbPTZLVI1QaezRaJexDr9SlJqqLHb0tJvQTQ9+A9QFXADn/w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:da89:b0:1fb:90d7:a35a with SMTP id
 d9443c01a7336-1fbb6d66842mr8187915ad.11.1720828626343; Fri, 12 Jul 2024
 16:57:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jul 2024 16:56:51 -0700
In-Reply-To: <20240712235701.1458888-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712235701.1458888-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712235701.1458888-2-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Single Xen fix for 6.10 or 6.11
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A one-off fix for KVM Xen.  This pull request is built on kvm/master, and
tagged somewhat ambiguously in case you deem it worthy of 6.10.

The following changes since commit dee67a94d4c6cbd05b8f6e1181498e94caa33334:

  Merge tag 'kvm-x86-fixes-6.10-rcN' of https://github.com/kvm-x86/linux into HEAD (2024-06-21 08:03:55 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.10-11

for you to fetch changes up to ebbdf37ce9abb597015fa85df6630ebfa7d0a97f:

  KVM: Validate hva in kvm_gpc_activate_hva() to fix __kvm_gpc_refresh() WARN (2024-06-28 08:31:46 -0700)

----------------------------------------------------------------
KVM Xen:

Fix a bug where KVM fails to check the validity of an incoming userspace
virtual address and tries to activate a gfn_to_pfn_cache with a kernel address.

----------------------------------------------------------------
Pei Li (1):
      KVM: Validate hva in kvm_gpc_activate_hva() to fix __kvm_gpc_refresh() WARN

 arch/x86/kvm/xen.c  | 2 +-
 virt/kvm/pfncache.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)


