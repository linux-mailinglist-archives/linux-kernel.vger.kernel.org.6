Return-Path: <linux-kernel+bounces-324666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F01E974F78
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C871C221ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31361714C7;
	Wed, 11 Sep 2024 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxy5Plkn"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0F613D510
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049814; cv=none; b=iX4t8GqgJo6ppLSSj4nbI+LNi4DxzWBDCJCqewZT/2AVp87m+79npoQ373wrn8l9bRHffopHwpCkPpUdkyjdCngy1PrOra3zcAALI8FZyrC6Wjs2gR0JEGRpw3WoNQZRyWzWkjW8exOW9WVWCa0cxUsouUT7p28U9U0XYsHMGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049814; c=relaxed/simple;
	bh=WGULIwGFcHMWpuzv6KqTEIotz3S5zoxm7qzdY8a1AAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Va/cZ9ozx2V3K2gKrzS6PiOdBiiV2nmS1Bc842Bu7iVGv0CXHDq4CjfjaR2Z5kZ+f7hbuK0Wht6cxqLYuaPVMC/RowhCwOfdpIRutNdWqAahAZn/n4FfHVJ8U5ClOm/vZglXzCryUI3/wMoDAX6YYt2Fxpp7FKCvmWibh69LWb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lxy5Plkn; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so2367890e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726049810; x=1726654610; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYeBhqn7rrFM95mddC+x7Jv95o0/aABHQuhJTnfgzyM=;
        b=lxy5PlknzoBt6M+YfeRY5QiOxDJ9syhD+1OfgS2cmm8XSeyIAFn1YHKR0KWh+lKkLN
         78HYsMUZesKH9ryVm8U/deT/nuwCWndD1PQt0IlCZuiAMLnGiXE7W28fTSrOiEP4bsbK
         I8U6dFyRbL/xEVTvb4fJzJfW2zjBTp0nZB3sFNSYKnkgayrjphdaK+YAdFmCh3xSdkce
         UkD59TF1o02kDSlZc3Y3E2psxE1nvmjOtNSPzFR+Mu5O3tArYep8ORbdVERmOA6xq/B+
         AopMl1+c+6/TqGn/aUDuxNxUzEpQm+OPrA2mPs7PgAnAJ57iTQkYcyN4QyhYRtXDWG0g
         ShFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049810; x=1726654610;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYeBhqn7rrFM95mddC+x7Jv95o0/aABHQuhJTnfgzyM=;
        b=VtQNC3tbuDqwr9YlqxwIBgOEbhj0KSn0md4YvCo98CRlGKgJ9UdY1YijXx8v8xTuuj
         CWM7rg8VinTJ0hQTCAFz3xSVt44AmLnlJo17bP6Uo5zOrN+iv0W1X0HPNsgLwRg9v3YT
         xvv9KPe2Ics5rthOU5S0Fd8aVErwM7UuFcOn8IJFFdBrPP3uiun0YEfb67SlCxzfDC8J
         OwDG3TvKipc8C5Y8/5CfT0JLOcof79D/mWl8DbcrcFqwohjuSEaC1BfknK76zyr9LtBb
         10+GLtId5afec9hem2lYB4bVcKka8sV7s8fUTz+trmC75F9N68grEp1kSezo0kExCJbP
         /sIw==
X-Forwarded-Encrypted: i=1; AJvYcCUIyzKoYwYc7YP5oOnOcrpooouxvtXxc1wifhYBdrm3qfAvLsBrS4YBX1kBsF/o0CUN4e10Rxm3oqiSFTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNK2uKMnZvMmT8ggEXiHi5FhNABQ+sekI0JuZYW1OJ067bHZq7
	vJE89+Z5LHX15gF45Hjo5oJ4BOcOsCh7KCO9MpARRhat/LUlVQNWmZBE4tJx9fI=
X-Google-Smtp-Source: AGHT+IGXELmJbRST89dICSQxeFnjBfTuKPgNg+mDhPc8/fYAt0oCs3+SOBTh7+U7fWv7r3k2GQkLvg==
X-Received: by 2002:a05:6512:3e10:b0:530:aa3f:7889 with SMTP id 2adb3069b0e04-5365880ff70mr11815140e87.56.1726049809549;
        Wed, 11 Sep 2024 03:16:49 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f870d37sm1533542e87.100.2024.09.11.03.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:16:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 11 Sep 2024 13:16:48 +0300
Subject: [PATCH] drm/display: fix kerneldocs references
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-drm-fix-dbc-docs-v1-1-ae5cb82fce1e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAA9u4WYC/x2MMQqAMAwAvyKZDbSlg/oVcahJ1Ay20oIIxb9bH
 I/jrkKRrFJg6ipkubVoig1s3wEdIe6Cyo3BGefNaC1yPnHTB3kl5EQFh0DesSEnfoOWXVma/5f
 z8r4fwvr+l2IAAAA=
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=WGULIwGFcHMWpuzv6KqTEIotz3S5zoxm7qzdY8a1AAM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm4W4Q03q9xko897YbwEEJw1fJ77gCeuK0W7kkG
 nf32IA/TI+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZuFuEAAKCRCLPIo+Aiko
 1bAlCACzT9XTqNcd/KPlW/BLyf31kdx2OQTgUE0a1sWJgTul7hYi7tRirO1ipfQeCBGPFQjMua5
 Xs3kvObdElB0DkCiT/jwHn9RPF56r7Th7k1s8CUJ6kL9J2t1mTXDYlQ9WdIVtBvA+GMrmDZ8dJY
 ifedMx4EMoSqpCeJqAKCPsr5LSh0N8TPSFc1q314Q4LryJgQHW8iWSV5OTZrQAcH8YuYoFAcTBI
 dB0d6pK0s65Nf/j1igekbXx9fEaqPCJAbA0DctBUX446oCGtQfQhBu7wV4VTtBRjJZhD7gQ87Md
 ZvLEM22cKVHLzL3E5Lx8MScXncKH7bahCiJG5Vis8aVoZrSf
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The commit 9da7ec9b19d8 ("drm/bridge-connector: move to
DRM_DISPLAY_HELPER module") renamed the drm_bridge_connector.c file, but
didn't update the kerneldocs. Fix that.

Fixes: 9da7ec9b19d8 ("drm/bridge-connector: move to DRM_DISPLAY_HELPER module")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/dri-devel/20240904163018.214efaa7@canb.auug.org.au/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/gpu/drm-kms-helpers.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
index 8435e8621cc0..c3e58856f75b 100644
--- a/Documentation/gpu/drm-kms-helpers.rst
+++ b/Documentation/gpu/drm-kms-helpers.rst
@@ -181,7 +181,7 @@ Bridge Operations
 Bridge Connector Helper
 -----------------------
 
-.. kernel-doc:: drivers/gpu/drm/drm_bridge_connector.c
+.. kernel-doc:: drivers/gpu/drm/display/drm_bridge_connector.c
    :doc: overview
 
 
@@ -204,7 +204,7 @@ MIPI-DSI bridge operation
 Bridge Connector Helper Reference
 ---------------------------------
 
-.. kernel-doc:: drivers/gpu/drm/drm_bridge_connector.c
+.. kernel-doc:: drivers/gpu/drm/display/drm_bridge_connector.c
    :export:
 
 Panel-Bridge Helper Reference

---
base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
change-id: 20240911-drm-fix-dbc-docs-8ac42d0c2e4f

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


