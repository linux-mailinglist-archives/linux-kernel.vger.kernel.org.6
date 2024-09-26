Return-Path: <linux-kernel+bounces-340318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B056B987180
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678A81F21D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29CF1ACE00;
	Thu, 26 Sep 2024 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyrUtu9B"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A80171675
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346505; cv=none; b=qK68A+3N9sZ6n7raFurugbkgdawerpH9GKJpFzwaaIV3XcuL32NKIBQpaJL53gMovK5bltACxxluN8zHNBD6JiY6BazJZraUe2UE5ByUpnVIkWZil016HYHAswWIfiTNTFvkmJYNpboD/mKIz24Kr5pzs8Js422gCiTJ30m283M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346505; c=relaxed/simple;
	bh=OU143TY6VU2C/dXSY66IOaY6h2HGNeTpFeyFwdvRQ64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FMOgUKS90b3ja2qXtGN2oVbKQAWTJdwj8saIMDBbHuZlfIqmnYhhqEtSyhziMdwt1TXdmYiJkOXlbPacIQ1pdNwZuFQhE5OLeIqT0wkgKfCJSgnUxvFXfiw6gM3Xmxpb5ZjStx01wRQS4CKDLJvtf6/7XoZoI8Vjy6cGl9ADnT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyrUtu9B; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so880952e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727346501; x=1727951301; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0UGHoMTDM49a9EphF+PdBOrdwDG91tB6VUJ+/2b2OUA=;
        b=OyrUtu9Bzhl/wcyYrJsADO8f/yx8kLvdqUGkesaTVnYIuPBjNNJJzXrIVtG41PTN5l
         Eys/HoXIrFc4t36+sizHzjd5w3dcBv2GvHCVmQzxZRFjk6CDXm1RqmFyi/dQvCvc4zSp
         1GaYWFX8ORGzUmw2zTT55PH0KVAWBs5fkzivO5i+/x+8hpunCTHsMV7GfmPmtiHjsXSP
         1smbPKdPvZz5s1bdfICKPhUIKiycjuYHpxecbtvnum3H74eB8g4o9nUkTTKqUjypDIn6
         L7gLsn8RyXmpU8nLMO+oRlvqPWpsWk1dZ1LHcZb9UsPthXOO5D04OLZwiUXGm0tB27iY
         EQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727346501; x=1727951301;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UGHoMTDM49a9EphF+PdBOrdwDG91tB6VUJ+/2b2OUA=;
        b=EXJqtKTdxVLj5ZqqbgqC4FdKLT/sqTHRmXdaqCm5ytKyJudPFfbTnzq3G1VNAE1zf7
         RStm4+jobo2dALeDnKCt/Qamy2Lke3O07mZjUQymu6/E91GBQ6huEp/18P2V1bcZkk6X
         ZjYEWQudDpGZs+HEe2+Xi/PLW3S6fg1Flc835Ct5024otkc0sp7J91KR8kwsHWNRpJ9Y
         /LQs1U9XcRpwsT5l2nQGmcf9QEExwMWz1g4oXH2XCpzUyQ8OZrUCtSx1hRcIguz/H/zG
         1mdFF6LkNfUIzgmzkXc+LFJhTNUh5Btja0O6ZvibSkZNxzXzzA4ysgaMpNmTnzvbaCYj
         qUMg==
X-Gm-Message-State: AOJu0Yx/H9Uoh2SYppLT7I1qGx0lXhJu89bJqjqXqUZlprtM3W5ks1tP
	L5bLeuCk8NQCq40nCfobhRb6tUhIeiwZA4DuA4O/5xLZYvP9OmBX
X-Google-Smtp-Source: AGHT+IGeWRIBo4qHrx44jx9y6GpEbbl8WMB1q6kdNYFIVyQmUrunBVkMVu26IXGg6eg5qqa0Tee4+Q==
X-Received: by 2002:a05:6512:1313:b0:536:568f:c5ed with SMTP id 2adb3069b0e04-53873455efemr3608607e87.1.1727346501239;
        Thu, 26 Sep 2024 03:28:21 -0700 (PDT)
Received: from [127.0.1.1] (mm-20-1-84-93.mgts.dynamic.pppoe.byfly.by. [93.84.1.20])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-537a864e29dsm763543e87.289.2024.09.26.03.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 03:28:20 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 26 Sep 2024 13:28:10 +0300
Subject: [PATCH v5] mfd: max77693: remove unused declarations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-starqltechn_integration_upstream-v5-1-125d9228d751@gmail.com>
X-B4-Tracking: v=1; b=H4sIADk39WYC/43O0Q6CIBQG4FdxXEdDULCueo/WHOJR2RQNkNWc7
 x66tbqry//fzvefBTmwGhw6JwuyELTTo4khPyRIddK0gHUdM6KEZoSnAjsv7b33oDpTauOhtdL
 Hm3KenLcgB1ypghc5qWgDDEWmkg5wZaVRXYTM3PexnCw0+rHvXm8xd9r50T73NwLb2vdi8XsxM
 EwwsIZzTkkqpLq0g9T9UY0D2vCQfcBTyv4AswjSmkJT5yovhPgG13V9Ad5rAaM2AQAA
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727346499; l=1400;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=OU143TY6VU2C/dXSY66IOaY6h2HGNeTpFeyFwdvRQ64=;
 b=MPr1TIN9f2u3Z0RD7TYEeL6SOWQcxPtYZfHAeD8ZC6WhFNqzppXq/k7Fh7k0OxJMGAw14vXtu
 sgQ335TrgZHD+JDkfhi1kzwfyCntDQoBNVKbkX5UrpgPy9u5U0GU8mM
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Remove `enum max77693_irq_source` declaration because unused.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v5:
- Split patchset per subsystem
- Cleanup unrelevant change logs
- Link to v4: https://lore.kernel.org/r/20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com

Changes in v4:
- Link to v3: https://lore.kernel.org/r/20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com
---
 include/linux/mfd/max77693-private.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index 20c5e02ed9da..c324d548619e 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -419,17 +419,6 @@ enum max77693_haptic_reg {
 #define MAX77693_CONFIG2_MEN            6
 #define MAX77693_CONFIG2_HTYP           5
 
-enum max77693_irq_source {
-	LED_INT = 0,
-	TOPSYS_INT,
-	CHG_INT,
-	MUIC_INT1,
-	MUIC_INT2,
-	MUIC_INT3,
-
-	MAX77693_IRQ_GROUP_NR,
-};
-
 #define SRC_IRQ_CHARGER			BIT(0)
 #define SRC_IRQ_TOP			BIT(1)
 #define SRC_IRQ_FLASH			BIT(2)

---
base-commit: 92fc9636d1471b7f68bfee70c776f7f77e747b97
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


