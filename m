Return-Path: <linux-kernel+bounces-293897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6C0958648
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB5B2879D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4CF190480;
	Tue, 20 Aug 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="eoLXi2gO"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3E19006D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154949; cv=none; b=rQUGTBZ4Jlzu7E8nLWSY1RqV4Avsd2NuhD0YlINmbUbiVfJjR4nFfeLD15QX8bM1bO8VxIJZTOQ+t/f7oXZ1d22N/IEOa6XM5lm7HhBJcLl2RBYz5pc9bADXm0LuoJQ+CDAZ6hxmx7WeFUiJ2xhOhNxU3Zm7V1n4VsFoTsGWuP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154949; c=relaxed/simple;
	bh=hkfItsWa9NSLlabsXabPkApTXzik3ePg1jC981q8YyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqM5x2Nk4WMpllbTAs8kMBpxBrJ/4IkvFgrV+sywXvkfTUi/XHTAIu5G4Ro1IAPdbOiKDPai4LoqZYY2uVcD4AO73D6Dlyr36zz8k4blGhWTnl6mp15IVkpM0uIMFdbXuXRTmlR/UYktG+0bSxFke05OPZKvliPc74yxP9Q0qHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=eoLXi2gO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so591961266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724154945; x=1724759745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gvs8qgusy6T7TLswBVrW7X396oYI0zVMv2rCG84jfiA=;
        b=eoLXi2gOaIoIg9eYSu8mm6eyKR4FK9rYJeIDJ6IEXi77tImp/jbe+gRzz8qudkfztX
         5KukR/W9SegY4vHwJZVxg5H+Nr84PE9YcBCz7cJWvSdJfR9TB9xJ+hCEuWP33Dhc35BI
         XH76aRuedJURGlFWM7/4IAeRb94lqEpe9HjvTxfwD8wweKvjjOIh7p7BtjZRoGJ5rEu5
         kJIpSOTT7j+VXI/PDjps/zidMF6PbqN0qEKkQkGuJtFZ3xByI5m1zxvhgBBzYerHIIWf
         YKOyJAQBsHQE7uQ/z8NB7NgXF3A9PqB7kVU/IriWiPzj+9qc5rroMU8ooWxu0CahJ0IF
         ufAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724154945; x=1724759745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvs8qgusy6T7TLswBVrW7X396oYI0zVMv2rCG84jfiA=;
        b=lcEB3nTXBiX9xAweFxunUc3NGqSFP4+6jvirzwbPAl59f+1LwjljWbJmVvqi4RXcQs
         8PIqsyeuOCpCEoBIHaw9IEL01h/WctC9jHPIjGWqSqB+VTg3LbQsbB8ah8ywXAZAqkuN
         s8uTbhaH8wuezi+v/pmC/faDgsmBXVqsAIaGpimbpDGCgf0EGCx4kqNCIPE6wa21etNT
         ZXXthWnhbbVzGEYLpFwlSjStCUdsnZJ0xjVal+5gS4LGiwwQgSSWyr7cff2PsLvh6x1/
         HZY1KOVA40WCNF3QLTSZlYaeS9JAkSqc66XncclTC8OPGmjKf0G9bFK+RcKQqkPDbp9U
         ArAw==
X-Forwarded-Encrypted: i=1; AJvYcCUQmR2H6hEs2QiWbCv2FYknxcmjbYJl2wxLBdf+/TPZdzUQk4NjJ7x1xZMQRwJwCGdYsLfJCYHuMnG4azcjxA5t8/9inYTvMo5Ptvo6
X-Gm-Message-State: AOJu0YziKiXUWw5T010LFPcRaLAH7ro+4fIojraalQW3j+kceTk6Qy7Y
	CbAYP58+CcwNImRgVLOeVhqzIagvkUHSaFHRbxlOe15wgdo7IkvllbtyIxBG+IQjrSByMXy6Z6T
	R
X-Google-Smtp-Source: AGHT+IFmfX3oCmgw3h0mXt1dqnyVJueOjZQjBdYc7SIl1OC+ATI8A8SOR6/3y5K4612gXvBTvVyuNw==
X-Received: by 2002:a17:906:d553:b0:a7a:a5ed:43d0 with SMTP id a640c23a62f3a-a8392a15b56mr932799666b.47.1724154944359;
        Tue, 20 Aug 2024 04:55:44 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6c1dsm751413766b.5.2024.08.20.04.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:55:44 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ocfs2: Use max() to improve ocfs2_dlm_seq_show()
Date: Tue, 20 Aug 2024 04:16:07 +0200
Message-ID: <20240820021605.97887-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the max() macro to simplify the ocfs2_dlm_seq_show() function and
improve its readability.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/ocfs2/dlmglue.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index da78a04d6f0b..60df52e4c1f8 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -3151,11 +3151,8 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
 #ifdef CONFIG_OCFS2_FS_STATS
 	if (!lockres->l_lock_wait && dlm_debug->d_filter_secs) {
 		now = ktime_to_us(ktime_get_real());
-		if (lockres->l_lock_prmode.ls_last >
-		    lockres->l_lock_exmode.ls_last)
-			last = lockres->l_lock_prmode.ls_last;
-		else
-			last = lockres->l_lock_exmode.ls_last;
+		last = max(lockres->l_lock_prmode.ls_last,
+			   lockres->l_lock_exmode.ls_last);
 		/*
 		 * Use d_filter_secs field to filter lock resources dump,
 		 * the default d_filter_secs(0) value filters nothing,
-- 
2.46.0


