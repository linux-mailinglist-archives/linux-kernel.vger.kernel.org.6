Return-Path: <linux-kernel+bounces-322360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A47719727C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4BCB23136
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6804114EC64;
	Tue, 10 Sep 2024 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQDYEozj"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873DB4430
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941064; cv=none; b=jmO/wtmgWt2oYe/3Jj8Ihsw8uv+keEfRTiOc2WFpHFekWGKXwQdc4ilKbF0x9suyOjaMiYYol22UOBs4VGNf457eBh5o7S+4oPnXFwJyx5CH7mX9tYR3HiCB8wyAAIdiWzTCJ/RR/Xaup88IvZF1GZIl5IjpxQg2mGlyl+johlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941064; c=relaxed/simple;
	bh=OJGgjae4i2NI37TZdwennJqCG02aTYJg/qyFEdtAYIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCwsGU3FGqIgUCgacGys9S6IqVG0qbpo/xdo9GfAGC7nqdcmY7HpVHTm/e8FRByVumtuDqS8QnhfaAb8CGiBAYNYSkikBar3B3sqAxXeEb3uoItovgx05HQZxP0a1O6LHXl9yv0BkkUR28W3T15N0ASym565yI9TFvASXAi5/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQDYEozj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d21b0c8422so742512a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 21:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725941063; x=1726545863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5nzOGnXyk+q+cUZVUm2V+/bvqTXupwNNQKYLxllMLI=;
        b=SQDYEozjLC7HnWoJU1cx8V27ZxqRAX/LHsnMoATfpN0PR+ba0jwmdr4DI3V0D7WatZ
         HgyghWDAmpMdzDH+5GjeTy2BKdLUozFMOMEFfBGPoHir220SwqTy8uAfMqthenDG5fBq
         DAyk7R728hOg21pM+/hDUDVLEqUuywoV5UhUfp0IlBXOhWUm3sqBaNEGLOe2QehjWFxU
         ANGz1wLMHMHp+5SW3UGgTIBAM9GfO7SJOaHOnqVA959kfJJqCM0n+q+G7v/PIm8EJX/6
         YEBkV68+8u555C9D1WQw5p8eEBATcAmilKwkUS3ieE41wsv5nd4/drfCWS4t3ES0FrsV
         PQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725941063; x=1726545863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5nzOGnXyk+q+cUZVUm2V+/bvqTXupwNNQKYLxllMLI=;
        b=wAdBlVk+8YoD8/K+HPQUp945Df9WyHaIpfkX/g+7DCUxvv7j9Rn3x4QTVEnmpiNiqs
         cRpc3Z5CrrOzJV/2pnM2Jnkgedjn19r63PEbzEhD/UkEnlzlz57j+KCcUyfOXdiZLZRG
         Lj2ftdNdmcKMfBNiO4tgnrtCZqN2XPHSo/H2n7HcGRF1CYW+qAplN2u3ufDbSUhgnUqd
         wKmxp0IDw1p/33IcH3Tq09hT9IFkBFUveZh+w7ecgEOVuAwrxbFw6SGHacqRmbx9yYo9
         C1qB59cv432Sf4pZoGSfzo2NUjN4jg7A9oDibEPyTGOHUCNzMGnLxKb1lY2lrzxC9Z1D
         ZxPA==
X-Forwarded-Encrypted: i=1; AJvYcCXLFLwxVDHRZxkdosKEkNshNtaU6Q8aoHhsr2rNnHLsEvW+qq7S96H/sf1wafJq8bu45iefMlHZWYbWVBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgaB9IBhTWPUC52dpF7Y4LKRHEnAjLIPOWWBBR1UNXhkhqlst
	fZN31AjY2gLz733dKXnj/8CCoy54w7R4/fwBsUuiP/xl/U/nHzIM
X-Google-Smtp-Source: AGHT+IGUuNnN1C12bsHnZBL4w0NXhQOMtv/wUCpSD2FO8MFDlHP/KTluDkaBbymh4N88LQNYHy61Kw==
X-Received: by 2002:a17:90a:fe97:b0:2db:60b:eee with SMTP id 98e67ed59e1d1-2db060b0f27mr4050263a91.9.1725941062832;
        Mon, 09 Sep 2024 21:04:22 -0700 (PDT)
Received: from ubuntukernelserver.. ([49.236.212.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04136902sm5316950a91.6.2024.09.09.21.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:04:22 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] staging: rtl8723bs: include: Fix spelling mistake in rtw_xmit.h
Date: Tue, 10 Sep 2024 09:49:15 +0545
Message-Id: <93a1b568ec96dea13dfc75232a08bbf42e270599.1725933169.git.topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725933169.git.topofeverest8848@gmail.com>
References: <cover.1725933169.git.topofeverest8848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes spelling mistake to increase code readability
and searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
v3: Created patch series with cover letter as suggested in the feedback
v2: 
 - Created patch series as suggested in the feedback
 - https://lore.kernel.org/all/20240909041352.2392-1-topofeverest8848@gmail.com/
v1: https://lore.kernel.org/all/20240906141024.10021-1-topofeverest8848@gmail.com/

 drivers/staging/rtl8723bs/include/rtw_xmit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
index a3b4310caddf..544468f57692 100644
--- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
@@ -15,7 +15,7 @@
 
 #define XMITBUF_ALIGN_SZ 512
 
-/*  xmit extension buff defination */
+/*  xmit extension buff definition */
 #define MAX_XMIT_EXTBUF_SZ	(1536)
 #define NR_XMIT_EXTBUFF	(32)
 
-- 
2.34.1


