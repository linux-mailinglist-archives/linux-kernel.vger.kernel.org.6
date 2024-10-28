Return-Path: <linux-kernel+bounces-384616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C8D9B2C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41E21F21E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DC21D27BA;
	Mon, 28 Oct 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Edzkb2N5"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AC31CF2AB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110348; cv=none; b=lrdjv4VCfK7VSn3nky4HumKaUCPUrBiTJU6t8cxFzuH1Bh6vvhtfkOpEdDllKq/K38bnUmRbTG1bSGwZ0Doh7C7gagMp/7Gxm7b9GJVLt8n0Pcz03XA3ADLaKXT/Dw/2YzvGAyUEwzbY0wV718p8w+6KG3dhgcKicyJydeAV8oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110348; c=relaxed/simple;
	bh=G3w2AWS1sO2hIf0BXswma2XjfTe1ek5as8WEGaPafrM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T3S3IJcjPgzu0XbOtUvQeBfTy4vQIzbUAay7ruKjKS0dZY8/8fjow6Oo2tgKpTn0Rv3RlT8xz9VXFRusBw+EOWc+rkwxxZvpMl8N55yMxE087pgcv26GH0opkV2X26KU5MuBAJZ/QhCtN5zLcuOZAG4zv5NwPUDnQvnNs5Rone4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Edzkb2N5; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b161fa1c7bso314277885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730110344; x=1730715144; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oiZZP8a/VVPUMg6rqixs38rRyTMltTho6huxqslh1r8=;
        b=Edzkb2N5UqemYRwYhSI2QxA7bKLVuNNY5IYOG3PG5JKeHARcNJPi8hnGhqSkAA9c/i
         u1ACfhDglbH/QmqP3Lnsq2FemVJ4oaQX/nSqLZlhBJxFRqmEQVzF/ogbSj8RsYa+Owsv
         Kas49vGIZLAteqo+qi57E/H53vQSNxrJgVy/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730110344; x=1730715144;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiZZP8a/VVPUMg6rqixs38rRyTMltTho6huxqslh1r8=;
        b=VNv3KFm2cyCSwosmMYpUj3fYzeJAxNQSUvTNKAA98zRGNdTdiCMoySE1L9sOwdbhX1
         QGL7RAQufpjxqomo9sDDZ/GVQEDcQmBDqltEyxWsFLt7PcZlDA8BG9h1OTwhD6mNEG92
         17RKTG4AIgI8BWJ4/AYkGhpmU92oJQuuVN27b1cn5RXx59m0X6X0DehMHPOG72D5Mvc2
         kkhCnjKWZirWY2Y1hVmpOkBDul/QVE9Px4xCcbA1B+gI8VqY3BznX/dulGX6sc04rZp2
         AAEJ2Wi+/XV7ghLM15RqLRJBkOj+uz7vvnoQBDMsqvPwkkOcOMHTaRSjxLxuLxFQh4IH
         rqbA==
X-Forwarded-Encrypted: i=1; AJvYcCX3IgVlpcnkDty47j3JurTbWyA0nCpSEtFm5MtCuCAoI29FDfw303/juMLxV6+4X1WpP4BdCSaEl0YMyNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdy0bpbObzx9s/75azYuTGeGJeQNVehjNIJlpY9WIPlQzIArKL
	RI5f2tcMEFxp6bGCCCvQL9EYZxgLWmimFEql6pZC8A+rKhVsAtKcUUuUKoA29VbZBJj5/aOKS0w
	=
X-Google-Smtp-Source: AGHT+IHCZNylv6nLjfkO/ktra4n6JfoH26XKs2q4uwaI7CD5MA4OdYifu82wP1TO9Q9/suHNb6Q5ag==
X-Received: by 2002:a05:620a:468f:b0:7ac:9b5e:baf3 with SMTP id af79cd13be357-7b193ef2c9amr1311016885a.26.1730110344518;
        Mon, 28 Oct 2024 03:12:24 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d279126sm305483385a.9.2024.10.28.03.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:12:23 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/5] iio: hid-sensors-prox: Add support for more
 channels
Date: Mon, 28 Oct 2024 10:12:20 +0000
Message-Id: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIVjH2cC/zWMQQ7CIBBFr9LMWgxMMRJX3sN0UWEos2hpoDaah
 ruLJC7fz3/vgEyJKcOtOyDRzpnjUgFPHdgwLhMJdpUBJWolsRdhdYIcPfurV95bDfW5JvL8bpX
 HUDlw3mL6tOiufuvf183flZACR4UXY7BmzN2GFGd+zeeYJhhKKV9MDvwVmQAAAA==
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

EgisVision 620 provides two additional channels:
- proximity
- attention

Add support for them.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2 (Thanks Jonathan):
- Create new attention channel type.
- Improve documentation for HID usages.
- Link to v1: https://lore.kernel.org/r/20241024-hpd-v1-0-2a125882f1f8@chromium.org

---
Ricardo Ribalda (5):
      iio: hid-sensors: Add proximity and attention IDs
      iio: hid-sensors-prox: Factor-in hid_sensor_push_data
      iio: Add channel type for attention
      iio: hid-sensors-prox: Make proximity channel indexed
      iio: hid-sensor-prox: Add support for more channels

 Documentation/ABI/testing/sysfs-bus-iio |   7 ++
 drivers/iio/industrialio-core.c         |   1 +
 drivers/iio/light/hid-sensor-prox.c     | 186 +++++++++++++++++---------------
 include/linux/hid-sensor-ids.h          |   2 +
 include/uapi/linux/iio/types.h          |   1 +
 tools/iio/iio_event_monitor.c           |   2 +
 6 files changed, 112 insertions(+), 87 deletions(-)
---
base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
change-id: 20241023-hpd-edeb37f1ffc4

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


