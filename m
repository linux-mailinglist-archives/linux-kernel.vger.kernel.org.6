Return-Path: <linux-kernel+bounces-240622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B736F927002
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CAB284C76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DBF1A0B0C;
	Thu,  4 Jul 2024 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUcVL8qX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F101BC4E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075944; cv=none; b=tSeGikvqAkdnyi9f+kvzmwrzr7Ri/DlRndcTxtvnEb2FRzjnBX6vL1NdkpPNM4PyXNL0whITLd9ewgaWBSVmUudXNml+9yX5QCN4xHy0rONIRwmmfxIC/RYqtx7EglSY5nCZSjZq8q3C71rnkOUubw7vqncAn5b1sY2pWbD5oGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075944; c=relaxed/simple;
	bh=HJDaGmoijA8IivDlw4ITokq/M9xuWc6aBVPFDUB0iYg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uGkEGRPkvfFymF0RQzMMuq/bM+dQoni7KdsfotzOiCJQ02UV/U9hHadcYILfGRuoA3XlL6H4dRA0y4+1ANeNAt5mgiNjMj2rLfUlvaDGFVvDlTZNgw8MxwIPXWSdpVFT9l5Z+2ohYr425uEIGvB8FlPsPGESnyr94g0S9jd9iHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUcVL8qX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa244db0b2so1998895ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 23:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720075942; x=1720680742; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb7qEMakmFij5zhdLHflF693Oy2d+rmi2NgGIv7uThI=;
        b=LUcVL8qXzpTX+kcwSueVLz+Vc22VkxONUFrQo+qpSKw1+wXdksjaNdg7RasC+XNbPn
         QOuW8fc8k3/p6ZSQSvVqnt3JKLRZJ6bzB+AnNxzrsX7g0y6yPYshCb+MwQPIPey1saDP
         C7y9Mj/te7VUHvLjT6EBtyo08qXyT0Dzbq31S8i828Zyx3y4nvWnPowfOql7Zx6O72y/
         +mNfCEfG6KGvBUMMn8+ibyYOfoglUfNVA50J3twrOA9K+VOuRHnYkDXShP/v3WwaPR98
         PJBOA0rkNKC9VdqnnS41hwynjtkKPXlwIVyCpKXakaqK8mXHNuU5lsRkTbT6gXvuSrdc
         uJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075942; x=1720680742;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qb7qEMakmFij5zhdLHflF693Oy2d+rmi2NgGIv7uThI=;
        b=ASKKlZL3tiugydjtK7MP9zio4oaZgsPX/d+yGg43iTCLyLRTb3M9ZW8a7I4MM2A8Mr
         thDq3WEC+W2bP895qz0SOemLiJ8u6j0NpbTYVldOARBUWc4i1DKVBrgvBtWoeDjIrczR
         AOm/Jdn+A3p2B1Dymwe4j+56WkEAOfHd9dyRvfrRyzycq8ux2yLDN7hPCIN2mL962QA+
         ocymqnDxdKP3JqUKdu9SIKmDF5wPLFgvH/EyGTiZdCGy4rEI0A6FrHad6XLSeGfg3/FY
         g1PAhFjrKSNlmUx4xq9c1FZd4oF8/cW3iy4MtInPFDX6Ca16Ox0Oz0wjr/994fFgZuTd
         RYUw==
X-Gm-Message-State: AOJu0Yy3eQLe5u8yUU+Gsq+3q7u+MPc+/QShxFLzNKXsvWQQQ9bop+dv
	k4Zz8IpEPHvtkFlb+k5PYDCay11Ki0piDh0PEH4vXRU+ADHpXOrB
X-Google-Smtp-Source: AGHT+IFGhuYncYUd5lCY/Rs8aSDcoWkdWxNKb66fdLNPpmPLF28xg8Jzo48BCnbCswA2XTGI3/LRCA==
X-Received: by 2002:a17:902:f690:b0:1f7:1b42:431d with SMTP id d9443c01a7336-1fb33e7a014mr6436945ad.30.1720075941786;
        Wed, 03 Jul 2024 23:52:21 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb1cad5b4dsm22615155ad.105.2024.07.03.23.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:52:21 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	imran.f.khan@oracle.com,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] smp: Fix missed destroy_work_on_stack() calls in smp_call_on_cpu()
Date: Thu,  4 Jul 2024 14:52:13 +0800
Message-Id: <20240704065213.13559-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

For builts with CONFIG_DEBUG_OBJECTS_WORK=y kernels, the sscs.work
defined using INIT_WORK_ONSTACK() will be initialized by
debug_object_init_on_stack() for debug check in __init_work().
This commit therefore invoke destroy_work_on_stack() to free
sscs.work debug objects before smp_call_on_cpu() returns.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index cc13e73a887c..61f10f982341 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1135,6 +1135,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 
 	queue_work_on(cpu, system_wq, &sscs.work);
 	wait_for_completion(&sscs.done);
+	destroy_work_on_stack(&sscs.work);
 
 	return sscs.ret;
 }
-- 
2.17.1


