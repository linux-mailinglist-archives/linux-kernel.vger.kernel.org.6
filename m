Return-Path: <linux-kernel+bounces-206131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE49004AB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F9A28E68D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E7197521;
	Fri,  7 Jun 2024 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eV2kWYIp"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A251953B8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766594; cv=none; b=Sz7HwY3xrlJ8VRfZceXoqQIAxeLTJyyuRApTyQcwPnBXaD53NWUZ3vKklSDwpGREYCghEQAEPYroyr65E/mnl5T1GGhKNVQeTZqpqO6fFCDe67tjYAM83IOOzADdHA9/jn3Y612TfEQ9odqoylxCyVZyjoYP3xk6dZFIQJhLGyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766594; c=relaxed/simple;
	bh=JXbaAkUfXwOLePC7VJ3jRbdq5WguoXJxRCdZfMDCGD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+eaB5xwglN6Xz32i6QKa89TjJQkhYL784YoEFEE5otx4ipyGDSNEzEAK2t+OfYrI7gaqnvjXpFWZjuswggpSZs3J9X/fSouUbonlo8XHk5HygD2VLu01SOL9S6qN9o8yPiOrCCsBJbmGk2wJwCZVWYgbK76mTcHGPHex1jvY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eV2kWYIp; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b7c82e39eso2385538e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717766591; x=1718371391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkMzRYwH0rVG++I7PNZai1lbvWhZpzJwskrcS26a0W8=;
        b=eV2kWYIp9LNN48YjuIkJ8WjmguHJrMwXyBSznQ6D0xDY1oxyK6W8Q9R3zTF4ok4+Zh
         5m6DjlFjPIbHFuWWuNj8cCYw0cb2oWDp805h0g5aQKOM+kbyTZlZwzcC85to+cpidcNh
         VwO6Kq9BQqfK92vHwHp7AMaG+6NjHCCJzQpQs5OBqDS48VlfqC9e/Sp5eNt5exgkAebe
         6W7eXiyWh/Lt4f6dUa9i48jztVItYxIY1UIOR0L6WNH7AUJfX5awlzIwPknJPJPOhCKT
         Z7NZyUZF3iDRbno19qeK8nfj5BW01PjQEalE22kLnMRySVVEd85CHWL58ZihprXt0NNM
         oa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717766591; x=1718371391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkMzRYwH0rVG++I7PNZai1lbvWhZpzJwskrcS26a0W8=;
        b=pPfUb8wB52l9gqir9J5HO3aNfp4MJunQOzqyq+xRnnJ4UAW3aObR212axye7OdzEPb
         0CCgZvrRSIVd4dDQw4GwdWMvUmE7x9nhKZvaOtAjH8MYJG8Hda5JUev3mtSRYKJwnf5+
         nBd1414FaP4fQFBCs4AnAPhExBxBxIBuETHp7WxnjzDojE0llIgmn/24cX8jLUqM0ugZ
         TvqqckkWGb4yMpwKWVN/dcsBlpbkTwwUOf/+LfAEC42W75pnIHF5IykBfEu7nh7AdYYm
         iEzIzVldvRgEEmKv7Zr9rylG2OfXxUFZTNTvCOG428Et+DeABpJxoQW7XD6j0q33fXiZ
         i4Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXDTjgCV3WZWg7b0xIkLYn/TvqZxZ+YxUoJ/D+Go0CZQhR3zBVPXQ/dk4NrDk7t+5aJBxrmaCOrCELwcOBS/Qe/4nzZ+68uaCf6uroB
X-Gm-Message-State: AOJu0YwTPVMVH2Tp47wZ//QIasFYOe5e9VAaYeXpklhNJgrDfqH5Eq1j
	sWv3Z57iyTUCx+QVnZmIKuhRwMSU6Gr1IMZQYYz/ut6qzLas2FsOZpoBP3+cUg4=
X-Google-Smtp-Source: AGHT+IEqVYzspyMjFA7VM7X1Pabg5rRSRUot0NNv54KwjdMq6vbtyxYVWWj0h/mV51xuhgFiU9PQ7g==
X-Received: by 2002:a19:e043:0:b0:52a:5fa8:d565 with SMTP id 2adb3069b0e04-52bb9fde009mr1923547e87.68.1717766591565;
        Fri, 07 Jun 2024 06:23:11 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bc27640easm80944e87.104.2024.06.07.06.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:23:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 07 Jun 2024 16:23:05 +0300
Subject: [PATCH v5 8/9] drm/msm/hdmi: update
 HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-bridge-hdmi-connector-v5-8-ab384e6021af@linaro.org>
References: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
In-Reply-To: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=JXbaAkUfXwOLePC7VJ3jRbdq5WguoXJxRCdZfMDCGD0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmYwm23kjoKoowWNnnGfRUNcWsRsEBx014LiQpL
 K5kGF2+H5yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmMJtgAKCRCLPIo+Aiko
 1QpCB/986W06+rStv5lrhzZaOvIKCcFCaFIJSIWQQDpppibPurGZ3ZYo0jReEMU14k2BZ8ExxpU
 UP+3rylqKQwPmrOlEvThIiloVTP5GvoH7ofajOZ3Q+gbKBqJX6GXDz8o0pEbwxmnPbkE1P+YhZk
 AOTyaAGdmMT0nu03qIaUOTgfWWrZGtLpC1H/foGLe/CYBDcp2p+7nBLzJ2TTkYyKkEjZFjBisEH
 6C0KhtI84IU4BXhfXjv0jYBJusFYuuVgzRdM7MniL2HRcaQ25jKY/TzLB92YNFjH6nSmFO6Fit8
 KCqjY9mRBwlRLa4PMAhKGC15tF0GjQWOJ6YmsPESUZSPCHnR
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The GENERIC0_UPDATE field is a single bit. Redefine it as boolean to
simplify its usage in the driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/registers/display/hdmi.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/registers/display/hdmi.xml b/drivers/gpu/drm/msm/registers/display/hdmi.xml
index 6c81581016c7..fc711a842363 100644
--- a/drivers/gpu/drm/msm/registers/display/hdmi.xml
+++ b/drivers/gpu/drm/msm/registers/display/hdmi.xml
@@ -131,7 +131,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 		 -->
 		<bitfield name="GENERIC0_SEND" pos="0" type="boolean"/>
 		<bitfield name="GENERIC0_CONT" pos="1" type="boolean"/>
-		<bitfield name="GENERIC0_UPDATE" low="2" high="3" type="uint"/> <!-- ??? -->
+		<bitfield name="GENERIC0_UPDATE" pos="2" type="boolean"/>
 		<bitfield name="GENERIC1_SEND" pos="4" type="boolean"/>
 		<bitfield name="GENERIC1_CONT" pos="5" type="boolean"/>
 		<bitfield name="GENERIC0_LINE" low="16" high="21" type="uint"/>

-- 
2.39.2


