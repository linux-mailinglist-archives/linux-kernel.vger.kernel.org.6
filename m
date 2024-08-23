Return-Path: <linux-kernel+bounces-299777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF65F95D9FF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2670D1C21639
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546351C9ECD;
	Fri, 23 Aug 2024 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZm4++i0"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB051CDA37
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457425; cv=none; b=YTSC2pfdiS2PYwYLNiEkMIXSQIUhH3MxRwjJCPWtaqgSymD+wMoOmuQcOqINrN3qP/g7cbGfnlua+bxeDPBHwh0k4sJ3vWGjkbv/DuYaRtXmWBLXC/UYrCaZ6XVJfQEL7RYmPywJXdh3LOSDjRrE97MfUzA+sSbq5KWjEf/PjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457425; c=relaxed/simple;
	bh=3TBDR7RHCVUWQzyGhzzytr0Lj+8frShpKy/vkdlRFo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AmuFN+K5zYugGCYzD58YHCMITzXqN9BLJjeu3+vBjNRdtAkELticRLlrgJ2lvi+kPHbuvsKjxOk1zvAkOBEJxw/ncN1mfQkSmBPTJnDRc9Ht1sTbXoPoZuuIpmIj3d7CMVu1LczeBA65K8EmRq7rRgb4D5wRHGStCikQ9gTRc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZm4++i0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e163641feb9so4926143276.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724457423; x=1725062223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HX2W5FE6FWjJbEMUv+O+IBpK22SAzsnBpYrjXp/CXhU=;
        b=lZm4++i0t+KeC2AlfKDbEqkdawfxCws42RBD190tn9Ogy/crebdte9JRXkK2TMhO8G
         bdFmFV97hfc+LiKEchuAUMVez/Mahmy5EXl9pySZ8KYg9Yqj08ZK+PX3ZVZ2XLkZoeJN
         xU+Ep1m9ygL7Z/i49reczvhc90ymbaqgf1v6sat+YCnSz4toaSDPrwIi55mZNhDja6NQ
         5/FDrVIGu2GscGKW//ARszgdONJ3Z76aaHNziHiCbrwcuXspdl2YAOUro3rTLTRVWOzy
         Je9/jcC2NJbQ0lljnOPZ+aGbE+BAYrD1SMzMqi+K42b46VExECCb7VhYytdycqO5joOi
         FZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724457423; x=1725062223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HX2W5FE6FWjJbEMUv+O+IBpK22SAzsnBpYrjXp/CXhU=;
        b=V/lvk9Z96HCytoaHgU8NJ5grXXJKOxgKvs8a3n+P0DxroCSFeU85jQekGoj+uN0WkU
         z6gj+JqpY+ybeyPjJ718yqXgW4zgoIJqCo0VKGbY2baLaJeSoHWuzwc++060ZmxQ5H0j
         jaBCIAzSuGG4O8HywdG+nzK3aB7f0ecp6Mpl1Jd8+FNOolr8AEEFRGd9ASkNL2mR4PYD
         y3bLKGl6qipO073jpYiTrDXMEayjSnx2UySkgmAbjYzGnoiMTpfn7uCz2bo7R4uWVR5W
         SEgz9neLB9koGOWgDBPoVeMLSbwh1SI6imLYKzO3GAdXjXnkYzKBQRtogWYvVtWLQ0CO
         C6QQ==
X-Gm-Message-State: AOJu0Yz6yiJ0TBXJwi4ZHzkm1OnYysPtNL6dcBSy30orDKXvEYmO9vCI
	mZEeIy8tDlnh349+7TeaGJY7613GqX0oFKbuEZIEHezhUPWzqkf0QjhciXVpJ/3WEcqu1XTpKXj
	bAg==
X-Google-Smtp-Source: AGHT+IF6JIS4ez1aIQ8nOslueiOxeGv+PCTulk7JEKtYxYZVfduMNdjKQcZHAQD+HV2bqB18HwxBJevmfmw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:b310:0:b0:e11:5da7:33d with SMTP id
 3f1490d57ef6-e17a78b6f66mr65811276.2.1724457423171; Fri, 23 Aug 2024 16:57:03
 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:47:57 -0700
In-Reply-To: <20240816130139.286246-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816130139.286246-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <172443899216.4130363.4073350525612402734.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: selftests: Re-enable hyperv_evmcs/hyperv_svm_test
 on bare metal
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 16 Aug 2024 15:01:37 +0200, Vitaly Kuznetsov wrote:
> Commit 6dac1195181c ("KVM: selftests: Make Hyper-V tests explicitly require
> KVM Hyper-V support") wrongfully added KVM_CAP_HYPERV_DIRECT_TLBFLUSH
> requirement to hyperv_evmcs/hyperv_svm_test tests. The capability is only set
> when KVM runs on top of Hyper-V. The result is that both tests just skip when
> launched on bare metal. Add the required infrastructure and check for the
> correct CPUID bit in KVM_GET_SUPPORTED_HV_CPUID instead.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/2] KVM: selftests: Move Hyper-V specific functions out of processor.c
      https://github.com/kvm-x86/linux/commit/24a7e944966c
[2/2] KVM: selftests: Re-enable hyperv_evmcs/hyperv_svm_test on bare metal
      https://github.com/kvm-x86/linux/commit/d8414067cc17

--
https://github.com/kvm-x86/linux/tree/next

