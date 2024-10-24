Return-Path: <linux-kernel+bounces-380510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DAD9AEFC0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C0828444A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25612022FE;
	Thu, 24 Oct 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="21OcgwGX"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D41FC7D9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729795005; cv=none; b=uTxAzZz3i4M6WGUN7Nh49cCx4F+nTXj5xuhq0CpAiHavLHc7j3chsDL3U38tIxx7yEm2gQ8BtXpK8SV/FWJu3jRdMw/6ByvSNlndOHVxhaHVtbthIs1GRkls22RS4Zh7uKmmmMxFGlyxV6EEVhFPRkFc2FClsg1LIAQeUlPjnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729795005; c=relaxed/simple;
	bh=3kiHpo0x4JoZC6Rs7bU0fkNLNXIKhCfPNpg1vpNlwkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Td4jOgJ8prKGUGVYBWZUX3tCfQ9mPnOsSh0K5doeFjjpHbMk4wE0gqj1OT2FOLj08RVPCiGfMSQfOpj8YA+RL3KLt3ktQCQeYpLsLZZwx6OKHHJRCDRXCJ56UNcUbl/Ftjbp6DKgGeI+u7RrD5B6Ad0GuSlGNL9IeW2/byW/x9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=21OcgwGX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35d1d8c82so22017167b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729795002; x=1730399802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Av5TcrKQ0emSnE/TneH2xzU4DKf3Pe9BcgJTocLWv6k=;
        b=21OcgwGXozWmG9BEw6we1s0wrdwVYmi69Mvg/eXGvVFibHJTaot3tnidhFQB0DXroH
         tQhnQi/DEmrmQb3YoTRxMtRMQwvvx8AtG0oa0HnAQMMArqGZr4HsGXRx8Nr5+TzpwKw5
         NPsHYz/OORCasYaKAX5Pwzo2AJXZ2lETE+qxzHqfCD650lXOaOlJavEmDbIUOTN1gGJa
         Rh1BcLwoaiBk7PY0Zxg6G6yh3cCS3bB4Xkv/j4RctS560jwFtVVs6nThcoRtzQ43eHgr
         cbKpz4pDVEvI6Zi7slfpMH7QoqbpBcg59FAXalWjbLlcY3WDt55kpnEDErXeAxDqCcix
         EoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729795002; x=1730399802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Av5TcrKQ0emSnE/TneH2xzU4DKf3Pe9BcgJTocLWv6k=;
        b=HrcVtYi0RpGT21n3Ykn36lKksutwDwU5/lf+7fIKYmahdGs2mZ6OE3Aw2bGaVm/KBN
         7NVAzY2dop8QrrVwKZNS0Bpxs7VaM5arXKzSGCqTqNY+K4anfXQvTddjH8sSK41kXERZ
         dhDFNGp8tR6563p0k0yuJ0Yh6x0FDg0EZSuv4pnBuH1CEjzHFQnbrl2HkSzFDDsOkBb2
         KNfGY+YsRad+XODTGoJT9YkaWX/A6zwtKh9v4+iPERXc5yTDojedu79cd2B+XBsU7BZ7
         N6TD47dcxMTuZPYuilc6QSJsMuGT0h2DSzIpp9vs/6fnTstn56H7abYcwyFaMl7f0ZK/
         Pn8A==
X-Gm-Message-State: AOJu0YyMiWlz8+pz1Tna9H0bSjWjtd3U1haZa9RzPhR8lcnJC6aExp9K
	bDXcrFYPzNGFBd4Awmg8KGbK1P06NCrT42sJAmY8r4pVkYxOeXXKY88OGpEsGf2tliTdL/S/F3s
	YItftjH6yGQ==
X-Google-Smtp-Source: AGHT+IEaHfj7A1f4KlpGTBNrwNkb5CcfS6KTqWpzwjm4zW82/1tDEVQPsR6Fed1wLSSEGkjI2tU6GGymXjdVhA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:7449:b0:6e2:12e5:356f with SMTP
 id 00721157ae682-6e86637045dmr1541677b3.3.1729795002388; Thu, 24 Oct 2024
 11:36:42 -0700 (PDT)
Date: Thu, 24 Oct 2024 18:36:28 +0000
In-Reply-To: <20241024183631.643450-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024183631.643450-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241024183631.643450-4-cmllamas@google.com>
Subject: [PATCH v3 3/3] lockdep: document MAX_LOCKDEP_CHAIN_HLOCKS calculation
From: Carlos Llamas <cmllamas@google.com>
To: Boqun Feng <boqun.feng@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, Waiman Long <longman@redhat.com>, 
	Huang Ying <ying.huang@intel.com>, "J. R. Okajima" <hooanon05g@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Define a macro AVG_LOCKDEP_CHAIN_DEPTH to document the magic number '5'
used in the calculation of MAX_LOCKDEP_CHAIN_HLOCKS. The number
represents the estimated average depth (number of locks held) of a lock
chain. The calculation of MAX_LOCKDEP_CHAIN_HLOCKS was first added in
commit 443cd507ce7f ("lockdep: add lock_class information to lock_chain
and output it").

Suggested-by: Waiman Long <longman@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: J. R. Okajima <hooanon05g@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v3: collect tags
v2: switched the comment for a macro as suggested by Waiman Long.

 kernel/locking/lockdep_internals.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index bbe9000260d0..20f9ef58d3d0 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -119,7 +119,8 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 
 #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
 
-#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
+#define AVG_LOCKDEP_CHAIN_DEPTH		5
+#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS * AVG_LOCKDEP_CHAIN_DEPTH)
 
 extern struct lock_chain lock_chains[];
 
-- 
2.47.0.163.g1226f6d8fa-goog


