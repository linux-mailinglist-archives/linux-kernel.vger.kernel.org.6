Return-Path: <linux-kernel+bounces-210756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A365F904854
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB72B2349C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85173DF62;
	Wed, 12 Jun 2024 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgokbjKk"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050CCA7D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718155304; cv=none; b=kOs1KKOF3OlQ5bU/W7Lj4Kn5JMGwgnkJyTRKYOJi/3CNAg0gX7qLxOir7wZtjHTH0RwsXVdyOSt4Bv5Lhf5z5D71wXLhvMNP79GitxPSvj/qnqXOG0vAv38dd7rZNpb7YVZwIN8jxfpfULfPoQ1kqDX+xkHDGVFazCZHCvYzOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718155304; c=relaxed/simple;
	bh=GlapdDKhTIPCCJP/VkWHjj68tVw41md0iGY6n3ryj0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BDrATCu0QiFDdy1sK2BSXOTZXgnVn1X0BjF5lfn2ILnIp+7g1G5e9wkPr6OGBTMhJYgcKNsC0C/RygawoLa6jc3kBgj3ngAIM1QkUcl0sZD9AsuC6c4xaNErTrunoJsXpBRUy+PPP/vyeWcEx9/zl33zVIFZOWp2wlqm6IFXNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgokbjKk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa84f6a603so10520325276.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718155301; x=1718760101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=949Sco2VRHaNtzMxd2fbftK/o32Oz5QH2yGUJXRf1kk=;
        b=dgokbjKkIQ6Lm4zfYBCgheAKFvMp2cLnqTVO4RDa32JkAVCYkW+wXDbg/xIIK9Flp5
         ZC0VClD+tip33nOL46K4kf3mCTVmJk7x92By8aNQH99Vt12YA5LEepjdsko4Yhi1VTnB
         fozhe5emdudhOBxMOPekPMXki4PNJW14b8uGaUV5ye61sD8sy7lj+4Q06s8w3eFBEgtN
         l/xPHdkhvpJBJ678NAFzjhfwUEET0SBg8PJ89OHUBvvpfo9AsYqzgnh7B2BFd/LtrgWL
         syJO9NGsNkWSlhOWMZ+5SVJBjr627DcCFRJMZmSIaFz1ver8aAwixET45MbJ1clDMWlN
         a/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718155301; x=1718760101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=949Sco2VRHaNtzMxd2fbftK/o32Oz5QH2yGUJXRf1kk=;
        b=MMGvSZxFJrg75p/quYVWgxuMjDKadG5/OtE9TSXefaXSxea6sOubVaUX4ojUfa1oYZ
         dZCtTSj3Oqkn3CfCuPMOlXELweSsDQMV3Oa1TXf3zwHVpJTmgSJNfZZgruUCngnTJKyC
         rdfil+R3TNR0quyAvZdvpEDiQcrRVccuGM7USCYozZGudiDUKMk5n+3FTmCAXxtuT+uV
         K7RjSrPgjIWxzAQl+G9HTG91TZQNffl/tLpPevD2yu9f834WdaMnXXK3UTpBrFZY41jR
         xZLYv6AiOrlK2v7dIwYOaKlQLcqlsQMwEFgABjt4VreDVuB8et0HD7r1zzCXUQFhzrTt
         p7dA==
X-Forwarded-Encrypted: i=1; AJvYcCVPGkzNUMI/hh1r/5bE5+2D93o9+nVsJ7YU2tqDPl/vrK7TSM0n8sMWLZ/j97yTqoCc30xnsiFph9UDVmDTDRjTIBdpCqlLmyicDh/Z
X-Gm-Message-State: AOJu0Yx2CVofVbrv5/8i/trkoHWhBdTtmSOuXpMV6ZMxyChCei5G76+W
	uYANRpNslJNIxutErbloFvTmkzWhGNyPig1X5rR0MjP9VRF1wdgjZeLBym+NFwX2qT/GGt+apL8
	q6A==
X-Google-Smtp-Source: AGHT+IEV7dvCZCTRpJ744rvbmMY7/LY4nMjTd6+1Xr4TaQMCK/If60QDgbv1vmQQIQ6r1mtLOEulyXxkmDQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c12:b0:dfb:210f:3ad2 with SMTP id
 3f1490d57ef6-dfe65f78d94mr29693276.2.1718155301449; Tue, 11 Jun 2024 18:21:41
 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:18:36 -0700
In-Reply-To: <20240508132502.184428-1-julian.stecklina@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240508132502.184428-1-julian.stecklina@cyberus-technology.de>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <171814098169.327928.5071447429899645642.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: add KVM_RUN_X86_GUEST_MODE kvm_run flag
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc: Thomas Prescher <thomas.prescher@cyberus-technology.de>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 08 May 2024 15:25:01 +0200, Julian Stecklina wrote:
> When a vCPU is interrupted by a signal while running a nested guest,
> KVM will exit to userspace with L2 state. However, userspace has no
> way to know whether it sees L1 or L2 state (besides calling
> KVM_GET_STATS_FD, which does not have a stable ABI).
> 
> This causes multiple problems:
> 
> [...]

Applied to kvm-x86 misc.  Note, the capability got number 237, as 236 was
claimed by KVM_CAP_X86_APIC_BUS_CYCLES_NS.  The number might also change again,
e.g. if a different arch adds a capability and x86 loses the race.

Thanks!

[1/1] KVM: x86: add KVM_RUN_X86_GUEST_MODE kvm_run flag
      https://github.com/kvm-x86/linux/commit/85542adb65ec

--
https://github.com/kvm-x86/linux/tree/next

