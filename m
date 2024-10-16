Return-Path: <linux-kernel+bounces-367255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0F39A003A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0344B1C21982
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03031885B7;
	Wed, 16 Oct 2024 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GAk8IiNI"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2921E3BF
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053375; cv=none; b=Xfv6gLubgh5X+wA9TzgVu6cjLvN5UUUvPuz+jwWJFqU/35l+NEtnZxt4M5o50YhxO7Da4unRFBiFdR7uxW1Mf9zDGCxzToVe0u34F3xa4A+o/84M44/KWH5U98HHh6Lk9cPw+s9wByGSYJdE1XiNX9ropB73+ZnGgSYYg2FNGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053375; c=relaxed/simple;
	bh=qC+n3goTXS2hugt8mCIbvBbJkH7jO/a1Hr84ivOiSQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMNi0bVBEhArJOaoi7y9tUF3w6khbdaYXkw9wXOrmPG2sI+ylE8aYL42xwqXLgkyQOJZVkkHyRLidZhsDRtg3OsSooXBlQP6wliPUKjYplEZN/z/q3k7T/3/iGt5lmD8ugsRftkoxEZ83f7tN7Ww5qby+prUsXbeYKi8guG57hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GAk8IiNI; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so2941039a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729053373; x=1729658173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqqd6q78BxI0CU824J9cvO4t84aKbKAkVfW5iWzN9E8=;
        b=GAk8IiNIkCQlW+TpNVYy/+JOzUv6EYQElV5SPr82QWHYeOsz78FZJGiqCJG7p6gK/O
         GmZvLUIosbBQ3pNrXPXn3YqlJTs9GdbfaW6xGWNDsxb8fdQiGrZSm7LERBP/vftTjiER
         gLCT9BfrfGX+D1ETmQnZsy93OqiqD4tWeF+JfRy0yxjkk1QcRNK0elOB+3JGLfahkZht
         JncyI0V1aupTgzmZDOvjG4n8I3pupHnCGshjVgzZDRwlY9GD+Ls+3XbD9Or2vy0qacqZ
         lom53BM7w6KgFCmpF5zb2fkVmnKcjVLfSVSAspMaaLc9vUjW1frq7PxhMPUQaHAOPlgu
         aB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729053373; x=1729658173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqqd6q78BxI0CU824J9cvO4t84aKbKAkVfW5iWzN9E8=;
        b=mPCKInuGbSgmfVp4e8D7kLDqCtDwXqZetWLc4RQszh6hOl/KBNFDm94yR/71X+mof+
         V4CGZrin1EVo0VG//Ya3vtfCZh2+dUmrwdN1YKqvQyR/lzMSiPjXopJ8NrOrBQXe1Tya
         NDmHoDlY9v42vped6OOCg4MWWfLYXsWvqEqVfk4ntFe+NrUMWfyV6E6UsnGnPnFoW2cF
         WuVGMNKwwoqhTV6F3AwCNB16av6ecVb6AxVR+YjE10gQw8HNvf07ugvqHIXbu1c5SHkB
         BjNX3cRIyD2k0CLXkBYU07icKy/icXpTMzXBg/SarPm6Rph2psMFf70vU4dGVYwgPqgl
         EnBw==
X-Gm-Message-State: AOJu0YwsKjOy/amvTX9Ym31JuGDwCEP2EUv1k+6+eCpUbCPqYr+IWM2o
	PBR7FlAJyEZm97DZkaA7nNd1QP2dyLt7b2zxEiXXdWVQ2j66wYo5mH8+27cJZBU=
X-Google-Smtp-Source: AGHT+IEK1hvescxPxPc6pwGW1b9EOHQ1bmNSkX7E0ygZg8JO5Ed7uYaLkOxbUJa2xc5HWUdiyI+Y4A==
X-Received: by 2002:a05:6a20:2d2a:b0:1d8:aa64:8733 with SMTP id adf61e73a8af0-1d8bcf430edmr24601378637.26.1729053373032;
        Tue, 15 Oct 2024 21:36:13 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77518a76sm2189192b3a.220.2024.10.15.21.36.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Oct 2024 21:36:12 -0700 (PDT)
From: lizhe.67@bytedance.com
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com
Subject: [RFC 0/2] rwsem: introduce upgrade_read interface
Date: Wed, 16 Oct 2024 12:35:58 +0800
Message-ID: <20241016043600.35139-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Zhe <lizhe.67@bytedance.com>

In the current kernel rwsem implementation, there is an interface to
downgrade write lock to read lock, but there is no interface to upgrade
a read lock to write lock. This means that in order to acquire write
lock while holding read lock, we have to release the read lock first and
then acquire the write lock, which will introduce some troubles in
concurrent programming. This patch set provides the 'upgrade_read' interface
to solve this problem. This interface can change a read lock to a write
lock.

Li Zhe (2):
  rwsem: introduce upgrade_read interface
  khugepaged: use upgrade_read() to optimize collapse_huge_page

 include/linux/rwsem.h  |  1 +
 kernel/locking/rwsem.c | 87 ++++++++++++++++++++++++++++++++++++++++--
 mm/khugepaged.c        | 36 ++++++++---------
 3 files changed, 104 insertions(+), 20 deletions(-)

-- 
2.20.1


