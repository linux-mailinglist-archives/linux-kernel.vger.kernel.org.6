Return-Path: <linux-kernel+bounces-408103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1C49C7AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B83DB34E79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0CF206046;
	Wed, 13 Nov 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQhXqMwj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51503202631;
	Wed, 13 Nov 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520661; cv=none; b=ZnWNHl5YlbpVcHaurJk5aNvtysQ0rGsoT7i3NWvIX3kaQZ5bX+DPNHloNk+Y4wY3r/4p11Y/S9GvxM3s8bF9fEuISpx63qpAyrDAXLwyC9JdI+LClGIrbOk2EOHTzlhMITBz9g1RgZlBXloSm6cMEN8xsOJ2LvLkIAHgBnECioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520661; c=relaxed/simple;
	bh=hsej9QZ2ZJJ5VqKk63f8ryGQSXEiV+HHzptb0uSPdo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U4TO3H9VPk8jzcVo5KlCkSM5dCEF4t/YoohlKKp0pPmfRHlVB2uVhuSRZf2TTss5zft3vxDPqV2JP3p/153m2YpTYgdAZWkf47aGwjYoKaUFWllsy72pOUAYTcrdPF4oG0phtYYY1Aa6hL6gDiCEP07b1ZW6/p7OlTrmamKulXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQhXqMwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B13C4CED0;
	Wed, 13 Nov 2024 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731520661;
	bh=hsej9QZ2ZJJ5VqKk63f8ryGQSXEiV+HHzptb0uSPdo8=;
	h=From:To:Cc:Subject:Date:From;
	b=VQhXqMwjpPCkrPrnlZicj4GTGfR/K+KldpPHdjD2omQxPmHz0tFKEm41XQcXgxDAa
	 3wQRG7WsdxDifZtXCHF6AjdB9W4hj3ijfX1FsWDfgGDLwyyuhiDI5AlF7slaAA39c/
	 HMHY7iXqMgt8aTKRXmiGoF+0XZ/fc26IiAKsadKJxlSttopgEyK22KoE10KS/nPFYa
	 nTG/Eslh8XF+TrJMULR2yXLDfyOq3Nwna6IlgbU9XBAFUSrmRb/JtJ4Mg/gQZI4Tsu
	 zd5QPE49iqk3FGnPLrbyI9y2Yfl3M2CbJUpxPU3hojao3PlQaLYf3ljhPFk4mEOFoC
	 E9uGDGLZbNc+g==
From: Arnd Bergmann <arnd@kernel.org>
To: Kiseok Jo <kiseok.jo@irondevice.com>,
	Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Tang Bin <tangbin@cmss.chinamobile.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ASoC: sma1307: fix uninitialized variable refence
Date: Wed, 13 Nov 2024 18:57:13 +0100
Message-Id: <20241113175734.2443315-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When firmware loading is disabled, gcc warns that the local
'fw' variable fails to get initialized:

sound/soc/codecs/sma1307.c: In function 'sma1307_setting_loaded.isra':
sound/soc/codecs/sma1307.c:1717:12: error: 'fw' is used uninitialized [-Werror=uninitialized]
 1717 |         if (!fw) {
      |            ^
sound/soc/codecs/sma1307.c:1712:32: note: 'fw' was declared here
 1712 |         const struct firmware *fw;

Check the return code from request_firmware() to ensure that the
firmware is correctly set, and drop the incorrect release_firmware()
on that uninitialized data.

Fixes: 576c57e6b4c1 ("ASoC: sma1307: Add driver for Iron Device SMA1307")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
[v2] check error value correctly
---
 sound/soc/codecs/sma1307.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index 81638768ac12..f2cea6186d98 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -1711,13 +1711,13 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 {
 	const struct firmware *fw;
 	int *data, size, offset, num_mode;
+	int ret;
 
-	request_firmware(&fw, file, sma1307->dev);
+	ret = request_firmware(&fw, file, sma1307->dev);
 
-	if (!fw) {
-		dev_err(sma1307->dev, "%s: failed to read \"%s\"\n",
-			__func__, setting_file);
-		release_firmware(fw);
+	if (ret) {
+		dev_err(sma1307->dev, "%s: failed to read \"%s\": %pe\n",
+			__func__, setting_file, ERR_PTR(ret));
 		sma1307->set.status = false;
 		return;
 	} else if ((fw->size) < SMA1307_SETTING_HEADER_SIZE) {
-- 
2.39.5


