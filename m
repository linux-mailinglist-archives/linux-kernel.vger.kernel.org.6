Return-Path: <linux-kernel+bounces-515921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C570A36A7E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACD817302E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62281A8F63;
	Sat, 15 Feb 2025 00:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GwuOd1Gq"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47091A7253
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580988; cv=none; b=hJqrBPJd0geu79AzncKHae16mhO2SrpCFxTJIoNpiDF7+8JmCfsrKX5mofVcy/guEcMZlJoXkLp/rFz9SQ1XgIqcKE42XgYSn33EeEEqk28odENo70+7pCN3/mswSMgXAPtkoqYmuHfXKvO1IVkLZsgPPZTzVoKc3LwN9yC4nn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580988; c=relaxed/simple;
	bh=DCnpPQ/WwTAd3s72FgUzg4owdgtwbQZ4WJnMni9AG5U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U42ooUAaGXAr9zNrh0sGGkMLWHGZwn+3XyWjrWTeCknlfXxS073eqMn41UymCWv6gfW6TafM8+MjJp9SWz0ht/lGKUaFjAqRicWMyVwAcHhOsQAh8bNtmHn9DeIclBjvtTB4w60u4fwGZa/gPGPQOmXY/HGgf5kikIgQY/kJR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GwuOd1Gq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2210121ac27so11959285ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739580986; x=1740185786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TBK4qn2rx/nQg12elABJ09B0nERLMVWWp6HU7JkxYNc=;
        b=GwuOd1Gq5Lhk4129h3TMGzWEXytNG8xDJs3PZoIjpAJ1VL0Ja6JqJ0fW+X8vC0SP0Z
         EaUAGC6KiQVcEzIVCnamLGFtYFjXM+sKQ/oc+uXPRqqn1VYyMAglcb5Q6o+2a/fCgBZv
         WZXOGzyHPd69DTlyOz6t+9a7TcU49k2O3P4WZgeoPwfQQhmJozKecOCju/pk0EyxRlL0
         o3wBtU1r1P5yPyg94JogIeREa4JJJpm/CjvMgOcFnKkREbLkwewXkxbXsmTkQ6yUIfgA
         tC4QcLeYjh5S91zyY9HOKhlwTph+V8xZNyIWbFv6J3vIYoDf5wkh3oEEwnvTDX0nNjU5
         D/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739580986; x=1740185786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBK4qn2rx/nQg12elABJ09B0nERLMVWWp6HU7JkxYNc=;
        b=gd3No4RDU9vVU6JquZ+oqHsyeX+nCj9TYgbi8a8936j5S3R+qBH52n+ymKrl/rZ9Vt
         Id57U4e4Kpc82xWpobJ9iAkr6HEaj1vX2bxrdeuQCPm0plLpAif7eTpYmuzw9DUYX0k6
         ozJlZH2ChYxDnAqUkqQtb6mF9tIcY/1MsgFgCaTT4of5qTlbP5r+jXhX9zh63HzA0a1X
         gRxleEmS5p0FhZ9Bq5glpF0cGxXde3rl7KnK71mNJKSDsRb+4CxBXEj5j7hhMOIlc+dO
         +48QNzeFVEFUk7fKpuHQqF6BChunKibspGWf0HfKNziopv4ccgwjmatodS7mmMAMKgQM
         wYwg==
X-Forwarded-Encrypted: i=1; AJvYcCVNxItP0zjlIGrFzW//kFCBxlgZFuJXOPQPoAgSQ7Ta0J3Dhmhyf3tY5oPig3iq3N1bEaee2d75HNmJ73U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtlvAXnnxFMImRzp4Sj01PxTtOtrwsJ2kC14RUXWFBl1IerWNW
	ev+3WQSGaPhc1dFW0ps0uTZCTABsRRlL2jKBgqvJzjAXzMtzC+uOVoVm4UTJ1+qw2iwjR/aPo6m
	IMQ==
X-Google-Smtp-Source: AGHT+IG436XgYDFB9d76yPBzvXUSNT2hkZpYz09EOUNzfzyxpmDvZeQLTqGccih51oIdBy5h2H10zp9vp00=
X-Received: from pjbeu15.prod.google.com ([2002:a17:90a:f94f:b0:2fc:1eb0:5743])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:28f:b0:21f:85af:4bbf
 with SMTP id d9443c01a7336-22103f0d484mr16863465ad.20.1739580986053; Fri, 14
 Feb 2025 16:56:26 -0800 (PST)
Date: Fri, 14 Feb 2025 16:50:31 -0800
In-Reply-To: <20250130163135.270770-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250130163135.270770-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <173958027698.1189587.16446324269012932260.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Actually emit forced emulation prefix for kvm_asm_safe_fep()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 30 Jan 2025 08:31:35 -0800, Sean Christopherson wrote:
> Use KVM_ASM_SAFE_FEP, not simply KVM_ASM_SAFE, for kvm_asm_safe_fep(), as
> the non-FEP version doesn't force emulation (stating the obvious).  Note,
> there are currently no users of kvm_asm_safe_fep().

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Actually emit forced emulation prefix for kvm_asm_safe_fep()
      https://github.com/kvm-x86/linux/commit/89ea56a4043a

--
https://github.com/kvm-x86/linux/tree/next

