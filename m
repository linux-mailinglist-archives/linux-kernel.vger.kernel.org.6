Return-Path: <linux-kernel+bounces-315790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B496C705
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B74B228E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FF513D630;
	Wed,  4 Sep 2024 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY6mxf/Q"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8913C69B;
	Wed,  4 Sep 2024 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476593; cv=none; b=usGphj00URNYZm9E1W/tni/7qQWEl7LLp9FMDeQSnNsC2wUE1rwvP7OkTNf+dFnyzEX03aoMh8Z4eGx7S/G5kKwPoyije2h0uMw2b4C1vvNONUDK95GX3OBiCjsP3Qh2Jjl9O21vEt91lWne2hhi1AueGXl3gizzyjkxozkulzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476593; c=relaxed/simple;
	bh=xY9n51PN63KEhEPxxjelhzy7Qf2NkTS9t2rG1XzDiQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a7OBd6gGG0XpCQtUGVjUFWKvgWiY42BpnSG/xQCaw3TwqOQ/IszMKC1w98SMsbA/UnuUIP2hs8MvqgGpy0uJyaV9sFpggfKzTZXD1PCQUmLiSQvWtjlH2iWQ4JG7Uqt1i12F1zon+XjHU7vLMIXHjgficzg9nx43aQWmKVt44Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY6mxf/Q; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d8a4bad409so3094750a91.0;
        Wed, 04 Sep 2024 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725476591; x=1726081391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kMUTvlKFCoe0p/yKImrYnJiSzgd4ECcJ28TTijkg1Nw=;
        b=HY6mxf/Qisvk14sZsw7S24LWn+VOWKzOqFa7H0bj4DFjCZ+uFOmEpxOVAYFBS+w5EH
         kbAUPcj6mHgMCtaFypnBEQR7d2QNBYaYu6Hde2i6bpUsmPXEsvHmqvQWuEPOEoFtRC7W
         nv+RwCo8l8I/w7MnEaMBcR0tAhiyk1eXlHnW+SzfLh5Zs5NNOudbEGfuIH23bnTa3NrU
         b1+IpO8RThYVsSPy7PlDPhmHH5b9eP0o/XGvWsrYW+ieErFmfgg1BXDr/1KdItU2Q6C3
         p+z0271Y7vhhBFa8+vjd2LZeVQtCCR/F/JWKLo8g4aFRyNpNTh35Rmkx0k/EePDUgOMU
         FGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725476591; x=1726081391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMUTvlKFCoe0p/yKImrYnJiSzgd4ECcJ28TTijkg1Nw=;
        b=dtVGIXx861hmkW+C4YBJv72uHpV4VYkCSE/JspZuEOQjkDib/vXRYqLQyA3cfjsupY
         uSuWXtfjpW7lHh2ioDe6F10ERutpEm73Fwnpt/GeDUpnWBiRXvYdVczVzY9TG/NJvXUR
         MzUE4Ane1kFc22emXPD22iNbwSN9T+lsqxOzPcHHrBjcKe0X7zcV5Es3NxgcY7QNO3O/
         I+95m5UhOa7xq+VZWkB0HmlxZpoymlue7cxsJEOokaJQdn81Sdyl8WujInI7H7P9Ez7l
         VnEi5A1c791pTQwD5boFsHbz1YuCRGmUsIjJDi9KkC40UJ/BcAefowRWjMSkZ5uU3Koh
         kHxA==
X-Forwarded-Encrypted: i=1; AJvYcCURN+r+5NR9aXeFA2bpL8Iy+5lA4wXhG7Gcmp+lVXj7F6opdMd3jyygr0XEdEPtgFPx/j7q8exJIN9M0ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+w9UN5pYqbGKvHyKxwgNRZFTOpXPw5Z0d12B9Mh9N+RhsTeD
	6k/H0E0BtsYbqoBaJeXpU7QEPVKQI9b3XHhtvBq1ZvpeexCVRojuLOmKHw==
X-Google-Smtp-Source: AGHT+IEgR9MgYD1NTzMg5Jsi7Gj/XgXckhmwgtgdVyw0YSiMsPdoDsq/8Nl5kZUmMHFN7j7hmrkWDA==
X-Received: by 2002:a17:90b:104f:b0:2d4:924:8891 with SMTP id 98e67ed59e1d1-2d89467ed3amr14310767a91.38.1725476590947;
        Wed, 04 Sep 2024 12:03:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8f0e9c7b5sm6125022a91.32.2024.09.04.12.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:03:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.11-rc7
Date: Wed,  4 Sep 2024 12:03:08 -0700
Message-ID: <20240904190308.226166-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.11-rc7 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.11-rc7

Thanks,
Guenter
------

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.11-rc7

for you to fetch changes up to a54da9df75cd1b4b5028f6c60f9a211532680585:

  hwmon: (hp-wmi-sensors) Check if WMI event data exists (2024-09-02 07:23:35 -0700)

----------------------------------------------------------------
hwmon fixes for v6.11-rc7

hp-wmi-sensors: Check if WMI event data exists before accessing it

ltc2991: fix register bits defines

----------------------------------------------------------------
Armin Wolf (1):
      hwmon: (hp-wmi-sensors) Check if WMI event data exists

Pawel Dembicki (1):
      hwmon: ltc2991: fix register bits defines

 drivers/hwmon/hp-wmi-sensors.c | 2 ++
 drivers/hwmon/ltc2991.c        | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

