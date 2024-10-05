Return-Path: <linux-kernel+bounces-352140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23554991AA9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65931F231B0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AF8177998;
	Sat,  5 Oct 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbCjZrEX"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE848171099
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160495; cv=none; b=Uu2jb9embX8TNTvg5OtYnJBtgHltumxocTtfrLBbLJ7iUkjW5brTLFK1nHvII/haA6bInyjsLChergZNhOrS3uqg4Xb5Z/qHB8ke7Z/QZlIcM8UY7jy5UnjitEW2+qb8mHvdgR5SFpjor6O6cjP8Jxd1LK8s5FTHgkiJSkDbRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160495; c=relaxed/simple;
	bh=dabQ6fghBfIvhyifZzKyzwvT/xIYIhxb9K8PNzkevQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SE/JyWOz+6jlj5n17mgVQhAun64E+k2Muv1JSQJdwRc4Ut7DmqiFKcw8JH+0QQfpUV5z+08fuiX4/n+yohFrm6QPcg4lSkw/MO622BujjxLlyNpyXiYN+MSxEPU7A7sSCdPYGRyKGmQ9TsLFed9DadvZEaqQJzce5J711OVRMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbCjZrEX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so31782195e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160492; x=1728765292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxnc96e2zL7BVq58lm7tPzStwCCg21M4KyRml5a1xEk=;
        b=PbCjZrEXVen8ENQTYOroVZpCHdvRnMVAgeYg1JdNtWOKFzxi1RsX2BHWZDMgzsQg64
         HBUbmhe/RSkKPrJi7TG2d/ACcc74zR47Odr48TvJL4JTZcsQNxvWXL+b8mvSKuwbBt3w
         AFwTjd7jjH9HKA8AHWgJ0YXCWOuY1JX1iSlhTit7nYQZuSY5hnU6JponD3wItVrTvc9j
         buYBsu0Zaa55z2/Ogm73E0K9hme7USHuJhSsajQviL3whqsopd2ebBmm84PX8qvfUS0l
         MpUPfsxMnT8RCDMoI+QzUV/P0mZ+mOYR860Yd8DCPmr3TNFwTxk3CCUuOM41mibXypAp
         LEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160492; x=1728765292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxnc96e2zL7BVq58lm7tPzStwCCg21M4KyRml5a1xEk=;
        b=cx40q/cYtXLjcnvzFoFQf+CaP9AS8Zo0OqG8dy5ukPlh0CFxzsF4GRALw3hG5QH7Ux
         v35reerPVvUlsn4DcceJ1g5WwfePfzrjkCZRj+Ek24pt0L3iU00d9eaDlkAX6fVToc8J
         bgjb0SUY8S+XcN/DSd6LYMzbTZ7zzg/jNtD7GThE3fxynPZMe3LtxsTAQogdishBvYqw
         JMdBlIeLRaeUY5YWZM7SzZElC24zejThnFyMFr/VTwgYH1SrA7YhQGN82lLQUD20M4B1
         LRzlnWby7oArMLqzd8CR/8TSmveNMgUjv1j4w1SmGTpZci9eJjUNsCd33r+Ls4o+kP1i
         eocQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoRaE8P7mjl/7N9uLFhw+Aguo5DUv3RmKXi3eyNDrYHoEpYTQOAuwefa+0GbkzN06TpJ7dL+miQDxD1+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzylSvJfQO3oZmrA3cJJBLIwJZEpfQUJpilaw6id+VScYsgx5mE
	OUXgTistToXXMDOO41dacgpFVl+VhNuu6Vfsz4wQ0Ddl4QAefIQp
X-Google-Smtp-Source: AGHT+IHUweZibiPXVMd+Cs17iH023FX7ucoRIBL+3Nw87JOZUy0zoEaXpTUDzdFBAI8zmvbRKEHtPA==
X-Received: by 2002:a05:600c:19c9:b0:428:10d7:a4b1 with SMTP id 5b1f17b1804b1-42f85ae92f4mr50982645e9.25.1728160492135;
        Sat, 05 Oct 2024 13:34:52 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:51 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 08/15] staging: rtl8723bs: Remove function pointer dm_init
Date: Sat,  5 Oct 2024 22:33:51 +0200
Message-ID: <e25134aacd3f784300f527d7e367b9f0f066254a.1727966761.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer dm_init and use rtl8723b_init_dm_priv directly to
increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 --
 drivers/staging/rtl8723bs/include/hal_intf.h      | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index de7dfaa69c66..760ba45de8f7 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -39,8 +39,7 @@ void rtw_hal_free_data(struct adapter *padapter)
 
 void rtw_hal_dm_init(struct adapter *padapter)
 {
-	if (padapter->HalFunc.dm_init)
-		padapter->HalFunc.dm_init(padapter);
+	rtl8723b_init_dm_priv(padapter);
 }
 
 void rtw_hal_dm_deinit(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 867021ed31bf..106f1124964a 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1823,8 +1823,6 @@ static void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_l
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->dm_init = &rtl8723b_init_dm_priv;
-
 	pHalFunc->read_chip_version = &rtl8723b_read_chip_version;
 
 	pHalFunc->UpdateRAMaskHandler = &UpdateHalRAMask8723B;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index ced414f2368e..8b85baf5be92 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,7 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*dm_init)(struct adapter *padapter);
 	void (*dm_deinit)(struct adapter *padapter);
 	void (*read_chip_version)(struct adapter *padapter);
 
-- 
2.43.0


