Return-Path: <linux-kernel+bounces-299770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33C095D9DC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5FB2864B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D3F1C9DC2;
	Fri, 23 Aug 2024 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxSvVtAI"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9B3181B83
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724456896; cv=none; b=emb5fz2OlhJ+fEikjdIe/JfKGjkbWXXJ2SmlUoTywlD689qUCs5rUjxJPJWQResm9bJWFWh458fDlxG6mBgL5Xqg0/iOcEcoPqUsuj36r8/Idu3K18UH3nbzSglj5NyANINpFcwgauZLca/P97oIjDa3wuhOJiCuHTKSk5dTWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724456896; c=relaxed/simple;
	bh=sOOqwbBuXDTIyAtIxAQNmxTNNWUvnNEPZnlOI4qMhuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XtqGTIffzaueMJOUtTF0vgWt+yv+gtB85unndhJ9DndM9G8xq6GYd245Lpp3vUsz49bBP+fIhKUX/Ay3Zgo0XsF4Y1ug3BrQdDUmrtwPb6HdhtU1UbFvk40V7QaAAWoyz8FpkKz+eZZSht+EYsKYkTIEkOrMLd8H5mGG/ynP4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxSvVtAI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-201f89c6b21so26990875ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724456895; x=1725061695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+21cvWvA20RSCNk8Ww40uayuCkSP52UXC5UruboIXY=;
        b=NxSvVtAIISOx+DrrfDAi7Jrp2tDrG690a05cP73BbyS2HDqe1kqCakwHOPrujy0hPK
         kNvwQmJANV0fH74D04m3pvXcxos5R6TGGF+2iC/81e7L6MMseO8LRiZl2ucXkGzek2lQ
         g1p5DW1zlu9tp3AzXVZ2R7gDn5hCVoZmvHZ9mQ1oh310fyGxuVOsHmdwhgqQxH1kOhQn
         y88cILl2GR6kc8+QDpaqEgSh+lyMNMcGNcQDlhHjVCgZUVycP0zQckvWp7zpvPynwOmX
         TLwt2/Mroe/KX0c9+LZmaxAPOQnTDKsvFcUQWz7k5yOf51pi5wDuyGRg/s/RxpklI+2D
         2fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724456895; x=1725061695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+21cvWvA20RSCNk8Ww40uayuCkSP52UXC5UruboIXY=;
        b=LYxySrEaGH1yn7xZC4agpVSxcytr4bWh0oX2n45uB1YvphrIW0kVHQDNb0IptoK9gQ
         TG6sOGCimeJ6YR/JaJfnnIqbMbWdjW00gmlRUikM7jYioTvZTDifpBVuAbatujnJ6XAT
         9RR33zMgOgHKngwG7H0IdTRDV92FvbgMl5VcjT2P3JOZQBDclc8RLtqyHFcUl27noDAj
         FVkZJGG/uRoqk7w8i5QNVEB1owalTQGU2aSowbAJl392zoHkxK0A40GIhOQi8ejapICb
         egaaTbVSqqOsE63xBuvuGMqIwFa9YH1Dx/kPJ8vVw+PDDVyBnHqVYB5C8ioJl8HMfdoq
         HhCg==
X-Forwarded-Encrypted: i=1; AJvYcCUPJE5Bnkxn8uY1sYin4UyBZtNbVm3vRPjm1QCFEYwBj/0lygJUApJOJoWl8Xt+3FDIsEtHaBT5GGtViEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxBINZ9Zog5aY1q4tonHZps+VuGKcWTrC2Pvxr5pSKhSz9jLHL
	3oysqKDHqmqWHoerPkVhkq9tlBmWkhTvOqYy8EyOWowH3OZ6lS3hrgjHuDRYewgUOnu6uVSicS3
	hkg==
X-Google-Smtp-Source: AGHT+IG1Zo4cycNEsNQ1ejGdL0ea+TYErjWLE5yXTXXnzMAU/RfsFWsp9nnDA+bxhWh8hhor5GQrcw7jXeY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c406:b0:202:156:c4c6 with SMTP id
 d9443c01a7336-2039e4d9ea9mr2586845ad.9.1724456894647; Fri, 23 Aug 2024
 16:48:14 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:47:39 -0700
In-Reply-To: <20240723232055.3643811-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240723232055.3643811-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <172442179509.3955684.3431419416456573954.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 23 Jul 2024 16:20:55 -0700, Sean Christopherson wrote:
> Grab kvm->srcu when processing KVM_SET_VCPU_EVENTS, as KVM will forcibly
> leave nested VMX/SVM if SMM mode is being toggled, and leaving nested VMX
> reads guest memory.
> 
> Note, kvm_vcpu_ioctl_x86_set_vcpu_events() can also be called from KVM_RUN
> via sync_regs(), which already holds SRCU.  I.e. trying to precisely use
> kvm_vcpu_srcu_read_lock() around the problematic SMM code would cause
> problems.  Acquiring SRCU isn't all that expensive, so for simplicity,
> grab it unconditionally for KVM_SET_VCPU_EVENTS.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS
      https://github.com/kvm-x86/linux/commit/4bcdd831d9d0

--
https://github.com/kvm-x86/linux/tree/next

