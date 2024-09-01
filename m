Return-Path: <linux-kernel+bounces-310287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEFE967795
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7AF281FA3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92810183CBD;
	Sun,  1 Sep 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMpmk1Ct"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961C183090;
	Sun,  1 Sep 2024 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207690; cv=none; b=BW11e9GRPrWXsSkDrptfe8631tmPB9P86TFvBRo2FfCIEMYES8H0Srei9kr3Wg5TcDOCuiGPPWbtfPMuUhZBc4tdi6ize6ePn/+RvjmL3lWpNKU2RL8FbqubriJHmcgbl8VGkwTbELT5DEK6pWPZjeO8aZxMl7TPamE4rU2Av5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207690; c=relaxed/simple;
	bh=HfLhhyK8ZjmZxmpk87z3JzSSJ2B6fRAkJGHcXbFr3Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ikLRZD9+U8sOejunAvMwYE0bdoQQrQyV0EFHAto3Llr981uI6UuioD/a/9aSHqd8wg2pM8aTVVtxaPjewwVDNrFV6SGr2UiM6sWF1ypKn5QhWqfIOY9TnbgoEiYtWqM6ZexwbKCbgzpMiC6McH29iFoLLHjJuKf4q5wrPGPEgJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMpmk1Ct; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso4727989e87.2;
        Sun, 01 Sep 2024 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725207687; x=1725812487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuCUp3dtlERSrvFobjZyRBsC7Z86P+xyj/8tqs+RWFM=;
        b=JMpmk1Ctmx2aU5Xoi4jjldKRAeBaGnLyEUzfePTeFNywpfMlfktIyfscP91u2zzytd
         NW8KHrPFhnE1RCSl0m/XCZf3YM4bJwtNMPToMDubi/HhgEIvLE7nw20PxYXIxuQhXgoE
         +8fkIgiPT5jvFzjKt2DMyuzVmNzHda8NJmSCxrd5OdlE6yLTWU+Mr7TLFd+I2w7e+SQF
         3bojODX2dJOhuZnwL5k7DMTNJCb/vOR5ZvuAjsMwWqyVdFEgpyD8W06sCin4sYgSNq+r
         sZXyL69KyYTbnx+s3pW3Q8Nbdy3ZMVuHJacKoNp39MPiFiPNQXLGDddfVWuo530md1mz
         zNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725207687; x=1725812487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuCUp3dtlERSrvFobjZyRBsC7Z86P+xyj/8tqs+RWFM=;
        b=QoMkQFz2nlDFa3xP6VB4KhzMBJT7rFl+VExNxcVUMCMTBVgMur24ZrFhfA2WliSTwM
         lIMj4NQWqc5sE9pL/o3n8s8LZkWSBv6WYa6y9hk7cRDafOGnAuhxFLSFQgimNqFWb9Dk
         T3Mgp5Yzp0SX23MIZQvGWN/MqyKtZO4mOC9W3EfVBtHNqxhpBP58JRAeII2worj46xHP
         ohIvST6bdU/PaCC56dPCebzzipFVOPBoE7dvV4tegXpVdWY1Q2be54vBJSQ1TsYxaLw1
         y2uRDwge/JSje54RZBKu0CVp9dCPmk9xo58w3/nm2WSfuVxYSGEdOTRW9WgJO+k9eE5C
         wfhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX5nE8mHG8gUPJs6gqOwbF3luoT6I9eSEFVcaFP/b3pksyLdd5QfSZI7CoBuznMJlRHCLpxwM2QWxQLCU=@vger.kernel.org, AJvYcCXQr77uwQ5abwG691CWI0FuF4jNuOxbcEv91zHc8pEUs1Yd8pp7r+C/MUBp0BDGujSmlI+p6HLT7I7knqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjjOkRKU3+RaKcHqcKa2Z9xgrDkF07RoqdHQPc9YUecCzCatl
	f7U9xWXeMYzSG1EoB73o7Q+UwL/XCAy8SXknEHwoAKHs02vKZE/0AW6U0l0f
X-Google-Smtp-Source: AGHT+IEGB7s1ist5UbduRK69b+q1RkRwi4CIl6+uwr/fcPQj8RE6S+v26D6lpS1ABs+eeFzW7FhuNg==
X-Received: by 2002:a05:6512:3e08:b0:533:97b:e272 with SMTP id 2adb3069b0e04-53546b92a89mr5932754e87.41.1725207687017;
        Sun, 01 Sep 2024 09:21:27 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898919686bsm448214166b.134.2024.09.01.09.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:21:26 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: ali5451: Remove trailing space after \n newline
Date: Sun,  1 Sep 2024 17:21:25 +0100
Message-Id: <20240901162125.144069-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a extraneous space after a newline in a dev_dbg message.
Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/pci/ali5451/ali5451.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 31e51e2df655..793d2f13267e 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -292,7 +292,7 @@ static int snd_ali_codec_ready(struct snd_ali *codec,
 	}
 
 	snd_ali_5451_poke(codec, port, res & ~0x8000);
-	dev_dbg(codec->card->dev, "ali_codec_ready: codec is not ready.\n ");
+	dev_dbg(codec->card->dev, "ali_codec_ready: codec is not ready.\n");
 	return -EIO;
 }
 
-- 
2.39.2


