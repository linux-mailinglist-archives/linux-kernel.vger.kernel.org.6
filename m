Return-Path: <linux-kernel+bounces-426868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF49DF992
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802CC1622B9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC0A1E1C09;
	Mon,  2 Dec 2024 03:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zchxsR6r"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0705E13635B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733110110; cv=none; b=F8v8xukWeM8HpQAdzc9m7G3sZ/UztAe+HImgeli+T0pj9COxZ6iSSpgtSr51E33PBy0iSPG0ly7Zgy2zgcBk56U6LJ2XvLuNZL1sRNXbDYDT6dKu77JKWV7JawOr8UNEfHNGgXBFipoxjEQEMRb8ad0unBBhqlJm+vmayVFE/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733110110; c=relaxed/simple;
	bh=2pMqQZoJbxjJd5L7dwZDGgf0d2qUfEp05fcMAeCeLLw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ju9DyGXCoWbh567bfuMp3tAWRei0FqPAozoZwg3DAHWofvIXfz24Xu/u1yWew+3IdleB5OCcvW0xcLp1Db7fBojtyg2o+6YF4FwZooz+dO8teFo0jlcWLb9UjelD9bx0+DfRXp7T5fb/fm5Fi6TtZTpoXCbRivY/dOxi15G1uJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zchxsR6r; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fbcfe197d1so2444541a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 19:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733110108; x=1733714908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y7BxaTMkVE6X5DOMUP7/Ckq3J2VStDtJd0ubZx4TSrg=;
        b=zchxsR6rKReZq8JhnekXCGYc8gPBRSSIhGACwOLlkJDUnm6d4T7ppb/mUdPqlQoEAp
         8zdrsAFMHJ1mIx5eoWs+OpgcoxX1pbkdLwzaJm45kd80CXrr9dvdJ1AcTQMMeCvdRcZ8
         gX96wUtLQ0wHRJ+jcWhDjwYkmTIZ6DFE48xCYp+qZCBr3mQwt468muU52ouhs2h/x7L+
         QMnAfsWlAN/tuBDuLj5YjQZvlbGDvczifgu2utifJsVBL5jgCYW7qwKZjCW0nsxJaFI3
         /+DyMKo9IrSFZYhOr23MAwmTsjWpyfLb0PSusF1f/8BUHqKB5O3L9ueyJOfwkpfjx1uY
         mHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733110108; x=1733714908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7BxaTMkVE6X5DOMUP7/Ckq3J2VStDtJd0ubZx4TSrg=;
        b=bVHZN28g7xvp5QX06caO5RsgYqv/IQOXJejWpgIQqp8kVPr4jOApzXd6dsKyQNajck
         Ov5JRln9ytafjuvkKKSY8YRby8FUxlPlUj30EDT4lrQAbHhDdDb9X+/0qtz2J7Gwq9tL
         MyDPnIfhJ7k8LuY8ohfcf4oTB13uCvMWNytDsIYElOGSAts8bBU/gMbK6h66++4zH8ZN
         Ytoc0t/9NQNhqHANSAPGO4+n3o/iYbaUOtJ90RfQCr7hDUXfEm7oBjDZFH/8SlC0pZIO
         ypswoi/2FWzmpvh5NIKF133+gve9quWgzAWSxHAiKi0z/YpS/F0ZA2AXWvJ+HlmmIaKb
         oj/A==
X-Forwarded-Encrypted: i=1; AJvYcCWw5PxN78e+7p2bITcsTcbYEND9eodkETcuInWjc4d4S2EkMDkQ3Q1nRu3UI7GKd1Vge6fzjExK7QbOSHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4M+bZFloxofPzD+kENO0fewkkhxcFgT/qNz+SNfV0FpeoxuB
	MX6QNUETQafg91nmdA/Qic48yiM9lpmWghysABkpap6b/KkM8oBiaP6D6EZQSijjPaDNx1t7DHb
	GEw==
X-Google-Smtp-Source: AGHT+IGQEFTqJCfYrkvhV7zpHzSAKSaOya/ZV0CjsMJI82ASy+PAVAGSQD0Zy9K+AP8jSS6ISfvqLjNmk0c=
X-Received: from pfbcw27.prod.google.com ([2002:a05:6a00:451b:b0:725:325e:59d5])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d9f:b0:1e0:dcc5:164d
 with SMTP id adf61e73a8af0-1e0e0afa5eemr31014108637.8.1733110108206; Sun, 01
 Dec 2024 19:28:28 -0800 (PST)
Date: Sun,  1 Dec 2024 20:28:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202032823.2741019-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 0/6] mm/mglru: performance optimizations
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

This series improves performance for some previously discussed test
cases. Most of the code changes gathered here has been floating on the
mailing list [1][2]. They are now properly organized and have gone
through various benchmarks on both client and server devices,
including Android, FIO, memcached, multiple VMs and MongoDB.

[1] https://lore.kernel.org/CAOUHufahuWcKf5f1Sg3emnqX+cODuR=2TQo7T4Gr-QYLujn4RA@mail.gmail.com/
[2] https://lore.kernel.org/CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com/

Yu Zhao (6):
  mm/mglru: clean up workingset
  mm/mglru: optimize deactivation
  mm/mglru: rework aging feedback
  mm/mglru: rework type selection
  mm/mglru: rework refault detection
  mm/mglru: rework workingset protection

 include/linux/mm_inline.h |  94 +++++----
 include/linux/mmzone.h    |  88 +++++---
 mm/swap.c                 |  65 ++++--
 mm/vmscan.c               | 423 +++++++++++++++++---------------------
 mm/workingset.c           |  69 +++----
 5 files changed, 374 insertions(+), 365 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


