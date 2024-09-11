Return-Path: <linux-kernel+bounces-324811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD6397513F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A486CB25587
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF97187869;
	Wed, 11 Sep 2024 11:55:10 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3414F185B48;
	Wed, 11 Sep 2024 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055710; cv=none; b=GcHIWtuZLKiksp11ujiE7dBkqk6JvoH/qMypkQ/J5OqW3Wa9vxgmTAJhtEhaBF/EWUQVcpLTB5n6SWToJj+ipDwFGKnIYKKHAD8iXtrbQolU5UCjQ+M7jyEMP3Qye8VZeX/7DQpShawhZC7+dELc8AINwH2sPA2lejw2e7Ypmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055710; c=relaxed/simple;
	bh=LhFedJCR94M2rhZThQJpmVrhF9jDCYHsq2BK8/AdHs4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fVF7QEpwbLf70lB7QUIvKUqaBFXYLvxg/rR0vwBUV+gnyapdvBOtgVZEw71foXcOfCKKWyOmqkYU2jqQ7gBYR94Hv3G3SQj5WW8IZg6zPoIgcEcvlcJ2WgmfeV3Lvp2UCx9iocHq+AN/Rh/zJs6Sgz/hZ6CIVetAjUr9Tiq1GSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 7A6326096305A;
	Wed, 11 Sep 2024 19:54:58 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: herve.codina@bootlin.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: codecs: avoid possible garbage value in peb2466_reg_read()
Date: Wed, 11 Sep 2024 19:54:50 +0800
Message-Id: <20240911115448.277828-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang static checker (scan-build) warning:
sound/soc/codecs/peb2466.c:232:8:
Assigned value is garbage or undefined [core.uninitialized.Assign]
  232 |                 *val = tmp;
      |                      ^ ~~~

When peb2466_read_byte() fails, 'tmp' will have a garbage value.
Add a judgemnet to avoid this problem.

Fixes: 227f609c7c0e ("ASoC: codecs: Add support for the Infineon PEB2466 codec")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 sound/soc/codecs/peb2466.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/peb2466.c b/sound/soc/codecs/peb2466.c
index 76ee7e3f4d9b..67ea70cef0c7 100644
--- a/sound/soc/codecs/peb2466.c
+++ b/sound/soc/codecs/peb2466.c
@@ -229,7 +229,8 @@ static int peb2466_reg_read(void *context, unsigned int reg, unsigned int *val)
 	case PEB2466_CMD_XOP:
 	case PEB2466_CMD_SOP:
 		ret = peb2466_read_byte(peb2466, reg, &tmp);
-		*val = tmp;
+		if (!ret)
+			*val = tmp;
 		break;
 	default:
 		dev_err(&peb2466->spi->dev, "Not a XOP or SOP command\n");
-- 
2.30.2


