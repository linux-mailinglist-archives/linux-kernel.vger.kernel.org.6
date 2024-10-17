Return-Path: <linux-kernel+bounces-370666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 810B69A307B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D5F1F23625
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA51D63E3;
	Thu, 17 Oct 2024 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="WdcZHE7n"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A551D07B0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202943; cv=none; b=Ak65NyFzYutgXeRuiyg1O96CpUMvpT8hSt7vyvjTJsmF+roQmhjqnCdz3rIcYimTchIq+6eCK69HX1g4o/m9t9i+4MI5G1RTehNs2IARLUZKSvAvxZTjWNFRW2D21j+oIgJr9WdXolIKPK1NNbpA4rTCiudAVPpwckhLq9NQND8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202943; c=relaxed/simple;
	bh=C1ettZhXIGpXrwWmjEv8ZGd6Xkvv0nVVh445vJUf5sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSygLcwzzAgjSSrPQNL/Ga6q3d+pJQePnXMuBJTasmyV9JjNMQemlGMlh1WXyKFT2rD2toZYycp7b0hXXhW2kV38oUz38sH6/JnyyYgCCdVWECSa0BWUSYNWeSEsjCwiCd8nui3Ud3+wchbOPATOOxpwmZynxbGL8oNl/TAmy0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=WdcZHE7n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso13857245ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729202936; x=1729807736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UFsgI9iLkr6zyS/OFRJNfMmcc362Y5tywufpoyBtvb4=;
        b=WdcZHE7nfBmxo7/S5JpX6UH+AemhY8Og1+WV2UIV4mLivj0Qr8CWO+ip8fiCNUK/bJ
         ZaExwM23sg+CjaxLZ8vj035omFrNWZCFkqmGVjRGAUIlV7tWXA5pTIfiHiwamvrAbAJ1
         6enU/uTlfzwZzS+P8/9m5YRV7vKZwVvZ0qm6j4sySWNrh5S0yFU4JV14ew1NyFct/14Y
         7f6+CZlGNJtbZS8NQGSgfGDnODMxLYb5ZD+2Z3VPcGVlTiQduA7MRplalqdC+w7KCp/K
         hlCtL1IgktseT95YII6lvb4SmphtSnj1/FJcpt0AQu3lSksIaUBQvvYQ0OvhZBcKWbEv
         Q0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729202936; x=1729807736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFsgI9iLkr6zyS/OFRJNfMmcc362Y5tywufpoyBtvb4=;
        b=Oqa3hayoWwyWTBxK0CQ3QXapBy8gCOVJy+W1iClF6njLmX5GgLFHc8hImoAEyojRcH
         593aQR/xMJrOh1NF6dMrbjNOkKL8fDCK4OgAcGFXpROdjXALr543ESvnowi7gYmUt07K
         /SdMuneBMsqLFffRwMuoOrDglM9/Y4b3cjOOurpZisBpx6Hh4pwKyQ4F3vMDdk0/4xW4
         guNfYKYA865082mncyAGRKbv67t6EXtKfxywc5msVDRunLXQN++YH+VstQmJuNcGbAx5
         zcdSv0p9SD33Lyqpi5wagoCYyG8ssYzH9UfBHaXgRkarNnNXt+EqcCoTciOYPRQr+T50
         HNWw==
X-Forwarded-Encrypted: i=1; AJvYcCUT5QP/ChTtdyDLW0zNN2uSuq/gnk36fESEp3dbjWFUBuZroc73EOAQvUNQeZifsWCLXcASo3+A7gu1qXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbh7FTj12p+XF1aw6N63hX9OFDUs6EPdEP2w7XjQUhj1SXshgJ
	5oudruEOc/CLAS+ZpmaBwg/8zb1QAsE1HhkHgxbj0l5SkKzvBqdsEnG+sYVE0i8=
X-Google-Smtp-Source: AGHT+IHCVP3YjOBsb8yQ3gloeSYLh2v91BcMDPYOPuSD9t8hzKslsYpLanvNx3VoPuzhOWozWgRP4Q==
X-Received: by 2002:a17:903:120e:b0:20b:8bf5:cd72 with SMTP id d9443c01a7336-20e5a91ac36mr4702555ad.49.1729202936501;
        Thu, 17 Oct 2024 15:08:56 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.147])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e5a8f4c20sm1131545ad.221.2024.10.17.15.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 15:08:56 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	nathan@kernel.org
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gpib: Change return type and error code of fmh_gpib_get_dma_residue()
Date: Thu, 17 Oct 2024 16:07:24 -0600
Message-ID: <20241017220740.30370-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fmh_gpib_get_dma_residue() returns unsigned int with -1 as error code.
This error cannot be caught.
Fix this by changing the return type of the function to int and
returning the error code, that was captured. Also, change the data
type of variable residue to int in the function fmh_gpib_dma_read().

Fixes: 8e4841a0888c ("staging: gpib: Add Frank Mori Hess FPGA PCI GPIB driver")
Reported-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index 0e27b3ef1a1d..802043ffe684 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -547,7 +547,7 @@ static int fmh_gpib_accel_write(gpib_board_t *board, uint8_t *buffer,
 	return 0;
 }
 
-static unsigned int fmh_gpib_get_dma_residue(struct dma_chan *chan, dma_cookie_t cookie)
+static int fmh_gpib_get_dma_residue(struct dma_chan *chan, dma_cookie_t cookie)
 {
 	struct dma_tx_state state;
 	int result;
@@ -555,7 +555,7 @@ static unsigned int fmh_gpib_get_dma_residue(struct dma_chan *chan, dma_cookie_t
 	result = dmaengine_pause(chan);
 	if (result < 0)	{
 		pr_err("fmh_gpib_gpib: dma pause failed?\n");
-		return -1;
+		return result;
 	}
 	dmaengine_tx_status(chan, cookie, &state);
 	// dma330 hardware doesn't support resume, so dont call this
@@ -717,7 +717,7 @@ static int fmh_gpib_dma_read(gpib_board_t *board, uint8_t *buffer,
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
 	int retval = 0;
 	unsigned long flags;
-	unsigned int residue;
+	int residue;
 	int wait_retval;
 	dma_addr_t bus_address;
 	struct dma_async_tx_descriptor *tx_desc;
-- 
2.43.0


