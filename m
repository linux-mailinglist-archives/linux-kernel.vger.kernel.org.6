Return-Path: <linux-kernel+bounces-352142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA77991AAC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00862826D1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4385017A906;
	Sat,  5 Oct 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfPIAh1M"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89C3172BCC
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160496; cv=none; b=fOrwIs8qO5eUK2G9pL95PylcENneCl1poGuVNr2hSSTd65QhFfkBIl0oZm53aofZ7VqB02FAfRzkZXjijli+K2/NqprM4cNV5C7IjZ5yV0drSYEWT9xxWYxu739jMwjuzkjiYi+K/3NihlQU3vnGWsZD3qZDyG8Wp5rnkMnQR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160496; c=relaxed/simple;
	bh=+o9bNAhuCTEeX/3tRLMGovUGCUWHMeoJSUHhd+GvWXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRfc05ckOOWqULScfdaXJU4PPlFEwNTkMiWKKcAoZ1jAwKkcotbrqjyQ2G0LM49BaWvG6IFtDNKLeRhpGp6xthj0QESSE6FGvZ+90Jgk0jjZPi1hYSaxi6KJyEhaF8X3VoU1ysVKMgr+gfwWlnQsIFab7jk2lJSplccNI3GaLD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfPIAh1M; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so31601275e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160493; x=1728765293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqqVa0m0IFUn28jRHH6DKcrgM36B1YpEymuOnaGzz64=;
        b=cfPIAh1M+F0m0NkzMvWhz6Wjl1QspRDXQt2wnoARAbwTnIAIeZ/K2M/nR6i6W0pfYm
         Z5XYzkqYR5EG9iNlm7Wp9RwgAwBQpgFm0gk33LUqWPPILt1p2vBqx+pOYTxge015y1hz
         D6jU5PG4X/jmUW80N9fanXHr3zuIGUPNey4kb9Y/AsO2kiDYfPPiquOpuEXpFlQuJRyB
         StjnCsTDyiL+/WYX3kwPc0hyt6TLNaFosW7zfKmkoZ2thhQ4bggZTQhDHXnwdaqyFmxl
         gXfv4K/zVUGOROktY27eRZ1WPkp22RaodN491b6HBbDdcOCYIf2JIQHe8LbAMXHkwAYg
         7tlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160493; x=1728765293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqqVa0m0IFUn28jRHH6DKcrgM36B1YpEymuOnaGzz64=;
        b=D10olvuorSJb3XHVIAMx4Jp02XupXq1+qzvl7aWsaUkuLbl9gjyy6ayBjYQoYhQbiP
         rUFOzKLNCBzHHgNvs9rEaMJp0l7VKuouuBRfQbF2zS4DtswmIuQuJrX12u9p5YdojkYF
         xqyDt8oL1ywnkDv3HyOs+NjcAsiKYCrRohc0Ez52wabVVpVjrRxMBQDFDP4FenKTQWlz
         Ebjc0hPhY3xs+pF62HnjwUUXAa5cPR0VlSf8zwOFgYo1LmpyTb2d6Tqq2xea0nPWS3og
         p8uaLZU5XKvEWxVGNQxc2H7DPm2stTBTvETIU9poOCFL/kvETuWIoeVjEWBgqt7yMVPY
         8j7g==
X-Forwarded-Encrypted: i=1; AJvYcCVbvBOX0euAVvZf8PI0gDhxSYJGC4glD8MWn+5/LOJNW19yWbWolsLlOCLIP1TQKBcUmBd+AxUtBBcja1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVlNomiJ0GDauaK9RUQwkbtqHH+nojK75e5C6MQx44ScylVXy
	kbr7U5PbbMXkqmtKmEsRBEj2cltt0EYgd+XcjwH+XxDFx6eCwS3E
X-Google-Smtp-Source: AGHT+IEyD1wqT6lfw8915OfOpCipvt1vQBVN/4QD9b8dH5y6OQJneRi7TsjPO8yLUIo5COrmveWLbA==
X-Received: by 2002:a05:600c:1d04:b0:42c:a802:540a with SMTP id 5b1f17b1804b1-42f85a6c655mr48721155e9.7.1728160492875;
        Sat, 05 Oct 2024 13:34:52 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:52 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 09/15] staging: rtl8723bs: Remove function pointer dm_deinit
Date: Sat,  5 Oct 2024 22:33:52 +0200
Message-ID: <bb03b1309e9aa6bae988c5b7003b4f925f5c7027.1727966761.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727966761.git.philipp.g.hortmann@gmail.com>
References: <cover.1727966761.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer dm_deinit as it is not linked to any function.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 3 ---
 drivers/staging/rtl8723bs/include/hal_intf.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 760ba45de8f7..451f54e5de09 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -44,9 +44,6 @@ void rtw_hal_dm_init(struct adapter *padapter)
 
 void rtw_hal_dm_deinit(struct adapter *padapter)
 {
-	/*  cancel dm  timer */
-	if (padapter->HalFunc.dm_deinit)
-		padapter->HalFunc.dm_deinit(padapter);
 }
 
 static void rtw_hal_init_opmode(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 8b85baf5be92..6d301b44fa23 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,7 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*dm_deinit)(struct adapter *padapter);
 	void (*read_chip_version)(struct adapter *padapter);
 
 	void (*init_default_value)(struct adapter *padapter);
-- 
2.43.0


