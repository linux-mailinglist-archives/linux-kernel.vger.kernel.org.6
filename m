Return-Path: <linux-kernel+bounces-383613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DBD9B1E04
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9DB1C20A9A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C6616F282;
	Sun, 27 Oct 2024 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZTVVR2C"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0977B16B3B7;
	Sun, 27 Oct 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730037992; cv=none; b=US76GkpQb7mk+VX7Ys+ZJqnPdBZLN7WGISsmucIx7jL4+hzRFWRYLyWo7jqLsiEaGPU6TJiQgkZdPoSILoP+H9T4mQbn7lvy8tu03XluvWKZlXAd9yBoFovygs9nlL9dfsbwEKcGAdg9f+UJr2yiGPHfmVq2gVWg0bqSymp/2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730037992; c=relaxed/simple;
	bh=DlNqd9z2/ZM2XeHgclPgzwfuQVlBcaEE++IuuvdtZHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DdzkxYrY4TkSSq2JLmCtyUQ/Axg2GUjbZ3aEd++7eQH6W2uq4OMlDVbFfqmWYK9VCEXAfJfFQerp2acVIlIjWtuXrflxNO1ZdmAFhRmp74XlkfYGh9o/h2b7LQjdT3XHGfC08Z+eqCtjNbmnrQWHpkLRq08ZBPtYJUf4/Ax6Dpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZTVVR2C; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so2625745f8f.1;
        Sun, 27 Oct 2024 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730037988; x=1730642788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ciP5PqyHVqbZ4ar5lDSwgDPW/+/+QdOUjUbcyphWzWE=;
        b=HZTVVR2CS7eOBP+K8+FWun+zIY3aFqWaUE93mGd+Y9VEenlY0lxDOzmRqw9KT9ty02
         WybdAJxwyILupsMUWOGRaMYGEMM/9SizZX6hIvzTNQyTpCMBefSQmol/47HZ6148md5i
         z3ue/KUSnsrrvpNznmbjgR0driK9Nw1E3RhaQ13DkneaQD5BAdkRkNKKCwvidJG8IeWu
         xrKgSZAMOv4Tm6W2Gepu/8I/4MsmviikcpmUVqmbKipHGNLTUvnQPfWMI88lGAe20NZk
         zBKzp0DQYWdwnteIlXuBnWSoVwVkM2ixQK/S4qTyJVu7Fbk+YE60NMxDkgSuyDb0obgZ
         IYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730037988; x=1730642788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciP5PqyHVqbZ4ar5lDSwgDPW/+/+QdOUjUbcyphWzWE=;
        b=IkQ5UbR3oE0885XbvnWZUzpJYzX1dL7iWCxonaotMnTTViIXzP7qneSI38bvTlR34G
         nIvGFrSXGJJAPDlLlRSLJgDHa4OGy2mGJB7zSDFpJpcUG06PWKR6UyOdIPmLJrNpTOkS
         8GFmCDwbMOHfChP2LA4dWdE+IUbPAcj3CqHs0dGgLR4nzb7NL+lSRx76EuEThQmHfJ17
         4XZMnOG2mDiHrZKxHcXo+fE/h+xlFgOfl4eUxxS5xRJbbCphLg49EUg4td2ZLV+BIEPB
         WjSfRlXON5zbvHdeutDwmNtNBs9mVaqRjetX8npi4odjzdoc9ajzc9dxj9U1uzFlYWu9
         R3dg==
X-Forwarded-Encrypted: i=1; AJvYcCV01Kw/ZDMftkBSheuOituNYqTCEPkfYGiV8homRwuzOM8fAYuxMEuChf4qEE/mK3r64olV1TYAgd3ClEr14T0=@vger.kernel.org, AJvYcCWuBlNepppttICfT7al6ZurlcKsRb6NwveGp34I3WIfQCG251yLyFQXoc2wH/zUs1IrAGN8JIqf+a88iHBk@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMyM/67X9by6/iDYqt5pm9vli3CFsRQEgEMf0GiuQNifpAjnx
	aIVteoe7NPwCBCvsdI3v8NrnQE4PEBrwahaL7TWVpjFQMnriQs5c
X-Google-Smtp-Source: AGHT+IGa9wvaZ5QuHXadDbtM1Tfk0wq1icLe9dx7brgIhawTZ5Q9vy/wi9r4O8n+YU+MyNdylirWTA==
X-Received: by 2002:adf:f050:0:b0:37d:4657:ea78 with SMTP id ffacd0b85a97d-380611f5b86mr4049920f8f.54.1730037988207;
        Sun, 27 Oct 2024 07:06:28 -0700 (PDT)
Received: from void.void ([141.226.10.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9d70fsm6871843f8f.108.2024.10.27.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:06:28 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] f2fs: fix typos
Date: Sun, 27 Oct 2024 16:06:08 +0200
Message-ID: <20241027140623.24802-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.0.149.g3e3ac46130
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos: datas -> data.

Via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 fs/f2fs/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 546b8ba91261..9dfb577d695b 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -598,9 +598,9 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->ndirty_node, si->node_pages);
 		seq_printf(s, "  - dents: %4d in dirs:%4d (%4d)\n",
 			   si->ndirty_dent, si->ndirty_dirs, si->ndirty_all);
-		seq_printf(s, "  - datas: %4d in files:%4d\n",
+		seq_printf(s, "  - data: %4d in files:%4d\n",
 			   si->ndirty_data, si->ndirty_files);
-		seq_printf(s, "  - quota datas: %4d in quota files:%4d\n",
+		seq_printf(s, "  - quota data: %4d in quota files:%4d\n",
 			   si->ndirty_qdata, si->nquota_files);
 		seq_printf(s, "  - meta: %4d in %4d\n",
 			   si->ndirty_meta, si->meta_pages);
-- 
2.47.0.149.g3e3ac46130


