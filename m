Return-Path: <linux-kernel+bounces-367514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C77889A0345
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05AC71C27B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB401C8FB4;
	Wed, 16 Oct 2024 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="YdBAodOG"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4911D5141
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065268; cv=none; b=a4yFkXZGbswZGdOIpnAX53Tw+ltlINg+KYSyGr605JZPdNlIqLa+cYo6NJxGcWn63VOiIeNZyxIMPAlkapLyJaygarCuO7pkbI+k8xOktT8xPjHI0c1E4gNh9pFBzsTaIh0wVzpeING6TRcKO+wkfYdX9zbtdZ1/HBVKooiPNNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065268; c=relaxed/simple;
	bh=pzemOVMWm3UmIYM1ZkUNL8i+q+D8kbSwIq6b2AW9isY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdP1ybYfxiel+UVBi/wp28CaOCeMBHblcFoUQcFZXBOctqojMDe0OIoY4NKJkNXaJCFV7EdLbjSAoEnAEc8ujJypqjGtQV2ZVb+UAF9zq5ob3C/Hhii2tk/DBLdnnFmbdqaTbCorVWVlNXSd3V6Sj2LQWHN8e28IdohmH2itjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=YdBAodOG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ceb8bd22fso24201095ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729065266; x=1729670066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BFR80fYrDpP6X7LmDbHOd9DE6LuBDDhguOyT+PK1VWU=;
        b=YdBAodOGm3+eQrsr4G0gaIKO8Ljm2TCBoHgc9PzJ7Hw+YwId/6bm3q72BV8/0hgVO8
         qN3nlAyikTrgTvxJk/uVj34LozS56xEPZMCIaNXa2anvN4aLo1pMlfVNAPtuk15mA1M3
         3e9O0IY3r36rDKx9PcGPDt9ZLZbaT7LGMeEjt8fyYDBR+10FVwM6Oi8Ph5hJycjllPMJ
         XEPew3dn0B8wMARdwZxE0p82wuF73GW8PPUGphCX9Ht/abEomzGcN+xAHVnE3wfwKE8f
         22GHSaWVEonYGayh5jbVb4QpWK/IvNO+b+GpyTrEegdpliZuqvhV7Lxv7/NDN4nxhACi
         pQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729065266; x=1729670066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFR80fYrDpP6X7LmDbHOd9DE6LuBDDhguOyT+PK1VWU=;
        b=Nx5VzoS9tgQSJCr0NUfhSL1T/igOYtbA1m5b29l9wUxVvObjuNVdt2AOJBDvUtGc9D
         Uzw5yLFPPza1qIH9kj/wFZ5q/JStKi573vRM2pbYTjhzdOBC8bZqW2q6Aqexw5YAfnMW
         SOlN0Zlimq/o8kJ5EA6wb3WMDwHFWzaq6ngC6crWlFhEQQZOkN5mgQywqFcCaduhuB+z
         bcUuq3A5j8eWkYrFjL2da6YhinuFmDJp6KLnhQ6yHXV/N19ew7hRg++MguCXyDacpnck
         OCOXbrGtgIzbbpKU5y1c6+5b+EiILMRjjzMFlSdRCsekKTSdSHF3DDyosL7C0aVaKBHt
         Jffg==
X-Forwarded-Encrypted: i=1; AJvYcCXst1shoSEswxnVygDevKfOCjY6WCVnCG7RZlf7hGXQfsOcFW4eO9tiRyP2q2sU2EcbuFbKK246gv7GKpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6JEMlSzSfMuKRKREf109H4eVOyVlDzrtgpZimfuSGQM+hc/G2
	jUrtJTYrZLrrrt4CEy80jKRWmYwh0hAudvMr3ORZNvFMWOZDBZ6+3btkXScv5g0=
X-Google-Smtp-Source: AGHT+IEUZnnpNJ+yGIHniIzFYqXySalU3xZmq4Xh79xaZ5D3jOGyUYeoLywGBCVvrAftvG6Nuiwxvw==
X-Received: by 2002:a17:90b:802:b0:2e1:ce7b:6069 with SMTP id 98e67ed59e1d1-2e31538f1camr17781211a91.33.1729065266295;
        Wed, 16 Oct 2024 00:54:26 -0700 (PDT)
Received: from localhost.localdomain ([132.178.238.27])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e392f7605dsm3370980a91.54.2024.10.16.00.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 00:54:25 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] staging: gpib: Remove a dead condition in if statement
Date: Wed, 16 Oct 2024 01:53:18 -0600
Message-ID: <20241016075319.4092-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable `residue` is an unsigned int, also the function
`fluke_get_dma_residue` returns an unsigned int. The value of
an unsigned int can only be 0 at minimum.
The less-than-zero comparison can never be true.
Fix it by removing the dead condition in the if statement.

This issue was reported by Coverity Scan.
Report:
CID 1600782: (#1 of 1): Macro compares unsigned to 0 (NO_EFFECT)
unsigned_compare: This less-than-zero comparison of an unsigned value
is never true. residue < 0U.

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
V1 -> V2: - Fixed typo of comparison in changelog
          - Removed Fixes tag 

 drivers/staging/gpib/eastwood/fluke_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index f9f149db222d..51b4f9891a34 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -644,7 +644,7 @@ static int fluke_dma_read(gpib_board_t *board, uint8_t *buffer,
 	 */
 	usleep_range(10, 15);
 	residue = fluke_get_dma_residue(e_priv->dma_channel, dma_cookie);
-	if (WARN_ON_ONCE(residue > length || residue < 0))
+	if (WARN_ON_ONCE(residue > length))
 		return -EFAULT;
 	*bytes_read += length - residue;
 	dmaengine_terminate_all(e_priv->dma_channel);
-- 
2.43.0


