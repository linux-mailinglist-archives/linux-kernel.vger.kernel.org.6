Return-Path: <linux-kernel+bounces-329695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BB99794C6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E941C210A1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4EA3FB8B;
	Sun, 15 Sep 2024 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baEr3dih"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E6225D6
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382463; cv=none; b=YqKrWhto2tlDJVM0irqDl3R/r1Jlbd2Pe4qPO6AW41OYwUmusvQFC5bM9E45h5jAZHbfMXLG+WqTUbyhuoffEvlE7vtsJ6h9+U9zncW7wJ6W07LghzxU9+pMCrlXm63Hwl3gaAwq2PPrb+aik9WXMahF7riIwBPnVlp3gIrUhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382463; c=relaxed/simple;
	bh=98wEUhIQg0oe7cqCfXtb9PvhfHYoR+LzgTdsHvJWDYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUhLaFpHG+g6Mqsjl9w9r+HCEwPk9FIPO7r9rfiFOqjMBeAvDAcPnDPhjW2zk897BMtYpUeIR8vPTRZQU9KZBm0HTP0BDoTx3rKoyDloWC+QkRf+Y4XtbQh9MjgX5dJrVNtXo3mJPjAYCHE3lFI9J0SlRhopgAZ6LJZePIpyTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baEr3dih; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c423d496abso1356960a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382460; x=1726987260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mytdCWz4Iuztl7wUallrWXgXAVacZn2drTPgnY2iPjQ=;
        b=baEr3dihyVIMikfRnAFtK+JRUk95k0M6M+BB+8S9+Ot5GLLPr1RdNaMT9JzDiqNkXi
         rqjE+9zS/O7O/Q7gL83g5XjmKcuu8v7CKawSMwvnHKsvY9tMkf1Hnmu3zqEGTXIU4LCb
         eoXLPE8vG2kcJWyYP/S9gnQasFmlqvbGNv6fupG4YnUuNg2MQ01Jbtvh5o+5DlPTLcqc
         xAuvNs2dXH2gw2UsL4CKnWo/Mg4oDW3IIt+AejV36vFPYBujHVInIINdt3caOjK50TpO
         2yfkBc6Gq/MxW3E9ZNq+8pNUSjn5cl9JVGkKPeLT18UqF0WyLryYPm7AWcQyR7fef7Ba
         wVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382460; x=1726987260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mytdCWz4Iuztl7wUallrWXgXAVacZn2drTPgnY2iPjQ=;
        b=QXL8Hkkxlb6FSEzSyNIfMYwTAaJBTRlknFtIP6KGoSXjiYqWdSzVRFqjrVmDfP3JxH
         c9cNLObjuxVvFhqiqApGzZh4dA3uJOK6yBHt9KIdJP5EVTnxnKCS41HTcSa8gtB4YpUl
         exed19VgGIsHni9AA4bjmlhV3k0xu0aPYjH4BJCiRFJ09WUuQpA3+JXH9wYvBo0Gt/C2
         DH529CD3RieUC1EoFoCwUt/q1ULxyy65XXI2IAGYcJyBzbJINj5eeu9eGsVrBEHJB6/H
         OZjlbFsVcg3H0ecg4D00/+/5jZXbpYBqbSB5xPKqJoaDycn0HEZXOn5YXgZSdEqfT1aY
         U6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDziHpmq7TOn5AapntYSJOnB/zS2CulyEuUigrn6wzESFwyro6cr3kLF1uyXf7G7g6vQ2WqVnGlT2BbAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rjGc6RaIFAg8QePn7vEGxfAcO2fg3jsUdDIwm32hsVbJqNTX
	1qUH9YtszYxfJZKvgPUQVCZPl9IQFJ/rXm4q3z5ZlvhOPrEKES+WDbtt7A==
X-Google-Smtp-Source: AGHT+IHo9z81VjnaVgB+Goew5pVeM34br4ujYIIrCTB5Q4Wqd/Wut7NSV6Wcd+sQfylyH8FwfQX9LA==
X-Received: by 2002:a05:6402:2687:b0:5c4:2448:87e9 with SMTP id 4fb4d7f45d1cf-5c424488a68mr12228752a12.0.1726382460360;
        Sat, 14 Sep 2024 23:41:00 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:41:00 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 05/17] staging: rtl8723bs: Remove unused function rtw_get_oper_bw
Date: Sun, 15 Sep 2024 08:38:19 +0200
Message-ID: <5918320008abc9a14c00fd61f00b40f35f1a5bef.1726339782.git.philipp.g.hortmann@gmail.com>
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

Remove unused function rtw_get_oper_bw.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c   | 5 -----
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index a4cc48989445..4eee324385a3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -290,11 +290,6 @@ inline void rtw_set_oper_ch(struct adapter *adapter, u8 ch)
 	dvobj->oper_channel = ch;
 }
 
-inline u8 rtw_get_oper_bw(struct adapter *adapter)
-{
-	return adapter_to_dvobj(adapter)->oper_bwmode;
-}
-
 inline void rtw_set_oper_bw(struct adapter *adapter, u8 bw)
 {
 	adapter_to_dvobj(adapter)->oper_bwmode = bw;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 479e90ff336c..2080408743ef 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -447,7 +447,6 @@ void Set_MSR(struct adapter *padapter, u8 type);
 
 u8 rtw_get_oper_ch(struct adapter *adapter);
 void rtw_set_oper_ch(struct adapter *adapter, u8 ch);
-u8 rtw_get_oper_bw(struct adapter *adapter);
 void rtw_set_oper_bw(struct adapter *adapter, u8 bw);
 void rtw_set_oper_choffset(struct adapter *adapter, u8 offset);
 u8 rtw_get_center_ch(u8 channel, u8 chnl_bw, u8 chnl_offset);
-- 
2.43.0


