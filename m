Return-Path: <linux-kernel+bounces-246863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D911092C822
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB8F1F23C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18A38BF7;
	Wed, 10 Jul 2024 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmRc/c7/"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB02C80;
	Wed, 10 Jul 2024 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576588; cv=none; b=QTOClEanT9H8Cs9+lbq1NEKNC4D9qVZgE7fqzHxGMmKtELefOfHIz6xTHwGwHmfaMyYdmg03MH//cBizjVPdu/yfDPvYCIlL0Su0nLRcu7bJ6GbKZ5iVDRPuFzmVSuucdP5CJo6U7GLX3HSYTxdiV+R4TLyiaaHWmMU2uGNle1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576588; c=relaxed/simple;
	bh=4c8Hv+dhG+AYplc+VLWoT1bJ74n8Hva4M8qP5Lcpidc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M1Um+H5+2y7TyxXdwCCHGVZLfx1LaHf6+XFrO1EJSDeFrxt+ZDK9pEe2ePWnsgHu0L8+4wuKYLtqAYdowTe99dZchxzbXjcHEdCrrM6lwa/Z0m2UKyuLlC1XxrR+U11JZFQVJTSl5pcDrcY3Wki8iTBsPB/8A1BxQRuJX+Xb2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmRc/c7/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b0d0fefe3so3057228b3a.2;
        Tue, 09 Jul 2024 18:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720576586; x=1721181386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=enW4cQKf7B4H11t1mfNT7cdVujNpDQzYO6FACNhVkX8=;
        b=EmRc/c7/FrZPywldeqOUq6b5vA7TEyjjJNN4352gXxkTGAM9t1QQqeWXSzzo3Iz68P
         dM12ttBNh2YV3pdfJaIEYNgyUcqA7ZP6htiMhKA1cv5TjIFI31mqdbVK9P+LW5sTd5Hb
         o/St6V6BkPoz+DL7WkaaYTepcZyYKllMfbAdPlC4f8MyAr0YR2cHXKcRXk9P/uwX/t6u
         UXQXxRztnfL89ic9ulpUhhIqmYnLGnFvuTO7QyC84zWhu98jm9DxCJ5FPwgLOrhALPDZ
         blPpLwovVRHMKQBcsohmqzpU+YgCB59BuuU6eWmtTfWTLExpef1PqQr5SjH60sdjE5MI
         i5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720576586; x=1721181386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enW4cQKf7B4H11t1mfNT7cdVujNpDQzYO6FACNhVkX8=;
        b=XatM4K0SId80KPtx6U2XOnUplCyWfdxmOr2fbp8JqXx7C2ve4VFGxIKbQW2BjhG1yp
         Q7z6H6F6B0Mff+sTFuFYcMfqsqfF1x+il4Idy0UTh2SAfbx0GsbQVgk8Oq1rQx/ZY5oH
         6PEh6OeeR8ysjO1f5ucenBmpW+jhFKCUsnAvhk4schL2ZIXv4kBQ0S5Rxeltu8384DKk
         kNlit9Slbvnlii/gq1V1l3PagQwTkpVHnMJZesfWohvhkBYOsPoDuKP23kN5FZFmOLa0
         HNetJnUAJ4+VfAOie863xYZqUmr2fonRtcLvbIZ9UM5uYb4F0PA/3pCiDlRZZ8Z0kaK6
         7U2w==
X-Forwarded-Encrypted: i=1; AJvYcCUBK4/eyNteFsGTbB4IRqDVDPz/M9rctKuvw2qgJuOHcw2YaVfcJqWq+RIVMrUkJWaLgV2wNK92xyB5fVGccl70jUK+fR/bVrARGTue4YxF4fhPTn2uQzUBQyRyrl2JzbqJptdl3C/DTs0=
X-Gm-Message-State: AOJu0Yx2woeEI0vSDpWOMRM0H5Gpkqs7io9fmrMd91GPC3VZEvHi0Tjw
	fr2TnLxerp+K4Nt8iNLLLdQvkskzIc3+1yfUqSl8tqhIjnQ3kktpImD0OQ==
X-Google-Smtp-Source: AGHT+IG4KqeNamkilvotkSQf0ix2WylzIwLgFGaO5x022D41uRLSeUhbNZCfsdzUylEMxw2tHkPCTA==
X-Received: by 2002:a05:6a00:2da0:b0:705:ddbf:5c05 with SMTP id d2e1a72fcca58-70b54edb0femr5858b3a.11.1720576585821;
        Tue, 09 Jul 2024 18:56:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c25basm2527876b3a.72.2024.07.09.18.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 18:56:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 0/3] regmap: Implement regmap_multi_reg_read()
Date: Tue,  9 Jul 2024 18:56:19 -0700
Message-Id: <20240710015622.1960522-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

regmap_multi_reg_read() is similar to regmap_bilk_read() but reads from
an array of non-sequential registers. It is helpful if multiple non-
sequential registers need to be read in a single operation which would
otherwise have to be mutex protected.

The name of the new function was chosen to match the existing function
regmap_multi_reg_write().

The first patch of the series introduces the new function. The following
two patches provide examples for its use.

----------------------------------------------------------------
Guenter Roeck (3):
      regmap: Implement regmap_multi_reg_read()
      hwmon: (adt7470) Use multi-byte regmap operations
      hwmon: (tmp401) Use multi-byte regmap operations

 drivers/base/regmap/regmap.c | 103 ++++++++++++++++++++++++++++---------------
 drivers/hwmon/adt7470.c      |  22 +++------
 drivers/hwmon/tmp401.c       |  19 +++-----
 include/linux/regmap.h       |   2 +
 4 files changed, 84 insertions(+), 62 deletions(-)

