Return-Path: <linux-kernel+bounces-267305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C97940FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7A51F247D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AAF19FA87;
	Tue, 30 Jul 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x91cXv63"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BAE1A0B1F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336023; cv=none; b=YTCrb655H0/0a431KwFJZdQNKSGalaRCm718EBSEavAhzIsb/EP0Cq3ujOmAQw0iEzn0q1jvJF3PpmDKTLxZGWdggpy8TWdEepmZEpkP2p+nkO8t9rjJIPfofAjSKTKia5Bu7FU5kG5n3O7Z4N5zS87d1TQ+V2PlWdwonG43O4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336023; c=relaxed/simple;
	bh=XK2vz41KExPbrsjdjcBuzNEb9VnxO/ji4DDW6PPtcz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7aBllvA0iq7144xBw8UI13GNYg6BXmlwsT/MQRiIxTMcrwca1gLsh+nYgkHcTekJi99IbCh4cdHsDZcJxdKoop3x7YgJFaz6sI2c9CtbAIs4winMA3Ogsp3VIV+pIMvEODZH+4Ffuvz8j7Uj7giXwwzAf4ApsSpECD6NGXxxFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x91cXv63; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so16595415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722336020; x=1722940820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yf2EBrF/xoIg4XnnkuWAq411eye617onXjc36oa4tx0=;
        b=x91cXv63377pknF15NFhPB4zj6PwuQJbBRNLr2qjPKo+/ppZK78O9KsKArATufEyuX
         Nq9p7JWft0ScTkfjFCfhM1+mue9rWemKDdma5uJULuQoasO4OvMP3hP8hjsroekdwoXK
         ptggdvYAeIU5WWTEHH6Zmd9tDJPd5S5CkDI4peHzI6Z+2DvbP7nATDUvPObWO0wmXcom
         cnZZBWuKOT/BJUL0kPEZvoIVy9NenOfbsRtAEhB/SSo5/W/DWYEbNRcXC1FMX9YJ/giy
         3rz01H1WL90/vZiztuTbuj2A95PEtAKfN6YsKIL4JdWbIdzvSWYWV/avO7jlm9kuXe4V
         q3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722336020; x=1722940820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yf2EBrF/xoIg4XnnkuWAq411eye617onXjc36oa4tx0=;
        b=cCRPNlxcCbHXgRNDP8kNA4t2og6Xi1zkULKTN7VoTGEVQIdceERRtzqBfRWA6x5bJT
         /gNlFukPzU/LIMI4FUQtHKxlMiaopaMt8gb3SfDhEWHhraVmJ9kHOf+3c/bq4EI0OX29
         WnMdyK2+N/I8Kk3TEwsbc/4OiWoAfuDHSe30EibKlgk44tBWmaD+Ggn2GnM5p2O7FwJf
         6eSLWIu79hp+SsovRRf9ENP1rNsZ301CRJOZeRrR8PQja6Fb+TiLd49Udz/3BAJQIYo5
         X8fXF34tIPUWUU6fHEUsx9hQj13N4ShkWX/voEmS1Iv+dC7Hd2S1w7tUo9lIfI1nlpbM
         VYAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOki3fHBPhqMF88AkPjEt5BmMtDrq8Dxr1q4IJwIZ9xnHuhu2+9YtuKV5u0vdKnmEtNOzrnk69k3jIdGmCuCor3llOMA3LDD9ewXM+
X-Gm-Message-State: AOJu0YxJSWcMPweybKRopkV0ga+yeE0PI9qAPVKHNJMOgglRahVbr/lB
	83GDoM3bH3UqJ6a9fwgitzeYo1aUVbTrw9vdurEHnVFQf9bPcNCzbmh2Jx4QyO4=
X-Google-Smtp-Source: AGHT+IFztmIvpi5e6zvIrQFHfTnJ6M1HTFlAZ0o0tSn7EJGgisCW751On8kDQJ0gXBzeW2QXpYXtPg==
X-Received: by 2002:a05:600c:a41:b0:428:9c0:2ad with SMTP id 5b1f17b1804b1-4282445d0c0mr10083445e9.18.1722336020479;
        Tue, 30 Jul 2024 03:40:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42809e4423dsm175962665e9.13.2024.07.30.03.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:40:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alex Elder <elder@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] net: MAINTAINERS: Demote Qualcomm IPA to "maintained"
Date: Tue, 30 Jul 2024 12:40:16 +0200
Message-ID: <20240730104016.22103-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To the best of my knowledge, Alex Elder is not being paid to support
Qualcomm IPA networking drivers, so drop the status from "supported" to
"maintained".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

... or maybe this should be Odd Fixes?
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43e7668aacb0..f1c80c9fc213 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18452,7 +18452,7 @@ F:	drivers/usb/misc/qcom_eud.c
 QCOM IPA DRIVER
 M:	Alex Elder <elder@kernel.org>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ipa/
 
 QEMU MACHINE EMULATOR AND VIRTUALIZER SUPPORT
-- 
2.43.0


