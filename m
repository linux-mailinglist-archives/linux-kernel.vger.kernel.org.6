Return-Path: <linux-kernel+bounces-203890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21C8FE1AB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F645285712
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4984913D8AE;
	Thu,  6 Jun 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brmyF0bd"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9113A259
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663941; cv=none; b=q8W/bQ3HreuCuvMQJKqa0MeeU+zfgoRzO+qDzatb3PDy2JiWGmbSjMnkEQHT+y0iaeQNx3zqSBeGgx5kl0BC6WegN/GN6pIPHl9xZdvpkDb1pb+D0zvflN47spmsLRfp4HvL2jsB098Gz1T+wiHHV6H73lXJV9AlRShWq0uCODk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663941; c=relaxed/simple;
	bh=sB9OPYz17fodfyyWPlp7gGc+2LZTdi+aFKX3ww6shyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OHj4XTu1+ZoalWqkT2BWp7IWZcsjOA24fG3pHtgfxCSRe2PXaxIyqng1ndcYbyZksGlCVpYrLtfgsia6/2WCt5xYz/YbOp7k2hiqL4WYm+oddoO+SHQzoyqoRQnXzJUmGjX2RbQ8lEukXbNHmpUaCZzOEFdJQcKheXJ65cDZYnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brmyF0bd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7025c5e6b94so573155b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717663939; x=1718268739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QNZl1fm5lZ6xU+lYt20e3pUCTVWLs0P5EsahCrj4FTs=;
        b=brmyF0bdVWKv5mDiAU9borwDfTUhdrVfj7w9mzGJsIcVPD2rPjuYXt2OuUE9cGqN/r
         Hzq2UbsEJ25Dzmu421BaiYM8enD7ki1I98pcVxblLrW1zAyUAVZ2GA0KiO/8I/qjKcuH
         cy0gdsmCW7admFSbbu30/0zmAydD45OpZ3jncNT9k5cGl6chHxivxj+ZL7Fz+2rrVnnj
         9j16VpNM6mZpnZiTGi2HF6JRflx01dvn5sQ14i5/wS547yTpLZfMnnUFNA9bTxsPYr18
         br3qQ/J+Q3LqVtfVmkjh/htji2Zdax1GIJa/kizLuHZf/K0pEfif87cUkKLWj5tcOFyq
         Fe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663939; x=1718268739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNZl1fm5lZ6xU+lYt20e3pUCTVWLs0P5EsahCrj4FTs=;
        b=O6XBtNnJiOjXTzaPLqeqvGrwR3Qz2IxKN331zYQ0y6hoMQgAfFgtjA9kcNz6lgcf3V
         D1aSPZ6sMExag9ibdJUw0i5GL25BGhHxFBEPL7nHhdiqgv80XHq6FEqjzXLERndum5u+
         LB4O6oQwhvGSNKGz2cKAmB6vrBhTltzErAb1P2iU5B4SIHinDBjUZQ6stxxLMyvrfzfE
         aAsIsFM6b+76a1VdIwhiU0AkcAWaXqsBYDQsr8Iyx8b+539ZIx57J14jEyz3pGI8E7le
         HL5ipXIPdGCz0BkPQ8BK/sBu0bTOdVXEqGlkgshuUi48Lea8KP2sgOXGBpVgkbZskbXa
         gk7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJWGu5ekbjVGf21RKGYvAloMkRn6npAqabJ6Hd9a/LqkxU+3gg0ckt3c89ivDOFIg+ytXLZ2BeV2xKsbSO959z01ylHmwLHv+vRvAc
X-Gm-Message-State: AOJu0YwUvpQ6IVNusQVRZdyCSQIlpKWrdETgZWaE6g91ucK/Ugvpgu8M
	HAstmp72IoONylgcWQvv3L98RyEXlHgc1OIlb9LDZCVZNs+jX1o/
X-Google-Smtp-Source: AGHT+IEcuTK1oA/a/mv6glrur8w2uorsffQeDphZCcgDGHk5GkZaEIYsf8IcWwA3HPqNE3bJ6ZjvbA==
X-Received: by 2002:a05:6a20:564e:b0:1af:a6bb:45c5 with SMTP id adf61e73a8af0-1b2b6fe3ad3mr3773872637.30.1717663939535;
        Thu, 06 Jun 2024 01:52:19 -0700 (PDT)
Received: from localhost (97.64.23.41.16clouds.com. [97.64.23.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4db3aasm692595b3a.155.2024.06.06.01.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:52:19 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Wenchao Hao <haowenchao22@gmail.com>,
	Audra Mitchell <audra@redhat.com>
Subject: [PATCH 1/2] workqueue: Increase worker desc's length to 32
Date: Thu,  6 Jun 2024 16:52:15 +0800
Message-Id: <20240606085216.3475033-1-haowenchao22@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 31c89007285d ("workqueue.c: Increase workqueue name length")
increased WQ_NAME_LEN from 24 to 32, but forget to increase
WORKER_DESC_LEN, which would cause truncation when setting kworker's
desc from workqueue_struct's name, process_one_work() for example.

Fixes: 31c89007285d ("workqueue.c: Increase workqueue name length")

Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
CC: Audra Mitchell <audra@redhat.com>
---
 include/linux/workqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index fb3993894536..d9968bfc8eac 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -95,7 +95,7 @@ enum wq_misc_consts {
 	WORK_BUSY_RUNNING	= 1 << 1,
 
 	/* maximum string length for set_worker_desc() */
-	WORKER_DESC_LEN		= 24,
+	WORKER_DESC_LEN		= 32,
 };
 
 /* Convenience constants - of type 'unsigned long', not 'enum'! */
-- 
2.38.1


