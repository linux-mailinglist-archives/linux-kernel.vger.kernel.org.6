Return-Path: <linux-kernel+bounces-407513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 224329C6E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6AABB2B3AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F16200C84;
	Wed, 13 Nov 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ceo3Edix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105A200BB8;
	Wed, 13 Nov 2024 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499033; cv=none; b=oHy3Yfk36ANhMA7SStJabc6iyfoiSzjqvxnqLuSrUR2Qhe+Z5cU1STvZwCzevhz4BZqbPCGwIzmwyVrHPgR62JKsC85TIaxLZOTXSxPZRenDeCJbd5lHr3NBMG8VGMFP14HAlqcIpBBrbq2pL5fA2bIJf/6MAZPfjc84cy+zS6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499033; c=relaxed/simple;
	bh=irKe1KMVov8M4lOKdgPFWA3Wyl9nGGWBEJyBxp6+cqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r85Q9dggeD/cyqM3UBx1kPaHkVO1d8ylc7/T3n4W5SZkZnZVn9G7+VeOaZGAcYFU6IR7BUpLzfOlhjcNh956vJt6M7kLUChG2/zHhSlO6YHQ5XI8PpyGTmBfZlJqHAoRpVoo+I5J38IZ+NeSicP6HDLwngXmv/bUkWxR/TdpisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ceo3Edix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FA5C4CED2;
	Wed, 13 Nov 2024 11:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731499033;
	bh=irKe1KMVov8M4lOKdgPFWA3Wyl9nGGWBEJyBxp6+cqw=;
	h=From:To:Cc:Subject:Date:From;
	b=Ceo3EdixWetuWcNrnMuWZx3ewHWed5Ed7e7iRw36XG2JdwIRh/NNdiBVOmKUQqJid
	 MK7j+zwD6W5K2I9i7ii/QRedo5pP9Dl2SEaVevLCLc5DIc53/woNP53TJzF5t7vu9s
	 ynWW26sUNOdD6uUolOTqJDPvHOH5MgJlKLb3M6pffAEhbO1FU81xm2lQ+C294q6lep
	 Hf5OuuWjn9Q9gq29Jk5FNIfFL87kuq2N//vLfuB5KcXY5zOsVMHcY9iZkmoLgFqtp+
	 YPe5ot6MhiCjAoaH5miBOa1SVyrEKkui9cIXx+nN7UJOewGiZZaGEuCrwwB2EPwN0s
	 1AzjHHCSJCEbQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Kiseok Jo <kiseok.jo@irondevice.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Tang Bin <tangbin@cmss.chinamobile.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: sma1307: fix uninitialized variable refence
Date: Wed, 13 Nov 2024 12:56:50 +0100
Message-Id: <20241113115708.4772-1-arnd@kernel.org>
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

Initialize this to NULL as that is what it gets checked for in
case of error.

Fixes: 576c57e6b4c1 ("ASoC: sma1307: Add driver for Iron Device SMA1307")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/sma1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index 81638768ac12..9d6a70b9b626 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -1709,7 +1709,7 @@ static void sma1307_check_fault_worker(struct work_struct *work)
 
 static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *file)
 {
-	const struct firmware *fw;
+	const struct firmware *fw = NULL;
 	int *data, size, offset, num_mode;
 
 	request_firmware(&fw, file, sma1307->dev);
-- 
2.39.5


