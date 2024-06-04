Return-Path: <linux-kernel+bounces-201562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C19C08FC004
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D43B28525D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5391C150985;
	Tue,  4 Jun 2024 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrXAbudi"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14314EC6E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544340; cv=none; b=Fl6MCyDh2XZDqUsGhU+BT6M7Kbpajlt7hLW+eSfhgEeFHxdshdZd9VoPffDKI3tc2Gt/jRymBp8tW+M+uZq8xG0TYa3KQTCuRRcNMx8UhphVhyjOP2F7CMtoK1RcoVOVXBp0Zor3BiJGfsYxc+W1SnJyFa/4ZunM5FVu/u0EJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544340; c=relaxed/simple;
	bh=RusASFhma6YK80SGBs5LHmKoNW4EdhIzbx1W+JwsWL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NFfbq9W1DOVCDDoV8TrjsselIGG1G6PunVAcwNYXTnzo27/xutWEMozQzjWl2CJA/eMcDheyxhLiJsCQ3lfqKh2PUFemfinFVyo0DAP3g0u/Iy9pMtBoFCiy8vU0OWXnQZh1+INp52CBrxbgXdMMe9crpd120zrZScObCfBFZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrXAbudi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a50486746so26300037b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717544338; x=1718149138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUvJNthG5Etp519IwCtLXFB/iTjp2rnBA/tiOcz0nSo=;
        b=OrXAbudic7oriFqbQP91OGF1VQlwaesIrtuxCIQ4XPUlneNVH7M3C3dLE1keGXP4Yd
         rQ9gaCR/K/0+uH7A+kvylDYk4eWviOmj/VtU5RcVKqHBGUoWNL39b1Bb2NZeEV3miuF4
         +7+yLL3DW7ig8NYsVudLkP0DjujVM7pZp8Kfu4Sog+XsPg1bBnMQLlkMd8HL6YkQQPKw
         xJeZJY0VBYAoVXKxN41bTUeJCzSFxIaHF51AxnJP4vgsNxSHi0G9dF8/TUe/cQJrBqcc
         FHBe1F18P9Rtz/LLej3q4AmwS35TX9J0NSAaIUcnMbjQVtvFTSt3YGy0F3PZo/EL3OLe
         WZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544338; x=1718149138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUvJNthG5Etp519IwCtLXFB/iTjp2rnBA/tiOcz0nSo=;
        b=jIWBtQ2F6g9r4ILjqPd9MZ0OAVX3DIOBg4q98MqUSPCeW8Y/iuBKtD3eL0sXqVXVC3
         xMGoFP5xPr59p7cp1MIq7Jeh9pZ8++Lv9eqbSYWnhogAK/5zTc9yeq2asLzyFmP7p4kS
         Y972kWW9GnU4gx4ZXrif1TmwIQ+6i9RIdouhsukc/AGi/4pXAe3jRp3WM4PCVs0tTz6j
         mg/j/7QO9EYmRtn9Uqz4Y5ZtyydwLiaqeqT7RsVT3jS9vpFtAncSpG8Ywa7H896R3GoR
         6Z8IbxlC6QAxPdK629A+YowbOoAs7nXxlIfSDtBu/WNNb+7oeuoqnmkC/0c7oGyWfRL0
         FAow==
X-Forwarded-Encrypted: i=1; AJvYcCVbiGwfdXXRIqwA6DUuRCiKZrecMCOmI0EsSUsomfxMQgP752Uv0+tXAMcX4UAMDZLhs6TMFMKexm7Ke0P+a+aBK91vC1wYkPX7+aXA
X-Gm-Message-State: AOJu0YwwYG3NpkZDsucR7eiExb9jb6tvBEzAGRYGGsS3gx8H9WDnzBzs
	9jklpbd2rloa9d4NfkeS1exv7qOGsIRYFaDDz/6EdejUtukknsquvQeiiBeATO0ZuVQmFlRf2LM
	VEg==
X-Google-Smtp-Source: AGHT+IGftjt4bD1elZSc1NbW+UKVTrbQmDNQ5NXixE6FiB2KoBEAHIGgkpeZDCkOZiJX23uP25Lkq1/FzeE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:fd5:b0:627:e282:6631 with SMTP id
 00721157ae682-62cbb58c2aemr2425297b3.6.1717544337919; Tue, 04 Jun 2024
 16:38:57 -0700 (PDT)
Date: Tue,  4 Jun 2024 16:29:41 -0700
In-Reply-To: <5b0cda8a7456cda476b14fca36414a56f921dd52.1715398655.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <5b0cda8a7456cda476b14fca36414a56f921dd52.1715398655.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <171754371923.2780627.18224114204018565468.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Only allocate shadowed translation cache
 for sp->role.level <= KVM_MAX_HUGEPAGE_LEVEL
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, 11 May 2024 11:46:37 +0800, Hou Wenlong wrote:
> Only the indirect SP with sp->role.level <= KVM_MAX_HUGEPAGE_LEVEL might
> have leaf gptes, so allocation of shadowed translation cache is needed
> only for it. Then, it can use sp->shadowed_translation to determine
> whether to use the information in the shadowed translation cache or not.
> Also, extend the WARN in FNAME(sync_spte)() to ensure that this won't
> break shadow_mmu_get_sp_for_split().
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86/mmu: Only allocate shadowed translation cache for sp->role.level <= KVM_MAX_HUGEPAGE_LEVEL
      https://github.com/kvm-x86/linux/commit/9ecc1c119b28

--
https://github.com/kvm-x86/linux/tree/next

