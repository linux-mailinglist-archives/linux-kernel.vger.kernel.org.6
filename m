Return-Path: <linux-kernel+bounces-285951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AA89514C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049861C22A05
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4136136E2E;
	Wed, 14 Aug 2024 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYUNhIJb"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A58488
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723617885; cv=none; b=OFIlm4aWQo94xUMWkVxCug2/oHbGGCvhMv3n3u89AGlYyBKEH+T2cei/Diy3xwo3QUCxgNQNvChHtikrnHbofDhnbYLQXZSZGGZCs3x/ullWnsrladQAuyppwLSaApvhF97EwPXFiAHzm58JlQYn9BqxC63gR+gW5AbBmHEQTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723617885; c=relaxed/simple;
	bh=lHYXxPpNT+ysxOyLzklz9tGxPGrAOVFZchxGoAHgSns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DC1wCfBPSkd8fy3gYN94RDoyzlMhoBflu9YXkY2a9Utb6u9MmPqmVoRcaQXZdvZCAZ4DevMNuCKm4g989LyIl2rfwH4hqrYZ2URtBNkMxhkzWN3LHsssTZA7WasvujQG0ro1641YnL1k56wh8QodbakEuqxld96aPIM8LnThPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYUNhIJb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so915834a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723617882; x=1724222682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=disicnMbwYkjy8JboJFLoo9d06xO3eMp583K8UkezmY=;
        b=DYUNhIJbWKv9QTSzDbLimv5Y2DopTNsjr7MtW6yK8q0QCB0+dXCDWqDpEh+BEgO76m
         5ykdDpS8CKrJrXZKpQLkssF+mdwqQNEQxmWs+qPBU7BP4HMvPqqaAria6MC05e2kbNf4
         OBuFAcS711/2P0VUbwqgLs3oXYLzf7O6CXwb+AlkhZO+z5mhflr4FJCUe8ZkWmeRacyz
         1oJ9m+55BsvZ/7lVvVMClp9dEOwdfJBmKlpnofIiUfmXYTZxQC7bhRE4IyKVVZZkq0gY
         e3cQC8AUzC7brKTU6i+e4mOseI23Fs7Z3N0iV4QQfa3LKi57ChYeoQu/0hTxye8YW1AZ
         kH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723617882; x=1724222682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=disicnMbwYkjy8JboJFLoo9d06xO3eMp583K8UkezmY=;
        b=wW3YcqGaIcK+1jBiMumZQNcwwzagjVc2c1deEFVlPF4++BqlTG8ZhCd8YN7eqfGGuh
         x1jnnNK/cIIn8JB9ev+uTaitewgqdR47sILDWDRYEaojpEXvTEf7MbTNGou2MgEN4Yp1
         JHUNvIuxjqoQrxzJkA4lbYjm9Ip1bt/ZJBiwR7px9/2dxlknTMeuM7RYFRJruaLOpSRG
         mII8bSqv+3jxzGuK7RrETHTo/hmnBKhHTPrlP9xgPoGAsuYpL1JhrdUupsAgiZQ0c97O
         PNfvpGgA5wIZ0tlY0CoNyO+aZnNnOwnSu3649WSzpQUcIHU24Y8i0RO0mI9yyjxnsTaM
         So8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4aExUmbTgRuJAkwha49888zgkzI82/fANyuMgJmJhyWcBu5RrB86v/wjzyLOUdAp4PbbhNLsYrgxW2UBLePFxwktS5VGl5b4dOqjA
X-Gm-Message-State: AOJu0Yyi2IksJciAUrPzYz5a5Ca2rJBDlE42zH59wOodz/z//LGktJ+E
	mO8PgKnJR+vjrfxx5epfwgAHe+iwJ9eDoUIHH5yJuT35nrT2j/gNo9XQYgqe
X-Google-Smtp-Source: AGHT+IHEbQYiFE69V75FNh6J8biCD/Uo1nJq3/aXKk5m2YQ4JkN4gYaQS1etWnwkwxFAHrlcOMOvWQ==
X-Received: by 2002:a17:907:7faa:b0:a80:c0ed:2145 with SMTP id a640c23a62f3a-a836ab73c52mr120410266b.2.1723617881570;
        Tue, 13 Aug 2024 23:44:41 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e46csm136293466b.180.2024.08.13.23.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:44:41 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>
Subject: [PATCH] lib/percpu_counter: Add missing __percpu qualifier to a cast
Date: Wed, 14 Aug 2024 08:44:13 +0200
Message-ID: <20240814064437.940162-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing __percpu qualifier to a (void *) cast to fix

percpu_counter.c:212:36: warning: cast removes address space '__percpu' of expression
percpu_counter.c:212:33: warning: incorrect type in assignment (different address spaces)
percpu_counter.c:212:33:    expected signed int [noderef] [usertype] __percpu *counters
percpu_counter.c:212:33:    got void *

sparse warnings.

Found by GCC's named address space checks.

There were no changes in the resulting object file.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
---
 lib/percpu_counter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 51bc5246986d..2891f94a11c6 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -209,7 +209,7 @@ int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
 		INIT_LIST_HEAD(&fbc[i].list);
 #endif
 		fbc[i].count = amount;
-		fbc[i].counters = (void *)counters + (i * counter_size);
+		fbc[i].counters = (void __percpu *)counters + i * counter_size;
 
 		debug_percpu_counter_activate(&fbc[i]);
 	}
-- 
2.46.0


