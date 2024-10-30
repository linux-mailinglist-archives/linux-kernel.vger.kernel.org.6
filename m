Return-Path: <linux-kernel+bounces-388884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 086E89B65B1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71CC1F21E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6FD1F12F9;
	Wed, 30 Oct 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvF85vPJ"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501691EABA5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298309; cv=none; b=jLp0wGXFRSReOcKPOY4ZE7XoDlPn1kioDxnPZlFdIHrnnszVF1/MnuW9tt03izJ//drpuPRrYUQholnX/sxvERmd+2RVE+k0OXL871LJ38E9eCAms9UjW8QfYHURs2pB5Em1sPVs8oLYulFaYsy/s0DMlXZ6tBgAU3LK2XCCAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298309; c=relaxed/simple;
	bh=4Gp7d75aWXNfRjmVO52nxA3QXU5ih7LwQbhiSiPc9iw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uiCGGs7SzA8qnIhzGyobbhAvl3sacB2Ntb8dbC1VkQQ2sjxUAfKhQ/fs6f1BIwJfuIWMGuJr+DVibFfcLU7gVi6SeXBQ9eIgjQqWUJj799wUk1X07VJAL7aXDIOmHrMTpGBKZDzes6jXb3kUKXDTL+Bmp4jnNdEv3ThF3fxSp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GvF85vPJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e58e838d5so7438677b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730298307; x=1730903107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu9T/ChYAhKXym5Mb4uVCAro45E0RQzqAj0ht4HK0XM=;
        b=GvF85vPJlXvIxpiFUd3tKf+TX54FRrZTBNEUAAu827zIVlTNN+zu8W+ylDmzxK2irC
         l3qE0bddAKc9sLZ4XuDK0iWaT2S4wnhznHCvRHASstCVdjmVnUvWr+dzPitZaRXHIaLg
         ATH+ZFKhYVlx3Mr20laOH45hTiQgLh+nPuafcx5pW0D0YWwYSR3pvG21XkNe680a/lPl
         wRBKEqRO7AyZD9/hY/xHD/jKVMgMItHpstP0q01Qa23K6vSDsKDIyz+kVNvankaaOP33
         aOAyl0O71HONgtwvxPIpto3Z0Fd8w0AqCjXPUxzps3mXyv2sjno2mqrZhuCqTuPygCdV
         T7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298307; x=1730903107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu9T/ChYAhKXym5Mb4uVCAro45E0RQzqAj0ht4HK0XM=;
        b=i9XoHIfptyNonUHSUQrA1NUesVFP928YLUuuJEfdFR116Z4IHyd4dJpnqxKqxv8UBU
         NURVG1iP1fUQOX6XtZ31iShSME9F8YZPeT9eRYA1KaKbt8MopPO0RBCHpJ7Z2zswlp/h
         oRjFeECAqyu98lnzekTm09Erpp8A8G9lfoQ/3quJwz3WtYOZy3Dq5HNwhppof/bFx8fe
         rhmNbU+evTP7H/WBzHHvGs+VZRId7huc6/x27F5ht97B3bVNZNQH8kyFkHpd3e9QJT3N
         BQEscmvCEJLzjASNdgZrW5wWprDx1PXhx0CwUWvWPw0zME8wk8rNUJ0ScLu7JmWm3fpp
         16rw==
X-Forwarded-Encrypted: i=1; AJvYcCWQPveCKZg2kx/OGVVIkeGcd7PP4srAqK57iB5x6aFP14uX4KzxID5GkddLaEmTSIKa/aqclult+WUBBCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71g9dq4UMmj+qH5EOGUoy9/VDtdCV6NxbfF4Pojxs8n2t3NYs
	5SiOH6xXJ4PnEKUNbTZTk4ZG83zML3gbJXPo2xGz3Ow3BokKFpA45GC9ATgZN8WeZBIL7vfow2i
	wQw==
X-Google-Smtp-Source: AGHT+IE6Qy/01yhSfd29fTCsUG31avheDCycvCS+iPE1pjQUQ+FnkGoAp6kZbn5B9mvP+ij9etCUOSfsPC0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6014:b0:71e:5a0e:78d5 with SMTP id
 d2e1a72fcca58-720630ea7f4mr28714b3a.5.1730298306536; Wed, 30 Oct 2024
 07:25:06 -0700 (PDT)
Date: Wed, 30 Oct 2024 07:25:05 -0700
In-Reply-To: <ZyI-0cPWbbHtZQLj@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906204515.3276696-1-vipinsh@google.com> <20240906204515.3276696-2-vipinsh@google.com>
 <ZyI-0cPWbbHtZQLj@google.com>
Message-ID: <ZyJBwQNRCFBTLQgx@google.com>
Subject: Re: [PATCH v3 1/2] KVM: x86/mmu: Track TDP MMU NX huge pages separately
From: Sean Christopherson <seanjc@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 30, 2024, Sean Christopherson wrote:
> On Fri, Sep 06, 2024, Vipin Sharma wrote:
> > +	struct list_head tdp_mmu_possible_nx_huge_pages;
> > +	u64 tdp_mmu_nr_possible_nx_huge_pages;
> 
> These obviously come in a pair, and must be passed around as such.  To make the
> relevant code easier on the eyes (long lines), and to avoid passing a mismatched
> pair, add a parent structure.
> 
> E.g.
> 
>   struct kvm_possible_nx_huge_pages {
> 	struct list_head list;

Actually, I vote for s/list/pages, as that makes the usage in code is more intuitive.

> 	u64 nr_pages;
>   }

