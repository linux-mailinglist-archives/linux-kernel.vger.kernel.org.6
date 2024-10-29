Return-Path: <linux-kernel+bounces-387013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A489B4ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770531F23ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDA720695F;
	Tue, 29 Oct 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fn/dXq7N"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4418220650E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207886; cv=none; b=oLsisPBVTkIdTRiy+bdW2a81Io9Gq54f2rxZtifKxfYXaX5TjBdtXEseGME3EfnYWZ+zWUeRP9ik9E7IjLf8CjqYTvrBdOnsabIFhfZ22qIwKTALz1uyqozJ3TidbH5H/Rsv212jb3e3z00y5HYVD2qJozMAftIyhYztzUleHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207886; c=relaxed/simple;
	bh=ANkqoHmBlWeAyTzEEJnr47Kb6ijhafWnHmW225AcRh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ue2KgVAi7SbzsUbBffUhbIu/5gPo6Foh8qR9crYKwZqLFicV5IwZMClyxfTfpUbqVE3jTCLTwO73uG27Wyymv67qKZ9hnA6aS8lZx1bnErkdKtFHPseNd0L861XSMvgLbID5RgbJzAYErLIdwYmAo2/F7JI22pwPgeqYDo0ePlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fn/dXq7N; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so45223191fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730207882; x=1730812682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECTIY6gQGhiQ/bshY9W31clyZwhWM9uKNHen6jEJgGY=;
        b=Fn/dXq7NLQbxGtcruPRmXUcYYUj/d+V5DJM58gCX0jhAkW2PCheM5BmCvfG81KkAO2
         xZioetQvZUhY/WD0TZEkolKrtjGbvr8UUdn6Wcl5Oyl692VNdzXUSRCYw/ythOP2W5II
         gYgEQ3rNE5QBLECo4myHVv/KNSupQRaymLDmIAjGI/iO+r7K3i4EIJPthv/KlXk5cHaG
         i/6C9hocksefldIlVmQYLEcdMRRnNHo4EguBJeCmE26vZUkSzEXerh6iBh1HSZDomD6P
         mmK4jgQy7qjTFhsgH0iN6NkfI8nmBTpXuqHgKHh+Xl79KbQWIS3Cm1AWXR7uSoE0gtXK
         1Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730207882; x=1730812682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECTIY6gQGhiQ/bshY9W31clyZwhWM9uKNHen6jEJgGY=;
        b=lAWeMvr6rTHOg2lvo4o176Ic4wlEtoFT1Hb+YhjqVvfNgSrDnc9Soudmj3NuEuGrmK
         auOo/hdDx8XiL6tVaeV6QuFlIb/+HtgkF/AIRngTvMKChW1AEeMFpiOpVsI8IN+ClVi7
         yfmH30jJUU1Vpfh87pyGeg844EitZKZq1VS2+c7G8ZxTw9R3iQJ5O1Z9MMCxB+4BuWmW
         9zbAB1fxMQRsaslhjrkngbmOur1iaYG+R8RSejxhbfOlHmhJCBb4OZKS+ySraapm1Oe1
         tvc26XnkdWwS2zEoJ83TXtGk7qjIJWdRohzud9HUtovxpi0peORixaakViZCiHJmY46K
         y8UA==
X-Forwarded-Encrypted: i=1; AJvYcCVXNzVi/WFoZzgC8b1WyhpEk0WtEZLr6HvskZGsxVlGdQgunWzQisXB6m4h4zqOOUXewKd2OPFJaOh/zhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBgYpfRbiO318q4mZxnJuvVgJch+ZYBmvgF8RczEykjUf6mcD
	h6WUguu97uIF6TEePTpRn2JY7jgnzgWwtKwus6nZ5PHS1aIFF1cA7o2Sb0lB9iU=
X-Google-Smtp-Source: AGHT+IEuA9SbdruHeD5eBVnlwcAjleTiKR4nR44WwhRTZaq0GkM6heGs2eeyKJxyU8w6mf9sXe31DA==
X-Received: by 2002:a2e:511a:0:b0:2fb:3c44:7f8b with SMTP id 38308e7fff4ca-2fcbe0a42d3mr44496351fa.43.1730207882276;
        Tue, 29 Oct 2024 06:18:02 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d1b5asm14898401fa.85.2024.10.29.06.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:18:01 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Victor Shih <victorshihgli@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mmc: core: Add error handling of sd_uhs2_power_up()
Date: Tue, 29 Oct 2024 14:17:48 +0100
Message-ID: <20241029131752.226764-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029131752.226764-1-ulf.hansson@linaro.org>
References: <20241029131752.226764-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sd_uhs2_reinit() the call to sd_uhs2_power_up() lacks error handling, so
let's add it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd_uhs2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
index 06857e1bbdb0..f0d631b4bbd7 100644
--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -999,7 +999,9 @@ static int sd_uhs2_reinit(struct mmc_host *host)
 	struct mmc_card *card = host->card;
 	int err;
 
-	sd_uhs2_power_up(host);
+	err = sd_uhs2_power_up(host);
+	if (err)
+		return err;
 
 	err = sd_uhs2_phy_init(host);
 	if (err)
-- 
2.43.0


