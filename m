Return-Path: <linux-kernel+bounces-316793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2163196D58F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D5B1C23403
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396891990D7;
	Thu,  5 Sep 2024 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUiXuyuJ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201821990BA
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531129; cv=none; b=bHtndeLMqAY6V58BTvxr07JUk9GMbtnXLFTu2QFA5ND+gaui4oZ9AqzjRWW75ETz+k0QCBDPdkDYhyL5KqoplMUoUg2QDRosi5PhXdbgo4LmPYfkXMAZh/KU0hm8+d55VBT/aVbwNaKvfczYjs21EOd1D+bftFGeFwaVnpodzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531129; c=relaxed/simple;
	bh=o5FOUWdQCv8tBt7r1pne9auPRTXSKUX1t3dlxBS/r4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DtgLUNDP8l7sMtOz5EE689axLMawXVVmIfVbawHWZE1vEUeiF9+eUqm+46Nuf/pDNTrkT9VPFffsqb/KbVDGvXsRjardurhGIzCFJ48DLjwSx2rYCvjaWLCCgNNiZUWWYNOTzeLxkGFjwVL0g+FLArsCLv21f0O56ZYsFQrMkAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUiXuyuJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71433096e89so457720b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531127; x=1726135927; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7uFupUZ9+Xx0XmShLW0ZK43bhFwuD5Gt0NUf3ksbS8=;
        b=cUiXuyuJmDqy2SlnNbD+D0OEBDuoV2KohPIOn4PylKFyca9y4OPIszv4G46cT//JDe
         6TFZ0NcTh/g70dBYFH0I2a/6jeo7PNidlceOV5fCrJk2T2z/4mFij3sN03gYqzFIegwr
         8SPP0+V2IzsR4TOW0vNj3Q2cJj+4urm6wC38uQCwmDBHoXOZhLNObxp48kRbgvKm4lda
         irO+/VF8/Xa2bbEj0nmPfGLA8G+69cCHDoGWtDgoV98ow0NtYTWULdLStZItZ2dNwYz2
         gUd/C2VA5mcBgl0cJYZfk3NBgKZ/Jf2tLelvi3fhR191WPa1R+w9fq/hz0hzPiXOEp+Q
         lEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531127; x=1726135927;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7uFupUZ9+Xx0XmShLW0ZK43bhFwuD5Gt0NUf3ksbS8=;
        b=d53NF3Y3YfxgWeR4G+BoEf7dG1SXuzN/XpGwfiQxl1y8cXyGpIJJph283vglLx48Ip
         L/krjhruuBdoWgU9fdBLFf1CXwhaDTDIXM0OmSU92dZ1i6NVc1syZ2o9NHPCtNeyHvgC
         +rQqZdqb7FMHPeONZ+zRuxL7BLxR40b+J0oZdcZs7l+1Zv0mG9gslxFPHQl/wAbSnmuW
         Cgn1L3neTK4lxyy/yB/BKBSn2krJ+ZiP+dDWO4QSgtaxv0dMc6uGswGqcryfrVHCVdmX
         Gh0sxVMYnngYcsdMY/A81K57Lj1Qffzkb9wLJlvyHlJNyixw1A92bxYnie5tkxawPsQS
         zWew==
X-Forwarded-Encrypted: i=1; AJvYcCXubJZZQ/AYt+dIiqH/EQuFRooKqFIrPxweDUPUp43Kl6vOUtuiUQHy6TYpQrARY8uGUBzzDIEcJrMj23A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwExRUq9QJ+rcgIItBeZjBvrWVJhxmNN1NOIbo4+gYs/qiTwUZP
	fk1htkMeKyvFqhk5VmhzAa65K10s68EzyTC7xH/a6O35ftOyggLC
X-Google-Smtp-Source: AGHT+IHXFbuUWD4wnmvyXxxH8FJ3A+XanXTZAkaP2j3zLD4RCvT6vOhnHpHccTGQvjC5LlpIqDD29g==
X-Received: by 2002:a05:6a00:124c:b0:706:6c38:31f3 with SMTP id d2e1a72fcca58-7173c2057bemr17920323b3a.8.1725531127397;
        Thu, 05 Sep 2024 03:12:07 -0700 (PDT)
Received: from victor-IdeaPad-Gaming-3-16IAH7 ([116.68.76.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785b75dbsm2913388b3a.212.2024.09.05.03.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:12:07 -0700 (PDT)
Date: Thu, 5 Sep 2024 15:42:02 +0530
From: vivek t s <vivek6429.ts@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com, dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Staging: rtl8723bs: Rename function SelectChannel()
Message-ID: <ZtmD8i7YZLRIcaI9@victor-IdeaPad-Gaming-3-16IAH7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rename function SelectChannel() to r8723bs_select_channel(), to avoid
CamelCase and to improve cleanliness of the global namespace.

Signed-off-by: vivek t s <vivek6429.ts@gmail.com>
---
V2: Prefix added for function as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.
    Commit message corrections as suggested by Dan Carpenter
    <dan.carpenter@linaro.org>.
V3: Commit message correction as suggested by Philipp Hortmann 
    <philipp.g.hortmann@gmail.com>.
    compile tested.


 drivers/staging/rtl8723bs/core/rtw_ap.c          | 4 ++--
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 4 ++--
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c   | 2 +-
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index e4063713fecc..23268ec502a7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -277,7 +277,7 @@ void expire_timeout_chk(struct adapter *padapter)
 		/* switch to correct channel of current network  before issue keep-alive frames */
 		if (rtw_get_oper_ch(padapter) != pmlmeext->cur_channel) {
 			backup_oper_channel = rtw_get_oper_ch(padapter);
-			SelectChannel(padapter, pmlmeext->cur_channel);
+			r8723bs_select_channel(padapter, pmlmeext->cur_channel);
 		}
 
 		/* issue null data to check sta alive*/
@@ -315,7 +315,7 @@ void expire_timeout_chk(struct adapter *padapter)
 		}
 
 		if (backup_oper_channel > 0) /* back to the original operation channel */
-			SelectChannel(padapter, backup_oper_channel);
+			r8723bs_select_channel(padapter, backup_oper_channel);
 	}
 
 	associated_clients_update(padapter, updated);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 6c52a856c9e7..834b53c0ee1d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3831,10 +3831,10 @@ void site_survey(struct adapter *padapter)
 		} else {
 #ifdef DBG_FIXED_CHAN
 			if (pmlmeext->fixed_chan != 0xff)
-				SelectChannel(padapter, pmlmeext->fixed_chan);
+				r8723bs_select_channel(padapter, pmlmeext->fixed_chan);
 			else
 #endif
-				SelectChannel(padapter, survey_channel);
+				r8723bs_select_channel(padapter, survey_channel);
 		}
 
 		if (ScanType == SCAN_ACTIVE) { /* obey the channel plan setting... */
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 7fac9ca3e9a0..87ce4a9b3aad 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -333,7 +333,7 @@ inline unsigned long rtw_get_on_cur_ch_time(struct adapter *adapter)
 		return 0;
 }
 
-void SelectChannel(struct adapter *padapter, unsigned char channel)
+void r8723bs_select_channel(struct adapter *padapter, unsigned char channel)
 {
 	if (mutex_lock_interruptible(&(adapter_to_dvobj(padapter)->setch_mutex)))
 		return;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 720aeeb002b0..8315399b64fd 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -455,7 +455,7 @@ u8 rtw_get_center_ch(u8 channel, u8 chnl_bw, u8 chnl_offset);
 unsigned long rtw_get_on_cur_ch_time(struct adapter *adapter);
 
 void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigned char channel_offset, unsigned short bwmode);
-void SelectChannel(struct adapter *padapter, unsigned char channel);
+void r8723bs_select_channel(struct adapter *padapter, unsigned char channel);
 
 unsigned int decide_wait_for_beacon_timeout(unsigned int bcn_interval);
 
-- 
2.43.0


