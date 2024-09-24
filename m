Return-Path: <linux-kernel+bounces-336547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A22983C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F7C1F21E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD2D364A9;
	Tue, 24 Sep 2024 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A95w6+Pp"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B648C07
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727154247; cv=none; b=lidBmcVJzdbWg3TYZLBw8fFkgM7pAVZVjU1+4nGuFYjndNvSn211igblFSCg1GPmFJg3uGGH1Z0uIOpGJqmWAzDRL6zPO4sshR0lfNaaPzoJnNTEQks/WnowEBjCUZ0hdM+xg5qzG103qfeCiko5nokD/1gCMoRXR8I19QM1GM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727154247; c=relaxed/simple;
	bh=LbmQ3b5IVzHyM5ry4uBW+x6fNv7Im8623G918HDd1j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNeXPeCiwAGFRBeVORLPG1MUZcjTgvhEZkitBnFg/H6A9eWjqwHpg5tj8j3tBRApzHvBvsdJHfA5VnDwNXth7Lour0mIxtHyRKPJWMeK7rvkTMhQtma3syFxvUtaLhaKLOXlgqyDVgDtvDbUvy9Uf2hfeBoazV4S3cryDkusosw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A95w6+Pp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-208e0a021cfso25095015ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727154245; x=1727759045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLJ5WI969Bj6yA6sCRRbXyrdJGNqv2GF6Kj0cnNoy4A=;
        b=A95w6+PpMXMJv3qhjRgqE356EXZnLxIm6KWk6xvbnkzBF0zzoLNkaXTGZj5LhNyD/s
         bv2FWvuqLDXBxAx14XnqZf7Vow88nMHYiQd0jqrEsFoYCbLb4cMbKUADbUxIMtJUUi+x
         6gF/6UutoQbrxEuilQ2uKs7+NL+RS/azUrwLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727154245; x=1727759045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLJ5WI969Bj6yA6sCRRbXyrdJGNqv2GF6Kj0cnNoy4A=;
        b=jUnBbsih7/aw2wZu6FAFjmJ33tw0Kt6alXVdtKv3uuavOh7TUxqZDd/W9lTM9JTLSM
         X6sT2wjd4TsIw4Ya8PtNx4FB5e9KO48EK8pLBlm3/whmz/NsXHHAFAV8oI7fEBUjHsMf
         QwtYPCPS9UhU5qjjMnQKDvIpBLjOv5oxMwE/U2RaB5AlStm+1H0YeBHrToVIVrNBoTSA
         VoBokrEZueS9GeP99jlSbjDqvapiBqEumGk04FQTdr9ZgGuubVmu9b0WDR18vAqH3Uym
         bKgDh9+udf+mpIhI8PtMxvhziN/ecUoQ0YADkt6+4s3dMI8hNwTGZG8vCS2moG0DTTyL
         8XCQ==
X-Forwarded-Encrypted: i=1; AJvYcCViAL//IlSBOJpnzlxVcQ5gir/kyu9oUTGO2BvBj2oH9wWfC2Ddt6o71gsK4IzhRg2o3/rGYfYijh/SMCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe+6MIkwNJasIRNkwghfAWcBHbZbS1T+4p4IanRW0d6aS0UmXn
	h4si31Dl0KEztH5vmeN+iqjK/LSN4B0A5jaq7fs9xnJwG6VLFt8tVwNXo1wRzSOif+qHW/wmgik
	=
X-Google-Smtp-Source: AGHT+IEmqF59X1U6RjeV0z7JoukgmX889Wfbwd82PVcwrsFHNG4CW+23hMpir0OupyftkvM1cYIyQg==
X-Received: by 2002:a17:90a:ac02:b0:2c9:a3d4:f044 with SMTP id 98e67ed59e1d1-2dd7f3e13b5mr18529586a91.11.1727154245492;
        Mon, 23 Sep 2024 22:04:05 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e058f0a295sm518053a91.13.2024.09.23.22.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 22:04:04 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Andrzej Hajda <a.hajda@samsung.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] mm: do not export const kfree and kstrdup variants
Date: Tue, 24 Sep 2024 14:03:42 +0900
Message-ID: <20240924050351.675925-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both kfree_const() and kstrdup_const() use __start_rodata
and __end_rodata, which do not work for modules.  This is
especially important for kfree_const().  Stop exporting
these functions, as they cannot be used in the modules.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/util.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 4f1275023eb7..aecdc04652c5 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -42,7 +42,6 @@ void kfree_const(const void *x)
 	if (!is_kernel_rodata((unsigned long)x))
 		kfree(x);
 }
-EXPORT_SYMBOL(kfree_const);
 
 /**
  * kstrdup - allocate space for and copy an existing string
-- 
2.46.0.792.g87dc391469-goog


