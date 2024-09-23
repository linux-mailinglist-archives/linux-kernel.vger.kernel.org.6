Return-Path: <linux-kernel+bounces-335835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A897EB54
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448F6B22305
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320DF199389;
	Mon, 23 Sep 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1HXxff2"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D0762D7;
	Mon, 23 Sep 2024 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093248; cv=none; b=kF2BnOroWCrkB8yfZL3zwpgrHDrGwAVdZ5hvrgYUenfAnbZ0LLzegcCdPp0QgVu+ZJyPbgaETNBAs5ZpjzHsTD0gdtoDLtAaj9dDRI/9vlV+a8skKWV/75+Wt6+LlG4HFv2DSknvRHneTMyIEsRZqeC8GLp94susCAONjgniJ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093248; c=relaxed/simple;
	bh=tp69qkZuFp099uNTWrev/5jOvomcaR9ejgZV8mgWssI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bkSPPFB89atpEGGtBuXYi8usQ1tBUxdSbEMHAiNGYsO4iouMfNxz/vHbRen0dFjDoN4tKsN8vXxcLMXzRlDwHXaRxesw6VVcaihoD3ldk618IPdp7L7v4j0wOvFueTcfQ0i+3RdBKJn9zLV/tGnlLExT9VjWVImYAPH5vuSLMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1HXxff2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9018103214so621508566b.3;
        Mon, 23 Sep 2024 05:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727093245; x=1727698045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KVEBv+WEEXWywK7FVnlVFD7W+Wd0c0cEXShEmoIOVVk=;
        b=M1HXxff2R1navrYovPQ3v8wcBchOLxXLTBAAasZnTGEXPTaK8RvUnHWVxGjVTeGim3
         IyDN6sjttveaMxpLE8RxyjTfAspjqP9crErD4FbODzzWDkCrfh4rJc2x7T010qpeqSe0
         KKcHjG+wonAg8oSLZOppZ5RB6k21TOSIlXKxPWM9Pfp+AbKK9K/rItdYBytj6g5IcFwF
         ay6iXf/ldFsxkoTgAcuxXRV/syPuIguX8TBrtWSUy5rrwMyDfTgSY5p0k3ENuW+SjW3V
         nAzLFepMXn2/DubDA8zS1HbMICZv//KndMg3cpTjmZ8l01Ocd7heLKQh1CIl9TdpTByo
         AKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093245; x=1727698045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVEBv+WEEXWywK7FVnlVFD7W+Wd0c0cEXShEmoIOVVk=;
        b=ETPKEUA6O6omjtRH4FgdbNhajVlphiwfiVCKDL+kXfGvvW1SYRNRPVOW2nl0bcCeFF
         oCfX1DTrkXwMySNmf0/E1x3plDnG3JoMTUvHZKsLopGtfNklYwzEkn/fokJLvReEBZlc
         d1nlIS8v01yLqFOprL7jk3Cv4ugHw37p7T+iWz7IPoxNXJWmgZX0AuFmxZapP+A6VN1I
         VmwYcr7POT6MjF0hBF0nxT7G1IbD+0iOGZOPQYaScdu88WiNGLNE2JDeUWCjCcUkxL+E
         xu9Fg44VSIORoAGiba7Qg936aOc+S2tXTxDu3NMcDP9j/Nck17ls3PnDpVzYVesEaOwR
         MYpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIDAydl42h0Zaeg/vmxtI20x0aEI56xWb3JhAlGwYczFlJ6b0xJyIBJb9sACPKfHDePNwtmflbWvvnqwY=@vger.kernel.org, AJvYcCXuGqVabtbhxFCabPFwoFgE4sEZkC6hnCO4ayx2gR2xR1TVfQjJ02v3MYTXEaFiRmi0bx6ruRKjii/1X+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHGZINz3CxKZaPmbzPNhmNylbRQ5ZAKPGBEFP1g9DnOgWTgBC0
	wUd02Z4OIRxcb/DzBF1Xjs3FkztOxFMwSoiZcQtI2USjVTfbaM+x+HFdkqg9
X-Google-Smtp-Source: AGHT+IExMqeN/pfm2xaRMHMe2BhKLuZdIxleW4JZonH6VhagQGq98tlnPNNrcRPoQ1sspYTgolGF8w==
X-Received: by 2002:a17:906:cae1:b0:a8d:2359:3160 with SMTP id a640c23a62f3a-a90d57720b1mr1034159066b.38.1727093245040;
        Mon, 23 Sep 2024 05:07:25 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f3a92sm1201898666b.81.2024.09.23.05.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:07:24 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Weidong Wang <wangweidong.a@awinic.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: codecs: aw88395: Fix spelling mistake "unsupport" -> "unsupported"
Date: Mon, 23 Sep 2024 13:07:23 +0100
Message-Id: <20240923120723.837196-1-colin.i.king@gmail.com>
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
 sound/soc/codecs/aw88395/aw88395_device.c | 2 +-
 sound/soc/codecs/aw88395/aw88395_lib.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/aw88395/aw88395_device.c b/sound/soc/codecs/aw88395/aw88395_device.c
index fd1f67d5f22f..6b333d1c6e94 100644
--- a/sound/soc/codecs/aw88395/aw88395_device.c
+++ b/sound/soc/codecs/aw88395/aw88395_device.c
@@ -703,7 +703,7 @@ static int aw_dev_set_vcalb(struct aw_device *aw_dev)
 				AW88395_VSCAL_FACTOR_DAC, icalk, vcalk);
 		break;
 	default:
-		dev_err(aw_dev->dev, "unsupport vsense status");
+		dev_err(aw_dev->dev, "unsupported vsense status");
 		return -EINVAL;
 	}
 
diff --git a/sound/soc/codecs/aw88395/aw88395_lib.c b/sound/soc/codecs/aw88395/aw88395_lib.c
index 769ca32a5c8e..ceb7fc43d018 100644
--- a/sound/soc/codecs/aw88395/aw88395_lib.c
+++ b/sound/soc/codecs/aw88395/aw88395_lib.c
@@ -688,7 +688,7 @@ static int aw_dev_load_cfg_by_hdr(struct aw_device *aw_dev,
 		ret = aw_dev_cfg_get_reg_valid_prof(aw_dev, all_prof_info);
 		break;
 	default:
-		dev_err(aw_dev->dev, "unsupport data type\n");
+		dev_err(aw_dev->dev, "unsupported data type\n");
 		ret = -EINVAL;
 		break;
 	}
-- 
2.39.2


