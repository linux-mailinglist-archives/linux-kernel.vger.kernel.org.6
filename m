Return-Path: <linux-kernel+bounces-387012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66E9B4ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060CC1F23B78
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC2206071;
	Tue, 29 Oct 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqxefMWX"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675D920606C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207884; cv=none; b=WVQnVPiuSHXMA/o4QRN6cSc1HHQFID/x6eiUAUW4uyYa81uPjiDEKVC+1Z64St7c47p116SENK+9QABQMSylHbSEpAAFExVY259VTGDnpQlaB3yK4WrF6QKV7UjLUCMwy5xojikZ7G+tUBBpqGO5U4YC2H82BGeMjZG0mqBQ164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207884; c=relaxed/simple;
	bh=tbrsLuMVRxfbdM+tKhvjJlm+GMhkqqKgd5n4oCIJnu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tF6W2ts+6kqYhvdKNC++Syf6YOjltNxCvNHuFu9TvpgTY6Mw7GYZCYtnlCu5Q0HdJkoKuU1EuUOWXQgjyYuC+hMBCaZsuAVX31KvuJqXtigLITMr1PWSfR8v82aJHJnjV3ctHzK9oYJCkzxtGa3P4QJWtkcVZeDk8BO7mJ3+lv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OqxefMWX; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso53900761fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730207880; x=1730812680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vs9BGg0Sepok2r3m/1kt5IOrhPFaUnN/UPddfC1MiiU=;
        b=OqxefMWX1hnxIToCX4htUZQ4MfghaPkY1ANB8y1pPmzFVdfHaxJBw3jqIpB93T2I37
         ruoCmWWmrcYSrmD+pTCqJzyM91cWFBHWhiea7wvesqQvxDA7jEoLQ4RvKFbnC6ShcGZW
         bTTz3CqkTIlXP7WszgLkBKOw2aeBcErMk4dvfi40farUnTS4G4aTFBf0unHatFHjtNtC
         SqYwID+zPGivVbJefXL9rH39zMAh3Yg5czs2kLrdph2Y/VvocudejHg1aOK9UOh2MNrb
         y1sp+6w8ppqITeDAPl7fG7T1ROxYp8JzyKZH/jYiWOi7Z9dKQBrD6qySy9HuQI9FBte0
         9BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730207880; x=1730812680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vs9BGg0Sepok2r3m/1kt5IOrhPFaUnN/UPddfC1MiiU=;
        b=g1puLB2a/wGmmeuZc954URd7o3h5GWe+AunmQb7PTkZzgnpPvc4TJiMmoLSg3WIwnc
         GEW8XQm6uYF3BuL+3LCDxOBxTd9AFySQsDZIsW31Jy2NIWEG3e0Jp1OogTzx5+kATinP
         BLgGysJE/pzMuYhP2rBX/sN7/N77L9iId00JLYzR3ynOpg4qB2Ri1T8R3i6T2eN/HWjb
         BlgQewbeeMNBoMRfs4TmAnftzuAXKyQJ5QsD75/PwgntyGFoTBHEgJkWXS5mFxMX25ln
         OuMM8so/gTtZadxfJe+I3MsH7OLnReGvwcP6oOJXzI8aQOF/AgzWkuNTxhjkEUayTDca
         Bt7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW0W/EpD9WYvgvwr/E7sg8w0ORXY4uqs+fcZ/tG4NKy6jNw0OLDEbbXlSPQhRHlHmXEVnRtVZyEJ6QtCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5IKaLAQiXf4FJyyxSBxYRKqF70obCa2LMsc3dPruP0xLYJ1Ez
	bToSLZuvAlB+X2pJRLdQBuEj7z6NQH1Q+sF5HBtIvdHKPHLXmk8thJj7pQ+iyug=
X-Google-Smtp-Source: AGHT+IE6CGzytnqqE1T09qa3lAI1opJSQ6Ui80bbcXBFon3dIlI5e5lZjNDAjRHa3/rmYcd7vsI7lw==
X-Received: by 2002:a2e:a801:0:b0:2fb:4fd4:668a with SMTP id 38308e7fff4ca-2fcdc80b0d3mr7977101fa.22.1730207880378;
        Tue, 29 Oct 2024 06:18:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d1b5asm14898401fa.85.2024.10.29.06.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:17:58 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Victor Shih <victorshihgli@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mmc: core: Simplify sd_uhs2_power_up()
Date: Tue, 29 Oct 2024 14:17:47 +0100
Message-ID: <20241029131752.226764-2-ulf.hansson@linaro.org>
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

Drop the redundant err-parameter and just return the result from
host->ops->uhs2_control() instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd_uhs2.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
index ddd2291ad7c4..06857e1bbdb0 100644
--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -48,8 +48,6 @@ struct sd_uhs2_wait_active_state_data {
 
 static int sd_uhs2_power_up(struct mmc_host *host)
 {
-	int err;
-
 	if (host->ios.power_mode == MMC_POWER_ON)
 		return 0;
 
@@ -58,9 +56,7 @@ static int sd_uhs2_power_up(struct mmc_host *host)
 	host->ios.timing = MMC_TIMING_UHS2_SPEED_A;
 	host->ios.power_mode = MMC_POWER_ON;
 
-	err = host->ops->uhs2_control(host, UHS2_SET_IOS);
-
-	return err;
+	return host->ops->uhs2_control(host, UHS2_SET_IOS);
 }
 
 static int sd_uhs2_power_off(struct mmc_host *host)
-- 
2.43.0


