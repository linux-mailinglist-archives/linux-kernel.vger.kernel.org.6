Return-Path: <linux-kernel+bounces-240760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ED5927240
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18F71C2406A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E0E1AAE0F;
	Thu,  4 Jul 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="E9GjZDfF"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E811A4F3A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083370; cv=none; b=pmeOuWW1feO+g66dN1rPLRcdDzpl2jjGM3ay1i9F/H1tBOHmS4h9WR8gH6qxgToShlr8rVWyPuavzbGt0Qwmr3jufr6kvc++3/j3umPBx3Ou/elNR1HykabNXYdbsuM9X/HRcGiscIa5244/ZIczGOGXtRm6GQnXrjbL3UKPs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083370; c=relaxed/simple;
	bh=d5j1weksNxK7Mx181KjldjiWTxmsafDJhHV9fjQXaTQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nCS1yc6uavKj9RhjTIkfU+iQi2VaAhPsEvUTFrZ5qvNMHV/n58T/w45ItXpyJXgHAIIllYxeeEL1VkhnKImEdLkpmuuB82P8xpCTY7btNjZGyqFWplIUCDaVGkCzhEpAxrsoCiZ4oumgbXIEDy0w2cPxlFcHaO6kO3pSdHoqmpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=E9GjZDfF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c80637d8adso321679a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 01:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720083368; x=1720688168; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXOoxvvOe31w1ncPerleKixgz0Ceuj04whgXRu8l0SQ=;
        b=E9GjZDfFbB+t8YrDbbk51JHijNvF0d/5P0j3NXxtVPT+POZzHFtbKxRxuM2y1RQQto
         yXQywx7XQHLLlD//sEsYCmG6YiPQmYnncjxrp3sWy5RDqMmy5T4Qhqa69CR4MInYrMjJ
         p4DgEiopF/DyEU4utRBUTP4nA76zbR8zAb2ZBzq9vM81ZCD+Gxxi0oUOeMBZBWgzuBzS
         C3PrDgTFuQJTBWpI02EWQLDMbsEob2lLkseZjyIGvJgy4wHAmnorjeSYHNV7KnqjxkpZ
         2nvmEwK1V9sIPvtm+C+PrzAKQC0yzQsBe/pjXJGaIYiYOJNVzEPjbNupK0zPf2bppfSz
         HSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720083368; x=1720688168;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXOoxvvOe31w1ncPerleKixgz0Ceuj04whgXRu8l0SQ=;
        b=mgqZX7JFaCDXhKsjjwM/+/rRaYUGwQWjJda+HApLrK1PmCi/b3dgA5lL+UIqFIxwLJ
         17OTGfLgY4Nm5+i/4bpvwU9wvFTnXJnHOcXmc5YjK1jhoovDE2ehZ3OUnvUfRqIJF/UC
         KOHlwn50ujr8gQ1Twl1yW93odlcZgW5iDlk5phb901ZKPrZ6bz2zTn3XfaRBQapiyIYW
         tBrsPyiRGlGMobyK3RKHjLcdnoq8J9ViMsnWaLeq0O4egvItOUhkCkmFwAiksUGV9Ai9
         xv52MEfLq0pkHcwmTA/U83MKvwI2zUHzS6pbJq6JB9IVE+nb5bBZ+AuW1K4KQIknyuFP
         jUXA==
X-Forwarded-Encrypted: i=1; AJvYcCWAm4bAJoaMQ+jFWljlEDfkbHXPjHPRGZy3mnpNlWOna+7y2G3fiseLYKgNiuc7yQW58B8bmbgsN3uT6ApJTVmUjRHaon+cVPhIzkw6
X-Gm-Message-State: AOJu0YwvW3+RKc8hS1+fA2ny1LoAi56XU2y2YvTZ6XqafOVZ98EnN3+N
	FZDbi2ZeE1BpL+t+f/lH3snG/sfgwEk7orSG2jU0fpn4IwbmJ3Xb7ABiUrxLtMo=
X-Google-Smtp-Source: AGHT+IEwW4pDtpfHuwfN8E1EywFvTESPh1XIyJapLgL8zwTEtD/NyP7knccVK4/CsOptrrx9sDsSuw==
X-Received: by 2002:a17:90a:eb05:b0:2c9:888a:7a7b with SMTP id 98e67ed59e1d1-2c99c570392mr636231a91.25.1720083367671;
        Thu, 04 Jul 2024 01:56:07 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a97282csm962572a91.20.2024.07.04.01.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 01:56:07 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linus.walleij@linaro.org,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 0/2] HID: i2c-hid: elan: Add elan-ekth6a12nay timing
Date: Thu,  4 Jul 2024 16:55:53 +0800
Message-Id: <20240704085555.11204-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Elan-ekth6a12nay requires reset to pull down time greater than 10ms,
so the configuration post_power_delay_ms is 10, and the chipset
initial time is required to be greater than 300ms,
so the post_gpio_reset_on_delay_ms is set to 300.

Zhaoxiong Lv (2):
  dt-bindings: HID: i2c-hid: elan: Introduce Elan ekth6a12nay
  HID: i2c-hid: elan: Add elan-ekth6a12nay timing

 .../devicetree/bindings/input/elan,ekth6915.yaml          | 1 +
 drivers/hid/i2c-hid/i2c-hid-of-elan.c                     | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.17.1


