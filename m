Return-Path: <linux-kernel+bounces-395935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E86FD9BC51C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B23D1F22B94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77182003C2;
	Tue,  5 Nov 2024 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuzjrdHU"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759731FEFC9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786136; cv=none; b=WTreygSjKUGYEM4aTFevEGcQfnR59qPgEt/9bDi/93I3ft9eZDGp4nY/qKkAmLNqK36fvsuhguklfWUxQgaovgcyfPrAMwQucxZZS3PjBu8bWJAL32abksjxGiR6wpGajTBeBjEtCNkxBLeKVToE/R9Is56tE4JkE0edHzxHxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786136; c=relaxed/simple;
	bh=9oxoSNrl05LDnfU19cL4GGdDL9tbdwm3S1/shv4n9rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrL7w1617jR5ro3xBrtYFxg9R9x/dDN+f6hK5eKXx20HCdPhjB+Se2J3Ez7PHRueFB4ylDKXrtLFACQYespPGKWkrf1Fzd5vnPA+OCW9KgLYY8phXt+dbJSgYHYq8Y2240tNYXn5rTwqz+pAdFAscDxFpTqT0Io4poUxcvJ2jEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuzjrdHU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9e8522445dso465885166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786133; x=1731390933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHh53OxhseY5hazfP8y9zHFBWmzPsydNQrxS+Mqf09Q=;
        b=MuzjrdHUxqj1ZNgczZTMFAXNhNiNIlOVdrdHKiPPkVJVBudJCA4MDB5ExHT/XWj3U3
         M5E5e4qUUghKBxlyDGFiJMoak2/tduBREDFQyKBzraAF/gMjWoEu84QllRyESNkNvBIc
         LFh9Xwa7jqYj4gu+ip5TF8BEYziX2wg5vc/lURq65N8RRaTvNQ+bueULCkMYTqSrQh5V
         wzRiITK7BYSaXTbpDllKw8gnA/OxznbUpiLpxW5MIEBLK4k89pIRhN/bSxtZbo5ZmVDe
         305ZgsWnzeDHCl4IdE7ZlbP9i+l6sWsGwPOEofJo/K5f8iiakjY42IUs2w6U1MdY8FGt
         VM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786133; x=1731390933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHh53OxhseY5hazfP8y9zHFBWmzPsydNQrxS+Mqf09Q=;
        b=HvRUghAVLfrry+IgyJeygmftMlGH8uMYCuVruLHnjBtyqr3sR95o0mRdAbRJqKuPXE
         8JSnPbTzrkFmRNLj1yXZMu3hANt7/u068il5iCGHm5w0m2boofE4Z9odi8JHVPNey4lc
         f1q4OiVdq6DUcf2lTAiivgWh3oCVpAedkTXfomsmUSZUsImNdWAdp0F9bUaQEGll5EDr
         9I+enwcj8gwXkpbwn1F1URq3VDitjweVwMD6GpcQ9wvEDLMUcQEYOnPmW9CfY36LjZV1
         z+N6PgW9SBXTfL9NGPlQSJ27VWWKZqdjGmPX4hB8ML54Zz8YjD7p0CaQb3iTyWct3wMv
         U3SA==
X-Forwarded-Encrypted: i=1; AJvYcCWFecPVrj1gfsdFEBis6gwlHb6pn/CKGMuLZt0TjMdaFGPr6ejXt8CWACcSfBE00laQ0Zd3FeFv1rTswHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwISIKdBDnKrEvBf/w4WN4+HEdN1NWYKDEZcsJJDqwucAuC4Pjj
	IdmBiFztGbeE6kcJY8Or0XZTljLDMzN+n2wbFps3XgpCEBFc0HJDj9nKhw==
X-Google-Smtp-Source: AGHT+IHhGA3OH/rcaYhretm6zSBAxAb2/EldQCnER6BsvR1dEsP61rnKJTZg01jOiEoS4uGu/J1a2A==
X-Received: by 2002:a17:906:c145:b0:a99:7bc0:bca9 with SMTP id a640c23a62f3a-a9e6553af4fmr1500239266b.3.1730786132567;
        Mon, 04 Nov 2024 21:55:32 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:32 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 09/16] staging: rtl8723bs: Remove function pointer run_thread
Date: Tue,  5 Nov 2024 06:54:56 +0100
Message-ID: <aee978f7180d728517af457e525549c19e3618c8.1730749680.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730749680.git.philipp.g.hortmann@gmail.com>
References: <cover.1730749680.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer run_thread and use rtl8723b_start_thread
directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h      | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 46da566106ae..28d15536abbb 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -233,8 +233,7 @@ void rtw_hal_add_ra_tid(struct adapter *padapter, u32 bitmap, u8 *arg, u8 rssi_l
 /*Start specifical interface thread		*/
 void rtw_hal_start_thread(struct adapter *padapter)
 {
-	if (padapter->HalFunc.run_thread)
-		padapter->HalFunc.run_thread(padapter);
+	rtl8723b_start_thread(padapter);
 }
 /*Start specifical interface thread		*/
 void rtw_hal_stop_thread(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 66c2a8fb2454..8d8270d85f96 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1744,7 +1744,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->run_thread = &rtl8723b_start_thread;
 	pHalFunc->cancel_thread = &rtl8723b_stop_thread;
 
 	pHalFunc->read_bbreg = &PHY_QueryBBReg_8723B;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index dc5bb61294b0..3306c26ed2a4 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -164,7 +164,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
-	void (*run_thread)(struct adapter *padapter);
 	void (*cancel_thread)(struct adapter *padapter);
 
 	u32 (*read_bbreg)(struct adapter *padapter, u32 RegAddr, u32 BitMask);
-- 
2.43.0


