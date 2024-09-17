Return-Path: <linux-kernel+bounces-331289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D95897AB03
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4E928BE58
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D8C1292CE;
	Tue, 17 Sep 2024 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="e7dffeeL"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098072B9AA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551119; cv=none; b=Xkd612Ikls7UmdQXJaGKTy9xgfAv/y5FdGDRzFyuEQZsm259E2XzC2kidAVHOnnp0lnDg2xad7urYWHn+1rpQ4xQtq5I3wNdQq8wE1ZIPTu8AyvH7GgJ+CU7GsnVSywT1am7TmFZAZMUi8lVIE+rPg7hZbSui9bZ3RF1MOgUZpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551119; c=relaxed/simple;
	bh=val/67N2SfFDFC/347H5PlPgIQr7gfh3hr689hL3QsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFMlldoQvb0gpI0UKU7DSU5nge1Y0Ekv9Y/31Dx6eqKpNgplYsKxdy5rHnzk43tLFWLeER/VQmNZmX8uG7b/rGUsA2+nEfqTmk0Av4nfy3yyQE5nA5J16tqlZUlO/0YJzKq104clLotBUJqILIhFhd0rlEEj/U0Xoyqerjz8/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=e7dffeeL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7191ee537cbso3673053b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551116; x=1727155916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8L727yW6y5K4Vj79MsP8Gb8oiWwFd0Isk+Dc5DKpe8=;
        b=e7dffeeLn+4qRA2zB6cJVld/QDuGyqjv6EQFfu5QMSQL/7UXdYfMhS40y4HLoqg6NB
         ESFhotZEVWsSvY9hfxlyL2inZNNjNThia8jvaFXPJsZt5nfcgHjeLndSYIrl1/BLuGVk
         3j3Zm5KxeXICZ8dJYUbIPIusoSWQNCKDunkRC+qYbYplbqyDqztVeAjdgsOawKiFj9SF
         PgbET8ACtZPeMIUBnwyDSGzws6nl/TbCrg3dGkJ2TrJXfNNMuLh7pHidMZVYA7wCxbjr
         ZKwSizmZJlKKeNYZVNaR/CitYOcJcSof1u7D2OqozOd0619AoHn+JwdR3p/mJNYDTngd
         MbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551116; x=1727155916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8L727yW6y5K4Vj79MsP8Gb8oiWwFd0Isk+Dc5DKpe8=;
        b=CM+r/IYyrNEFOl8kxD4tB74Q0qOEQH93lXJvTf50N2a83Om4NxJ9ydC9pC0Jg7enmd
         9ebsZwNF5VbbW3/uj0H3ylh3oirOdwO4S0XNDM0eUboWNZfldL0UFHtIqZu3yinEz5/O
         pjFN8sKFiLKf6+hdAXdQs3DbZFzN4AzUGxWoEUEj03UulFqzfkJxOg4jeP2uviYcF/5O
         5lKZF5NMfAEF7xdtxfQdId1GjvYBZUB3usVu0CA+g4c4lsnBcV2m03tgAmO61Mqso3Rz
         HOBna8OX/vmXZjQdDwz0t9S3PGuhmKWHJJG2LUX6cph/oHgLhf1FE+YAsGnqJjyPS+0R
         Au1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSypibKbbawFpqRAyCYgW4qIpJlffrt0G/of+DUvjLzDghCxrmwRBCGxZc6PgQHltnbUXhdiV8MCHQ3PA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrsf3EWD/ITptQl0FHEG7ncsS1CPGNt6eYQg+ZlFycCPi5UrlT
	CrSMv7WAMBr36r4KqeU4prQwgwtzm1E8qyzZVSSsG/sbfgZTH23pmPXzZhK7IE8=
X-Google-Smtp-Source: AGHT+IF/wKmKVvxO0PS4z5h/szghGGC8+5ScEmeewviyzau+urGptDF8+G+q8iJvn6Lv08VAHYPI8g==
X-Received: by 2002:a05:6a20:b2a8:b0:1cf:3677:1c4a with SMTP id adf61e73a8af0-1cf75eb94cfmr20928305637.16.1726551116306;
        Mon, 16 Sep 2024 22:31:56 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:31:55 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 01/18] Staging: rtl8192e: Rename variable nDataRate
Date: Mon, 16 Sep 2024 22:31:35 -0700
Message-Id: <20240917053152.575553-2-tdavies@darkphysics.net>
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

Rename variable nDataRate to data_rate
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d6615f787d53..21d8ea153368 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1743,7 +1743,7 @@ extern u16 MCS_DATA_RATE[2][2][77];
 u8 ht_c_check(struct rtllib_device *ieee, u8 *frame);
 void ht_reset_iot_setting(struct rt_hi_throughput *ht_info);
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
-u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
+u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 data_rate);
 int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
-- 
2.30.2


