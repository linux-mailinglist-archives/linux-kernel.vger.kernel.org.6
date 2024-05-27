Return-Path: <linux-kernel+bounces-190032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3FA8CF894
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C40B21BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5430D266;
	Mon, 27 May 2024 04:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elDlVemc"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7932F2B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716785962; cv=none; b=Wn4CC1g/BB6zRAeXDabiDL1uLu+73q/YMXZ+7vqnu60VX2eFZe4X7Al3j0VhCNfLuTglHGr0DZNYYqw6+YnY3lx6YvtmMAqmnZpvkkln3j76gYsQSzzDETyBnl1BpNg6AMF3rnpUcr4RJ2eHPXmYWFN0cvbaailXBxNb8saz1CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716785962; c=relaxed/simple;
	bh=qdQ520WYRB6dXPFOnS961CjC3BWpc8ad5xZiBOfFKIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HhXp/7ubh8Xu/wjkCcrL5/0A5Skan1jX0ZTwerJVsbgJoN4f6ojrEDeZW3xBarSPIAkHk0ro8B/dVmbGi9MuYqIbcVP4lVaLCedkwGoueW6lp7A7hMuJAxwih61SsWqg5YhOdjQmHLsk/oq8tXr3g8nPGIA1d0qt5p1ZXhTkJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elDlVemc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f4a52b9589so2792275ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716785960; x=1717390760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6KvdvQaSGvfhx7HMn7VzdtxXHAGgtD6sRHh0aCS+qE=;
        b=elDlVemcYLaNJ6Dsr9oxofs0gxdxgwVRTep2wO+aCJAy2ywkvgdc91QO9K3bKuEZTz
         uLvrFjge71NvPDnY0j6qNOo7JsveQdhaM5bwQLDjogtScL0zE0yT2s3kwgmExdkBcPXS
         jE6J6Kkye03nqdm1VZVIx+K5Cpq+sxKwHTYbC9nxWQiKeBeNbsq5zRffHqO/uXa0W2ok
         tA2aAPoGptd/UE2MbADEWWQWaT+g1sRmSAc9ra5UiK3j+sCLINStxbMonwBpI+5KzK6I
         C4RFy1NLZDDsr4L69R3KufPP8Y7WFRVHde+P6XDviqqQefrSqyyXDJ+CzCXddNj1+if2
         G0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716785960; x=1717390760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6KvdvQaSGvfhx7HMn7VzdtxXHAGgtD6sRHh0aCS+qE=;
        b=ws3xpRBIprxdZHULIdSHx6MY5qp3djX8rd8ZRWuJ2LJ3p6JNVCv9IJQncU3gQoPvZH
         8xzqDQ2sR9nD1WPVNfcDNLBW0LhgpS9J5mrNKH0BXiwcVvf7zNinZxjYfxLn2PXwy5oi
         nosrD2Pu9NQf1roH7m8o6agLVBdughHLeYk97khIS+VuEQg/kKjmiErGQ12dX+pnh2uA
         MjtNRn9w+bNhntt8DIkT5cDkD1NvTBoKU7MMwhcoRsOd7jPQuj6f4Sdknvx4L1Ih5nRt
         /n+8qmzZDyZ1t0xT9bp0sw1TuFkpP42WmaRkELjtyOSnjcX6266/8vxJYQK8k6TnPtT2
         +sug==
X-Forwarded-Encrypted: i=1; AJvYcCW7eYCV/YVtsgLXe7UxHwSL2T2s6Qm08LS87byz8ofewCIPC+ccb/iwh+DIxAwDvtzD9qNEOTi6//sxQjABsQQe8nTDNzqom63AJ7oN
X-Gm-Message-State: AOJu0Yyw1x6z30HIjKRQCMerGKkgLQm7G3eIPxjKZtt5KPP4WKcHr6r/
	zxuafcWSnUiHSDwtV165gKKIKYDtwAjQryEStiH3MZ9rHe6BlrXlM7yIvVN5
X-Google-Smtp-Source: AGHT+IFNa0PpZQzqfaYhweaVAzKkOHkpJwdzLdGBNQGpG9i83v5TmzpdBOcqCxEVzJ8DWt+I0GljcA==
X-Received: by 2002:a17:902:cecd:b0:1f3:266b:ea23 with SMTP id d9443c01a7336-1f4486d1f6amr96091525ad.13.1716785959565;
        Sun, 26 May 2024 21:59:19 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f489e1a2e3sm17549435ad.184.2024.05.26.21.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 21:59:19 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	colin.i.king@gmail.com,
	ruanjinjie@huawei.com,
	hi@atinb.me,
	bragathemanick0908@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: Fix spelling mistakes in rtl8723b_cmd.c
Date: Mon, 27 May 2024 10:43:56 +0545
Message-Id: <20240527045856.72996-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes misspelled words to increase code readability and
searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index a59ae622f05e..d1ac2f44939c 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -700,7 +700,7 @@ void rtl8723b_download_rsvd_page(struct adapter *padapter, u8 mstatus)
 		rtw_write8(padapter, REG_BCN_CTRL, val8);
 
 		/*  To make sure that if there exists an adapter which would like to send beacon. */
-		/*  If exists, the origianl value of 0x422[6] will be 1, we should check this to */
+		/*  If exists, the original value of 0x422[6] will be 1, we should check this to */
 		/*  prevent from setting 0x422[6] to 0 after download reserved page, or it will cause */
 		/*  the beacon cannot be sent by HW. */
 		/*  2010.06.23. Added by tynli. */
@@ -964,7 +964,7 @@ void rtl8723b_download_BTCoex_AP_mode_rsvd_page(struct adapter *padapter)
 	rtw_write8(padapter, REG_BCN_CTRL, val8);
 
 	/*  To make sure that if there exists an adapter which would like to send beacon. */
-	/*  If exists, the origianl value of 0x422[6] will be 1, we should check this to */
+	/*  If exists, the original value of 0x422[6] will be 1, we should check this to */
 	/*  prevent from setting 0x422[6] to 0 after download reserved page, or it will cause */
 	/*  the beacon cannot be sent by HW. */
 	/*  2010.06.23. Added by tynli. */
-- 
2.34.1


