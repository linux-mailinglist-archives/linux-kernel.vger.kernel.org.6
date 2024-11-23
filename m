Return-Path: <linux-kernel+bounces-419051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1C19D68F0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21394281D43
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8792017333D;
	Sat, 23 Nov 2024 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACNfn0qE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F6A95C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732362718; cv=none; b=oT36/R7Kw3IQvT/Joy/eiq+MSc2HX33AKbgv3ZkxRztQ7Mlpwjuqj75rVDgh5iOnlHf13yqdIxaU4l1CHjI2v+K+IWLXp0rROYJWWSRlTBOGdsTs6HxEcY+b/iVCRqzceRa1X/vGEsEAmP4jxnhPMhjIIIA1ome+I8HuPvzyuXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732362718; c=relaxed/simple;
	bh=+e8CA6CFuOnsFvQL/VTzInW6gkXoswAQ/X7g97zdGhc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RXdGw4diWcVK6o5CagsjT0pYh+yE828JtGETIRmqTWItTAFN58oNmR6vP9Z7O2/XGR1lcwMF8CWPsN3MKzC/tes2iMl9CicW/gouT3GbkLyXJvAD3dBgBVkB0hiORxbHEniTnj/6Xpkuam72QJ9+ypLiyJHo8xLfPrryNIo/tRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACNfn0qE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21260cfc918so21993365ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 03:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732362715; x=1732967515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sM+NR1R7uTx0PmhnmObK9Bg+qdRFNdiJn47imK1IWGs=;
        b=ACNfn0qEXUpZQpnRXaIi50y3KrcJqBXzPxKbdZ3AgJfngvZDjGd1g4v5qhGXLh4mUt
         SZow2gZTSbeviBlKiJLGesJlcte2IK9qQLiwb50AaY342BL/BXFLMQbALjvmzp4FIc5k
         GTK2/5BqoLjcmleIcte02WFVHyiy4rSgTak1/E/XRIQ+ndnp8mrMNkYBGwb/1kb7vO52
         WSSPpiJDOli40OHkV2Xd3riG5xLHPPxCjbtyL/fJP0hGQu68NTxmRDZhIg2aaaXxvr06
         4thM0W7ASc5zXGRzduzbwIyXc0rzgVkyd7ImrA3ngZMznsB965tEL8D+Hsvv0UYyDr0U
         Bqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732362715; x=1732967515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sM+NR1R7uTx0PmhnmObK9Bg+qdRFNdiJn47imK1IWGs=;
        b=vwFkyN6ghjykYRpZGDzHqkkUy6Pn+n+0n6pd5YDB5etMp4eUdcHLqaD0du2yBS6NLr
         FBVktE9LEHkSjtd1Lv+hP72CF5eX/i0VKYmBp2QeGAgY2+EDar7bdOsuJg1hw8GLRe6D
         DQ49NUfi7DxnZzu7nkhIqFf8CmdrJv2Uz0y44tbVgRrtOxZRbc5vCS95ojyuJKPCLv1P
         JSrMlCT4ngvQ3FeQjf9x5kkYf4yBGLUNXXZcn23HWFfI7XIYrXfgiG5XwRDmUewVRJL7
         sbeST7EHRMXXGLSs7MkMPkHiKnZqtdnmiRH6r/Ab2R56ypgpGZd3EZ4PPe65YQaHxs3u
         Vw1w==
X-Gm-Message-State: AOJu0YyMV4bIUE3QMw1B7FRJTaCz+MbwQIXYlG7LMIUZ9wTAM2vmBe92
	hvlgEnvxs+75SgWaPfpfE00LN+ElxpIsSZBZGog4zyoe2eZmZDDaAsRjZsn/
X-Gm-Gg: ASbGncsulkEVW94qm+utRxA81oWFGdWhS3y/6vWQJjZyh1U/DsmZlRaJDUPfxFZ/rk3
	7Y2Pk36J63suGhNfYD0E5ZZ4xug+ute2gYcBCOhv3ADmh/vQ6FTBgxBaDQ4IXHJ9jSxA9n02Uyd
	bUzPSwjs/jgpXgAO4nwoJrFgFQ2BQo+Rq8xPqo4OgERqBgYsLacMNlbEgLcj4/n2SHo2mHRk6wQ
	5Wnj+oQmWlPDzMuMVrYci+cHh6UNnugUZl6pEpVpKPAwWawRv8CzYMXQQOBUPLF7k71i5b5BMK9
	5k7Rm8v8/n4ZZBaR4cHeDFwYXwd7dshUzvePaw==
X-Google-Smtp-Source: AGHT+IGxqKIzPZrz/8ogaDjICdo2QwRnzwYAFKCE2yJGyILDPHrb4l4ku8hPeRA/5OLYqehbwqA2lA==
X-Received: by 2002:a17:902:e54f:b0:212:3f36:d985 with SMTP id d9443c01a7336-2129f82ea85mr93323055ad.53.1732362715476;
        Sat, 23 Nov 2024 03:51:55 -0800 (PST)
Received: from localhost.localdomain ([121.241.130.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724ec14d483sm1886477b3a.15.2024.11.23.03.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 03:51:54 -0800 (PST)
From: Vamsi Anamalamudi <vamsi.anamalamudi@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Vamsi Anamalamudi <vamsi.anamalamudi@gmail.com>
Subject: [PATCH] tools/include: Fix typo depricated to deprecated
Date: Sat, 23 Nov 2024 17:21:45 +0530
Message-Id: <20241123115145.13778-1-vamsi.anamalamudi@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the incorrect word depricated to correct word deprecated

Signed-off-by: Vamsi Anamalamudi <vamsi.anamalamudi@gmail.com>
---
 tools/include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 4842c36fd..17de65b12 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1320,7 +1320,7 @@ union perf_mem_data_src {
 #define PERF_MEM_OP_SHIFT	0
 
 /*
- * PERF_MEM_LVL_* namespace being depricated to some extent in the
+ * PERF_MEM_LVL_* namespace being deprecated to some extent in the
  * favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields.
  * Supporting this namespace inorder to not break defined ABIs.
  *
-- 
2.39.3 (Apple Git-146)


