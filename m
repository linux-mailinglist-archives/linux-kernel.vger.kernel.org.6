Return-Path: <linux-kernel+bounces-421068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A09D8648
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E817028B90A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619D31AB53A;
	Mon, 25 Nov 2024 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zaAZ2TEp"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38361AAE17
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541000; cv=none; b=dbPgblBOpskFsw2v3BCm5D0M2dGWOSP5Hdi8Pu1gGhcdms4pI60RtrqHTJTZdfrjQ0cc2+4iE43kJpU7SA19C9NTumMA13YRBhgGlS95tEj7sZXf1uQrMVQttR7mpfDiQmUDC2zvuWPHZ4GqX3DlKzh7k9Irv4pACOw9AcikxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541000; c=relaxed/simple;
	bh=tsGjL3oAXbXazFnaNHNq78HYCtcbKhPU8bS3LUWF9sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSIzvjm7YWItX1zEtUNZZR0+ZVLl+4YroVSdK3bmO1ExM1yTos65RRxVvdWCZsOGYF4fQvtKaZJgNN7PXAMaNHHuoexDk/ncSKmnOPbcivDXjS49VJ6mWSRtMLCpd1ac92JOMEpHMYghrSbHurgxJRa8EDujQox18xzNVl0siW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zaAZ2TEp; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53de6b7da14so458220e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 05:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732540995; x=1733145795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZJPVNAx/alEFALNFU1/rflNdzfT+JgwsBAa7B0VlDA=;
        b=zaAZ2TEp6yKRjSJe0i6+pg8+QSPF3SwXjONhVGoc5Y9m8ui0nJlH+qOPl3i67Bk87S
         9j1MJjGPRROS45RqMc2vDG8WNQUjHf3zeSd6lJp2bl4nsQeRWFcNhP47+YitwnnD0dT/
         IayMdOJeIVBp0ANaeb3AEgGTLRA1OiaAlLP3NWzBNwCeozdjzHigKawlN6EMrMkp7EPi
         DfufChDocei73Gns4AF6dObkrHKAK7q70OhUAqewd4yUCwRDNaKIsD78ZrW2Iq2EWUe/
         bNwmkH6QSOqNW5cYT1QRBLfQndwdHfWv+jfhfqCq0CQMA4uBXHjKPFXwFURScD1uhUo4
         lVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732540995; x=1733145795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZJPVNAx/alEFALNFU1/rflNdzfT+JgwsBAa7B0VlDA=;
        b=Qi9RXkGFHMLQDi+7687xmWClSBnq4Bh8KaZwHgJWe1sb4rai7DMwHASN6NBJZruu7Q
         60CpccGwaozKI5+iEaZW29PPe4Se1spyolcZyiim9l+U5iyiDtg7V3AiZEmY260HpeQJ
         Is8m44PPvcH5lrekWNg57D+0dRYfrQXkNfaCTgPKFSVO9VqmF0solhi6LUC4iVIkb5/D
         bGHOI/9Rg4FD0XdpmRdf8hZ9e1ximCXLO5sqAbaLQw6E4wuMxDtSAGCyviyidVL25AOy
         hYRwzEy6JbPNMnNhy/PxLGfkpSE4u9szvQfzXhorfWgipSWjb94694fbDgbPP787wFMc
         m5pA==
X-Forwarded-Encrypted: i=1; AJvYcCX9+PFtaDI63aHTm3HOmZJanlvTmYeiWVhoTudj0XCO1Yxt/odYiP+dzBSJiRym8qer2BHiMjNII3Go3UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOslcbfGjrIYUjU5Z651AetU9najRNhxB6ZcovNN1hhkfy5DIG
	JnTZiq3D6HnNm4Czg+9eUAG1Hb1tbGl3fS+dtaDAVsbo+HVz9NoX+IXcfcIodNSVJnCjzKnGIcc
	M
X-Gm-Gg: ASbGnctbdhRBwvxEwy/0vUtYCH15okiIFJWlxHVFJt/ljh3Wt+egj4gjYsXu+JFwGJp
	4LgpANNM5VEhv7+GSKnMLRoyD8zY6Y+WmBoxf2HsF8xFKyPg0eI4cZeP0gufp7/qLjhb0L7ZUGY
	pNbue1rLpveMDKXgUWvIPc8P0J/Etu8eFPwlf91mAeyXWQ+yCo1KW5GQxu7MYTuPooKbyqZ7T5j
	OQgxzFJBp8BG4zRM06ocyNP0eVtVj4LxbKn+3Jaq7nhGaalpRlRf7+FeFooY94JeFh3CLrLRV14
	81iBMVXCS+iB5AINezVGM5D4
X-Google-Smtp-Source: AGHT+IGOxHk25jTLFTha4OAsOGW8H0e5H22tj6vbvzfjfKUzjryuPdA/e7p3sWP9nnHla+J7nmIvOQ==
X-Received: by 2002:a05:6512:39cd:b0:53d:e47a:1642 with SMTP id 2adb3069b0e04-53de47a1701mr1966433e87.35.1732540995377;
        Mon, 25 Nov 2024 05:23:15 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481424sm1682598e87.133.2024.11.25.05.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 05:23:14 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Drop the MMC_RSP_R1_NO_CRC response
Date: Mon, 25 Nov 2024 14:23:11 +0100
Message-ID: <20241125132311.23939-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MMC_RSP_R1_NO_CRC type of response is not being used by the mmc core
for any commands. Let's therefore drop it, together with the corresponding
code in the host drivers.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 2 --
 drivers/mmc/host/rtsx_usb_sdmmc.c | 3 ---
 drivers/mmc/host/tmio_mmc_core.c  | 1 -
 include/linux/mmc/core.h          | 3 ---
 4 files changed, 9 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 48d3b0aae5a0..0c6eb60a95fd 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -115,8 +115,6 @@ static int sd_response_type(struct mmc_command *cmd)
 		return SD_RSP_TYPE_R0;
 	case MMC_RSP_R1:
 		return SD_RSP_TYPE_R1;
-	case MMC_RSP_R1_NO_CRC:
-		return SD_RSP_TYPE_R1 | SD_NO_CHECK_CRC7;
 	case MMC_RSP_R1B:
 		return SD_RSP_TYPE_R1b;
 	case MMC_RSP_R2:
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 107c78df53cf..d229c2b83ea9 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -313,9 +313,6 @@ static void sd_send_cmd_get_rsp(struct rtsx_usb_sdmmc *host,
 	case MMC_RSP_R1:
 		rsp_type = SD_RSP_TYPE_R1;
 		break;
-	case MMC_RSP_R1_NO_CRC:
-		rsp_type = SD_RSP_TYPE_R1 | SD_NO_CHECK_CRC7;
-		break;
 	case MMC_RSP_R1B:
 		rsp_type = SD_RSP_TYPE_R1b;
 		break;
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 45a474ccab1c..04c1c54df791 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -297,7 +297,6 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host,
 	switch (mmc_resp_type(cmd)) {
 	case MMC_RSP_NONE: c |= RESP_NONE; break;
 	case MMC_RSP_R1:
-	case MMC_RSP_R1_NO_CRC:
 			   c |= RESP_R1;   break;
 	case MMC_RSP_R1B:  c |= RESP_R1B;  break;
 	case MMC_RSP_R2:   c |= RESP_R2;   break;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 56972bd78462..e13856ab6ad0 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -64,9 +64,6 @@ struct mmc_command {
 #define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
 #define MMC_RSP_R7	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
 
-/* Can be used by core to poll after switch to MMC HS mode */
-#define MMC_RSP_R1_NO_CRC	(MMC_RSP_PRESENT|MMC_RSP_OPCODE)
-
 #define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
 
 /*
-- 
2.43.0


