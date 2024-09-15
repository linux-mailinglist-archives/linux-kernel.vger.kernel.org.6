Return-Path: <linux-kernel+bounces-329706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB129794D0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30D61F2223A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B4B13E03E;
	Sun, 15 Sep 2024 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYCdBib+"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B4312C54B
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382470; cv=none; b=Lfm9HoJdt8b3cQe5ZfoVtLebYbyaOFClZX9oOCC56/UnkIMvaPoOCmpkQPo3ZfI4yPDExxD/QIKF7OFeaDJgp3yNCrz43R5VQLtrVmZVcuDA9TgNlyzPoYXO4o/EyfRwTkOuPA/fn5njTcNef7lzx1Ibnhjb8RTraq3fDyBDC4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382470; c=relaxed/simple;
	bh=Js4POPVp7tcPzGMNrSOimc33cvs8JgbNabVDIlLIGDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFm8NGESt0AfJOeXXem9V8G0Sw2/zqFFbhemZzaWNNCWpFUCyq7RGzCXF46QBqY6ILOoYzKQ/b1zUOC2ic5ua/SCG0gFSYNFLWFC1/e8aCOfcSvr5Oj0Wqy/sqWWdxkKL+xd1XddzUXkkO7WAPYs9qgEGjPHLtiWnPqry6S+Bok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYCdBib+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d4093722bso475956566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382466; x=1726987266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aghDyGl0md6PciwZ2vSqAUp9KqGz/7+l1dC8yB+1Yqw=;
        b=fYCdBib+zxZZyy+fulrpVQW9Eg58wjv7PDjEI8AGkIyGDFzTCxyPtaMmqOSkx2Bic1
         dQ7OYsqDEhcmpzAaDPEh4LnyxqwOfOm1kq5YltQUfCy7E+rfDOJWSkgrGx4a1J9jzKFM
         B9oVi3dovrjXCueYiI7APm7HI6MmlYce/hNC7HfTrH9MhJf5hrexFs2udtP2jDg4kata
         L9zE25v81QR726ySW+nGUB/5H+sgK48uCIGe4xAMnMRmZTweBkSKXwGjN1mVsd4xadeE
         laNw4V+N0Jn0gV73VfHhqeawzZ1IXjw5GoD5vd5hKumy4KVmaA5sBGeOrBwyTGFp9ACw
         uBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382466; x=1726987266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aghDyGl0md6PciwZ2vSqAUp9KqGz/7+l1dC8yB+1Yqw=;
        b=AxxdOSu0tlk4rNGYQnZZ5jBAO4j3HMHcgjGl4X8Uze8ySpAjajCmZfKOeujxhX8+N0
         Js3TAcmieXE4dRx36l8/EjIW2w0hcUrHL7GX5kDz7ilFUgVn+L9ry56SJ4LWs4UdLf7B
         pfwN7qc9IN0h9UePB7ewmTT541n9laLI8O9TTuhWtWNi6IGi02kagneAQN6GLXS4Q1mK
         C3wdOpCLuARDTUjzcjlrw8mQPhProAs/6EM8RJxlrPorRZzNMQVT/M/l53ILE+n9rJDD
         YCUyNhqA8GYkwCYfXTTR6M07HXutJkpsieJK5Y4jq+o8YOv8gaBQ2fNlS8WkgpHv+C4T
         tztg==
X-Forwarded-Encrypted: i=1; AJvYcCU7I3cSoVarqdwQ0JMbwsOymevwMhu0+tZ0/NXNJSXjNpuSZC7POW4Yb+qlZdpzdOWjL267X3BfgxUBsq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5TQVAttr7/YZS+SUZ/W6c9Rmgk1Mj0Ng7qpW7rKm/4LEiVOMT
	khjeD+v39IKVhugaRLn2+LJISbiVyonOyz4xcnDFvtsVT7O1THMd
X-Google-Smtp-Source: AGHT+IGUe6mOCXY/8tTVFtjgkN+PaIY7q6WDjNrztOo+eP2BuvEbj+IHGYSASnkGSSuGYMBK7sAl0w==
X-Received: by 2002:a17:907:7f92:b0:a8a:6e35:31ef with SMTP id a640c23a62f3a-a902961d872mr1323344866b.49.1726382466147;
        Sat, 14 Sep 2024 23:41:06 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:41:05 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 14/17] staging: rtl8723bs: Remove unused function rtl8723bs_inirp_deinit
Date: Sun, 15 Sep 2024 08:38:28 +0200
Message-ID: <dc6d35602d44cc676bebbd6d84733ea5420ac3f3.1726339782.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
References: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function rtl8723bs_inirp_deinit and belonging unused
function pointer in struct hal_ops inirp_deinit.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 7 -------
 drivers/staging/rtl8723bs/include/hal_intf.h | 2 --
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 93d455aabccf..c54d6dc1a495 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -937,11 +937,6 @@ static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
 	return _SUCCESS;
 }
 
-static u32 rtl8723bs_inirp_deinit(struct adapter *padapter)
-{
-	return _SUCCESS;
-}
-
 static void rtl8723bs_init_default_value(struct adapter *padapter)
 {
 	struct hal_com_data *pHalData;
@@ -1267,8 +1262,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 	pHalFunc->hal_init = &rtl8723bs_hal_init;
 	pHalFunc->hal_deinit = &rtl8723bs_hal_deinit;
 
-	pHalFunc->inirp_deinit = &rtl8723bs_inirp_deinit;
-
 	pHalFunc->init_xmit_priv = &rtl8723bs_init_xmit_priv;
 	pHalFunc->free_xmit_priv = &rtl8723bs_free_xmit_priv;
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 0fc3622806a0..d959be13fcf3 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -167,8 +167,6 @@ struct hal_ops {
 
 	void (*free_hal_data)(struct adapter *padapter);
 
-	u32 (*inirp_deinit)(struct adapter *padapter);
-
 	s32	(*init_xmit_priv)(struct adapter *padapter);
 	void (*free_xmit_priv)(struct adapter *padapter);
 
-- 
2.43.0


