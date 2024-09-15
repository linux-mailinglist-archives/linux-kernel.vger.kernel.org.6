Return-Path: <linux-kernel+bounces-329697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739999794C8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666361C2140E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954EA49620;
	Sun, 15 Sep 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lei3/Jgv"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B0224EA
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382464; cv=none; b=qL4/AhdLaDc5gGyrykQHS/Kiat/wIdwziCQmtFefIlz0/l1hXYIo2HpqGgjzTunNBetWYo8FUIVmKJ77mPZ6eH/Xl/cbyLoRLIujC5DOXrB/IOJfeXZezw4OASM1N35EugTZZGknKz1zGkTaXSmJnxuGhpCR6EgjaHNnvXw1dqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382464; c=relaxed/simple;
	bh=J1eaPEGXQTggxvrag31RjvbO/OZwnbWAvNuMWEu8Z1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPCfqKODnxEqTEXR80/tM8ah5nyznw1x84yP0Elli6Za6tY1TPNgrSuqqSju/r8wYPv2cJU2yMh133uNs2Pd0NalRjoStoDa61p0ecESXNQNK4QgKyhTNr1cGHwx6i2gIY1Y3xt45hhngavUYWwmLnzNsF6J2t0RyXGuOIaJJE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lei3/Jgv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a81bd549eso408076866b.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382460; x=1726987260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtdv6H+0O9IYGXXcKB93eZPrd2Xv4iQ27EcAPr2FIFs=;
        b=Lei3/Jgv7AVo9LyKjz41QHUOTmx65fcRuSQkwXMcel8nHPK2XiK00goVKoNs/Ni8wZ
         iI5HEWldHpCffxazdJb44vf2msspN55tftYtuxa1QLXLoMGpf1koOEYw+AqZRC5xZZAg
         x0QsrxxheGl+ngti67TJFM5XTmkp3jl6vlogIshow8ynBc1M7DqHeQm8Sf5KGd3ZSGeV
         67qHsA/QaX554YDQLWdXX0G2ym8Ov0AZ6xil5TOXJdUo3MpYwZ1hvTlYs82vP2qxknXP
         s+/GObBxSeuCC/FhiLHCLHq2IxG0yI8DubAHDp/YFqNbdomf11Q7JBYrYHn5ALJypaU8
         mWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382460; x=1726987260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtdv6H+0O9IYGXXcKB93eZPrd2Xv4iQ27EcAPr2FIFs=;
        b=XL1fRIe/qzVXG9cBnXuuT4MaIQKr+5qyb8v2/QJbApMedocSy4X7QIElru96M8IaDC
         VAn19hVbRUX5LFN2Hv9jVOdbsuTjjCpabEMXJP/H69OJ+oZ06TVAJ4uW6l9t1OjjUwCS
         vdrx1fwql2XySBD7HBtHVwhOjUTj2YnaAtqMZ2Tk6NjOUAD5hAymx2FjWeeyAnrVzsIX
         DvH7ScLUkziAl7AP2GYe9WEGRCSs9Iim1SPLmQfcdQHTfKoiItoljdTQYehF98Ow1Fp/
         T5uLqZh5TjPhFhRYjcQgtrq2ASesd5U9+TpNawBCQ9IJcjpLGQJWZcd50LfiBVZCJf3Q
         uQTA==
X-Forwarded-Encrypted: i=1; AJvYcCXDJacltLSwFK0GQ/x3JK5ESNpQsvJyUuAiMRKBPeR+FVnw0rqRRMW9uQw78qxpd6PDYoMID4qA+cfiNw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Pee1fri5UbZ5Qn2qr6fb/BpLAzbgpS39yW8Olza3l0FptBKz
	20XucA4S6XdLrSy7YLWBgwztjTfUW4ZcPdVxow/5SOMzM/WsS5DCEf1KCw==
X-Google-Smtp-Source: AGHT+IHuv4df+s1zPsWeAfo3P2ZQTG12QhiqcUEflqhuSA7TDxUiFuZoUXwvwMRMIOQBAySGfFt5Fw==
X-Received: by 2002:a17:906:cadc:b0:a8a:7501:de21 with SMTP id a640c23a62f3a-a90294ab552mr1091979866b.12.1726382459810;
        Sat, 14 Sep 2024 23:40:59 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:40:59 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 04/17] staging: rtl8723bs: Remove unused function rtw_get_oper_choffset
Date: Sun, 15 Sep 2024 08:38:18 +0200
Message-ID: <23623deed7bb225c614693d9b871e2d6f49744a0.1726339782.git.philipp.g.hortmann@gmail.com>
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

Remove unused function rtw_get_oper_choffset.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c   | 5 -----
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 85215838a004..a4cc48989445 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -300,11 +300,6 @@ inline void rtw_set_oper_bw(struct adapter *adapter, u8 bw)
 	adapter_to_dvobj(adapter)->oper_bwmode = bw;
 }
 
-inline u8 rtw_get_oper_choffset(struct adapter *adapter)
-{
-	return adapter_to_dvobj(adapter)->oper_ch_offset;
-}
-
 inline void rtw_set_oper_choffset(struct adapter *adapter, u8 offset)
 {
 	adapter_to_dvobj(adapter)->oper_ch_offset = offset;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index ba39435d1a10..479e90ff336c 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -449,7 +449,6 @@ u8 rtw_get_oper_ch(struct adapter *adapter);
 void rtw_set_oper_ch(struct adapter *adapter, u8 ch);
 u8 rtw_get_oper_bw(struct adapter *adapter);
 void rtw_set_oper_bw(struct adapter *adapter, u8 bw);
-u8 rtw_get_oper_choffset(struct adapter *adapter);
 void rtw_set_oper_choffset(struct adapter *adapter, u8 offset);
 u8 rtw_get_center_ch(u8 channel, u8 chnl_bw, u8 chnl_offset);
 unsigned long rtw_get_on_cur_ch_time(struct adapter *adapter);
-- 
2.43.0


