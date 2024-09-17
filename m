Return-Path: <linux-kernel+bounces-331288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DEB97AB02
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C28B28BE24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A63839F7;
	Tue, 17 Sep 2024 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="WpOpmdsQ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A64174A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551119; cv=none; b=O+BHRYIP9q/fjnMQX5YpAqwNYYQT47qkG3pSaNiQJt/6YGgtDnt/p+Ue07ufQUktsj7i+H46d+agcK1uWHICXJsjFYVDLpQzgRKVyRMG6Ek2FO9yWqLLoU38rocgj2ybL6zkUc3P5LFcHA3IsvSRVQMdlxX0KB6Ax9GRUyL5KR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551119; c=relaxed/simple;
	bh=K8nfSr10EcF6PUvU89ZAJtY+Y0GNw9MlRURLlC/EAkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CtppPPLTVabY7+wADCBgLvhNkluxMhY65+27vDhWG1Z0WLyz7CcP1hUE35PFqMkaxqDuHXBFbI3CkI5a4rEHX2b/ji5jsUsBi8Xd3pTcU4ZT/6ggiZ2bl+1ve+PLRPySRYW8JkU+CzERIWHn3EDElneEPU1dOdmT79Mg/E+wt6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=WpOpmdsQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so4398835b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551117; x=1727155917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGyWd9SjHJRazr/twXm1zqpgxc6lZys6CmSWJwhQDgI=;
        b=WpOpmdsQ1rSeo8xrN+A9JeZflOMeJwoRUXW5XqI6HPGkxZ+opX4/M0RcNNO4ZmmxqZ
         AH7Q/f7aKUj6plvf/K2hbAY6W6oTCcCGBYDL0OR4sowi+X/OX++vKQ/iEgmjRzsW9jMo
         iyonypxc7ksPlIV7qjzvrdU1ql4q5MYw0+dF2lMcl49YtD7WimBkXmDnCRCa4wOpV+SA
         nbqxJyP7kLri2RNeRuXZ9JBcHMWj/Y8pHN7fod4mBeqwm66ft+DatB0eUE6gHteX+G2r
         QOx33yLEPDSWjRSuTL/VrJ8ss5QIAGdEdms1eI76Fb7fslfCGnO7zg/8/8SY+AMaEu0P
         qTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551117; x=1727155917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGyWd9SjHJRazr/twXm1zqpgxc6lZys6CmSWJwhQDgI=;
        b=H/VmP77h/rEwewWa3akMq/G9AaajmeYw2TJ93Uu6i8rauhJIhFB3uAFsvuVE/q5O36
         dq7NTkGNQ5V/WFhz7pUlwZ543PBCFTn9RI1TsJf0o/s2Gzkh5t2KkyUf9/vCfruUIbHy
         /Hk8BKhoIb4r9naf2NAtgsPMUEzVkoGya5mq+KrlhoacKuQigdJlR6jjfy6oUcyxYhA7
         znwLSdi4XGvMXcV2te4a8Ki7aTNiqecgstCExlgPUXxz9aGm7hCKBEZzqbfqKZ6DykGz
         Gigsmz/inMBsuA7VQRTCgHO7wLcaJgKhlSBoZ8kwLfOFTeT/OEZrdKRf1Xh9xCJkq6lG
         515g==
X-Forwarded-Encrypted: i=1; AJvYcCX6P416DTszkfe+9GBF26blq0YQXPQO+wPHk9dN2URq7i2zUuMs9l6vwM8sn4wlz7HqzP2wHxi9bYu3aMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxha81JewsPy7VEv2PyP7McBM7ehjLwQqX30GfhdW6yU2/g+bOV
	ygXFBDR/xRAgnmxOWyj7Fef8hjya7z8ZUoX2kakWYE5srz8BTxmJ7WkV15vJZ08=
X-Google-Smtp-Source: AGHT+IFIxP5DxAqqxP/TrO2OFaEEhBVHJ4XkTh7pzSCwK9Y7KSmdmb/nl/G9Y0HJjKeV/BTnpIzeMw==
X-Received: by 2002:a05:6a20:4322:b0:1cf:651c:52f1 with SMTP id adf61e73a8af0-1d2cecf6d8emr10057411637.0.1726551117119;
        Mon, 16 Sep 2024 22:31:57 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:31:56 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 02/18] Staging: rtl8192e: Rename variable bIsCCK
Date: Mon, 16 Sep 2024 22:31:36 -0700
Message-Id: <20240917053152.575553-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bIsCCK to is_cck
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 2672b1ddf88e..2000289720b3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1173,7 +1173,7 @@ static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
 	pstats->bPacketMatchBSSID = precord_stats->bPacketMatchBSSID =
 				    bpacket_match_bssid;
 	pstats->packet_to_self = precord_stats->packet_to_self = bpacket_toself;
-	pstats->bIsCCK = precord_stats->bIsCCK = is_cck_rate;
+	pstats->is_cck = precord_stats->is_cck = is_cck_rate;
 	pstats->bPacketBeacon = precord_stats->bPacketBeacon = bPacketBeacon;
 	pstats->bToSelfBA = precord_stats->bToSelfBA = bToSelfBA;
 	if (check_reg824 == 0) {
@@ -1370,7 +1370,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 	if (!bcheck)
 		return;
 
-	if (!prev_st->bIsCCK && prev_st->packet_to_self) {
+	if (!prev_st->is_cck && prev_st->packet_to_self) {
 		for (rfpath = RF90_PATH_A; rfpath < priv->num_total_rf_path; rfpath++) {
 			if (priv->stats.rx_rssi_percentage[rfpath] == 0) {
 				priv->stats.rx_rssi_percentage[rfpath] =
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 21d8ea153368..08eaa98c0a1a 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -483,7 +483,7 @@ struct rtllib_rx_stats {
 	u8    RxMIMOSignalStrength[2];
 	s8    RxMIMOSignalQuality[2];
 	bool  bPacketMatchBSSID;
-	bool  bIsCCK;
+	bool  is_cck;
 	bool  packet_to_self;
 	bool   bPacketBeacon;
 	bool   bToSelfBA;
-- 
2.30.2


