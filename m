Return-Path: <linux-kernel+bounces-246074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4A192BD50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3012E1C23A8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520FD19D070;
	Tue,  9 Jul 2024 14:44:18 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885C19CD08;
	Tue,  9 Jul 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536257; cv=none; b=TVijsalVzo1/pAwrv30PQgVLyYYfsC91MV7sg2v5SKNUrasj6ILPaOhfO9n0YUjlq9204Pp1d7lP313BdZOP5XkqRBArvDwLtcDUxZbvjQ3y8/tDCu0ZyOtH1h4bHNCCn4fX7EHQDiS7bEMn19qZLQFyJNYUZohgGP7yQs7I54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536257; c=relaxed/simple;
	bh=W6yMqaE41OlDBEIgiNxvVuVTPZrqwpqbKz79y1d9LiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTvjtmtpfs7IptwppQWgbsumhToayKelXjQ8tfmDedSr2TDl0xpejhL4EhFB6GUwiX+3F4UGumgCaAhvRhFaAAOOZFzXJjrfJN2kROOKTPGjkCAq5XheE8oUmRtFIwvWLBQe67qvL4TCtHdEEIjlDZ0ETcq+bjHdDfrScmIriUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea929ea56so6735677e87.0;
        Tue, 09 Jul 2024 07:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720536254; x=1721141054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53Fo5RNi03TqYv7uPWkY+kGMfarDzeZ7ETXCPaSupjU=;
        b=q+qkz5zvd0NpXbqDMOOurucf9dZ4GbeMKtgZYqhBDXGtgeRoEmNtBNKujlyvpisPJT
         CpP8c7Mah3y2LxhS+jlA6n4l+IX1qmXyTSwzCXonmlRP6v992Hdxn9gczftX8SvLhUXl
         qjDC1iAJAjsd+wGqsoTqvxZxS02MlunvYcS4b3DFk/jJYvbuFFttXRKTeEsM4kmNBm8n
         /rlrhWW3LTBomqEFE/b/AsCq1xIdFvVLhLSGKK6mQyruM+8R4NRP6i8Vgw28pDnSM0UD
         kK4YGiuW1JHFS2OfUFF0GkJF7imU3GO3U8MA/4eymSZEYjuZEPfzqlawk3ieCrIyabaG
         XbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0brtYC6icFlmfOB8fHQiUeN/b/2TcvOnv3CckDGXG7iom+TjszfR9X4H2TiRWBbcVrx12NYd6rGVHvcUwm7WD5Xs4zgQZYIdwCB+taCRfk0lv8k4E+b72rWCaEWwlfTGkaxXY
X-Gm-Message-State: AOJu0YwQp2fejaExoKzyGN/7cixx/NLCkuujpz/Ns+0BLOQe3DJOGZBQ
	M92JszoPGGYGfIWKcNQj4Rkps5YAdqLxwUIQFBhU+dM9Srqc2vCQ
X-Google-Smtp-Source: AGHT+IFfIk+h8GEmouVc0xm9avRwo62OFN2pEtBtFACYaLeOQkZmii+MMY9mAZqIWoK5/oKaqEzSEw==
X-Received: by 2002:a05:6512:1247:b0:52e:716a:1898 with SMTP id 2adb3069b0e04-52eb99d5ff5mr2275785e87.58.1720536254051;
        Tue, 09 Jul 2024 07:44:14 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7fef4esm83003766b.121.2024.07.09.07.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 07:44:13 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Cc: thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] net: netconsole: Remove unnecessary cast from bool
Date: Tue,  9 Jul 2024 07:43:59 -0700
Message-ID: <20240709144403.544099-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709144403.544099-1-leitao@debian.org>
References: <20240709144403.544099-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'enabled' variable is already a bool, so casting it to its value
is redundant.

Remove the superfluous cast, improving code clarity without changing
functionality.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index ab8a0623b1a1..de0d89e4e4e2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -344,7 +344,7 @@ static ssize_t enabled_store(struct config_item *item,
 		goto out_unlock;
 
 	err = -EINVAL;
-	if ((bool)enabled == nt->enabled) {
+	if (enabled == nt->enabled) {
 		pr_info("network logging has already %s\n",
 			nt->enabled ? "started" : "stopped");
 		goto out_unlock;
-- 
2.43.0


