Return-Path: <linux-kernel+bounces-524367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C682DA3E241
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6121118846F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD0D212B0B;
	Thu, 20 Feb 2025 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuVhM3hZ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8081FF1A7;
	Thu, 20 Feb 2025 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071951; cv=none; b=Xg5xGQ2R/I0+WkE+1JiorcimddgIQ0lhOhf3aTwFDDVuS9JmkEbqCwESOa+Az/sY0aFZuBjftEIzP8RU9TYgl6iy2oCh6q5sM5j67RRHfxFk2BG76f7igN0/pYX2wt2roNmyn96//lFBA2c7wAN7WbPCpikt4rUJi0XDm0294G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071951; c=relaxed/simple;
	bh=lbxp0U7nS6050w/dyFPx4V8itxpoYCb27lxROY6sU+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OG1cOq7aLnU2Lc2ekFlfFk2CaJc2ngzU5zN5rdZdIwDpQmfIQmPqy3zxc6SyGT8EPkAedO0nYyfjTDPq0U+cNLJKoWXCwhMwkcuVl9rhFz285xilVRXR8oLvHJXIDQ3fi4JSaUygpgfNbKDTCYAaQRFwGeNvN716eM8RbIQIoRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuVhM3hZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e6028214so26670675ad.0;
        Thu, 20 Feb 2025 09:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740071949; x=1740676749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nomDZP7UgjJM6LiqPmJ9pxSMIsyz19CUu75QblVwQ2E=;
        b=BuVhM3hZaD3sINTjebnYeoM/4q3FrbyZGQCFZhxvVBwfpNzyrB0i9oCxzZ/mtJglCB
         cRilem43V2Lz6t+CXN7os2E5GTLlybdWwYLZShaZuQWK6Bi7nMJKD8XyC15ckFd/X2z+
         E83Cips3kTeTnPnoQILhVk96A6rdqtwQJy6MMzedvTA3UHTz0B0ftKBdrxlb2r9MLl6k
         mBnNhwjoUg+GskFW0PefJYuoJoCieUZKElcWhwXkGlfU9cK4TOfzU+AZnw5R+jmvpCfX
         N+G7jHv8GdXd5VGdQeacozL9pPdupwIkF+spyp3givbOoj3To3yCqwofKqI3QIVmEXcd
         8YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740071949; x=1740676749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nomDZP7UgjJM6LiqPmJ9pxSMIsyz19CUu75QblVwQ2E=;
        b=nvAzVf7WrQ2DO89jDW/Y62nNiezHmBiFfPbDr4FXpwtd+BeGEA+92nYXOq2QoODgcL
         hL+IZgVu8G8vnQDETjZx1ls4rYR6J60e6+OxV6loFqAk438dS6QMWaWBZI8o6RhvXufr
         BEZ7x/Zp4CkTFJAmCCCRAOQB8v5bp+4FlDhYBzhtiLyvqoJ7iwN5ZLJjPpZygFL729Nl
         W+r85CTVSKvbqYrfbLXZVlQiZA7BPpL8zC6XyJr+ILtDYh/E2LkXlDcaTuK9mopdFiP1
         +UrM6KMUaqz3EFolUSvTrnwoiIJdEd6oU9vzwamzdE6v4pAP+bbhdo5K8ezZ+Fe07rqb
         nAOg==
X-Forwarded-Encrypted: i=1; AJvYcCUddVhOuDYJr6PFyII1UgK0GzUjeXplZWAtFdeEoTSFE3EFmaF0YhKhAG6sBMLF1F28w02ALr1gSzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHbWFCTpaZkodcmeWtfH0FbhlbJR5O5I1Yiht8mbN4tWfSuY4o
	JfZbT2K4JIWze7Yw8STB+WTRbZxtcU0K6oF+pgRWKC91Yj+JHhEKkkGKpO7FgPs=
X-Gm-Gg: ASbGnctJDcLKNQJLg2Ce+VFHdEJ3JHWV+l6ARhq5r2kh1YlzzX0B6nKHpLwO9tPAfGK
	SdQPyY4qLgSA99JEFL908NCB3z75WEZ91jWR9ALqcwpyrbwrSIx2M+gg1wPqAF4NkWoX2jK6QtK
	yiEssa86RObWVXEbSB5fQ+orZ2QZQ4Y4E2f2PNasR+tWfRYfo6Cnib0ZDrSQBcuOtetavV867C4
	HhRJo/DGEbFMMIdwZSykMniolOc6S8cywNuGWgN4anu+u2Tws6Jp39nHj7iW9phU26LycP/dDvB
	8Rq99B+IgOnCLKyCz16ulohI
X-Google-Smtp-Source: AGHT+IGeGn7sAE0oh/LEmZ0Q9vohZZx4LORYi7li2Q40VP3JZ4WbLcXqVZcaR3HNoxG0ukBcPdb44w==
X-Received: by 2002:a05:6a00:2e16:b0:730:927c:d451 with SMTP id d2e1a72fcca58-73417382ba1mr4907029b3a.20.1740071949258;
        Thu, 20 Feb 2025 09:19:09 -0800 (PST)
Received: from archlinux.nitk.ac.in ([2400:4f20:11:c00::101:920a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e324sm14101963b3a.88.2025.02.20.09.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:19:08 -0800 (PST)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: corbet@lwn.net,
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] docs: debugfs: fix spelling of "failure"
Date: Thu, 20 Feb 2025 22:49:03 +0530
Message-ID: <20250220171903.11321-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in debugfs documentation where "failure" was misspelled 
as "failuer".

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 Documentation/filesystems/debugfs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
index f7f977ffbf8d..610f718ef8b5 100644
--- a/Documentation/filesystems/debugfs.rst
+++ b/Documentation/filesystems/debugfs.rst
@@ -220,7 +220,7 @@ There are a couple of other directory-oriented helper functions::
 
 A call to debugfs_change_name() will give a new name to an existing debugfs
 file, always in the same directory.  The new_name must not exist prior
-to the call; the return value is 0 on success and -E... on failuer.
+to the call; the return value is 0 on success and -E... on failure.
 Symbolic links can be created with debugfs_create_symlink().
 
 There is one important thing that all debugfs users must take into account:
-- 
2.48.1


