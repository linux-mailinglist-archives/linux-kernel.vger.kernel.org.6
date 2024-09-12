Return-Path: <linux-kernel+bounces-326774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135CB976CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5053285ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859171B985A;
	Thu, 12 Sep 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibbt1mLK"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A71B6541;
	Thu, 12 Sep 2024 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152782; cv=none; b=hmGDJ/hLQmvCoQJxgL65lyoTHmC9tm+bpiP1gKZxmectdokZugr6n6W3HdSlxw1q2XUu7m3WmXvK+uEa3dV5hAwOXdFftI/bhj9LVFm1mCTQ/wlnro0B6WuiqwIkTbSY556nX7WJFtYg9/7c/ur15SnJHJA0+ItpRcwXO+Bc/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152782; c=relaxed/simple;
	bh=OWL4mlcwtG9tysqDuntuby0lkx3kp3yrJUTlD+NSAk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rnicchxPB1BteSum9SXaLO6mSGE97PdRAwJ2cyVurSLL/Y2M6M1Nw7/0Go+8nQwhiodwqm85yuW+J6Dd9GPZjgMD//Zo4d69Il/jrs02rNmAzNsSqJItW7t2rqNtX0ly7tK3lTJXJW08U4pOOpehDfBV5HIZVC1ziy7Pk5KDwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibbt1mLK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so734612a91.1;
        Thu, 12 Sep 2024 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726152781; x=1726757581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+5IKbYoDJEP2KO85oswQmEdobyY+Md1ZqhM7AUuMvg0=;
        b=ibbt1mLKj11tLbnR97UW6F+YW2wPi3W+XfDh0J98oYss0JXl+k2YsbAq67qabJgl+Q
         zbQoeHhS0z99PPJvAjvlX6mwBawlUoLmPlTlmVPoQ28suqi00VOgSDc92JVj3QJayxqR
         itqzb62HOHaFPF/qz67/lsQVXDXzGCg+Djrdq/M3O6Z0dCbeG5RDTFoMnpaU7mQk/qf4
         dISkgum5m3rPkf3/kmDdrjUkkxv/26DkikbBR3lgx60b2vgURIaM59hktxwF6g+vLFGC
         TK5CE2fZmImQRI1IJ5uHe/RFfQuMXtzKTo4iHEMh8mGZiUg/Y34sUy3YEi72vsTnj+w4
         +Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152781; x=1726757581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5IKbYoDJEP2KO85oswQmEdobyY+Md1ZqhM7AUuMvg0=;
        b=q/SYTXKtNHzAzrMRCD0S1//yfq7FxWqcDaO8xBHr89y5rlUuk1YOQWvHVadUu0BzrJ
         yTTfz4rLVHAfjHD5Sdlu3bQdNsvJjCOv5FF0osTWiaIvKYYNhKKP4TxS+PkN4K2YKsu+
         gD4CxNqf73CVs4XlHz/2Sf3dLBwJQCgnsn0IXeoVxCQOfN+BvCh+o+GxabAHB/uxYNJl
         lAZ2VrGtY5MW29d1Oppmhw0JLhMMo4kSXMgi38fwWyybXCJGfwbaPjWXVjnUYe1s03lR
         Sv+I3jcyVFNKZQbNNlZe3X29sDjG4e30waEjttcf3Mwab6ZgSW7zazxAzZqzgzGthfKU
         i7jg==
X-Forwarded-Encrypted: i=1; AJvYcCWCVwZ0MGN+nCpKJNuQbC94fUb0QoSbBxAFUZkL3tECYBCjF9tSCA7zklAWGFIa5Abch26bD6TAOyKdyy0=@vger.kernel.org, AJvYcCXdU4Lc8vw1fpImAS465CYELrqSrOxlixs0MJ9iCZ+3ej5qUZWwIuR34d2xhPT+6M9IgZdK/DzUj7Oo@vger.kernel.org
X-Gm-Message-State: AOJu0YwsKRjclaVXVJ3IXaMcuK0l1aSNH80ynJcHN70Woz9rSYFCrfYx
	P6iwTB0QsuzPSKiEkWJv74qqoXXM0Q6KZGk6sGtw3zYnZO8sLcN1
X-Google-Smtp-Source: AGHT+IGnHgXzCoYLfVO4IAmPffp9UdTT8UdZ3TotNadEvQeLFNoK2/xvDlu0w5z7lWOj456UG/fd0A==
X-Received: by 2002:a17:90a:3ec4:b0:2d8:8509:85d1 with SMTP id 98e67ed59e1d1-2dba00826d9mr3133023a91.38.1726152780589;
        Thu, 12 Sep 2024 07:53:00 -0700 (PDT)
Received: from embed-PC.. ([106.222.232.184])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe4b41sm12760161a91.8.2024.09.12.07.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:52:59 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: skhan@linuxfoundation.org,
	dan.carpenter@linaro.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] usb: storage: ene_ub6250: Fix right shift warnings
Date: Thu, 12 Sep 2024 20:22:47 +0530
Message-Id: <20240912145247.15544-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change bl_len from u16 to u32 to accommodate the necessary bit shifts.

Fix the following smatch warnings:

drivers/usb/storage/ene_ub6250.c:1509 ms_scsi_read_capacity() warn:
right shifting more than type allows 16 vs 24
drivers/usb/storage/ene_ub6250.c:1510 ms_scsi_read_capacity() warn:
right shifting more than type allows 16 vs 16

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 drivers/usb/storage/ene_ub6250.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
index 97c66c0d91f4..ab6718dc874f 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -1484,7 +1484,7 @@ static int ms_scsi_mode_sense(struct us_data *us, struct scsi_cmnd *srb)
 static int ms_scsi_read_capacity(struct us_data *us, struct scsi_cmnd *srb)
 {
 	u32   bl_num;
-	u16    bl_len;
+	u32    bl_len;
 	unsigned int offset = 0;
 	unsigned char    buf[8];
 	struct scatterlist *sg = NULL;
-- 
2.34.1


