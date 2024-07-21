Return-Path: <linux-kernel+bounces-258086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F9A93834A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 05:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C755E1C20AC6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 03:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88274256E;
	Sun, 21 Jul 2024 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aeEZ4zCG"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682B217FD
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721532002; cv=none; b=llExhpoB/REA2BTnrsiuDMfpf66ljgoNo+Nvfj9S/P1HoF9eqtqlmoc2dWBM0C2mImhYGwR/5turXGMrxUKFY8XknJM4Mf8HVlamuCJioXw9YjYkgvjJ2rtnZ40UcMVbynlKT9xHIDnVgavDKj1j1VCPOkhNXix74XWvrtkgKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721532002; c=relaxed/simple;
	bh=fmiWUtLoLSg0oXD5COw+p1HKt/OkeyiZZryCTS1y0Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=db1jbNT0RavX2Y/zbkCroqwik9r6JMI6gloKlmxGPh2wX2jqFsg6lfHizUv9YLd0fvajTUBDqTEXHCOjQansnXAGCqyqAsMYcPvcPft1BhwfGmhYQxVwfrt4vldZhUEu+OKUQ+OqiiLlPzeBO3dDFHZkJ6420pUABmGeoGcJya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aeEZ4zCG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeec60a324so42990761fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 20:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721531998; x=1722136798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8IKB8sxXNF6g036oVsRu5aXttvdlBEUNATyMc+zuAo=;
        b=aeEZ4zCGiCQRNEW4CjpvouznLlbEFeCbnqpIuDuHPjSDG8E5V3UYOvJzScYXVzW9Rz
         Pk16t/KpPBHnGh7Tfn1Krx5ywPFCNqkAMKiiTtBuZa11vQ/LDLGoD2VcVABC4B2MmNwb
         ir+Cqx6ykHtStIFyToQYoFBV9kdqrmnv18wPJA4uWcCfZh5XzN9XIUmVHnB3nP3doKuU
         JoKqLzl2Tuc22F1t+Tf3DA257sJLGRa6X+5sPTb/RbpOjGJqBuLtIfm/Ax8yHz/yZHzc
         VIbCtjYHY8QCu7LGMZozWnf9xPYGGTZFv7RAb46BqTTAjFDYAkrKBYS316vl+ZiTiN5J
         y98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721531998; x=1722136798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8IKB8sxXNF6g036oVsRu5aXttvdlBEUNATyMc+zuAo=;
        b=lf+OKjzJ9e55y9qJBXvk6UzZ1Vs5X28rN1LTaZyT59fR8JKw03gPE0neDYgoV5DNPT
         rRaV/Mfmtlu+GU6lJjgIlFjPcd78OF2lehYZXOtlTyA4HJrWVGD081TitKbdnQn5GB5T
         NhF0OlE2TatAVXCHL4ALE+ETyiYjxsuZXfslJ9Wq3Ab9yhDxsZbr07w1IRdAlcdv/aO3
         4aMkLbNotpNZKPXvzYZxUqPbtoNITlkloo4Mkin6GBxdvs3sM7eW+gEq9//MIju6Mx9w
         MQnbA570qnrHw2Pshij/h9P1ZRjp9DqA2fKNY2HWd2Mc61JHBydynf3hbq7nKiMCQBHD
         O2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWbIKC75LcTONt6bsO5XRf7DDp9R7f3BA0QdD4q4Y6dJLOva4PXV7Dlqjme92VFEbMwyuh3sFE3wba/qxdmmhPk3bvfKcefBfJLr5+f
X-Gm-Message-State: AOJu0YzfKlAhEBbP7O3jZ+vzHZV86HsM8kR/EA8KePGTuJ1vQiVCoYrG
	sP1VJ/2qodUMnDlFLHe99pOtPvcBuyd/IUtmxQxkSzXo1wI02LpnH0PGcIiRtS0=
X-Google-Smtp-Source: AGHT+IHc3wmiD+skdiqMr6Cm3540sI2oYmkEJicmVSbBLP9S8TwTr0ZZN+fR3kg9LhTJsHSXug7lGA==
X-Received: by 2002:a2e:97da:0:b0:2ee:8817:422d with SMTP id 38308e7fff4ca-2ef16789b22mr31000521fa.5.1721531998401;
        Sat, 20 Jul 2024 20:19:58 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7a3c7bdac0sm235270666b.60.2024.07.20.20.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 20:19:57 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namhyung@kernel.org
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCHv3] perf tool: fix dereferencing NULL al->maps
Date: Sat, 20 Jul 2024 21:19:44 -0600
Message-ID: <20240721031944.62913-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
thread__find_map() could return with al->maps being NULL.

The path below could add a callchain_cursor_node with NULL ms.maps.

add_callchain_ip()
  thread__find_symbol(.., &al)
    thread__find_map(.., &al)   // al->maps becomes NULL
  ms.maps = maps__get(al.maps)
  callchain_cursor_append(..., &ms, ...)
    node->ms.maps = maps__get(ms->maps)

Then the path below would dereference NULL maps and get segfault.

fill_callchain_info()
  maps__machine(node->ms.maps);

Fix it by checking if maps is NULL in maps__machine().
---
 tools/perf/util/maps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 432399cbe5dd..d243cb794a99 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -169,7 +169,7 @@ static void maps__set_maps_by_name_sorted(struct maps *maps, bool value)
 
 struct machine *maps__machine(const struct maps *maps)
 {
-	return RC_CHK_ACCESS(maps)->machine;
+	return maps ? RC_CHK_ACCESS(maps)->machine : NULL;
 }
 
 unsigned int maps__nr_maps(const struct maps *maps)
-- 
2.45.2


