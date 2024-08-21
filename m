Return-Path: <linux-kernel+bounces-296224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CBF95A7E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCB81C21E42
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50DB17C7D4;
	Wed, 21 Aug 2024 22:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JmlFguGD"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC2917C7BB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724280250; cv=none; b=C5kis8SGXhgWWOCtI9+f4C+AEytyj5by9d/oe5jLrJH9/Oxl4zPJS7kH37+/fDbuWi8nAUATxClOM5MuvP2ObyMdVJdwFhjHOrG3weeLh7bdsv8lo8yaHwSCY8saIR+1EBeG9LyfNG3c+pBG6TStLyXyYsAUDUNywr/rNN0yTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724280250; c=relaxed/simple;
	bh=5cLHH69JJDhOiZb/fBtbVOyASTGvXu6KKQLE3TDOJWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0PsAMzSgwUq/Gsu5mbbHuXU6uWdeqLRU9VAZuEMew/UikVdhnLItk6bj6ROqMbBUGzLXkCM188NuBfY1oOj0MlDnUMcC6PemO28T9Mgzq7rbKNO0LnWHFsqinfVbFKJxgNBCro+qzG2Nq8EucYQ8xUR+Udyjp3xTD67JWd2rLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JmlFguGD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so139316b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724280248; x=1724885048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WqryzH7j3wvqpBXhrLGUt8KpB52GpjP5213AXHE2etM=;
        b=JmlFguGDuqKT3oWwE7Su3z1wZ273p+Q1qZXq7u6aXIAu1XsOYnIbS9pY+erp0Eb2Ex
         t+iem3nv6i1h2YD+8P0H3SKPnq6hhBvb3xUm+74jaFIrPzx67Qh5tZc8Zwsn7bgoOOhs
         q0jB+DEmVvxNINQvFp6dylrAiR/lgK93ojB5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724280248; x=1724885048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqryzH7j3wvqpBXhrLGUt8KpB52GpjP5213AXHE2etM=;
        b=EBCJRhfPPiwLGgktErT53Gx7IfabIkoUhW49KEoj321HTgahB+jJ4zPJlVhP4xOSii
         V8La/PG2lKPuyLFEZIy/pRfhwBcIbiyKW0RLUAPB0Rr6cKT6XMtNAAJ0HNKRdTgpLALJ
         TRwE8wl2+s68BvREKal0raXZfFs//kFoXiDRhMDDQAlXrZJtyPETJInxw4gkr/4oMfbG
         j1l+CROB1MY/LCtQElF7Klz20WtROpHK+WVQs6NgStR41+pdP9Bg18xfU+fUrzXIklqH
         qyjfNELiK3S9gw3sr3TrX/wl4dolVWxv2KIJQ4zQjQCuIHRhb2UZ9Cd+rduTEgQwY9q/
         cHbw==
X-Forwarded-Encrypted: i=1; AJvYcCX49+zopTio61FHGKCtKysuI9yU4/cWpUHbNmcjziIGP4L5+U4UHmSRsrvDX5DKHoaFGfFzi6GAqBW6f8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeM0wyUmS1j4AST+iPNAC1mW6Rw2v23scJy6CoACzFzoi/hlLn
	v5ZfY0YTbenfyEBqGvvcgFpGxbmdkNvjmH86ELzvwq8wl9B7RajQdjpa6t519A==
X-Google-Smtp-Source: AGHT+IFwM9rn2lURI25CT0hrSuglfVOUBVyVM6H/oqBUlv0bJmvcoH/Gcz2c+LGeDKE/N6Yy88qgHg==
X-Received: by 2002:a05:6300:41:b0:1c4:8da5:21a4 with SMTP id adf61e73a8af0-1cad81a7279mr5139868637.41.1724280247846;
        Wed, 21 Aug 2024 15:44:07 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:8b27:65e9:2bb6:ed40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e0a10sm157368b3a.108.2024.08.21.15.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 15:44:07 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Guenter Roeck <groeck@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sai Teja Aluvala <quic_saluvala@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [REPOST PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
Date: Wed, 21 Aug 2024 15:43:40 -0700
Message-ID: <20240821154339.REPOST.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems in the field, we are seeing this sometimes in the kernel logs:
  Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95

This means that _something_ decided that it wanted to get a memdump
but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).

The cleanup code in qca_controller_memdump() when we get back an error
from hci_devcd_init() undoes most things but forgets to clear
QCA_IBS_DISABLED. One side effect of this is that, during the next
suspend, qca_suspend() will always get a timeout.

Let's fix it so that we clear the bit.

Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 45adc1560d94..efce3846d5fc 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1091,6 +1091,7 @@ static void qca_controller_memdump(struct work_struct *work)
 				qca->memdump_state = QCA_MEMDUMP_COLLECTED;
 				cancel_delayed_work(&qca->ctrl_memdump_timeout);
 				clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+				clear_bit(QCA_IBS_DISABLED, &qca->flags);
 				mutex_unlock(&qca->hci_memdump_lock);
 				return;
 			}
-- 
2.46.0.184.g6999bdac58-goog


