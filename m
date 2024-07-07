Return-Path: <linux-kernel+bounces-243493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 480799296DF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EB0281594
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB19D2E5;
	Sun,  7 Jul 2024 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cte4GR/p"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF49311723
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335146; cv=none; b=spl6GkmbBfalhUdkWWaLngmHjoKSwiI6GEJV1sL3Ln6YqKsFbqXFqXKwXpzK4rY4bVqS2RI3UU6bqvBQ8+qoMlrxtu/hSDlsNlgczPNaqWB5QPMZy5KpdbxJexFAX8jeoF1R2RwDt1bc6D+BGTD13p9v7JU8Xqgk40C6/JW0fE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335146; c=relaxed/simple;
	bh=M0unsPZXof9195t12LQdbKVCLjsDSZCV25BC5Zi3GPg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Izp5rrZOgGitIPDM6HcenNumKabHgcjHWEe5YYsmwya6K/wtmFtZnCHbglZGMayZjgMfTluJ9brtUC+YFWy8jqmAcemUgpIvDxTWQ8Pj8n92za4l/RCJImrxmGMdtiknNdXSJzM35avJXhha3MgWRmilJnnT1YGaktdaHLABOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cte4GR/p; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58cdd58c545so477452a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720335143; x=1720939943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTIs2Xhc94fJOZitmW0LJjQdfwpTiVJtqyfruFQJ5rs=;
        b=Cte4GR/pKyAM3jd8tkmKOMhhTO1T7UBzBzUv5GYgHNc79GbMS0yxhR7c1AaXsJnUmo
         wAgKZFcua1Dtq/fE2suEX6mB6X51wmMwPPgiawCxxYCFwljj4QugIYSRwXxot5keJ8fV
         5b8coo04iJV0NyQDqKVnPjlJHZhx9g36+Rwmd32gIj4tZ48mLW25XYk7wNHinim+MB9S
         hzoq5eiQLfZWjrmTH0MAjzCwKKsu8R1ZW2RX1c+Tnbntrw1rRRqs2/XlroJrrvcyQ6en
         Kx/W3Q455ml/uei6c6a1QNiCUlWqX6tpEfKItzeh/7lpfpME1kQUtQ86XeCuFC440tzZ
         MTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335143; x=1720939943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTIs2Xhc94fJOZitmW0LJjQdfwpTiVJtqyfruFQJ5rs=;
        b=TUdzxCQYg+AkHC+1/QRmlnza/h45syE62ikEJamUrLn3q40bWquse/FnCCgVg71K+H
         Rv4KF+v5tqBB7Mhclu8Oi66r06m2xjb/fJ/52s9poGLj/KLEnlZxpCFq0l3cVRU/o8xm
         YJKnRtKnicXGeHNq+sDlBFpHMb+ZiLU45+lcd4MDZM94G22RFYRhJ7vovF24D+x0DsnN
         Ley7cA3dyhnhvTA/v5yJXnkPc87hxwMrsJ19jctv6lVXM96cxc6SB03xhJBQEohcsjVn
         /yyMYyw49WpLeM1QPhtt9dO4btJxIeumzSfOSjs5jgzL8Hycpt9MfL755g2JTTeN+nTH
         RJtA==
X-Forwarded-Encrypted: i=1; AJvYcCXDfbtyAjD1SdLH9UhiyXg5xyoepqpvzZBzQSLCp5td5Jqu4lwSljCj4uHU43SV47qxnGMTAshEJD1+JNqDfZqvFKWDoRJBResj1Rud
X-Gm-Message-State: AOJu0YzOKxkmJGKp1TACpuTjU0abPCz+NHVytzupjEiTj3NJmR2TQqvn
	RZR5sdZf9pClZH6WlK1IHa5/517H4pZu7w5CS5r5rMH2FH9Y1eYaSAfj1A==
X-Google-Smtp-Source: AGHT+IHXUgOcer0IXuTSnfsKDy/tVvQGWERqsJTTQAzfKpkR620KfmWWosIl8JqwXq/40l/fd7pMXw==
X-Received: by 2002:a17:906:7051:b0:a70:4217:5c8b with SMTP id a640c23a62f3a-a77b9de0734mr481514966b.0.1720335143186;
        Sat, 06 Jul 2024 23:52:23 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77c978763bsm207772066b.109.2024.07.06.23.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:52:21 -0700 (PDT)
Date: Sun, 7 Jul 2024 08:52:20 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] staging: rtl8723bs: Remove unused macros in rtw_ht.h
Message-ID: <7bab6def02a4a89c481d20547375d894d538458a.1720245061.git.philipp.g.hortmann@gmail.com>
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
 drivers/staging/rtl8723bs/include/rtw_ht.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_ht.h b/drivers/staging/rtl8723bs/include/rtw_ht.h
index 1527d8be2d7a..54fadb92334c 100644
--- a/drivers/staging/rtl8723bs/include/rtw_ht.h
+++ b/drivers/staging/rtl8723bs/include/rtw_ht.h
@@ -63,43 +63,21 @@ enum {
 
 #define	LDPC_HT_ENABLE_RX			BIT0
 #define	LDPC_HT_ENABLE_TX			BIT1
-#define	LDPC_HT_TEST_TX_ENABLE		BIT2
 #define	LDPC_HT_CAP_TX				BIT3
 
 #define	STBC_HT_ENABLE_RX			BIT0
 #define	STBC_HT_ENABLE_TX			BIT1
-#define	STBC_HT_TEST_TX_ENABLE		BIT2
 #define	STBC_HT_CAP_TX				BIT3
 
 #define	BEAMFORMING_HT_BEAMFORMER_ENABLE	BIT0	/*  Declare our NIC supports beamformer */
 #define	BEAMFORMING_HT_BEAMFORMEE_ENABLE	BIT1	/*  Declare our NIC supports beamformee */
-#define	BEAMFORMING_HT_BEAMFORMER_TEST		BIT2	/*  Transmiting Beamforming no matter the target supports it or not */
-
-/*  */
-/*  The HT Control field */
-/*  */
-#define SET_HT_CTRL_CSI_STEERING(_pEleStart, _val)					SET_BITS_TO_LE_1BYTE((_pEleStart)+2, 6, 2, _val)
-#define SET_HT_CTRL_NDP_ANNOUNCEMENT(_pEleStart, _val)			SET_BITS_TO_LE_1BYTE((_pEleStart)+3, 0, 1, _val)
-#define GET_HT_CTRL_NDP_ANNOUNCEMENT(_pEleStart)					LE_BITS_TO_1BYTE((_pEleStart)+3, 0, 1)
 
 /*  20/40 BSS Coexist */
 #define SET_EXT_CAPABILITY_ELE_BSS_COEXIST(_pEleStart, _val)			SET_BITS_TO_LE_1BYTE((_pEleStart), 0, 1, _val)
-#define GET_EXT_CAPABILITY_ELE_BSS_COEXIST(_pEleStart)				LE_BITS_TO_1BYTE((_pEleStart), 0, 1)
-
 
 #define GET_HT_CAPABILITY_ELE_LDPC_CAP(_pEleStart)				LE_BITS_TO_1BYTE(_pEleStart, 0, 1)
 #define GET_HT_CAPABILITY_ELE_TX_STBC(_pEleStart)					LE_BITS_TO_1BYTE(_pEleStart, 7, 1)
 
 #define GET_HT_CAPABILITY_ELE_RX_STBC(_pEleStart)					LE_BITS_TO_1BYTE((_pEleStart)+1, 0, 2)
 
-/* TXBF Capabilities */
-#define SET_HT_CAP_TXBF_RECEIVE_NDP_CAP(_pEleStart, _val)					SET_BITS_TO_LE_4BYTE(((u8 *)(_pEleStart))+21, 3, 1, ((u8)_val))
-#define SET_HT_CAP_TXBF_TRANSMIT_NDP_CAP(_pEleStart, _val)				SET_BITS_TO_LE_4BYTE(((u8 *)(_pEleStart))+21, 4, 1, ((u8)_val))
-#define SET_HT_CAP_TXBF_EXPLICIT_COMP_STEERING_CAP(_pEleStart, _val)		SET_BITS_TO_LE_4BYTE(((u8 *)(_pEleStart))+21, 10, 1, ((u8)_val))
-#define SET_HT_CAP_TXBF_EXPLICIT_COMP_FEEDBACK_CAP(_pEleStart, _val)		SET_BITS_TO_LE_4BYTE(((u8 *)(_pEleStart))+21, 15, 2, ((u8)_val))
-#define SET_HT_CAP_TXBF_COMP_STEERING_NUM_ANTENNAS(_pEleStart, _val)	SET_BITS_TO_LE_4BYTE(((u8 *)(_pEleStart))+21, 23, 2, ((u8)_val))
-
-#define GET_HT_CAP_TXBF_EXPLICIT_COMP_STEERING_CAP(_pEleStart)			LE_BITS_TO_4BYTE((_pEleStart)+21, 10, 1)
-#define GET_HT_CAP_TXBF_EXPLICIT_COMP_FEEDBACK_CAP(_pEleStart)			LE_BITS_TO_4BYTE((_pEleStart)+21, 15, 2)
-
 #endif	/* _RTL871X_HT_H_ */
-- 
2.45.2


