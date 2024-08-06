Return-Path: <linux-kernel+bounces-275524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADAE9486D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311B91C22476
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB62182B4;
	Tue,  6 Aug 2024 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ka/YApqs"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAEF1799B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906104; cv=none; b=EPOMnkqF45yrZNQpRwNkU+G+OFrRzMG3JqskdR5VN5BR3fsUFG1nuO/ywUWJJsScLatHXjkGdrG8vLm6LWjhcwy7INk5mcMDJuczy2NWGJ4kBjXnxOejFE1L6I7QUGFt3ybSQlCq9Nt9vxXK7N1h2R3bXNY+KAKSPhVM5On3Ka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906104; c=relaxed/simple;
	bh=Km+iJPKlLRg1mRcLnrAduu/BuUz0nmCQY6HrdWcZR0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oMYSwOayuaoiawu9weDldUzkMhW9JO+UNpp9vDbXAz57Z+MULfl7WkME+ilqkfksV+BGMNpm+gCOl30r0wefNsGHmJ6RRG7cd5BzyijTuOjPPNG2JoHWbZTKoGLVT7krjP1+kyf3RpmTMtODWtAtwMl7ZY8RvAoZ9cJCMlbu+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ka/YApqs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7a1914d0936so118620a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722906103; x=1723510903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IMpFhIDOals2MKSWZWMbH7rS8dQ/Ls9OxICKkzOKh+0=;
        b=ka/YApqsjcAMBwZVUYS4X1m1pYS96OywsJOZnPtr1q2eeDy6D+IBKrjcZ8JWO96qZa
         S5nQSETRn7uWL1L1IQTc2RSKx2xNGh3wUM9d3KUwA5EDj0hJpU++dXBchEYgXEYxiQKx
         u+j6PTq6Dl5vZjYYSWqUO3YIPdyVSL+z78+xMk/VWyqZIhUvhn/HXcww7PrfwLEKAdZs
         pPc2wDbMR7DrViiS0KiUMr0SCh7AxJHLBrec4K5Ne8yS45783EZH/HR8w6XM7Fz7W9TJ
         LRFVCtoqgvTEdUgrL0VCghB1fpNk1yzEhSgsidZ+6MD14DQ8kmXj5lBGYjfkLCNcnKFk
         8V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906103; x=1723510903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMpFhIDOals2MKSWZWMbH7rS8dQ/Ls9OxICKkzOKh+0=;
        b=R99CK5IYgu9KeidjFjTzCXPRtxBydqJR6NPZsXDJHleOiNy4/jzf9ndhi55VZ4doua
         go7jrbs+mnVLDK9Nk1iPFaDvge1jfyRWx/wZdnNzHJnh32GyerH4yEAZO+BIa1VSaUB2
         DiulOtgdRdtLX823j54+nq+T6QdwxA6w7ZB/cYaR2stYZBlVfF0qhRh2OiUjgXnkZsSv
         kc9ShNTezLR8ZpNXGJ9zCMyh/fIqfAOWuO4IIjeC7lNFBnj2wrE050zZsex62QP83MmR
         D7T+ZnYuxZVrTK3fSZsIbtoOyscNpuuxo+rTseQtOTKrr5vfcWoiryYq6Tbllkm20OdQ
         66Kg==
X-Gm-Message-State: AOJu0Ywnc+YDCL1IK88hvj/0lPw8uaAJbdvh5rzsXFAfklXMG5ByrCTK
	GDWQ+DYvN/b/eqxohWAWZ3PIMyXXVc5j37TwY9UN4PeQgdqqPse46uspJlWY4+uHChij05pv+bt
	EXzaXZYrZKg==
X-Google-Smtp-Source: AGHT+IHCkb1x+tcC8Zl5405hmEgWnQ5SRcEcP4wmpsZR9KLu0wxUs9mbgmT06I15SruC2BaSkbklt5uL6m1hag==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a65:6886:0:b0:7a1:f561:8c99 with SMTP id
 41be03b00d2f7-7b74893b228mr27035a12.6.1722906102329; Mon, 05 Aug 2024
 18:01:42 -0700 (PDT)
Date: Tue,  6 Aug 2024 01:01:26 +0000
In-Reply-To: <20240806010128.402852-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806010128.402852-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806010128.402852-4-cmllamas@google.com>
Subject: [PATCH 3/3] lockdep: document MAX_LOCKDEP_CHAIN_HLOCKS calculation
From: Carlos Llamas <cmllamas@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, Huang Ying <ying.huang@intel.com>, 
	"J. R. Okajima" <hooanon05g@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Add a comment to document the magic number '5' used in the calculation
of MAX_LOCKDEP_CHAIN_HLOCKS. This number represents the estimated
average depth (number of locks held) of a lock chain. This definition
was added in commit 443cd507ce7f ("lockdep: add lock_class information
to lock_chain and output it").

Cc: Huang Ying <ying.huang@intel.com>
Cc: J. R. Okajima <hooanon05g@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 kernel/locking/lockdep_internals.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index bbe9000260d0..2b429ed103a8 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -119,6 +119,7 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 
 #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
 
+/* We estimate that a chain holds 5 locks on average. */
 #define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
 
 extern struct lock_chain lock_chains[];
-- 
2.46.0.rc2.264.g509ed76dc8-goog


