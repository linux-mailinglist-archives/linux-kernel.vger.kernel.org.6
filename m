Return-Path: <linux-kernel+bounces-298272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E891995C4FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE956284832
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7F15466B;
	Fri, 23 Aug 2024 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYThDvWr"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4129413
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724392101; cv=none; b=l9T6K+w5uuOAk8uz/h8Nn0bxz9DGCLRYzcNjDIRC5n+jCtgkp9eXnt8nvmdREEsxd79xOlbCfnLZxbYdJgEb0xNpnlngKUAknXw+P7/glSvDDMAr7tBKk1X1iXf4056eSHPiYRwZwgfqmNH1aPSsjEQyw1K5xAqNq9AD2Yd1Kns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724392101; c=relaxed/simple;
	bh=8CRZULC2av8W9UqJuHWqBGp+Gs8U6Tg3EYV/tAeLtaU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cZ2t8l1JE0mPmistE7DSMACHD1aMY0ZGvA0nmHBggHlibOGK9NHF8fb+kl48gdHb4Rv4muQsvWhexSB7e66fVNdxrVkRL4WPC38/Fvi+QJAFsAyX9AMI/G1h+CxNfNPqOtJqXEIemogYioHg3IlQav/+wtzpVgvJVIf46YWmIo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYThDvWr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7143ae1b560so842937b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724392099; x=1724996899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eK2cKwXA17RWndDH6g189gbs5ylSm4mN/bHBBIKVpec=;
        b=AYThDvWr1daqXjMQHzcpczNUlWCesAWLr2UdrXiMrAwLLr0Z17eqwmFa4otbwZioL0
         I8JDYW2/sIBPOFRcnISawUZk+9ey0FrTUKgDG/Ht45FBd3kckZOZf7BPEa98yOB+jC9N
         ixPcqHyogr9JHj2KZkaveEE2iqC4KO94E0UZqVRDP5Y7ZtaI+ZVIL8blmaIzA9sq9GNw
         uWzvlnaMty+WpQYkZm95nDN2PfIQGz2Q1wXW5LOyz0S999GzwqMNrB84MG7BgQ7UM+3A
         rOGrTOKlDhuQfHYGFiHvO0PVhTTpC/vTm9YLU9a/cihsED7XsGMOufKcqh26TypzqRHr
         FmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724392099; x=1724996899;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eK2cKwXA17RWndDH6g189gbs5ylSm4mN/bHBBIKVpec=;
        b=iDywbauWLz/MeV7jqBRgTcxoqJIDqjjeuxLvo0ZOIVlhHC1Kau4XK3+rJ/bNLX/nHq
         plLDLzT0qwFQjDvHQKgcRsxVLck0ydIhvFRQLk+EZaII+hGUCD+WGkV5pnRxRse9K9g0
         ws+AnbZKZLokHB6z4DU4grMOERMpKJzcrsF/Btxa5VVx9GZewjZln8UINSj7N44vZJRK
         w4JshmUAx/hmxVWrAp6BNXJnT0kYwQ/ebIMpm/U7u+WTwbi54CUg1RSvbmoD0c4LY3Ct
         V7CymDlr/y056Xts9j8DGEDPZWZBlFoS/8VqQB40MIQJ7yZUViln6TEtgswY7EAIyUrV
         FlpA==
X-Forwarded-Encrypted: i=1; AJvYcCVdbCEKhcZcsp000oAWHxagdrr7Ie9LgAIwynrm33k4HY2bHkrA6nfnYe0tcJtsA6FQDQ2PEC7uxCwBV4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkeDYPD4jNso9xq5OEl/aVHfZpSffNWxY4dUAZ5T2wfkz6yaMa
	Gk48NyVMR5p5IDhWg0pL/EXnSdeQOcme3cKJzsDck3vsVM+dRb4u
X-Google-Smtp-Source: AGHT+IFE8o8bIIkoSBYowFODAyNJJQYSo/cIcZ+h1Unty23LCrNU6MxYmt3sNYZsM0X5n/B1fSPYJg==
X-Received: by 2002:a05:6a20:43ab:b0:1c3:b0b5:cbd1 with SMTP id adf61e73a8af0-1cc89fe6626mr1632321637.38.1724392099143;
        Thu, 22 Aug 2024 22:48:19 -0700 (PDT)
Received: from [172.20.10.2] ([101.90.58.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb8cf61bsm5361208a91.9.2024.08.22.22.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 22:48:18 -0700 (PDT)
Message-ID: <51603da9-d77e-4a11-91d5-3ec1902cbb4c@gmail.com>
Date: Fri, 23 Aug 2024 13:48:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Benjamin Tang <tangsong8264@gmail.com>
Subject: [RFC] sched/fair: Remove unused max_vruntime()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Since commit af4cf40470c2("sched/fair: Add cfs_rq::avg_vruntime")
max_vruntime() became an unused function, remove it.

Signed-off-by: Benjamin Tang <tangsong8264@gmail.com>
---
  kernel/sched/fair.c | 9 ---------
  1 file changed, 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..1dcaf1f5aeb5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -523,15 +523,6 @@ void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, 
u64 delta_exec);
   * Scheduling class tree data structure manipulation methods:
   */

-static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
-{
-   s64 delta = (s64)(vruntime - max_vruntime);
-   if (delta > 0)
-       max_vruntime = vruntime;
-
-   return max_vruntime;
-}
-
  static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
  {
     s64 delta = (s64)(vruntime - min_vruntime);
--
2.11.0


