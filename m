Return-Path: <linux-kernel+bounces-541941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF9AA4C39F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7392516EEE1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF0721422D;
	Mon,  3 Mar 2025 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dTJX1luz"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536D5214213
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012806; cv=none; b=NohQySul9iVWPWfzvWae2vkqxBt8eTmsQnDh/rVN8K6AoiUQoGr9RTzYsoDgzPMiwaoE1QDZsY8x9mUQRKpWVIAxVrmPjhRCxXWwafytpO9BSW2uLZfPR6umrSUf5NKfL/ZwaHsNv2GElH7unzvuoEF3L4J/xS1J9DgRzElWF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012806; c=relaxed/simple;
	bh=huTITU+3NLOlGIQKUO1Q57DNwMMY/Xb18Ro9MUcuAZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nw7Vh7FPBcs9G2K4TV8PfzRB+JhvAuzKqCAHivaEoMg+hsd6hXR19Kxf4sOyffp2ES+rp9jE5rTl48UcV4eJT9Q55IxlpqVqW0aFA+1zhHBzqkCAgb5CzqDC3q0VY1Y/wsi6P4o4cBpabLMUAdQHpPPXYwqm6Ns8K5UqxPOvfMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dTJX1luz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390eb7c1024so2512745f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741012800; x=1741617600; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cCvz2PQitaL3G15KvIJkAOr8tNO1gvVwjPom0Ibxufk=;
        b=dTJX1luzeTmtWi+dFz9agN48SvJXrKpiLJhBzXIU4vnMm/QGn9sE1ebGiC2PWA4Vm7
         W+byrAciKvEzUmYrnNZnVTvhN8H0i6Enllf4Um9v5AnDxpbSnnqJEth9ze/KBUntGs7y
         ZeNQENI8t1kg3TiO/bQgBZDoFe/B66F2AwEy9TOEF3e5i99vVIrwmxG2ZWmkyM3zr1na
         Ir69Z7r3ylWpWVLJXEzraoDHnMiWiY0ok8UdcNDiQk8wkB8qGfLWqaulKvAtqX6zxxPU
         nI4N+p0rNJD6T1fInxNHi9IzyP6T5nR1r1P8GgqRZ/N3dlcBrJg93oKDT6vxow5Rif2w
         xgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741012800; x=1741617600;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCvz2PQitaL3G15KvIJkAOr8tNO1gvVwjPom0Ibxufk=;
        b=orZMqdbfT0e9cCHIJ4vMryrAn2SqYRtRDKraIZfaLA19o2PQcRcFASGmj2dmUAAvp7
         oJzFsDM9pMVfv/gcn/Q2HCiwSSAAL70E7e2OTI9F5VnltwvKAY5vcDcPzLxZqUKIIMCH
         Bt38ojNxVk3+FcBI5KJS6DOz+nL/My1rfp4wBbuXIINVKFFiG0dw2v1QwxPTQX010FCO
         7DqcvDOB1Qar5PBcJbr5qtRW1I+uPQh0Di3OUYK/3XjW2lVcoVzS9gNt9fyW532ZRxg/
         4hPhZAqZclxDBY7Vf+CwANnpEHrCS3IrNuJuwpt4XCUeAqI8E90Vfe6lU5UOreJ32Tvx
         E7Bg==
X-Gm-Message-State: AOJu0Yw9NbxlKJumfmPMbZ5RmnYWLGAIyH6oZax12ZXZgnuCxg+Iv8rt
	D4B7HjhuuMcCd5YSuGz/MHnQ0Yxy8v3pQsI7mzhlhiSUGv3yNXDZ5P93EuYf87Y=
X-Gm-Gg: ASbGnctf8MbbSZY8cXfY2IdKxcDCjb/lIBvvjRFWF7N4nNtNXionwePyTUiKU5PFfes
	WsikGXlVP4/6p4Iey2suDrjyCrfsK/W2WmdhzVAx/l+LpDrwU2pras91W+B1+2M2Hu6RAs5Wy4/
	yGLP5DGrA86PLgN1LRFK6UftWIYjHNmBRNOzeABP8UvgL/TCr0ETafUWOApkouiFw79xnS6UsWU
	neE3x/I5rPPt08BPfPHQDrrHoVJJcKU6jEUtOW4+nDv/RAi4aWon4PnqjdGZYnGQTQbUNnsGhO1
	lKnMMCp+F1IL7vD30fgbrv6y1fHtq616XXRoeEpJ0woZWDOcJrKsPEhDPVdebnKqeHzxhDwfgfb
	pFa3Dr7Fk0N6/l2WnhnEM/OCCLh09
X-Google-Smtp-Source: AGHT+IFGoay4YJM6YSXz0DZ05o3quafyCNLOWh8vQu4Eq4apk6qCX8ogXLL13gs5Zle+ply0NrLrLg==
X-Received: by 2002:a05:6000:1f8b:b0:391:ccf:2d1b with SMTP id ffacd0b85a97d-3910ccf2dcdmr2532910f8f.49.1741012800564;
        Mon, 03 Mar 2025 06:40:00 -0800 (PST)
Received: from [127.0.1.1] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7c43sm14394801f8f.49.2025.03.03.06.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:40:00 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 03 Mar 2025 14:39:57 +0000
Subject: [PATCH] MAINTAINERS: remove adi,ad7606.yaml from SEPS525
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-maintainers-remove-adi-ad7606-yaml-from-seps525-lcd-controller-v1-1-a4e4f1b824ab@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADy/xWcC/x2OywrDIBAAfyXsuQs20Qj9ldKD0bVd8BHWEFJC/
 r3SwxzmNHNCI2Fq8BhOENq5cS1d7rcB/MeVNyGH7jCq0ahJTZgdl61D0lAo153QBe7YWc34dTl
 hlJqx0drMaDD5gL6WTWpKJLhYG7TXSzTaQY+sQpGP/8DzdV0/McmlB5AAAAA=
X-Change-ID: 20250303-maintainers-remove-adi-ad7606-yaml-from-seps525-lcd-controller-b77d4c4bf54a
To: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Remove Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml from
STAGING - SEPS525 LCD CONTROLLER DRIVERS. This was likley a copy/paste
mistake. There is no bindings file for SEPS525 since it is only in
staging.

The removed file matches Documentation/devicetree/bindings/iio/*/adi,*
under ANALOG DEVICES INC IIO DRIVERS already so wasn't just misplaced.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This falls under FBTFT which is currently orphaned, so someone else will
have to volunteer to pick this up.
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0e33544fa373a4978b7dae18c040c..215dbaeedced8473b5b339329b3596a2fbfd13b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22512,7 +22512,6 @@ STAGING - SEPS525 LCD CONTROLLER DRIVERS
 M:	Michael Hennerich <michael.hennerich@analog.com>
 L:	linux-fbdev@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
 F:	drivers/staging/fbtft/fb_seps525.c
 
 STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER

---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250303-maintainers-remove-adi-ad7606-yaml-from-seps525-lcd-controller-b77d4c4bf54a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


