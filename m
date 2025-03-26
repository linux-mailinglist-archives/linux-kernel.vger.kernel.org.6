Return-Path: <linux-kernel+bounces-577321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADABA71B81
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0381D1892326
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165AF1F55E0;
	Wed, 26 Mar 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="J5CbCd7I"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9F1F4E21
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743005056; cv=none; b=ZxV8k7036qya7hBgyJxgJ98ek3Wa3CW9rWX28bygY1zoK5DGA6x9pMkmzUx7PykXSTcLuFaFIO1rEtP+8zof+MhaPDol8Qm0f/Lw/qffS62dKbUJzSud9P6HbKNStgGSwFUPrUKT/U8aF3UyTE5rclFM0xzMlKFITJQigF9rPII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743005056; c=relaxed/simple;
	bh=oqYKM1ZpqC7RtfF7IzC0cixXHyD/NT9TgSDoB1yKb90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aohzGmj1DlCqf6L3cveGRkUBwYBjjITl19TrfO9kSE8tIH8N86T77hGT8PC+JyLEPycD7FpiD1g1KJBk9i2lm5k2LqNphRd+sDAECxyDOvY6QmvNHqboavqM5CsOsr0LUsqzQuXSU2FuCR1cy3Q2WITRE1JelGdiB+L5vqGTAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=J5CbCd7I; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2243803b776so1855465ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1743005054; x=1743609854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V92Mcu6ROGqDUYrr0Vu3d5f14OfoLPIUJ7IhtsUxhlQ=;
        b=J5CbCd7IhHSd5Doa2D3yEmNf2yBrzCT9957Q1N/HEdy+tC6KpSCHIWZLnF5XyAstxb
         jG4XXMbGvCCdv9p97UmuLfsTnPMVonYwr5lPd+77pxWEhV0bJa89bJVzLN0gtn8vWHY3
         KhIQRzM56xdA5BQnMWiCSiwDohx6qDIHCwv9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743005054; x=1743609854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V92Mcu6ROGqDUYrr0Vu3d5f14OfoLPIUJ7IhtsUxhlQ=;
        b=sbmUA79dhHEcjeSEqshxcQPqwi5iFzIjZ1ABlKT9mD33RnNVVDUiKaK7YOOpBDw1Ks
         LTsIFe83l5Mz6dPNI0IpAhHw5WvUJER09n7oW071hY+4PfDIAkmcd0T83QY24K4H/gz2
         5pF4rCWiJFFOwIDfzQUeJ65+S5R37yJW0tY7iTAPR9UowQ5NMbhUuVOGLLQIiVERj+K4
         ELNuvt8Z06eFHwprydY50/S+50xXfI4I6SXigSo/A1qtNQkIaa23S9sefpxRlRKK4qOy
         dAH8uFJ6/BQNZPJhFS5m8utKSED9pIA9B720ri7ZRx6kqUcFNaPxPO0k177XsbDS0ngB
         bF0g==
X-Forwarded-Encrypted: i=1; AJvYcCXA71ewHOwazYF53NCj26p2mBx/FfS6HhVXopF/5pBWF+dKbGL1oANTzOMjz3nSJnfwUfKVGx2BKUb+ce0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEobW9NiQ9BFvU5ybLTdowpUyx0vs01j1PKjCUwD6hRY8GK0P3
	Sqx54wNCJH7SL26tILSiSFsx/gDJqMReJElxdG2oT2HyQepLYfGmzaadR9Vut14=
X-Gm-Gg: ASbGncugych2mZdWPp6F7/r7tRcfTeUgf6OG+idoo+mXiVeX8z1PSOTCF6WK6PSUOez
	MY6rcjjesoUbL2Mqvwf787AlX7g88vPy5YHG8ufVDGabdPfyXTRM9B2Tmf/ejcm9Z38eAwfwql2
	SrjrnRBlhnjCteaYJRs3xt9gzev8NrNCJh4uSlLfvq1Iigure6kx4UrUEcIxBj98AncTTTVlc2Z
	57AsHq4Q0NTCoGvFuWzUrfVAgqaZtoyYcM32TSVrYYgilXFzcPbQ5fPpzIzVtaGv75uF6UlWTBz
	uHl637K2NKM8TvE14s1tF/7YTyxFZcXdz7OplPE3S4mAbrgBzcO7b4H//PBq6+8zD0EaEPIoxWy
	sJfrc
X-Google-Smtp-Source: AGHT+IHW8xu1XUEic/d8MMjR4RQnRgGFxBNA9gZny8EZQSOeF0ZVLLhc++6oIw8DXemWvzAssm4PLg==
X-Received: by 2002:a05:6a00:180b:b0:736:6d4d:ffa6 with SMTP id d2e1a72fcca58-739610a4c99mr141933b3a.15.1743005054274;
        Wed, 26 Mar 2025 09:04:14 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73907b36bfasm12217947b3a.2.2025.03.26.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:04:13 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH 6.13] btrfs: ioctl: error on fixed buffer flag for io-uring cmd
Date: Wed, 26 Mar 2025 16:03:51 +0000
Message-ID: <20250326160351.612359-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the io-uring fixed buffer cmd flag is silently dismissed,
even though it does not work. This patch returns an error when the flag
is set, making it clear that operation is not supported.

Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
Cc: stable@vger.kernel.org
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4d9305fa37a8..98d99f2f7926 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4906,6 +4906,12 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 		ret = -EPERM;
 		goto out_acct;
 	}
+
+	if (cmd->flags & IORING_URING_CMD_FIXED) {
+		ret = -EOPNOTSUPP;
+		goto out_acct;
+	}
+
 	file = cmd->file;
 	inode = BTRFS_I(file->f_inode);
 	fs_info = inode->root->fs_info;
-- 
2.43.0


