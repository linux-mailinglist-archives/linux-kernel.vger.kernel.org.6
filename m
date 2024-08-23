Return-Path: <linux-kernel+bounces-299775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3483095D9EF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C42283007
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22081CCB2B;
	Fri, 23 Aug 2024 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0osuhRQ7"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5DA1CC8AE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457274; cv=none; b=NQFk7pS1+GABDuEovTP0WxU9eNO4v2+gm4Eyj87Y7snWf+j7bHz41D1xl+xsXRyZHrZ3+9t4Bz/2acW7H6gT+7dnyVP/Siyet88rqNJG22jVKYy+Iv7Wuu7Pa4qUqUKpY8H43VwxJ4Ik6kVb4nlvFwlxmYM3/ujRFBGK1aVWzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457274; c=relaxed/simple;
	bh=ZsGbrVfo9OkjdxgpqSfk8utdzoF8z3yMoR3uwvLyy2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ym0qCGp4MvWofmCJ13bVCmBTcuGSEcWAr5IA6XrafUK2Iz14SW3B9n8G5HhxS91D4vQnAiJpsLmMVjZAqflKk2ShMcvLEheGETVqOUNtnFgDcN3qAbjVHJ36jLKNc9vMyTVP8hRhkZBMN6ivWowoZsWsPTHfQ/JHixh+TPdkyqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0osuhRQ7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d3c976e426so2763093a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724457272; x=1725062072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I2v2MHDt4esEOK/DxuPwtgfOFZoYYQTEeuqo4M+jXGM=;
        b=0osuhRQ7sH7zrk5U3BvtbkFoo1CCbywysNtofdxaYniBe2yX9rKlaUsJ6ox+Hj+wCg
         e6ylKsFwbl9GQHXF3aA4IiY2PWkBVk0/wUHVDodGtta5kuWMQLTXusk/aGe1zykSHFwm
         /OkPMpGc/kcVOeJ6lY+coHZ6ZL+bb48AaSFrW1eiHQpdyvdQqlg3LFNt2qV7tg1IcRal
         +rGkBtpSzst4sJ2cy6unSzCDOTVbtJ06wLPIaTQCDP6nbWnX2c4eCevv8XCoHiXOo6rb
         Zt/r5oi0N4K37FQ6P3Fqgc2uhdRao3QD9hPqlCrO1jK0aN0nt+lxVrplw6EoxsE5j4Mi
         IJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724457272; x=1725062072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2v2MHDt4esEOK/DxuPwtgfOFZoYYQTEeuqo4M+jXGM=;
        b=WKdJabHCkVRNStYNWC8RuQJfS3yEQwBWvtu5BgNis78w849NAps3lo0b1YUfAXxsLG
         m6pfAhI30aqFKkFkVeUgVr7Qkk94IkuVEdiz4TAbh3av89GGu0ARmfRJuhP0O2wDycSh
         N7aNJ8E0TTdxyLZ7bRGuGoHEW0dY7kxn401tdll2/X1CQaQf4KB+9D+QDMNIOeXk+KDo
         8TU1GUGaY0aWOiTjbcLG4svNnZ4F1ms+Q7jwGDuxEk0gH6yI26cXFsynU2C9hI4OyMjs
         qAKW9uOpSQA3GDOFlhBaQFvwns4R4CMjucZU+u7ZjgG0ytmtcHH6vzh6CqzAr6SiJGLO
         hmPg==
X-Forwarded-Encrypted: i=1; AJvYcCX8DHrxPpZuJ9AGG5uop+XEcP17M5YWzhlIusPt7HfE9NIj1ZujSepLUbo1/bGzT+RFUzAZ/tUo2Q8k/uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEnSERHUM/UcVgW1TgeVtVR1VgGbuKZ+aUugvkXpbPPyWUBg1G
	zA3R++fSpjP0hFqCOKqObYaW8II+U0U1T7eu6b9lY+DnMyD+gINx2w7IrpkX8xnhn6BNBLmyxNZ
	gVg==
X-Google-Smtp-Source: AGHT+IHm1c1eC7EMuzeGgtY+z7vJ1lrOuEaIgxUAfa1UDufYAd0VdDhBdDFlj2e3bEGajgU0/zU2XZlhzo4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:fa86:b0:2d3:ce45:9148 with SMTP id
 98e67ed59e1d1-2d646d81615mr54476a91.7.1724457271818; Fri, 23 Aug 2024
 16:54:31 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:47:53 -0700
In-Reply-To: <20240802202006.340854-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802202006.340854-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <172443896940.4129936.14195284777076363677.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Clean up function comments for dirty
 logging APIs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 02 Aug 2024 13:20:06 -0700, Sean Christopherson wrote:
> Rework the function comment for kvm_arch_mmu_enable_log_dirty_pt_masked()
> into the body of the function, as it has gotten a bit stale, is harder to
> read without the code context, and is the last source of warnings for W=1
> builds in KVM x86 due to using a kernel-doc comment without documenting
> all parameters.
> 
> Opportunistically subsume the functions comments for
> kvm_mmu_write_protect_pt_masked() and kvm_mmu_clear_dirty_pt_masked(), as
> there is no value in regurgitating similar information at a higher level,
> and capturing the differences between write-protection and PML-based dirty
> logging is best done in a common location.
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86/mmu: Clean up function comments for dirty logging APIs
      https://github.com/kvm-x86/linux/commit/acf2923271ef

--
https://github.com/kvm-x86/linux/tree/next

