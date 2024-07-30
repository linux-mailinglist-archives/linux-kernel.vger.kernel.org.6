Return-Path: <linux-kernel+bounces-266863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B3E9408D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1424C1F24287
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880016B3A3;
	Tue, 30 Jul 2024 06:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="B8Ze7q9C";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="gRkkyAMK"
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D9241E7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321981; cv=none; b=A5xe5G/wmGiSP3q5jPDnIY/mcfwWDbG9ihLyeUa5MhJcyyLX2kEdxMKfsvC4r43dnw9BI0hElssBLYnj+d4qE8EPjM68qU1IlTBDHXuVbO61cYjI0lTUjMvDyM3w03AfftBOZjUCIhLJlEhqLjQFJMDrYLPyGR/YjyFn9x7T7uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321981; c=relaxed/simple;
	bh=rKjoVvpxnUbLKUJLX8QKYA05GnfC5jwRs5LKU3wTK9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLopKXLnsp4vb1Wd6b1wBLjvHi0fkHZDOB2CgzKGRmq11E4fWe40g8yOMp29XKLtkd9J7EPsMTAemSNA5C5CEUCQszTFjx1sK0Y4H8oaqpOVW6sxTZBrNbc8qhVml9cZEJIegAKK2e+1rPhcs3c2y+j/oHtF6gC/3MTmU7f2IBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=B8Ze7q9C; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=gRkkyAMK; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
From: Felix Yan <felixonmars@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1722321470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2E1NBOUaWLZiWkzrT91XszlHXGDEr8gUnIgRpGg+lWg=;
	b=B8Ze7q9CechRWtPT7c0Jwn20m89XOZ9G/wKSECYTZodIkGyqSnGOA2A4DDD2lDgT8Jqvu1
	Omry5TEGanl+8JOU9ac5Jmke/fOO5RDNUDP3tMAAHDAHyJmGQubP6u/yN00btlFcbCQihr
	ZHFrXPw9AUcKkTBVaWCU8K3nTmS8wlw2n4RKDIruGGQrCcoJ4zcE+cVEedBraWVXoQIuk4
	EEf5a2GZENDdIn5ieiv5k6QhR11wOFvR4KhxEefrawzbxWIQWvHTOpy6XWKBnrvWnBxpfE
	2gmlZTtV36Jsa8dpIo7PDVabx35BZbHgYuNxR2uBcJajWupkIZ6aIcjSybEf7vogvIR8Bx
	OdcrgPVXlFNI6k6JLVOZGM5FBxx7pHR4XXBl4RsvX6eTK/P4EA1PPF32lhu8A2F3R3VjOn
	NJayeGjrw/Wu00/rdlgpPybyo85igIzUl3u8iPYnDEtho04cinOw1jae2DN7etNYeYj0d8
	saEY5Uo2dOck35CrqzaZwYkR6G+gb17nFThqhxiql16scnnJbV3cRUQWO+bfmk9x7JTqWN
	7CVlNqyeDgzB8OiyTeIwD3dOOHeNuxqWsmQ/XoCOvmLEZYZHfLQ4bQYJHpPGSrKcSVB4jP
	UVnJKQrnmCNheEucTV7fSrMlkEfnIuO2u2zLslCOrCjuBCyYSRLMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1722321470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2E1NBOUaWLZiWkzrT91XszlHXGDEr8gUnIgRpGg+lWg=;
	b=gRkkyAMK5F6ZpsTbIDGFPTgQilx/PZUMEKvLQB5QnTheobFgwO8+6RtRObi2pJr4AIT9Cd
	tkXuU8K32kfwMsDA==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
To: Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	helen.koike@collabora.com
Subject: [PATCH] staging: rtl8712: remove trailing whitespace
Date: Tue, 30 Jul 2024 09:37:38 +0300
Message-ID: <20240730063746.176245-1-felixonmars@archlinux.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following checkpatch.pl error:

ERROR: trailing whitespace

Signed-off-by: Felix Yan <felixonmars@archlinux.org>
---
 drivers/staging/rtl8712/rtl871x_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
index 2613b3c2acfc..268844af57f0 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.h
+++ b/drivers/staging/rtl8712/rtl871x_cmd.h
@@ -736,7 +736,7 @@ void r8712_getbbrfreg_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj
 void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj *pcmd);
 void r8712_setstaKey_cmdrsp_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
 void r8712_setassocsta_cmdrsp_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
-void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl, u32 tryPktCnt, 
+void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl, u32 tryPktCnt,
 				u32 tryPktInterval, u32 firstStageTO);
 
 struct _cmd_callback {
-- 
2.46.0


