Return-Path: <linux-kernel+bounces-226367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6C5913D79
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4E5B217E3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F0A18509B;
	Sun, 23 Jun 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUNVVhsq"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00A1849C0
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165457; cv=none; b=nuv4AT/rVfjzCiwxcfLYKZZ80uxnptUdfzOa/Zd1uozhMrO+W8pRWbkxnBy7Be3YPOvmWjOgjsQSqt/ldtNxSJw19R8ktk2dUTPBftxj5tU1boMWr1wFyAI65FTSW5Y2Kj0woTakio8fQ0tpKx9s6q6hleuWqqP+sVya4Ia7UoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165457; c=relaxed/simple;
	bh=JNCF8MfXklHl4C6j05doES2fTMNQuKfQjswvfgk6bv8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpXLYVgxdDCsqYOrV529a2mSdWJgT1JDS3a5Bg89yeM8anuVX3d1u0bEBJtSGDgussv/gcDatqyLmCTg0ZF6eOf9OeBUpZk4rstTL+mn/52b8QooW+LfWb7uYAj/lokp2xi7+GmubgdEIjW1AQpImR48726DqHaUuiNqM7p14r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUNVVhsq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57cc310bca3so493224a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165454; x=1719770254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtAQurWfvbD0wQVfBx68aLTWozMUJQpP//xDOdNrogo=;
        b=OUNVVhsqipxrdZ/rz44+L+zAIVeZrTjRh66CocTjPZiJXZ0NcAIVRRv/ejz0V7r4NJ
         /+1m7DKyTE5uSDbrywUKQ+qpEHrzn5er92pu0+CSvAmPJE+ivgri5EYBJApEBKqAZhTQ
         1teyJunExAEmD0/V2ABs74MR1sWu2ry9lle0NDik6fUxbdlZczDA5LuVfh4qEL752t9f
         wn4RvPZjg3+HOTueKkR2l1G8VL7qIXxwIP/RDuzcN0UE+oS4kDmDsv4JzJhgLxtTaZ2d
         4AN80s5egfOhpIEssOEr4ElpXOi5Bw9dOPWzxJkeJRp0BDDSz6gLjOKeyHgkiIAaEv7n
         EqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165454; x=1719770254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtAQurWfvbD0wQVfBx68aLTWozMUJQpP//xDOdNrogo=;
        b=q2PrxZCuRurWQSMqrB5NAzQWDGJeVwBOSHhtKIdDd7eNadAEDXvlEpouWY6fQxDjEv
         S8TMAOmxQ+aDdvi6p0Z2NIpm8dY3KZYY2XN528/x+Z7T27yG5sieQEWAPhLriBnmlJxu
         NRfUTr8NfJ79UVKed7AkbCBjeKDQIQ9as4EBKFpVplYazQLQ6QZdCAmBQR7/PbxEx2Pu
         D+NEAcygzpRapwLKTniPtmI2UF3fpkAEGr45gnjVtORtsPX8kaMDYPHiHpmjuA+SOwfa
         12w0BlHLm8EicQyLyZZCps36CVSLYM0fOMMQdRv58QuIBVuLrphxpEBdYW/t8Oa3U1Pu
         KdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX622PlwRJ13spWL6F/gpn83mG3h4bjjg+X3FIbvYLGAZ1tF9wq9woGvafXejQebU7CVD96EfDAyHT+3sXyY4GD8cVwy6srH7srdkN8
X-Gm-Message-State: AOJu0YwooGEFI0wqzexQac1VKs5ynYaQ31sYDUPiBgRFWKaas2owjsyP
	3TKHKvsuIAVwNrWodrjf1FDZS+kQv4d+MA8Hrkfr/GcbKTL4gQnw
X-Google-Smtp-Source: AGHT+IFG1nYe6wO44yn+4v5OrjGlXFGCRgVcdrYkFwuVhWdHT24uMOdtejZu9+RRm5vYAcAbBQj+sQ==
X-Received: by 2002:a50:c346:0:b0:57d:1d4:9afc with SMTP id 4fb4d7f45d1cf-57d43a6cff5mr1878689a12.1.1719165453568;
        Sun, 23 Jun 2024 10:57:33 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d305616f5sm3741653a12.80.2024.06.23.10.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:57:33 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:57:31 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] staging: rtl8723bs: Remove unused macros in sta_info.h
Message-ID: <912fba119b3041c396bcb2ddf22219fa0025ee42.1719155208.git.philipp.g.hortmann@gmail.com>
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
 drivers/staging/rtl8723bs/include/sta_info.h | 44 --------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/sta_info.h b/drivers/staging/rtl8723bs/include/sta_info.h
index 1ea3fe22b99a..b3535fed3de7 100644
--- a/drivers/staging/rtl8723bs/include/sta_info.h
+++ b/drivers/staging/rtl8723bs/include/sta_info.h
@@ -222,53 +222,24 @@ struct sta_info {
 	+ sta->sta_stats.rx_ctrl_pkts \
 	+ sta->sta_stats.rx_data_pkts)
 
-#define sta_last_rx_pkts(sta) \
-	(sta->sta_stats.last_rx_mgnt_pkts \
-	+ sta->sta_stats.last_rx_ctrl_pkts \
-	+ sta->sta_stats.last_rx_data_pkts)
-
 #define sta_rx_data_pkts(sta) \
 	(sta->sta_stats.rx_data_pkts)
 
 #define sta_last_rx_data_pkts(sta) \
 	(sta->sta_stats.last_rx_data_pkts)
 
-#define sta_rx_mgnt_pkts(sta) \
-	(sta->sta_stats.rx_mgnt_pkts)
-
-#define sta_last_rx_mgnt_pkts(sta) \
-	(sta->sta_stats.last_rx_mgnt_pkts)
-
 #define sta_rx_beacon_pkts(sta) \
 	(sta->sta_stats.rx_beacon_pkts)
 
 #define sta_last_rx_beacon_pkts(sta) \
 	(sta->sta_stats.last_rx_beacon_pkts)
 
-#define sta_rx_probereq_pkts(sta) \
-	(sta->sta_stats.rx_probereq_pkts)
-
-#define sta_last_rx_probereq_pkts(sta) \
-	(sta->sta_stats.last_rx_probereq_pkts)
-
 #define sta_rx_probersp_pkts(sta) \
 	(sta->sta_stats.rx_probersp_pkts)
 
 #define sta_last_rx_probersp_pkts(sta) \
 	(sta->sta_stats.last_rx_probersp_pkts)
 
-#define sta_rx_probersp_bm_pkts(sta) \
-	(sta->sta_stats.rx_probersp_bm_pkts)
-
-#define sta_last_rx_probersp_bm_pkts(sta) \
-	(sta->sta_stats.last_rx_probersp_bm_pkts)
-
-#define sta_rx_probersp_uo_pkts(sta) \
-	(sta->sta_stats.rx_probersp_uo_pkts)
-
-#define sta_last_rx_probersp_uo_pkts(sta) \
-	(sta->sta_stats.last_rx_probersp_uo_pkts)
-
 #define sta_update_last_rx_pkts(sta) \
 	do { \
 		sta->sta_stats.last_rx_mgnt_pkts = sta->sta_stats.rx_mgnt_pkts; \
@@ -281,21 +252,6 @@ struct sta_info {
 		sta->sta_stats.last_rx_data_pkts = sta->sta_stats.rx_data_pkts; \
 	} while (0)
 
-#define STA_RX_PKTS_ARG(sta) \
-	sta->sta_stats.rx_mgnt_pkts \
-	, sta->sta_stats.rx_ctrl_pkts \
-	, sta->sta_stats.rx_data_pkts
-
-#define STA_LAST_RX_PKTS_ARG(sta) \
-	sta->sta_stats.last_rx_mgnt_pkts \
-	, sta->sta_stats.last_rx_ctrl_pkts \
-	, sta->sta_stats.last_rx_data_pkts
-
-#define STA_RX_PKTS_DIFF_ARG(sta) \
-	sta->sta_stats.rx_mgnt_pkts - sta->sta_stats.last_rx_mgnt_pkts \
-	, sta->sta_stats.rx_ctrl_pkts - sta->sta_stats.last_rx_ctrl_pkts \
-	, sta->sta_stats.rx_data_pkts - sta->sta_stats.last_rx_data_pkts
-
 #define STA_PKTS_FMT "(m:%llu, c:%llu, d:%llu)"
 
 struct	sta_priv {
-- 
2.45.2


