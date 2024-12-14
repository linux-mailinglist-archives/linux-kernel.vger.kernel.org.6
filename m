Return-Path: <linux-kernel+bounces-445809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFAA9F1BC5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413C2188E81A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B858C19B3E2;
	Sat, 14 Dec 2024 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKMbef6h"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8908F16415
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734138469; cv=none; b=G6VbgQ0Uz332DHvH0LGkULAWCiqiIUNDPgDeOKTPo6CMqmmMTuFOLlhvFOIQuabb0W6TalMu8hWOQq84tv4NX+vz0A6b3XDhfeG6auu9eW5BV5FyZTjc+f/zOKJCS0y4AtbGlPGzJwJAg6NCJ+epVP1hc0ICWakkK31AwV7eRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734138469; c=relaxed/simple;
	bh=Y7iSeB/iFN2r5nReVSRRpd3Yjr16tNr3Xsa+8UTAWN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JvLX8a0NVCH7b+haY58wJ5tMhCXZI3bqmYnPRF9DE4vXMcPCoF5faomstD83XOGh6ToIOn6o7/YkQcOHpRIGCs9gU4eDY+9afZaNpycLkBALVlYQQgCsy/n8GN4bzrUhu/OsR1aMBoz9WRCogSIRK0AQCGQK79wbnvwTuwRlzFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKMbef6h; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef79403c5eso3133922a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734138467; x=1734743267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eF/Qtxj8u+rXx6pztbYRnhJ4md/Ws0Wq0EpKN7FU8Sw=;
        b=DKMbef6hFSAU6h1IRlvxFnkqA2MbTVIWGXO3tirQ/m7MJKcYHjo2p0AethVTxbH+0/
         7JldOAMvLn4iSbp502kJMn5aBMNuAQ9RtbmLAMKOxS1+roKv1GJSYQkdqqE8f32lne7t
         N+q7rf8+3/U2BQaumuAJPLkdf7KIwb5fC3Km2EhQVJOgjIvfOas2lfyZSLkRZ901ThO8
         t4QZOq3j5yXG+ietxwXa3MjpLpijptw4t18tTb4ZWpGVsxPUFfk/jS5NemXM6S0O7wsi
         FrjlaESPqgKkgJRoOT+R/OBOLaDHKgfSzOpmbq04GKG8l3f1Gkq3kmOb/VPO98ABC0jA
         mGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734138467; x=1734743267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eF/Qtxj8u+rXx6pztbYRnhJ4md/Ws0Wq0EpKN7FU8Sw=;
        b=A0oMuPYm7CY2CMLp7srTwD4MLd+uLknIvcYE9T4j6vbddrETPlz2139QNKcNmM4V3T
         MuMF6SmKybbA6xbtWVB3gqz8UKwVXw5QVO/eUIlXlT/jLIigiy/R/44vnTpp6ApeieKC
         ZnZo89wYP0ofmMIa9GdQVHQoVj5x7+gItqPTgOuJd450WCm6z/7rJ2cCPZbmOopjXY93
         5INFNyTVs9hGz1N1nNlCEMoEE1Km4rDt/YF9ANuMU8ykeUB7fP+RH/WKFfJz2ifode1y
         G7jiuxTyfygJpU1zqFltzGQe08otUVSIWL2CslbMD0SfIXrcyGb8lfnyW8wBg6LNbzMU
         eFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC+sTv6uMU3Bu07Dpw6z0K9TH3m5tFl0DaZeyPxZBjGmKfKlyD6Pww2QP8eA77AxxL6HBEqhZnGTFxxVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4UxDSCdABV35lWpDDiL7IdjWrR5e6UOW8oxDxEZW2OWmUz9E
	tvO7WicgtUb7gMsslhdRmVHkQus/vw8Q8yFoP0SVql1DanT2mz+UqCpaXx7NTXZ5o9kNsLZgpJG
	Hhg==
X-Google-Smtp-Source: AGHT+IH0qFw1WgPjMXBzEGus8ENQhTcYTwf7/Lt7Vb5caWVGm2/gGGV3oi0MjPa5CrhahTjY2DcpyW9W95w=
X-Received: from pjbsc16.prod.google.com ([2002:a17:90b:5110:b0:2e9:5043:f55b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5345:b0:2ee:d96a:5831
 with SMTP id 98e67ed59e1d1-2f2900a6003mr7323795a91.30.1734138466757; Fri, 13
 Dec 2024 17:07:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Dec 2024 17:07:14 -0800
In-Reply-To: <20241214010721.2356923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241214010721.2356923-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241214010721.2356923-14-seanjc@google.com>
Subject: [PATCH 13/20] KVM: selftests: Print (previous) last_page on dirty
 page value mismatch
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Print out the last dirty pages from the current and previous iteration on
verification failures.  In many cases, bugs (especially test bugs) occur
on the edges, i.e. on or near the last pages, and being able to correlate
failures with the last pages can aid in debug.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index d7cf1840bd80..fe8cc7f77e22 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -566,8 +566,10 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 				}
 			}
 
-			TEST_FAIL("Dirty page %lu value (%lu) != iteration (%lu)",
-				  page, val, iteration);
+			TEST_FAIL("Dirty page %lu value (%lu) != iteration (%lu) "
+				  "(last = %lu, prev_last = %lu)",
+				  page, val, iteration, dirty_ring_last_page,
+				  dirty_ring_prev_iteration_last_page);
 		} else {
 			nr_clean_pages++;
 			/*
@@ -590,9 +592,10 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 			 *     value "iteration-1".
 			 */
 			TEST_ASSERT(val <= iteration,
-				    "Clear page %"PRIu64" value %"PRIu64
-				    " incorrect (iteration=%"PRIu64")",
-				    page, val, iteration);
+				    "Clear page %lu value (%lu) > iteration (%lu) "
+				    "(last = %lu, prev_last = %lu)",
+				    page, val, iteration, dirty_ring_last_page,
+				    dirty_ring_prev_iteration_last_page);
 			if (val == iteration) {
 				/*
 				 * This page is _just_ modified; it
-- 
2.47.1.613.gc27f4b7a9f-goog


