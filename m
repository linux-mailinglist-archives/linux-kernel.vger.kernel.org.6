Return-Path: <linux-kernel+bounces-263909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F7693DC36
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D252825AA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E5A15A4B0;
	Fri, 26 Jul 2024 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZFH8Z1f"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9318F2EC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038110; cv=none; b=kY0+HBpsX6DNjGUcHf1dkpGMdxTPgWcGypGEIF8Nb8r4PB21p/KqxGnT9+iENEbEuO1qB+uVS/9W+/zfDdqEtZITCKfUwIq+xG57hz68crlswaBhy2tiA38wUIwy8aMl6SYvLvLJHmaksU3CiJ8T+EdLDOKKrE+Acw8X7dyPVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038110; c=relaxed/simple;
	bh=LwnbsVmoSkGUot+G6cbXgIy7tatzU4elH4imBAcWXlg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WYFovz4flPWM7mFllbrZNM5QGM90JvSNkfvaQgIb6SvyDBy1mv0zIp/eR4Z1O71K4CkR2ZZQkXrLR/0C9BQOBHMtt+6pFy9se5hzAmk68qIN3Z+di3z7E/u7jMB9Jj57+MdxczAFmaHYPcyEp/pn8Zx+lqJfN4fBh/7t2/IwlBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZFH8Z1f; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc5f04f356so10599525ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038107; x=1722642907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Agw1NDopTbJHSwXqEMTAoK1oQKqohLcT4CyuwhV7hPY=;
        b=MZFH8Z1f6H+7tRJum8lT1Vm7ri8x+Xug7jf1d83CoRP56DsICdy3/XpfWetgSX84F+
         3O9Uygiu4wzYrBS6TGn9YuOSDHyMhkron0pg612PO657AGWM1CJoXdyZZwSGBxYTKu9L
         uYXTaAzaSeoBPIu2hHk8gw29P9fdLK64zGzFVIjowqj6XMtueIdgrlrw6AoIVQz/Rwg5
         nOrndP0boNuzbW9ZXOcUox7y/7Lgwpgnle+J9kMwZ1GGGeqhvu8LV1TdCWI7DaZrXiaE
         am/ABXWN9T68epdnmT2yOBlUWf0p3L/bMPX5qNRe8KmWoJNGeJTD5sVm+abEEJgZ7Cdu
         cJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038107; x=1722642907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Agw1NDopTbJHSwXqEMTAoK1oQKqohLcT4CyuwhV7hPY=;
        b=lqabnfWeNCMysabciZZgNvCWErqADlSwcExMQSLqUP0yQF33EpvEPRWdQ65AfU8MHj
         PdA5c2lTJF9X8vJDRiazKMdWyzxWXlc0y3SVdel6Q01X3JYF9o8HNnj5QXmEifGligPk
         jwFeHW6KzOawJqxtgSz5lN0hDjBHfjfS467nB5xniLge45d4m2oe7qWmGWBCbRhuPNBd
         0sFEuiRab2TPFx8UjyW44jfNMl9U/8Y4JZjwII7zveeOwnakQgeH1Mp0/FtlPo1I3+XK
         HrdOcGoSQvhfrg3iAg1eg7TCukVd3rHW/sgJRBzdueCDDgqpKR0eGnvtCM2gSNkNXDIP
         VGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqKmzBpKeLQGdcmS9iAQwUz5OxBnxh4e3+xfUMHCUP0tfHQf7AGR1zOErxYn/AozX49ikQirbR1kfTXYYxy4KNphgrPuCNb+MrSsPf
X-Gm-Message-State: AOJu0YymSEzBGg9xX4PiTD2UPCEX/qtdqQKzTGdIQJRO7WGZEO5viYTF
	Tg8r7tMagfSi8Og8tidIXEIIDukW5UvOIgCEato0ew0/zEFN5iQvHureAEXzmZsBDYeJ4Qsqecw
	mOw==
X-Google-Smtp-Source: AGHT+IHxZ9LAKt5vIHU7V05HDfJ12gC6skwH/WeW9XOXHpR7B1c0ubRWlOUtq2UiALskA4rClXraM4lFVDE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:b18d:b0:1fd:8ebf:672c with SMTP id
 d9443c01a7336-1ff047d8f61mr25415ad.3.1722038107293; Fri, 26 Jul 2024 16:55:07
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:52:21 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-73-seanjc@google.com>
Subject: [PATCH v12 72/84] KVM: PPC: Remove extra get_page() to fix page
 refcount leak
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Don't manually do get_page() when patching dcbz, as gfn_to_page() gifts
the caller a reference.  I.e. doing get_page() will leak the page due to
not putting all references.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/book3s_pr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 1bdcd4ee4813..ae4757ac0848 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -652,7 +652,6 @@ static void kvmppc_patch_dcbz(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
 	hpage_offset &= ~0xFFFULL;
 	hpage_offset /= 4;
 
-	get_page(hpage);
 	page = kmap_atomic(hpage);
 
 	/* patch dcbz into reserved instruction, so we trap */
-- 
2.46.0.rc1.232.g9752f9e123-goog


