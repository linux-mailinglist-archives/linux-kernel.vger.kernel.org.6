Return-Path: <linux-kernel+bounces-394734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A6D9BB34A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A32E1F2101D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5D01B6CEA;
	Mon,  4 Nov 2024 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sG6jOTxI"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236681B4F1E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719463; cv=none; b=qhleIPbEYds1OYea8GZMMNKLDHkhZbx8OPxNtY10Rz7c8IaLDyJX7h7N0OR8tnVvKSbTEyuixatU8jQrNVRNw+Mkfc63cOp7TzcXRSI1CI7g8Kf6yvRAmlU/ILMNCX1V7GnqxENbZw8a9Z7bX8O4pllKGC1BL5ksKgOzAs6RYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719463; c=relaxed/simple;
	bh=UYZ3kIxDLucn3oyrn/tKsey0UjLM+aqNDUd0kAgrci0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJViy1PvttKSkwdKudplwaMjcfZQH4g1kZSAErA2FKlf5adLhPfEJ/9poShW+v3BMCm/3kkMuNGPOVhyTejIxcaLY4MqgJEDR81eTNWI6RSf6fRodmXmgyD2heOyIGpLJIaGgs9X7KlKlV4YkUfMQYuUrjON+eXAQFdiV6pEYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sG6jOTxI; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f2b95775so4377195e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730719460; x=1731324260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTHdbkolXrAXojf/yFVLVMxFSBrJ15Q3tYkvYVpuHpA=;
        b=sG6jOTxIoo5Z0s2UkmcAxy6qIFGQ3IBjgCGdMotT6oY45qFGL/L5WXlbJ8ax32iTn0
         LCmcwB/JoURbdL/KuTdti3RbvpnDeA91oq249jD7siCdOhfDlY9TS4t0qkaBuwX7nXXu
         0JxT5NOHlwsx+49lthVbT6MfK96rEtZbLyb4eHE+8pBy1Ql3L4t5HfZnczEwmLABOwRe
         2fSvFLnXMOTyyubmDWj5uhmIaVArQPB7IeNmQXeyZUAFZw0UYIq4nXQKB/E8Kg9ksFBs
         wOCG3ECnzfk3GySy6TgOfD0jnszVK8QIUQGW8alUssc4FZEiPDkxY1lmwWCFNkbC7p3B
         M+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730719460; x=1731324260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTHdbkolXrAXojf/yFVLVMxFSBrJ15Q3tYkvYVpuHpA=;
        b=Hyy3RcCi/zBd39asht7j7wi0ZNhP5+QLMIp5rNxbdzi8nYz3vmvwjSC5lnH+cUur+I
         7MnFrd01e4wKOtyrl/OIm5lAnYXPo9z7Ww16x6d1VoLrF6BxnpPA7jgQBd3WlUCfqY+a
         S8q+aMUXFRjE7qQBVYVpgdNhRvuaVXf5M5E9GApg4y4/KEOytRRJabcahGHWauTDQKw2
         OAg4hIPzZJ/Jq4/n78FV/y79H0FaFi/dW3D976Ad5TFsarU56lfCj6ixCcbGIczDDzB9
         XarnN/DLYkw4YSnbSC5fS8PbctFOLPiYkNbvUcN3kxh/5M7c7R9z2+ZYWDPlbU4yVTky
         lmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx/31xuJKPjhw++2Etm5cmzXLXCVahYBtg4tRLIGyYK0ilU9V7CVZKdqxQ5p42TcMTKl2pVscrS99bJ64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCL/4l/4TBusCTKs5Hea9MGi4S8TF4cD7TPS0d+eZFWHwb/py
	O+n+iqLuTD4Fb6EanQDe9AoHUqhfrTKhG9ST7c2mRhDqEpjEmlx4C5oeDrN4pbtfJqer5ttwYTt
	e
X-Google-Smtp-Source: AGHT+IFZaFNv8wLkd7sg6t1hW1ZdCSeinW0m/apHyHWo0TgH/lHco95Il0oiLc67lylJL7XPhu9+NA==
X-Received: by 2002:a05:6512:4015:b0:538:96ce:f2ed with SMTP id 2adb3069b0e04-53d65dc9855mr7025092e87.10.1730719459698;
        Mon, 04 Nov 2024 03:24:19 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c179sm1648707e87.91.2024.11.04.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:24:18 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.12-rc6
Date: Mon,  4 Nov 2024 12:24:16 +0100
Message-ID: <20241104112416.51129-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.12-rc6. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12-rc3

for you to fetch changes up to c4dedaaeb3f78d3718e9c1b1e4d972a6b99073cd:

  mmc: sdhci-pci-gli: GL9767: Fix low power mode in the SD Express process (2024-10-28 12:30:27 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-pci-gli: A couple of fixes for low power mode on GL9767

----------------------------------------------------------------
Ben Chuang (2):
      mmc: sdhci-pci-gli: GL9767: Fix low power mode on the set clock function
      mmc: sdhci-pci-gli: GL9767: Fix low power mode in the SD Express process

 drivers/mmc/host/sdhci-pci-gli.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

