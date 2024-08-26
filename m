Return-Path: <linux-kernel+bounces-302279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D922995FC0D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BD61C227A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298C219CD12;
	Mon, 26 Aug 2024 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqRq4KBI"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298FB64A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708940; cv=none; b=otcgjXrQDO1CorpklmU9HUXqxqbxYEGgCU2z7brigxqqDo8Liu1CA2MnXbVYxSfMKfW2rfhUjifjKqXTauRneecDmPC3hvE+mollxEqMT3L9nlWc0NlDhR9KIjum+krDaTMFMcytedibkCDY3VauxrkC3VYcFgMMXqcixAGodz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708940; c=relaxed/simple;
	bh=xdz6JSkn2AEuVmNz6w5uVIoARWYD3VBI4VhoF7crCAY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GyI+lAFPuCUeGQ3KOkhToqqeD2Y1OEPBu7hhxoNPHteR0YdFeSgwqjMXVPp5QynI/byzrp3hbz4XypjkcPQqp2Gjkv+axnK0wVjCXRVTCC/HMxOf1R8PXCFQsuvUVEuPjktJnODR6BB8iZMeM/U4LQsfD2GLadNBLsTmjdMP/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqRq4KBI; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso3257011a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724708938; x=1725313738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yy8J2IE41q6zia8cYCGqVYSEyhsGRBLlE3f/+odahgE=;
        b=SqRq4KBIZvgmrVIyJXkI5tFzN4uMJpYYhN3dg8y7DJpB7GoKySxEylNw85cknBtL/x
         o3a84uouJ5jrqYYK4enilG4qhH/gKvjUZ5Wrkq4Zt5qR9m1qd0oN7Bc+bpaM10OTDhjv
         c0BVwNPbXYnvTeIVUlqn+06iW0X7j2wmjp5t/fXAEOg+mXAumKAoT5mt1C1LuxKO82s/
         Kzf6Nwm524kczRnQnQpraHbZWT64SjBmuxjLvlQz9tLwfMxgOzLzxNoE6coQ35FO/qHj
         0kcVcpAw6ivzKmFTKNyBaGxvpBCLvFZXP0IYC2v1gDPO3YUwZ+WM8RpOhv8b62bevEQ7
         MXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724708938; x=1725313738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yy8J2IE41q6zia8cYCGqVYSEyhsGRBLlE3f/+odahgE=;
        b=TSMRb0NWyyFlcu3pzv1ArBmJfkfYUS6hYx9V0x2HyodHCA1DtWEib9vJ3wTKAm1xDW
         UTKUfChGFEmgiJN3L/lN2CzAs92XTCsUnki9VpOXLtIPq2BfLBXpmSYb4rzhQlS9ybsT
         Fh8fPacCEB45bEta0+9uB1Fb5vTsHQq2AQ52Za+VEyyIoFqzzH3qV4Yqa5HSO3SAHLN6
         uL5K38WLj0yyurxxJrfhGuMjH3KtndEn+tHeClwIcwfMGqRoWX+PuQRaamnodaFXIqA4
         MHnAT84Uw7H3EjbuJuz30FuiCsZG7xT4KUm9OVPAAo1OvqaDKTYtOnYR/Hz6obaBbEkB
         uS5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXn0CgboWo7Mi5FdUbm4ckPRtV/nZLpKdEo0p5h1JsovCui8KKlA3GFMJ1WPUt5vTzERURKxcctDtnpW+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFnF5kg60bYQfkseRfymJUM5PqYVXX033l/4eORMvzToTd2TN
	rqzeRng2aDBYhYg7w0N/6h4UmXGDHni4LxXI7XqLleyZoJ0YQghP
X-Google-Smtp-Source: AGHT+IH3ihqt8I3Yrxd1Jr09igMRh1xBOyJkSngSBh8WiYzs1NcJ+XJK1sqyLAEPGBIVSxiIB7qvYA==
X-Received: by 2002:a17:90b:1052:b0:2c9:5ecd:e3c5 with SMTP id 98e67ed59e1d1-2d646d38277mr12648440a91.33.1724708938371;
        Mon, 26 Aug 2024 14:48:58 -0700 (PDT)
Received: from localhost.localdomain ([2804:4b0:1408:4900:9408:c7b2:31:3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb1726sm12621151a91.37.2024.08.26.14.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:48:57 -0700 (PDT)
From: Gabriel Tassinari <gabrieldtassinari@gmail.com>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v3] staging: rtl8192e: Fix parenthesis alignment in rtl_core.c:325
Date: Mon, 26 Aug 2024 18:48:53 -0300
Message-ID: <20240826214853.21003-1-gabrieldtassinari@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix parenthesis alignment in _rtl92e_qos_handle_probe_response to
silence checkpatch warning:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gabriel Tassinari <gabrieldtassinari@gmail.com>
---
v3: Adjust the indentation by adding one space
v2: Include the modified file in commit message
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ad21263e725f..75192041008d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -322,7 +322,7 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
 
 	if (network->flags & NETWORK_HAS_QOS_MASK) {
 		if (active_network &&
-				(network->flags & NETWORK_HAS_QOS_PARAMETERS))
+		    (network->flags & NETWORK_HAS_QOS_PARAMETERS))
 			network->qos_data.active = network->qos_data.supported;
 
 		if ((network->qos_data.active == 1) && (active_network == 1) &&
-- 
2.46.0


