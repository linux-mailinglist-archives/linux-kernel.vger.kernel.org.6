Return-Path: <linux-kernel+bounces-258256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2119C93858B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 18:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94047B20CF3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F38166317;
	Sun, 21 Jul 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPXXJJS5"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A826AED
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721580369; cv=none; b=fW/A8YJd0tD2JdU9lxaEPthnli+wb8uFjlh3xAbXpVDxYEAC6/OGaqyYllWPMqgpgWrfBMWcHztPxXXExVoS0IFoINJyVdEAyTZuUlmhREIrwwUgkDSz+SaHabUk1isUol1k7EiUyqKMGyqKt/fdV6NIptaI2+xoaw/iPz4LKHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721580369; c=relaxed/simple;
	bh=rAH4Jm9AoRvX4/4HSmDEGIbMl0UA3sgBAgyyr6KPB6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvcEnkRrD1KMd4e/SVkAKE8Wl7bUivDIt/i9KHIt/raCVmIcMkUFIxzEwIpuLSX5zeHncMUkI1TOWRkZoyJqsQsRdb0+dWngvfoWoTiAN9wFvB1js6cGDJLwRchnMmRaJtENAP66GipLYE+Z/FCRW3GKTTVnEbR2nqwCJXrksFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPXXJJS5; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eeec60a324so46984181fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721580362; x=1722185162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnzMvlF6bfeYxZjSrDfgdjPHin7M8Ak7WmhUUH8l9fU=;
        b=hPXXJJS5IeLVYSdZTniRZLTox4VKKuZTazLvz/VZsvzPONbwyfeA220ze5tkm0dzQx
         5zH1f1iWbl6/8qXjCkOixTI9AU6FO07quoTQq/GLADEGkK1fSP4xGh1ew4Z3bhPmvOtu
         BcAdLEY24ALNabfJUnjwVRUzeUmT0sMzSLp1SGpkI/WMzWE4GF1LIY4Z0FwKrTMDpwU0
         mi++hh1El4DDUdo8qYXMaN90/sZr3OOLrSFaWtK0qAq15c9rGEv/scv4gVazGXsfa8O9
         v6dvvXvqdkx4C26gVoY3xe6xyUyYaqZuiSM6dPxaD/rNXtVrhkUGAxGl9/1WQQ7qYPwg
         xoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721580362; x=1722185162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnzMvlF6bfeYxZjSrDfgdjPHin7M8Ak7WmhUUH8l9fU=;
        b=J52rz/05f+jSarZCihnetFB+mwXd3kPUca36DZU/p1BsX97MIUIEghV1618yIa+QZ5
         FsrrgFtDY6ld88XegFh73IOuk6PFTcr3Ys8w0jYIkq3mrbF20z/gBkSWsXkQ1qaVYD4z
         P6Cje9s/BNgH3RlC/Jic8+sjd2pQNSobxQqCSyrHwtgJbdC6JnKQw/UAJAgTW6XZDStz
         ScMUXsrNddRqltc2xV4ID2P+C1+L/0bQg0KE1e6WEhwr+0TbQBOWTJOE4gZnoivBw6rP
         LTMQeBpVLMF/f5ItRjAhbfl5Hxlwd0Hwn2QwBqG82LoMq4aGv5RJSODPrF33nNb+DLL8
         V8Dw==
X-Gm-Message-State: AOJu0YzHRt4X5nnztG1x2u1qMq0QAVPrp2NCyQbFOKvzaInjRjY977zK
	t1X6D9+s0NeIGk1hALs/OmkI+yoYFFpTdH/KAIlUOIBqlejuKwJTY68lV/+L
X-Google-Smtp-Source: AGHT+IHPfyYAhzj4ox02oB/1AKZGEh8nbWZBUDGUOuxa8VGJ67ALfy79H2GpYRZVJwXwrV2xcl6d6A==
X-Received: by 2002:a2e:3504:0:b0:2ef:22a6:d90d with SMTP id 38308e7fff4ca-2ef22a6db66mr29278881fa.47.1721580361940;
        Sun, 21 Jul 2024 09:46:01 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a709a74169sm1045051a12.95.2024.07.21.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 09:46:01 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH] locking/pvqspinlock: Correct the type of "old" variable in pv_kick_node()
Date: Sun, 21 Jul 2024 18:45:41 +0200
Message-ID: <20240721164552.50175-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"enum vcpu_state" is not compatible with "u8" type for all targets,
resulting in:

error: initialization of 'u8 *' {aka 'unsigned char *'} from incompatible pointer type 'enum vcpu_state *'

for LoongArch. Correct the type of "old" variable to "u8".

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Fixes: fea0e1820b51 ("locking/pvqspinlock: Use try_cmpxchg() in qspinlock_paravirt.h")
Reported-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Closes: https://lore.kernel.org/lkml/20240719024010.3296488-1-maobibo@loongson.cn/
---
 kernel/locking/qspinlock_paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index f5a36e67b593..ac2e22502741 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -357,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
-	enum vcpu_state old = vcpu_halted;
+	u8 old = vcpu_halted;
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
 	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
-- 
2.42.0


