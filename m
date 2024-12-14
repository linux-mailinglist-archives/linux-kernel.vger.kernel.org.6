Return-Path: <linux-kernel+bounces-445800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD019F1BB3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEA9188A49C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B015782C60;
	Sat, 14 Dec 2024 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xcdTdCHp"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76023B7A8
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734138453; cv=none; b=H/SnaKRaM5gxIOj+DO7HwK9atKCy4ckEcUc2QwuDhGkcL4NpObCJOAM1UPETU6+WHMAvqa2ud/4Iz0LHwNlScosKZ7s83VBYt8Z4Zr8s9cqewTBJ0sSicZinTAxC2qLfHWoD+PjCBnsyL468xmp1Sx6SvboXoXWFr2mKvGxqw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734138453; c=relaxed/simple;
	bh=40+uE3sPtrY0nnt1koHNIUnQu2u+jT00mNRygEsPKEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WhYNhVxhxEISjBZh4iKsb5Bay03iihypc+rdjpo69nm8f/v2H6Kw7yR0rFyaD+rBBVQkQaClpMcqiVCqeIFmH8yIbx8XBzFGcKsJcnob4N6QZDHwI4mKFzO7+Z1Od7g6kWg3DDLW+58vP7lTkIzG4SqyLPxA3Y+/tQGv3RKbpeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xcdTdCHp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72907f58023so1983993b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734138451; x=1734743251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MI6Qma5wvtLLYEaqt0UatWEv3JJNRMjOF7eSoljdSCM=;
        b=xcdTdCHpyFZ7Vb4NDcq5rVIMnbFBAcjguVtPt0zgRpo5dzGiN6gNUeQKdzW534sdfW
         x2QYhW5hazgcpLB3KpcLpd5PPBhAeBtBdy9l1u84YYRkzXZYT8uYcRDM7jtdJIL8cjWU
         xunsfjb7C8CvUK6jc9as+yPtl9naj5IKmNrns9BkBxTLsanNTbePGUB1D1l9YUHOgu/C
         A4LvQYTyg+wwaMk3VvRYIXGD5+VIub95DCoCu3bR0nIjiqMf+LeWgy+XXCILqKkh7nwu
         z3PDUmtOqBqNiKKKJC0kFMPLiyn1065IzZg+fNSRs5mffCcKOsFnkmgLWhXlFUn/8piA
         FsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734138451; x=1734743251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MI6Qma5wvtLLYEaqt0UatWEv3JJNRMjOF7eSoljdSCM=;
        b=hM9+nsXoybqUdh7P6nZJ7VilUP8YOJiFlEF3/NGTGqzIJPepIqjQeP6haw6PsbASx8
         B5JVmfVuKai1ZSAgsZf2xmlC8XNUxecsxYb5uatn0gIbc230uzFOp/TkfotD4ruZLRw7
         B3iX6ADdjuNSs/Zwj1nJ6JHO9OclLpvA6GsFaMCmhR1dVrrkEIBLtsoxWG/Qtj4+ehEf
         iCfDxvk5+whjSj2GJxta/a/ALzdqDCDH/ImyXvWxgrs2pTFQNhx6SHwVTtgfv9k1iquR
         FUgv5hI3AA+Lcg6r6yBaWvJdC3Wu/80zf749WhRbVy9vhXsa/CKCI+Kex3kmzcy36wGR
         2+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVF9+KicsS/sq7lF4O0704zSOEIPOzVDFcbPEDdr/qG8deGheMKAG/Ks9SykyLQ9+wnXuS0uNfVFDYkMKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoBn3cCRYtBqXdV4e3hLxZSaoLTw9txUk9zV+yVuPmopX8O+8+
	5Nond5ZkVEzQUA27r60ZhgT4drZfeSK/+jB0CeOqvdOXpgiM81uhnk/LB1P8hA6h7MsqrgZsrSc
	7wA==
X-Google-Smtp-Source: AGHT+IEgTSVvvWEd78/T/3yZBa8sTV/azpOr4QdU93yuP7UZZJ/l4/0iwkxtnud9GUNGgYiWrbJ3HVCNU3U=
X-Received: from pfcf8.prod.google.com ([2002:a05:6a00:2388:b0:726:d6e6:a38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734b:b0:1e1:bef7:af57
 with SMTP id adf61e73a8af0-1e1dfd70b1cmr7762017637.21.1734138451136; Fri, 13
 Dec 2024 17:07:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Dec 2024 17:07:05 -0800
In-Reply-To: <20241214010721.2356923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241214010721.2356923-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241214010721.2356923-5-seanjc@google.com>
Subject: [PATCH 04/20] KVM: selftests: Drop stale srandom() initialization
 from dirty_log_test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop an srandom() initialization that was leftover from the conversion to
use selftests' guest_random_xxx() APIs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index d9911e20337f..55a744373c80 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -891,8 +891,6 @@ int main(int argc, char *argv[])
 	pr_info("Test iterations: %"PRIu64", interval: %"PRIu64" (ms)\n",
 		p.iterations, p.interval);
 
-	srandom(time(0));
-
 	if (host_log_mode_option == LOG_MODE_ALL) {
 		/* Run each log mode */
 		for (i = 0; i < LOG_MODE_NUM; i++) {
-- 
2.47.1.613.gc27f4b7a9f-goog


