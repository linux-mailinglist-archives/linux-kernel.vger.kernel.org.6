Return-Path: <linux-kernel+bounces-320033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6032897053E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDFE1C215E7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E5D5338D;
	Sun,  8 Sep 2024 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhhoRGfj"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE21C6B2
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725776826; cv=none; b=BF1lhE3B9PYHbosJZN7IZN39wi7pLLzvYmqzsF0edZkq5GNb89UIgexkZH9mHQlosr/OaB8yricOIXqkHKEAQRECOrYB2ch0lOSbTpRtxVsqPb2DO4q1o+zTAX1z79G+oKbxjRQCrpozZUyFydmjuu5VRdPKQxEnUikrADfSPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725776826; c=relaxed/simple;
	bh=qpF9T31Hf9GFMUi/eIny+a7TlMMvnd3LEWvQkYOmW4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W5lMUDXMtN7eanNdLwQv0/Nx7238sG6i2y2Jktrx5e1M8KVnn2a3KoYR2EJoLjUe589aHOXaARuBa/TzkaRqhXN9apjlQaeWnPbmvWQSX9okGdJzEFxKCQUp2HMhhvFBM9TtfkwEXItFElvD1hkUPDmMuW/Nt3BVYpGrHFR2NSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhhoRGfj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so66685b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 23:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725776824; x=1726381624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nTSZxeatMRv/4rTpSqZ6nnLY4DQTOXBFlaSMm6/gKyU=;
        b=QhhoRGfjTNbJoBiRqRRXdmQ6PYvkp4/IBDMC6iDdUc2O7uqDMNiD2ERTVqxdS9PZDL
         0AGiBrTwX+rAg0GmqLiUQyb/KnGhyc/DI7yRlAK0TLnenJoPUv1jJLFmWkrS2KRLMxi7
         vJOIVzITMgPrhBzymdoQbcaFAFvwBUCfwWrBpm7ds1rcf82xcytVb2W6iGc+UHL/7B27
         SnCaAwuVcnGeu7f/+ogyMSdMWTTsMqZggjtTvb4ia8jFi9V+JOV14wZlrZs4rQGSaMi0
         5NvYI8ZqnLLxVal0asLCP8nHuuCo36bJ7SgFWvxGqAcnd3wQF23R2lWzUMWoTIUpZH2P
         jiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725776824; x=1726381624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTSZxeatMRv/4rTpSqZ6nnLY4DQTOXBFlaSMm6/gKyU=;
        b=XV1mNwz/yCOqgZ33ageLd5PL4nh14vzB0prxKgvitXexDw8WrA4IUlyHHf7CdW7QF8
         skvD0jpcGw/4clUbdbklJ+nC2mCr/6wjJTHk4D87/uqbmVz1Fd4JBnEhLzuT8VZBKMmj
         KIz/9LWtSC1/oFOm0KJqMJAXKOo4T5ACLg6fLkhX6C4GnThiTE6ygW/FMVd1soQBM86C
         XTJmv30FOwpdR4o4KRdozPK6SdE9WPZ2VY48P2HtMN2dJEL6LMoecSaNusR6NUxOA0mD
         2LVwF4nTqWqPDHKbVl5EJfrGOEHXXulzouwoDMd2r4LmFVEUbbjiLSvASDY8lnfISDV3
         s/jA==
X-Gm-Message-State: AOJu0YwzRFRy8zzq2gpkKyBRJw0ud5fUdxxx2ZnzNhsKDhM+3UwEdZvP
	3rLTTmmsfdIRHK4oJZ7v9zg63VT0HVhf4N3Kn4BqJOnG3XKLcHQk
X-Google-Smtp-Source: AGHT+IHutKOify0mo8NpVhR9nKKvDBe86/1l0FB77CAJSm9wIutm15S/r7RH5EwWvqhQ5VX5q6rIEA==
X-Received: by 2002:a05:6a00:3e25:b0:718:ddd9:a8fa with SMTP id d2e1a72fcca58-718e33a306fmr4961861b3a.16.1725776824181;
        Sat, 07 Sep 2024 23:27:04 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e59687cbsm1651108b3a.115.2024.09.07.23.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 23:27:03 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Sun,  8 Sep 2024 15:27:01 +0900
Message-Id: <20240908062701.7906-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/ext4/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..8cc5e19bfe78 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -346,7 +346,7 @@ __u32 ext4_free_group_clusters(struct super_block *sb,
 __u32 ext4_free_inodes_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_inodes_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_free_inodes_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
 		 (__u32)le16_to_cpu(bg->bg_free_inodes_count_hi) << 16 : 0);
 }
@@ -402,7 +402,7 @@ void ext4_free_group_clusters_set(struct super_block *sb,
 void ext4_free_inodes_set(struct super_block *sb,
 			  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_free_inodes_count_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_free_inodes_count_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
 		bg->bg_free_inodes_count_hi = cpu_to_le16(count >> 16);
 }
--

