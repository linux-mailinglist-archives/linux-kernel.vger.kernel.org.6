Return-Path: <linux-kernel+bounces-445808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2E39F1BC3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AA2188E314
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80271946BB;
	Sat, 14 Dec 2024 01:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huFZsV8i"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7B014286
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734138467; cv=none; b=FyZ1wnE4fUEnHbCwSnJNvp8fVIHfdO+iH7x0VyKxyZKf31cvZTWpckd/BFlaWyO70lOa9hnnuBKi5t3cytZIRXAxtNdF6Kw0L3JPviodATPpptYa6KtRPGe9yXn9vIcO2NOw5Tjkd4x04Chf7EuTPwSrc/Zn1/6zZyO6kLSjHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734138467; c=relaxed/simple;
	bh=QVWmEN93U4wXoW46HSHclbwWmnJqdA1R3pFC8wdRuNY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oH7x0BCSoij4ImKsnQkv+KdU6BD/T4j3rkfn+6tXNiA5i4ouVAw8z9OkijNtC4AaLUH/9UwREHCKMktsZ+RvB7n/YlKLdB5QRprfDvvLrDImoX8RFyyR2SSNptBbOIJOeewyTHkJxunTkpoTU8cy77NuupqjB24z+gXf2c8mhno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huFZsV8i; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725e59e41d2so2182951b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734138465; x=1734743265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bHCBDGsUVxz6SdxgZL4telXbGroEPmY7oNy/cAKGEh8=;
        b=huFZsV8ix67y/CtSdBH9UwyPXgzRjw9UA3PvnFvoXjHrzhuc8dFo4pgJIFpJ+jb1O1
         YwdjYTuaYk2b5Zvmg3gQNlTrSjnyfslGRMbNDjesouGEKw0jKDpjfYAmGaKxpux9TTUa
         f/JrBnYADH/mtRGMsBdVcV51gvk9+2ruPl9IoMHMZkwZDq+iy5WKPX4SzPg7mCN59F8V
         j1Xxpafi3uHfdADD35rhHpcTg053zf8PTZEwefBH8FnJkeceXlQ+hn0FsQ3eMaZTDCil
         /j/uA6shixfj/Ve6lGqMYuJVE/fO0xNOFlgoin3xHHshqJlK4DV2I+gKcSvOZ21v7FBs
         iprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734138465; x=1734743265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHCBDGsUVxz6SdxgZL4telXbGroEPmY7oNy/cAKGEh8=;
        b=s3MMYY83M7PTTZdxgJzOFlsEYf+ai7FQ+urnh44iEuts0NWuzTH6OHJVeOjW5SEaJs
         FDcV8lddvEflFsbI+UibY+IcmPigkMAe5VAiYjaQv9LwwI8LyVOU07+Lb1tiLJ/J9Aoo
         ZOC2dgq8TsW17cwi559L9DUBiEe6krA01MMhtMECQDFPtQww7/PDUDVot3oPuookIW8W
         /y0fsHz6h6UpaDuw0t4WgAaYb2llBhM0esczI3ExDBWrXL7TT0FQnzrVh9c8HpSssSxP
         GArVt4q4RmTKL0VJ/Rzd8OVBDCicUAamUbCy7paT2VDY7dqGA9nJEffmt5qimFcCQxdp
         yjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVDpaP11CD8NGhx6NWqm1mL4f4DeBuvwOs7MHw059QDCJGZANgjfM+FIEzbOiQwC21VxJZ+OI3v2S9Opo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwwckzGAj+v2Jx2bgLjCFXC0wNjcF3MOvmSnmSOpSQpEg7XEAm
	yzBT7rVUEUonGIQzOz14NISlyYj8ofSWbCVpjzE2E9pMgpwUspNKpeY3AS02Czo4cdtncKhhACE
	iiw==
X-Google-Smtp-Source: AGHT+IHI7aNGyUVYAZRaIfM3tqmWl5rQShpzYJGmkFTVL8PahcKsfjqTBmmhSQLHOzhneJg36ly7uAtGOuQ=
X-Received: from pfvf8.prod.google.com ([2002:a05:6a00:1ac8:b0:725:d24b:1b95])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1483:b0:728:e906:e45a
 with SMTP id d2e1a72fcca58-7290c269159mr7557525b3a.24.1734138465060; Fri, 13
 Dec 2024 17:07:45 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Dec 2024 17:07:13 -0800
In-Reply-To: <20241214010721.2356923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241214010721.2356923-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241214010721.2356923-13-seanjc@google.com>
Subject: [PATCH 12/20] KVM: selftests: Use continue to handle all "pass"
 scenarios in dirty_log_test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

When verifying pages in dirty_log_test, immediately continue on all "pass"
scenarios to make the logic consistent in how it handles pass vs. fail.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 8544e8425f9c..d7cf1840bd80 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -510,8 +510,6 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 		}
 
 		if (__test_and_clear_bit_le(page, bmap)) {
-			bool matched;
-
 			nr_dirty_pages++;
 
 			/*
@@ -519,9 +517,10 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 			 * the corresponding page should be either the
 			 * previous iteration number or the current one.
 			 */
-			matched = (val == iteration || val == iteration - 1);
+			if (val == iteration || val == iteration - 1)
+				continue;
 
-			if (host_log_mode == LOG_MODE_DIRTY_RING && !matched) {
+			if (host_log_mode == LOG_MODE_DIRTY_RING) {
 				if (val == iteration - 2 && min_iter <= iteration - 2) {
 					/*
 					 * Short answer: this case is special
@@ -567,10 +566,8 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 				}
 			}
 
-			TEST_ASSERT(matched,
-				    "Set page %"PRIu64" value %"PRIu64
-				    " incorrect (iteration=%"PRIu64")",
-				    page, val, iteration);
+			TEST_FAIL("Dirty page %lu value (%lu) != iteration (%lu)",
+				  page, val, iteration);
 		} else {
 			nr_clean_pages++;
 			/*
-- 
2.47.1.613.gc27f4b7a9f-goog


