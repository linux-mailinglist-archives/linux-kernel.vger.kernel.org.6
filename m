Return-Path: <linux-kernel+bounces-309816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8779670B1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC5F1C21A0C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CC817C7C3;
	Sat, 31 Aug 2024 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDgKEfus"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E717B50B
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725098925; cv=none; b=aQ3OqMeHscP5T+IYTD50ZIPsVLJAo2zS+G7POxryUugn2dpT5qbEtnCjkTfCxw72cLPYDful6bxzNBVJM8krQ+N2f8nIDXjPSQaKfBzVAjo5TZViPWpRe+nftivy/QoijosSRn3ye78r+KYg60NUBb13T0lU0WmGRo2SEB/Zxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725098925; c=relaxed/simple;
	bh=afvgwD9TDf32Gw3SlmaMTnwOeQpet4+7Q2yjBfU71rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifnNlBLoh0FZNf39SVS8U1L9UU6u2I/no2uzGUzXuqYsWH9arI2ewq+vlZ+JJV9TUiWhab+eWX2W+cr9Px2+pa4UnOhZgOvqXoHwyuFZOBo4qxPzAZAPLn8i4izkz9/1cloMUzF2bsxnSxzZB+iyAYSnneOZJi5czW6rT3EVHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDgKEfus; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86acbaddb4so308716866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725098922; x=1725703722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3o7LRK+qA1Rp3EETX2MMU4qubCapxq/bZEDMNP9rdI=;
        b=ZDgKEfusFL89/NLK+9+mtn0rAG8ioxn6IDR8H0YuZ+HM3N6/YKmMYsjflvc3+HzuaB
         aIhymGUO/Kyws6W9IBmBHbjaoAbew5SQirY8YCqxakbY1arRN83A6gbyiUOjQmgCpV80
         ZclO0s+HQi8YQtf2PZGuECza/sNqjrc5FOB4qLIxwiOPRrkEhq7Gcpt9JJAN6TFaQWrM
         FcptluLm6rcz6FvKgeTgDn1sl3CKZ1ikVm4dCKFm0sQ0QtbA/mbzphTMRc6aZYtCTO/V
         8T7NObilQf/r/S/UeLL+6ZSpGVwlRZbjH72go5iesaFpDz72iEzT257cAQj0oXEmH+EY
         ekeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725098922; x=1725703722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3o7LRK+qA1Rp3EETX2MMU4qubCapxq/bZEDMNP9rdI=;
        b=G4ijCKBsSV9R5jDJ9H8p7PWS+/mRZroPzmlCW22mG0N7WAvxdnZSmTYrIFihfYqr6j
         1gfXlSvmvMHzw9fPRFyHDfobNAZxJPU5CyOe2qqlmPc7g5z09Ipa/1XaKdWk+g780ep0
         2Sx095/V0z9q6RumGfeWN5YEKIhXj2PvTDv05GLdbwrsNUn8diqrvTsWl11l2lKeCz8U
         U+cbCRZCQ9G/qupghv5jceeniwr2B+rDxy7xTwx8d5ki053yKJr33QE5A5IDOG9V6JiX
         jBsOuQ/exYdIslhKj4uWcKZKfJqbz0s+X2y04Dh40uf3Vv+cSmqTYNu+I0MNlxAb7Ogk
         0hvw==
X-Forwarded-Encrypted: i=1; AJvYcCWxy1bP4kAp2aUG+AykPEWhSBLiNEpUToxkSSw3Fc5s6eQ52naXqAhy+5w03l8gWVeKK3Uo66rPRYc5HuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPfzk63TDGGB1Z9l2MlQ/EabPNkZTjthZd2VlnNnAUDa73DryD
	1rL0p67JwP9vueh+hy/nKhdQtPiSqaudx8ahM2yLikpD7xWHrl7+
X-Google-Smtp-Source: AGHT+IGwZ7KLfT/QNzkcxGy6HWmXFg98Q0DBkWJNKwbafcC3uk8+tSBR3nd/IrW6uVulfgLLx3aO4Q==
X-Received: by 2002:a17:907:6d2a:b0:a86:8191:b81c with SMTP id a640c23a62f3a-a897f91ff8fmr560356566b.31.1725098921622;
        Sat, 31 Aug 2024 03:08:41 -0700 (PDT)
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
Subject: [PATCH 3/5] staging: rtl8192e: adjust size of trsw_gain_X for new RF90_PATH_MAX
Date: Sat, 31 Aug 2024 12:08:07 +0200
Message-ID: <20240831100809.29173-4-straube.linux@gmail.com>
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

The array trsw_gain_X in struct phy_sts_ofdm_819xpci is always accessed by
indices in the range i = 0; i < RF90_PATH_MAX. A previous patch changed the
value of RF90_PATH_MAX from 4 to 2, so we can reduce the size of
trsw_gain_X to 2. Use RF90_PATH_MAX instead of a hard-coded size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index d87bace0a19b..de0cd40df25f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -8,6 +8,7 @@
 #define R8190P_DEF_H
 
 #include <linux/types.h>
+#include "r8192E_phy.h"
 
 #define		MAX_SILENT_RESET_RX_SLOT_NUM	10
 
@@ -137,7 +138,7 @@ struct tx_fwinfo_8190pci {
 };
 
 struct phy_sts_ofdm_819xpci {
-	u8	trsw_gain_X[4];
+	u8	trsw_gain_X[RF90_PATH_MAX];
 	u8	pwdb_all;
 	u8	cfosho_X[4];
 	u8	cfotail_X[4];
-- 
2.46.0


