Return-Path: <linux-kernel+bounces-275521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2259486D3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492471C22231
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61E26FD5;
	Tue,  6 Aug 2024 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xRwqL6Dx"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F863CB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906097; cv=none; b=Nu2keJK9Htw75ms/lQpyzINx3hWulGSqn/UrD8p0shH8bUg5Q8A1TXsOI/0yezI1J+x4WBQd2+PijDbm07FESFrrIIrd3lw57O/vQsJAwmREAPSmecEqGWugQnTg6BtV4ldMkCGT8e3HbeXbAD++eJE8Mho51OhkjGBFzRQ3RCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906097; c=relaxed/simple;
	bh=fM4SJzWvF3QTsUCKIYp6JVztdgWOj9EDVg02LaS/GXA=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=bXNCtmTTUin5YMFmH6aB+P1SHSwEvKk7/NsqLIP6HIbiACPjb/yOD1Z+YitJa409muknCcaqYkUp7TLolMZLOd3wZQmM3RGolBju6KiKjBKaeqf/lFTqnlnaXXJPZpOE6MJHHyB97/qTRmAC8/zuXrrF0ayoZeENgATv7v79XNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xRwqL6Dx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d1df50db2so327410b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722906095; x=1723510895; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jJlx0J8t9Bmz0EPbFFVZ9ZkYVWLdmylZG3lirelk9mE=;
        b=xRwqL6DxJ/QF5kgdooYnMep/Bj9ORZbIsR3yE3tSX5uFibB9XjpDUQ7bC6Z2KhQwjH
         HT0ggJpM3YyD6uXuvWIcO7M0nR/8tETmKg1MnQ7L5Y/oG222jWSmsmbnnF5T+xY8Nr6j
         9F/deF/Hj+9F5f9Y+1NjaYOuzU6BM+ClGYd9PXvHbhVS47tvpC/IqcsbK34P7IydaJpZ
         KOWOEhxYPCs5Z8OOV0Kwk1xDkTCk+6X3Rbss41EUOROyDSdP7vDu2qAjtC8/9Q7EJ2bf
         3POBlb71V/uRLaAgMOOg2Ev6xvnjX9TThjQd4qa7PEw0u3O6doTrim4I2cQlIl4b3sSk
         Gm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906095; x=1723510895;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJlx0J8t9Bmz0EPbFFVZ9ZkYVWLdmylZG3lirelk9mE=;
        b=VNeG2z9dV2s6YVCQGmNATf7iD+gFa8TftPNxae9hgus2rmQM6ijWXXjat4F67qH/87
         Fn2qZSOfuDM1kuYo/d3DrM/y4YZYq0waWAhRAoCCT1UXnVusIiJ4hrSrtbbV/XBbvS3P
         yE/67Le5WRQXm9TJXBbsK9DmtUX6T7eKjZJ+JtiutjI2+3T0zQI8SWs/hOYaVUM3zYRA
         b90otf32iss5CQOLy/gaF1xzsmhIhMcpLnWeBAqh9bTWKr927Qnm3yCBs2/R27VGJeEc
         yEdwN1+7lDVNF115dYbTZs0p6WkG+yOi8MjDGfZwNURHfmpeunZGPqIlYZ/PwhV6bXlx
         e91w==
X-Gm-Message-State: AOJu0YxFqY5fGE1dUZ7T6QKQShhvY2yOHuAWbU4+8UBlLx5Zvmc8eV8M
	YtNR0eLZD9LUFooIPPAoAdS6osOxoIweiiflLz5w49TaIKuZu5WWHCpIyJrBYZPRQIxT1/WcJbn
	IhOpcqE00ztCMjJ7MWq/iSU+hfEr7ihZft02o9r/Vkze4u079EvbBZhNujuGh4uf0p9BIPTnNAq
	eXjXJOHE2iMHGiyHVhtPLgJt7dy9xZ6cjrZugq7Kip+SI2bI6a5Rs=
X-Google-Smtp-Source: AGHT+IHE2vW0EK7l1Yeq12LW+96R9mdcq0Xqzm/E7LumdZwrFbLPeTh9DiSlY+ml/fBSIj36DP6J6KtGtY3Xeg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:9192:b0:710:4e5c:967d with SMTP
 id d2e1a72fcca58-7106d8d2d3bmr233519b3a.0.1722906094399; Mon, 05 Aug 2024
 18:01:34 -0700 (PDT)
Date: Tue,  6 Aug 2024 01:01:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806010128.402852-1-cmllamas@google.com>
Subject: [PATCH 0/3] lockdep: minor config and documentation fixes
From: Carlos Llamas <cmllamas@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, Huang Ying <ying.huang@intel.com>, 
	"J. R. Okajima" <hooanon05g@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
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

Carlos Llamas (3):
  lockdep: fix upper limit for LOCKDEP_*_BITS configs
  lockdep: clarify size for LOCKDEP_*_BITS configs
  lockdep: document MAX_LOCKDEP_CHAIN_HLOCKS calculation

 kernel/locking/lockdep_internals.h |  1 +
 lib/Kconfig.debug                  | 18 +++++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)


base-commit: 766e1913ce7c3add51f49bc1861441e3a3275df2
-- 
2.46.0.rc2.264.g509ed76dc8-goog


