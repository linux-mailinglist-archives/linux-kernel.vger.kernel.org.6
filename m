Return-Path: <linux-kernel+bounces-316113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F9C96CB70
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B879B2479E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD13181CE1;
	Wed,  4 Sep 2024 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0bGKPKz"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E3D13A869
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494224; cv=none; b=umdXm519XXEPrPtT9a0jEbyqTXsn+Jv0K+uyb8BSdcfW4FG6Klh73IjZgGzoz3tUmt72QRr+XeAobMxfQ6n+zhL9g3koQtkCvcyEAxygqwQAxY6dvI8K5qH3xV+8JpxJC6gYpncSiZ3kiuLK/+gPibnjK6JLVmjMPlSfab0JZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494224; c=relaxed/simple;
	bh=P1V/iTkXAX5je0mmSGA8SUIUYkanDp8ZLHxeKrihSbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LTU9VRf7ZLrkFRaFqqOy3WITDHwBExSObakMRoHN3t0rYJt0H4wHaYUuXjDnUM5fmT7kOQZ0hNxqQ8rF3n3O9Z+rp6Z4I9Y3Cwwd4tj6OEpqpyHsOkwQWQhrFqPWr3TydX71/134fkyvy2TyxkijGjBASXKB4bnf3QIMmktRTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0bGKPKz; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82a626d73efso6958639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 16:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725494222; x=1726099022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F2GvsxqrGhdBZJzoxaEyme4yyK4FzYQjimMYgOocqX4=;
        b=k0bGKPKzr0upQ50rosqoQinVjC36aPV1PI8RlvYKGt/L8ARp0YwNv4o3MyDgBPegbj
         ElsHQPHRVQcrpoVWbXg85UQGLUsZkOkQ9H0E6X4GksTL7dobruH168Smj5UiMXFxPDgu
         A+PL19/YUNKhrOY78crqqJojBFjl+B/RT5bt01CQrL7sZ6HN/l+wrNaW1t/EELbEPOCq
         8aDOvN4iXex9OMyy4CAqj+CS0bcqQA+jEnmF2mSw45MjoyECgF3+RJdWVDQnD6bBNTHB
         AGpf1rfLNXDwuCa/JuXKnXev4G0ve7yAVcIWpvmnjOybjDRoxGCwezt7be57FKdXD+ha
         L1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725494222; x=1726099022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2GvsxqrGhdBZJzoxaEyme4yyK4FzYQjimMYgOocqX4=;
        b=fYVQp2s56DGC0Gu70uHueR0RmULUDipQ2Bwk4pDWhNLcFznpf2SCf6Uh/czTKvxR5v
         97tAyk5qQhxtgAAj3lveHm23YtsUKY5/OXe4pG+3LP3RiryPj4LtUX6UwE/8vr0sLxFK
         afjfBuKHRhKTxxJnLF7YW6eMVEs7o6XJXWr4QT3KMLHhu2ctO0vs8U7GHTDNA6i1pfze
         EZjuyBb9c5eryoV99Q7nCWq7PLkyejPQnUABOUBsD0ClHIVMrgXJyVDSsqr1Plr8UtpV
         ae5FtFSzyO7edOoXIStSqMf/Yewgu/CkKcBSHpocq9ehftWx9my4AANShBb5WQVzmkiH
         OOow==
X-Forwarded-Encrypted: i=1; AJvYcCXJJES9QcrEgCgeOsC7X2Wh9wFrnvUejQDD32fchkwoCpxgEpEtoczrwxv355h6e1th1VPU2Ek3KnMldjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8A5DwBezcaibLKeT0Jxtdh9e6IX9WDncCapyz4+e1FssD91L
	yhwH+GMKSeFUBlATxq3TAb0Ltlhm4y26HGCYipah9ICyRDUyUyf9
X-Google-Smtp-Source: AGHT+IH2/xw7uH1ta+NymZn7qHkQdO3VJG3zbLmK705z0/0HgtyU0x7qA0GYuICzmaP9S5RtJfmLgQ==
X-Received: by 2002:a05:6e02:1d0b:b0:3a0:452d:aaf7 with SMTP id e9e14a558f8ab-3a0452dadc9mr33115215ab.11.1725494222142;
        Wed, 04 Sep 2024 16:57:02 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afc594csm39396735ab.43.2024.09.04.16.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 16:57:01 -0700 (PDT)
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
Subject: [PATCH V6 0/5] phy: freescale: fsl-samsung-hdmi: Expand phy clock options
Date: Wed,  4 Sep 2024 18:30:28 -0500
Message-ID: <20240904233100.114611-1-aford173@gmail.com>
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

V6: Fix some whitespace
    Fix issues with calculating the closest divider
    
V5: Updates patch 1 of 5 for whitespace and comment updates
      Patches 1 and 2 add RB tags
      No functional changes from V4
      
Adam Ford (5):
  phy: freescale: fsl-samsung-hdmi: Replace register defines with macro
  phy: freescale: fsl-samsung-hdmi: Simplify REG21_PMS_S_MASK lookup
  phy: freescale: fsl-samsung-hdmi: Support dynamic integer
  phy: freescale: fsl-samsung-hdmi: Use closest divider
  phy: freescale: fsl-samsung-hdmi: Remove unnecessary LUT entries

 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 570 ++++++++++---------
 1 file changed, 292 insertions(+), 278 deletions(-)

-- 
2.43.0


