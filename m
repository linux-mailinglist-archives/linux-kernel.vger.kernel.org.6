Return-Path: <linux-kernel+bounces-341177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0930987C19
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 02:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E64BB20B74
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ACFF9E4;
	Fri, 27 Sep 2024 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ho0FAqYC"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8803A6AAD
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727396201; cv=none; b=s82TWsq+Z3arOXH7KMiv8J+5BZXQv6ycruKs58Faws14eilvqh9FlLQ4K5hY2pOETM0Oh/W6QJAvbWGGtQnje7NFcY3lW9Cqr75Eo3T0ybNPHt9zoLNYcOg1TaDATVbbO6HNV6U8JUpJLzEJT3XJ2NRDM1HQpFO4nukIjc2eM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727396201; c=relaxed/simple;
	bh=KHhB1JvodiEZlYG0K/aIr41oOeymhmWOlg3SNBHxxp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OuCyFJriAetaIClyEvRePUyiyPh05wrASYuV/l1JoKbzY5jG590ILiiJRPmRNbMttTnNo0dkwvgGfHVdOpMmV9fmr5skRX7dyKdyCiCTHTQDrK+Rhw7S3TrcgBXHGOeQC6yT5r/AQ7g7Q3NNAKKB4XkCjG321ftInU5rF9elXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ho0FAqYC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2070e327014so13149065ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727396200; x=1728001000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qCS+Ka3w15waaZmhKt3WbYhaBaIYN1wdPlmBW/+h3qE=;
        b=ho0FAqYCRu5llEQ1wYBU1WkdA0anXl/Btv0JjNzpR2yaY04S37qBr0K5yGG0a6PrH5
         knUOLqTT3V9OiBV62eYlN6okYiEaJEqtYy3rskCSf2qg2zjxCNaOWfBMzh1+7LXdHWaY
         XM9nlGHjs8w5QgE17pwCLrWP5Qrxl5+sxgqLM/ujoHL4krTwyMp9rkhQVq1ex/Hja/H/
         MGYFk7R/PdkOO9O2DdGxUkmn2wdaSqpQjSWJ5CggsByiLDr9nGe1F3lALWZAMT8llGa9
         8a4hr9ypLktnDaojeTBIlBY8Dcr2e1Vcq3PzUOcLsdn6KkZngoeAWjvxQ+aKPmxnuNKU
         VLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727396200; x=1728001000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCS+Ka3w15waaZmhKt3WbYhaBaIYN1wdPlmBW/+h3qE=;
        b=T3U1WpV0i7zFhnTC/5klCngKzFF6kwOgeIqlcHAjVwF8M56HOW6qq/Jhp4pqZ3Isr4
         e6YL46lc5Tl1tY4ZAO6tBc7+kW6LklnsKQnSk5hNgeC4vLPhhsXLvy7wXu82yUVs4gC6
         kOadguXwcknjporyEKdf8MKmXHLs7cB0zFfIgcL1EXVlR9Xdu2L05gV+5Z7cT96kCfT2
         jh1S6+QinPT8qoexl00VDvUbu9cXKQrdAoZs4VVni37H4mIeHzAdw5dqFLq0B596cZLm
         0Kh4VVy/wOmlEhFTawGw2c7nVCmp7/J/qxt5JRgxNBp85u1Br6WeO7gx6GwAYBzQxOGf
         Bf+A==
X-Forwarded-Encrypted: i=1; AJvYcCVJw5ehYLKHj7CTjJ/mc55TPcFZmk6f/QekmK/JCNUG4S5gXMupvuw4dIzZzK5TNdYfRwbXT8jmGr96Xfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfMFZrH/Sw89S2Z5NSZfgInkfTEsD4c/iBWb7Ohn/v1AnVumI
	6ylxrJ1rAvLdGNKD+D4k9ovg6OvnG57ym6ep6KIJFQ4uExdzx5i6Di8/acxlPuJFlugLuzdG4br
	hZA==
X-Google-Smtp-Source: AGHT+IHGZHd87jRSKB1vMMfqB2NkUEzbiC7nAZzkcFWnI6OrmacXeP3BVJ5c97nGJzj2dRpAEXFGoCIYE78=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e891:b0:205:6e76:e1b1 with SMTP id
 d9443c01a7336-20b37b73820mr247965ad.4.1727396199576; Thu, 26 Sep 2024
 17:16:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 26 Sep 2024 17:16:32 -0700
In-Reply-To: <20240927001635.501418-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240927001635.501418-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240927001635.501418-2-seanjc@google.com>
Subject: [PATCH 1/4] Revert "KVM: selftests: Test memslot move in
 memslot_perf_test with quirk disabled"
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Revert memslot_perf_test's testcase for KVM_X86_QUIRK_SLOT_ZAP_ALL, as the
quirk is being removed, i.e. the KVM side of things is being reverted.

This reverts commit 61de4c34b51c5b9c7ef8229eb246346254638446.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/memslot_perf_test.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 893366982f77..579a64f97333 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -113,7 +113,6 @@ static_assert(ATOMIC_BOOL_LOCK_FREE == 2, "atomic bool is not lockless");
 static sem_t vcpu_ready;
 
 static bool map_unmap_verify;
-static bool disable_slot_zap_quirk;
 
 static bool verbose;
 #define pr_info_v(...)				\
@@ -579,9 +578,6 @@ static bool test_memslot_move_prepare(struct vm_data *data,
 	uint32_t guest_page_size = data->vm->page_size;
 	uint64_t movesrcgpa, movetestgpa;
 
-	if (disable_slot_zap_quirk)
-		vm_enable_cap(data->vm, KVM_CAP_DISABLE_QUIRKS2, KVM_X86_QUIRK_SLOT_ZAP_ALL);
-
 	movesrcgpa = vm_slot2gpa(data, data->nslots - 1);
 
 	if (isactive) {
@@ -900,7 +896,6 @@ static void help(char *name, struct test_args *targs)
 	pr_info(" -h: print this help screen.\n");
 	pr_info(" -v: enable verbose mode (not for benchmarking).\n");
 	pr_info(" -d: enable extra debug checks.\n");
-	pr_info(" -q: Disable memslot zap quirk during memslot move.\n");
 	pr_info(" -s: specify memslot count cap (-1 means no cap; currently: %i)\n",
 		targs->nslots);
 	pr_info(" -f: specify the first test to run (currently: %i; max %zu)\n",
@@ -959,7 +954,7 @@ static bool parse_args(int argc, char *argv[],
 	uint32_t max_mem_slots;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "hvdqs:f:e:l:r:")) != -1) {
+	while ((opt = getopt(argc, argv, "hvds:f:e:l:r:")) != -1) {
 		switch (opt) {
 		case 'h':
 		default:
@@ -971,11 +966,6 @@ static bool parse_args(int argc, char *argv[],
 		case 'd':
 			map_unmap_verify = true;
 			break;
-		case 'q':
-			disable_slot_zap_quirk = true;
-			TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
-				     KVM_X86_QUIRK_SLOT_ZAP_ALL);
-			break;
 		case 's':
 			targs->nslots = atoi_paranoid(optarg);
 			if (targs->nslots <= 1 && targs->nslots != -1) {
-- 
2.46.1.824.gd892dcdcdd-goog


