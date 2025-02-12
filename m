Return-Path: <linux-kernel+bounces-510389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84B6A31C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687AC3A3FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3531CD1E1;
	Wed, 12 Feb 2025 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+b/MQTg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58504288B1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327725; cv=none; b=IEXpxXA7ruOo5YlmlJJ/VftcrbV+mKtXibkooKmgIQ1kg26BTJ8+D8ZVTRMlpTayQTNAKMM/BO8Ph7E0h3UOHoDBzd0omjK17rbP4kkKVHwjlx2qNRIzO5ae6Zcwtn+O2D/WEPoaw3L5rd5BTALvwTw0AqGUiXp8ypn1NUtwJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327725; c=relaxed/simple;
	bh=4k8gRvSUnnFtDJKlgB+W3NkTIdMqjf/Wnhl/MOXYQeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eiw1wrrshMfQmnhYWwEvD5vHpdD5UxErbx+1fGoypWfXovd7Gled1nmoqfp7I2wLIyvLlOvUkpUAww4FG7NjLM2FvOzLpMaX+sv/Ge9bzj8YuZQ7WOw4//0qOojozqzXqlbdO7HGoQOU3Z7/94Z0MYZhXD/+GQD9MLw6c02YorY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+b/MQTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B484C4CEDD;
	Wed, 12 Feb 2025 02:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739327724;
	bh=4k8gRvSUnnFtDJKlgB+W3NkTIdMqjf/Wnhl/MOXYQeQ=;
	h=From:To:Cc:Subject:Date:From;
	b=V+b/MQTg67xmsPuQDXNdM++t3OKZ98motiv0JlCIT+PJ113nIdoII8XZ4s1rr3PQS
	 KUiISdPADo/mZnv6lKk+bvy49kBjZREtppBe57iz/49lfwSVsQzVT3t5RdyZgvl3g7
	 rSDvGfKpCeq2+yCnVuaiSeuJPrea6EGlzWqlA8YHy3XD9LyNn+kfog6feOzDYYl4JG
	 XM0yKmtetmrjPEbpRdaoMctebfrCLuZo1yPvyQZpYuyBg6iTEOHE5/BR/mpK6U7zQo
	 qYx7CA5Q1dcr7pak39X7zefiKHE2TTmlW5mEySAiqABBZNpbO0dsdvOhGy1CI7OI7t
	 nFMCQzlU+Ml7Q==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 0/2 v9] reclaim file-backed pages given POSIX_FADV_NOREUSE
Date: Wed, 12 Feb 2025 02:31:55 +0000
Message-ID: <20250212023518.897942-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series does not add new API, but implements POSIX_FADV_NOREUSE where
it keeps the page ranges in the f2fs superblock and add a way for users to
reclaim the pages manually.

Change log from v8:
 - remove new APIs, but use fadvise(POSIX_FADV_NOREUSE)

Jaegeuk Kim (2):
  f2fs: keep POSIX_FADV_NOREUSE ranges
  f2fs: add a sysfs entry to reclaim POSIX_FADV_NOREUSE pages

 Documentation/ABI/testing/sysfs-fs-f2fs |  7 ++
 fs/f2fs/debug.c                         |  3 +
 fs/f2fs/f2fs.h                          | 14 +++-
 fs/f2fs/file.c                          | 60 +++++++++++++++--
 fs/f2fs/inode.c                         | 14 ++++
 fs/f2fs/shrinker.c                      | 90 +++++++++++++++++++++++++
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         | 63 +++++++++++++++++
 8 files changed, 246 insertions(+), 6 deletions(-)

-- 
2.48.1.601.g30ceb7b040-goog


