Return-Path: <linux-kernel+bounces-567882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 174B1A68B67
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE3137A44AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9874925522F;
	Wed, 19 Mar 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="aUBE+dtp"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477920C480
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383457; cv=none; b=KGwiWZVO3PyQuAb9weBlOJIow2BHdPxVOS5y1uNLud/TPK37Njj7Vvzqcl4SyHZ+Hkjhhff8tSaGL/u+g5AWgGHdQEbh1DukmobCDx42QOI8BySLGUgA4D2k6PbNEu6akatRI+kkN6dzjjnGJ9AaSg9ZFWoi0b9QoKhd7C/cYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383457; c=relaxed/simple;
	bh=vKkl9RE5EwEBFLtLPUlfSUx26PfPlZrX+Blb5dbT/C0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ig5f9d6DJ3CVbwlMj+0fahNV2NEUynurbvS1sMcDO8BWtt5s/76tPwUqMDIDDZO8MBMhbUh8Y4bYzKjuFFdCDTUB0HWlafTZTONkBzFWKeJx5gAI9TyXpADZNXKOhRrYQf1J3VkV1Yqq40E5ACsabASszI8jmh4409kkKov2v2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=aUBE+dtp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2241053582dso33286295ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742383455; x=1742988255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZvnuJrKt9TGuvAge2fzG7AvTvxdXtsSJqic522bGGA=;
        b=aUBE+dtpGvUlRQwt4d8VdA5uptO68I5pFyPKrCfXoY6NbDN70a0Op9CjuMrWhOtUN6
         inEY1+976vbuLP3lM1XPKSr7jtVopyungZJ86CQKyM3o+OmGuYMMCGWYe9qMnFAR3OBb
         MSda/TSodFJzqsC+8m3KvrJodWq2tKHA94Cbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383455; x=1742988255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZvnuJrKt9TGuvAge2fzG7AvTvxdXtsSJqic522bGGA=;
        b=DvHXHQe5XEV2thguHEbfJq1o3ecLFJq7i6WE3YG6SS+OiYRzutEkL1kDG43Q1e4USQ
         /39JL8hUF+Hz/GmWIpbTsEg6fWgqsLLuki8VOkkxDACDtdGwy8okoK9/e7GCE8I/2a59
         +Qlu1jZhghFon0BaDY0oXDivhR6JW1DegVgENftDsgx6DA+YzinapV+fjS4FA7oZCNjB
         mzRVGfxvO/YnUGEGYZePIJto86ZBePsvcZ5dZxXttCSzRVn1zBnBTHjQHM29Px6i5i6i
         /+IjIj6NOyzwskPgagrUFTOw0AZTILYYe1PZ5sii8FHRIcTGKCQY+eu/pdss7ClJ7BLh
         PSow==
X-Forwarded-Encrypted: i=1; AJvYcCU7n0lJ3FpwbPjPav66cLzS8AvHQa0M4UDVmifCydk9se/WENHz4iIthqZLVhyCa/TDMw68KZPQDxFumf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeMX7qwbvOsZDIK7IcI70YuFdRyC5/7CrfqI7fTiUBU2TeI6Ng
	hehblF9ovdu1kNcj3JQH5oimntFAUHP1eI3VziirxeSgZhWhUcOplwyyVV7v6pA=
X-Gm-Gg: ASbGncuWsWf7yBTGeIqCPomZYQc5oiIDZGsgJoInJDeNrBnhsaMJ3MXfS+VUSDyhWTm
	uQubB5sJA4DVVUzbfHDzgudpy6FlXekDuEo6ui168icNxntw8fRpmw+burGqChCPvGcL9m/JmkC
	aO5yTyGRP/dpeEVZ7oUVMoOeklZJUSZKLlLbtdJwiGsn9DEZHwmDiJ0DXKGp6WwKJo+MBwQSm3r
	tsAFexXyttzaPDrxrLkCAJFHARbYjXk+RveFziME1g204pL3eSaIGPYquRwJQ3K+LAhF4x/O8qY
	dV6VL5D0j/8ypgLvUdD7M9TREes7H1TEfZfkStew/pWWP43CEkptE6OKqmhFVfvqlF4x9tAAv1e
	fB25glcUa+o2b4mg=
X-Google-Smtp-Source: AGHT+IHhLaPon9yGAlr+vvdISzeAeLbAmh8UYYNWjbtERsSGvsF20JUu0H7aaQVQFG458JsbhtpC6Q==
X-Received: by 2002:a17:902:eb81:b0:224:1781:a947 with SMTP id d9443c01a7336-226499280d0mr43847995ad.21.1742383454604;
        Wed, 19 Mar 2025 04:24:14 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6d5dsm111605955ad.153.2025.03.19.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:24:14 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Mark Harmstone <maharmstone@meta.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH 1/1] btrfs: ioctl: don't free iov when -EAGAIN in uring encoded read
Date: Wed, 19 Mar 2025 11:24:01 +0000
Message-ID: <20250319112401.22316-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a bug on encoded_read. In btrfs_uring_encoded_read(),
btrfs_encoded_read could return -EAGAIN when receiving requests concurrently.
And data->iov goes to out_free and it freed and return -EAGAIN. io-uring
subsystem would call it again and it doesn't reset data. And data->iov
freed and iov_iter reference it. iov_iter would be used in
btrfs_uring_read_finished() and could be raise memory bug.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c44e6ce6e5f5..b556db9e7cc4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4924,6 +4924,9 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 
 	ret = btrfs_encoded_read(&kiocb, &data->iter, &data->args, &cached_state,
 				 &disk_bytenr, &disk_io_size);
+
+	if (ret == -EAGAIN)
+		goto out_acct;
 	if (ret < 0 && ret != -EIOCBQUEUED)
 		goto out_free;
 
-- 
2.43.0


