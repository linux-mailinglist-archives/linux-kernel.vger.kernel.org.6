Return-Path: <linux-kernel+bounces-314079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2730D96AEA8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B461F272AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0890039FFE;
	Wed,  4 Sep 2024 02:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk4Xgyvk"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DBC1EB21
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417202; cv=none; b=eNkxEHEd0WMG/QBSkhi/CjIQ3kEvEsLGgopmpv8bX8WLDWnNQeQO36JjuvmnnweQDrsT/zRy1RSzVKuJAqZmg2+55OEJygF7K8jkZm4jsMnkgHoVWUHlJjfPuGtuZHSnob4Y8l2uHhuW+jwqkNWWSjZy4xx15gvByCJLYqSoL2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417202; c=relaxed/simple;
	bh=R+lKxRbjXcIKERikoXfNu1a0FwUXcue3CAdynxcHrGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0nwb8TMKXRPSNJHs60g/KF3uksq8VwfDmS/Ik7LkxZQV7OlF16v+bWR4SOP2Atwjn38FxAbt6sBq9kfvBe6/KnEZc9XS5sCNj8Fat4P5u/v5636zZuytOvKdRycX/0ZdZOW+XaOWeDAOjy/3HAR8Hh2IfxFbnDaOfhiCp7HkcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk4Xgyvk; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82a1af43502so307149239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 19:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725417200; x=1726022000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Cq4uRe87nNpuluoh2u68vh6xZwB2FqhqnMAWLtSiFU=;
        b=Sk4XgyvkWY6NlL8QbIWi9RUec0GyBXc3QyKHCPM4aV7n+62WSSy0MexpoYp10C86nH
         TqZAho9C7nVryFN7Xe9Li2IZYos0mKUYrwkAUimDbwarWz8ODjJRwceAtGGbSMBzLonh
         DPeGk/Z69/OE2umdffSNsft8orBn+THrb4oweyR8/E1aYJwW2vKzecQL7hbtck3YjEQh
         2HA8D+KKifc/pehHoKbrE0UJnzPzpgG8dH+udlnsQ/lHKLgw+69OtOuFgD6XmIWcgNY5
         ROpp4IBsV/8WPegqEtTfbGsVf+VaMlyYCDimluewcevCTZGO7VCxtJmaXkWSW18YPdxY
         IZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725417200; x=1726022000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Cq4uRe87nNpuluoh2u68vh6xZwB2FqhqnMAWLtSiFU=;
        b=hmYWOkeKZEP9fnMoQlJ+UFg7NIisRA1K7lxW1nQDQwU5k0UdOGzvGLbe9sx42jXxrk
         0S3AI9ZwnFPQc4N/Bxnd5wneVsbYkrEiEQfqB1HqLBMPw581BCSoFhinw+rwXFKQAbf0
         ag3LgjX1UUIWu0j+YSL+C/55D95MGOWMoqJoynDdjp2JudByPgj3rEDMIYL0HxVquLDv
         SdaBoeCZSFTYqKCpjhS4I9h+Jxo2hGmv29FRu04NNnwxXeY2CvOHQZwylbWdlCyV5Aol
         tlk++hWYTa2HPilG9b69OI6+b1JRUQgsVaIFg3TxaK13Elpr9LLIaHpB6TAT/dUJ2M//
         Ov+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWTs62YCynOBC4CcjXEv+FdwCrklwstqBUwQlUhWlzU/V6BIsZ1L19zI0Xolba7mK7g2g1DSeLy1zx0X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymaS3SBoA+6dDWqCj/Wf8hGOghY1AYGDZiT5nK7xQEvLSnI9c1
	0Gbqs7B7DPhOYsVt1ImjMPjOdklAtyX7E1rMiyFFcnUgkWndZrr+
X-Google-Smtp-Source: AGHT+IEnNoDnJJHEsh46v8XZWeTjgjrjPV2KXMHRMeK6JATQURWY7kyHULcOTy2yDMp7T4Be0RCgtg==
X-Received: by 2002:a92:3643:0:b0:39f:526b:c5e1 with SMTP id e9e14a558f8ab-39f526bc781mr96172755ab.18.1725417199953;
        Tue, 03 Sep 2024 19:33:19 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afc4ff6sm34556175ab.37.2024.09.03.19.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 19:33:19 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com,
	linux-imx@nxp.com,
	festevam@gmail.com,
	frieder.schrempf@kontron.de,
	aford@beaconembedded.com,
	Sandor.yu@nxp.com,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/5] phy: freescale: fsl-samsung-hdmi: Expand phy clock options
Date: Tue,  3 Sep 2024 21:32:39 -0500
Message-ID: <20240904023310.163371-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Currently, there is a look-up-table to describe all the clock options the HDMI PHY
can use.  Some of these entries in the LUT are using a fractional divider which does
not have a well documented algorithm for determinging values, but the the integer
divider can use an algorithm to calculate the integer divder values dynamically
beyond those listed in the LUT and also duplicates some of the entries.

The first two patches do not do anything functionally other than simplify
some of the register accesses and de-duplicates some of the register look-ups.

The third patch adds support for the integer divider and uses it whenever the
clock request is an exact match.  Otherwise, it will use the LUT as before.
The rouding is still based on the LUT if the integer clock isn't an exact match.

The forth patch updates thes set_rate and round_rate functions to use either
the fractional clock LUT or the the integer divder mechanism to determine
which ever clock rate might be closest match.

The last patch removes the integer divider entries from the LUT since by then
it'll be comparing both the integer divider calculator and the closest value
in the LUT.

In my testing with a AOC 4K monitor, I was able to add 4 entries in my modetest
table.  I do not have an HDMI analyzer, so I just used my monitor to determine
if this series worked.

Adam Ford (5):
  phy: freescale: fsl-samsung-hdmi: Replace register defines with macro
  phy: freescale: fsl-samsung-hdmi: Simplify REG21_PMS_S_MASK lookup
  phy: freescale: fsl-samsung-hdmi: Support dynamic integer
  phy: freescale: fsl-samsung-hdmi: Use closest divider
  phy: freescale: fsl-samsung-hdmi: Remove unnecessary LUT entries

 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 570 ++++++++++---------
 1 file changed, 293 insertions(+), 277 deletions(-)

  V5 Updates patch 1 of 5 for whitespace and comment updates
      Patches 1 and 2 add RB tags
      No functional changes from V4
-- 
2.43.0


