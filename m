Return-Path: <linux-kernel+bounces-299771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C795D9DE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7EE8286100
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972BB1CCEF1;
	Fri, 23 Aug 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eabNc5X7"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E891CB142
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724456903; cv=none; b=e2sjD1R3hyuPMIGO8HWceHdmyHYD13KfFxrrwDC6HtRSx0Y/x+IqfR9wY0x2C+eX90XyVdv4JcSyZoCExvDRXwdYW8+eYEHh0xvcK2Xf6w83DJoHkQJEg2LTm1YEQSzrhHBD6CVjXWDbvX/Pku147VNSCEEJO5VeQqj/XaIGUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724456903; c=relaxed/simple;
	bh=PnVmzKJJoLtxPKYlnrhO8hCFrtM9qp0qrnc+xF9wO18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GOtJLwMWK+4mqSfkC3mpEiOKarldt4s4GDMscM342oGPV5A5tF3jn9779VD/Er+EpG8AoffiPZKKleVHLtCQDAkLPnV+Gx5XnZZn+Q5oSDcR30xbtX/wh7LMHEcNLhkjIItmlzXzXvG1rzRheov07ULAJOffAQZetTJm3RQMVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eabNc5X7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-714290c2b34so2344487b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724456902; x=1725061702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WCZ3bF2/cwaD0m14rX979B6XZ+dCyFWivoHXohUIvY0=;
        b=eabNc5X7oPOOHIuNqNJrJ7mE8ttKd44IcmLXmVvZAS/FCQSApWoMmVsFkCXPVfRAJz
         6MveGlzCKjZT2WIcTSbp2cgALc+TSehiggTUv3pzSD7P/DzmdtEMCWEwU1hnNw8+crmP
         xI9zWh4nxAowLCBN0Q9dk46Yg1o7GMN2/FtAcDlSzmgYim6TSXlXaXZ26sfzqFkoa9wY
         wvzAiT2XcENcMZnU1exzfu7Lpo8p+1n3E6KRnnG/4W5rwmFYdDWCHu6miAN91Z+PxZjJ
         ZSBaSk9Hw/+ed+RYKEyizYdXlXlRkPdAcdrMQ69AWlDx7UNOgbeyPR7X+vA0Ozknr3UB
         0CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724456902; x=1725061702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCZ3bF2/cwaD0m14rX979B6XZ+dCyFWivoHXohUIvY0=;
        b=G2PeER0buchG85yYPZxN342MPq/WF+428zkDBr2GxQrwBE0GX0ytfRQtW21Oem9nm4
         Corped56JyvXom9m0BA2E9oUNcISdDdO5+xqyynu63mB3gk+t1c207Pb0ZGnqQU4AUf9
         TDu69RUwuBGJv2yPQFx5FLdXGcRV7YcMFiN9c+/sZOTG3ROqz0DdI9QOUbwEmAzRo3/v
         FIrWHG8FQYYVrE2svSVckgwiG27hQjaK9wIDuGJsy4q3RXB7/+/wi8QP/LAAe7b1oJCD
         uNMK7xkU7Nq0lF8tTszmY90NxLHr+1TW+UQq3kep3/c0UQBbDMdQBdaFyRnA6jc5qIzz
         LkMA==
X-Forwarded-Encrypted: i=1; AJvYcCVn/B6uZinEUTn8VZD9HkB7/n7UkgDFEakTnDniDbea0st3UfXNV5dK4iwm6d/5Zh+ocIFnjFLaTWE54PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOym5Jmp9wke13dxEZ5ll8ic7WA3dOcpqPYJFMeaKCEBLRVnz4
	+0X0cbFk3xVTkTOG/XO2MU3JT0NRGtuBCN5VKG5a3HU52VcwSPBvZAS5U85Cd/J36lbyVcoFCKD
	o3g==
X-Google-Smtp-Source: AGHT+IFOzpKLkzk5rA/2rrwxxc/5JMDIP/kI66+HhXb7YtDLUhZ6qPLoyOuTrpJna3EykNDsGMdgJt46xRI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6f03:b0:70d:323f:d0aa with SMTP id
 d2e1a72fcca58-71431945089mr88104b3a.2.1724456901668; Fri, 23 Aug 2024
 16:48:21 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:47:41 -0700
In-Reply-To: <20240723000211.3352304-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240723000211.3352304-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <172442177547.3955389.11987354449064860269.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Check that root is valid/loaded when
 pre-faulting SPTEs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+23786faffb695f17edaa@syzkaller.appspotmail.com
Content-Type: text/plain; charset="utf-8"

On Mon, 22 Jul 2024 17:02:11 -0700, Sean Christopherson wrote:
> Error out if kvm_mmu_reload() fails when pre-faulting memory, as trying to
> fault-in SPTEs will fail miserably due to root.hpa pointing at garbage.
> 
> Note, kvm_mmu_reload() can return -EIO and thus trigger the WARN on -EIO
> in kvm_vcpu_pre_fault_memory(), but all such paths also WARN, i.e. the
> WARN isn't user-triggerable and won't run afoul of warn-on-panic because
> the kernel would already be panicking.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: x86/mmu: Check that root is valid/loaded when pre-faulting SPTEs
      https://github.com/kvm-x86/linux/commit/28cec7f08b8b

--
https://github.com/kvm-x86/linux/tree/next

