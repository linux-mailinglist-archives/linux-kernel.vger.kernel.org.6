Return-Path: <linux-kernel+bounces-298622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDAF95C988
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C826285F67
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB10514F9D4;
	Fri, 23 Aug 2024 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wCkrQvby"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501B13D26B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406395; cv=none; b=dHhhjNDUNyTx6sXFNUIIOuxz94VliTI6vzBUhxg6IEUxDXvMXzgk8W8/ndQ9m71u/pXbc7BZHXSpmO2vvwj7JoAEniqqHv88Y0zv8tUjKUarYrjTZpf+yaTsorQ8tpaKQ3bNPOoLdq6bKObtZmPXY+SrKh1D/5bE7cETq4d5Oco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406395; c=relaxed/simple;
	bh=Ap/x27+7809718JeEKye8qMyoPqWfzWvIeTeDRcXon8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGiRBkIqnj56HUJZXmq71/VG9bBBas6ESzwFJij0xamfEwomyMouZItCSIHTjKsqUCP6U384EQzlx5XkExNY9w8997xFHpK9dBQQWtAXNXVkq49pfHxkDmR/cDLQvfrp12eWZIIJ4uCT3Isi7DHIpDs1BrcDqJBeRn1LRltENVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wCkrQvby; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42809d6e719so13185685e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724406392; x=1725011192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGPaDjhAkHGO8KGQapFP+sDknrfRWsCW7Ql+/R3WyIU=;
        b=wCkrQvbyJrMHvxWsW2j/P2C3cxvAtITq6WEBEdPbb6qMrwn8T6J3v3p3nV2GhjsJED
         Dj6nMEysVK1/sbUSUzE+xjSACDocfSVai7SApG0m091aQbx2l77ukmBzQHCi36KufSKX
         UocWkyJc1cZtifhAww39AVQ2Ds8OGbYOPf1FClrqhkM8ONp8vGgWtXe32WK5QjxqozzE
         2RPgbnpMzwjv0P2Nzt+SrgjqyjuPHogFcWVqXDAzjFt0fbkiMK5X7AwLlGT9gri3blM1
         BFb/V0TWTnuJzou25EvfDZYXGYwlsnu7AJehBIv2MOujqIVppBSsMhoncGKcjdxc4jI/
         oMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724406392; x=1725011192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGPaDjhAkHGO8KGQapFP+sDknrfRWsCW7Ql+/R3WyIU=;
        b=fK0RoABxYg7bA0hueAhuFXOL0Ej7Sp++FMEzx13MAG0ub1PwKyDlg+LVb3m2FGbaNp
         ZQUfkSWp/SmwWh+f9/QJ0OPa0UP0wRhM7T4xoLogYqBwHA8vQb+e/Sgs7BjZUrbbEI35
         UeCfpJs+qW+wjriQ6gYqy+RfD/PfeGHJP6j/0jfU6vgsjQ0duR/lNOv5/qyEstAIDFeH
         5XUecLjBU5kL97u6UH0c+1nLHd9KXvoK1j4e8lzVWlC9pRA29C4paiva9Dcqkf1vcEC4
         V/nsDvswmUrukPeZY3618dz+AT2dZNDnvx323ZJHpfrwGNtv9gnFy/4ML6WQX70z1Q0O
         p8PA==
X-Forwarded-Encrypted: i=1; AJvYcCXqESOo6LUKsJf7EUYMxv4ZJ1LKdqMyZuNvCelCgSJz2neR5y7qSxiAemACGWhKQsFwJ3v28TUDB686ZKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/4GQF4012Ft3QJAXl+WXwE1w9pLSO2oTnIhzhw3bf3IfGY5x0
	3n1jYfcCqsovKGL1VRr2EHwuDTeXeFBdqEbdH1ymKrRWWZS+TbKkiJ9lSpR/0WVmQbKde2v36Wj
	KG54=
X-Google-Smtp-Source: AGHT+IHYsgKtUoCDnzdH6uD5d0NfJ3+hk3bYjAi0XoXU+y4pxwIErAgW9mmzqM5S5l2DkXxJhwf0Og==
X-Received: by 2002:a05:600c:3ba9:b0:429:991:dd71 with SMTP id 5b1f17b1804b1-42acc8d4bd5mr10318805e9.11.1724406391448;
        Fri, 23 Aug 2024 02:46:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:58fc:2464:50b0:90c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e1f7sm53640585e9.5.2024.08.23.02.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:46:31 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] power sequencing fixes for v6.11-rc5
Date: Fri, 23 Aug 2024 11:46:28 +0200
Message-ID: <20240823094628.34085-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following fix to the QCom WCN power sequencing driver for
the next RC.

Thanks,
Bartosz

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git pwrseq-fixes-for-v6.11-rc5

for you to fetch changes up to a9aaf1ff88a8cb99a1335c9eb76de637f0cf8c10:

  power: sequencing: request the WLAN enable GPIO as-is (2024-08-19 09:55:53 +0200)

----------------------------------------------------------------
power sequencing fixed for v6.11-rc5

- request the wlan-enable GPIO "as-is" to fix an issue with the wifi
  module being already powered up before linux boots

----------------------------------------------------------------
Bartosz Golaszewski (1):
      power: sequencing: request the WLAN enable GPIO as-is

 drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

