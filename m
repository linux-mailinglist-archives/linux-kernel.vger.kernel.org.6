Return-Path: <linux-kernel+bounces-226372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE3913D7E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7EE280C09
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DF518629E;
	Sun, 23 Jun 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOy/ZF/Y"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7450185091
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165488; cv=none; b=lvgK9J1xre2T+g9/S0ReU1F6fiYPiKPBTEl3ATSKAoQnHahfaZJ4yDwEZohxJdRh2YEdtSCBmLXdFIFYgAyk9tG+slqQq41N0+lLOL8MZ19+vzkG9mKgOXxh1GYyxqgqQZ7bWcpDahy0k5/IayO65p6ySh/eUgZjUU5+uT4tFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165488; c=relaxed/simple;
	bh=R6XM7jW3udkgWoLCKFwsri2TbX0ri2/bGBF7okJLTPg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIYpdKyTQJ4oe84bIU0l/kSMJmkfjk9uNinU6r6kLcR6kIL+SWN0trXSiAxDL8CUpYP65v2O9U/eizIr+DavY0hXrshunKedTcuDw0set2ViS8I1MuHyFntjVcNJdzynV/nozCS4SrpLbSNRGlN4SL6bBtpVsblU6dcfNutsl/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOy/ZF/Y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d1594f3a6so569344a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165485; x=1719770285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CeP6RxLC/M7SQiQJoNsCR+rK4B27OB8IhQklB/6FH/4=;
        b=WOy/ZF/Y1fl9xP9x4PofzvJm5fqLjtweudhDNBgs9vqhMc4HjEa1JcjBxN8Cs0UTno
         vrkepO/fHM8ezCmJgPUc+1LjvjOVPq58gWc4qSVfmIIJh3zQQz9QQZOBH17CCfCE3tTQ
         jL57GbHq39Ovu2cNw+7OjBWgGaJmRinLrcpoZ67l98PPDe6WWc5DODeL08GJEU/x/UXn
         3zHx3Ga5Ynf4ybx+F6PuwBunc5Z/1t83fyBa/GwfCJ1ImO3WJ+th8xPw8GYvLT9bLU43
         sBAPYzKazLpvWVLaIeTqW6R8kYuPz8xMvuvrqFos24NRVIbFYdqfJ1gbYKcou9F/vttO
         c7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165485; x=1719770285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeP6RxLC/M7SQiQJoNsCR+rK4B27OB8IhQklB/6FH/4=;
        b=qfnGPsP7mG2tbV0Od4BzWnkpNqaNbCQ9sC6L67oyph5D5wQCMoD9KfrP/gKPiEEiUE
         xiD+gXqaMPo82mO2uGBWE5ot6RVecA7YljDDk/hpD3klOEmS5TcTgYMuoGh0OKB+lVyO
         3O3pYYoGfmkEM5yaKwGTB3/2ix24qKLwofFQvRx39Wb2JGFG+dja8jhVsdEXCiwibr7r
         AL8Ud3ljTuSJTU8Jl0p3KdwrN+AbybBB7RUlUpklpdxIVm9Zou95wR5GTrRC60iqL8+S
         6oF2MewpfTKO1v5ANrzGqWm/2/uqNA8OASYu1/ElyuCTIrwArZh+p6eIiPZUokMDFMjk
         0REQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQfAOibF4eiAhkHkbax9RF/9H1NKVwvQ9amm64c4bK7/lLGJS4qukrHGxuri4ukq91To3DpMqjtdy0AOhPnitUcMPuQWBgW7aHoLrR
X-Gm-Message-State: AOJu0Yw4dXvu5Op7HyHAMxNHIuskRF9HEk0Wz36nW6EwmHLVQevwMjSo
	K/vvCNt81oLHc9cZSkPtr3U018+8Y//EOPvsE+xuXeKOydvD9lY/
X-Google-Smtp-Source: AGHT+IH9QWeNIWTyxKGzlRLC4GfqQQmKmbdcVjvUEUwgnFfuz/X+GqhDJtokCU9knowP+lRG7OgELA==
X-Received: by 2002:a50:cd5d:0:b0:57c:6895:1de9 with SMTP id 4fb4d7f45d1cf-57d43b68dc8mr2323173a12.4.1719165485119;
        Sun, 23 Jun 2024 10:58:05 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3053558esm3720144a12.64.2024.06.23.10.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:58:04 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:58:03 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] staging: rtl8723bs: Remove unused macros in rtw_mp.h
Message-ID: <49bf00c305b34f2d3ed1061b6a22d042edd3a2c1.1719155208.git.philipp.g.hortmann@gmail.com>
References: <cover.1719155208.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719155208.git.philipp.g.hortmann@gmail.com>

Remove unused macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_mp.h | 29 ----------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_mp.h b/drivers/staging/rtl8723bs/include/rtw_mp.h
index ea3abee325ef..f94bb18479da 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mp.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mp.h
@@ -8,7 +8,6 @@
 #define _RTW_MP_H_
 
 #define MAX_MP_XMITBUF_SZ	2048
-#define NR_MP_XMITFRAME		8
 
 struct mp_xmit_frame {
 	struct list_head	list;
@@ -151,12 +150,6 @@ struct mpt_context {
 };
 /* endif */
 
-/* E-Fuse */
-#define EFUSE_MAP_SIZE		512
-
-#define EFUSE_MAX_SIZE		512
-/* end of E-Fuse */
-
 /* define RTPRIV_IOCTL_MP					(SIOCIWFIRSTPRIV + 0x17) */
 enum {
 	WRITE_REG = 1,
@@ -259,33 +252,11 @@ struct mp_priv {
 	u8 *TXradomBuffer;
 };
 
-#define LOWER	true
-#define RAISE	false
-
 /* Hardware Registers */
-#define BB_REG_BASE_ADDR		0x800
-
-#define MAX_RF_PATH_NUMS	RF_PATH_MAX
-
 extern u8 mpdatarate[NumRates];
 
 #define MAX_TX_PWR_INDEX_N_MODE 64	/*  0x3F */
 
-#define RX_PKT_BROADCAST	1
-#define RX_PKT_DEST_ADDR	2
-#define RX_PKT_PHY_MATCH	3
-
-#define Mac_OFDM_OK			0x00000000
-#define Mac_OFDM_Fail			0x10000000
-#define Mac_OFDM_FasleAlarm	0x20000000
-#define Mac_CCK_OK				0x30000000
-#define Mac_CCK_Fail			0x40000000
-#define Mac_CCK_FasleAlarm		0x50000000
-#define Mac_HT_OK				0x60000000
-#define Mac_HT_Fail			0x70000000
-#define Mac_HT_FasleAlarm		0x90000000
-#define Mac_DropPacket			0xA0000000
-
 #define		REG_RF_BB_GAIN_OFFSET	0x7f
 #define		RF_GAIN_OFFSET_MASK	0xfffff
 
-- 
2.45.2


