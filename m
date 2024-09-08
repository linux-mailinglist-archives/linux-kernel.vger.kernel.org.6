Return-Path: <linux-kernel+bounces-320125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D35970663
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A571C20DE5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7017514D2B1;
	Sun,  8 Sep 2024 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKirUJIE"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A811509B0
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790292; cv=none; b=hFfqhaAcbvCyqXgoiU0SDNniztEfUjgMs3kbcIozqWuGid+we3xEttSRietoz6LId2N29+SMgKE6S+dwi5ZvZ76VjDez+TwuBnNPL6FMWRzGsscr+KjXURmiaXrMxYDxlAjcmZhqlcSywRRP2GWs1TN8nb/BstV+1Z25rX5+t8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790292; c=relaxed/simple;
	bh=BboeagGjKvfTaMpatd3Q9UtiYxSVOaorAWSf4hQUXUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rdzcKIYI/ywn9fspuxWh9ew1MBCw1fhAY2XZxZx8BMBqhJ8FGseo9JlijCQnHnn3pnNi+4s/jzJiGBLhv02Bc5u6wUuIQv2/l5k1Lzs+MnFoMri951ZqoRrpNrbdzr6jwVRTEJm8kf4EN4MYg9YUgf1lVXPqTjRM3VLuBgQgVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKirUJIE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2da4e84c198so2365709a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 03:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725790291; x=1726395091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Pz0T81DyM+ABMiQOyhUaG4cYHqvUmHaS8GbpCvlsf4=;
        b=WKirUJIEj+3rdpjkMLlLFqtQ2h8Nmkx6QqYeO9IYqkl1+YbSYUBtSvbyZwAgp2NDhs
         xTRmI5OpnIwCG8hWSeuqDnddnuinpO5M6VzhW83oX7ZQIt2x5pQgTPT6808OlxRBc/K1
         lRm6Z25XOAQI8H1K9QppxmdworJ9ELMi+Wb3npT6fk77yt5Lt2s600oGhE44XlwnLGaE
         cBupRoVOYwxDTuYzBn4bcbtmQ3MxPck0+liuu3TSJTHg6Eh6kNz71efu2pkUzD7lYmqv
         kWjaxGj714IQPcErLjd+lqS1Axx0LXmOGo4+XFbxETQVpsqgXPeLv9jkvAdTsh1vjCw0
         cOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725790291; x=1726395091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Pz0T81DyM+ABMiQOyhUaG4cYHqvUmHaS8GbpCvlsf4=;
        b=aNe3ouLqUXMd0Gs5NG7RvrS3VaUAKFVO3RiXFuH18c+pCo74HBTOR7sQUs0p6bAFG7
         KnzV0odyj+LsBt4Ahmn0ys7eRR7PG9Tof8rePwuYObhoKgbj1HjL/nmPlNaX6Xuf38Ks
         zY5pWDYujmRtZeFaBbWiRJFMddzXny4vsJiqHYrsdwDuSXGbGSOAsBdoRxH5/bWzUCwG
         JOBOh/UnQXeEnmG8vI+mBzxNalcF9prW2BFYmslLLre1UkwZDmAkrJ0g3xhnMp1bGkaO
         3r1KVa+CXbtyrQ8ikQjMrKQ7zWlaNEr43ybVNQaAvPagw41cXJEaRuo+BQbcOb540coz
         MJgg==
X-Forwarded-Encrypted: i=1; AJvYcCXSSgrN37ukhsI9CfDbBImibzIe+4uFfLM+5L/WkhFP+jCiHJ0jPCXbBVQ44CMTtYpHedRsr+ZxFStbzRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+0YKfRz5L8u/tKk4sS6QRHmS1rh5EphV+Jh3qZB0dUu684o62
	n686z9/Hu4lcWXAJ4+Jx6hPg1dsrgjRJ6zPUg6pAQ8mQ/jITJ/tW
X-Google-Smtp-Source: AGHT+IHRjf5GcLOnN3CwmtT15cylTOwvR3MWVaG9aLxHdFF9oWFgzIhjEotLGg1C/PcPcdVbvFYyzQ==
X-Received: by 2002:a17:90b:3b87:b0:2d8:9dd2:b8a1 with SMTP id 98e67ed59e1d1-2daffa3a9dfmr5177223a91.9.1725790290898;
        Sun, 08 Sep 2024 03:11:30 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.172.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0782dfsm4589379a91.34.2024.09.08.03.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 03:11:30 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: philipp.g.hortmann@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	sayyad.abid16@gmail.com
Subject: [PATCH 4/6] staging: rtl8723bs: fix comment with a trailing */ on a separate line
Date: Sun,  8 Sep 2024 15:41:08 +0530
Message-Id: <20240908101110.1028931-5-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
References: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the trailing "*/" on a comment block.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>

---
 drivers/staging/rtl8723bs/include/rtw_security.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 4efa2d258ebf..1e5e7f52f8da 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -240,7 +240,8 @@ struct mic_data {
 /* ===== start - public domain SHA256 implementation ===== */
 
 /* This is based on SHA256 implementation in LibTomCrypt that was released into
- * public domain by Tom St Denis. */
+ * public domain by Tom St Denis.
+ */
 
 int omac1_aes_128(u8 *key, u8 *data, size_t data_len, u8 *mac);
 void rtw_secmicsetkey(struct mic_data *pmicdata, u8 *key);
-- 
2.39.2


