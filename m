Return-Path: <linux-kernel+bounces-230167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3012C91794F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6222845A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D0015885E;
	Wed, 26 Jun 2024 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk/2w8Gj"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87CF1FBB;
	Wed, 26 Jun 2024 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719385440; cv=none; b=FYIdhcwLxsSUGAU1b8Llv26vyfYvU0g1VwfWubUKndaWi36/Ui1aHDbuPKjNrL3Eza21/cAX/2IEs/ptbyxAUAXosJDwobEXYAXfDIptG5JZjI7j1C/E4zngnBAQwzwA0qJMUVDCdluEfwtILRirGNbgL6GKFe0rqoZg50G8Yvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719385440; c=relaxed/simple;
	bh=yhiDsGtckWbJdiH+m4+tg0FxsetoSjM547eWaMzugqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmE4g+T4FstsO0VJZj2CJf+7Ha1wjUmIUzHhFS8cAyADkno2OMp+AoKYS+LLojri+ZmFInFTB6CXjfR5fwk3PhebPvyKmvPp6VGd4uactZM2gZwJvkmkwqIVEG3OlkV10M/3tamrekJAZkOmmaVa0zJwwFtJEsWYLITZ0TPaxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk/2w8Gj; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d1782679fso7796732a12.0;
        Wed, 26 Jun 2024 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719385437; x=1719990237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCmw9U2ETNDBLBuD2pt2tF/w6GsMBw1zovesQGm6nj8=;
        b=Dk/2w8GjuktBoRbBtDNRVWM6zPNNdvqXS/cDLan8zbYRM1BtGj16Mc9ofusu0dbjYY
         +EzLnbOZlfX1CyPFCzj2owffYtgORvJ3uTayz/ptHNcInp7WsKEZ8OcywtF1nk0UELp2
         /WGicI0lSB8ABZY84A0DGZ/pXUkRxiboQz/9XSPifjKnboeuTaSv4s/lQ3OcK/2/nYrl
         NLOErXnd8TCqGVkKmR1/hk10DuLhrByDTBdLfAaSYfisECUmvvTZQywN8Boum4rWJm5v
         4wwIeRt5ElSajzjhS5BcYeZe6fys2rmpfqZFmM1Tra3uFNqd8KUl/SM72yvdGN46esId
         rFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719385437; x=1719990237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCmw9U2ETNDBLBuD2pt2tF/w6GsMBw1zovesQGm6nj8=;
        b=nlYCOVu7If4xeLshVGd3kjY2PWEIRRHG7PmSyg5tFHdNaaeWWWibVXrtehkLig02Zz
         JoeK+mQE85DA7oPneRRc2mGpvjE0qQimija6e2iHFcT+jCBHaleuzGvAIIVqW7zG4LCz
         La8ROTkrAscs3slw4+oB339Q8jIPTB5j70qKwojSZ+Agx2X+VYFIEFu5dQvDH3YQ63+n
         ZkRhld4KdUa36HoQFnAWg+cFp/3X39PWitqZaLn5RjodOSOJI37r03SQeveb0tLNhXXh
         n1TxjDUx9cBkv3pQ6BzuDbaawOXr9hgnOzzS4ErZZR+YGOxxE9mBVa/BBILtiglZ4O1M
         Crxg==
X-Forwarded-Encrypted: i=1; AJvYcCW/N+ICDDbBK8R5sGY+MogDqkVVQ8c96DXEPMy9x4um1PqkAbCbrpLDBA+CyOgYM2UzNCPfWNo7cpq5NZx/OD3V40ZCOelFIlEC8e/E
X-Gm-Message-State: AOJu0YzZ1CoKbJEL2Ga2/BMv8MCQqTCknu12eYVjMg+k/qKLKap0wYUJ
	U8d5+BxKMwYVs/IrdJdS5CqHTwcjN1c2zv0SQLPeKqRbBGROE4W0
X-Google-Smtp-Source: AGHT+IG+YhujMvMhvhUyfqCcrHDikxocG4QadsjpWiXNy+jvs+ekjSV42yHz8cqiWyCcSzweRbZSCA==
X-Received: by 2002:a17:906:c206:b0:a6f:adf7:b073 with SMTP id a640c23a62f3a-a7245b4cccfmr612328566b.10.1719385436674;
        Wed, 26 Jun 2024 00:03:56 -0700 (PDT)
Received: from localhost.localdomain ([95.67.7.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48a038sm582582966b.48.2024.06.26.00.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:03:56 -0700 (PDT)
From: Vyacheslav Frantsishko <itmymaill@gmail.com>
To: mario.limonciello@amd.com,
	broonie@kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-sound@vger.kernel.org,
	itmymaill@gmail.com
Subject: [PATCH] ASoC: amd: yc: Fix non-functional mic on ASUS M5602RA
Date: Wed, 26 Jun 2024 10:03:34 +0300
Message-ID: <20240626070334.45633-1-itmymaill@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <0e571211-8921-4548-a093-6c5719c866c4@amd.com>
References: <0e571211-8921-4548-a093-6c5719c866c4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Vivobook S 16X IPS needs a quirks-table entry for the internal microphone to function properly.

Signed-off-by: Vyacheslav Frantsishko <itmymaill@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1760b5d42460..4e3a8ce690a4 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -283,6 +283,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M5402RA"),
 		}
 	},
+        {
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M5602RA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.45.1


