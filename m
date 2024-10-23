Return-Path: <linux-kernel+bounces-378350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6429ACEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FBC1C20976
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5171E51D;
	Wed, 23 Oct 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEQDW2TP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101A1C831A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697207; cv=none; b=Vymiisb3uWL6KZOP/gOiWacSTGAaF6Xv+wYpwcKDJj3BC0BcAQ6EGf68ALiLSukabJd7UrJCdSN+Y/IfWwCimP2yFZQd2nJpIVliD9XRt7fViVPDCZx9qEjSUiVnJ17tjaFSoWYBI/fSnUpktsbi2MYjiH8FqIfYDGpEFrk8KaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697207; c=relaxed/simple;
	bh=sTMEe8hKVyhG4n3/J0S0bVeWZJkoFNBIjGAvrfLzml8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OACSFZKynOMlPw1BW4YpqMV0IWpcga9OqIWywpkXKOTSz/NBaKP5OX8gPcCl/HvxTwKXJu/NAmVIYVGEDebxwc8eLRaF82fY4TW3A/hifagRcqd6SzI3OaXXOKuaP+ljekZXkhi58i4KEdRxnyYi23AO8XDajB2lzqn4W49f24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEQDW2TP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e6101877abso56452137b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729697205; x=1730302005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7NioyoNb1tbeyUGY4RlitjUeF9A4E3KRPhc6ahZCNVQ=;
        b=tEQDW2TP4aSlWq5iJGF0obfpW9K++suPbFYXR9gRcqeoXCNrINNmWcQAwiUErUHrhe
         EIQ4Q6L7hkC1Lpi1ZDYUr2jcNgeIENl8cX60FUD6uwSxaGGh6Q3sDyqoW5Ntl2LHT0ro
         0FBr4Tkgmv4riw3M7uh54fA7Rwz/I3JdXpDkzmriMSnjFBEGYfC9z+NzykFXC5qRDh7s
         NvVt3bXraKyVCzUFpXelc73Q7EliBIJ+mzXCN5isJ1DqSdCzOntiawjk9NlN0LGoBGUs
         yCbqSTvwxPnKkpVWkNgJgnfpSsXkb1+5mxKivDQlPkLvXqorouaqK1yjThx5wdVBxZSR
         3P/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697205; x=1730302005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NioyoNb1tbeyUGY4RlitjUeF9A4E3KRPhc6ahZCNVQ=;
        b=mrX69+dn3+oVuZDeV70db6ZbsXdVpmfoFb/1zTtpJllQ0r7lnxbUSZYhEes/uffA3u
         V0UA72ie035zCkbKDnDnYerFvPG/pGDL0+osqIjnT5M4/FPCKRmdyPda7LrJXjKJEg9o
         DyJn0P3lioubtCe0WhbPGpkDe23YP4fiSHxD6mWxqnhq0JDZI3WcAKJyISXQFN6gq7GI
         XgXsotb4f+/84gjvq9ZK5dUKx2qX02x3YiLxSLGq/CBDDmfgzdhEk5tjGj/n41HFIGw6
         vY7zPCufICqMDUWxqc5OZIh7kF+IpXb2dHInzqJNBd0+ueeQw/mEG2/NJu/vm/h82HUt
         AfCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyJLBg4BT4KW9qCkYLkgNumelOjdfsF3zdO69sKd9i9UW65DbUL0kotcbzzBLCsg54oplWwrSgGXUgTXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdG4t2h6LQ7XpS1gyYjuybvxXw9DX88GV43Yl7AB9i+EphqiiL
	SAcv0yByI2Jdq6h0+X8TnBI+KES9rpGVaURsPhSTyhPb4+VG7j31EMyfYmW8WZ8l8QoJ27H8cus
	92ioCsQ==
X-Google-Smtp-Source: AGHT+IE9OyKSIQFj5g+9JOMt/US00gq7iSxNgRTSGWr8GfQo9rufdELdBzRinCot5ZkBU1YALlbhI9gWX/bZ
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fac1])
 (user=rananta job=sendgmr) by 2002:a5b:947:0:b0:e28:f454:7de5 with SMTP id
 3f1490d57ef6-e2e3a6b78d6mr6103276.6.1729697205144; Wed, 23 Oct 2024 08:26:45
 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:26:37 +0000
In-Reply-To: <20241023152638.3317648-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241023152638.3317648-1-rananta@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023152638.3317648-4-rananta@google.com>
Subject: [kvm-unit-tests PATCH v2 3/4] arm: fpu: Add '.arch_extension fp' to
 fpu macros
From: Raghavendra Rao Ananta <rananta@google.com>
To: Subhasish Ghosh <subhasish.ghosh@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Andrew Jones <andrew.jones@linux.dev>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, 
	Raghavendra Rao Anata <rananta@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since the tests are built with '-mgeneral-regs-only', clang-18 tends to
push 'q' registers out of the scope and hence, the following error is
observed:

arm/fpu.c:281:3: error: instruction requires: fp-armv8
  281 |                 fpu_reg_write(*indata);
      |                 ^
arm/fpu.c:74:15: note: expanded from macro 'fpu_reg_write'
   74 |         asm volatile("ldp q0, q1, [%0], #32\n\t"        \
      |                      ^
<inline asm>:1:2: note: instantiated into assembly here
    1 |         ldp q0, q1, [x8], #32
      |         ^

Hence, explicitly add fp support where these registers are used.

Reported-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arm/fpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arm/fpu.c b/arm/fpu.c
index 587b6ea3..f327a349 100644
--- a/arm/fpu.c
+++ b/arm/fpu.c
@@ -38,7 +38,8 @@ static inline bool arch_collect_entropy(uint64_t *random)
 #define fpu_reg_read(val)				\
 ({							\
 	uint64_t *__val = (val);			\
-	asm volatile("stp q0, q1, [%0], #32\n\t"	\
+	asm volatile(".arch_extension fp\n"		\
+		     "stp q0, q1, [%0], #32\n\t"	\
 		     "stp q2, q3, [%0], #32\n\t"	\
 		     "stp q4, q5, [%0], #32\n\t"	\
 		     "stp q6, q7, [%0], #32\n\t"	\
@@ -71,7 +72,8 @@ static inline bool arch_collect_entropy(uint64_t *random)
 #define fpu_reg_write(val)				\
 do {							\
 	uint64_t *__val = (val);			\
-	asm volatile("ldp q0, q1, [%0], #32\n\t"	\
+	asm volatile(".arch_extension fp\n"		\
+		     "ldp q0, q1, [%0], #32\n\t"	\
 		     "ldp q2, q3, [%0], #32\n\t"	\
 		     "ldp q4, q5, [%0], #32\n\t"	\
 		     "ldp q6, q7, [%0], #32\n\t"	\
-- 
2.47.0.105.g07ac214952-goog


