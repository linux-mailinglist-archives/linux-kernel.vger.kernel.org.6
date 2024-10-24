Return-Path: <linux-kernel+bounces-380757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D339AF59C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA99282CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C30C2185A5;
	Thu, 24 Oct 2024 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgIpcH//"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DB816BE01
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729810521; cv=none; b=BMpix8yWyFhIGMlVXptWZHeYRQdtiRTOHL57WUfHGzYSbb8BOCBCzt7BiN1QUGsokCeVCHl1wMJ1lMI/07y29XTAZM74GkXW2bNGA/WhDLVoBfcwXZR0jI7tnMWuPx/KuIkxEQprF7yb4ISupOJE2fkpwmJ9LaySaqVV3ktxazs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729810521; c=relaxed/simple;
	bh=2t0NQJ4i0sajNkNmezauDEuozrVUAiF615VNOMCaVno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8vLkKJsoj8MUWJLLBuB7I6MWjMm8vp8gNrMp9D+ZJ8D2q32EuWzhNZC/2EIJHg2bkSmb+XkTVrDlIYLzn90UgeXhp2RzOT3dNSXnLFKnn8IRxr81hpf64+MxwTfQQafpl2orXjRX/4uSMQsMvFujP0Q9kCFCa1hGjhiw8m//ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgIpcH//; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so948456a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729810519; x=1730415319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BZ5yIebvbjCx11gbUEaKqEHQYCWzk/WEOkgc2gej4o=;
        b=NgIpcH//Ov5qzh/WSPizc/1dV2yYw+6Ou6nOumzTRKGFcvcWajfKBkk/M1WQ1SGhFD
         /PI0wCmjU8xyB3k8338/qMHyM1zY2vfi+90+Gu8OyhZnraqQ3pvp0Wv5gibqqplgq8jd
         Hoi2LQZUNktTNsp7/DOIErPmrBDLhC/kt9SixsgOTakC+7ATdOdpmk9/Iego8b2eK5VL
         6T4GqPEFKz0G3U+MbwNCa4G6fr6h4eTyLeBgwDjKsFhaJv98oPjxACHYALvEk60niAia
         2LmziOdOEt5HEinlR/5VaTp0vwa/WhchSq88goz8UyxHV7AKSwfbWByAH9+mCKjtFfL9
         debA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729810519; x=1730415319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BZ5yIebvbjCx11gbUEaKqEHQYCWzk/WEOkgc2gej4o=;
        b=t3xHFO4OkPLXfm91kE29/yep3rilBosEJA+n02LpoY+uYsnxwFLOW9zhqPPgvv7zq5
         ZezX6w7EV4R06xRsuYEMLNaRJwjwKCb7ZL6Ruw8YDDKHFNg4ehDkrQpiXAI+KCdkwYqk
         +P5VpcSaHNuX5mDnQd1aBGdZDHdmhoXqKPXBu0wKdkmYpYd8skASEU0d8H4Y//1sk+FN
         /0ltBY7UrqW9Yj5k4h64V6Qpo6PQ0KQH8SopEfOTVl4o4jTF70Ysof2Wo7bZ8Ubc5UV8
         hJxsjSSL+0cbfqCfQpjEgoFq8soBItrUk5BK/+HGUECEiUbFX34CGokjDwz3wtuMpup4
         DqVg==
X-Forwarded-Encrypted: i=1; AJvYcCXP5dQIjhFuvbz6LFedm3XAoWdPBYItp6eJSgRex9SDeHU3LEpHBaBvKnAq6ShzyZbiqrzvSmwviZkR8ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34WthcCq67ZMT4EJ39v7bLq+KY6YPgCUjJ5zpQHNaObOmLifz
	f7dzUrlvQ+07T4k68sO8cd5LuwaRZfvk6w63SYWSGJ/qoeitIIzh
X-Google-Smtp-Source: AGHT+IG1CnmN3xWtfp10BtAmupCLlIyz4ArIS6I2qnftlZ9Ec0JzjDaUHnRwh+56tHnosG0rMeW9oQ==
X-Received: by 2002:a05:6a20:d80c:b0:1d9:2723:64a6 with SMTP id adf61e73a8af0-1d978b2c40amr8713015637.21.1729810518754;
        Thu, 24 Oct 2024 15:55:18 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:bf51:a58d:54e:ca72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabbca78sm9170227a12.58.2024.10.24.15.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 15:55:18 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: dan.carpenter@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	philipp.g.hortmann@gmail.com,
	rodrigo.gobbi.7@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: staging: rtl8723bs: change remaining printk to proper api
Date: Thu, 24 Oct 2024 19:55:12 -0300
Message-Id: <20241024225512.7464-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f61d8272-4af3-40d6-a333-e7731c3fc5ae@stanley.mountain>
References: <f61d8272-4af3-40d6-a333-e7731c3fc5ae@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

First, tks for the answer, Dan.

> little broken with -DDBG_RX_SIGNAL_DISPLAY_RAW_DATA, maybe we can 
> fix that in a next patch. 
> How is it broken?

make -j<> ./drivers/staging/rtl8723bs/r8723bs.ko EXTRA_CFLAGS="-DDBG_RX_SIGNAL_DISPLAY_RAW_DATA"

drivers/staging/rtl8723bs/hal/hal_com.c: In function ‘rtw_store_phy_info’:
drivers/staging/rtl8723bs/hal/hal_com.c:927:43: error: ‘PODM_PHY_INFO_T’ undeclared (first use in this function)
  927 |         struct odm_phy_info *pPhyInfo  = (PODM_PHY_INFO_T)(&pattrib->phy_info);
      |                                           ^~~~~~~~~~~~~~~
drivers/staging/rtl8723bs/hal/hal_com.c:927:43: note: each undeclared identifier is reported only once for each function it appears in
drivers/staging/rtl8723bs/hal/hal_com.c:940:73: error: ‘struct odm_phy_info’ has no member named ‘RxPwr’; did you mean ‘rx_pwr’?
  940 |                         psample_pkt_rssi->ofdm_pwr[rf_path] = pPhyInfo->RxPwr[rf_path];
      |                                                                         ^~~~~
      |                                                                         rx_pwr
drivers/staging/rtl8723bs/hal/hal_com.c:941:71: error: ‘struct odm_phy_info’ has no member named ‘RxSNR’
  941 |                         psample_pkt_rssi->ofdm_snr[rf_path] = pPhyInfo->RxSNR[rf_path];

Actually it's not exaclty in the same line of pr_debug/netdev_dbg replacement. Do you think
we can do the replacement at:

> +			pr_debug(", rx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",...

regardless of this build errors? I mean, fixing it here in this patch
would not be related to the purpose of this simple patch.

> Just delete this line.
Ok.

> -		printk(KERN_CRIT "%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
> +		pr_crit("%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
>                ^^^^^^^?

Originally, I didn't replace this because at dvobj of sdio_alloc_irq(struct dvobj_priv *dvobj)  
there are two adapter fields:

struct dvobj_priv {
	struct adapter *if1; /* PRIMARY_ADAPTER */
...
	struct adapter *padapters;
...
}

Checking the "counter part" function of sdio_alloc_irq(), the sdio_free_irq() (which is not used), 
the if1 (primary) is used for debug purpose:

netdev_err(dvobj->if1->pnetdev...

And checking the initialization path, if1 should be ok at this point.
But since I can't test this, do you suggest to replace anyway?

Tks and regards.

