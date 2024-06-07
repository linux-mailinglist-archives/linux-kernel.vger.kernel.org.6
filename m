Return-Path: <linux-kernel+bounces-206185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5058B900552
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23A61F22EE5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E2A194A7A;
	Fri,  7 Jun 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Llt58sRE"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E871946A4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767829; cv=none; b=kKJpOoyp2PIEvQ6DKErqvWuB7bNQzqJbOLdPbuQOQyVdhH8pJ0R+dIyEiBa0abEfN68qWzpoxePRK/zqQ8dDm9RXLsaOWBKcDBFK0Hc/1zOln0OhCwLhqWW/AUvghDjpD9gUWFHKxd6CdRCKNq1b9k1ydkCHxTI+ReXZkRI/I3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767829; c=relaxed/simple;
	bh=yu4G++9W3cFFa3BDJeHdmx/4W9lKxnpuweqH0q9NbrY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d0mjLnxTUs24dvqbLnRT7/AHHo0qma1HblTVo/SoTyMiDoDnpyaLcYG5wbkVLT84hNlIFBPXDT+/slyqZJkD47p+MFSPJ98l7mWJONez6cs6zEI9NxYMDiva2NWdOjxPKkqWYGuuAVlTUL/CYyQ8pFvIxILxbiGJLcSRvKscUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Llt58sRE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso563791e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767826; x=1718372626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdBre1dGi2JyJKOSGF7gG4RE564btgGprcdJBommpHk=;
        b=Llt58sREFDO1vTLW6Myzic1BvU8UTReZqkt0p837QNxp7y8pTw7OQhAPnyluWITBVJ
         SlGsODBsofAGxRWFhSZINXwizkDfQeswOhqSgH2sV0QESHMEFO4aAyqPRii7/dT/Ff+H
         YfVGpyQ88gJ1ZpAvYHhs+dR23UPB0fprh8SXW+NHb8k3CUuaP5B3GfDg1q7tAU6Smn6H
         xpY6VTqZEdNnZW63XNQ8/Nthcg34fUdgqjetabajfV2hwJLNPdOaI76TE+QFtYBtzvXb
         Kn2gL8B6BwGkCyRGNYaKpNanfyJWZ6SiOPWrvX30tedvxt+P6zxGmISZSumxDfpfqAKf
         JbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767826; x=1718372626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdBre1dGi2JyJKOSGF7gG4RE564btgGprcdJBommpHk=;
        b=lX5TeoZtarVsEF2SFQVbKb7FElP08jUeUUJALErzAJSU7NUy8p3ZtK/zLCa8DyZJXJ
         NUsgl2lLIUcOU1BRkxqEiajfZRxn+1s5jSRdkXqCpgcNs0tq8G7IrGYsCjtWAI/0wzMy
         ctJWQM6BcosANmbmbvYduht9QBCpH+7uTsvI43/Z8XsLS8P8YQ86NWhjvesfFo09TyKb
         l3LvD0OsDtG6QuXn8BE9q8WVSZD4BJ4ySKjOyQN9feyXmr1YkoN6oUFc4+rHnWJYwVuI
         YvvKtZn+0yCZlj4UCv3ZNJDn16SMyPxkYNcyVV/e0LTd/FGSoE7dIMMO1O/qu1wR/ZpF
         JLPA==
X-Forwarded-Encrypted: i=1; AJvYcCXsCUQJxHr6UlAqxO1PixWW7SUyh02ZeGoZ7fKpq/7tr+XkOAZNbSXaMivbandX2IDeo1zc8eSBhgt0TKjfYQwVWRK/KMBvrv29Dr5e
X-Gm-Message-State: AOJu0YxO2tup+D7vE3GGMvVjrePIekXypdvn6AuNOmah/lKo1KWwuWa7
	On1poRHAH1l0mmSPhz4XqOYe1InwuwFQeVyBFzUQDdhdsFMFDNOLYszvYw==
X-Google-Smtp-Source: AGHT+IGMxlg8urqbwAFOjNr5bTMp9W0RVY0EmvHh1p5VgXr3s6l4vrW2FFSH8rmVQ7/n9SDcAnbVoA==
X-Received: by 2002:ac2:5ec4:0:b0:51f:2908:df48 with SMTP id 2adb3069b0e04-52bb9f7a958mr1610734e87.18.1717767826019;
        Fri, 07 Jun 2024 06:43:46 -0700 (PDT)
Received: from alsp.netis.cc ([2a02:2168:8a08:3100:a1b3:3b31:44cc:f7ee])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-52bb41ee46esm550070e87.72.2024.06.07.06.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:43:45 -0700 (PDT)
From: Alexander Sapozhnikov <alsp705@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] drivers: nvme: target: core: deref after null
Date: Fri,  7 Jun 2024 16:43:39 +0300
Message-Id: <20240607134340.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

After having been compared to a NULL value at core.c:813, 
pointer '(**sq->ctrl).sqs' is dereferenced at core.c:838.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 06f0c587f343..5a67d2bc0c55 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -827,7 +827,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	 */
 	ctrl = sq->ctrl;
 
-	if (ctrl) {
+	if (ctrl && ctrl->sqs) {
 		/*
 		 * The teardown flow may take some time, and the host may not
 		 * send us keep-alive during this period, hence reset the
-- 
2.39.2


