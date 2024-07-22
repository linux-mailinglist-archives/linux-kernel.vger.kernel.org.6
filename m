Return-Path: <linux-kernel+bounces-258581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EF1938A10
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171A4B20973
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BF21CA94;
	Mon, 22 Jul 2024 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="kR/0Mx/T"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43011429A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633516; cv=none; b=U8WUXLaQ52NxtEFWylj6Ojy0klfjuPJO5vrXB1digPuOipDWiuUA8cLHn2/XQvoCAdv88TWxRZzQmbx8oANrleshbX7ld9OtpLM6cCjlyDpDUPXEaPbmY0gAR5tpnB+vKZZ1pWZcjZyQcrNKFYSimK/ThMvng1WG3/iIbkn4r00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633516; c=relaxed/simple;
	bh=Z1FCw/x/74es6pAG95Uf5qDTDT69K4y20dS27vLH7PQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YHq2BGHdBvpjWsI8hKiWDBzUHr0Yh5yveflA46ZKT7kmJun1zmZgPw2lLsXtKSbZ5tCTB8+cEmYK3XeK55kz+iajLgfE+j82bp2f2jIsNW0mUI6ChlYbShFOcMrhHP2Q0/eQLZj3yB+XVUlz7pneg1efKRg43x4uu2LfYFVesjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=kR/0Mx/T; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d2ae44790so277676b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 00:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721633513; x=1722238313; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2KAgnjwVQOc0ZyTb2UjcVxk7fFjtqOGmwkkRzyiULQ=;
        b=kR/0Mx/T7tAiBlCJlFMdsSIsSxnvenS7Ec4+Pjf4RCfriKSAJ5RR+4t8dgCwAP9bDC
         SUWCbAG60wspcue3TlruY2fLPE78j+x3Vkrdeom6f7bxiJT/034i8BdY+UIUPQVFuziK
         /Bbs3VgexDhvVyizd4HvszE9XnKagpChWYFWVnlV+L6StOWhWHIkn1EuTVMs9S+ZH/A4
         R4mLOOlIOaLXMYVr0ovl2EB5yzI6E1Q4LzhC546F016vteTrfkFNBlpUPw/w/BKLh3zv
         LMeGtbqMuJwXP8ymTDjZK+Xe9qX0D5dfi3NPhXVW0oeVlEayKDW8QBSUZcdUbu6cUG6/
         nVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721633513; x=1722238313;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2KAgnjwVQOc0ZyTb2UjcVxk7fFjtqOGmwkkRzyiULQ=;
        b=ELhLUhytnQIWMY844BzctAMwyVUEkINzeilV41I3SMTKUDf2uS4XUczPBtW9Bh8HyL
         BpiVu9GOjRfW8M6l5ckNHmQgNB2xWekdT15TvZBR35xGU2hbjsG7XCNR98My0cfrdUR1
         Gtcr8pPeX9eBZbG86MAdKHRM57Xqj6rkA8hWiXvZFzJBOf7lDRypyNLRocPIlD9VQADo
         WvaT4k0Pv0oYLGDH4XVabVm1jHTJkY9O7wFBZL8ddtkMdZ8wsrrHcLqa+fN+TJ7uZYpN
         27ynD0DZSACkCbctgPOsLBYGfmJS+3xmrSoJXYwWiBtpHzNug06Jd9Q4Rgr3+yilMqXl
         QbDw==
X-Forwarded-Encrypted: i=1; AJvYcCXHCYfBOb6SHOZ6HtZEoHcK6Rfe1iH7qeyU0eYbwgWeFGtZL72NgH1Ur4fcRDGhZLMlb0QNwIVmNQjOViFpqXhGwQowGVTNsq7WytmD
X-Gm-Message-State: AOJu0YzMXY4pAYL3RhL6x7P7S1T+sq+tryPUb8mll1CNc07Uog0GxT9+
	8auZ06bz+bKIwPOdA8e3BpX73KROGghzsRrWJarsR7IQh3NQcA8p9gL2aztWKmU=
X-Google-Smtp-Source: AGHT+IGF9DhXIv1Qu8bMdlHQYClv79GhIKxblDYYH1XqHLI7fo+5ZVtusQJQtSx2l3XpJXTjpOMXMA==
X-Received: by 2002:a05:6a20:4f02:b0:1c2:8d16:c683 with SMTP id adf61e73a8af0-1c4228fd07amr3773629637.32.1721633513114;
        Mon, 22 Jul 2024 00:31:53 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0e6c9461sm4081162a12.61.2024.07.22.00.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 00:31:52 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Add Add elan-ekth6a12nay on the basis of elan-ekth6915
Date: Mon, 22 Jul 2024 15:31:34 +0800
Message-Id: <20240722073136.8123-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Elan-ekth6a12nay requires reset to pull down time greater than 10ms,
so the configuration post_power_delay_ms is 10, and the chipset
initial time is required to be greater than 300ms, so the 
post_gpio_reset_on_delay_ms is set to 300.

The Elan-ekth6a12nay touch screen chip same as Elan-eKTH6915 controller
has a reset gpio. The difference is that they have different
post_power_delay_ms.

Changes between V4 and V3:
- PATCH 1/2: Combine the 2 const into an enum.
- PATCH 2/2: No changes.
- Link to v3: https://lore.kernel.org/all/20240716082851.18173-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
- PATCH 1/2: "ekth6915" isn't a fallback, modify it.
- PATCH 2/2: No changes.
- Link to v2: https://lore.kernel.org/all/20240715073159.25064-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
- PATCH 1/2: Respin the series on top of v6.10.
- PATCH 2/2: No changes.
- Link to v1: https://lore.kernel.org/all/20240704085555.11204-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (2):
  dt-bindings: HID: i2c-hid: elan: Introduce Elan ekth6a12nay
  HID: i2c-hid: elan: Add elan-ekth6a12nay timing

 .../devicetree/bindings/input/elan,ekth6915.yaml          | 4 +++-
 drivers/hid/i2c-hid/i2c-hid-of-elan.c                     | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.17.1


