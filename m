Return-Path: <linux-kernel+bounces-209178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8748A902E47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318F11F20FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F04BA5E;
	Tue, 11 Jun 2024 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="y7aNDApD"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D765A94C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072564; cv=none; b=D0nP/jBUgP7hLF/2ThWsYODiWEj2z0vNwPyjjHbTwLa23cv3FL/9fEmbyVDfnjabxp3aHYQB5K/Ge3SAeVFJC6k830lAnYxKbatGMfZ33xpytZCf9tVVxJbX9xv2/9lNzniT3EAl3qerM60ZoB/7Ghk2UrIGvOtjZFm6bRbqi3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072564; c=relaxed/simple;
	bh=cGVfdVYeHoF7ee8gZPI99lAdeF1Ov4eltP6J+pZI2UY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pOXbMMkEfmHgY+m5CSjgaJwbPon80JcPSJGUbYi9BXLAXdsrlz77dl53W81PeC9B85Z9OKtMNeDBeDu1nDy5sjUaGYMzJZJuDfshlWYCLFpM/WFfCnysIw9n2OBQ5o5a6CYxUyMWHR5NDcYnWZ8SreIBfKlIpziqgKwOPEmNg7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=y7aNDApD; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c9cc681ee4so298668b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1718072562; x=1718677362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rOWiDGoZ3cg9dnynIRWTsyteioX53Ouu76F3VV4WZDg=;
        b=y7aNDApDJ7bHaeBXXcBXwUjPat8I2+0gcbCkgNPIE6YTZI/dwp+fvGjy9qjZamkt4v
         jWvmwm/EMBBb1qfvPSW9HedLqj1gmqXQ8BI0JrmA7te9SEBEKrHL8V3zZcVFPA9PWZCB
         SoYgYFgaED9NmBDFnuGgFOIjaUT/2cFV4cPLJRVdNuKvDhpy5JAccycMsFL1WBEtP3kq
         gqRXl0YyxcMivI1pCNXbw9yMNuz+qF7LMZfxjynzdbrXloRg0d9aGvfKO1qW2zXsRNgl
         nCRTI6Sc9MoGEmJRavPuI41AjapJoh6ypwgHvM5S1yD/XL74MFE+kZLJMfzoZaNqkSMz
         +MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718072562; x=1718677362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOWiDGoZ3cg9dnynIRWTsyteioX53Ouu76F3VV4WZDg=;
        b=RMY6m+ClIDNZoFgMh18q+S1jpiZnZibXp/LeaFAXIqcLUY3AXUCjujEpoks9w5l6ig
         Tm6ChmzL/E04hp4xJThLI75TcCj0gm0u8VIgpv8HZxdEYeBTIuqk4+d1M8q13b9L4bZz
         0ZoCknh+8xrB95+9ijS9wd+N2KaTXeFDOurO0lAV2K9ibINpQSgfm5lFYSruEReoooeR
         5DBUUDAHz3BMqaIt6aDnmKkjQS7LCSLIizwCyuL3H/4tTPiFMomk5a5VUyE0hUNBL6Ma
         NdOwDh/y/UpHU/5GkBTIdHFjYQqIkCgVqDv79uQCznAUYKJ8yPjV8XDgyo5fw0K3xc5G
         mCVA==
X-Forwarded-Encrypted: i=1; AJvYcCVGzfruNeTKvjif1CPgjGyZdCdUavV0i7PVaVbdu78MsPfXbcLbWluzfDkQMnx0H8sJHc2vAkAWTbCDuwHRwxveoWR6Idn/mXgAEePC
X-Gm-Message-State: AOJu0Yzk+uanI3z/4J6RdxygIGtXK3soSJ8BrxNRa1eC0Bc0EkPtIqCI
	DNWbSKnJozbWL9BYkuMG+9ObDfkZJtaSIlGXK0ny0arrLeM5A0zrkQtWRatszKg=
X-Google-Smtp-Source: AGHT+IH54UnImHOBfDjxg/a/aqysYcwTv7IDKcLuDx7VweoZ916Hrr9pYkdYYvKpgl1/Gy1pVhimIw==
X-Received: by 2002:a05:6808:218f:b0:3d2:1f88:3e7a with SMTP id 5614622812f47-3d21f88464bmr9449264b6e.39.1718072562390;
        Mon, 10 Jun 2024 19:22:42 -0700 (PDT)
Received: from zhou.. ([101.78.151.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7042f5584e9sm3953561b3a.12.2024.06.10.19.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 19:22:42 -0700 (PDT)
From: Rui Zhou <zhourui@huaqin.corp-partner.google.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	trevor.wu@mediatek.com,
	allen-kh.cheng@mediatek.com,
	kuninori.morimoto.gx@renesas.com
Cc: maso.huang@mediatek.com,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Rui Zhou <zhourui@huaqin.corp-partner.google.com>
Subject: [PATCH v1] ASoC:  support machine driver with TAS2781
Date: Tue, 11 Jun 2024 10:22:27 +0800
Message-Id: <20240611022227.2508354-1-zhourui@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support amp TAS2781 for mt8188 platform

Signed-off-by: Rui Zhou <zhourui@huaqin.corp-partner.google.com>
---
 sound/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 5a8476e1ecca..07f67f96c889 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -233,6 +233,7 @@ config SND_SOC_MT8188_MT6359
 	select SND_SOC_HDMI_CODEC
 	select SND_SOC_DMIC
 	select SND_SOC_MAX98390
+	select SND_SOC_TAS2781_I2C
 	select SND_SOC_NAU8315
 	select SND_SOC_NAU8825
 	select SND_SOC_RT5682S
-- 
2.34.1


