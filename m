Return-Path: <linux-kernel+bounces-392795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A21D59B9836
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583DF1F2114D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC351CF281;
	Fri,  1 Nov 2024 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PX8UGIef"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC1B1CEE88
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488491; cv=none; b=jyK/2PIXPo+7knmIUsZzxHql9tQGbZx1lVvCbQfOR9hxM0wdE/lduLMd9ZMhDMopN+qVrr5hhQZdWmvGWtas+Tui3uB27gEcNjHiU+pYNe53fvPV65uVwyDBs6kftvTTNK8wT0xySOwzuoiABpHrqYG453XeKsKhMP8fYAiY1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488491; c=relaxed/simple;
	bh=C7gwsh4j/BAB14lD7dzupP/dHGuEiIminjPPibGx7cQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HK9IEn1epALNNXq88tjcRJ8jqochtaY3n+N7x5ECA8C1PadHZfNh6JTWgKliBrRgi82WkHOTUffLXYYwKVpE1vDVAzkzhGNQ4nCfzzE2lJo7pcSndXWMsJw81mIvc2vcVg1wW1fVhyGeFyzezfBSJXuRHNPeCVhJ7VBt+xGvBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PX8UGIef; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-206da734c53so25496015ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730488490; x=1731093290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urd5EkNykePfHeXMeGS6iuB80oiMj96n1Jo4CkHhTrE=;
        b=PX8UGIefYdyAkqVnueRDgFJ7Lcw8GQWqgpfymminS4dnCx5zG0xfSWGE4gPdYAvwpK
         g1PVTT8XGkM5LOq9THJLIE4vZ0hd9zCgg5A2y8kYT6MEeg+bQ5C3E7butvQJVIMbCvDz
         P8SJPhl40q731PH27O7eEjWR86CSmvmf5+EaARibpT1KN8yyLIWgKC/683cc+s+Vuks1
         i84ucbJqxUCNFPoR4OSNFw+GRhgD6MCkJWIo02HkFX/FeaypiKgilAv32O4cC/xHkpkE
         UXYtlikwV8kXyJqRe25qdKcdMX/jN3H3K7HuGNOAJCgkKQcwjkcCw4MOtIFjSUSSdPHX
         3+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488490; x=1731093290;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urd5EkNykePfHeXMeGS6iuB80oiMj96n1Jo4CkHhTrE=;
        b=RNxZ3NrPAEzmz/p/Hk8pHNmP1KDSq7dlsAcDMolR6n+43saSSrV7tDY6pQs8GJKlzn
         Lb2kn9l8C/YP1mTOL2ALOuHke7ZpP8IPGvhDEP+muKnjYFKL7PE6HmFjusVs8Rk4Hhzj
         5YYRun2EECSxWkyu1yQuvAJXrF0+qQ1LJp8AHiubdhZ4/Xk2V+bVDx7af/mdlctb5reE
         OMuJu22CZBBqU0gmfdbATocSpGJ7RDpTSVgkTfEPXhxKdSe8v2gcIxe8nVIic/MehbLf
         xs4nM0dQf1PRoH/l6k9JoiV0srgCshvOHX+c8F6tr1ME+qBpYYr9vlfseG2hoSf3NGDJ
         oIKA==
X-Forwarded-Encrypted: i=1; AJvYcCXfu5Bp37AcTExJt/iY6ZjpJh9qGVG8gZN/rJIQPrkf10f+lPDAFLnAixYm4KZR0DCSqTPyUTKtLXuy+mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjsm8TJzCPloJyq1GehV5kBn0tZeEQLA7jQWaVcOnczpPA3nA
	5h9c2v0eLMokyLd+/GgU72cXnpMxaE1rbY86ynBByyL7JC98Or4cME+tH0hVMgqU3ufGNbG6dLX
	2gg==
X-Google-Smtp-Source: AGHT+IFIwyHK3UYBd7Qrg0OHF3Ib/N5mjWdfHnpOyY3of1Prd3NCXjRKiQLeEgUK8FIHCxqW6kif7w6+Uok=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:903:c87:b0:20c:716c:5af with SMTP id
 d9443c01a7336-21103b4d985mr77505ad.3.1730488489855; Fri, 01 Nov 2024 12:14:49
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 12:14:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101191447.1807602-1-seanjc@google.com>
Subject: [PATCH 0/5] KVM: nVMX: Honor event priority for PI ack at VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rework and cleanup KVM's event handling during nested VM-Enter emulation,
and ultimately fix a bug where KVM doesn't honor event priority when
delivering a nested posted interrupt.  Specifically, if there is a posted
interrupt *notification* IRQ in L1's vIRR, the IRQ should not be acked by
the CPU if a higher priority event is recognized after VM-Enter (which
unblocks L1 IRQs).

FWIW, I don't exactly love the resulting code in vmx_check_nested_events(),
so if someone has a better idea...

Sean Christopherson (5):
  KVM: nVMX: Explicitly update vPPR on successful nested VM-Enter
  KVM: nVMX: Check for pending INIT/SIPI after entering non-root mode
  KVM: nVMX: Drop manual vmcs01.GUEST_INTERRUPT_STATUS.RVI check at
    VM-Enter
  KVM: nVMX: Use vmcs01's controls shadow to check for IRQ/NMI windows
    at VM-Enter
  KVM: nVMX: Honor event priority when emulating PI delivery during
    VM-Enter

 arch/x86/kvm/vmx/nested.c | 77 ++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 33 deletions(-)


base-commit: e466901b947d529f7b091a3b00b19d2bdee206ee
-- 
2.47.0.163.g1226f6d8fa-goog


