Return-Path: <linux-kernel+bounces-352135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826B2991AA4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23BAB21E62
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57BF168483;
	Sat,  5 Oct 2024 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9F3EAMf"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487961591ED
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160492; cv=none; b=XKP677e5ZWdx6/QfMtuVN8Ucbqa4DuOpZDwP1YEeC3uEsW3hr9rOwQnlHBv4EGZORP4F7UbzuPeqKn6XDegIGH8JHuvHFyyNqF2eSgg4g3vLaofjy2XYv6Su2U7MgqAJmVLKA5CCdJScnV8vcmBAr4qbN+/si6EDTzehov9B9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160492; c=relaxed/simple;
	bh=q5jkccRulWr/FM9cDWZHBbIPLgsceK1p3SYDkLvSpgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgqqfvNn+5pqRjEVJoxjpR8AA62vkCSK0+d2FinbXqBsHpsbNRgs0K5LJCb+1rxjExubxr5KJywvdsDA5KG/e/4wvNPGp5CYdmz9ez1V92QhAOhrQ6zFP6m61befYHikiIV9RuVqro2Ui4+PATW2q8yk09iVSHdIHzQzNt1nCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9F3EAMf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so31920685e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160489; x=1728765289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGS5wmBGdEuYs+XoDSYSCpWyPDlISJFCe+zrt7w9w7w=;
        b=I9F3EAMfqKHJ3Qd7E5+iN7XW6Ma8hxySKvgBmjaqHCRpeNGm0YhHp90f958oNiJath
         qCC4Nb+YYnnPI2vG+5OQlgDZrqxAWI7mlHJ0Mzd6a6keT0PlV4RyonewFy5BFk+Dbdht
         2S42vxJuswwVDb8yeBbfWzOnYkpfDBc+qw01zAH5Ym7Fhz/HzbsOg4AkvI/9TSbfwGwG
         L3h54FCu10UokaNLTqnP+4nJM/QX6XhOs+iO7DhDaJHa05lq5mHUVeZhIu244ElUY5jp
         xEg3gFxGcXLdVy94lv26TUW5zPaJnWyTpo2+OtFyZegRe8E4CRf0t5mrYOUmw1F/6URr
         zcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160489; x=1728765289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGS5wmBGdEuYs+XoDSYSCpWyPDlISJFCe+zrt7w9w7w=;
        b=Q0J+19qC8aLwpCnmr3aZDrFARpBPsTbz7YTeD/K2v4hgF820RcgPBxHq+89Mx0O7mL
         Qfk/CP/PC2+axHpMxxQ0Ru70h/1g/4fACwEMMrJ6K3YO79x2MYnwUS6Y/hl4/mvzbS3o
         eVE7tq7nWAdB84bW1l1ZGu2RFkbEUjOpdonpEjM7+Rq12h/Kao+0cASVa5ig5KUCy/S7
         7plMREsu7qn2mTMn5CV7VWZgHh6FQ+aTRYe3/cs5H0j5o/Dx7HyZ6n4qbJx7A0NyHGgR
         TbdY/GnJPgd+I0LlHIMJoCn5+fKfWbcezE2DjKyxo6nfKAel15jm1sL9TaiLoaNy49G0
         l9MA==
X-Forwarded-Encrypted: i=1; AJvYcCVBc6G+Sa+FesCOrtPV3H8V558VF+lo4m52jNGgSpLyW77Hv5QCTYIdaNqTh9cBYNscBr4sXjZyGO61Dto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGAkT7qI8rc2VUXOk/p9schNTOcVYW0fRyTk4tQJEPFN4sIm1n
	aSCrFKZhz8uAZC/4deafvYonIJoVM+YiO9prGGRYmQsTMPayQxI2
X-Google-Smtp-Source: AGHT+IGitESMSPkFKM4+mm5oFRXBO9avimVzsrnOI1EzNSkPcMlWtmDxXldk+gy5mKpCNwM13iWSKw==
X-Received: by 2002:a05:600c:1da7:b0:42f:8d36:855e with SMTP id 5b1f17b1804b1-42f8d368710mr15580855e9.5.1728160488394;
        Sat, 05 Oct 2024 13:34:48 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:48 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 02/15] staging: rtl8723bs: Remove function pointer hal_deinit
Date: Sat,  5 Oct 2024 22:33:45 +0200
Message-ID: <b0acbbdc372e01baabd1d98f824bc2a3c6c4c600.1727966761.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727966761.git.philipp.g.hortmann@gmail.com>
References: <cover.1727966761.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer hal_deinit and use rtl8723bs_hal_deinit directly
to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 2 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c      | 4 +---
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 --
 drivers/staging/rtl8723bs/include/rtl8723b_xmit.h | 1 +
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 684d31360f4b..d9121e13fe69 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -107,7 +107,7 @@ uint rtw_hal_deinit(struct adapter *padapter)
 	uint status = _SUCCESS;
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
 
-	status = padapter->HalFunc.hal_deinit(padapter);
+	status = rtl8723bs_hal_deinit(padapter);
 
 	if (status == _SUCCESS) {
 		padapter = dvobj->padapters;
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index b4819ff2928f..d7941fdf42e1 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -884,7 +884,7 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
 	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
 }
 
-static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
+u32 rtl8723bs_hal_deinit(struct adapter *padapter)
 {
 	struct dvobj_priv *psdpriv = padapter->dvobj;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
@@ -1259,8 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->hal_deinit = &rtl8723bs_hal_deinit;
-
 	pHalFunc->init_xmit_priv = &rtl8723bs_init_xmit_priv;
 	pHalFunc->free_xmit_priv = &rtl8723bs_free_xmit_priv;
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index fc3a94e40721..40383d3cdcef 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,8 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	u32 (*hal_deinit)(struct adapter *padapter);
-
 	void (*free_hal_data)(struct adapter *padapter);
 
 	s32	(*init_xmit_priv)(struct adapter *padapter);
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h b/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
index 5e3483cb22db..ac4ca7e05b9b 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
@@ -406,6 +406,7 @@ void rtl8723b_update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem);
 void rtl8723b_fill_fake_txdesc(struct adapter *padapter, u8 *pDesc, u32 BufferLen, u8 IsPsPoll, u8 IsBTQosNull, u8 bDataFrame);
 
 u32 rtl8723bs_hal_init(struct adapter *padapter);
+u32 rtl8723bs_hal_deinit(struct adapter *padapter);
 s32 rtl8723bs_init_xmit_priv(struct adapter *padapter);
 void rtl8723bs_free_xmit_priv(struct adapter *padapter);
 s32 rtl8723bs_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe);
-- 
2.43.0


