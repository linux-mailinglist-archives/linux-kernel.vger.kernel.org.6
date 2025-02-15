Return-Path: <linux-kernel+bounces-515939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45D6A36AA6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D37C1891E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB10741C92;
	Sat, 15 Feb 2025 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0VCz6vGf"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EDF78F4B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581791; cv=none; b=aGntE4C1CROySK/D2eTY4da+uL3OepQXnCB9ru3aMtPhCgfpSd7AUdKQCu8Pwq93WQ/XM1OCRD4IWxF0ltZugV5pKbtLUs43ne4ST9VnpGspMQVMrj1TDpQlOUAUGpy3VHAXHxN9M9hrU4KuXTrlGtWUq4SbcwitBtYzCwMy2yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581791; c=relaxed/simple;
	bh=5SqsxFyjoWcxFNf6Hg/LiMYgjTxlgCTtPvOJjWXlJU4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=txc0SzItrYmwKHoOK/gvAESw+9nk3UcqrqbqYWUDhVfqFPBwkK1Ej7BcOjpfB6H2FDXFh7JSIC+cHt63J2Feqkj1nHm7tSJovtePw0RMCah7YcT2wNif/2rzX1VbVpez7fl7EGEM6V4DkTgJ71iDjKddh8PBVxAfmgCzYBU9dYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0VCz6vGf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso8411808a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739581789; x=1740186589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ft9NGbA4u44DYHGMH78+t9Ma1QvHtYydU6iA2plJOxw=;
        b=0VCz6vGfF5kQjUNsBQcEq6tvV1exF5P2GnfZ0E5cQRUcWUtdl7so7voW8KacIsc6Vv
         9QJQPOJQlno+dPKJx7x3XI800DWOsucr2PCtusVZH+QwWbEKyXUnH+q/NqQth7I5m1Lu
         NuPxD87Ma8qkQuBa7SscjqGztHwmT7MQRP9gxqBbntZZObMmpoKop32+ywgm5F6RXO5D
         95Q9ZLtuzBe0yhJOceuf4a4dtLJsxY5tYExcqsT59iYmJICdnBaTUy+fA2MJKaK0/HIZ
         Yt69auBAo+tG6x3CTGcY4cVYhxDp8qpM+QxXXk9NqJ4I2M05dJJp0zQUPpE++j98ZSNi
         dDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739581789; x=1740186589;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ft9NGbA4u44DYHGMH78+t9Ma1QvHtYydU6iA2plJOxw=;
        b=gCQ2h+4LcHUAjpvBWimCf0tTKECdNSQZPEtA26EYMRKW5zkB3htMvFVo/7fy6BO8PU
         JMsucth9ynZc1GOvbCdyPyxP7R0sNH+ur7BBYBzD/x02T/wJV0tTUKe28NC5vze3OPMP
         Mr88tp0HYhs3zIXUl+g4EO2Z1VaNxos+2JO/u8z8DY9oVx3doyahFtW86MpVlun5AZr0
         27/y4/TUwTuH0LsQeweHkTLWgB8QLA/pbOLH7wHc8tyhRvw02zuNgGKbzRCNweLNqJjL
         cHLGYJGTUlppcbH9k4y0dF24OFWySuO67/Xg8B6P3CRdSgD/qv0X1jj4LxXhZBlidilW
         pu7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW45/bcCfxwJAiuJGew79fyDkB85/naWRk+Sthhokc7nop/n72HHApyDD7hQuEv2eliLVhjWNp3xlVF81E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4x//fzrvFyaBxpjzI9KYhs2nKg+a/9VmBhngOzAnLqiLos/C/
	UkoRXP1XtkkHdZ9tRo2e8qEBhnDN++VOk5UCQHEQyuAuAyAj74BbjEuVsPMhN2zofFcMxrAu5PX
	7jQ==
X-Google-Smtp-Source: AGHT+IGPReR8yPKp90g7iQv7Dwmt4gM4UA2F5Uz0fqd4eIZOb7XvKt0R/RDgOGVTmzaTTFl3g4BgUfRVtwE=
X-Received: from pjl14.prod.google.com ([2002:a17:90b:2f8e:b0:2fb:fa85:1678])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2789:b0:2ee:e945:5355
 with SMTP id 98e67ed59e1d1-2fc40f21c9bmr1729152a91.19.1739581788933; Fri, 14
 Feb 2025 17:09:48 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Feb 2025 17:09:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215010946.1201353-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: SVM: Fix an STI shadow on VMRUN bug
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

Fix an amusing bug where KVM puts VMRUN in an STI shadow, which AMD CPUs
bleed into guest state if a #VMEXIT occurs before completing the VMRUN,
e.g. if vectoring an injected exception triggers an exit.

Sean Christopherson (2):
  KVM: SVM: Set RFLAGS.IF=1 in C code, to get VMRUN out of the STI
    shadow
  KVM: selftests: Assert that STI blocking isn't set after event
    injection

 arch/x86/kvm/svm/svm.c                             | 14 ++++++++++++++
 arch/x86/kvm/svm/vmenter.S                         | 10 +---------
 .../selftests/kvm/x86/nested_exceptions_test.c     |  2 ++
 3 files changed, 17 insertions(+), 9 deletions(-)


base-commit: f0f0cbf3b767935abcfdb36649ab626fb2ab5ae7
-- 
2.48.1.601.g30ceb7b040-goog


