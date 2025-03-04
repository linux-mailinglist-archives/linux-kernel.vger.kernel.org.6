Return-Path: <linux-kernel+bounces-545451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120AAA4ED4F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3241890838
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9C225D523;
	Tue,  4 Mar 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic4s4ObN"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58130255251
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116498; cv=none; b=GWacKL2gwKWhyoG1/WpvApyqeKh1R8M3d4BOg03tNLbulhicSUYBqvmCtEUdt48t3gUn8ttpn+CCW7zSB9dH7ck3+C7xi+vqJ+GZXr4+BBvhWKdg/S44hb+wYwsMHddOz/JurW7VvtadfMSKwPZG7F67kSYF2DAaxVZLzfngBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116498; c=relaxed/simple;
	bh=LORQsVwLTnGVfVFh5m2kwdKQtDUywERLd2dudQi76wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lW1LlIKoxqPtZvIrCj/FqH8GDvsc04uASorTxEFAITzEW8O1EOoo755opJLEziKMuwHHuFRUghUjs/Ou7dcqQTwnFkCVwLgOaE2COrfytt0Px8Ei9DrFwt8We5KnZcZO9PXJhtVywcV3jnFwRNj32Uab2FUG73grhw2OF6ZgtE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic4s4ObN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2234a03cfa4so12967065ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741116496; x=1741721296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfwpAjfF81ZoEEByv81hbUTcL55kAuRlyaiSfIzemn4=;
        b=Ic4s4ObN3ZoQbro1Gw3h/ELOHrJszLWMK2OkhUU0Zc6rWFNw3k15++dFy21KHUqR69
         3ic3crFm4RilEX/UDYm3rp9rmFjbxrfb1gwovU6ywrPFFS6V6G0MBTMqcA/WM1SmjnO0
         2wopJToMahptgwtnXx0oAVrjnwI40eltjlEKVEUjKxaK7gw1O9+IPpdMf7Xm4SnTQjFr
         i5HsLRPH8g9G3P/J0xwbAVpFdLUlPgEHsAMkVl0iA0SptEtgQLQx9+GB3DhqlIOAZiEi
         hCyhK43TJVk8qnyMCHFb0/CExwSjSy0mgYsuYGDzoTc2fes2BgpFWfnDPFAV2L04y9O3
         kW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741116496; x=1741721296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfwpAjfF81ZoEEByv81hbUTcL55kAuRlyaiSfIzemn4=;
        b=cpeDoN6tC13Y10/zjIzurkiQXH4H+4nfOfk4ThX43wFv2xA4DzKZmX0q0mHJaUAAIB
         ITo2DFvQmXQi/PsSrIElp4ki9YYoT7omSo/YK1XRZ80QJlB3dRK9GacmvB/G5kAkfcUS
         9nKM3C5n7hd2/OzcPxkMyjTOGfgBjVZXC6ea8jXiie2RFtwXwODPYvOeyjPSzfrrUU30
         QzA4mX7S29YibZhkuksVFBj0E0tulg177a7Hf7sPQiQS3/vp7B/XEpmVkTNfPD6f41ir
         e3T17DDVr4V+VLsA1UniNkRStbuURyKVU9Duh/EaJnCrq8VNo9salcOVxOyI19n6Engx
         ajQA==
X-Forwarded-Encrypted: i=1; AJvYcCXGusIvZwbyT5ZXak0GdqpE2J2jBLCgf+vMhjywJq/ZHhekq96hFHr47HZvTrTEFB19ePdjThNCoq4otYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzOM+B4uzus8wXFxhgW5wbC4i6EFvm91Q9PQhrv/VVa7iP9Gpc
	OTQQYKMNvEEqPfGIbPnKQL2XtlD4KIPj4AMo9g0lI0Vf2aM4FIZq
X-Gm-Gg: ASbGncviaF3Q4cSV3k2w+GV2NbgC8BGacDbhEv/XjoLneRIzWtDKUlOQajaNrnQTuP8
	BivbfwPA26P9uVG3lyi8IPX7nXqSUCTunuMCW6+fJ2eyoVSRTq2HvTEb4aSJuxDr5q6IyNQufRh
	xs0ZeS/Pe9pv6s7OjeI4PkhNnULBz4uo5F6GSZH1Es4JuhKAXS9jD3ze/acNlm9iiVY4yQURFiS
	PJELo2LmWW7w6gVB6oZPwEwsmT7X4Njqvu/XxE6H1wOC5igj9tzbmskLcGw4SUWhoWZPBlWzU1e
	ST2xZ9/ze4OX9r/psfykwMmdLD4mzopC3dNS9zXQj0DXCdypttZZuGGvKA==
X-Google-Smtp-Source: AGHT+IFC/HtEpOI88jDvCz6XWpDsB1WUEG9zN3cdBySAyd4AF5z+1Dg8su7AkiLyDrWInkTaZatviQ==
X-Received: by 2002:a05:6a00:cd1:b0:730:9467:b4b8 with SMTP id d2e1a72fcca58-73682c9afe5mr41447b3a.4.1741116496118;
        Tue, 04 Mar 2025 11:28:16 -0800 (PST)
Received: from localhost.localdomain ([2802:8012:1f:3200:f1d1:c186:ba5b:8f06])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734d444a9fasm9341920b3a.60.2025.03.04.11.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:28:15 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	niharchaithanya@gmail.com,
	jiapeng.chong@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Gaston Gonzalez <gascoar@gmail.com>
Subject: [PATCH 4/4] staging: gpib: remove commented-out lines
Date: Tue,  4 Mar 2025 16:25:43 -0300
Message-ID: <20250304192603.40565-9-gascoar@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250304192603.40565-1-gascoar@gmail.com>
References: <20250304192603.40565-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove commented-out code in function write_loop().

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index f7dd0809b06c..bb22ee2cc5e1 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -218,18 +218,7 @@ static inline int usec_diff(struct timespec64 *a, struct timespec64 *b)
 
 static int write_loop(void *dev, char *msg, int leng)
 {
-//	  int nchar = 0, val;
-
-//	  do {
-
 	return skel_do_write(dev, msg, leng);
-
-//		  if (val < 1) {
-//			  return -EIO;
-//		  }
-//		  nchar +=val;
-//	  } while (nchar < leng);
-//	  return leng;
 }
 
 /**
-- 
2.49.0.rc0


