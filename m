Return-Path: <linux-kernel+bounces-520744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D558CA3AEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46BD3B5B36
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D491E885;
	Wed, 19 Feb 2025 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybv8r4WC"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E431BDCF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739927427; cv=none; b=mSpnv+UO94jAD+zcmUF4ucKpd53t3pUU6fop9ytKCCQBBZdWWqY7VWBj7ob5lymj0c+lihsudHzepu+FD0iOFb1/+RNvgGUGJly9CLQ+NIM7RCtjQWtPOi6A1YPUDZb1LTZjnFS1WMa44SvgsQrlgpgquSJlydNmbcotV9tgY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739927427; c=relaxed/simple;
	bh=dkzw9/g63rEXIyFBSAUuU25xtdydAr18BHvIgg/GVlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XQ0ciM9YO9CORu51sTQV0md4Ggd7pDgyizCo80Z27P0fp7kkMOmKS3iLdkAjwhUEL/fJx+mOfouw4AjRt4W2jUtrTn40bINXtWPkrxjeSJirC5A9pm33j4sOKOEwtwws//2Y05+vbRy6BBV/OGidlA5UEtbw+Nja2yyXZHZWW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ybv8r4WC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso568839a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739927425; x=1740532225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tPP20hMwm4e/s0jmdLYDurh81murirTr7TGKiykzS3c=;
        b=Ybv8r4WCNqNFRd42RPBySz2tncFRVbelJCx7UtUHGuyGzbJaCkHBQChCO/FNdlQyDw
         m/gmiVhbtkHsw0V5oGJhv9tsRgLq1GwTk2qPXaVXWMJS8QxXTcMnCJfuYla2yHf8Z6rD
         P7CGjxlwpywj9k+u+UEfnCbKz4RfeK47VCHOuNNbKP6h1mCRhVqv0xaMQ9Q+BAxGw2Iv
         yUReheFt5gChEnY38/56hYoqVj0DUSqUUzdV3BhiKDTMcPC730NXl2cm1Kr4sOpVEU3n
         DgS6EvJMNpcsWdTcVsmVq6Vpvjsv9fEuS/Leuln6L7mmeAEvWJF9ONbhHeW5aLRhmdi8
         R9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739927425; x=1740532225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPP20hMwm4e/s0jmdLYDurh81murirTr7TGKiykzS3c=;
        b=ulNpD910iIOIWpihajSrI8MzVxYlmmo1a5Z0m7piRKtgj2fvR+m6bi8G+Jh+vBaK+u
         AJdQ3GtHkyN/M3gua9AOaJVGr4AkGDa/EpubGGt/VVgAnpjIJ6udtnXf83Sa5/oNtfTy
         mmW4G5gB8A3O37gRx9hz6euo0drqmvaVo9GKA97DkLf68CSHYJ2YFnYE+PcUhAky198T
         RNAkMLpJJLqfFOUe/EidPwATvSZwj+RCj00MnBZ/bw2tQAbxR/ZWtDwNAl6bkzMKL/vO
         M8YewGGN9JWfe1QuhXLf7xZf3kIoc2DPxua8zLxpWnGme+YFo5skgB4q/xGxrTzKL4yc
         hQxw==
X-Gm-Message-State: AOJu0YwB7uKdYpecyGCPoeufv4fCSfcsQ/DW/7JL4SiJHLpX8WY6Fjm1
	tY7M+SLKT3bLEjhG8tNsNDOJ9GYFR9hVUsr12INJxZx2Eayv9ec8
X-Gm-Gg: ASbGncssyzBumOT30SNRxi3cXKGrMcd/w1OpgEWHlQ7BvTrRnQym4hzZ/0GIug/tjxW
	tao9c0PFwtp7uMyuGBM/Ua/WOWNwnBvwtPTIGYa2hFwzA3CgcnDVBV/K35nypaeibaEbxKdRwVp
	FGpjFMq0bO/1/qSnwxwNbpB8DVV8rjUrqFuNYiL1Ym1qNNGN1Lny8S0qu959DTQi29s6mahjmzz
	B16WpTJ2kW1vuEcWHDlGe7XXf4lPVWA7hmdX7pBr6jbL+/bNB313DuX8Ws4x/MPNUwjQheoj20x
	6OMN2uKUmD6Ywbw08nOBvoXByQ==
X-Google-Smtp-Source: AGHT+IGGAt2uTHnIMgc2ojQC/dDaRgH+URJZl2YMeEP5q6CurdFXtqWho9IXnGnQuu1RmgUQoOI9tw==
X-Received: by 2002:a17:90b:388f:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-2fcb4cdad5emr2927596a91.3.1739927425616;
        Tue, 18 Feb 2025 17:10:25 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348f05sm96080315ad.2.2025.02.18.17.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 17:10:25 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v1 0/3] Add support for Nuvoton npcm845 i3c controller
Date: Wed, 19 Feb 2025 09:10:16 +0800
Message-Id: <20250219011019.1600058-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for the Nuvoton npcm845
Board Management controller (BMC) SoC family.

The Nuvoton npcm845 uses the same Silvico IP but an older version.
This patchset adds fixes for the npcm845 specific hardware issues.

Stanley Chu (3):
  i3c: master: svc: add support for Nuvoton npcm845 i3c
  i3c: master: svc: fix npcm845 FIFO empty issue
  i3c: master: svc: fix npcm845 invalid slvstart event

 drivers/i3c/master/svc-i3c-master.c | 72 +++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 9 deletions(-)

-- 
2.34.1


