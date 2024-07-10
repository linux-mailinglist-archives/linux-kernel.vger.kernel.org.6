Return-Path: <linux-kernel+bounces-248241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F6B92DA83
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DC7284F03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0D12A14C;
	Wed, 10 Jul 2024 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="DiaSjFal"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19681723
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720645318; cv=none; b=QGts1baz6T5+axnx0jhFWGbWLqiueUrEDzhrRloyRqUKRxTLRnaYDY1O5Yo7Dko81/M7DFlgsSYWCsMizCMpL1jNFQcfLg0Uecv+lc5zGD9APxW1ZIL5L12nWra7P14GM3Ot3GzLFJj6CpvzSxblfOJkTNWKZIzdShNZiuNRQRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720645318; c=relaxed/simple;
	bh=uJjXrGcMu8RjpDfGGmOQVnAvn8BDTyPZX6ZiQktuOuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4Q6vREob3P4ZUwwLkr/LweI1YMrMGhnPRDuSAncXjnuzPww2Fwp9D+jHhCmChX2wMZFOnUtX15qRAJozcDH1T0LtYAVgJf7a37RiGR3pwpe5ZS7aMm2vw0iRx7tf0hH0ujinUEVazqlY0Y/5oQkzS2GewG0dj1QYpLU2almWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=DiaSjFal; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee91d9cb71so1854261fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720645316; x=1721250116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vfPD6oQM4WTY/ZUL1ljka0zg8gHP6mHHiU2gRkoeXcY=;
        b=DiaSjFalN/F50wahFAXbNwCw3+mnaxE7zBhHQEp5D125IWb4rYLvFrziRs3/zMCwZe
         4c68ZuJ7cG/yAuuLQz9RDo9P+cb3k+ZKcFI1e5UBBlYWMDcmxPjLwu4fljqbmZ049/Sv
         g84Tiqv2IWV/Uazx8R7Fhwkr6bD+Yhn3eQUWrJvWJiIZ6gB1h4noQUP6JQWU+81kQ7I5
         LRtx3yr7FhvefY2Z1aezoNbFWQe5sDvvezJubf0Swbbqc7Nw/d0m3hJUhhrm7EFpplsS
         +Qtw5EziPq0PydbsXNRq4NsRIvDA2drtZuUZgLXZa+uVtmNpT9UHCbzPY50ZPZIvUHj/
         +7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720645316; x=1721250116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfPD6oQM4WTY/ZUL1ljka0zg8gHP6mHHiU2gRkoeXcY=;
        b=G1SjoUARa7BjLRvsA+/+75CdlRz1gRTijPpYxWsNTF9uQBa2IpTjqeAEZqnZeMswLK
         cYEO3R9GyR7Efejq3ApnPsByeh1qI80ncaG177p8aaJAghqZfRSBa+XM9j8Henps35Fq
         zR/ZoADZb+oa0+mFAO9DpxRflIE1sjNmfuc06HflfnHBIYzTYIr7Xobp/aYz86QpTyZO
         tLtNHR4nLoBBKQaxkHMiVS7Hjk6napmP6OLQIMutue0gCDOvmGzt5JG8IvFxF9Pc8Szu
         IIxy9/izs538FMd4+Md0m0SNeSRC4N7J4Yu26nGPg5cc1jhEjtO7EPNMufUTLux5dAu9
         jR/A==
X-Forwarded-Encrypted: i=1; AJvYcCUcxgofoqwT2EOVI3YU4zjw9AbCg0W9/hiqQdQvplq5xbYrj7qxfjE4JRhykk8w0jzs8ZoKFE7fkwBEMwnXFnGHaIxmXfa0XWxacH9m
X-Gm-Message-State: AOJu0YxUEr6zHDEoSRLTfu3vN+LEoPV7T1tyZNcMi4xsWORvown5qWap
	Ry4dplBlwCpU2B+zZOraG0ow/2cnQ53Mv+WfvWCyqbteVmz5V4t2LR6r2VHTMAY=
X-Google-Smtp-Source: AGHT+IGvQA+P7LFh+KIoLHnBwWndid7fZ5r4y7e3S09VhX9Fpm8r0gitrY3HYtpl80Rj2AdHvdq33Q==
X-Received: by 2002:a2e:8081:0:b0:2ee:4e67:85ec with SMTP id 38308e7fff4ca-2eeb30bc9d4mr43078141fa.5.1720645315622;
        Wed, 10 Jul 2024 14:01:55 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5a27sm92480685e9.23.2024.07.10.14.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:01:55 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thierry.reding@gmail.com,
	mperttunen@nvidia.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	jonathanh@nvidia.com
Cc: dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] drm/tegra: hub: Use fn parameter directly to fix Coccinelle warning
Date: Wed, 10 Jul 2024 23:00:35 +0200
Message-ID: <20240710210034.796032-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function parameter out can be used directly instead of assigning it
to a temporary u64 variable first.

Remove the local variable tmp2 and use the parameter out directly as the
divisor in do_div() to remove the following Coccinelle/coccicheck
warning reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/gpu/drm/tegra/hub.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index f21e57e8599e..e0c2019a591b 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -521,12 +521,11 @@ static void tegra_shared_plane_atomic_disable(struct drm_plane *plane,
 
 static inline u32 compute_phase_incr(fixed20_12 in, unsigned int out)
 {
-	u64 tmp, tmp1, tmp2;
+	u64 tmp, tmp1;
 
 	tmp = (u64)dfixed_trunc(in);
-	tmp2 = (u64)out;
-	tmp1 = (tmp << NFB) + (tmp2 >> 1);
-	do_div(tmp1, tmp2);
+	tmp1 = (tmp << NFB) + ((u64)out >> 1);
+	do_div(tmp1, out);
 
 	return lower_32_bits(tmp1);
 }
-- 
2.45.2


