Return-Path: <linux-kernel+bounces-445813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515379F1BCD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDB4188EC0D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AB81B3949;
	Sat, 14 Dec 2024 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQePBnFw"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD51AE863
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734138475; cv=none; b=J/oAnMI/aioGSA+16Nypav8RMQvbIup6PmjCuHSTjqXlH6Wn4gyhmABO2qRfpIHiGh383Z1316Sa4WorSWS40wx01wBzlfa8oI8UuCOWvpOYoBwQ5liru8NDRlwUv+OIVG+6clPvoa0ZnZmME6Ef4RMg4VwqKFoOgDbCO0Z0l3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734138475; c=relaxed/simple;
	bh=15fjBvur3l72YTctDs8wzcqD8BFstsOioZDobvlDBPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nbstBCzsrOkj+KqTSa8XO1fNA26rR8xkNGOEB7S9FGAGIIGvakuVe0t5Fg7c8wen2uFbKfFJyPATcX1avbcoQDZk8Py3jiUvIYLZsfwClQaRklMntDwsWNyXX4HaCBNA9fAMjUSWWY1NWRlrtBNJy3lwQJXaz4NomfEdWj6Pu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQePBnFw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725dd39ebe7so1869806b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734138473; x=1734743273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=l6O5Kjy9lNdBNSlyw7J2d7cJV0mm9IEhLLTToQ8CHPk=;
        b=dQePBnFwXpMIfDmew92avrGAWDye97SyhD7Zl8s2hcHE4KThG/c53G9hhnyaEEmcOY
         qFAh6LjuVmc4dPGF+Q3u51iLkLrc1mAaNiSzQ/S8bOKFo9UWtbHFiOtk96PxkfN3Rrog
         hdGf5fnfz+p3qVr+5651Z0iuEOVYOtZnn8nAO47U4xS7xrzf5WK6buvHPWZcPzqMTyTX
         R+8rgvB5u4wCiBLmL2XPlPoxsn3lgG/f3qS0psurhtaPwtl6w4+xu2yHH4kItYtSdcSm
         P7+B6PE2EYu5fQ1bH2IUpdLxrCSOCFIH3LUrfc0dRDzzdCvD5ORPuIh+mN82lDAAQPqE
         bNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734138473; x=1734743273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6O5Kjy9lNdBNSlyw7J2d7cJV0mm9IEhLLTToQ8CHPk=;
        b=dBaTmMOldeIScUvtF1Vng1tftF5J9rna1uA30BkzYJE5HAEXbj0LECfs3CNBkThzDy
         bILvcb8XKWdX9aM5X0I4DlpHFaoQpgWk2P8D9djMDcx9Skb5tSWGZQvF4GWlOxKst/eN
         ygfI95Yfjt/r3UgYzowLZ8mu4pvtMrGQo88M6X3sxwWEtGwKX12eFPyXx/nP5SPIIHKN
         cf3jIRxuR1Qqbh8g+umR4/AF5vMc3kGGleZQvYipY1tyKHDIPqbcsj9QSG6KMkfPyoxo
         vWj1eopS94o5zYvUscBw52BLJs9RsQtw3ZbvlD6S8Vuq3J9/H4HwdCyRZx168UZkop/N
         l9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCU9/PRXaBdHdRpht48Q9l0ogY3D2pDZg4B3JkKvit9gBuVxuZLQg/LsFWKiT2TFQt3NChP9hLPL0Z0CnRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80tEDZpktShwhC7W+DUK5ordeC3rKx8wkubtG5zVkwz/19q9p
	JTl9NAk6gwToNFv3s38uL8wiB9eA/j7ZBAOYWMTR/w0CIQ9ZcVRtnN50Bm6ygBX5LgAzYQnWa6C
	+cQ==
X-Google-Smtp-Source: AGHT+IFbjgenJSEGTWdLgFOWtExnq+ivKP1l9rQ765/WWBXl0wC/gywOgYMd4e6dYdWbXXmt3f8FtKaH6qI=
X-Received: from pfbgg9.prod.google.com ([2002:a05:6a00:6309:b0:728:e4d7:e3d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:288e:b0:725:e957:1dd1
 with SMTP id d2e1a72fcca58-7290c25b8d8mr6933616b3a.17.1734138473024; Fri, 13
 Dec 2024 17:07:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Dec 2024 17:07:18 -0800
In-Reply-To: <20241214010721.2356923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241214010721.2356923-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241214010721.2356923-18-seanjc@google.com>
Subject: [PATCH 17/20] KVM: selftests: Tighten checks around prev iter's last
 dirty page in ring
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that each iteration collects all dirty entries and ensures the guest
*completes* at least one write, tighten the exemptions for the last dirty
page of the previous iteration.  Specifically, the only legal value (other
than the current iteration) is N-1.

Unlike the last page for the current iteration, the in-progress write from
the previous iteration is guaranteed to have completed, otherwise the test
would have hung.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 22 +++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 8eb51597f762..18d41537e737 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -517,14 +517,22 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long **bmap)
 
 			if (host_log_mode == LOG_MODE_DIRTY_RING) {
 				/*
-				 * The last page in the ring from this iteration
-				 * or the previous can be written with the value
-				 * from the previous iteration (relative to the
-				 * last page's iteration), as the value to be
-				 * written may be cached in a CPU register.
+				 * The last page in the ring from previous
+				 * iteration can be written with the value
+				 * from the previous iteration, as the value to
+				 * be written may be cached in a CPU register.
 				 */
-				if ((page == dirty_ring_last_page ||
-				     page == dirty_ring_prev_iteration_last_page) &&
+				if (page == dirty_ring_prev_iteration_last_page &&
+				    val == iteration - 1)
+					continue;
+
+				/*
+				 * Any value from a previous iteration is legal
+				 * for the last entry, as the write may not yet
+				 * have retired, i.e. the page may hold whatever
+				 * it had before this iteration started.
+				 */
+				if (page == dirty_ring_last_page &&
 				    val < iteration)
 					continue;
 			} else if (!val && iteration == 1 && bmap0_dirty) {
-- 
2.47.1.613.gc27f4b7a9f-goog


