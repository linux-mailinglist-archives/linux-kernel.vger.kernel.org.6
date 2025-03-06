Return-Path: <linux-kernel+bounces-548721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD0DA5489C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22663A9B03
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A711624C7;
	Thu,  6 Mar 2025 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYC58hO6"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C42E339F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258851; cv=none; b=cP1lDs03kMqZMNvqZZqze/JUh+dTog+m7pOH5sVgTWrCU8gAxZv13qwDf0OOkhoH6G616qWEOcsYvcK0dQgvwEo15LXV3HIttPJ5AcfqnWySyomMBhU5SQE0AukZ6voAEjwWXZAjKlD5xm+fjMnwl6zIMPdvQ9Atn8uhQNb4Pag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258851; c=relaxed/simple;
	bh=HjLJ7C2AIduywljQpybYoX8/PUosMtVkdvA1RpOLC6s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X6nKPYCnUM93XBB0iltucwNKMBP0ZcyRav8NgsVrFLm5DiZJacVpd7n+RaiBD2I2JVZta3VxKBJn12O2BN1xY77C7zJgb9LkwRIT1+Vey2ysnDQaK0AOaYohHZ0UBvvkA5DFzcyfIXNfEg5nq6uJXjmFF8/cD30d1i1EvJoBbDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYC58hO6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4393e89e910so2289545e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741258847; x=1741863647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3EIDfh3bzz6FZ09T3hzG7XWiQpkIRvJOzVpoxagQuo=;
        b=KYC58hO6TrSxtyhGi90uTchBpS5ZPlt5N0SairQKaMljkOlCxarrTCqug0jskx1eIH
         2PETwXtphbsE7JfCaVHZHFfF/hFFLo9w+jTpocHLcW/X2X6Cc8zqzseESA+ihUAqN1HI
         yx6tTax/VE7HarqBZGIIyjTxWqg+i58EWYvDuK2v3EB9eQZJp0BYzIh5EppReInOKGQX
         gte9+E6i267cKSRzYwBzP8POJeBd2mrPTgd1nzD05yQFZEIPp2mbDChs27ylSiVJOE4p
         Za2KBwe7f6lb71MRUo7S0ClKnUUskYGJmNAscA+TwYjSrh/RF5dIzpl8ve5plR/M4641
         UNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258847; x=1741863647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3EIDfh3bzz6FZ09T3hzG7XWiQpkIRvJOzVpoxagQuo=;
        b=EWRP00/2OxnEHc+HYKJU5E+eF6824UQeBeXFVDf+5Ed+HlnEPyoMMet0w4qW+OL571
         MB9Q1Hm9aMA8oW6OL20ZFGBV6nOvarSvzeXcsxIZjderijR57raJrsq5kA7YMuKA4Fg5
         Ew6041kGhzJccNu3pBNAY0EqwkE9KriSBv7jgbuFt3kyXzlSZrJw126NR8uifeORnl60
         rW6nzLuBSlCHgf04r6cJShKEWP5i7uHo0/EIfaspaSIMnFO/VXjOU3y1cXxedzXzYnb5
         78sl8+w1+t6j03mNsgO6mweRGHJq9LFX3dnaibpeOj+7vhQfV2ziBqldp9rgBQvfOKMs
         VeWw==
X-Forwarded-Encrypted: i=1; AJvYcCWkxlguOed0A/xQWMtDDRPD/eDn+vHDj00YGLbbW0IM1sIuk+mW3CodD1IzBwpY5yuRQ7xvldT8aMOmQNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCRJseR/Ky0XQsgYl4rDB6BFq9iymIoVBage279eHyIO00w6Rc
	wgssSQ/Gl4zb93zdKf5frmKjd6TshWuUPt5UCO1gmqM5gT1GM6duMOBYcIHQMy8aZRY1jLwasiN
	TFggCaGSrYHZ0wrF4TQ==
X-Google-Smtp-Source: AGHT+IHc9gvpZKIAvFGYxWaWiTqhy0gbG8Wikxg2XkAF/4yfzSNV6Mp0Ztsi5081XwxCLqL618nGLsdLrgFavXUx
X-Received: from wmgg12.prod.google.com ([2002:a05:600d:c:b0:43b:d4fc:1dee])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b95:b0:43b:cfbb:3806 with SMTP id 5b1f17b1804b1-43bd29d2d84mr55969355e9.14.1741258847657;
 Thu, 06 Mar 2025 03:00:47 -0800 (PST)
Date: Thu,  6 Mar 2025 11:00:30 +0000
In-Reply-To: <20250306110038.3733649-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250306110038.3733649-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306110038.3733649-2-vdonnefort@google.com>
Subject: [PATCH v2 1/9] KVM: arm64: Handle huge mappings for np-guest CMOs
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

clean_dcache_guest_page() and invalidate_icache_guest_page() accept a
size as an argument. But they also rely on fixmap, which can only map a
single PAGE_SIZE page.

With the upcoming stage-2 huge mappings for pKVM np-guests, those
callbacks will get size > PAGE_SIZE. Loop the CMOs on PAGE_SIZE basis
until the whole range is done.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 19c3c631708c..63968c7740c3 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -219,14 +219,30 @@ static void guest_s2_put_page(void *addr)
 
 static void clean_dcache_guest_page(void *va, size_t size)
 {
-	__clean_dcache_guest_page(hyp_fixmap_map(__hyp_pa(va)), size);
-	hyp_fixmap_unmap();
+	if (WARN_ON(!PAGE_ALIGNED(size)))
+		return;
+
+	while (size) {
+		__clean_dcache_guest_page(hyp_fixmap_map(__hyp_pa(va)),
+					  PAGE_SIZE);
+		hyp_fixmap_unmap();
+		va += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
 }
 
 static void invalidate_icache_guest_page(void *va, size_t size)
 {
-	__invalidate_icache_guest_page(hyp_fixmap_map(__hyp_pa(va)), size);
-	hyp_fixmap_unmap();
+	if (WARN_ON(!PAGE_ALIGNED(size)))
+		return;
+
+	while (size) {
+		__invalidate_icache_guest_page(hyp_fixmap_map(__hyp_pa(va)),
+					       PAGE_SIZE);
+		hyp_fixmap_unmap();
+		va += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
 }
 
 int kvm_guest_prepare_stage2(struct pkvm_hyp_vm *vm, void *pgd)
-- 
2.48.1.711.g2feabab25a-goog


