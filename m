Return-Path: <linux-kernel+bounces-320621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12AF970CDE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A561FB21E0A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E467E1ACDE6;
	Mon,  9 Sep 2024 05:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2LCifJ0"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DCD134C4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725858847; cv=none; b=h1RLOcVIDWRvkqEoLb1asrxKRHiX9K3Gy6LpGZRCV2ekxckT3jfxBoj0n9p0czM6/IKuMbA6ETZO+KrapXhybZwLHsw17TWh6mElHnh4cySOwUA4Q5X6VzaJP6aOuk59EjZ2v2wGYH3hHHYUe/p9IppvsqGGOvyzHBaEt9+Ij6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725858847; c=relaxed/simple;
	bh=SPOaxhthGx0mKxj+cyoLv5yQxRUkPGMwxrX4cMFDt7Y=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=hE45m2Ip+bU8RkOxb31gEfJDSRDjDrv8GqPDKA5xBG2sDtVSTmkJRJHAMCwP34k2i38FgBdt07XI0AOosc2xpw3b2kdIp5j2DKKSXzQ7sIvRnlAow/CL7NWS32gAis4no3Pt4V9gJdDeVG17IJfCuKzJtkvqGR+TDY2YQucd0ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2LCifJ0; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-277c742307fso1561384fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 22:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725858845; x=1726463645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtVGaZq5QShvFJzoIFqVcPOWLblx9klsp4rliV8AkIc=;
        b=b2LCifJ0g/CwSgYD0P7F5KGgPDpN2iTo5gYZS5Y965TjYyqLdB8Yw/qsOjJ+EIhFYe
         nETQzakRY6zy/CE4Coal5eP5EUJF4HWbwIUWfokrQ44PPzsRX2w+dKKCXn0Ba4FoampO
         AOesJTxISDi0+4j1DCQg5NEIs+7ZTljjPhK3Ml/VK3uzmqwmA/3CImjKhvOfu0D8IFZ/
         5yQA6Oe5gyCdkqhfVuL8A1+5W1kHfIwphO2eGdHbk+Ua7H4WzflYj9KDvkrFKvgmhbWK
         aDldh3evON9Ha043MsqSHxE3JWyM3L+69A6l4DaNWgOvo8A9jmGwh3eKoBDXlMJJ7pLI
         uQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725858845; x=1726463645;
        h=content-transfer-encoding:cc:subject:from:to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mtVGaZq5QShvFJzoIFqVcPOWLblx9klsp4rliV8AkIc=;
        b=HqqFXv63lmlMsPv9utl4P1Auh/1SXL3EpXsqB5JkZlm5EFoT8vjgip4aol3LfcUWcB
         jx+IvZoT/iJHXjozaUY2v+vjP/HS5wt5SoUs55jb5G4ApXqwLU4FpFu/27c31qSAanUz
         vgBJw8ZdgJu8RoQuOIBcTklGzgV2mtHzFDQ9Pfpv5f5QvmBUkl4ZHZz0ve+C4ZgmyK8n
         ytsS6vJ2lna8Ho4121MwoX6RZl6wSV1geU/6THV6b3/8i2OeW6nhJjXWIAVVGzm2mhqO
         aeQSYxGI/KZ3LpWwQ0KA/U22cWo4/p3M5YOpTvAzc7MybmuTQOn7IKGBdlfHF+iSrp1n
         Vlcg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Hr6ChnKUQMfgDuhbEcItAP3zICj3GzL4++m+VvhjDYAVc2lvnHoiwckkKVL7rynhe6fXku3dEIOqxEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWo9v9bpKyT+7fYXmZxV30wZNUjgigZT/iu6EGUUzZtxVX+QH8
	nzUqUvTKxt8kKglvzMw8mKAyP2VGr+LrYqArR/kePhIP7q6V939LMJOApw==
X-Google-Smtp-Source: AGHT+IHej6Z5MU8YVhUq6u/r9TgIXh+anLFMFCP2+VJdYo7nwgbAvZ4H4Up4vQnHZy6x0S7PlzkuEQ==
X-Received: by 2002:a05:6870:e310:b0:277:d6f9:494d with SMTP id 586e51a60fabf-27b9d7bd0aemr8336181fac.6.1725858845086;
        Sun, 08 Sep 2024 22:14:05 -0700 (PDT)
Received: from [10.23.230.106] ([114.219.141.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e596880dsm2746923b3a.134.2024.09.08.22.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 22:14:04 -0700 (PDT)
Message-ID: <3d9e48ab-869e-4633-8874-b2899c8cc8ce@gmail.com>
Date: Mon, 9 Sep 2024 13:13:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
From: Benjamin Tang <tangsong8264@gmail.com>
Subject: [RFC/PATCH] sched/fair: Remove unnecessary judgment in
 pick_next_task_fair()
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 Benjamin Tang <tangsong8264@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

sched/fair: Remove unnecessary judgment in pick_next_task_fair()

Since 'curr' argument is no longer needed in pick_next_entity(),
remove unnecessary judgment.

Signed-off-by: Benjamin Tang <tangsong8264@gmail.com>
---
  kernel/sched/fair.c | 2 --
  1 file changed, 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..92f8ad778205 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8492,8 +8492,6 @@ pick_next_task_fair(struct rq *rq, struct 
task_struct *prev, struct rq_flags *rf
         if (curr) {
             if (curr->on_rq)
                 update_curr(cfs_rq);
-           else
-               curr = NULL;

             /*
              * This call to check_cfs_rq_runtime() will do the
-- 
2.11.0


