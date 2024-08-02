Return-Path: <linux-kernel+bounces-273068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76CC94643B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33943B213C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C036A039;
	Fri,  2 Aug 2024 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGKErI4P"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FA956446
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722629338; cv=none; b=TtqCjbEQ/RjGQqv89cssBM5T0yhU5m6gRb8h4+9OdCGEdsgRDhhxvqibrNw0/yqg5Hwa4Yt3gkZ4N1eArGzNxHU/6tWNAiwMvTIPz4AxMrJ3Kaj2dBDbOcWaZGhqNbIUXYruH4nycAcoYBv1Nv1WsqTTDcJPDSu9MGko3lkU2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722629338; c=relaxed/simple;
	bh=Cywag1Xm4zEbwJ7Y+yW686Ysaezmz/REuGc0BkN1Bp0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=twt9jOg1C12Ux/G5oLLXfN/ZKYgKL1Ptf0Te6wiqT2b1UnHLdztWzw+Pcu9NPFx6VPmxNGKeJPeSX71s1o5sAVUhA+xOAXhAwK7d8JyW31ggFcLVw+JJPp/Vfros4bkOqOJcDxKVgZbKhKRSpzqLFf3HPUjIPU+nzXbUtSt5Z3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGKErI4P; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66b3b4415c7so182131567b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722629335; x=1723234135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xn+PTZfbOoeM3uzTrVDj1sQQ44aVrywqdE7G4cLUAMk=;
        b=cGKErI4PZGz2dfrdiQjrYh85j9pQPNqyFNBQ34QSUjowYIFWJ9ljt5npM1V34E5chY
         n963iqJmctuppEupX7J4ZYMgyvsFJsxFnAFUg9KvGBUnkIGunNJ6BLUcYdCOy5QpQOFn
         VtuHWr7SYGQxLtVInTw23RYk0WdlYMGTU5T9/fFiSfWhnQhW4sApt2qTVHFpoGPyL1my
         CJAQwohGmSs4MkMSIWkc3BTx4GwQ2zbAL/5oC2cCQKMktglMUV7v51J2QAXoTTaK/S8e
         g4MrN9Jdh1wcEfqpjGA9n5m1wE46m3LymYSr6gJdxQbkpMp1DozOQ+movWj5zbzC3FYR
         rzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722629335; x=1723234135;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xn+PTZfbOoeM3uzTrVDj1sQQ44aVrywqdE7G4cLUAMk=;
        b=HPWRGp8TqczbnKhes+D0prOF/bF3WVCAV7EDFc75tJUVhZ+I4mN/JRZZy54GpHyL9g
         3eQdcKtAD2m4i4fbuMiNoyCdXOnTJGJaYj/QFhdUjzwoZGF6+tdEgCSqZCeNEhIdx7Bw
         2YYZsQHpMKWg1yByIQsD29FYfXMjmblhYZOZptpSHLhGxY4mjElmXiJ4RWrt+zYMCFNZ
         CDAIT/Gl/48UtlNQ0x6PPnXlPvs9dKlqxrsTtTnu40i5eUGedZGnxUvzewOBfsMlDkkm
         XaCzKT+p1va6JEISdOMunCwM2YHFUb4EfgCoBr6o1lkRhNmm6BW3QO4QNhAnNEn+8MlF
         Z1mA==
X-Forwarded-Encrypted: i=1; AJvYcCUleyT5MWIcVzd88P+ZpBLT/6GH5Ol90VJL7vaVUrtNmV1ef+IqtvxeQfZXP5ChcwK06FIW+69g0Qk9I2eAjUr5YNGb9xl+11CMHXTE
X-Gm-Message-State: AOJu0YwkjGsSaanWwZDwTaO9dYUG/4Ch+iHi/ZL5jLbXPW4AB5+sl6iN
	9XtPoj+5xgqUm5kHdjDgQUskEyy8g6VGjxZ2FC80NOyMH0ofAT/7J/IgoPMIfIYAAlCB+m6bdS/
	Kgg==
X-Google-Smtp-Source: AGHT+IGMYoWQegn8k2fjIVDFS+exelJ37OpbAan3ymKOza63KM7bJzE44b4pboHgwFDVyLsxNlhCPbJNByc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1892:b0:e0b:ab63:b9c7 with SMTP id
 3f1490d57ef6-e0bde401516mr8177276.7.1722629335671; Fri, 02 Aug 2024 13:08:55
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 13:08:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802200853.336512-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Remove unused kvm_memcmp_hva_gva()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove sefltests' kvm_memcmp_hva_gva(), which has literally never had a
single user since it was introduced by commit 783e9e51266eb ("kvm:
selftests: add API testing infrastructure").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  2 -
 tools/testing/selftests/kvm/lib/kvm_util.c    | 70 -------------------
 2 files changed, 72 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 63c2aaae51f3..acd2db809e83 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -428,8 +428,6 @@ const char *vm_guest_mode_string(uint32_t i);
 void kvm_vm_free(struct kvm_vm *vmp);
 void kvm_vm_restart(struct kvm_vm *vmp);
 void kvm_vm_release(struct kvm_vm *vmp);
-int kvm_memcmp_hva_gva(void *hva, struct kvm_vm *vm, const vm_vaddr_t gva,
-		       size_t len);
 void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename);
 int kvm_memfd_alloc(size_t size, bool hugepages);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 56b170b725b3..f7b7185dff10 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -794,76 +794,6 @@ int kvm_memfd_alloc(size_t size, bool hugepages)
 	return fd;
 }
 
-/*
- * Memory Compare, host virtual to guest virtual
- *
- * Input Args:
- *   hva - Starting host virtual address
- *   vm - Virtual Machine
- *   gva - Starting guest virtual address
- *   len - number of bytes to compare
- *
- * Output Args: None
- *
- * Input/Output Args: None
- *
- * Return:
- *   Returns 0 if the bytes starting at hva for a length of len
- *   are equal the guest virtual bytes starting at gva.  Returns
- *   a value < 0, if bytes at hva are less than those at gva.
- *   Otherwise a value > 0 is returned.
- *
- * Compares the bytes starting at the host virtual address hva, for
- * a length of len, to the guest bytes starting at the guest virtual
- * address given by gva.
- */
-int kvm_memcmp_hva_gva(void *hva, struct kvm_vm *vm, vm_vaddr_t gva, size_t len)
-{
-	size_t amt;
-
-	/*
-	 * Compare a batch of bytes until either a match is found
-	 * or all the bytes have been compared.
-	 */
-	for (uintptr_t offset = 0; offset < len; offset += amt) {
-		uintptr_t ptr1 = (uintptr_t)hva + offset;
-
-		/*
-		 * Determine host address for guest virtual address
-		 * at offset.
-		 */
-		uintptr_t ptr2 = (uintptr_t)addr_gva2hva(vm, gva + offset);
-
-		/*
-		 * Determine amount to compare on this pass.
-		 * Don't allow the comparsion to cross a page boundary.
-		 */
-		amt = len - offset;
-		if ((ptr1 >> vm->page_shift) != ((ptr1 + amt) >> vm->page_shift))
-			amt = vm->page_size - (ptr1 % vm->page_size);
-		if ((ptr2 >> vm->page_shift) != ((ptr2 + amt) >> vm->page_shift))
-			amt = vm->page_size - (ptr2 % vm->page_size);
-
-		assert((ptr1 >> vm->page_shift) == ((ptr1 + amt - 1) >> vm->page_shift));
-		assert((ptr2 >> vm->page_shift) == ((ptr2 + amt - 1) >> vm->page_shift));
-
-		/*
-		 * Perform the comparison.  If there is a difference
-		 * return that result to the caller, otherwise need
-		 * to continue on looking for a mismatch.
-		 */
-		int ret = memcmp((void *)ptr1, (void *)ptr2, amt);
-		if (ret != 0)
-			return ret;
-	}
-
-	/*
-	 * No mismatch found.  Let the caller know the two memory
-	 * areas are equal.
-	 */
-	return 0;
-}
-
 static void vm_userspace_mem_region_gpa_insert(struct rb_root *gpa_tree,
 					       struct userspace_mem_region *region)
 {

base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.46.0.rc2.264.g509ed76dc8-goog


