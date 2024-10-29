Return-Path: <linux-kernel+bounces-387011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4ED9B4ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4E61C228CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1695B20606A;
	Tue, 29 Oct 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y77L6Joq"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538267FD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207881; cv=none; b=KqsNv2p+5G5gg7MlLs2aAaOstDEW0Ei8Uh8Wx7rjHUdl7ZwrPDkcRY/WGXBzWqsqFvqrbEYaXdUzb/NvqKqNbhsm5GMpGbkIt1b993p0vHXMlV9rxwqe0VRi0V/hbzUSqDLGortpHq3J3Y0hSDzD1mvhPzH0Ea/s55e67cUcsZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207881; c=relaxed/simple;
	bh=jLhj/ex+QixSb5i4w3Tt6w0jRciwP4qE1O0l1pqDbdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6dVNgGRVpxXY5LR7Bc7fBHZHvsZ8YnMKQSeTnJIFt4kUZHApFn0Hrz2EeSRuzED6QLRLnXwheezLSDzRWSS/A7uTysmgm4GaXfT5k5LvoocOEG2eM35JI4LwCEXnqvsQoribTXzx5nDdnLeCv7sU3cKkiN37P/+tot70jwL4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y77L6Joq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso53900221fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730207877; x=1730812677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1N+vVVBQWYgpIJyhvHjDiFW5w7UYJ9BQQQxmwzMHM80=;
        b=Y77L6JoqZVjEWEtTYjj2YTmCtLr4r+VuKJNbfQZL5pGiahhYIAmRSxQ6KfY+WW8dB7
         QwsYNCvW+xSSoVk2XnHqnNtKrMMe2Y2jQ0RIGtZstpX6Hc35B5lfVg9gfjyyWAUxGZFG
         IhhdySVzDZRqPZjJH11+fyaHxEZ4FgBKOL5id/ccHS2pUf88sgW7bm4WIJgz+f4xFlMI
         O/UcmmDkd+rdeNBa5d15trRz5n0BnYHiqZuHRcHLLVBHq3hA8zKw5mHXDT1VdshpQ4SD
         DjnYeTRUubXuWYteOjGl5rJD6p/JpzdZIjULgdCVBUp0YCPuQWpiIk1k6xT596kA9Rhx
         B++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730207877; x=1730812677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1N+vVVBQWYgpIJyhvHjDiFW5w7UYJ9BQQQxmwzMHM80=;
        b=dUlhIuW68fbIVQ1+TFhkmlNKKWwmBWGcXGLcvLYSBc5Bdj/+SJGO7TQAjxIZquh86L
         JxaGGwPGkRHplI5ISQq4ONELjv6V0dtEbJQa552Bc1Ne5XPaVlW90tb7se4JiYZhf62p
         wTUfaKpNvaKQlW/j716s7Ux/OI+JzdQvb8Te6oQsBWBtX5QdkYRv0FnhZAXfMJqkHocy
         AMM8nRNz4NVY2F3okb/atGE7vrd7RDrZEd/To1Aqwim2Xh4aIwkIB0+gSyuw1qsOXbLu
         Kno/Oo0EDZfsTmIxQ33fgIKC5P2M6d8zdEicKWryp0BT/WaA7Bcd535MhyVue4y1v7at
         6Ehg==
X-Forwarded-Encrypted: i=1; AJvYcCUib3hamyVk4IitdPNEo2CtvMrtJpcYCGNvn7u4+gOgPepAjBgc8lQe/xbspH7qUi7o9/p9NBOC8lYO6GE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqgZGKJWliVrH/9L6A3kk3u2Nh/gTI0Vkk6sIuajyxsNZGaiXN
	mQ2tZjImiOUEPzqInfgCrFm8IWcaTDc9co6pwQ/4S4VuT1Xv6/PNXPnAE4zgiX0=
X-Google-Smtp-Source: AGHT+IE5RkhoPl4UK1lubh0oY1lGyCltRVJ8yBpNvSjZBTTKrUGFH8tKo8+D0eV+y9T8vsN+I18VNg==
X-Received: by 2002:a05:651c:1545:b0:2fb:3881:35be with SMTP id 38308e7fff4ca-2fcdc920ea2mr7062221fa.9.1730207877490;
        Tue, 29 Oct 2024 06:17:57 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d1b5asm14898401fa.85.2024.10.29.06.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:17:56 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Victor Shih <victorshihgli@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mmc: core: A couple of fixes for UHS-II card
Date: Tue, 29 Oct 2024 14:17:46 +0100
Message-ID: <20241029131752.226764-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recently introduced UHS-II support to the mmc core has a few problems,
during the card initialization and re-initialization. This series intends to
addresses some these problems.

Ulf Hansson (3):
  mmc: core: Simplify sd_uhs2_power_up()
  mmc: core: Add error handling of sd_uhs2_power_up()
  mmc: core: Fix error paths for UHS-II card init and re-init

 drivers/mmc/core/sd_uhs2.c | 65 +++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

-- 
2.43.0


