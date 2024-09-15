Return-Path: <linux-kernel+bounces-329693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C39794C4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322CE1F220DA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B90C2628C;
	Sun, 15 Sep 2024 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WznPlILh"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7B22083
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382461; cv=none; b=YTxoOBsGxn/exQxH9lFGqi+sbDT00tUtylRbeS+H9qC3A9U11mZpeHBQKF8J6F7dHPOJFw7zQSNYIFmxAnwW8bKO+/l1hbZ5o8a+ZbhXPdZrKgFIPaQcxznvIhromHyZ/0DJvkl2zuLWDlnniCETHlEMy1D0gmOvXNk6pfCI1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382461; c=relaxed/simple;
	bh=pvldl6v2DFlIl2vFANnRg4XBzOOXrXQyVsi9Mo6ORJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHRS3ZLplq4FV7uB6cC3j8ymQ4TCjkWzJElOlhq9jT2EIkaZB2pvp4behzdPQOcCwTp2iU/SHCmH716LClSJ0HiF5GYjeTfwgbDhiqS/3HZmoH+LsfPL4iJbbjpHofCVI77JB6m3VI4FLkOLZNVs/cZ9ojsJ7gAr/ovd7XQl5ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WznPlILh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a81bd549eso408075466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382458; x=1726987258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC/kfw8fP/MikLolFMSvfN+YF3ONZgmkBG/9V4Tu3L4=;
        b=WznPlILhx6DwDu7OQXbZKEki+8uWB1KkLKSLLOcnPsoSmir4oyFN4P3tyGHG89b4nD
         WWJsghiAzDhvLVX+95mezlKi9c2uwr72G1PBrjisAzIm7k3CVf/FC4mJLQupXteDcQWW
         fhIv1/Mh5f3Kr3o7DaBwnJxkBbp2VCurl90lHfRzbuwsgrfJF2+s69UygOD5gWh+7XVq
         u2209NjwdzOGPS2CjyLV+IoAPN9GN9PkWNEKBMobfoFJHCKuXs3+tr8XSiyABdHoHPgq
         zKR5II2Uw21bpGzI17cmFU2PbjACqwJqpm58NSz3cEx22jMllZU68rs3B+hkcW989CJ5
         NOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382458; x=1726987258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eC/kfw8fP/MikLolFMSvfN+YF3ONZgmkBG/9V4Tu3L4=;
        b=GAmWyt4E+ZJYBCcl7WHO8rbpseZD+ENSUTePv+9YVXaU301OIB9sN6XhYVRK/Kl8XR
         vgcjQBZ3hgBAl6ojDws4z965YHDGQPIAPzTQ1JsItBr+sNhA9+UXNvYRSiR25dBfUdjM
         epD9kGK7PbBofxAtoJBebC5tgO176wuTuVvsnlJ/W3S78FzQyPixvKjpJqaCmHdEgkNr
         nj6Mre1Kahzre/rgp0jklpvz/EAvIm12U3Dk3mndnsyJOmeJSFcrSYyUovzlFmHQfDB1
         WcMv1+KFvZdkIM+qBLE5uM3UBl6H+uMY9ZiBsC1IGIUTeL/NSJwe2Kh2yb1abGQUxrnH
         ofPg==
X-Forwarded-Encrypted: i=1; AJvYcCWDqzySTWtHsE6+arNi1xvSlsEaIzwpSydw75Md6uuyuoUaYHIeTvRgVKmk45+EeSc+b4hFNgdkgS/ASKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfn9GtAWO7f6kif5/cGk9AxPoemZV4YuzdJ3vhlPNysoqglsVX
	8QoP8K8OkYCg6XzrJ6IkxvVuMt2ReHCP3rKdllc+LTOaKYhWbxyD
X-Google-Smtp-Source: AGHT+IGQquk2jTrGNJ5jXz0fryYGBvUsxfpAEhOJeups2teTSbS1S/xyCYdIHw9wkzaCLdiTIX7+lQ==
X-Received: by 2002:a17:907:e28f:b0:a8d:2ab2:c99e with SMTP id a640c23a62f3a-a9029730615mr1184068266b.55.1726382458576;
        Sat, 14 Sep 2024 23:40:58 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:40:58 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 02/17] staging: rtl8723bs: Remove unused function rtw_search_max_mac_id
Date: Sun, 15 Sep 2024 08:38:16 +0200
Message-ID: <34c5f2ef44641c5151dde12b161d3f0aa963de5c.1726339782.git.philipp.g.hortmann@gmail.com>
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

Remove unused function rtw_search_max_mac_id.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 18 ------------------
 .../staging/rtl8723bs/include/rtw_mlme_ext.h   |  1 -
 2 files changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 2fb14f4ff1af..cd62ea47577c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1822,21 +1822,3 @@ void rtw_release_macid(struct adapter *padapter, struct sta_info *psta)
 	}
 	spin_unlock_bh(&pdvobj->lock);
 }
-
-/* For 8188E RA */
-u8 rtw_search_max_mac_id(struct adapter *padapter)
-{
-	u8 max_mac_id = 0;
-	struct dvobj_priv *pdvobj = adapter_to_dvobj(padapter);
-	int i;
-
-	spin_lock_bh(&pdvobj->lock);
-	for (i = (NUM_STA-1); i >= 0 ; i--) {
-		if (pdvobj->macid[i] == true)
-			break;
-	}
-	max_mac_id = i;
-	spin_unlock_bh(&pdvobj->lock);
-
-	return max_mac_id;
-}
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 8315399b64fd..82709ffc7bad 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -528,7 +528,6 @@ void rtw_camid_free(struct adapter *adapter, u8 cam_id);
 
 extern void rtw_alloc_macid(struct adapter *padapter, struct sta_info *psta);
 extern void rtw_release_macid(struct adapter *padapter, struct sta_info *psta);
-extern u8 rtw_search_max_mac_id(struct adapter *padapter);
 
 void report_join_res(struct adapter *padapter, int res);
 void report_survey_event(struct adapter *padapter, union recv_frame *precv_frame);
-- 
2.43.0


