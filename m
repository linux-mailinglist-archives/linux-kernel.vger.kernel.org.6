Return-Path: <linux-kernel+bounces-551079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE03A567DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0FD3A8F83
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B14E218EA1;
	Fri,  7 Mar 2025 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AYBYWcuQ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA9014A4F9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350777; cv=none; b=GzGf7cIrcWwaX7G9K1r+DyLlYhy3tvMIen6DugKSWTpFTyx5H09Xxd+BMfBRKWN5TMnUe/iaZONeWcjOyd82ZcU/zojuV1hn9l2enshMz/xg05dPkSSzKKX2srqPJeDXhVaHroJPcdWTpA7lEocU+4+Cg52EQ0156SFwvsbhmLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350777; c=relaxed/simple;
	bh=x0KNblaIRgSJMApw2q2ASsM7BQ2eIFQHYxnjbxM69Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KhL2k5SMSd7JUNt8h+icX7NAm6zkjCV605BcQFKeJpMzKjq6psy40FfnRZYLDpZ2+spraMh1wSbx3slAT2a5k0+0hfHNjn5yW+I3Slig4eu2fpeAaStlBU0++YhTh3pyLk7Ms28nunWxv+CJzJKU3MY5F7JTIDwvgp7XH64nusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AYBYWcuQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso1409661f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 04:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741350774; x=1741955574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVLNbVcf5J5tHPSW2EA0QuyhFRjDh+ZXmGhDgOad+9g=;
        b=AYBYWcuQ1uBII9L4+9FLTon/N0j84KTL2d0XiP4aLQh+tqIf13oqnMLISGbjtoW6wO
         wSf71eVCEs8Q+2LQXNIJlyusa9GucxV8tveNS6Otxd2kXgs62Mu6ssoBrpUU00oiwEEl
         RYvjYH/uFIpsTGDkC4fftuzcunmYgSLVJmV9EWCK3+H+apNkrafgm09wSbWgqANulPPL
         HuKJBIblJnNzmYrHfv9BwgNuFOQPZhqp1fDpHPPd09mtsb8l6vZJqJXfb+FJ3gUKfGEL
         Q58nZ2bWeJV83DoBz5RBsLUPtR13VSv2tjjl1SHVf2EJJUFYmECxfT21fSsfgscrpKa3
         /wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741350774; x=1741955574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVLNbVcf5J5tHPSW2EA0QuyhFRjDh+ZXmGhDgOad+9g=;
        b=gz2D11rAJSpRpSNLqiM0a1MKHOzWwSmg9WaZIBRftOGMs39YbiHPh7bUlxeDInYZln
         oV/H3o+Nbl29ek1+lOQgXKAKxTD/agcUAxhgaJAevj2wjb169QsLeW00nya1xPNJ3w+2
         jXBlp33KSyJV40vaFfreR3qL5QSWVm74VWmfjrupjugdjAPYEd3yGeJUycVvNHO7cXK5
         Hj7exlfo1HbQ5OiXr2zqmT67mxpbt/Ibz7DhyKZzMtdJjP0MxWuvHi0usDQs+UpEBqHo
         BpKJSshVn0faZvnTRoSroxs3UIJ1wvvo7SO8f9/4yvWaq+988geNjDfihOPhn9ngVz81
         g10Q==
X-Forwarded-Encrypted: i=1; AJvYcCULE8SRV0Hmo3NdFJDMNqWeMYB2gTCstHpU7KVZWvDMe/hIQHjmGVtNHba9xOJKfmWkt4MsH/zE8Dvo6kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYUh0UDc1WAjQAsUyFGmAANbhojYoTmirclbsJ3Ob1vi/Ru6x
	dzOyNsaufHuYhUKcxnyW77IqtuqEU0Ojjg7qnbwn3g5yjoxo/VtCg1h3C81/SC0=
X-Gm-Gg: ASbGncurH6JGb3nI16ZVFwrNA2BElWz8yuZvWiYeeHv3a7yK2hFADe2XuYCOuSVW5dv
	usU8n/HMWTPZisiM+/yEndTzMbI8KbUWLiDhy/ppZ4Aht4fbw24nkLLo5l26gHqis3lbwoTM076
	HARDxJBWmWylxl05x5ik7m5vN7+nP/5m8HBZR2WVX8zqg/BuusnepFN5gBHHlKH2pPG349WEdlO
	3zVVUtZQHucwAMh9ukVgM14mzeMk0YrYC6KT65TEUmku+0e2pMykQCJrJ96dswe2iJyjpB2r3xX
	Dn7gzbhl3phFD6KyOp3woeAYv2o8baElidvxDdnwSgs=
X-Google-Smtp-Source: AGHT+IGuef6pKgiNyF2uu3DNvcdOFkH4Hdb6WvXNB65WXsz2EKPw7vJT7pFnYFyhkFEZzi3HaKoaLQ==
X-Received: by 2002:a5d:6d8c:0:b0:391:2a9a:47a3 with SMTP id ffacd0b85a97d-39132b5b802mr2169697f8f.0.1741350773976;
        Fri, 07 Mar 2025 04:32:53 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:f9a:e2a6:5c12:124a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfbab43sm5297046f8f.15.2025.03.07.04.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 04:32:51 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.14-rc6
Date: Fri,  7 Mar 2025 13:32:47 +0100
Message-ID: <20250307123249.28832-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of GPIO driver fixes for the next RC.

Thanks,
Bartosz

The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.14-rc6

for you to fetch changes up to 391b41f983bf7ff853de44704d8e14e7cc648a9b:

  gpio: rcar: Fix missing of_node_put() call (2025-03-06 15:51:27 +0100)

----------------------------------------------------------------
gpio fixes for v6.14-rc6

- protect gpio-aggregator against module unload
- use raw spinlock in gpio-rcar to fix a lockdep splat
- fix OF node leak in gpio-rcar

----------------------------------------------------------------
Fabrizio Castro (1):
      gpio: rcar: Fix missing of_node_put() call

Koichiro Den (1):
      gpio: aggregator: protect driver attr handlers against module unload

Niklas Söderlund (1):
      gpio: rcar: Use raw_spinlock to protect register access

 drivers/gpio/gpio-aggregator.c | 20 +++++++++++++++++---
 drivers/gpio/gpio-rcar.c       | 31 ++++++++++++++++++-------------
 2 files changed, 35 insertions(+), 16 deletions(-)

