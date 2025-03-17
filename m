Return-Path: <linux-kernel+bounces-564717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B983A659AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577D319A4A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6C51DDC15;
	Mon, 17 Mar 2025 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv2eVjMZ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76BF1CEAA3;
	Mon, 17 Mar 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230765; cv=none; b=o59lhNT1xdoH7keP5EVcqsYs+5TyNQ+DiCD+jN5K6/QqPdKCx0XnJPwWs/ra2QBtxiO0h/v36LQNhjX+cG2J8WXf6o1fkWVywfCTd1Ggfy1ZXZZ9JbOxviyCCfNvcAT7Bat1RaeR5eiU1DOXG93dlWpmGvVZen2wMkRc4VsNzxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230765; c=relaxed/simple;
	bh=5Q7w+OJ7l1ZDm/tsxPV4eM7NaDik6tbwMLcJgZHoSpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YHNTNcU4XiUAeedycDAtpvBZ5jK8S75AwLt6uGLPeTLmsIoemmmy4Q9xEsSCY7t5G2/Jo8ZZJuxM2QysbYyypWy22xSspIyjWWQOGKlFEeFth89jiVOLMj5O29HP5wLbTwK67x1b10sm5Zdz0lw9F2Q3tuyr9pVq05SiSzFPvEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv2eVjMZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3914a5def6bso2477081f8f.1;
        Mon, 17 Mar 2025 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742230762; x=1742835562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zyGgK84Il9TLLYSLWDjMI2QVCsqArbRSKD1j4zncwxU=;
        b=iv2eVjMZa/6Dm1LYIbp+xNEyCqNU6vmu23FdTVqIGt5EOPE+hEAth0V9+X/CXEaBCb
         5M5Rlgd9tx8N+0XwAkfNIdC/A0wve9OMnM5Ih9E6ZAdhSc19vpczDqsK95bN+clQYmYi
         HyMU9U4vhuZhxPTIzpEXY/AcbYRl4xs102Bhf+h2X3PdcmiFyA8R1woMCEOyp//fAJEI
         z4ykexFiaKmSdidb3gpftxgxEDjgHt2OVDq8MA9KoZQYEZZnIzEKaYZUkHgDErE3LvXS
         QkSlypfGwgmpmfx6jQqvSkaD9v9hJNUL1V6SS3LxfP/7rgsa8zUKlch4tUF8PXqVvt+R
         Mk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742230762; x=1742835562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyGgK84Il9TLLYSLWDjMI2QVCsqArbRSKD1j4zncwxU=;
        b=d4Bx16aMz7hWHRM2J7xlAWC6gX4HX+R2WxhvxBr3vd1L9LUVE8iVnrgcR1jTrzSxAZ
         VqTBNU6G8Wu4HC2YKZwV51uliVToEHOsSzf6wvjIexOPjezit8334avVGhA0VxvxDwY/
         AC57QyImeWDZBpbBGetlIWecn4skiZHOUwQRaxulDe9brIx+BmArcLAFdr9SLl301ku3
         doCsoYG1jX/e5P7ZSXb8nSt1dDfuLTz5rK7RnBGkAu19/512pGfTI8b/UcRxti3BUcbK
         0f8PXTAtWsptIvJDjTUkun7iwLZmVPSie+FXmzaHYCsAxE+UWUAtl2NZdeoSBHRxOVby
         QW/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2wt95GLcuGllnoFr3MFyxBSrLwpOOeeDrObfc51euVEKy1DrDDU+ohEX666v52WclUMu2MwmEurQ9npU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMOXk+r9WzxtIFT26twtVES8k5+LSVXyrM/P5ONdPB61qndfdl
	tYvlRmpF2zMlnz7N4BVqLWDjZQ7cALKdkwloS9TRpY+2UdP96WLg
X-Gm-Gg: ASbGncseHRs7rlhA1CHFD/qn5EtF2g35VuSMASgIstB+oJUhDGwVTo0OoIqZefUgivN
	RIw4LG8ql4uwHZy5xjiMkiYp+je9bX0ogm/Zrj9xCjUo9f+Jap6N+m1mCojW9CvKGAdPstqWNBM
	6dkwaRtPQShLBxcgELYDT+EKUNf6vVFZBkl9wxMU8Al7co3GWQ0aJzVsu1v6nxuJA6z3v4fGj2P
	qyA6m9mhpIwcmH0K6dhNFTMu9SlqWPEYgYO1DMX4J8djGUm6aDaaahHlkzaeLO7piPEBfjQk05t
	10VI7m4mN+Hev+scMZ3W4UHdLffVPVfshu3XXv/9HClRfQ==
X-Google-Smtp-Source: AGHT+IHTSvBupVcvyiWw5zRhB1DlFobM5fMY1RLGC6HrdyKlgNfYeMkZerhgcR4aRzfPs5HOYlrbdw==
X-Received: by 2002:a05:6000:4025:b0:391:31f2:b998 with SMTP id ffacd0b85a97d-3971d03ed60mr13509122f8f.6.1742230761660;
        Mon, 17 Mar 2025 09:59:21 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d1fe05e8dsm109443415e9.9.2025.03.17.09.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:59:21 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Subject: [PATCH][next] regulator: rtq6752: make const read-only array fault_mask static
Date: Mon, 17 Mar 2025 16:58:45 +0000
Message-ID: <20250317165845.525593-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the const read-only array fault_mask on the stack at run
time, instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/regulator/rtq6752-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rtq6752-regulator.c b/drivers/regulator/rtq6752-regulator.c
index d35d844eff3b..618904ede72c 100644
--- a/drivers/regulator/rtq6752-regulator.c
+++ b/drivers/regulator/rtq6752-regulator.c
@@ -105,7 +105,7 @@ static int rtq6752_get_error_flags(struct regulator_dev *rdev,
 				   unsigned int *flags)
 {
 	unsigned int val, events = 0;
-	const unsigned int fault_mask[] = {
+	static const unsigned int fault_mask[] = {
 		RTQ6752_PAVDDF_MASK, RTQ6752_NAVDDF_MASK };
 	int rid = rdev_get_id(rdev), ret;
 
-- 
2.49.0


