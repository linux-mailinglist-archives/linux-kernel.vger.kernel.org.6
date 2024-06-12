Return-Path: <linux-kernel+bounces-210877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA93E904997
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380D9282669
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09E38287E;
	Wed, 12 Jun 2024 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="HFDlC0So"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22838002E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162571; cv=none; b=Brc++oEqpj4NnVx2Q+wAZ5YcE8zPwJk+dq8jiUr5te6UBdKijn7jjyRUeXcQnfHtan6GI950PXjG+raykxeQQYM5ZCxoAWlDrEaendb+VlU9E+gZ+spPfLZKLPSPO23eUGKTGtAvjDmwwJ6+C9ic/pLfeezCv/su8xvCaxQjlF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162571; c=relaxed/simple;
	bh=mipjevFOZ2dmGJOw6Kz0lN3TbrBvmglYVOnhL96glEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+p/RZwVOweZbWSYcsrWd6CzgYPQLLhKeIChcFwGDKwR5GlpVGZlK95SHCO48ugiLkV3TpxqNyFvT/J+/43qeNyJ5rYdv7tcMJ+I7iXkOZafWiehxILOQEuCRyfJ8VgLx8LmMNaBL6TdwyvF7Hqo43vqRePAdCFAZHYc9x8RmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=HFDlC0So; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b96a781b63so2368133eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162569; x=1718767369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mN2Oo5HuRfYFaYNQRaLC/1WniMLC8Zh3ZlO0PShWS0=;
        b=HFDlC0So1ksFFS8RsrCHvLX5DGs9ivjD/cUw6iBEizr4nXOXcPy+ZMa2C9uTBlfw7w
         4F3rBf94uwfrDONYkEe5u4AKMl1qoen3ROgZnLIebSYQWRmD6kTe+SdOrt/dqTyWaVKh
         9fFbHoCXk0Tnvi5In5lZqeZpj3HA7ZWaB8l/9NcJOtf4l+dBTAcxutVBCbf9yHxnSII4
         mtkkH2Ucs2HpCqfc962SIifuE8e3IXVHHuayYfEEHm8ij18Qv4dLh96i+xS56bnDMIRB
         dfdvrqxv50kx/gM+FY168V3IUY8ZWv+34B8svCZl6JUIhYOa058p0zznneRCYf8X/VEH
         pdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162569; x=1718767369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mN2Oo5HuRfYFaYNQRaLC/1WniMLC8Zh3ZlO0PShWS0=;
        b=Miq/Fu+xAtockiSjUv4B5ALkYpKzh3ChpKK66U/1UqBcTGWQWsxzYX0rjjeBNgBC2l
         2kTKvTquyeWnEkbD1PRmHblQr4Q8Gsd0UwHvcaW+c92Q9jw5tx3DklCIviWhKV4p8MgW
         KwI6qiDJoYHqYJmun1QZsOuIw/oTrFimSsraMnaL9jdO4+iD6wumWpp+DbRzTHE7MBpm
         Hgi+Y6CJ6wcY65QYdO4u+8z9fo+OI6kaHrK/NXiycfnmY/3s/QPCWvLKkwS6gNBmIH3T
         6TqRuCWVpji8FFQK5yflTNQej+7bZi+qDYqWrwS/7kxN8DLsLRSsd5wxPHW/pQBpE+C6
         Fyhg==
X-Forwarded-Encrypted: i=1; AJvYcCXlwziZNkd/rz6lJ/7F9ZWK8WmCWqbeRcl9P8o6ZZlnDFykXXBig7ZLoaXgr8yxlyrjpyqxBWALqBwoVaL0rjUyZKo/Ap+UM0hwPOV2
X-Gm-Message-State: AOJu0YzNPI9XFgxB/6VAIc0wiD5jzZW5iog8Jh4qURdIRAuEecDMWeNn
	k6qWMrA2kR2NHloXT8rtpP7amm+Js5k/pZQYBiVIECwIWi33ww54es6nll9fwpsWN8Hs+fBB3ip
	y9os=
X-Google-Smtp-Source: AGHT+IHHrQEiUTsBKjWQW8t2x2dF0rfY+q0Yk+bIn3X2BUvy8WXZn5NIHh+HdzxMfQcp2PFaUBVHlA==
X-Received: by 2002:a05:6358:9106:b0:19f:4d5a:c688 with SMTP id e5c5f4694b2df-19f69d2ca8fmr72735855d.15.1718162568669;
        Tue, 11 Jun 2024 20:22:48 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:48 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 18/24] Staging: rtl8192e: Rename function rtllib_query_HTCapShortGI
Date: Tue, 11 Jun 2024 20:22:24 -0700
Message-Id: <20240612032230.9738-19-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240612032230.9738-1-tdavies@darkphysics.net>
References: <20240612032230.9738-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function rtllib_query_HTCapShortGI to
rtllib_query_ht_cap_short_gi to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtllib_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 93b9f0609428..6a979151d1d0 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -330,7 +330,7 @@ static void rtllib_query_short_preamble_mode(struct rtllib_device *ieee,
 		tcb_desc->bUseShortPreamble = true;
 }
 
-static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
+static void rtllib_query_ht_cap_short_gi(struct rtllib_device *ieee,
 				      struct cb_desc *tcb_desc)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
@@ -871,7 +871,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			rtllib_query_short_preamble_mode(ieee, tcb_desc);
 			rtllib_tx_query_agg_cap(ieee, txb->fragments[0],
 						tcb_desc);
-			rtllib_query_HTCapShortGI(ieee, tcb_desc);
+			rtllib_query_ht_cap_short_gi(ieee, tcb_desc);
 			rtllib_query_bandwidth_mode(ieee, tcb_desc);
 			rtllib_query_protectionmode(ieee, tcb_desc,
 						    txb->fragments[0]);
-- 
2.30.2


