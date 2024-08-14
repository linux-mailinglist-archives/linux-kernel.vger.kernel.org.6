Return-Path: <linux-kernel+bounces-285793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCDC9512E0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD471C22F76
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AE4376E0;
	Wed, 14 Aug 2024 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GvFlf4LE"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666A1BDD0
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723604687; cv=none; b=X9LUPAdVyOxmeYV+Zrh2K1FUkC/e1iuSRkwTE03Spd+KqpwMFCE+6RiWrdAjtynCvOaVBkd0OcuvFyjQYw32MGU23phVmjh24i8f8cOdEeOn3PQIfEiL0R4GMjl72QBtNrfby3ADfA2ywIIX89L2MYJcg6UyjHdnM8lh56Uqtyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723604687; c=relaxed/simple;
	bh=7UJu/2PsOEHOhwnyEG3i9TZeYYxvGGCWRhh8Ql7+FLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/R6LQ3+TRKoJuQoiNsBBhCFO3NHEgqrZRVqgFSupmFEI18GCjc06TOGEXa+8T2lI0oVKkBFS1dHyfe+Z9/27bmGN79p8VKJzcKM+LZMtTU3Ly5kQqQhsfZjzkiXBOlHlD8n0IHIqR9iahIPQ6Q0IRcUoUG1qJRWfGSVXhe75TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GvFlf4LE; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7093ba310b0so2719498a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723604685; x=1724209485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3J0fEUvbHMhAPJWdImRyNu59MSY0IJb+fU9MhfF+WQ=;
        b=GvFlf4LELb7hvUwyw9IbuQOancOinDUCXXJCwyXf8m+LSkF/v6ywPb7d9rZQ7D+m9j
         zMmzj9K164tFZdbOL/u6CHErU/gA0LVmgDTtQ/8D/QohjONUWpeM679zo3k8E9QmFzx1
         TiPhjCfRR6qYbtwkvlh9AvtjWZy8T7AkfbIPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723604685; x=1724209485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3J0fEUvbHMhAPJWdImRyNu59MSY0IJb+fU9MhfF+WQ=;
        b=OfcsSktH8oQN2fk4ZUsM7epc/YMwksi5nr0lmrREO+QXKM3Mpcuy4dsLU4MQMrucS8
         e66LsOOZdhPnLOyTUgQBGD75OfM+y1WovzbZRdbDf/ixtn2/2E3UE5uyR2aFHfrivMBF
         swl5s9e8+r1h+8AX4LGNi5/LLYZi7ReJdzaSosB+nPyLPeh6tsODFKPq7DrLqdMGOGkY
         z9OAAHZsHWqo7NIll6zenxML04uJ2DV+8/sUhBDEn3367+DUZK21xK7yYLlPo8mCjqBc
         NZ64YPkjz+OTHxJtpylXdb3G1YUWiDZsi5UQFE8XClzVkzfwAb99qwqqSerbkZmkGMyb
         6uQg==
X-Forwarded-Encrypted: i=1; AJvYcCVCdEC/7zwyEUgDEJDldQfW8IYer+6qZs6RvntLaCzUUBJES+XqL733lzbpW0Prpc8u+u6ZFbw9zXPDiBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66BqhIWlHOsVm30Urr/NAoBGD1Ys8PuSVrWcIz0IvpaCuvIqd
	S92ge2zDIlrJlTaYT7uwT2Vn2F3Q43n5DupU1IaA1isWbTP9698DMqIAQww2gA==
X-Google-Smtp-Source: AGHT+IEuPm6gxy7zj+fU+81SpVfOU29yyUWzz3ZXSQQZUPg354kPeGsGkveX0zmBzn6UCnv07eUfFA==
X-Received: by 2002:a05:6358:3110:b0:1aa:ba92:e7be with SMTP id e5c5f4694b2df-1b1aad69299mr154584955d.30.1723604684705;
        Tue, 13 Aug 2024 20:04:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:517b:be8c:b248:98cf])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7c6979d4b3asm2182709a12.4.2024.08.13.20.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 20:04:43 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: bpf@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] tools build: Respect HOSTCFLAGS in 'fixdep' compilation
Date: Tue, 13 Aug 2024 20:03:51 -0700
Message-ID: <20240814030436.2022155-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When refactoring the Makefile rules for 'fixdep', I open-coded the
compilation rule (avoiding the "Build" recursive make, and therefore
tools/build/Build.include). In doing so, I omitted HOSTCFLAGS, which was
previously part of the host_c_flags definition.

Add that back in, so builds get a matching set of host CFLAGS and
LDFLAGS for this step.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/lkml/99ae0d34-ed76-4ca0-a9fd-c337da33c9f9@leemhuis.info/
Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
Fixes: ea974028a049 ("tools build: Avoid circular .fixdep-in.o.cmd issues")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 tools/build/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index fea3cf647f5b..85321c7b6804 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -44,4 +44,4 @@ ifneq ($(wildcard $(TMP_O)),)
 endif
 
 $(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
-	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
+	$(QUIET_CC)$(HOSTCC) $(HOSTCFLAGS) $(KBUILD_HOSTLDFLAGS) -o $@ $<
-- 
2.46.0.76


