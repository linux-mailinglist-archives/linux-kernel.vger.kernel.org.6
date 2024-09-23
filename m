Return-Path: <linux-kernel+bounces-335825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B3C97EB39
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8AE1F222D4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4628199244;
	Mon, 23 Sep 2024 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgr+VP4S"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF30199225;
	Mon, 23 Sep 2024 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093010; cv=none; b=EijbrhOsP9ResJe/tO3yRtOy1G7vOH0oc/M9Cee9zrvLE/KJpfOhvz8N/vlmLwoXKGshN1l7YsVUBJUg5w9dS04zCgsSbFIYBiZrQ6o51h4CLCFA17iOdwjNiqDBMCMD4EzOjlDDcjhVAsKvgHgd+/aMczt9N96K5MQhuYTVjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093010; c=relaxed/simple;
	bh=DEujSNE8kA8NV65w//k0ciqJySctHjom9KmancTFR2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=On60N5Fmzu1vhtAGH3nZLKCVXWSIf+zcffHeGSDv4IS9bEaLgZwT9syPmYhMB0DktIhr5g+Ll9sv9UwxYdgJuMZH1LaPuzwP4ITTLJZWDUEmflYXI56rwQxsy7af1CpkfeRtiDVfyUEZw3hGohBuBmEYc/0JXjkYL0JH0CXcgWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgr+VP4S; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so602065766b.3;
        Mon, 23 Sep 2024 05:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727093007; x=1727697807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr9QnQ/SHVC3jB3UzK2Sen0r7Hkeve1Iojahm6TuF8A=;
        b=dgr+VP4SQ9U5h8+k+a6EsgxgLsM2p6UHWfzC3YNBbWL2n5Ui1U7g77y4I1K3eRZxHF
         SootqJomo3RwBTcdumJu56pdaICaJPa+JZPMOZycmQQN+wYpCyy5kbI6AgUGnJfJSyu4
         2rpouNL+5esd45rHBIlkmLLd31XfUiaalvFsdr4gSN6bEEkFGL9t0Fa6ZfLNj3R5bSOy
         MCqsNaHzMe5L5LQRL4puoEvfzb1W15qrF40u8YdFzbz18CSm71taEuBs4uANieDw3wsf
         uEmddBy3Cmv6shOxHu44l22ZmtRwY8MgWZ+yzqYFtG7ykcfGy67TufKtUlqP5M7+uWbC
         /9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093007; x=1727697807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rr9QnQ/SHVC3jB3UzK2Sen0r7Hkeve1Iojahm6TuF8A=;
        b=VJl9mgL31o9fX1x/R6VIMKagQWwbuXSmh+Dwz7UfetqtlnwGi7mEUt9xvLlfZCNKlm
         oLagZrZRF+CkmHi6p4Paia3PS1prkmxkH2T2q7WVEyLdtF5B9kiN3p2T98tqwwMsUEF4
         bPJGJFYrdmySKv8JPu20EVHHvumxA3PZFOGUnW2dBPHvRXGDKBiN2k7DpSe5ctFjMp8w
         mGdoZMsq5kcMNHiuCjb7ZbAnIDEfRCCwj2f4a/SZO0FW8lXa0Y8wppMsOG4a7mi5GAAk
         imMKN2QwFkf2cTKhmxKxqE1Z5eL7mFPaZd/OvMreKusEum+XSI2HrbE88Alx2fuilsEh
         Z0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKDhL5CFIlr7CkMnAV4ln0rnxaaknoa3ntpbNIjKeEMgDF2b6EuyP2HBMPqIwZCrhl0ekHzi8/ZNpiogo=@vger.kernel.org, AJvYcCWbUsP2ZzfQVjFqyHJ4oZQv6J2He1exNlMj3pop2kYSK0LQajsM5n69j2+5PYLs6qay19tdYQcjhj+wboo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3pzKMJ1Evm9a69pEVC0sA2qTnLZ5BSsTN5Au0U8to/mgLfgb
	YkN8Uxew16Jhci3HIHXlsOFklN0wk07DGs9SXGPlNetNxwS89o6Rn1hNyQ==
X-Google-Smtp-Source: AGHT+IEd8tPFmHQIiQluni3R+3wOabQk+sCenIypIJCUXuYD75ODe5sssnM+7HL1z5WGglZemg94GQ==
X-Received: by 2002:a17:907:d59d:b0:a8d:345e:a0ba with SMTP id a640c23a62f3a-a90d4fe65d5mr1102181266b.15.1727093006631;
        Mon, 23 Sep 2024 05:03:26 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096689sm1216210566b.27.2024.09.23.05.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:03:26 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: aw88399: Fix spelling mistake "unsupport" -> "unsupported"
Date: Mon, 23 Sep 2024 13:03:25 +0100
Message-Id: <20240923120325.836918-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/aw88399.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/aw88399.c b/sound/soc/codecs/aw88399.c
index 8dc2b8aa6832..f3d4f13e6aed 100644
--- a/sound/soc/codecs/aw88399.c
+++ b/sound/soc/codecs/aw88399.c
@@ -462,7 +462,7 @@ static int aw_dev_set_vcalb(struct aw88399 *aw88399)
 					vcal_k * aw88399->vcalb_init_val;
 		break;
 	default:
-		dev_err(aw_dev->dev, "%s: unsupport vsense\n", __func__);
+		dev_err(aw_dev->dev, "%s: unsupported vsense\n", __func__);
 		ret = -EINVAL;
 		break;
 	}
-- 
2.39.2


