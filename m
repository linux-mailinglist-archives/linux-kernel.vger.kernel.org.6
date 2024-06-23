Return-Path: <linux-kernel+bounces-225903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4412191373F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 03:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9F71C21028
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 01:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8742579EA;
	Sun, 23 Jun 2024 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXPUgWKv"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D5323D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719107463; cv=none; b=RYjBsN5CnlMPXUpeB6Rm5aleN+ruqw9SyuMCPC/1arWL2bcFXcJnsv2wrzCokJyvoibtkn9Ch6qzcFlI6RwJ0fBo1/xiMbA0D9FtvimOjaMNpTWTwmYT+zhArQH0obOSQqO5URwd6LcOnONq6xCtGGf8f5wqBJ3xOZzVdzupizc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719107463; c=relaxed/simple;
	bh=P+PKS8m42ljBAbyGuuWryReC6Jqlk9dro1d2kpyxqao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GsvGCVivAWO814K0waRtP0ZG7iw5YWe2E7gyJ9q+B0zGls0vOV4lcw+MqEi2cnqPldBJC0IJgVO65sp9w5hIs9J+A87/ZEZQrWxKKQvA2EPLVrGxghkpnhkfEmU449NQ93pFg6bV7uAn9Om76xGc8NEFMcdq5jwYpDj8Id1VO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXPUgWKv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70436048c25so2966522b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 18:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719107461; x=1719712261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xe2UlK7v/7rbuod7LlXrBUY0CkHWMtlpCysjApbLgNM=;
        b=kXPUgWKvEhB1ZYWJ7ruUcUlbkU6YsbrJh887+r+4yhMaKM8xpCPJrQxoOxVQFT37PR
         TRGG7yOdZrsG8s7i/X81mNlb6dkezNLRLHL7tjyQOblNxeQ3UmePrJ5MhdQLCX9zVwP+
         xew8BCjUitkydtBE+TQWSCw1XK3b6zwhL2h1I5sCkEdOxEBOKRfOSVB8pR2oJdEbAWY9
         QOdOg8KBApmN6vQA073jSQ29t3aerjSjIL2X95j+xZ4HsiqOu5der63aEY8j45kzaWMq
         RbgpN/6TuO9pgpH6VzpCU8/OVjAka3ox4lCQDsGFmkzxmCnN1gTQHeq+vSAdIohSLTBL
         6EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719107461; x=1719712261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe2UlK7v/7rbuod7LlXrBUY0CkHWMtlpCysjApbLgNM=;
        b=QJWqf2n87yiZbK19qUcQChd2jBTlroclzVFUzJyoINW+vF8hdN7rgb6XvL1Q4kF5w3
         btdMo2GEHEfFrYBl9o1XMkmwHhBQ1gVlo2Ub9M8Fhk0GbuzV1BnPoZccgeOpS5ZqgbDH
         Txr7U3ppEmlbn3ZBkne5++1swKz96th0YNrtEi2tJcLairRq3b4KFo89HO9QThHYwlzZ
         mc4cQnnLra0lmwf002i8g9nPwPDEjbhl+0d5/NvX/cS6TwEJm188B+gY56DVAG6I3/3/
         fEBEpagohGu2zNVNwqyLUTszhp8m6NIaoUMAInKF6KkwEwcbS2ojViaQrORyeqoIPTwE
         dabA==
X-Forwarded-Encrypted: i=1; AJvYcCXVpwyjLjJfeB94hVlpQu1EsF404v6JE5E61um0m78VwAE3lSv9FwavWBawEvq2ZGUfNjsMyAPH5QnCOJ/iYZwmotNxSD2gwfqcH7Di
X-Gm-Message-State: AOJu0YwzRfXyhgT11GXkuxISUbTK27SOuvv8LC5LyZMAuPC3VjnHQMXt
	EnyiVPmfvWDN+xx4/YtXD06ZwtEkkgosLg60nIM5r15TvhPUVWwijUWmjA==
X-Google-Smtp-Source: AGHT+IHnwvR2xclrhzZcuu5QV+H9OdsAunxKNgDsINmAqXLGjQ1oqxY9Uf/2Hg6ra/31ZUju4MwdtA==
X-Received: by 2002:a05:6a00:22cc:b0:705:ddbf:5c05 with SMTP id d2e1a72fcca58-7066e52a7cbmr2639924b3a.11.1719107461503;
        Sat, 22 Jun 2024 18:51:01 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065107b8acsm3712626b3a.30.2024.06.22.18.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 18:51:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org
Cc: void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCHSET sched_ext/for-6.11] sched_ext: Clean up kernel/sched/ext.h
Date: Sat, 22 Jun 2024 15:50:19 -1000
Message-ID: <20240623015057.3383223-1-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

While sched_ext was out of tree, kernel/sched/ext.h contained declarations
and definitions which aren't ideal but are helpful for forward porting. This
patchset cleans them up.

- for_balance_class_range() is removed and instead open coded in
  put_prev_task_balance().

- Some declarations and definitions in kernel/sched/ext.h are moved to
  kernel/sched/sched.h.

This patchset contains the following three patches:

  0001-sched_ext-Minor-cleanups-in-kernel-sched-ext.h.patch
  0002-sched-sched_ext-Open-code-for_balance_class_range.patch
  0003-sched-sched_ext-Move-some-declarations-from-kernel-s.patch

and is also available in the following git branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-header-cleanups

diffstat follows. Thanks.

 kernel/sched/core.c  |   14 +++++++++++++-
 kernel/sched/ext.c   |    2 +-
 kernel/sched/ext.h   |   54 ++----------------------------------------------------
 kernel/sched/sched.h |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 75 insertions(+), 60 deletions(-)

--
tejun

