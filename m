Return-Path: <linux-kernel+bounces-278066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD5494AA72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF87C1F21391
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99122811F1;
	Wed,  7 Aug 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLxFdLLS"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265A8005B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041571; cv=none; b=iBS5M+E2qmSI7QX2o6D8QCJWmr6pglkSeBRiOZ3tkfej6NpAlMhoez5U5h7VMWU2GEzYeyA/I+ucXZ6cAoAnnbr1dxPy3N+A3ZgZo8bpt9tdr5gbGRnTvk48lbvd5wyQPl2npGuvgpqtc6KZcDNtW4nHvMHP4lFZ6V39uW1YrCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041571; c=relaxed/simple;
	bh=r7lF1o4iRHGH4f4sMfpANX/D7WnUtxSEfN5qZCVbnZY=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=HUp/upB9OK6H5usvZTZeSStBH+sCdA1m7Kzhdp2JRy8kmDOldlCvOExEGgJAP01y8E/tUQVddQ03xL/PAoBIUuz7lobLk8uTZHhxuFD3DD93gjOBF4gFyLmFNbKdJGorC2LhQLhKhRQYnrz8tslZQbFaGgJhsRAyqPG/4j3cwnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLxFdLLS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7104f37771eso1972684b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723041570; x=1723646370; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VvGdizoflRwtNQAi0Yk+1Nxwj+WXb+Tm/DM6/vmjVZQ=;
        b=CLxFdLLSDBrVRfoCZsBSq08h1+YUObygO9+8ErrhMf6dD+LNLdVTwLfnJVTvje7kMe
         tb7K/LJHWOZcYUbm2sKij/8KClbzk8IGUXawJqp0EsCEb/lQOEmcP5CFNe6c8qDP83DO
         cYKyAVagmSLoaxszeTXP0v9MaaP7TXTpFSh1oTKOVFeYHn011GU6Lfx+3xW6DkNlTXl6
         ISgEQ2QgpIyiG/NlKwTPDXolwHEmWG0Tt5YcfAK4Uvk/P8/o64T923G0yGKYVDB56X1j
         f2p8Pg8MUeNfSWmkYbWjbgeaCmYG/XzvV+EzyB7Bo2MxnzrZasJ97fSFSyVbGYEfGZn9
         hzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041570; x=1723646370;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvGdizoflRwtNQAi0Yk+1Nxwj+WXb+Tm/DM6/vmjVZQ=;
        b=Og1IgZtw4VZruDYJjBD34UX+s+U/l2lNT9PRApQ/BzNWDSY3Xk7UZvdJmSNh8by90m
         vbE2qXs37U90QJQF7RxdOQN7g/T5pZMJnzfQnSUdGWBCfngXqzC8Bfcoatxv/lntdyQ4
         qILLFcC9vZ80Gm4xbtfalhCpXGNtqLTu4e63Gz+T97q0xxJHnD1PWnRfVFAE1qq0KRLN
         ui+6kEHzoDlFdhxDy5gx6FiKU9q6u9089gfUvkd0qdE5SCF9e2TgvRZxMRPZcDPphnzt
         +nqs4QR7/mvIR//sUxXn6lHjmMvzbs/xSL58sgfMcCuWP2acq3KlbPWjmKX1xh7gnM7v
         nSjw==
X-Gm-Message-State: AOJu0YyS9ta7kwjYZvhrvmTn2xaTZ6HisK7SzGTEbTBxzCK+PddmV6Qz
	3LFzWE9TqjXHA8hURkqZ8hu/d+EEYuMb1pn5D8qszgU+wN7FxvMt1xDZJs15vo4lBnGSqW7sqsa
	YiJDPkkML7/jH6q05eNkOISB/pwM8YM/w0xgAexL1rThrhkUDSxtjGvBc1Rv40e/KLXRSw25S7R
	yjoFKadLag45Zs2XzP3V4eVwOJV7kDqG+dCbNPkelBbpV+a+TKhSM=
X-Google-Smtp-Source: AGHT+IG1TcwI/iib5itfAk3+YXxvXPUEUdilcJNpFSj/w9odftFMKm8IwozpMjbImZN+tQyPQuzEFos5uk8ZgA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:6f01:b0:70d:fba:c51c with SMTP
 id d2e1a72fcca58-7106d071bd2mr52979b3a.3.1723041568344; Wed, 07 Aug 2024
 07:39:28 -0700 (PDT)
Date: Wed,  7 Aug 2024 14:39:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240807143922.919604-1-cmllamas@google.com>
Subject: [PATCH 0/3] lockdep: minor config and documentation fixes
From: Carlos Llamas <cmllamas@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Andrew Morton <akpm@linux-foundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Huang Ying <ying.huang@intel.com>, "J. R. Okajima" <hooanon05g@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

These are some minor follow-up patches that came up during conversation
at: https://lore.kernel.org/all/30795.1620913191@jrobl/

Note this patchset is sent on top of akpm mm-nonmm-unstable as it
depends on "[PATCH v2] lockdep: upper limit LOCKDEP_CHAINS_BITS" which
as been previously applied there.

Cc: Huang Ying <ying.huang@intel.com>
Cc: J. R. Okajima <hooanon05g@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

v1: https://lore.kernel.org/all/20240806010128.402852-1-cmllamas@google.com/

Carlos Llamas (3):
  lockdep: fix upper limit for LOCKDEP_*_BITS configs
  lockdep: clarify size for LOCKDEP_*_BITS configs
  lockdep: document MAX_LOCKDEP_CHAIN_HLOCKS calculation

 kernel/locking/lockdep_internals.h |  3 ++-
 lib/Kconfig.debug                  | 18 +++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)


base-commit: 766e1913ce7c3add51f49bc1861441e3a3275df2
-- 
2.46.0.rc2.264.g509ed76dc8-goog


