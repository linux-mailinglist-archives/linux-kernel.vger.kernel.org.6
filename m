Return-Path: <linux-kernel+bounces-227742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FFF915616
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA70628D198
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD7E19FA60;
	Mon, 24 Jun 2024 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="kWxtNnQa"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC119E822
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251947; cv=none; b=PQI1Z8VcZAswZGTIAQW1LNQ7AxjDGBpww8ydKafopvwKQ0xL+kMMGYtRSRqbg25e1ByakP3ERC3HrVEKcwimGqZM+kd1EByA9kd6twFTeOgxXivZmIywvJYOKkWG/NYum97Yox4PvsuL4ByjtTcnPzCZDtmcBrnqetRruRNA6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251947; c=relaxed/simple;
	bh=zkhh0W7So/DmsEzPKSMH58KDs1LV82zcrId2pWGoAMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNG2zNNkpt8qoAsvZ5nbHfcbX7fLjQJLCUhGnkNLvqOWGUNV9oQuKin1Fv0Tb1cOCvM3VpuAxWf7N4lxKpbzUQg6Y7nSgnVNOR+OMqLKTWAsG1Cen0Yzq/T6KpXlQb8zdad5D/wkK+giigiBGmKHeiHeDql9FQgmdoIIOyP5Z6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=kWxtNnQa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70656b43fd4so2373117b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719251945; x=1719856745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bUkG7WPXxoFCKENTQnYrOokr0PwEX3Pguw8rWa7FZAs=;
        b=kWxtNnQanH8AWK79/BVJ5QnOP81vs2flmoBh7J5X0yTxVPGTvivvvylJZn/aCIJjHG
         wVSwR3CzKUjbTvyp+vNywltGFT5sXHuFFGfhBBqnEhAGoc2QNGdyEAMtN8y00mKvafOF
         h4syRyPeV1+n7QwfdYmwG8Xl4tFq9gvN2zgNtM18ARE/gnG0mu29wOC+5D7yJEa+Phpe
         jLLmpNg1ZxL/iVyN7CCS1CkNhR6NZekzAakU1l3kc+lSVvKCUtlnWt6XfBugZPC7gwc9
         AHet6ac3Cl9rt17EdsBo3n8P1NKVVlIzZSMWFk2fsktdSqkD/qYgoV32efpkR0OdaGqQ
         ZNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719251945; x=1719856745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUkG7WPXxoFCKENTQnYrOokr0PwEX3Pguw8rWa7FZAs=;
        b=llVuwCLRozKfFIn22ZGuafQNhplkJ159n0o78aMC8RY0IwGGY28g35vvwKlIRNzNu6
         pfpAHNaEgNpSnPBO4ZwCoxvGpLPExVJiehCNaQU1ah2J3ErpR/9l5wf95Uft22YPN2ND
         zcyTaoUKqOgCkQE78gSTslhJC7J+nB1Xm8bP65o5BQwv/IdfavJ/uJjydbNkIX039e5C
         csKXxnGuyEZlm3+E2XWgP+h2FKVDoyUNi+RMPGWGi1ZCItJGnbc/x+6gYJ+a/JvY8YSY
         LVROUSZWbhdPW6IJPCI4NTq/Aq1ipqOz5iqxcAi0Py+jqpAmzLEzTQnxDjkFVtqzz6pL
         iu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlbmUaV7wiBHO+kzqe/lYEIkxhsmb5uDkNkj/2AD1aYABoNx8Te+8qb4uXUYvCP/8QJojQg+DYQ2FCXoVhhZWuVAhlaZPk4r2XTeO5
X-Gm-Message-State: AOJu0YzjErKiXVrdt//iIawtU8Nfv7SzxxKBw7JdTo4gYJsUHQVP+XhP
	xycRtixbvTBwQlM9gFUsluGuneA148I7V+xLsl7owkv1YgE8v8dM4mg4mVUIbpw=
X-Google-Smtp-Source: AGHT+IFoTWqQll6E4ip1TtGr7Dbwsic1VXI2sT9nSLcFoaZZInI906/i2cJjCWfXScsnv9zLaHJ7JA==
X-Received: by 2002:a05:6a20:8908:b0:1b5:3ffc:b3c9 with SMTP id adf61e73a8af0-1bcf7e2a56amr4065302637.13.1719251945206;
        Mon, 24 Jun 2024 10:59:05 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7067bc13770sm2868633b3a.56.2024.06.24.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 10:59:04 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: elver@google.com,
	dvyukov@google.com
Cc: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] kcsan: Use min() to fix Coccinelle warning
Date: Mon, 24 Jun 2024 19:57:28 +0200
Message-ID: <20240624175727.88012-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
minmax.cocci:

	WARNING opportunity for min()

Use const size_t instead of int for the result of min().

Compile-tested with CONFIG_KCSAN=y.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Add const and remove redundant parentheses as suggested by Marco Elver
---
 kernel/kcsan/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 1d1d1b0e4248..53b21ae30e00 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -225,7 +225,7 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 {
 	char kbuf[KSYM_NAME_LEN];
 	char *arg;
-	int read_len = count < (sizeof(kbuf) - 1) ? count : (sizeof(kbuf) - 1);
+	const size_t read_len = min(count, sizeof(kbuf) - 1);
 
 	if (copy_from_user(kbuf, buf, read_len))
 		return -EFAULT;
-- 
2.45.2


