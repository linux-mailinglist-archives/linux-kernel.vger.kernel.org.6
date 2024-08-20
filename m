Return-Path: <linux-kernel+bounces-294477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D67958E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7881C21DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA2814A4DC;
	Tue, 20 Aug 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g11v2uMC"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A8145336
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179354; cv=none; b=cVDIOfddlQE24eAjQrskdJgartFcRNMIII/7kTi3zIlCNCyi0pTjOn2s9Oxp/Irz+kflECCIh5Fkmw+MEjzyXRxV1XuTHUVDU47PyxgT7wAoIOuxeXcwmsqW5sDT6gfjNm9IjH4RieFG9B1C4tVxwHKBk3/Heq5lQcZYsARDN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179354; c=relaxed/simple;
	bh=YPwnmjDLK+YVf0WyuqFgoPNXU4jhy1NiR/p0IqzQHyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pBRaCvw6nCZH6RHS87N44+L6dZvXDZT9mAGbcbxHHOD59RRKyPCyY9RtRE0AU9dU8wObnTzGyDQYjFr7duRG1KwaL590Gh2XW6x1kzdru8DacDd9CCOliLbZYRhaTGHuK/Vuo8HkVr0NKTPTsRT273Mw/ar1XgF3nbWJOF1OCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g11v2uMC; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso4533466a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724179352; x=1724784152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d6qvU2I/kFY0fRRBFMo/OPhj2YEvUyZhHs3rYMJMfKI=;
        b=g11v2uMCLTFcyTWyr+x8CQMDEdFhQ8d3FKI50+QGIPU7IZ8YD7HJFZ7pHwTZjKc+y+
         RC8I2niVtex5MaGNBXf0tuc9/GsuAsDVP9dGKddUNzyh7HkP9Rd2W1usQQS7sIC9MGdC
         W4Rae7oIoxkfEsSOU5fSjnttO10OqOox6yyAn3kFMKIlMZxjWg1uMwxQkeAQRAhAv6Cb
         Z0FYGLDW15XbJYoTSwQQYZYuj88t9ARBMmIoG2TZRseapiCuGbb48Cb/FfmukJZ5/wfv
         /twv6BiZxK0LdBvJc9zqaV21cVkHFwGlfJ4DEB9cSp+A9V3Lg+dZI4tcwIDBYDOGR30x
         ZMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724179352; x=1724784152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6qvU2I/kFY0fRRBFMo/OPhj2YEvUyZhHs3rYMJMfKI=;
        b=TYzdmsDQKoE61wd7VIaaoie+2LeOzmD+fZYmK3jySTto4Khttqj1NL4e5G5BYKnsoV
         qeW2m47rivHvICEO8ou8YO+8E69NUy+6a8U/IVmaXQq7QLXsVKzyR3v3rcFznnN7ac3F
         FOWg+z8V5NLzsTIYmsYKepaizWaujeyZu4uZQYcg3O1Zwd6Vlfo3otetpuhlVIQJNOSN
         3lUfH5gARFpAd0lBmZyR9C5pTV4EdeTSUvqSFzgWEdG2eTTEQudY02enKb+hpZOyxtF2
         D0OnijaEcICVZySlpM31/1GBzDj5KO16uY70M3EHitd+NY7pEQRVTjcTP/wR9mz4voAL
         aDog==
X-Forwarded-Encrypted: i=1; AJvYcCV2euiBIFmwVUaiuQtk123yK//ClWW0SQWI58+scSgDwA38VVd7kbJ6O162/YmZOnlF7tgeHaEfQNRxpKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwgmSpM+c7E2NIIkXHEAya1ygT9w3kDn7u5zodb7DJBKpUtdd
	Id+0Fs1O6HY/0mz2uK+wzc+Fi7J7SUu/Z9LjaVUyrZf8aBdKte00GONns3/u
X-Google-Smtp-Source: AGHT+IFxlJrjQAQKZg0A12JTqiKvjdykV//J1dgiLVqq1WbyaFiL56N6kPECxFc5tIIGDKmeX/UNoQ==
X-Received: by 2002:a05:6a21:1788:b0:1c6:a57a:159c with SMTP id adf61e73a8af0-1cad81814e4mr388450637.52.1724179352220;
        Tue, 20 Aug 2024 11:42:32 -0700 (PDT)
Received: from embed-PC.. ([106.222.232.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0e246sm8541159b3a.70.2024.08.20.11.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 11:42:31 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: gregkh@linuxfoundation.org
Cc: tdavies@darkphysics.net,
	philipp.g.hortmann@gmail.com,
	garyrookard@fastmail.org,
	linux-staging@lists.linux.dev,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Replace strcpy with strscpy in rtl819x_translate_scan
Date: Wed, 21 Aug 2024 00:12:16 +0530
Message-Id: <20240820184216.45390-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in rtl819x_translate_scan() 
function to ensure buffer safety.

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index fbd4ec824084..970b7fcb3f7e 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -61,7 +61,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	iwe.cmd = SIOCGIWNAME;
 	for (i = 0; i < ARRAY_SIZE(rtllib_modes); i++) {
 		if (network->mode & BIT(i)) {
-			strcpy(pname, rtllib_modes[i]);
+			strscpy(pname, rtllib_modes[i], sizeof(pname));
 			pname += strlen(rtllib_modes[i]);
 		}
 	}
--
2.34.1


