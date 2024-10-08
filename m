Return-Path: <linux-kernel+bounces-356071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA579995BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7A11C20C91
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C01216454;
	Tue,  8 Oct 2024 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="NKpWF6O1"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57A1D040B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728431142; cv=none; b=qAXkHOmJ8XCKNl3uvqOOhaNDOtdGT7FZvox9cWchUqAH6R9Zosv2naTPuoZqEQXXgUQoHrJWOldRjROJq7AQBPdzofSQsOgptWVIRIsODx664eYU2HWpbHw2sdkPIDSIV6kLy1frnDWnZUGuV5z2lDqIRgyKfsPBC41jSBbgqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728431142; c=relaxed/simple;
	bh=bCZmzTMm1fduflRwYohg+qsNUnboVQ3kGZV0ddcyoDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ph++0I+9So8IMTN3ISthADqLjVQIedHsRyRTX04d/P9pDgK4/5VW4eqZobn3Aqp6aV05YaJILnVjyvn7btkdV5dKonN+V0/xYCIGTQP8msmNYGJuNSuG80fy/OMwPTelYx7sYXndLzknymQNoeDr2z5dBvXS3eIzMSst/iwB280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=NKpWF6O1 reason="signature verification failed"; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71de776bc69so3111306b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 16:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728431139; x=1729035939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F6zDPvO9jWfZI0VBRyJNJETUDrhSoVwHfhfz7RdGzrU=;
        b=NKpWF6O1weanghbV5QMXLgYhFpAPAEgH+PvRsxvJk9fbMlK6yWB7khgLxJcCn3B5js
         WwlezYs0uD1gvPpuckKlq3kx6YOGayp6jidua0xPvFoKPwFwy5zGmyxIng9jyxiTiXD7
         tsZAaW+BqYmfPzwsw4U9zJsEgOoX9cfcbpMopoIFP0CGpLZYTGqlH0Hzk/oaEgSCFaJG
         kP4M57Tc7HkwBltRkQEyFf+j5fN7tW+oZzFWxSDolI41zFg5oIxFqHdbw3AeeRpOgIvp
         dtCiVZCltOeYq2u2ib3RB0xJjZFlls7pnREjfZ06g9PtUjcJNR8YKqPp+FtY3LTPTPxA
         DVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728431139; x=1729035939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6zDPvO9jWfZI0VBRyJNJETUDrhSoVwHfhfz7RdGzrU=;
        b=SIoPzcuwdsqT78J2pvR0blXu3z9ynmR0gBZ+TM7JIXykOVzSO/Ch8GPiQ2/UP0jJhs
         HK3/kwZ5ISbQgNlcE/XkVnOR0GJaJSH5QsHjD1VmF/sTF84Ei54BmmKg+eZSLM1uAYdi
         ITAqFg8KJ8cFW/c2zW4LS/Hdt3HQVSbp+QCeUTbQFEcqXIj0VU1HAEj/dhCuFErw2N+R
         7w1RQWpjDk2tzFa+OBgiqBxymVB1O9vArAeiC0hHPxfI9JpVGPWulAgJby2eIJXONV3+
         Si5lPBVr21uPUexgco3Jhlyx2J/DsUN+umRME8Ml/NqFGz4kJg3BaY+XF7EoyEEGnrjE
         4lkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHnNxRLEV+XA+bV5zTjUjIDRuDLtfWvb2NWQXP1WZ9r73TjH3/IjCw8db5O19uW/HN5knrvtBCipoNMZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7NT807pBwAl6SypQuZFg5K1+pbjQYVJtxI/is+StdIgyONjAd
	lsSeo6lYWtP6NAcPr3bVhoNqyWndO+oVmSlUuxdlt4fkS+QY50/GCXHVlD3XiOSbsrW1R8UYYBR
	6sYS1xaO8
X-Google-Smtp-Source: AGHT+IHk9+tlA16Su1ssevBPWt5oHpt2DeyaQ9HKDjWn0d/+7kP5lBTgDq9UsaTWDOpbj8k3ntKUZw==
X-Received: by 2002:a05:6a00:2eaa:b0:71e:bcf:454e with SMTP id d2e1a72fcca58-71e1db67325mr922826b3a.1.1728431139159;
        Tue, 08 Oct 2024 16:45:39 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.223])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71df0d7d06dsm6634651b3a.204.2024.10.08.16.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 16:45:38 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH-next V2] ASoC: rt721-sdca: Clean logically deadcode in rt721-sdca.c
Date: Tue,  8 Oct 2024 17:44:20 -0600
Message-ID: <20241008234422.5274-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the same condition was checked in inner and outer if
statements. The code never reaches the inner else statement.

This issue was reported by Coverity Scan with CID = 1600271.

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
V1 -> V2: - Updated the patch prefix to PATCH-next
	  - Added how the issue was discovered 

 sound/soc/codecs/rt721-sdca.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt721-sdca.c b/sound/soc/codecs/rt721-sdca.c
index 36056cb7a3ca..4fd26e490610 100644
--- a/sound/soc/codecs/rt721-sdca.c
+++ b/sound/soc/codecs/rt721-sdca.c
@@ -611,13 +611,9 @@ static int rt721_sdca_dmic_set_gain_get(struct snd_kcontrol *kcontrol,
 
 		if (!adc_vol_flag) /* boost gain */
 			ctl = regvalue / boost_step;
-		else { /* ADC gain */
-			if (adc_vol_flag)
-				ctl = p->max - (((vol_max - regvalue) & 0xffff) / interval_offset);
-			else
-				ctl = p->max - (((0 - regvalue) & 0xffff) / interval_offset);
-		}
-
+		else /* ADC gain */
+			ctl = p->max - (((vol_max - regvalue) & 0xffff) / interval_offset);
+
 		ucontrol->value.integer.value[i] = ctl;
 	}
 
-- 
2.43.0


