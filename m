Return-Path: <linux-kernel+bounces-309818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF7B9670B2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BD42842BD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C66517DFF5;
	Sat, 31 Aug 2024 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbyuq+lB"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D251C17BB31
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725098926; cv=none; b=OENoEHRCiw809/8QP+uTkEgBmW4aRNfK8IxWIF60YLK08qXTCRWWXgBBC70W6MzEEgmQE0LyeSbSo35p0lMNsjgwyU5PMWx8AcASCMDuEopaPszJf5WNWEySDQdq6rK66u1qz67IdvWNKnHV5nm77pY8FAw+LTwuT5cgrlb6Mzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725098926; c=relaxed/simple;
	bh=Nhe1Kkw/FoRg8Qwa9UBPSnis8dKevjpCGUA6qwa7k7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5nz22UXxVHOXwOiYQSIDGusRf+dJBkszrrv80R3hcJgNrkxCwpAUdQrbd+77X7hRKIMAwtpY8VTZ8gaZvr79Qnl3OCEXQ2Dv71I8sQQYbiDCdDmBlNlOGUbbGhl/a00ZK9HCSIBI1gZVkkSj2A+VSk1tBSq2rFH+1E3Desf6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dbyuq+lB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a83597ce5beso425396066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725098923; x=1725703723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFqvD3mmrt1l890q+NAz0Rb4IBw7y1KfY5UglsMerHk=;
        b=Dbyuq+lBue8VqJlEcUFrenDs6RkA4Togn3guYzeS32IbMh7I6fzL3KvbtW6Y5nFhV2
         p1gMxrmyzVNvkacRHIfmQoCFFVko9+1aXElzGX/RbdMoC4XEtIPZ5F1mauZZJBH/07Z1
         I8zIM9M9pO/G8Y4kRCdLTq/+vE2sw84xw//za3nBu1FQvi4v1IFH+sCcMN7/eZAwqP7m
         6iLn6XojBxAcYLvE4vxDokppsW2hUgpLQBGMrZuJ8W4DiOWd+bWnlriuaKy4wgLETOm+
         u/Of5tefJnERz3/mwpfu5X1YmxsD2kw/W+v1SFbiHe02mc/Sdsvjl89/vz/gJJ90jD01
         lFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725098923; x=1725703723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFqvD3mmrt1l890q+NAz0Rb4IBw7y1KfY5UglsMerHk=;
        b=rh3BeXATjvsA4nPtczX5ZV8aGzqX6xuSM3+GTqXIYuRBBq6X1xklmWENf5BTPfl3sx
         /We81aUVSpz8Kn8IOf2l3z7zxbJkZGlmUofdOtQOHZJpZGGYOQF75iqdNcGWj2CTUUNu
         +BG3ync8Fng4128fPCwoccW0c8ETB++zMemJZm141Vw+16pNkLO/hrOpKMS/jmZnLZ0S
         oef8vrZcjUj/sent19zAM0yd8+djNXt23qlfjqO8V6Mrib9Zwsy8afD4oCiYMDo3rAR4
         /sFhfVVpYdXVXqITiaSYH8R1oyQfE0du+3kPYIesSQqu08lkCgs6orbce95wNlsL3wQW
         /ipg==
X-Forwarded-Encrypted: i=1; AJvYcCVtep2EWjWkl1rGVbqBkdf49TPYO1MiZIrUq2sH2DNh5QF5lm+wm1NPcO85AY0uOVCyDXLKP5BFWIaPHsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01P+dv2RYii9CuP+8n9kGASOvx8+196SUOm+uX0Qf3WkaKy12
	nvNlgKXqltlZ2LegqVRG4b3A/zr8Q8yFAM11QYyAus+AcWyhfsGG
X-Google-Smtp-Source: AGHT+IGx1jxgBTt3IZq0k6GwLhT0dUVGvzFmMQuOhijICW07q2vbOUcAPnY1FpS9e1o8j5ThvSVOYA==
X-Received: by 2002:a17:907:3f20:b0:a6f:996f:23ea with SMTP id a640c23a62f3a-a89a2693566mr431760566b.15.1725098922583;
        Sat, 31 Aug 2024 03:08:42 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aba11.dynamic.kabel-deutschland.de. [95.90.186.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989021973sm307444966b.82.2024.08.31.03.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 03:08:42 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: rtl8192e: adjust size of RxMIMOSignalStrength
Date: Sat, 31 Aug 2024 12:08:09 +0200
Message-ID: <20240831100809.29173-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240831100809.29173-1-straube.linux@gmail.com>
References: <20240831100809.29173-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The array RxMIMOSignalStrength in struct rtllib_rx_stats is always accessed
with indices in the range i = 0; i < 2. We can reduce the size from 4 to 2.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7a1a68317a49..0eb987e999c5 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -480,7 +480,7 @@ struct rtllib_rx_stats {
 	bool  bFirstMPDU;
 	bool  contain_htc;
 	u32   RxPWDBAll;
-	u8    RxMIMOSignalStrength[4];
+	u8    RxMIMOSignalStrength[2];
 	s8    RxMIMOSignalQuality[2];
 	bool  bPacketMatchBSSID;
 	bool  bIsCCK;
-- 
2.46.0


