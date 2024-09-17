Return-Path: <linux-kernel+bounces-331235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4904497AA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 03:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838511C26A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D8525763;
	Tue, 17 Sep 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fTf79/3V"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F35F1B813
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726536629; cv=none; b=GaRpsDddLca/VkCruK3Q6cjbExjaBeEiobT2AvzMphHjAyWR8ZXISDHssmR4Wc64SUyjOyAAgmKutaZ6Ikz9+88khfnzGXFx4PD6J0g1osF6Nwr3QJpugm1kmamNHspyhf6CLUCGSttwsyJ300QZ+r61RAURhMbN/jWt3g3FvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726536629; c=relaxed/simple;
	bh=fMhkbvm5dFvBe0bEzntnr3gAJAUQzlWhs5mHYJgRIJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD0rv8PJQm4CLK3NjBKVXh3vdbMsSTyyvEgFA3QCXghN1tvNVSxhVbz73MTxzy1bY0AMDLcuHkxIUrVM2gbmy2ecFMUu8xFOY3KnCbac+qjsQnmQ8VlvGb3jtzT4w2P9wqc9SWXmoTd3plMVIR1JoTpaZraUWYV3VsZ0MWoemjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fTf79/3V; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2054feabfc3so42769345ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 18:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726536627; x=1727141427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2ay2DI64scCfkQ48LTjmv4Aci3oWTl334/brCtW+Lk=;
        b=fTf79/3Vxij5I5UGRAax3DCtK5zc8O81i6GHL/h4gL3IHMuKpsxAhAD89w6eztzSMU
         ERsTH73W/qfz+hzPiCu1EDktcdSu/e0WIGhyLnG5S2AoEVJq1i03bZNUtuL+D4VWpHDm
         ZwQmF4BjzI4YyRfQCmKn6dp30htULPlqWtys4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726536627; x=1727141427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2ay2DI64scCfkQ48LTjmv4Aci3oWTl334/brCtW+Lk=;
        b=drwCMp1uIuOLZ/fxfBHPOFivPTGYIxWpFdRJjqtB5rqbPb2l1iS7C6ApBqR05+qiEa
         fUvlK3AssEBrCfOBrJs9XogOIeuk04gHonB3xkx47V2cQFxNVB2HCrA2o/+gNPpeWK6I
         eSFi1kl9an7IO0p1XOgrQLINeGGb7csYo8uZ8rgJL+vqjtvfhJeWLfZwlTd3jTAlss18
         Z6LWk4cOzj3BZqT5PbD1zxTg+7MlBN42vDagQ00fylIURxh24+nCdT1cJvhlvgwVIK5I
         NqMHKOmKFf6k11JF3MrlkQEmffyimcdg4kvFYZ68B3NKvmHNPmrzlmeiN6VS73BeJJD9
         ibSw==
X-Forwarded-Encrypted: i=1; AJvYcCWuqIgVzqSJ9ke4ernOihDTvYiYKj0FHY0dEKr1Vl/bZNInB7cFNIm8fcAwQuHwE6oLMLoy/15beJO6FZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+vg1N7SmTJq5Fi4bVl3ykyYkGH5OQOa4Rw7RXr21QgH4mXjH
	DiMf6aCeZRri0lyvk07HMw7bqVrIlHRlyWu7G5Jonhgq13qi1/vAZ+JSD2JdOg==
X-Google-Smtp-Source: AGHT+IF2E9b5BulhzwwXePKnyv/f2KpmqjcS2NPIeTG73hJq7GojqgmxBZYy1tbOvgN0G37XnVKPQw==
X-Received: by 2002:a17:902:ec86:b0:206:ac11:f3fd with SMTP id d9443c01a7336-2076e392bbdmr262688425ad.30.1726536627458;
        Mon, 16 Sep 2024 18:30:27 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:693c:b4a9:5e6e:c397])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da63fsm42104385ad.38.2024.09.16.18.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:30:27 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] zram: free secondary algorithms names
Date: Tue, 17 Sep 2024 10:30:05 +0900
Message-ID: <20240917013021.868769-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
In-Reply-To: <20240911025600.3681789-1-senozhatsky@chromium.org>
References: <20240911025600.3681789-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to kfree() secondary algorithms names when reset
zram device that had multi-streams, otherwise we leak memory.

Fixes: 001d92735701 ("zram: add recompression algorithm sysfs knob")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f8206ba6cbbb..c3d245617083 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2115,6 +2115,11 @@ static void zram_destroy_comps(struct zram *zram)
 		zram->num_active_comps--;
 	}
 
+	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
+		kfree(zram->comp_algs[prio]);
+		zram->comp_algs[prio] = NULL;
+	}
+
 	zram_comp_params_reset(zram);
 }
 
-- 
2.46.0.662.g92d0881bb0-goog


