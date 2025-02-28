Return-Path: <linux-kernel+bounces-538323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336E8A4972A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF031883B06
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AC025E808;
	Fri, 28 Feb 2025 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fh4rKZob"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190E25DD18
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738349; cv=none; b=MbvDmJBxtB6vhpB8sBa7ddGfnCfxCfyuAG8dNYGle1jA+83Ynny4Rt99NN4zBug3BIqwtRxepqG1UsaUBNz2+oP+85kdIXZ3x3dsbGrFEesuxAQWDpSW2OAWyvb/RDf7Cv1hwB9XjB9RMD4RXRJu9mf/6frcAUTe87uPuN3GpzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738349; c=relaxed/simple;
	bh=XyLO+57fDofN6GJHV7mkm+GB+xkNeXPKaNuh0zqrY5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JSDaBfSIGs8XxOOO7287VrHZUv8ml54VJjapBxwyXWOa2UriW383bsIawh25gR7q4aCiUB+zfANIVnhkqIV76w9itCM3+I5Ouuh8TL8ZP02VDFt6EqpEoExQdsAkuQ3tQc8bQktFGRA0EE4D/C7BZKMeTc/dyMMK0OD++6wDI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fh4rKZob; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso14332005e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740738346; x=1741343146; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZhAYztASFyJGMSgZE5i6lkqu3vzWqDwef4eaMAfdZ0=;
        b=fh4rKZobaumA3bi5tt0gh/cBtuQX4XxNpohCCSVQZuuuk40ICFn3nkWQiX+Ct1ugj8
         i1as11yXcb66pk8x11DXuuj+ZtSa6ddml6OJUCn7fLizU8OvnYYvRQWxNfW+QHIV2slL
         J1zGjSN5KGffmebOC8CAzzJq9zO0d1Iq53vWarYrdjBu2h4pvRAjM/f41KzJSQ8uOPnA
         IV+ugp0R0/i2iGAkw2hzYm66bT4wVC0dux4KGbTsM9p4Cv0nQh5O/MSXxxUnoVdTzjIb
         FYsGVZYx1OJkG2y9KjgBfN2RhD+5MAcDR+xqrAoEVb/SL3HigDqBCE4kOz/OZI64WO2e
         IC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738346; x=1741343146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZhAYztASFyJGMSgZE5i6lkqu3vzWqDwef4eaMAfdZ0=;
        b=HNf6jrMiVZmu8st4x/Q1N7OBre5yuXSlalhYfLm7tW2jbkNO/aUmehh5OKPSrUcMoX
         5/PuYosn/R63HgdOfpgtS/iDRnb9xFQt7Ztbyk9WoaXmIUID2iCqoq48qvPisCABL/CI
         jCykIDU7eKRygLF6uNArsZEQpZO8p7U7TcgM7I1YrO5UDJItfmBYKnqCg+zK1KyvBam/
         uHZ1mKYpggg80eKYkj6L0GNeaHPGcXb5K1v/VXN+44KR0gXSnSa1uJcV0WUTg0kgJoWp
         OqQMVTUnNM92cU+tIMUW/SfMxBgq0CP0aEMgj3THkZtYJBvGl1QiprdkYOzqfcH+UmUS
         2PCA==
X-Forwarded-Encrypted: i=1; AJvYcCXKnXxb4+Y6lN+RSc28to666RLJeNtSu4cua4aQwpI2kczJZWjoTtYG/cSunitsVPfp86C+LlM+Xapr9PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzubA0sirVShYjX76WN5K+1YJqP7PE2LZmSGMEKpiEuZI97SYIM
	3+yHOF+fxxaUUPSH+8vqCO4MvqBQY0uhGwclvNE7xNUwTuO/YuQXRerrxPsX0sbmzrJmXtfpBMR
	OWS/wOQcw8AkPgUxtRg==
X-Google-Smtp-Source: AGHT+IErysWGWTMM3bCvvoDqVF2QmB3ahdAOa99vtob8aheucDELjb3c2wdk5I/bEmp96LHcj4ZpHr7SpAP9x51t
X-Received: from wmbfm6.prod.google.com ([2002:a05:600c:c06:b0:439:9601:298d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1986:b0:439:98b0:f8db with SMTP id 5b1f17b1804b1-43ba66f9800mr25488185e9.16.1740738346325;
 Fri, 28 Feb 2025 02:25:46 -0800 (PST)
Date: Fri, 28 Feb 2025 10:25:17 +0000
In-Reply-To: <20250228102530.1229089-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228102530.1229089-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228102530.1229089-2-vdonnefort@google.com>
Subject: [PATCH 1/9] KVM: arm64: Handle huge mappings for np-guest CMOs
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
index 19c3c631708c..a796e257c41f 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -219,14 +219,24 @@ static void guest_s2_put_page(void *addr)
 
 static void clean_dcache_guest_page(void *va, size_t size)
 {
-	__clean_dcache_guest_page(hyp_fixmap_map(__hyp_pa(va)), size);
-	hyp_fixmap_unmap();
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


