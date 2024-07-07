Return-Path: <linux-kernel+bounces-243505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC8C9296EC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2757E1F218F6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BCDD2FA;
	Sun,  7 Jul 2024 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQvCMncA"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09F17997
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335305; cv=none; b=k/s0grHDYrhEXTn61q6b/RuNVGLNYas6eDIC0p7GAWOAX4mG7gKIDX+dsXv9OFVyWsb0F2YyCkIY/zr9lp8HM6wZ+D/XB6YluGGjHugDLvrzhn7NRyvcw4lUS67vfWqDHIExYsdOXdbQXR4w5IBBQRCUgHs+LJFGRIwOrwrvi4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335305; c=relaxed/simple;
	bh=rzKabKffahYwgJ55hpBHQvrGtgLu5nbsAN1wfIvqlrk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGOH9FEj7RcKLp8CdSLpA0xTHMn/xsZdpwdjOXiQD8BcwqbKKDhpVy/ruHpXLrlPDNc2QCOFX+qmpOLzVU7tswPC1QYP5txep3J4CNA7cFS9+G34e+XkI9T+WfR4mtZDzi7mdDZrEbT3ABIfQeq+swWF7tx4kFhlb442DkrX0e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQvCMncA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4265f823147so1162475e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720335302; x=1720940102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m2PorvJffBvL5zdCnB5NS37w93MVpx08ayzwznwdvC8=;
        b=gQvCMncAsJpw3HwPyIqOVsgrvnmkKUhhUnu+WYBca1WB+Lhk9RjBq5VRlzwuaFTv3H
         /aEtLaNHRA+Wici4KBbdMuECYfoRSy61sWt/PFLhM14L6JHP24XMSuoi0GCh7Ohb6C7Z
         z34Ub+Ed+TYhAOZfaDUNEzuo/3QrriogXGMgscPhNxlx+NiFdT6fXGZiJQqoLNnu2IVo
         oBXqr/1z9w7kEWgNy7Fr9TVWoi7h5NbdfWxBIZImBgYQJjzfZ856KZxKNwfVqCoWFD92
         fv5Dd8EUbwQn+ZzgwDvJBG9UKqLYNsnQnnc90pj0+oN6KY/MnUdxknfTKOo4Rgy1zDgv
         WP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335302; x=1720940102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2PorvJffBvL5zdCnB5NS37w93MVpx08ayzwznwdvC8=;
        b=ut9erJ4C9uXn8XHaKsYj7R8Q7kS9+3JXQDItzD/1F8tHmBCXLI0TR+1SVJCbOy2Olq
         pPDZakd9asjV2FUqvA0Zcgs3VRspPFqvASUbRI2ZrOnP8c6lc7je4RxgD8HjDakVJ+nY
         p0+Oq1LEI13xjZG/8y2ajkH0pra+BG4ODuQPcJRALjECciSM8kqu82SXos6HdwTgIDKX
         L2TD0tQXEs3Hx1MT7RRfRWgYPOHXWrM8EHMlDKSxq4u3YUwm10FCP4VUo5TO+KSUGeM0
         qcrXBo1vtcPiBX+y3NEvbXGlfbYb9Jrsys5uXK3//Hb7n+6MKpLX/9nztqkrXz/Sw5W6
         JbhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJVqVuDHVMydyBvnLP8uGQb4+0MOW2ErhdOp33BEOuZ+P/Nyw4k7Wo/INbclMGBCiaYJvegb7haDdFHRRRyteENXTd7KSlLwkWLOaC
X-Gm-Message-State: AOJu0YwvrJNJXBcL4AOEFV+PGEJtWyUxWfYAHOSpCVsq6r2oka6A6K/s
	1JHg/lGD04ACXNcrmHCMwPeAhfEyDL8G6VGKPUl2bErJEBWL9Y6+LTdKsA==
X-Google-Smtp-Source: AGHT+IFON8nQMBqv3cEJcIEdHB7Adc7nAWFXQc4w7yFh4P2EzQKJvi1Iv7yS+/iqeF16r4tihrMn2Q==
X-Received: by 2002:a05:6000:4023:b0:35f:2f97:e890 with SMTP id ffacd0b85a97d-3679db8926emr6233367f8f.0.1720335302102;
        Sat, 06 Jul 2024 23:55:02 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36798fafa0esm8788724f8f.74.2024.07.06.23.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:55:01 -0700 (PDT)
Date: Sun, 7 Jul 2024 08:54:59 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] staging: rtl8723bs: Remove unused macros in
 rtw_mlme_ext.h
Message-ID: <7178388b14033c24e9c6a3912a1cf19d342b9b22.1720245061.git.philipp.g.hortmann@gmail.com>
References: <cover.1720245061.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720245061.git.philipp.g.hortmann@gmail.com>

Remove unused macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  | 37 -------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 65e138a5238f..5b8574f5a251 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -20,50 +20,18 @@
 /* define DISCONNECT_TO	(3000) */
 #define ADDBA_TO			(2000)
 
-#define LINKED_TO (1) /* unit:2 sec, 1x2 =2 sec */
-
 #define REAUTH_LIMIT	(4)
 #define REASSOC_LIMIT	(4)
-#define READDBA_LIMIT	(2)
-
-#define ROAMING_LIMIT	8
-/* define	IOCMD_REG0		0x10250370 */
-/* define	IOCMD_REG1		0x10250374 */
-/* define	IOCMD_REG2		0x10250378 */
-
-/* define	FW_DYNAMIC_FUN_SWITCH	0x10250364 */
-
-/* define	WRITE_BB_CMD		0xF0000001 */
-/* define	SET_CHANNEL_CMD	0xF3000000 */
-/* define	UPDATE_RA_CMD	0xFD0000A2 */
 
 #define DYNAMIC_FUNC_DISABLE		(0x0)
 
 /*  ====== ODM_ABILITY_E ======== */
 /*  BB ODM section BIT 0-15 */
 #define DYNAMIC_BB_DIG				BIT0 /* ODM_BB_DIG */
-#define DYNAMIC_BB_RA_MASK			BIT1 /* ODM_BB_RA_MASK */
 #define DYNAMIC_BB_DYNAMIC_TXPWR	BIT2 /* ODM_BB_DYNAMIC_TXPWR */
-#define DYNAMIC_BB_BB_FA_CNT		BIT3 /* ODM_BB_FA_CNT */
-#define DYNAMIC_BB_RSSI_MONITOR		BIT4 /* ODM_BB_RSSI_MONITOR */
-#define DYNAMIC_BB_CCK_PD			BIT5 /* ODM_BB_CCK_PD */
 #define DYNAMIC_BB_ANT_DIV			BIT6 /* ODM_BB_ANT_DIV */
-#define DYNAMIC_BB_PWR_SAVE			BIT7 /* ODM_BB_PWR_SAVE */
-#define DYNAMIC_BB_PWR_TRAIN		BIT8 /* ODM_BB_PWR_TRAIN */
-#define DYNAMIC_BB_RATE_ADAPTIVE	BIT9 /* ODM_BB_RATE_ADAPTIVE */
-#define DYNAMIC_BB_PATH_DIV			BIT10/* ODM_BB_PATH_DIV */
-#define DYNAMIC_BB_PSD				BIT11/* ODM_BB_PSD */
-#define DYNAMIC_BB_RXHP				BIT12/* ODM_BB_RXHP */
-#define DYNAMIC_BB_ADAPTIVITY		BIT13/* ODM_BB_ADAPTIVITY */
-#define DYNAMIC_BB_DYNAMIC_ATC		BIT14/* ODM_BB_DYNAMIC_ATC */
-
-/*  MAC DM section BIT 16-23 */
-#define DYNAMIC_MAC_EDCA_TURBO		BIT16/* ODM_MAC_EDCA_TURBO */
-#define DYNAMIC_MAC_EARLY_MODE		BIT17/* ODM_MAC_EARLY_MODE */
 
 /*  RF ODM section BIT 24-31 */
-#define DYNAMIC_RF_TX_PWR_TRACK		BIT24/* ODM_RF_TX_PWR_TRACK */
-#define DYNAMIC_RF_RX_GAIN_TRACK	BIT25/* ODM_RF_RX_GAIN_TRACK */
 #define DYNAMIC_RF_CALIBRATION		BIT26/* ODM_RF_CALIBRATION */
 
 #define DYNAMIC_ALL_FUNC_ENABLE		0xFFFFFFF
@@ -91,11 +59,6 @@
 MCS rate definitions
 *********************************************************/
 #define MCS_RATE_1R	(0x000000ff)
-#define MCS_RATE_2R	(0x0000ffff)
-#define MCS_RATE_3R	(0x00ffffff)
-#define MCS_RATE_4R	(0xffffffff)
-#define MCS_RATE_2R_13TO15_OFF	(0x00001fff)
-
 
 extern unsigned char RTW_WPA_OUI[];
 extern unsigned char WMM_OUI[];
-- 
2.45.2


