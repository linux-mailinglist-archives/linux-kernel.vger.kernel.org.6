Return-Path: <linux-kernel+bounces-309817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0282C9670B3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1686FB20E04
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E7517DFEE;
	Sat, 31 Aug 2024 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnxMi7P2"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C164517BB26
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725098926; cv=none; b=fbR9Cbj/cMofEDUGRj+WPObGkck/lW60hhKury5YfDZhjMiCIJFqlF9B7/UCoy5HzdChpqFh1l2gCfuGf9oTiCz7ZlFewWJ9k1eYql95VE9I3nWurSZCbTzn4ScfUZ/8GNkxIAYw/ua67H8slTl/tyBay5XizotLyR+45mOFrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725098926; c=relaxed/simple;
	bh=z9x4kvh6fBoQQ7+oTmL+WFNDMUlp4TnhC8xJ00dGT3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8iOoaDRNTZJ1urLJFWfODaY4ZNkJp2eGEjYAwlC1eUQpmcozPySBgdWGUDtuv3NHoTsfD7NrR3NP7rBD1H6iBoXusVJBgMpm5EAnJjzr9oCjM9z50h0NkbFLdXQEfYne5xUUaFCLO2kb3uGFRFCpmgSaxZc35GfZ3RihDPv3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnxMi7P2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533488ffaebso3204982e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725098923; x=1725703723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xL32uT02Dwm3xjWU0uDR6JvTAdhZwWaoQqLWzrb/g1Q=;
        b=cnxMi7P2N6dQdSbVCwpDgCEmkSlXOWpINvly9TmQy+hOCMCw2AcQU/KdVM4oXMFgNh
         XWSnFBBiWUZ8U6wvjHnDR/YwxHE1U+XhUo9ZvhDBvKoiP0WhyG3OqXZcJhqTZW+De3+g
         V/RFr1yxWzx80JC7twQOpcIQREvhYJTHfqC3OdPbmx4NvI6rW8sWOsq+3SJALmWbLNos
         JDMF1zyL5sONkXdo4T1Xr59/8J85FW/1mlbT6N5oQDGlZq8vA1KpO7NQEG/t7szzVMFB
         5xHP9PAoM0D7dePgaIj8UHpVzrVIRSnBDYyueFjrwLApo0teTpb8itAM4U44ehYhbn4F
         i1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725098923; x=1725703723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xL32uT02Dwm3xjWU0uDR6JvTAdhZwWaoQqLWzrb/g1Q=;
        b=RDuCVbGuu1WQN0bIxt7ZCDqUkyUOka9isG7FAMY41DbYAL+1rG8U87Er3520XR3xDJ
         55SGk5gvAj85HQbJydUeROZjvCKsTN30lTNIK2diTG/W0ZBoOaWpyavCX+9rzYBa8cfx
         OSX6vXo9HGEQusXQnn/U4eguqCEKohlVJgHFq0mPL4xRuyJgETLwX/Nij1JKlmKvDGrH
         C69wnbjV/9Vnigg4TEnh89vS59g+7cBbvS+Eud6siOuygug0wokhjNO1QQBuvY8k7JA0
         fykzXCtVQstBSJyupkZopW9ptujk7CAGGBtYh2Z6GILTBR4ANZXi5xX54Cfm1WyYbA6T
         QaDw==
X-Forwarded-Encrypted: i=1; AJvYcCUnH7kH0DQotILMqk/ogxL6qJ6uJKZ/WYouWr3JsXHLbfVXsAUYFcWWtZbXAVrwzy6YWa0xiJMl/49S4+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1y/z2rkfI76V2X6/iKLlakaoCWrj46B/YCysgyC/DYpu53xg
	eyuUnGC3moxhBz84SgSyS1smocuc5hHKql3ZF9r4RWkNOg8zutge
X-Google-Smtp-Source: AGHT+IGUxmjs5WxFUQJb7wPfgODJ7HWZJ3tLpxPDimfNnZ3Cx53baeTmf7TdQZLwqN0lms5VPT1tUA==
X-Received: by 2002:a05:6512:3095:b0:533:4b38:3983 with SMTP id 2adb3069b0e04-53546b037c6mr3152673e87.20.1725098922087;
        Sat, 31 Aug 2024 03:08:42 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aba11.dynamic.kabel-deutschland.de. [95.90.186.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989021973sm307444966b.82.2024.08.31.03.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 03:08:41 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: rtl8192e: adjust size of brfpath_rxenable for new RF90_PATH_MAX
Date: Sat, 31 Aug 2024 12:08:08 +0200
Message-ID: <20240831100809.29173-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240831100809.29173-1-straube.linux@gmail.com>
References: <20240831100809.29173-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The array brfpath_rxenable in struct r8192_priv is always accessed by
indices in the range i = 0; i < RF90_PATH_MAX. A previous patch changed the
value of RF90_PATH_MAX from 4 to 2, so we can reduce the size of
brfpath_rxenable to 2. Use RF90_PATH_MAX instead of a hard-coded size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 1d6d31292f41..8297d7e59415 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -300,7 +300,7 @@ struct r8192_priv {
 
 	u32 rf_reg_0value[4];
 	u8 num_total_rf_path;
-	bool brfpath_rxenable[4];
+	bool brfpath_rxenable[RF90_PATH_MAX];
 
 	bool tx_pwr_data_read_from_eeprom;
 
-- 
2.46.0


