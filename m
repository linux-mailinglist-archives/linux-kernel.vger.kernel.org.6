Return-Path: <linux-kernel+bounces-253470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9149321D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B356282645
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B31E5674D;
	Tue, 16 Jul 2024 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="vTqtcioj"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2555887
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721118544; cv=none; b=WEdPQQXWaRSSkZLIHxNUrkJCWxg35CyGfWxY5EONbJj9Ui5uc8oskCf8qPwU/DoswEYNgbflRRpkTN2TVHyY/dZMRPsE6r1W6vf8gcdeOv3C4ZQkz05YS6BgI21GlRoWvX9+42ZwpDfHQwIzr8HKd3WmO5s/wJqXGcYlwPGLwg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721118544; c=relaxed/simple;
	bh=+XJUbKH9XVGi0Un4JVKR6Zse7a3JV6qmob6cOiJJw4k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=q23XlQ+r4J7eX120Ua/EP9wsZ1u/BQTl8SJ8LNc5SKX8FdnrrVawWHN6AL5lOUWGr8r5hfBSg8LGRqoOoxscNYGwKF9ugVmHMvn/HsqxBw2UR8yvjP4AdeAzE0VvaBcHNt/NRaOrs8FF9WqIrCsQWBxuFExKuO4q0myJ8yrVyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=vTqtcioj; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70368b53cc0so2685028a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721118542; x=1721723342; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCtvvIx/yZJGexuJqTFw9RuA3ab7qr2Xt+qsnXbhE9U=;
        b=vTqtciojOJsT9+BXL6aLqtY61J3qJldL6/SBHsP0g/SZm03muSdc6rHWUJRCl17HS1
         TVoYA3WqYwChiOoVNGCsVY7amBISOcF2Ktbi+zbKKzIN/DpCj60vOE5ZuIrtJv6OUIV3
         BwWZCyoEkzVSEO9r+Z3qBIdoZcCtF+yuuVsak9n76bnF/RgLXekTAMtwu9He2A572g93
         jN1coO+4TDc0J7SWJN69a5ZdtmGT070EC0J3Z2mavwoZ2ApmuvxGz/r+LOacM/QPe3Sj
         lPDb2DVbFvfThjf53MwKhcQk799Vf6oUADLvR98+KZiMCg9SQdOivoe2g7iFvN7KvUfZ
         3WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721118542; x=1721723342;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCtvvIx/yZJGexuJqTFw9RuA3ab7qr2Xt+qsnXbhE9U=;
        b=iZ7DdRrcc0BmL7LjEhy8bsNyhulWNOts6TvDvKD5nPAtdhkHFacyVcxwVat8yffmWa
         4hV9kNFtK/evDx4qcpYMHOU5cTjA/W9ueBjHE7DhXc3GkTL3bhu003rUp9n/DZnPkKRF
         2iur7pWDfOW7z71D/A9UyKCNXXX88sW+kFPeLZr6P/4Y8d0c5hQYGnP0+n7zvzDCrbfo
         18iwFACNxvf8KkzXbsKwqwmF6iZ9PRIw9Kh3lzDfA+j7ALTufXb42SOLlA+NV8ayAboO
         7+7NERyyPdlfUnXNke2D5Wug2+ltdtlgLPZXj2M5g8FW8YOoR2C7dbseCC3wvP9F2k7v
         WZsA==
X-Forwarded-Encrypted: i=1; AJvYcCVsOhs47qiHmFkgxFAQDTu0qpqY2dqbYGt6wmzjywguEbseXTQCYeSpiHNcxTKznV45zLpR5FjFJmte65X59oJr+6d87KS2PwWBZrUF
X-Gm-Message-State: AOJu0YyrUKcm6Zw1/YOGTPpWizw5ai7zm8g2vtlLLBQXHBlOvzerWPYu
	nYT6cif6/nM4BE87aoPvFnk/G+2YqC4Kz4+FRH/HIuRGfQ1hyQhPQrAhypGtw58=
X-Google-Smtp-Source: AGHT+IEdh7/ptoL+oZD1LR9e0MBdyHHjA70akBaKcXOjtXoQ623zVqNT3IYVU90f2CE4eUeMZnXb5g==
X-Received: by 2002:a05:6830:25c3:b0:707:9b5:90aa with SMTP id 46e09a7af769-708d9948af8mr1706743a34.12.1721118541931;
        Tue, 16 Jul 2024 01:29:01 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7e110sm5714347b3a.121.2024.07.16.01.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 01:29:01 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linus.walleij@linaro.org,
	dianders@chromium.org,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v3 0/2] Add Add elan-ekth6a12nay on the basis of elan-ekth6915
Date: Tue, 16 Jul 2024 16:28:49 +0800
Message-Id: <20240716082851.18173-1-lvzhaoxiong@huaqin.corp-partner.google.com>
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

Changes between V3 and V2:
- PATCH 1/2: Respin the series on top of v6.10.
- PATCH 2/2: No changes.
- Link to v1: https://lore.kernel.org/all/20240715073159.25064-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
- PATCH 1/2: Respin the series on top of v6.10.
- PATCH 2/2: No changes.
- Link to v1: https://lore.kernel.org/all/20240704085555.11204-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (2):
  dt-bindings: HID: i2c-hid: elan: Introduce Elan ekth6a12nay
  HID: i2c-hid: elan: Add elan-ekth6a12nay timing

 .../devicetree/bindings/input/elan,ekth6915.yaml          | 1 +
 drivers/hid/i2c-hid/i2c-hid-of-elan.c                     | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.17.1


