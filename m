Return-Path: <linux-kernel+bounces-320604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2F9970CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA1E1F224F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DEA17277F;
	Mon,  9 Sep 2024 04:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEzYtmen"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6E816D30B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725855322; cv=none; b=urMIY+IgjmKox3gcx0gS3sUl/RRd7qnRuBzn9yPN//NnlBBtjhoSyCZ+yCrAhpGfGyCDm7+pYo6VhoxLj5024E9a+fhNSwRXDZI4qaeL5fA4ZFqkugiFNUoWXYEQpcUWXNitOuEhJo+nvUfytDlRxghLca8bOf2A1AjneOcBOko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725855322; c=relaxed/simple;
	bh=x+8U0C7QkL36TPoIe1zSzWamAm0OR18bcKXmz27+cRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zv2Y3jCWyU8lr7a5L2aiVy7AZGJOJKMgXFEM9SV0vmke9vNqQ6fxb4nKStcuolbMoyzY4iVYoXQPTNLPH2gT4V4yjZC7fPM92LQ8IYoaEn1MSmHUSYHD9Ch85Q+IUXIX1hRK3aSwYKQV16LRiCHWIa3PmB18CAoloaA+SJmEaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEzYtmen; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3dfc0631bb6so579489b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 21:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725855319; x=1726460119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nqaKTzOQEAoCmLVc5fe9PS9plUk/uiL0j+yMVGU74Ek=;
        b=WEzYtmenN7GaNEr+9GV72jTe7g7nSKbiCOe5mtTlifAc+U6yPz1NRtH7FDK54aBcsI
         gFr6fE6bpA8hXAKgv/jL1j+jSZtY1NFt6o4x68AJQh0l02DEQHTaxaXfFj4xdmOc/JJO
         jlild2k58nyv53N0vMwBkPSMBkHMiyACZY9aMv1HBvCu4OTy4bXHxDxoTQzGjWDFMkJM
         xluyCw4aLcc5M3GAueh897uwoNiXbsZZESjlTakJqFO5pBubciJiqBNAToNcIhOCZs3Q
         +0b7ve3QvgSFkywJYEhOQ4aYR9SFmfwZP5BVN28bFLnbRsdyBLaEgY/5mHi/BjfyDFmP
         g8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725855319; x=1726460119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqaKTzOQEAoCmLVc5fe9PS9plUk/uiL0j+yMVGU74Ek=;
        b=bamm0HQj2XS7AzSr3p3PeF+mBDAX3gJ0FBG6mk0YwWjJu0hVgnBn7pw6EDdPUuSn4E
         M13AOjAAx+DRmE0SeheaFUfYzn1DdVM8NKRnzEF9S47TNeurJ4a2TPv0PjMpzytidX59
         q/GOJiwDaubBR9GNoMCL1nIswaqS8Id620CsQYKNqGXdxk1iSd5TnikbrIe3e5hSitPa
         ArKWiGsmloe4zZqYcl0reiJpBKiIw4rAJy98OSo5UNDfzS/C3kQPqKIeg8OScA3cl7e2
         FKJEwiSWfeEhMLoe5MsszXdd9HrOWEDQRYcwKkFUdRIlnx+b0jfm2wzml9R5rPB/doGn
         +6Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVkpLvs1fIqz6X+zcZDPwNNRaYJ0aOrIPfzBaqxviCPN9sjsUh0Sv9RZxID85SbOUeNBsJHbFVkBNW/HQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmORwTHiTWF3L5vw0REB23VJN9FMNH3BW0D/gtc5ST7QHB+bpR
	mtWMtmS83t7tScR2ZiYgUKpoNSwA1BVBE1krmx7iqWt/MYH9Z3o4Au6Vw0Q8
X-Google-Smtp-Source: AGHT+IFebW/lH6JfzbyrfIXsthW9Pkx7kSX8A+kRX83nIqcl2Tpia01HTOGiXVJSGI3Ka459SzTxhw==
X-Received: by 2002:a05:6808:bd5:b0:3db:4367:c05 with SMTP id 5614622812f47-3e02a037536mr4987168b6e.7.1725855319241;
        Sun, 08 Sep 2024 21:15:19 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5991331sm2651901b3a.196.2024.09.08.21.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 21:15:18 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] staging: rtl8723bs: include: Fix spelling mistake in rtw_io.h
Date: Mon,  9 Sep 2024 10:00:08 +0545
Message-Id: <20240909041508.2412-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
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
v2: Created patch series as suggested by Phillip
v1: https://lore.kernel.org/all/20240906141104.10076-1-topofeverest8848@gmail.com/

 drivers/staging/rtl8723bs/include/rtw_io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/rtl8723bs/include/rtw_io.h
index be9741a056e5..0ee87be6dc4f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -13,7 +13,7 @@
 	Otherwise, io_handler will free io_req
 */
 
-/* below is for the intf_option bit defition... */
+/* below is for the intf_option bit definition... */
 
 struct intf_priv;
 struct intf_hdl;
-- 
2.34.1


