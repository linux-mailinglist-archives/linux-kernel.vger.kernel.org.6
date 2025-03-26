Return-Path: <linux-kernel+bounces-577626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C04A71F92
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479C5177870
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356D9255E20;
	Wed, 26 Mar 2025 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZGczyL1"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CA18E34A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018537; cv=none; b=Fu3k0n6eNFJ/uKs1Oum9jBuh5cXnHCjFueVGRQzAUP6ysbluwKVuJV6t8VSWdpfuv0Y5ctTuf100Y/kmgsnwKlDP8MngMpBMO09seaYH7P/pVDFnKCs11oRKteMw0+LPQEJy6jVZVjagf/ZaM8vMvSCvqySKDDSq3w1hpLBVC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018537; c=relaxed/simple;
	bh=3dz7TALKYsubRBUYr/bSgmmrsdzj1opX4UARJMrIvow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=teUwNPbKq5AnWUfaYVfticNx5aBO66wq4rd7w2pu+9FkEd1WAFTohNRO0OYbWRVWFYsglgUcbd6Z7WvbrGel4egjfM1pa8AatyNSyoQDM35Ew2g7cjMDFJohuXxDTFqHqj+fKySiFR7pif5P6xoBC6tuM+o7uHyGmzemSV+hGC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZGczyL1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2254bdd4982so5269905ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743018535; x=1743623335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mr/ftcHWfkXSh0K4oLo0YgEeRzBHbBXHE5/0Xa1PdAE=;
        b=OZGczyL18dlZWw2Yt1POXdYn+L+xGIHwbydMQHpjY1bn4EIuQryB3nm2dO7kR51w4d
         h8hIMffuIW8/Uz0FQwjISfKAjKRfCMa3Vyvrekb8P6Op2t400LtDT4/PLBqAJ0YibmBk
         RwkxGbUC7JtUJckzqmobCRP+0lBlv3jdLExu5m2R9Q4ejQmVOVivLXvhWqmlR9MxywiE
         ttb38ZLaPZrT4ZhPYYsK+cTKXYgSVJXXnqnph7BrUkBzRxAMNongYxAY0KwzThCCGoIG
         rrnzweeB9ADo2S98tXW8kIF8Us5cCKgQGHYTh6amepEeJiQT2EyszoZmIwr+QxnJ8lGa
         z11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743018535; x=1743623335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mr/ftcHWfkXSh0K4oLo0YgEeRzBHbBXHE5/0Xa1PdAE=;
        b=pViHdoS4Dy+psVQK611dRCWopEj4LvjF2iU5MoLmIkA7+o4I6JipCj4rpfgqDyYpVT
         RsMU7bMk7hnWbKHMsAQ+IASHWHdFdi9l2UXDVEGJ0/qrwbiDgmJAIquFiwIZUmUIairp
         WmmuheUAirgO3oRng1j2YLxO0TfzxyKl4mCw8cJ3Eg3a0asOUp2UEq236QxoQUMHGasY
         jQbDsBC48zb0UmrpwiED7wyGTb1ECZ62hCBF3NXx5a3UTWNwPznphso4SMMKxtHfBqcZ
         gvKTQnY425qu75ksWWFfHCy3eruX3avTFY2ISLEG8V8IOp4EFTg+nMszsoWhOtSOkz2i
         BOCg==
X-Forwarded-Encrypted: i=1; AJvYcCUiiAH2hK0b0oyydWQIwJDf3S+d8RGpbVpqhWzqTYNQve+CfL93v8oP/ytBXX3Fcb2edqQU/dwN/GX4JGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+8zvTbbUhaUeHs433smqzjjloQHDH5Wf1VR0MGLuwg27NRpg
	BIjrUN8S3R9/EtRXlDnbm/CEoNSCaGLjdJy4ikCdYA6ydQslfqJsAmRhnsnawCqAAsf3UQiHzx/
	pOg==
X-Google-Smtp-Source: AGHT+IHVbE7MyotFOK0/MO8xvhQBRUILzC5BoDATUc8bzSwlPsvPrDtsqOB2AH9g+FdXyS0xyy5A+Jx8Uww=
X-Received: from pfbch4.prod.google.com ([2002:a05:6a00:2884:b0:736:3d80:706e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e2a:b0:736:3c2b:c38e
 with SMTP id d2e1a72fcca58-73961037e5amr990961b3a.13.1743018535394; Wed, 26
 Mar 2025 12:48:55 -0700 (PDT)
Date: Wed, 26 Mar 2025 12:48:53 -0700
In-Reply-To: <Z9NMxr0Ri7VUlJzM@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221163352.3818347-1-yosry.ahmed@linux.dev> <Z9NMxr0Ri7VUlJzM@google.com>
Message-ID: <Z-RaJVo1MKuI90G0@google.com>
Subject: Re: [PATCH 0/3] Unify IBRS virtualization
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	David Kaplan <David.Kaplan@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 13, 2025, Yosry Ahmed wrote:
> On Fri, Feb 21, 2025 at 04:33:49PM +0000, Yosry Ahmed wrote:
> > To properly virtualize IBRS on Intel, an IBPB is executed on emulated
> > VM-exits to provide separate predictor modes for L1 and L2.
> > 
> > Similar handling is theoretically needed for AMD, unless IbrsSameMode is
> > enumerated by the CPU (which should be the case for most/all CPUs
> > anyway). For correctness and clarity, this series generalizes the
> > handling to apply for both Intel and AMD as needed.
> > 
> > I am not sure if this series would land through the kvm-x86 tree or the
> > tip/x86 tree.
> 
> Sean, any thoughts about this (or general feedback about this series)?

No feedback, I just you and Jim to get mitigation stuff right far more than I
trust myself :-)

I'm planning on grabbing this for 6.16.

