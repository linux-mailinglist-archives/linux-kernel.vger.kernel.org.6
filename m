Return-Path: <linux-kernel+bounces-445802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB339F1BB7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC4D1633DE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8151F16F27E;
	Sat, 14 Dec 2024 01:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2SqFCBt"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4E584A22
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734138456; cv=none; b=r/phwRRGKNqpzYwh8JIqVcGjhFltZIp0+qcf70uSP17mcrdmt7px+6Vr7d4EbQ8Do2wlRoV8LbIdE3KBEK2M0ANGZcqiA4uYw+CvQo+l4rkQHUZkJqTAnbZhcG3Tdsv0bi+WqPMt09xyy1ZeN1a28OiUW87uNblCD7v+gWWbS7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734138456; c=relaxed/simple;
	bh=ChtkTwOdtM2CUHYRr5Q44jb7j5O7SxNDxq57Jgyawzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n840d4vseCxtH3r/SIWpjeObCNQaNio/l0Hii4CyisCwdbz5hTPZVINrpXpMQr7we//aP4PbzrS8VSL/G9+MeWS1QD6PUqUdgWBFR2+8GseG3i6Ve2bE9QAp+9Bwd/BWAoFfGznbD+P5jxoajzgCr4VntuFoBPf26cEpF622sRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2SqFCBt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725cf06e7bcso1956608b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734138455; x=1734743255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=S4Qc03cR1N5CABN65ZcLjYJSL9LWVrIe/DGU28OwxCc=;
        b=V2SqFCBtzIxBdTqHO8ImQFRE5+NsddNwO2H2wfS1CjEGjwL01pILZi7MRwO2o1c3Bl
         Ydr0m2GKyoaRNe6IHwGKBFG52FTkB+ZEgSb41jv4NCgoStPZ3tFe/noMiM4Dr8YLWZyH
         /h5wvlMe/MIDncF7BNdsuIvsX3Gu699Ow3OCd5Aj/UeFRdgrNWQMjVXBKUmwFEMj2mKG
         OmpyCq92X3ZMYDMrYkryH0M4crk6pI7uqkGOf7NpplfONKoqBfbYmeIH/yGc8I8CumOL
         Jv1OYGHhjh2M9EQYohESuQ+Sgcj6iHJm1ynQbsXINd8cpE9l6owi+2w6HNB3B3SewsCg
         fzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734138455; x=1734743255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4Qc03cR1N5CABN65ZcLjYJSL9LWVrIe/DGU28OwxCc=;
        b=ly2G/a/e7bHuk47vnB0EYYINgXmzdH3ujLQWf58r8g9hW+9mAl2pSOAM48ug3m1J27
         4yJDm9uICU6oyvHCSBUNf3mGJz/DRXPggnFxPMVDEXV9BfPGuKh3E4UNVFgid76t6kTG
         V0mxAXi/SsG6eRemZ39BpB3TdUG3hS1z2reak1eHNeNDNIsrM+2T4/HG7C5mfmRXP8qa
         q9VRgPoEbR1i+TzfP4xIPIyyyIIIzP8tQLMvoux2EkKO9FTRqZ52OBOIsa75H7R/AVVm
         d3AkqPycRgtttQYMwRdpitVlIHkpVH7UgFXF5tBOEr3s7uAC6yjTYClV+Okrd43AyzDp
         t9/g==
X-Forwarded-Encrypted: i=1; AJvYcCVJVidP5mdqhRew/r37cE5ihbdM7WCELAzvo1JsBDJol6h80cBOmlmJfL2f67O+MVo4R0/Nhwz7NgGYhW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNO4vf6yRGqvnVtFwtO+2xxjfZXCTJRQs9V2z8cyrzPVMm0Dgz
	X6vU5Xc8dlA99Cu0HCwDssgzoQeZPU9bVYztxKZDKqqAo4+yYdO+C1gnqpmk9WnbQ2bmC6b095O
	YCw==
X-Google-Smtp-Source: AGHT+IG76QYly7Ply8m0CQfOF1OiirHYULNiCeYsTc6x5fGj00WXQFhcZFDKzqpfuelhdSo8iO789Lb6YjM=
X-Received: from pffk21.prod.google.com ([2002:aa7:88d5:0:b0:725:f376:f548])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:430f:b0:724:f8d4:2b6e
 with SMTP id d2e1a72fcca58-7290c0fcdadmr6078557b3a.4.1734138454729; Fri, 13
 Dec 2024 17:07:34 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Dec 2024 17:07:07 -0800
In-Reply-To: <20241214010721.2356923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241214010721.2356923-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241214010721.2356923-7-seanjc@google.com>
Subject: [PATCH 06/20] KVM: selftests: Read per-page value into local var when
 verifying dirty_log_test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Cache the page's value during verification in a local variable, re-reading
from the pointer is ugly and error prone, e.g. allows for bugs like
checking the pointer itself instead of the value.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 08cbecd1a135..5a04a7bd73e0 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -520,11 +520,10 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 {
 	uint64_t page, nr_dirty_pages = 0, nr_clean_pages = 0;
 	uint64_t step = vm_num_host_pages(mode, 1);
-	uint64_t *value_ptr;
 	uint64_t min_iter = 0;
 
 	for (page = 0; page < host_num_pages; page += step) {
-		value_ptr = host_test_mem + page * host_page_size;
+		uint64_t val = *(uint64_t *)(host_test_mem + page * host_page_size);
 
 		/* If this is a special page that we were tracking... */
 		if (__test_and_clear_bit_le(page, host_bmap_track)) {
@@ -545,11 +544,10 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 			 * the corresponding page should be either the
 			 * previous iteration number or the current one.
 			 */
-			matched = (*value_ptr == iteration ||
-				   *value_ptr == iteration - 1);
+			matched = (val == iteration || val == iteration - 1);
 
 			if (host_log_mode == LOG_MODE_DIRTY_RING && !matched) {
-				if (*value_ptr == iteration - 2 && min_iter <= iteration - 2) {
+				if (val == iteration - 2 && min_iter <= iteration - 2) {
 					/*
 					 * Short answer: this case is special
 					 * only for dirty ring test where the
@@ -597,7 +595,7 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 			TEST_ASSERT(matched,
 				    "Set page %"PRIu64" value %"PRIu64
 				    " incorrect (iteration=%"PRIu64")",
-				    page, *value_ptr, iteration);
+				    page, val, iteration);
 		} else {
 			nr_clean_pages++;
 			/*
@@ -619,11 +617,11 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 			 *     we'll see that page P is cleared, with
 			 *     value "iteration-1".
 			 */
-			TEST_ASSERT(*value_ptr <= iteration,
+			TEST_ASSERT(val <= iteration,
 				    "Clear page %"PRIu64" value %"PRIu64
 				    " incorrect (iteration=%"PRIu64")",
-				    page, *value_ptr, iteration);
-			if (*value_ptr == iteration) {
+				    page, val, iteration);
+			if (val == iteration) {
 				/*
 				 * This page is _just_ modified; it
 				 * should report its dirtyness in the
-- 
2.47.1.613.gc27f4b7a9f-goog


