Return-Path: <linux-kernel+bounces-393794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2289BA54C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 12:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3767B21866
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ACC16E895;
	Sun,  3 Nov 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3TeE+Nj"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566D1CAAC;
	Sun,  3 Nov 2024 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730633874; cv=none; b=Kqjqp6DFgEgKJdP/VUKoZRSG+3zqMLqHt3Iyocq1tyrd2/+7NwvLbPY9KaGtZj3/l6Umbpq85j0FjO0Xrc4TtKZuMGsYs7sQBAZCPODfq8J9hWUkJPkHeR47OqsCmmvPyZWfEkAGfif4idTWzJhxzxw6mpu2duzCS4EGd6ezRK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730633874; c=relaxed/simple;
	bh=jnLNjEKj2iz1dVAAYrF9077ZoGePfde4qSV9ZBsPWKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hCFYB4jtMYyK0I5Ttj45XlQ3rkBXeKtcQm5ZpEa8E1AKycknvimew/WDMr7iGnAKHjGUfKyZWFkpyqokfs1SnIw+g2L0oq4KB8+Ss0By6+Z1HNtzVrW+fxWqOnWPDQ21PC8qxYwazkKnkNeTN/0ApuGLcbDt4/4ZppsrCODR6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3TeE+Nj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so2840395b3a.0;
        Sun, 03 Nov 2024 03:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730633872; x=1731238672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLyvJYn+bL9aT0FBOR5WooY1nd8WiR6VnT4XJOdKsR8=;
        b=T3TeE+NjtqLAsEQ5PJl5puI5HNI7fMiSPwGREJBPAPPMENccosSKBWM/3fYJH54kSO
         Npf4AYMYHvOnRsgzu1JYpS3rGvHwVmhQJqMZruAt6UNmuU2knC3YWR5iGRAfydvJXFXq
         mmobiYVKw1QxNOFzwiGy9uDwcrkS27s7AOQKHKzjcRsQz/taciz9HLGln5NAqJGpBEyJ
         kjVyOozX8YP8amXMsamzB9x96b0VlZwXJ4yVms4wCHW+7LcM8URyZTGgwNrN05MInvJm
         dTQwzl9OAWDdQ+VCJhIS+nvB72udVqwOrD3JJvGL6GCl1YaO2UopvvM6ne30AaQmby7A
         N/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730633872; x=1731238672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLyvJYn+bL9aT0FBOR5WooY1nd8WiR6VnT4XJOdKsR8=;
        b=OEyQAZO/rmDkKTNVSwKQtVkgg7D+LtyW6LI19wkcZO/dRiEge81JFMJXCsS/w9r358
         4ghkofQCrJzfHfPRm/RHHFtV95cAPMnM4OlXa7TViyXIyQtt22sFywZ8kn+mfiv0TLqY
         cwelV83sJLR4yIp3d5QDJzMHTiKCKt/lWuisYbpcgWy9a2akC3JKNxFzARGS8EBI9wuQ
         9JWQ0DAcXe0JWZ21lcxh4j4TubMwVHOhyQ4Spv695Dfel1pH9e5EUUtClrbgXCX7Pb94
         tKW3z0up97iUR04bt7Jh/It6R0fK8jKjmD9NOZfWrF17O3XuSNjRvepIgvubRXsheDN7
         GErA==
X-Forwarded-Encrypted: i=1; AJvYcCVn2we5oB03pzB1S/ohfiKvdAy3EWvVL/q6N/rFsCmj+mZXnl0OOy1Xlxrn0lRlCOPLlLjJU+vxuFioEhY=@vger.kernel.org, AJvYcCWe4aoOFpVFoUZKxtsVr/fMPF7c/9I6gRnfQl0ATlf5LMgZel/Vv9bzzY1kdjK0UDnH8n6doVjaGa0wVxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylud/4UN113s/YkMSTF4BcsTBIjaq97pFqhFpEEuqhkZtWY8on
	b1ypZDrpgp62SkGXPPmwg8gX7oJZz/3jy2KSzXJL7tNUDVGJVnkPO7z/POgU
X-Google-Smtp-Source: AGHT+IGid/2PJDadVgnB+zvdW2xpcZD1c02xxIFC9A3G9dQp9miJKSlVhP7jce5ZvV9P+qpICQ+oDg==
X-Received: by 2002:a05:6a00:2d1e:b0:71e:3b8f:926 with SMTP id d2e1a72fcca58-720ab492766mr22614759b3a.22.1730633872385;
        Sun, 03 Nov 2024 03:37:52 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4071:e31:2e03:831f:fe19:ca3c:4935])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2eb676sm5516543b3a.164.2024.11.03.03.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 03:37:52 -0800 (PST)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: surajsonawane0215@gmail.com
Cc: broonie@kernel.org,
	daniel.baluta@nxp.com,
	kai.vehmanen@linux.intel.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	peter.ujfalusi@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	ranjani.sridharan@linux.intel.com,
	sound-open-firmware@alsa-project.org,
	tiwai@suse.com,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH v2] sound: fix uninit-value in sof_ipc4_pcm_dai_link_fixup_rate
Date: Sun,  3 Nov 2024 17:07:02 +0530
Message-Id: <20241103113702.27673-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030155705.31327-1-surajsonawane0215@gmail.com>
References: <20241030155705.31327-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue detected by the Smatch tool:

sound/soc/sof/ipc4-pcm.c: sof_ipc4_pcm_dai_link_fixup_rate()
error: uninitialized symbol 'be_rate'.

This issue occurred because the variable 'be_rate' could remain
uninitialized if num_input_formats is zero. In such cases, the
loop that assigns a value to 'be_rate' would not execute,
potentially leading to undefined behavior when rate->min and
rate->max are set with an uninitialized 'be_rate'.

To resolve this, an additional check for num_input_formats > 0
was added before setting rate->min and rate->max with 'be_rate'.
This ensures that 'be_rate' is assigned only when there are valid
input formats, preventing any use of uninitialized data.

This solution maintains defined behavior for rate->min and rate->max,
ensuring they are only assigned when valid be_rate data is available.

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
V1: Initialize 'be_rate' to 0.
V2: Add conditional assignment based on num_input_formats to ensure
be_rate is used only when assigned.

 sound/soc/sof/ipc4-pcm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 4df2be3d3..d5d7ffc69 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -633,8 +633,11 @@ static int sof_ipc4_pcm_dai_link_fixup_rate(struct snd_sof_dev *sdev,
 			return -EINVAL;
 		}
 
-		rate->min = be_rate;
-		rate->max = rate->min;
+		/* Set rate only if be_rate was assigned */
+		if (num_input_formats > 0) {
+			rate->min = be_rate;
+			rate->max = rate->min;
+		}
 	}
 
 	return 0;
-- 
2.34.1


