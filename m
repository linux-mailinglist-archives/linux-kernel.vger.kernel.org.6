Return-Path: <linux-kernel+bounces-569812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA72A6A7CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4681752B2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FEA224248;
	Thu, 20 Mar 2025 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1lWHOCQ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04A2222CF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479254; cv=none; b=AGjJz9jfqEwDMZVPMCljOR0/KPhuFYAIxQ/3YNs8zmHHGRhaxP9AAHMA9W3V/nFTuAbjQDu3SphqiYNSeBeAw6uAG+eIEWcrOQ2KE8Hyed6n19QZBFeOBGWk3X+MB069ooypEdDzbSHG0e+MS9fI/gwMiHMrUZKu0w1VTvlWFNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479254; c=relaxed/simple;
	bh=TMAuU4onZ/cymJIqOhYHnqnXdS4duBL3QBe64ptE4WE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBdkFghCi6lP6caszLrxrt0XaYXxnlxZ+z0/bZI3noNACZ8S448ZL2O3+NDTxb5E8y41v6kjYC/KKuWBSB4M8Z1aGNhmvPP5pfXVnikybMFRrcFs+tZIAJMFoN1g7hTvXO9aRVC/CMu3YPl6HPBFhTAeaNxNIPas6ubwmEXjDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q1lWHOCQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so976153e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742479250; x=1743084050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jVzbvi3/XOkK9yO+8BTkmB73EOh3os+jpQOtKlsdsjI=;
        b=Q1lWHOCQY33Aa/+3B6BQRldaZyHpuImNA3g9jUhdE2SkBpLJedbp+kAVzwCR5DS1jg
         n0YgSQPkgMvDqmCEe3rULS6UKStWjWRugpgKfVSkjMAd57oKyvsB4HdGGoiYIXcC1KUr
         sUrlQ1MJKu2DEi4pgBCu0mBd26oE8WQIRKwcIBbnIS4iJfa50DFjk07lCCIHboGFktz0
         1D9ykGLkVyGk8mv04EXQPtnVfEcvqaHwL8URKhTLsGsULURNxT0Qh6vJZyrUMkgZUGR4
         PsC7bPowtMnF4W9eha7ONc7mUe5Sg7j7+dvtoLkBMUxrgAncZeZnWHCrXJSBazbrJBEo
         cihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479250; x=1743084050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVzbvi3/XOkK9yO+8BTkmB73EOh3os+jpQOtKlsdsjI=;
        b=bVkImsrbEG62vfonv3gHPVEmOnR6jNfzczMM5qoZX0LmDQxuqeovHTUvhf/uCaQ9jc
         APmNwWnR9S1ZJGrlhiQOhy+9fNZK78axV4Y8Pz8Aphn9tA83xkEmVHmcTDeDJ7azOadW
         lX62jdRXPVvkUL3amk0t0TN1wQOHM2DyZ7+BnbW67D0cffX6/qpFG/pOGUhGB3/00LaY
         cQNR4ZvqKZJZhAPAhWyqOmoSaePxLmHCgUQR6PHcGeur2gQQ2yzEKm4Rjposp6Uj/F8V
         W6hSWTdWTEQI1367XIgrTl9hl3+SZKVT48aQVet7fCmMBcTyMp3yPbbIUSozLXYfRt6T
         Htrw==
X-Forwarded-Encrypted: i=1; AJvYcCXeqNkI8vtVWAnwccoU11KGQmLa5DKROaz2hPWXNsA14L8wRcX4SalSUin7ManG+ZcP/wWgthve+8pWM2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDpAiYcPYqENzsryv8M9q+FxXWd66IDrQnW4XyCeo70O8tfqb
	kuxSi9YjD/D7mrnC0LnK31mH+T10noKjig6/6MqQ1f2FOLQ67MdIaoWa/seEiFrxTrAgQZCoVci
	+
X-Gm-Gg: ASbGnctpjSEnDv7k9fJu/8AyBhgowe8PESLlcVhN2NQtylSKjyKx2u2JLrKWy0StwzR
	MIXDmA2TE6mVrE6Kipai1GX4Z2lqvrQWIaSdgQYbmhDT36BRBEnW70Bcn6at8gnGVv5/1Lhh2ML
	1C6HYE/uCssR1S1DZQ2TEyXP+hW3fL3inM2O6gsBwQV+pAONtCaI4aN6DBYQahQj6s6Gt/gohAV
	XZQzXlFYFG6pwr4x+8ff9nPqsA4//sP+xgL0fo/Ts/kwKLXLea0rBkUqS/Fsh2F4v9y1jFc2ZOa
	bSQthqanC2vRaEeR6eDEr5fU1OHaucoKEVxai/Otcfw0a2WicYnanPIsB3W0uuqei5O3ujE5nqv
	K3+K9ro+5K7gVEYD4MDQ=
X-Google-Smtp-Source: AGHT+IFMYBU0DIXrF7R99VRRvNyaKksRIT+6rLXREKORT7TWKL6TEFXo8/nh8xP6GcxkGQSqzFY85g==
X-Received: by 2002:a05:6512:3191:b0:545:49d:5474 with SMTP id 2adb3069b0e04-54ad062a16cmr981532e87.20.1742479248474;
        Thu, 20 Mar 2025 07:00:48 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864dd9sm2295029e87.148.2025.03.20.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:00:47 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] mmc: core: Add support for graceful host removal for eMMC/SD
Date: Thu, 20 Mar 2025 15:00:31 +0100
Message-ID: <20250320140040.162416-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As pointed out by Wolfram Sang and already discussed at LKML [1] - an mmc host
driver may allow to unbind from its corresponding host device. If there is and
eMMC/SD card attached to the host, the mmc core will just try to cut the power
for it, without trying to make a graceful power-off, thus potentially we could
damage the card.

This series intends to fix this problem for eMMC/SD cards.

Please help to test and review!

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/all/20241007093447.33084-2-wsa+renesas@sang-engineering.com/

Ulf Hansson (5):
  mmc: core: Convert mmc_can_poweroff_notify() into a bool
  mmc: core: Further avoid re-storing power to the eMMC before a
    shutdown
  mmc: core: Convert into an enum for the poweroff-type for eMMC
  mmc: core: Add support for graceful host removal for eMMC
  mmc: core: Add support for graceful host removal for SD

 drivers/mmc/core/mmc.c | 66 +++++++++++++++++++++++++++++-------------
 drivers/mmc/core/sd.c  | 25 +++++++++-------
 2 files changed, 61 insertions(+), 30 deletions(-)

-- 
2.43.0


