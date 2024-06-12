Return-Path: <linux-kernel+bounces-210759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B990485B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BAACB20B25
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A520C8E0;
	Wed, 12 Jun 2024 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+Q8nXeL"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CDFB652
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718155341; cv=none; b=KBat1C7DJcpmI/d9QSPBaT1qP76BgzG3FO7RYXvJe4Kpg/oGtmwbabX7rUaRT9Iyf0BHRkAYiuqQMzUIp0gXtTc/Vmr+zUzX5hFhNa6jDSeKMSbEJOYbspAPagkKxsYETruxrVR73dFtIxZqvuQfQx5xuC7GPktfPGLxLpQqdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718155341; c=relaxed/simple;
	bh=f5VMVrZU7oSQ79Bsj5/3VuRRuEsNMLKcfiu9/MHiQ98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XFNZH1AfGKqwdSk7i3MGs6+ZUweOWX3AplT7I+qArCnMEBZrThMi1cL6NCJqq2Fg7tTJEbbOR/H7fdDkp5RY7HtuguE+tCsT8NhwT1ycJL5i5WKW8OCskrufCwtmmxzsDw/cV6EC6/R8vHAPtGZ43WwYpzgm9hwAuOIJ9TUhJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+Q8nXeL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70417103e68so1449930b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718155339; x=1718760139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb9f+cg9Vl4nXnhugQmQCsJ7WTfeJMYPPx2YMVNc+QM=;
        b=f+Q8nXeL7A2WObUhjzfk+rdOmlf8gxP2D/Zsjr40xFtuYFMGXRE+4eb65pt5pC2miB
         G5FlEk4YaOyoQufyvpSXkoLBZHifXDarBaNN42F1Apb8aBPCvJeIK8mgWmieouM/6pDZ
         lJXo/2AOcu6a+gw+WfX7zNa20s+zR6kSNCHBlTLN02wY+fV9c6XFVL56veF2Nvsbe3Cw
         z6Is37q9B8rpvWhqKpb/hortVHLIbYiha/R/ZL5wvC+xtT2iAsf3t1G8YwTkYS3lTXVm
         aZyzNr+pGXfg4rpevY631Lhgw6VLGgwHSpwbOAOG6hoa/MN2mCwAZb5wQ6/CaOxoJZSC
         163Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718155339; x=1718760139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb9f+cg9Vl4nXnhugQmQCsJ7WTfeJMYPPx2YMVNc+QM=;
        b=PodSP3/Eu/shW/Zic0kqaYNSx1e9owi6keED1qA2SlsAS2C0YzWepTnoOUOq2meXuW
         Srr6s0PFIRBP2wIp+Km6Pg9MgprjTRlyrGdA98NoWjuNV8gGocHgxiIT2KhmmIPf4OU8
         8oVC1BrcdiIZVSSmXxopnwKX5jpV1T+Vw9qhBA7Cc782e5Du2wu0n2bOUCyaGvICoI6i
         yX55mWWC6MWqvC+6TO6DqdC04TnZO3ogoDSfr8n81SOtI7RgwRyk+qAKrkebC0gUgwjf
         QQiRLubv/vCXgJRyfxiePjGLru1LT77KVl9sWgYvGY2Oz30DIKFJssIvPyilHkNAbgu3
         WO5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjYgS5EpFCV7CfmrsxGSBeIvQHOMBB/jZelioVUYZFhSQNWFBml0hgvQI914C2nTf2xbkahleaVorhMI7NMFfz8+TFUTH9LIMK7By4
X-Gm-Message-State: AOJu0YwvQQqdWqXoHVsIsVUsJFbh+p0xkzADdONrQVe9agP2SAKfdXg5
	M2NXlOi6tZRN1VFD7nsmvwkgNkMzx0Z/BNSO1hry93cOOhBlWktiG8POrmPRmbOXp+2za3wh4js
	FNQ==
X-Google-Smtp-Source: AGHT+IEmowuaCYMrQr3ZSgZ+OAYGBjHSMxfno7VRdfpQ8+oO+V/q/7VsbGu3tmviAI1flX05a/mL2QKvEiI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:890b:b0:705:bd14:61b5 with SMTP id
 d2e1a72fcca58-705bd146371mr1756b3a.2.1718155339378; Tue, 11 Jun 2024 18:22:19
 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:18:42 -0700
In-Reply-To: <20240608000819.3296176-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240608000819.3296176-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <171815511021.423253.6283731694914331846.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Add a helper to enable bits in FIXED_CTR_CTRL
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 07 Jun 2024 17:08:19 -0700, Sean Christopherson wrote:
> Add a helper, intel_pmu_enable_fixed_counter_bits(), to dedup code that
> enables fixed counter bits, i.e. when KVM clears bits in the reserved mask
> used to detect invalid MSR_CORE_PERF_FIXED_CTR_CTRL values.
> 
> No functional change intended.
> 
> 
> [...]

Applied to kvm-x86 pmu, thanks!

[1/1] KVM: x86/pmu: Add a helper to enable bits in FIXED_CTR_CTRL
      https://github.com/kvm-x86/linux/commit/3b65a692a5c7

--
https://github.com/kvm-x86/linux/tree/next

