Return-Path: <linux-kernel+bounces-322455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8EE972925
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0EAB248BF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C59C17BEBD;
	Tue, 10 Sep 2024 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfL8dqPB"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A044317B50A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947882; cv=none; b=OziZOJS0Prjuko47P8ypIvOl6USI8jFh5bgdzyxu8tsrWFpck/MiLxsfBlhvBn0Z861IcadmK61jTyknEoisJ5DEkmV3i+qmVzP3U3CJYZvpNKg1zzxNG2MyOAFm438QiKTIoffF91P+kLdrNucA/cQWyG6SIDBM7WkF7t87/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947882; c=relaxed/simple;
	bh=GjUGopGW/wE1aOAPUuMneNgzgbYxqvxGw0OD/j/5yFc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0/V2DTFI8iIquaShf61v5h5Xf6/RSgcwPVd6OHLNMW1ej0v2Gxgi+4eB0cRwXsg28pUDMsm2bMdunnR/vztzbxDkem/F2sl/z3b6n7wkCR2CK+R3C0xFCUB3oTyV31xhBafZ23gt4oD6E6RNBYCg1mBSVezyuI87+SHV2iDV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfL8dqPB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c3cdba33b0so5419743a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725947878; x=1726552678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cx3ykix+TuB8uuNKcx/1J8Hn0bQfcisX/xQMqnMFlU=;
        b=kfL8dqPBsWgSxchYt3+YDhFaO384NpO0mAp6UG1lPXFj7Pk+PugYFuHveGEYR0pUH4
         IHiXrEg/ZPfSDsTmrnT5RCQILc+23PVisf90/UfSHBmHjq27cUeISuaOtq6vJzj5eTPg
         0XABJnvStXfTdFWSSFUnUvfFgELXFzjSssq4hxpzTYL4BcWENJqsA/xhpxXefdWuMcPt
         jDm7x9wuc1z+7Oqs+jPpVTqNT1ENw0gYHdMp0/+cgSOVNMPgmntY0MuhSx/wJwVu7cPt
         /CwcCnbQOQe135QgZIwMJ1WbLqSRiV/IMyfa3WIvrUxUYAx+YQOSbm7q1wzomJQ+HPRd
         Vq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725947878; x=1726552678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cx3ykix+TuB8uuNKcx/1J8Hn0bQfcisX/xQMqnMFlU=;
        b=Oi3oozvpP7uhLe4EtLpn2NwHBaaIXGPma2H1bojaaJcCqJDmUmSAP7/2OUGOAfLNHu
         ky/ooBxYZnTxVXvvn2K0E3HmJ4tPWiztjUPPLPhhKRYWURwTwLl4FJ2Kd/WkIkTWCaBx
         o5W5n7ENpYtvaT/J8fYoOKfpQLfX7TnQKhX1BLW9UysMeBHWLnuMcVNGdTLEKPSWNoqX
         iLJfsACS2+a48AfC4AxgZFqm031eUp2SRxTnj6fCGIvekGF40UAEXAiarXjiypUOGIc2
         wST8LNAYBpQ0n9KLCNRSoXRThSlnNGFau9CjbjLcpu9nkrTTP01fBgfj2/OsdPpd/vHG
         PQ1w==
X-Forwarded-Encrypted: i=1; AJvYcCUCnE0rMVrNFGPHptIEcuOMW54xCXYZv/Gy6DehmezQqAKNLiA4lyCYiHN1uGUDwB2inKat8kych+Fd+0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCQyju/chCjWfj/09PZgC8Q/DDFUkjtESKXg90KlBjVeESNii
	LMpGfthOogZxD/M+UwfLt5548kdVBiSVMW3Owlruu+dZ4m5jhR9e
X-Google-Smtp-Source: AGHT+IEwxBhh5fLi6FkPQok12Ucj1eFyyJ4CcVOGrJhWFjQI93n4H+TEVIWzrwRzxYcZO7lzaW7few==
X-Received: by 2002:a05:6402:5203:b0:5c2:6e51:9d22 with SMTP id 4fb4d7f45d1cf-5c3dc7bd575mr8923006a12.25.1725947877907;
        Mon, 09 Sep 2024 22:57:57 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f2a8598b80c2d4e9a813f29.dip0.t-ipconnect.de. [2003:c7:8f2a:8598:b80c:2d4e:9a81:3f29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd41ba7sm3832400a12.4.2024.09.09.22.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:57:57 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:57:56 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] staging: rtl8723bs: Remove unused function rtw_ch2freq
Message-ID: <53a8ee320803ae3efe22b648f2a4555482efaf46.1725826273.git.philipp.g.hortmann@gmail.com>
References: <cover.1725826273.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725826273.git.philipp.g.hortmann@gmail.com>

Remove unused function rtw_ch2freq with array ch_freq_map and comments.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c   |  3 ---
 drivers/staging/rtl8723bs/core/rtw_rf.c    | 25 ----------------------
 drivers/staging/rtl8723bs/include/rtw_rf.h |  2 --
 3 files changed, 30 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 6c49bfa00578..84ce7307d8f3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1883,9 +1883,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		/*  copy pdev_network information to	pmlmepriv->cur_network */
 		memcpy(&tgt_network->network, pnetwork, (get_wlan_bssid_ex_sz(pnetwork)));
 
-		/*  reset ds_config */
-		/* tgt_network->network.configuration.ds_config = (u32)rtw_ch2freq(pnetwork->configuration.ds_config); */
-
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 
 		spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
diff --git a/drivers/staging/rtl8723bs/core/rtw_rf.c b/drivers/staging/rtl8723bs/core/rtw_rf.c
index 4f120c894998..2aca45de298e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_rf.c
+++ b/drivers/staging/rtl8723bs/core/rtw_rf.c
@@ -7,28 +7,3 @@
 
 #include <drv_types.h>
 #include <linux/kernel.h>
-
-static const u32 ch_freq_map[] = {
-	2412,
-	2417,
-	2422,
-	2427,
-	2432,
-	2437,
-	2442,
-	2447,
-	2452,
-	2457,
-	2462,
-	2467,
-	2472,
-	2484
-};
-
-u32 rtw_ch2freq(u32 channel)
-{
-	if (channel == 0 || channel > ARRAY_SIZE(ch_freq_map))
-		return 2412;
-
-	return ch_freq_map[channel - 1];
-}
diff --git a/drivers/staging/rtl8723bs/include/rtw_rf.h b/drivers/staging/rtl8723bs/include/rtw_rf.h
index 718275ee4500..9f98b3f5a2e3 100644
--- a/drivers/staging/rtl8723bs/include/rtw_rf.h
+++ b/drivers/staging/rtl8723bs/include/rtw_rf.h
@@ -97,6 +97,4 @@ enum {
 	HT_DATA_SC_20_LOWER_OF_40MHZ = 2,
 };
 
-u32 rtw_ch2freq(u32 ch);
-
 #endif /* _RTL8711_RF_H_ */
-- 
2.46.0


