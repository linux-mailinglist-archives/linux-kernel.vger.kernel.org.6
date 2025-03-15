Return-Path: <linux-kernel+bounces-562364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85EEA624BD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7EE19C3FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516B8185B5F;
	Sat, 15 Mar 2025 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HXVJUm9K"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5138911713
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006414; cv=none; b=mZiDRRUr4OQO1an99wZ/1db6RCSz6PJf+b9HhpDb8G1iAfYIGr05Su2Rns4DDKqfwwb/1KR8X0wYRmDckjEd0bVxmiyzUAjGsFeuHwH82porlbbmdC0ueuEVkfHhgGQMQ0upQptPphZaHdVOfZvXalBzrASCoNXlNxRDazEkjFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006414; c=relaxed/simple;
	bh=F37DdpTElQ2q2g+ifpTPVUBGVrrJmQS6C1fk1ytOIFE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pHfQYkKhll7q0XteJnVEVChk8ig6XibL/okQ3ekjBuIWJx629Llm8XQd+XeS18V93WzUWVq/UGTEEVEZt9blfEDwZCjP1ZRZvuK6hUe0ay7ZfrtXG8maxbcuNc8+xqUsy8jDPOFvadqWLwmh89MB6KUQhOIadqbKDmz25kJRdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HXVJUm9K; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff82dd6de0so439365a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742006412; x=1742611212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p243mb9oLjguco3vJ1B5SxoOuqk2mjKqrxWdDVESxQ4=;
        b=HXVJUm9KkAvPhhQoykv7Q0oH1PfW1B20eT+oQssC61A5Q7/O4zZ9OTzwgAY730jRCZ
         FNwhAViVIGb496cMb8fInJUKr5m+qHjcuxcgVmV6aWtg6v7cB+I7eNULzrW4JbkUGKvC
         MSDuH8rMkfGkvChsDuntpM1r5aoUqdKBh4QNbYJhYw7FcblBndA7xQNdNU3zqXkn922B
         jaUpQJ96XehwPv6bF6kjkYetXA8JJwluX8B91sYbyeRwHeCKBKbJtJkGh49VTblGosHE
         kOOKEmydDJ/St/qx+GLffdIWYaOo3cPVjai85ZJ1mBAPmvetP/EJrtkQOXOWyteQXsA/
         lXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742006412; x=1742611212;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p243mb9oLjguco3vJ1B5SxoOuqk2mjKqrxWdDVESxQ4=;
        b=Mwp3EBDnyn1RcTdvb3rzxNwfBdi5Wi+TRvmAH5IYVot9y+lXbNiVsXTZRGopbQsNQj
         1HQIJ1c/Xgo8Dex74rI+pjpm4eargijr6208MV0uEJSJ6qvJUn5j9YWP0AxWfztSKtMe
         umOcf2ZUHYorjL5cuaO2NBarfFv28Um0KMeCgQy+9L3CxOHvKQVTVXitxvxD0dk+K/MO
         UycnVkFbHi8RS5ZXCzPTLQNsC6jWq8dMGajM4AunUk81hynrmzDjz1nM+mjaGqxpJsfi
         pryxdORtMwp5vL5Qp3ejWDzd1xzEy/bxI1xcn0yjDFt0F/diicEXGQ6N/KpeDdmHigI2
         tymw==
X-Forwarded-Encrypted: i=1; AJvYcCVUV768hFZVi7P3aqlT00j1kkh3ZeMZf6ri7QWuD7bJSgurs3q0NW+FeiqWS+jl74633a3sYGc0k15j6H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZvrKrCTuxqkdBcQNXMBmN670mO7FWbtQKGO51F8ZddhjhCCp
	gkuRai3v8Ungm88IVs5ZJMPpFU/CCFgHKIM0MTxYbApFkH4njlLWONbe/hi8JmqM8rXGl0OZLFl
	jEg==
X-Google-Smtp-Source: AGHT+IGl8oTkoFLkt/cHHZ+lGdj9KR0zQyx8nSi0QEJHT+P22WLdQdUmgVzr1J4zJ+0c36Ci2iOcUZvc+50=
X-Received: from pjbpt11.prod.google.com ([2002:a17:90b:3d0b:b0:2fc:3022:36b8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5247:b0:2ee:a583:e616
 with SMTP id 98e67ed59e1d1-30151ce122fmr6575082a91.9.1742006412651; Fri, 14
 Mar 2025 19:40:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 19:40:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315024010.2360884-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: x86: Dynamically allocate hashed page list
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allocate the hashed list of shadow pages dynamically (separate from
struct kvm), and on-demand.  The hashed list is 32KiB, i.e. absolutely
belongs in a separate allocation, and is worth skipping if KVM isn't
shadowing guest PTEs for the VM.

Sean Christopherson (3):
  KVM: x86/mmu: Dynamically allocate shadow MMU's hashed page list
  KVM: x86: Allocate kvm_vmx/kvm_svm structures using kzalloc()
  KVM: x86/mmu: Defer allocation of shadow MMU's hashed page list

 arch/x86/include/asm/kvm_host.h |  6 ++---
 arch/x86/kvm/mmu/mmu.c          | 48 +++++++++++++++++++++++++++++----
 arch/x86/kvm/svm/svm.c          |  1 +
 arch/x86/kvm/vmx/vmx.c          |  1 +
 arch/x86/kvm/x86.c              |  5 +++-
 5 files changed, 52 insertions(+), 9 deletions(-)


base-commit: 7d2154117a02832ab3643fe2da4cdc9d2090dcb2
-- 
2.49.0.rc1.451.g8f38331e32-goog


