Return-Path: <linux-kernel+bounces-300480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64695E42D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 17:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A81B281966
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A710515746B;
	Sun, 25 Aug 2024 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXgDTgMz"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A290156F3C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724600766; cv=none; b=b4LOY4HGWapyJYmbaWA1hTwb5H6E/E3kwsC48ly6+aUnF9BT0Xewx5BCWM0RekmlLQOOlp45jHfLLodOhAlyPI2Bk4uyDSJE43hxOhxNWQWayIFpiL84z6Mxc7074CeesPC/w4hHmfKy16QvQcxymmagiQP4nTzkNVejzCkiawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724600766; c=relaxed/simple;
	bh=qFAr3JB9cQcJzIL3tHGa1v82oa2xKnsbgnCcDYEJ+f8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=WWXZcxm88HZ3Bgur2zY90h7IDEDLvmCGUpI6obQsgsZPCyNBqx1+IZIW2xN2a5L2D0zxnJBcxQaFwqfACxn7JL5xuMkneL+Q5H92iJy4+u5FElBUglYxG0vfSiCR+R91eVWCYV0TZBExtTJ9NjKsNwxe14QB5FDBTvxs6N4yFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXgDTgMz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20230059241so27608835ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724600764; x=1725205564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TovjW3a+wi44sci9aoW3NvQpz+eAWFPeMHC0GadI33U=;
        b=fXgDTgMzQ+t9c1C6Z4/5mt7UkhkBmFkcaDMcirI3pZLuxr4acNDEO3XaHIWDP2UgiL
         EEOyD+iHar9Y+Zr+6KxqKpo2Ua4jXiL91pc/j+GA1WwHy59QvtMhryB3i/iDbx4g8Pdi
         uDj4uBJBVkGPXtVFeiVP/V7GasDwsRQO497e1Yhwou9VUNedu+TzwVXvaC6GfOUaHlNX
         JHogHtA/MFcwUv+5knFBU+BYblHE8hYYbrVq5ZUDCstmSKERR2S8pMRBnnTjqTw/Tgtp
         yfFXAIeM1nb4fmpq5KYDcj3/WDaJhAHVaZn+cwu/tC01swGkZkzT63pIks9ESgddPxAR
         6NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724600764; x=1725205564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TovjW3a+wi44sci9aoW3NvQpz+eAWFPeMHC0GadI33U=;
        b=vbgIZbTQQMGMdSJ+SZm8vEcvctZ8hj2xfO/Kohh10GftbpmGfTg+BowQef1jGOH0e+
         xA0sh3rTxqDAx2qjfAuUGN81CrAieciwquEbVT8aqaiSp8qoIck/UzmGU2XLCQG+6U4a
         EMBNJ4M+QoGlIAQ9cpNgi9Tz7KneyVecmSJwjt8DOaunn6bK8vA+QY2IHV49uKcbQNIQ
         SbEwF+Dl18QcheBbkZyX+G4F64Ena3NT6uo3YIxgmTqjtxhxa1LKUiwUIJrKjzJeOwBI
         1JSV8N2MzQkg6dJmj8zDOezYr5QIabt4Wq0nVMcVY+EjfrQfy+q2YYEjxQ4ETrSJIx2z
         3POg==
X-Forwarded-Encrypted: i=1; AJvYcCXtH+JanAVp1HqX1CXvY2swNYhgSmOy3GRc55Y/2hzpyqmJA4ioMlC9c/aFa/O0pieL+MccdoNAxQNbGy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmbYHchr8BUEDg5PLzOYQZuyFj3SbPP2spepY8i16VCrshKt/6
	FtCbGMBYk1Bf2YrrhT0PGBdil1FsXtDeAVuFit7d3u9quXOChkM1
X-Google-Smtp-Source: AGHT+IHlEas4dSlHv2gTUSOkjdLdLADScUZdAxxRIGXpu3M9hFADuEnKHV7QD6DfyQIX9o+mhj6q+g==
X-Received: by 2002:a17:902:f54c:b0:202:3a1d:a231 with SMTP id d9443c01a7336-2039e4aa902mr79215165ad.31.1724600763592;
        Sun, 25 Aug 2024 08:46:03 -0700 (PDT)
Received: from localhost.localdomain ([2804:868:d047:ced3:41fa:c7cf:e733:9f1d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385564dcasm55256055ad.14.2024.08.25.08.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 08:46:02 -0700 (PDT)
From: Alien Wesley <alienwesley51@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix multiple assignments in rtl_wx.c:529
Date: Sun, 25 Aug 2024 12:45:57 -0300
Message-Id: <20240825154557.17912-1-alienwesley51@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separated assignments for pairwise_key_type and group_key_type
in order to silence the following checkpatch warning.

CHECK: multiple assignments should be avoided.

Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index fc8e7f73b2a4..47f1adf30ab4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -526,7 +526,8 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
 	mutex_unlock(&priv->wx_mutex);
 
 	if (wrqu->encoding.flags & IW_ENCODE_DISABLED) {
-		ieee->pairwise_key_type = ieee->group_key_type = KEY_TYPE_NA;
+		ieee->pairwise_key_type  = KEY_TYPE_NA;
+		ieee->group_key_type = KEY_TYPE_NA;
 		rtl92e_cam_reset(dev);
 		memset(priv->rtllib->swcamtable, 0,
 		       sizeof(struct sw_cam_table) * 32);
-- 
2.34.1


