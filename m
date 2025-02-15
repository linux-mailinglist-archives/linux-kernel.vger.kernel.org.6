Return-Path: <linux-kernel+bounces-515920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37672A36A7A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56A83B2E72
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CA51A5BAE;
	Sat, 15 Feb 2025 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bdO3DUDv"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36541A5B9A
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580978; cv=none; b=fzvO26+t1gJ3ieKvqxhf6otvPcrsSMAa5q4KyOG+DjZwqdQYXud8au/byedF17jvsKFq1GBnpqQVZCldbsfrEoFpk08F9zK2quEeLGVgEhIG3AlX0oIO2ELvq4tfh+OSSUwa4Ofs10njpsVGGhFhIkFNVw2gNrxaM0SA3X4GETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580978; c=relaxed/simple;
	bh=uRG8ujHEnrVHsIn8c8zSJEBtls3YLe4Wr0vqkh6cY1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hUFZXmkT/jeZpo6a8pBfX6lYu4abj/KsP1rHOSV0eaTLhXaw0SDYcZCxX81B2TcC0uKvxWD1Ih7gYI4xl3O58kaDu0Ql3e8OUqVAEuoQVFpkl8lyndTmvcr6cta6EXglSFI6YDZuRAN+y8ZFgpcRJ/WxsMLmeua++cBsZYNaMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bdO3DUDv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220ee2e7746so25755335ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739580975; x=1740185775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=68IyYIycq1Pdtbw/J+YPvwgWpOzv8wHscA0Xwfn/5+E=;
        b=bdO3DUDv1e0tmRaaImpGLsW2AFYAq1fsbnnVFRUsPjwIFmvFgiIHrQ3ZAEtT7HaDp1
         g8D6Gzb35omYET5C6vm2Vp0dd1vgG2qoZAnLB0jhp867TC9fwknPyf8u168za71jhJqA
         ybr+QKEdXEL5mKKOFBsRed2gME2tlUy86U7Z4WnpIhRjaag3TmVWtVeANIl0L29/TXD/
         olIQxAY4NxlP8WnJyBtNtYxUE5gsu7d831oYV3GKW+nsm3MKUpmNEUImHaSYuKsMJ0Vz
         XzG0km2HkajycFnDgrPmsizt03IsPvqNOLnEVezQdncURgUjaMziYtQwCFQ+Kip0qXB6
         dB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739580975; x=1740185775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68IyYIycq1Pdtbw/J+YPvwgWpOzv8wHscA0Xwfn/5+E=;
        b=xVWgwmtCXQe8idYWnkEC+kdNiL07qIjOzGZNHZYVRYzBUFwaOcv314zwEXgQ//ECrM
         u1ujfphvXGbMWa0S2qORiYNXi56LPdpj/u6fp8vmQEOfMOFM3Sr6tsl3H10SCsfplzTR
         9tKgVX0y0T6THutX5iOfVUYmYNxTN1U3NZQInIDTq/+r3GfleF2BJLy+tdMglD5xPOk1
         hvaVVXCYlb/JMHJsvnI6AhoYOSISW2N9sqXjlil/AgHJuJuPpbMstlNEEJW9ILOPnwzf
         3i9WhKku8mYQTqbe2c0NNppN3GhtQ67GiO1h13SJzQZFgg35PLwgF/rIYWpDJijLRDax
         TPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFI8gTXjMlzChhpQNt8HvzS10C30tSH+VRyVVMvgJnSQDK28jyMtfKlIRXKVupIfdcRmstwREd0jurVM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZu5SyU2Ei8QAZPz99+Zb6xOxiK+M0n/YXFoLFoXYlOje2furt
	Jpix/aBUsmFFT6AglI+i7F8HVpGWpEmjIaNjTtR36XcuPpf4gFk7zo+FOU8vKjVjmS6khwSiN7v
	GdQ==
X-Google-Smtp-Source: AGHT+IG4oS8jezFfPOMO2sK+lY9DhJZjY2Sv8URxjuuxFTE3h23wn9S/0xpeGoE8/8bdl+7B4BhHhcuLgNc=
X-Received: from pght20.prod.google.com ([2002:a63:eb14:0:b0:ad8:3be5:88d4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3986:b0:1ee:7e81:9e61
 with SMTP id adf61e73a8af0-1ee8cad2bc3mr2237807637.11.1739580975020; Fri, 14
 Feb 2025 16:56:15 -0800 (PST)
Date: Fri, 14 Feb 2025 16:50:28 -0800
In-Reply-To: <20250117234204.2600624-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250117234204.2600624-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <173958014840.1188392.7565055042963100594.b4-ty@google.com>
Subject: Re: [PATCH 0/5] KVM: selftests: Fix PMC checks in PMU counters test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 17 Jan 2025 15:41:58 -0800, Sean Christopherson wrote:
> Fix a flaw in the Intel PMU counters test where it asserts that an event is
> counting correctly without actually knowing what the event counts given the
> underlying hardware.
> 
> The bug manifests as failures with the Top-Down Slots architectural event
> when running CPUs that doesn't actually support that arch event (pre-ICX).
> The arch event encoding still counts _something_, just not Top-Down Slots
> (I haven't bothered to look up what it was counting).  The passed by sheer
> dumb luck until an unrelated change caused the count of the unknown event
> to drop.
> 
> [...]

In case Paolo ends up grabbing the version I applied...
https://lore.kernel.org/all/Z6_dZTbQbgr2iY6Q@google.com

Applied to kvm-x86 selftests_6.14.

[1/5] KVM: selftests: Make Intel arch events globally available in PMU counters test
      https://github.com/kvm-x86/linux/commit/933178ddf73a
[2/5] KVM: selftests: Only validate counts for hardware-supported arch events
      https://github.com/kvm-x86/linux/commit/8752e2b4a2b7
[3/5] KVM: selftests: Remove dead code in Intel PMU counters test
      https://github.com/kvm-x86/linux/commit/e327630e2a0c
[4/5] KVM: selftests: Drop the "feature event" param from guest test helpers
      https://github.com/kvm-x86/linux/commit/0e6714735c01
[5/5] KVM: selftests: Print out the actual Top-Down Slots count on failure
      https://github.com/kvm-x86/linux/commit/54108e733444

--
https://github.com/kvm-x86/linux/tree/next

