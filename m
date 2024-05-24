Return-Path: <linux-kernel+bounces-188890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 099A68CE834
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF071C221D2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A95012C801;
	Fri, 24 May 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX1IYV/z"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0B41DFFC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565224; cv=none; b=lGi65b54JzAaQOGeIbutbCNXRuf8QsDIosVT4XRJBTEv1Rw8yG9eL8GDe8wQnLC6TSXjtcXxpNznjAEdq8p4lL/ni62jCFTYHSEEHoSK8UnjrjpVa+PbQQFO0uzAOAedH6dotPk3eyIMKHkZwdyI2Tx8DvsfErAnebGvqpOAEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565224; c=relaxed/simple;
	bh=dfy7lBx9o/LoiFhztFzB6TT+AoSqyiXNlnNPdSnQbY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uBop9Vc8XkWzXDAxl3In3EwMM3aIWnr0ObLBK11XMTd7W0GyilG54AzE9LleG8a6tgb5T7vPlck6qIyAqxw66m1wSIonZtFufIYTm91JfOU/4E6CzZVlrOPjiEpqg7mgk9vqpyWW24eelQfN6GOvNNPvgETFc79Y0WlITUNxc4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX1IYV/z; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f693fb0ad4so3952642b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716565223; x=1717170023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wP+0c9kO69lJishldPkRtQz2m4VWJyfKYjNILD4qKl8=;
        b=YX1IYV/zs6oGvHi3KUUNY9tW1voqrMEOJaqaLcgQ48xCS3mZQYM375w7lrDPZGHk46
         xM4peHdmToeXS9QE0ZxgLoh+2Pb5tJrMoza/u8nDiJ8Poe9f+6QXSl+9QMlbT8OXcDhQ
         6IJDqZTmVREjfp/OZRgFgmiMMhDn4OobV3Lee9dYhUiy9x1L9QUTenAKDuIa8Zgh+NUu
         FkFFv/3jMmx3idXTplmDEbcYQg5+Er3geN0pjjD/1qCGH8uUchi+N5s9Ibok9sldyPol
         5Hy4gzGkImoZ2ilNhApzI9eiDo6dGteTxW7UIxv/z9bjFiX88gIWxuJMpGGGYvvjmDmy
         xwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716565223; x=1717170023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wP+0c9kO69lJishldPkRtQz2m4VWJyfKYjNILD4qKl8=;
        b=pNIihCIkMBWRd5g72B4StTO9ThjFuu3t3X9XQ0mHDuv+3f/RVjrNs/hey0ybFDJKlt
         Q8qW5+bX7TiitkHCIM1+UcZNvw0yc+9HkzgeQDgu4Jim9TJgH7pCZDPJVqi0KwKJFss3
         i8VC0NCbM989sNj1OCtfuF940IEsfQURrwDbTti8QQKkcmuA1cw4QB39K9Y9NLc/c9bJ
         dAXa+XliZFi4Ivxf8gM/mFp1gHJwxTLZ4zvHamL8pwsFDappVHeRuy18vQXD/j9yCChF
         Cv71ovMcMLxVwd7HmiRgyPKpqx43fC7lyYaMJ1tmfwoP55lP3JkCPCce7lV9krsYQ7G8
         tcIA==
X-Forwarded-Encrypted: i=1; AJvYcCWefXwJ9RpjAiUu2d89LZoLR544LUxSb66NWpscjZB4SW31uMpFDJ+/gwhJzgxDCXdytFl0S+OM+5m159Dbc/9VWukdi6TFZm4/NuaB
X-Gm-Message-State: AOJu0Yymv0NWifz2LtKGjAZKg6ulyai7LfbeVYNIQX+BJY8a7wig2haV
	UV0ry5DcGpjtz0BS2EG91pdlzru/M7n2M/nziy+owZALPWYLo1T8
X-Google-Smtp-Source: AGHT+IE+IJeJkijTrkeCMpTMKxv6s/e3nRYLMeX+cNgRdLnj0qTw/3UWTy2pZII5zaz3A4LlDkGwuA==
X-Received: by 2002:a05:6a21:3115:b0:1af:dae8:5eac with SMTP id adf61e73a8af0-1b212e1cc21mr3349631637.46.1716565222648;
        Fri, 24 May 2024 08:40:22 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4e3704sm1242993b3a.202.2024.05.24.08.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:40:22 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org,
	ayushtiw0110@gmail.com,
	namcaov@gmail.com,
	dan.carpenter@linaro.org
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: Fix spelling mistake in rtl871x_mlme.c
Date: Fri, 24 May 2024 21:25:01 +0545
Message-Id: <20240524154001.63946-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch corrects misspelled word to increase code readability and
searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index fccfa0915a02..70c295e97068 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -944,7 +944,7 @@ void r8712_cpwm_event_callback(struct _adapter *adapter, u8 *pbuf)
 
 /*	When the Netgear 3500 AP is with WPA2PSK-AES mode, it will send
  *	 the ADDBA req frame with start seq control = 0 to wifi client after
- *	 the WPA handshake and the seqence number of following data packet
+ *	 the WPA handshake and the sequence number of following data packet
  *	will be 0. In this case, the Rx reorder sequence is not longer than 0
  *	 and the WiFi client will drop the data with seq number 0.
  *	So, the 8712 firmware has to inform driver with receiving the
-- 
2.34.1


