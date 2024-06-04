Return-Path: <linux-kernel+bounces-201563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0345E8FC008
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367241C22877
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A696314E2E6;
	Tue,  4 Jun 2024 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RpD+wLOo"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F614D703
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544368; cv=none; b=i2BBgf3VQam9fakcX0OQu/WHFcOp9OJ4nD4/GzIYdKQvWjwia8E4qBHtkiagmCzfZ9LQem6x/+VsFFM+c85ZuWqQCdKmpYJBfgW/8DpqwAJQ5mmkOqQXFqe8H30/rCbarGYjo4J1gnLnCy19NyLvQ1FE7qAl4Y9tr+xOjulPlW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544368; c=relaxed/simple;
	bh=lH7OitCHRdT7V3xDkv0BZZ4kPK0J/p6LL7hzMRiZfmw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lHnIk4OBQ7u4UtWDEO1+2y4qeMmZaBS3XARcJBR7IFdC/xwS4d14ji207xMqTgflPiTAjNANXg+gdhOiKoiB475amlh0Utq0opArf6ujicDG9pXENUFM/tdJmHkFzcbAHDnd8ryMf3/tU9PxVe5uwoK4XSKtl54L2T5OTFVrJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RpD+wLOo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a27e501d4so29933927b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717544365; x=1718149165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVPA1CVlxppPmfWI4RkOia/Fp2tCABe0o8VrZrea1qA=;
        b=RpD+wLOouwfK/fDVj5KMXUBeqnoU4EojDxq0Px5aX3Dl7M0kb0Mw5cgD43MTdGmCIF
         9Fd3AFgSN45jcvoKfLUEVBQKjFiN49RoTVZ/20/oCy3wscu/ExG7W7gmZaPdm0NkDlLD
         SkXfUY6Ivd1NcwOTHFi9GBPYa1tX3u1I6/sh7DNcH5KL1VNQkBBEFJXOcja6ERNIFJtH
         1YbrEKMl/qcLj/uZ6ZWIquvKS+amPcUa3vEer9PtwPjdK/jPVwKU99/1iS5bQ3PL8jsZ
         ya1SqifQh0voqp7tZGDwqeFjDMtWAIvHxtqmHsFL9zQSwe/k2FRLQzm51IZsEw7mP2Il
         3jaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544365; x=1718149165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVPA1CVlxppPmfWI4RkOia/Fp2tCABe0o8VrZrea1qA=;
        b=NjonvdUA/R5IBaYsciyLF9OM2uOI855eunaZfDzo5Sb5SfZmH5mr0NPcWZHZhtA3Sj
         +tXJM9h0FslWDifJd9K098ObTnAL35AyCUjSUSmjhLvTIwjVUdJ7f8/MeIIHDWd2Te5b
         HlgZj5XtMtThdiqboQE9jE9pFNDaNvfUc91NR//XE5cLRLCFP0ArNYQK+AgRLylUNiUD
         b5SOsyH8zu5zPtUvraj6DfJn4ngW6YHNel4w8NFvH+Nk/PdqKN/yBIubMSf0eYYwgHHp
         JnoFtaHaY87poo0lHAAga/2R1W0HRW0wruYUIsZ2VEJko9eR7hkjZDYJBsqePwsi567+
         LWOg==
X-Forwarded-Encrypted: i=1; AJvYcCXPBx9BIfFi4O1C5JDSSjP2+Dd3qh7NJGv9lUgHeFfS++Ity2o6RcdZ1So+S5QPFuioX7iyR3uO8eizVT+FU9PBZsW+BOCUjDEgPC6S
X-Gm-Message-State: AOJu0YzfITMpf1P6C3EQ70r6WqMiVvCXLJOiSqQP2E1tRin7sAIAc++L
	hSaSbfH/XCDwlCU9YM+3Zj4E8WCPVMWxTEDj8pl955uTpshcvM9T+0sBoKqvfjD1wamt6xKJLHP
	kWQ==
X-Google-Smtp-Source: AGHT+IFhXHREMbaaMkh7ThxF7ZZZg81Q0yHJGIpV9KYfxsphttpecTRLSUmZiGMkIqgoZU13fHMYllj+Ipk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:85:b0:61b:e524:f91a with SMTP id
 00721157ae682-62cbb6644d9mr2040697b3.10.1717544365557; Tue, 04 Jun 2024
 16:39:25 -0700 (PDT)
Date: Tue,  4 Jun 2024 16:29:47 -0700
In-Reply-To: <20240430005239.13527-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430005239.13527-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <171754375753.2780904.9220835490279179987.b4-ty@google.com>
Subject: Re: [PATCH 0/2] vPMU code refines
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 30 Apr 2024 08:52:37 +0800, Dapeng Mi wrote:
> This small patchset refines the ambiguous naming in kvm_pmu structure
> and use macros instead of magic numbers to manipulate FIXED_CTR_CTRL MSR
> to increase readability.
> 
> No logic change is introduced in this patchset.
> 
> Dapeng Mi (2):
>   KVM: x86/pmu: Change ambiguous _mask suffix to _rsvd in kvm_pmu
>   KVM: x86/pmu: Manipulate FIXED_CTR_CTRL MSR with macros
> 
> [...]

Applied to kvm-x86 pmu, thanks!

[1/2] KVM: x86/pmu: Change ambiguous _mask suffix to _rsvd in kvm_pmu
      https://github.com/kvm-x86/linux/commit/0e102ce3d413
[2/2] KVM: x86/pmu: Manipulate FIXED_CTR_CTRL MSR with macros
      https://github.com/kvm-x86/linux/commit/75430c412a31

--
https://github.com/kvm-x86/linux/tree/next

