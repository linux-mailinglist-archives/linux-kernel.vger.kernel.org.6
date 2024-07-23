Return-Path: <linux-kernel+bounces-260214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DC093A498
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4598428428E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C031581E2;
	Tue, 23 Jul 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="B5R/5gLG"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D0157A7C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753661; cv=none; b=izzYtEQTwk5jtcksUWIwa4woim1Stf5/ATXez5nxkk5XejJ5Ggpf0zVd+y54gOP+1XgmEj+MjJ6pgmlgOcl+5LpvU5/KrqFE0xJKFfXBxrhVqhzUMeFJf3fCtk/G6m19C/LieaREKb6crBr15l8D02SKh7p63xIJ9LPi2p9We0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753661; c=relaxed/simple;
	bh=EqmoXx9ANo44HduyygKOKQ9h/PuYmQB0faEDVLlWrU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cwXftIfAzJMweifPg6nJ5udz5+/QyqF66exH3pPc84axvogqEVv99orD+Q9ck12jIv6N4lO1LRMQjXFihMRcHnt2F/BBOTPXm3lehv5soZbqKoToX/yKP344MfRnnxUtCPU3a4D9KxZ2tJvJtdLW+MPQRUsco2Gq8b+uCUKTIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=B5R/5gLG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so50302435e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1721753658; x=1722358458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ec19jJGfGnBIYVJTGlviXly/zWfA2esrkPo5x5OJnq0=;
        b=B5R/5gLGOcGjmEcAuVGEJn7OcLmFxNTstKzEl/MiuRR+BTl/tVifs59tkOBALUgfr0
         +r7aY3NDlTKzngyIcaUnV7nh7tmh2AnC/3VulAkWuPsCEXBUboZOXF4LYwehlHzGaT/i
         l35d1Y8flB/92AgiVZ9OvY+rqGuFFrkNleH/bjWtH439nUqDj28x/mRIla9Q55mnmjJP
         Rz/4yUETQHCQMAv10JDDy2b0f/vcac26c+zzS9NbCwU4VZYThXXgSCUdE5ycg2NdK0Qh
         YPGB8vT7nSa7vOPOAN7dH/bR7N0OwnzNM/OvJTbh5JgwgsZdvdOnasnxwRZ9hv1/fynF
         aVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721753658; x=1722358458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ec19jJGfGnBIYVJTGlviXly/zWfA2esrkPo5x5OJnq0=;
        b=Qcl+ZKkhL7qnn672g9X+2X9nnWNGekSdiBReUzLedoTOrgFZScRsIwqyBOuSWYapRg
         mGyC+irqn4ji5bmfpBmFcJYsZGf8WX30AdNj/kS2fmyVkTDl2VTFiqUmWGgIisZgtsio
         wxlzBpqbXz24COfEMV7SN0CaMhkO95q4Ru5BLOjlqmnZ/3GfMfWOGWWlPz+XAKU+ZuHR
         /Wq1Pfol32A25+k3GnF/rNTvcPsL8eVpkElp5aD7ZmVKSwsCszB3vnnt6EpB8k2a/On/
         s4Zq5Zby6o4XxnrmRmwrJUsGIQ/vVDXtmGOTkBsX/LBxu1ECyWwES820ZMPMqWJtPeXx
         hGhw==
X-Forwarded-Encrypted: i=1; AJvYcCVj+aGA2aZXi7zSkuz8z21/JGERTJGNort9YTmXJ7chFJLhBDhkataG6kS+6tXVF5DTsclSuljdRdjSx9ftJUngqZXB4eDMNvLD+6Kk
X-Gm-Message-State: AOJu0YyWfheRIQV6823HDSDVLR/6ByGR+IMKnU6SDYwfhMvdm1G/FfMZ
	5JjkTS/aO5pFugeLaDgaNwM3YFDpiDIchoIhZLXAhPIHhh/YGVY4uqbB28O4qW2YdYesmF0JQEd
	g
X-Google-Smtp-Source: AGHT+IE8FjLzbMDmFIu1l0FGepGi7un4GubrWRXa08UU0tOJSgIX3H10cJdAw1PsPSBh6SaicfBxTw==
X-Received: by 2002:a05:600c:b9a:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-427f7abaf92mr998335e9.10.1721753657738;
        Tue, 23 Jul 2024 09:54:17 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427df79bf64sm126909345e9.5.2024.07.23.09.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 09:54:17 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kees@kernel.org
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] gcc-plugins: randstruct: Remove GCC 4.7 or newer requirement
Date: Tue, 23 Jul 2024 18:53:31 +0200
Message-ID: <20240723165332.1947-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the kernel currently requires GCC 5.1 as a minimum, remove the
unnecessary GCC version >= 4.7 check.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 746ff2d272f2..5694df3da2e9 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -19,10 +19,6 @@
 #include "gcc-common.h"
 #include "randomize_layout_seed.h"
 
-#if BUILDING_GCC_MAJOR < 4 || (BUILDING_GCC_MAJOR == 4 && BUILDING_GCC_MINOR < 7)
-#error "The RANDSTRUCT plugin requires GCC 4.7 or newer."
-#endif
-
 #define ORIG_TYPE_NAME(node) \
 	(TYPE_NAME(TYPE_MAIN_VARIANT(node)) != NULL_TREE ? ((const unsigned char *)IDENTIFIER_POINTER(TYPE_NAME(TYPE_MAIN_VARIANT(node)))) : (const unsigned char *)"anonymous")
 
-- 
2.45.2


