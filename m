Return-Path: <linux-kernel+bounces-524640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E195DA3E558
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B632316569F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D35213E80;
	Thu, 20 Feb 2025 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUq2MPI6"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201E1E5B6C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080979; cv=none; b=hstW8uHVSU3kfCO139vgOj48v9zLgrCaKsfrkK+lliKne//wXrOGghLNwjm9yP4GvlDnW9bLD5zludCgil+2GXFfDahQSgp480xHepXkexZeC9cQ/ITRoZ8Hab9pwFlg1fpJjQ2qcRBbnYq5cWHDqjtFftLEcXOB0f9MpJn4EWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080979; c=relaxed/simple;
	bh=d2kMQo51UxcJnlJjsASIq+nHqoQfcyxAhwWjTgFX/hE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QzVNG3JUWRMeQMDjI2sxYjaM/rsznxigxnHoKUIFGwXq1rlK3hDIE5IMXwVc4Q6Ytbhc6HF2+huAjik+0VcAj3NZUn95n0De9fcSFBfKUGiOq6sRU0P362KNA8zgaNh1SxJbx3Epc96cbsbTWi3qOMGniERf5uVtJv5cOKLYi9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kUq2MPI6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54838cd334cso124245e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740080976; x=1740685776; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hJXWsN2NkqIjVHTQAsP7Xm8vTVdN7QdGeuujq0WVxek=;
        b=kUq2MPI6gjrUKeGqYSDcnvyecb1CaGZYjWBg/K/usKheayJd2cEsX612t5uEg2jdrb
         BNW9u2TBCqL6CvE2Qu1lHzdQx1xvO4fV24jIPe9PkccPeaoUekDZoKzxpUmOXgUdv7AY
         vlCKpeNQUXl/ibbC0UHP2OjF3nFpmGFs/ZeBIa8W4Dfs87O0QEOvU0Bjdw9RxHb50wJF
         sToF5nZQp2hoO77drxrLY4aucGsZWdUWsweK3Pv3NpyEo+zgKUeZvpIFOyD/Ryl9z928
         RkUU1spsGEJoQe5ZMIPkcqmCHiJ0uaNGfBaXZmhu/fyuEvf5S1VKazFw4/THddsy96lX
         0ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740080976; x=1740685776;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJXWsN2NkqIjVHTQAsP7Xm8vTVdN7QdGeuujq0WVxek=;
        b=rFILJiz9Anfnrt2W6XQwaj2V3CkgiBLc30cI+oVW1qlB37fsEDun0t+Lb6OKX1x7UX
         8Y8z7iDGg815zo51A7nxBWwl4xMrbgo7dWIrHWNZaGAkUqm1R+6QMUGM8TLH/nVGsXIn
         8upltN/vZ/5uiw1urLvzhyTyoEnk4+1CtuD1iSIF40riAPrsuXsQ8q5i/+zPYPG3sCy3
         4VNVNowZDgYZScUxvy+o4fDGNEQ76vYYsZ2zhWl4nR5LmUm8LHOqSBdZdBlIW0Im2SLF
         d+sH4nYvsWLUWH6nQlbpECapvBlAjM8KMKkAzqcXqKGflutJ+FrdSbc7YITY/4jVbLSr
         4ARA==
X-Gm-Message-State: AOJu0YzXFZKtrW3WzQJh7vq1DcnWdFrvHWO4M32OxqCWapJRmJ5WnArD
	QQhCwXPrLRKBkKEQRgY9meufcI4ylrwcJWg0rVOMM9JTF47cEjaPFxJGHOknfxPuP/B7+sr1zh+
	4
X-Gm-Gg: ASbGncsAQtD/Xv7xBLoGrzFgB4htEnWuI7k+XN+WAwqcls4/5I6SO7q6DmtyDpvvzng
	pDGEAs6uEJAYxApzW0OKQ0Hx8bLJ01E1XZVjo/FoFIniPtaZL+L8xOhkTkuC29aU6Bz5erkFV7R
	Lc+KknV27exc4UnL+bMUCJ4eVOSM24CroLt0RnummBtm26q4yrGIr+yb+QjuJg3eHEtXPzriXRH
	p3M96FtKfpwojnktvTyZWTG5haQrz+GPHY99Cf7I6iUivLN9HubZFW637Tq6c4w451U4Cc6lDQV
	r8v84jvCKNX2GEtzG1BF47U=
X-Google-Smtp-Source: AGHT+IFjOVgPwzwhg3SYxcRE4jw2kx3dhsioaiUkzR0pk3Je1abaplyVqVcndszSknGYJFvxv1eMdQ==
X-Received: by 2002:a05:6512:3f11:b0:545:2df3:9a89 with SMTP id 2adb3069b0e04-54838ee8ec3mr110664e87.17.1740080974737;
        Thu, 20 Feb 2025 11:49:34 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54548430df3sm1725718e87.226.2025.02.20.11.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:49:33 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 21:49:30 +0200
Subject: [PATCH] nvmem: make the misaligned raw_len non-fatal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-nvmem-word-size-align-v1-1-0f7cc909bc86@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEmHt2cC/x3MQQ5AMBBA0avIrE1SjZa6ilgUoyahpE0Q4u4ay
 7f4/4FIgSlCkz0Q6ODIm08o8gyG2XpHyGMySCGVkFKgP1Za8dzCiJFvQruw89gbZUpbV1ppA6n
 dA018/d+2e98Phmg42GcAAAA=
X-Change-ID: 20250220-nvmem-word-size-align-b9594a876569
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=d2kMQo51UxcJnlJjsASIq+nHqoQfcyxAhwWjTgFX/hE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnt4dMyE3MOZvV7GR7b+Qab2Ty0ICh+WvC1gyFb
 f5A4bvH6pOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7eHTAAKCRCLPIo+Aiko
 1UTpB/42GAdVJwM0eJBeEdO7Elip9G7qJkU/xWmQie9quH+92FEufMVCgMFsyYA/I+8T3vrVBSw
 SPtjaxHlcFBCWg1MwX2g7dnYu1M0Ti2/7Vi9guBSP+USYfR+FMZK0JOr619QNPXjQ0fgNyqDiNN
 3dWy5oZjqJIJlHZQABxsxWrrNHM+NA4r4R9b38LQkMHVeTgTvOAGCA3AOe1aE62Qh/CXdydVnk0
 sDRk/Y2xzCCOiiGiAKcNY3MFMwApcaxBh82lG2MIqMrScuDIJulmMWz/6aFo+kZfO7E7pNkcdaY
 SQhwF1H/Uoe9x6OGiJ+tmIl2ZGbAkuBgewCzm7BHxBGQDYAY
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The commit 11ccaa312111 ("nvmem: core: verify cell's raw_len") enforced
the raw read len being aligned to the NVMEM's word_size. However this
change broke some of the platforms, because those used misaligned
reads. Make this error non-fatal for the drivers that didn't specify
raw_len directly and just increase the raw_len making it aligned.

Fixes: 11ccaa312111 ("nvmem: core: verify cell's raw_len")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/linux-arm-msm/Z7Xv9lNc6ckJVtKc@finisterre.sirena.org.uk/
Tested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/nvmem/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b6f8544fd9662cff0a04e292bb536418564f0368..e206efc29a0044739f9d56e1b131af2809365201 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -612,7 +612,11 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 			"cell %s raw len %zd unaligned to nvmem word size %d\n",
 			cell->name ?: "<unknown>", cell->raw_len,
 			nvmem->word_size);
-		return -EINVAL;
+
+		if (info->raw_len)
+			return -EINVAL;
+
+		cell->raw_len = ALIGN(cell->raw_len, nvmem->word_size);
 	}
 
 	return 0;

---
base-commit: 8936cec5cb6e27649b86fabf383d7ce4113bba49
change-id: 20250220-nvmem-word-size-align-b9594a876569

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


