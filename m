Return-Path: <linux-kernel+bounces-369512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 313109A1E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06B41F2328E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6091D89F7;
	Thu, 17 Oct 2024 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="MPKeGgq+"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199691D934B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157184; cv=none; b=So+DZ2nwsg+rPdA1v9kft2xAvZohFw809pRVZr+7s7Q8jYG4Pbqkm7BCA5xJoJn5SbtEl16LAneT2zVMffIrgmTuTBSbqB/gRx6LZd1bWjAALu1ncXUDu3vm+3aMzBKgK6QEYekvAE5aJQj9+fBD1vnMqTZGvsWP74SFg3YxiLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157184; c=relaxed/simple;
	bh=GVh5VyWkqC7o+XRonpLlh2qGC5xnezpcQmYSGJaGhac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m9rVL7Ou9qamz8xq9YQQt+ZzRNv1DFDuUbTdiz2GRaPLHO8betOrLgUcGwp+1HiQSC473Q1TEral8+JvHu2jvc4mj9ymvHHiUu4viTkygi8voAwbUWhlZSoOySWXnX7Fnes+ni1Q+c+S5gAqZbJHguOUoBTnDNA/OVSeeaAXxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=MPKeGgq+; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71815313303so55110a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729157179; x=1729761979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3N3DRZ09rXq2ioh1KFz6sEVJ5OoOv5z6eEm+fY0xnA=;
        b=MPKeGgq+bmlD7faVO5neQbC1+LmCESCDRcp/gVxSpfwcPCN4pDwlJQtp5fYChJxY0g
         qYn7rALSysmVlwwVf4F09QY2p5HR2lcHrKD9kjEpQtDcjCzcxSCu6dbU5sdpTfps4+me
         hitrxOGqy4SJXHy8vfT9H8XUa2APhHI7VPpO6tUUjJc3e1ohOT+CIA9s4I4Lw+WSDkkb
         WWNqv9QrEdfZlsTsSrPpdJeharcj+mqgxaqnjpbcPGZ8zgSsM+PycvsBcJWRtqCjh9cv
         mJlEjzLvw3NokvjXS9jkRxEPmwxrOtzebLMjTnsMD9xlFirMK0D82US0eVNT1Q02j2My
         appg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729157179; x=1729761979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3N3DRZ09rXq2ioh1KFz6sEVJ5OoOv5z6eEm+fY0xnA=;
        b=t+VrD9eZ/mkSFYVn4+6xjYMLC/2c2yEPjHfoNXpNWCqT+/nJ872WhpoA/u+QI+sPUy
         FZFSiD+VSrzLV9HUeEhDn0y4/NbaEkUwiGa3UrblAjNEKfqKAeZDfhKwmK9WofkaKN1y
         RfGWSW8zX+kfiI9BaQCR6N0+P6Kxk8oNzCADSoJ8Ogvyh2FO22mNRXzOMBwnun1BS1ay
         bht1CvyQqAx616rifSy2thAlfa20Bk9b7U9kSQ6MgumGz3f4u3aJ52IUAfrBgqNlSsgu
         8LXuqw3Tm3ZxzVz5RWppQmLc82Nie2dWiSxlueIXmIxVu9yPgPjFY0pzUIgTLHd1Jf7a
         XIXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsMH2aiGDR4d0sRbdWjS+afbRlDmcE3SyigGDK/Iv24sA11wgMqmgw6+OPDm6K/nWItUfZrLrhs3TcK3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvF+uHbYTbfjHlY42LpA1vAhgr5ga6xyixPVPe9bggL/DNdHy
	QXY7TPdA1eru5DFGP7N5Vi5MgABmXMaGfaaqE2tdSIG8Byx3TCYDKMn4jlPKf6I7B8NJfLryKQp
	vd5/uNwaD
X-Google-Smtp-Source: AGHT+IHFu6aDuJwO13ZN7HBGLSpCzZMGYriSy/NfP+4SeQedmPA32TsM/6TK8yVv5BdGu20RNJa2DQ==
X-Received: by 2002:a05:6830:6186:b0:713:698d:928 with SMTP id 46e09a7af769-71803549c42mr6602549a34.31.1729157179059;
        Thu, 17 Oct 2024 02:26:19 -0700 (PDT)
Received: from localhost.localdomain ([132.178.238.28])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ea9c70587asm4623972a12.72.2024.10.17.02.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:26:18 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] staging: gpib: Change return type and error code of fluke_get_dma_residue
Date: Thu, 17 Oct 2024 03:25:10 -0600
Message-ID: <20241017092511.17621-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fluke_get_dma_residue() returns unsigned int with -1 as error code.
This error cannot be caught.
Fix this by changing the return type of the function to int and 
returning the error code, that was captured. Also, change the data 
type of variable residue to int in the function fluke_dma_read().

Fixes: 55936779f496 ("staging: gpib: Add Fluke cda based cards GPIB driver")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
V1 -> V2: - Fixed the caller
	  - Updated the changelog

 drivers/staging/gpib/eastwood/fluke_gpib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index f9f149db222d..378687eb619f 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -536,7 +536,7 @@ static int fluke_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length
 	return 0;
 }
 
-static unsigned int fluke_get_dma_residue(struct dma_chan *chan, dma_cookie_t cookie)
+static int fluke_get_dma_residue(struct dma_chan *chan, dma_cookie_t cookie)
 {
 	struct dma_tx_state state;
 	int result;
@@ -544,7 +544,7 @@ static unsigned int fluke_get_dma_residue(struct dma_chan *chan, dma_cookie_t co
 	result = dmaengine_pause(chan);
 	if (result < 0) {
 		pr_err("fluke_gpib: dma pause failed?\n");
-		return -1;
+		return result;
 	}
 	dmaengine_tx_status(chan, cookie, &state);
 	// hardware doesn't support resume, so dont call this
@@ -559,7 +559,7 @@ static int fluke_dma_read(gpib_board_t *board, uint8_t *buffer,
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
 	int retval = 0;
 	unsigned long flags;
-	unsigned int residue;
+	int residue;
 	dma_addr_t bus_address;
 	struct dma_async_tx_descriptor *tx_desc;
 	dma_cookie_t dma_cookie;
-- 
2.43.0


