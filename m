Return-Path: <linux-kernel+bounces-359760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60392999047
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472291F24FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F211EF954;
	Thu, 10 Oct 2024 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zBhsl50q"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E201EF0A0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584725; cv=none; b=hZ8jI/5DJy7L009qibkEBv1tVc0PeYWRVVt0jWoMIqSkCpehTt1hso8e3YfZ9TXZK5/gfAGhUX1TRERiWrHqE4y79fD9Qz5XCOuM/t8TopXYqJlPm2O3w7senbxTMzdVJtu7GksgzL/2yUR/G+SoTA3EQngCK4QEg3TtMTr/R14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584725; c=relaxed/simple;
	bh=rFmsStC1d1lztIwj7oxh4zyq4MQj9meeqHdDcxeq/wk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q/dg6eiatbSddyOo9LAKJhoIjCFFBasoy8w4Vmh4GRvnATG3INl2R8gH8YNuR4JF7fF9UEhufquQTqlvJasKt7Q/K95SbG04g/93hptK2+pN3qrrfWfasipqScHDBYuuZdCcRHeei+DnTz8D181S2nV596hMmfpunkU0mMwxJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zBhsl50q; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d4dee4dfdcso1264255a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584722; x=1729189522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RdgAxVyxp31c7WibHLiyIF43paER00mxZOAIHhsdwhk=;
        b=zBhsl50qhIyYlq5VgEtE/+OL3pX+IkWGN8RxGVp/QOIATD1A51kLNeCudHlw6tpDB0
         TTnMuZ0YrHvKBYD5A8G+ycj8IUIKyFCIAvMqpCIDMUUrDrOdy+ab52MBoxiszJHwHzOm
         sj7/CT59ErmtRPL1Q4YUop0G579u9pMO68H1UQD9Q5tvvttPtuceH0HBENkiQygrEN+L
         UXFheIKzvN3cuQNMasUDogdtF4XkKlByJg1oeWEuvwjQVYTXh4u+Ukk61xBxYSl0CUBn
         zAffTJ/B4qMDCsY9MtrgvulhfXkVKD4XfiY8/udxWcKlNZIr+Ec1bJeX/OtZ25Pola2P
         ZJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584722; x=1729189522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdgAxVyxp31c7WibHLiyIF43paER00mxZOAIHhsdwhk=;
        b=B9M517QGKU9Xyy2/tqI19d54S91xUGtoJd3hAEu0vQID1tNJkeNtjgnK5egDgeRxEN
         IAtMUjPZE4bzTCNLQwjA+nfRUZrxq8OzH+ifw6fgLW7H1V7zmUC0N/ua1ktMNKZ9Sp0F
         pmQYgkVcId944ruC8MBkIAfNAt2LHbJjpUbzWG4ovnnhVO150RF14r3TU2AFjWd23JrK
         isE4kvldbYaruZ3TvBnpCLU26oBRSV+/lPjZ5/3MhO9bpbZdH8L3zyz6MZYTaTC83Q+Z
         QAnBe1wwXyyrB+E2cmqjFEuF89iYnS0/0dWBi8/b9OH1FV4ATtB0a4SVZBKMoRL2Jv5/
         nYOw==
X-Forwarded-Encrypted: i=1; AJvYcCVeKuYVq9uMuZHG8+yYV8o1Dcnz2sKXIuvpxr4MEaXqIFuv+rShDCykpQ8ZsiVBRfXJ//wVXHLhqZlPiBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypMbnKJ75HHkOz/AmwzM/u515DZ8tQjB+ms6DcA6/tfYbWF9So
	goPmT4/otgih3c45bgdcfdDGbcNPVTV+T/1Zbwad+VBrxno4wm6xwD5cEpA6YijvtzexBQ6YAAk
	1kg==
X-Google-Smtp-Source: AGHT+IH031wjBK6zBugJiyQwbgM1S3WkZumhuZG0/47H7WWzE24O4tbIqX0eqBdD0TzKWzHgCchY3qP4ics=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90a:9a94:b0:2e2:da81:40c1 with SMTP id
 98e67ed59e1d1-2e2f09f2280mr107a91.1.1728584720854; Thu, 10 Oct 2024 11:25:20
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:16 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-15-seanjc@google.com>
Subject: [PATCH v13 14/85] KVM: Return ERR_SIGPENDING from hva_to_pfn() if GUP
 returns -EGAIN
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
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"

Treat an -EAGAIN return from GUP the same as -EINTR and immediately report
to the caller that a signal is pending.  GUP only returns -EAGAIN if
the _initial_ mmap_read_lock_killable() fails, which in turn onnly fails
if a signal is pending

Note, rwsem_down_read_slowpath() actually returns -EINTR, so GUP is really
just making life harder than it needs to be.  And the call to
mmap_read_lock_killable() in the retry path returns its -errno verbatim,
i.e. GUP (and thus KVM) is already handling locking failure this way, but
only some of the time.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 17acc75990a5..ebba5d22db2d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2946,7 +2946,7 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool interruptible, bool *async,
 				 writable, &pfn);
 	if (npages == 1)
 		return pfn;
-	if (npages == -EINTR)
+	if (npages == -EINTR || npages == -EAGAIN)
 		return KVM_PFN_ERR_SIGPENDING;
 
 	mmap_read_lock(current->mm);
-- 
2.47.0.rc1.288.g06298d1525-goog


