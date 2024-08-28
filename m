Return-Path: <linux-kernel+bounces-304679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EA4962384
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D31F1F227AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C6B161901;
	Wed, 28 Aug 2024 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjMhaVCw"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29F15E5C8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837704; cv=none; b=X1wCXrs0CuWz/pAQA+EisMO500v8iKodb8gXgZtWl9koym8doUSpM4GBLx0Jf0taWGs+8xQRwCH0LOAfmZI090sxprJI8Pqm3gym5RuOYi0nB1U/SSIzzUNDI19UF+wxp/lJRqk4eKnww4YYRk+Bl3WoBrx49psgbJf0T06PHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837704; c=relaxed/simple;
	bh=4YS4I0XQCIaNKYbjXiti5OZquZe0TdclS1625mfl7XI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cPF3+DQpw79s0UktdCIjZYJns6K5+vnCSYiLOEkqCBaohgUYH7/q9nebSw3V5FSaueMVhlx7VJzXWmNzaUFJJ3pQoDu3GWtkvcVZlH//UxrabCizIDy6RfLDrNqbuj4adBIbRp1+KmVF882sqD6t8cy5tCo4wX2HWP6yaa7PwYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjMhaVCw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20223b5c1c0so59510855ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724837702; x=1725442502; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZUXGBXAC8OMsfLHHG3FliGgquwdY3FycIOEhk4W18k=;
        b=EjMhaVCwF91ODhwri+ItpOmLn14XekFWQ3ne2e7TvR4I4Bj6rhFxM2dHdNKGcsUvHk
         zF4xbdWEYIlpdsqG5IxLjHGWL9Kcosm+y8mYps0l5TOs5KcyrNtA1fth2yHQZxncWXMN
         nO2atsKX6+RyBgKalCoLk7lGJwZfO79vmr7i1fXlcqKuLOHWYH9GnB6rBy2M79gozgbp
         bBt4WtvHVIzLoV3Lz4Am7u7OvQ5It9j7Wznm5MWZio6wJBxniFD5aL+7YgkdsyvZVr9k
         NrxaqaP2QIzs/1c39yr9WcRrQYeT36u6Fht2Pss9D31CtQboor++vueYJX+dZxPq+j6c
         1XHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724837702; x=1725442502;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZUXGBXAC8OMsfLHHG3FliGgquwdY3FycIOEhk4W18k=;
        b=cNH5NzS5l7Mz/qyfYzoPCNVqyyHxvE9BYO19CG23WsNNFeWxEd2vp7KZd5QzGBNwaQ
         cIkeU9WpMMfJ58T1pIF0Yi7vCyRfCW3EIwnRwQDyS9kqwjvXkZaViQiP8KHKck1X+F09
         3mz3Akg/KGy8jT8WAxIWy2YHK/U4rZLFe34jEdgb0wMpykso3I2f2i1JiK5xkQCjjdQ+
         1KAvvbcebuFc7qiAdhCXL2iHFnwkSSGoQq8TIABHK+F1X08hG3IyhjILNvmSVOgsXsrg
         CKMBDRndTHy6WgqevKlfvU6v0guL+G5tTXCpmrvTfTqwnhWdpTUpZC86hAy3V07fWyfg
         PW9g==
X-Forwarded-Encrypted: i=1; AJvYcCXxoB6pinMDqCrniKTLWCqlUeiZ+CT0qb+e+Z0l5DNWJhceAm57r0UgOAiFD/b3WknhvLYYjqUPCZ987Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCNeknG8dK2u1D1LUYvnoH5nn3ChhqYAqIkJtYxCSfbkpnmWRS
	C/70x6Uo5ox9bKvmLCrIoZneKqgkhGA00P9adRQsM21o2QAEllUeCAe9qg==
X-Google-Smtp-Source: AGHT+IF6pUDGNAwEjoRgky7yn/+9QZbXK/RaHJlmwJmE1NSEhhOVH8IeadJllwTsNLT7HQ9VlbZmnQ==
X-Received: by 2002:a17:90a:df0c:b0:2d3:c6a7:5c83 with SMTP id 98e67ed59e1d1-2d8441b1f5emr1514649a91.35.1724837702003;
        Wed, 28 Aug 2024 02:35:02 -0700 (PDT)
Received: from victor-IdeaPad-Gaming-3-16IAH7 ([116.68.77.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445e8f72sm1243173a91.20.2024.08.28.02.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:35:01 -0700 (PDT)
Date: Wed, 28 Aug 2024 15:04:57 +0530
From: vivek t s <vivek6429.ts@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8723bs: Rename function SelectChannel()
Message-ID: <Zs7vQXhcYRCxCDaH@victor-IdeaPad-Gaming-3-16IAH7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rename SelectChannel() to select_channel() to avoid
CamelCase warning from checkpatch.

compile tested.

Signed-off-by: vivek t s <vivek6429.ts@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c          | 4 ++--
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 4 ++--
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c   | 2 +-
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index e4063713fecc..9bb1c5d9d5c2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -277,7 +277,7 @@ void expire_timeout_chk(struct adapter *padapter)
 		/* switch to correct channel of current network  before issue keep-alive frames */
 		if (rtw_get_oper_ch(padapter) != pmlmeext->cur_channel) {
 			backup_oper_channel = rtw_get_oper_ch(padapter);
-			SelectChannel(padapter, pmlmeext->cur_channel);
+			select_channel(padapter, pmlmeext->cur_channel);
 		}
 
 		/* issue null data to check sta alive*/
@@ -315,7 +315,7 @@ void expire_timeout_chk(struct adapter *padapter)
 		}
 
 		if (backup_oper_channel > 0) /* back to the original operation channel */
-			SelectChannel(padapter, backup_oper_channel);
+			select_channel(padapter, backup_oper_channel);
 	}
 
 	associated_clients_update(padapter, updated);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 9ebf25a0ef9b..a79bb2930170 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3831,10 +3831,10 @@ void site_survey(struct adapter *padapter)
 		} else {
 #ifdef DBG_FIXED_CHAN
 			if (pmlmeext->fixed_chan != 0xff)
-				SelectChannel(padapter, pmlmeext->fixed_chan);
+				select_channel(padapter, pmlmeext->fixed_chan);
 			else
 #endif
-				SelectChannel(padapter, survey_channel);
+				select_channel(padapter, survey_channel);
 		}
 
 		if (ScanType == SCAN_ACTIVE) { /* obey the channel plan setting... */
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 7fac9ca3e9a0..b45ac9156bc6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -333,7 +333,7 @@ inline unsigned long rtw_get_on_cur_ch_time(struct adapter *adapter)
 		return 0;
 }
 
-void SelectChannel(struct adapter *padapter, unsigned char channel)
+void select_channel(struct adapter *padapter, unsigned char channel)
 {
 	if (mutex_lock_interruptible(&(adapter_to_dvobj(padapter)->setch_mutex)))
 		return;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 720aeeb002b0..310352131e9a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -455,7 +455,7 @@ u8 rtw_get_center_ch(u8 channel, u8 chnl_bw, u8 chnl_offset);
 unsigned long rtw_get_on_cur_ch_time(struct adapter *adapter);
 
 void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigned char channel_offset, unsigned short bwmode);
-void SelectChannel(struct adapter *padapter, unsigned char channel);
+void select_channel(struct adapter *padapter, unsigned char channel);
 
 unsigned int decide_wait_for_beacon_timeout(unsigned int bcn_interval);
 
-- 
2.43.0


