Return-Path: <linux-kernel+bounces-234679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFCE91C961
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198E61C22A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F64132113;
	Fri, 28 Jun 2024 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5uTL2yx"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E286636
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719615420; cv=none; b=AcuRzHsqghUqZRtl5zKNSlhIhNDA4R08L+FwQARTK+XpDVE3LWMpkKFZeT7rlVe+b7u3OJHI3y2c8SCSh2vvln0PSQ3np58pge9039NNrTsNz/XXMBIOsc5MsT0ECaQnkqgb3Xnx8dw0tSX7ADKvnma8Kip4oCKskEqn3aFZ2kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719615420; c=relaxed/simple;
	bh=R/ZZ01BUMJass6vcnzebJ4EDyiBiQSblYt72eT+mc3Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WxPK59R0UHDrE5OSJafB0fVx3VnP/J96VqPl1/DdrmJnkfrANn/NTl7/C7snDhll1Ca7B03F+e3SJ/z18oF3P8PZd+btI29SsOq8DjzAP99801ka29Xsz9JbyIy1vaGMe3vFbjFM3o6kx/VpCzZrg/ze9Ofg54QD62AE8Imp94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q5uTL2yx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c7e48b9f80so897866a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719615418; x=1720220218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1TYj2TZPpVeCJnlW6WBsJe77ol7Kf1Aou5o5ttttPsE=;
        b=q5uTL2yxFq9cx/E40Fao7KshXnmA31MenDrqk4jepasfeC1nFtkK9H8FHT6k6aZHMN
         sycKBa8xDYyXD2o41UPxYN75DuNVUhVWQ1p5a+Jw3y1ZKhuICN3KWumPk9XxyGWXf/ji
         a+aSYFiMtaERtZP6Gc50+AAK7BapNX5zpCq5xu0PUIEDfMaUmo9Ub9ZWfW2ymxVtT3e4
         JWbLLjNfX9yg/L+bxu/BJ3M93IZiKcZH8zSICs/cf1pOOlLRk3uAkXlUAJEYxVRbKzeD
         ODz5HwjFa1pz0sEQm14T6uWrfYtMAz6+kYJpfXNrCQODjon1142W1RyBx9Elm+oPZ7XP
         ccMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719615418; x=1720220218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TYj2TZPpVeCJnlW6WBsJe77ol7Kf1Aou5o5ttttPsE=;
        b=SpG77A3Kpk2VwwutzK7U4BMTppnM3UNwNSi4/x3AkYtmMZUPMG8Vir8pNu20Gje9Ka
         HNAf18osde04r0hh3oi6n/9LsPKT20ANkrvNfbckTePPsg8xZOc+yqQ9aD5FGGwvk4u/
         6WwAz+eZ85gQRg21SbOG+R2cYskpKgv8jEtFDetOiAk7THgEGIxc4Apeec1Vp5nDKt8Z
         tpesz6dCRGsV6Oc4w4METRKXiXDPv8OXmOgcMaAKO/cLSGVW7XUw2L/YBuCekTWj5X9E
         ECCR8E9WoGxSQ42Hmp8GUhbdTojsV9GUbCeFwDyuI6ASDtpTt9Erg2dHnJj6rc+sKY7N
         +tVA==
X-Forwarded-Encrypted: i=1; AJvYcCXyFCPugSmF3fmw04XPo8o+o/RxfF/9bA6wnYnndXSECuKR/q1jhEw/U1QoguwRoCXNLlFkpnKj0ITad2bxMycfzAn6tLmghNeH7Yhv
X-Gm-Message-State: AOJu0Yxd8gw3IHox7fhfdRG1vBzD2nkhEPkTd4o0uuOaOVVW1NWkM6Bm
	tNS75wdUZZmwXmadaNo2SLVeatRxeUt1WLFJJQB2jglE4GL6qZJdP+G85W4ZUBpYVEeVKYioYny
	ySg==
X-Google-Smtp-Source: AGHT+IFn3thlh78sPFpUcjjJ3e8afZkxEnFXZJx3Xg9r6LMlYwN6ZmN+hjdkits3bfwrxjFnEkhWWMrwp8o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4d85:b0:2c2:fed7:d797 with SMTP id
 98e67ed59e1d1-2c8507b2998mr74129a91.6.1719615418320; Fri, 28 Jun 2024
 15:56:58 -0700 (PDT)
Date: Fri, 28 Jun 2024 15:55:32 -0700
In-Reply-To: <20240628005558.3835480-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628005558.3835480-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <171961369481.227974.18088204748355236734.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: selftests: Fix PMU counters test flakiness
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 27 Jun 2024 17:55:55 -0700, Sean Christopherson wrote:
> v2 of Maxim's patch to fix the flakiness with the PMU counters test do to
> a single CLFLUSH not guaranteeing an LLC miss.
> 
> v2:
>  - Add a prep patch to tweak the macros in preparation for moving CLFUSH{,OPT}
>    into the loop.
>  - Keep the MFENCE (because paranoia doesn't hurt in this case).
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/2] KVM: selftests: Rework macros in PMU counters test to prep for multi-insn loop
      https://github.com/kvm-x86/linux/commit/5bb9af07d37c
[2/2] KVM: selftests: Increase robustness of LLC cache misses in PMU counters test
      https://github.com/kvm-x86/linux/commit/4669de42aa6c

--
https://github.com/kvm-x86/linux/tree/next

