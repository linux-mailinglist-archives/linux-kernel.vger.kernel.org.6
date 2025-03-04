Return-Path: <linux-kernel+bounces-545449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E307A4ED4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E94E1890D1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EA025D215;
	Tue,  4 Mar 2025 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDkEp5qA"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAEE1D7E35
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116416; cv=none; b=Qf1f8pS2JgOf0OFs3eN48kaoXo9oUQlyK2jp9ucc00vt/kf4BdTpmUOhUgbXx5aN9wTWcLKYMWB8iSrGqzFDl9j3l5mxjCMzOoN6WLDYdkNkurUq6y7Lx6edSQ01VJ2cxHkj7v98OPkVNrqeF4YpvfNSl0OeqijR4zuV+1o227o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116416; c=relaxed/simple;
	bh=DAdX4OpccQ4N/WOgqzCYspVQp1sfDjoox8PLWuX0yz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flRmWQ+eNyBP9UCDhA94uXwlwkOauN1xkgIdJZe5HozS5CuFTRIUNlFNOGt8vL/QwUgLMMxfbopj8KrV2d0jmI2+hNAHBq+evr7hW9vrwdo5F7girgm9QL6hIFV8VCrOc+u+fjFGhI2YU48AxBL9PdM3pGvjJG/p298Qjnlrfzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDkEp5qA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2238266483dso9327135ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741116414; x=1741721214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0a3i+UFmRGSl/m+YRIPURF4olKZ+jWt/8woe5airEEw=;
        b=TDkEp5qARYBm1F2GzXRC0kXZR2uUmhIu7/oCWSbHE+Ipp93g3gxZmphTmjMOkglinw
         2ljaZ0JHqAWd992JgT8vtM0y6RhjpJFlX97jmBRU/nXwtyapzK4x6TZKiSbvDFO06LFF
         7jv5Bsf0w7zNJWn2WPNGFE9TCNs/OD+YiS6djEbaNbxOL2zstkquCAcE+o6itamLA0Jy
         SMjeQPGMKaSBiR7d5gz2xshcePDz28+kF7+3sK88xmsh1134t0xsfKb4WlWNTfm8EpZ5
         jEml6quOCRsTQGl4BNfu23OBUXVPS09Ol09zH2+RgaO6C23/0alX2QWdxi3Jd25Evmh+
         Ymmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741116414; x=1741721214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0a3i+UFmRGSl/m+YRIPURF4olKZ+jWt/8woe5airEEw=;
        b=PFfPK+oUV4wr9FMtWDOYuXmajxwYvJ44ysCRxnbPweALgXi9L/QsWJ4Qnkjo1DzaUs
         pjtb2C0YgbJ+2cbo24f2YbdTk9feSjLh5J0mVRf7hhciePoEDeuXiiDatnRTuMWTF7us
         wiMshOWA1DGPZZDwghatZ/x8zusgdTr3T9Tsc5RUJTpTqk47rbiYqqk0TQt01WqND+Gc
         924Yg9jHSxhjOSTNhmwm+33LzMGN8dtMGuSuzW7PCa9A9AUUhUGPzp+GH0AvpCx/MLsn
         rmr1WRVOLjcJnClJmqV0zd+lZZlIp1/wG+njafVtfQoLSOVNzVT2zAVgDWmf7A1To+F3
         GmWg==
X-Forwarded-Encrypted: i=1; AJvYcCWOXwXvkmsy5xdszkcynq+lViuFk7EVAXJZFCgTHfgM7/y7IZFqDmdX6KlscWq1W3fPn7OC3ZqxNO6ljTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRpwH2DgsxQY2/em8f/7/deZ0FU50618sjRYHnJBzGOy1lM+v9
	hOGFYH8Ll/R5bBQFQfoOmLwMubmuvNa82z09YcqRRY93IvSiwirl
X-Gm-Gg: ASbGncueMQLvo73f6Hdze2dHEHVkiaTE1jY8xePpAFyopq6qVV+Qxad4GMPiwLTsz8i
	WDP+YsU5ZEI/Nh4TMS1GHPztPxe2UQ8JVhwQ00zn5k8hwYrpQBm/4jAuQbID6X9HgyxZdgHQaRZ
	di1CyNGcSRwE83VtqqJ1lTgZ2RO0AtEI8qn7HVF8c1KcEi7c2iUpTM2X0AI9c5LEofIjowAhazf
	LKW1Ft1UtpA+PyDg/0FtNtuPFlntYCVXcXToKpoIqVkPHbDlRR3gr0TqpqQioixtj5GB5cAygEY
	c9wQxLzsAv5z0qQdsSOTkVVSgeJbtvVFQAbSE/gXfcX4qHTr4aziV7LFdA==
X-Google-Smtp-Source: AGHT+IHsR5Gyj3IQ6WCJBUcHLaPvJEGRp0u+lrdzKgsHJz4jWIFjmVkczlI+pasHGBKFEHhUmAp9cQ==
X-Received: by 2002:a05:6a00:21cc:b0:730:915c:b77 with SMTP id d2e1a72fcca58-73682b5b913mr54849b3a.1.1741116414537;
        Tue, 04 Mar 2025 11:26:54 -0800 (PST)
Received: from localhost.localdomain ([2802:8012:1f:3200:f1d1:c186:ba5b:8f06])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734d444a9fasm9341920b3a.60.2025.03.04.11.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:26:54 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	niharchaithanya@gmail.com,
	jiapeng.chong@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Gaston Gonzalez <gascoar@gmail.com>
Subject: [PATCH 2/4] staging: gpib: fix kernel-doc section for function usb_gpib_interface_clear()
Date: Tue,  4 Mar 2025 16:25:39 -0300
Message-ID: <20250304192603.40565-5-gascoar@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250304192603.40565-1-gascoar@gmail.com>
References: <20250304192603.40565-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add '@' character in kernel-doc comment in order 'assert' to be picked as
argument by the kernel-doc compiler.

This change fix the following warning:

warning: Function parameter or struct member 'assert' not described in
'usb_gpib_interface_clear'

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index eeabbdb39057..090857824d07 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -621,7 +621,7 @@ static int usb_gpib_go_to_standby(gpib_board_t *board)
  * usb_gpib_interface_clear() - Assert or de-assert IFC
  *
  * @board:    the gpib_board data area for this gpib interface
- * assert:    1: assert IFC;  0: de-assert IFC
+ * @assert:   1: assert IFC;  0: de-assert IFC
  *
  *    Currently on the assert request we issue the lpvo IBZ
  *    command that cycles IFC low for 100 usec, then we ignore
-- 
2.49.0.rc0


