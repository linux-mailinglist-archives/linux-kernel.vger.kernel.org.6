Return-Path: <linux-kernel+bounces-417742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5857D9D58A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE11C283421
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C697E575;
	Fri, 22 Nov 2024 03:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JkqUIAZ7"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0CD42056
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732247256; cv=none; b=QQXSPGZWRGB0h/oxa83eIsiPe0bwI1trKU0pcokzqIX9rfzFvwgiKe/DaOkE8q+yBBJh/2PGp8XrVOR8UCdfI4WFdNN4UKhwWxASDKXe85gU4eLRPc1ajW212lvZYy7Up8nwhizOvHwpHFnFGifOG42CfxLAEJOqQravkUWarqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732247256; c=relaxed/simple;
	bh=9PRuTzDBqQfJQDriZ1LwQnsJ3pxswr44u/jT5UYum2w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qpcPjiB/hHcui58d9p3o8XsB+f2oljYfcYVVUfxnoGugicDs+g4RKOHxhJQCqq2IHEip7jM8Wz+gi8zEeZ3WK60R+Zxz3i5RT2TedKV2ZPADrQHvXk19JjbMFbbBgYrKlXLVbxIP6Ayio4aO944fZIBvNE+7D5/qo+i77LG7Nn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JkqUIAZ7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72467c35ddeso2098821b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 19:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732247254; x=1732852054; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OUPLabeEhsTuPB6N8IV/JgXFnjKZTiSfXFCFhiuDbdQ=;
        b=JkqUIAZ7L2x6EVLpE8J8O8BqfHDNQK5VFSdNk9e5vpnKp6yrxnOtZU7ETlm6uNLxeR
         rg0WuIGllftScg2R4wCXx7jQSR9iKhiRex7SqMbDW8OIboj+BkmijbJRReau4SAGekUG
         QgIccYj9OZvpRUymJZuHQN0R5T87ssatuwf4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732247254; x=1732852054;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUPLabeEhsTuPB6N8IV/JgXFnjKZTiSfXFCFhiuDbdQ=;
        b=qN2CPZ8ual4JbgmIlU1LfTipUlumZDRK3wP7lfB5WmzIQZtQqnYWYx82xVjJWpWIif
         UG3TWhWEbjXGmAFxRLkDr39LPOz1zMtPsCpWrTJt/TtVPazFkm7fdsZpqZIfs/G0DDTO
         HLu4cJ9idg+YS10622rCfNoKhr2E6Wsv0AIwY+J+hH7Ij5ORYPyg99R+Jpz1F2dqN+1b
         EqkLWFnDSmWEi6cym6dXUaGZUBWEJgfLqrvu4/+Iq9RJwduSTCO/mulnujZw6FS5kwK9
         rggSl4C1o5T1m0YOhMmZFffC3cGp3NxO4Qez3S68pYqOCqONbdX0/ZBtXalL+FaKTOql
         gRKA==
X-Forwarded-Encrypted: i=1; AJvYcCVOdyuYmUcVAZJrrYpchnii7e6s78kEVkuueP/smiHG4fxZ6cwf4MOpJeMLZDW1dUacZOtCTDwJzMaYfa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymMqVvuIbEbp9jmwrZWRc/kzcaFcob3/PEgXBlr4b0Acu7CLKK
	0oZycl3i+mtkZarOQgmRaHUNQUHx0bo81Cp8APXu7nYaI/nPBS1NNRO/YuFkOg==
X-Gm-Gg: ASbGnct9snbGnu8hWoXX76yZNqnwjkux/zgGgMhBTEUyvPMyB6T6dvtJb8Smmoam/LI
	1blvKBCjE2iv4HMhiUA60yO0+kkuZHXRfwjfjsP9y6QWaBKkfq7DdEA50zPpgbfzny20koI5Oy2
	WZIkynQwfBRHHUBAHg3kW4n/hqy6KsN4+BGQTDn5Fpx6WptOBhwQ7pTIKV/PasLq4KBQKCfBjJp
	JKlxd3KYjseBNCNlMicu/hgwzZVZ+UbJRqjZJHjs9ihjTbl1HYY3I0fiKcoTIBQ+5fu/04=
X-Google-Smtp-Source: AGHT+IHiALVToYKglGv8HQ4w/4rsnqINW3YG6Y1GRh2tGW268TcBGb5mBkzYGC/fBrRZJ1hQiu3nXA==
X-Received: by 2002:a17:902:e845:b0:20c:e169:eb7b with SMTP id d9443c01a7336-21283c7d68cmr91453535ad.14.1732247254165;
        Thu, 21 Nov 2024 19:47:34 -0800 (PST)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:533e:26bf:b63:973a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de554b11sm550174b3a.133.2024.11.21.19.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 19:47:33 -0800 (PST)
From: Sung-Chi Li <lschyi@chromium.org>
Subject: [PATCH 0/2] Extend the cros_usbpd-charger to make it a passive
 thermal cooling device
Date: Fri, 22 Nov 2024 11:47:20 +0800
Message-Id: <20241122-extend_power_limit-v1-0-a3ecd87afa76@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMj+P2cC/x3MQQqAIBBA0avErBNyiKKuEhGmYw2UhUoJ0d2Tl
 m/x/wOBPFOAvnjA08WBD5chywL0qtxCgk02YIW1lIiCUiRnpvO4yU8b7xxFgxpNp9RsVQs5PD1
 ZTv90GN/3A9AOCHBkAAAA
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732247251; l=964;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=9PRuTzDBqQfJQDriZ1LwQnsJ3pxswr44u/jT5UYum2w=;
 b=Zc1RWAqzt3jVrYqd5ASn9V+gjaIAcZeOGISABX0Ac99Xxsn8I3BztCE6a22BtmSCbL3aekvws
 faN/RYixLo6Dxfe7unI1ySbUZo5kTdF4qousRqILdTYvWR2gEqJJnw3
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

The cros_usbpd-charger already supports limiting input current, so we
can easily extend it as a passive thermal cooling device. By limiting
the current flow into the system, we can reduce the heat generated by
related chips, which results in reserving more thermal budget for the
system.

This series will only works on making it a OF style thermal cooling
device, so related code are guarded by #ifdef macros.

---
Sung-Chi Li (2):
      power: supply: cros_usbpd-charger: extend as a thermal of cooling device
      dt-bindings: mfd: cros-ec: add properties for thermal cooling cells

 .../devicetree/bindings/mfd/google,cros-ec.yaml    |  3 +
 drivers/power/supply/cros_usbpd-charger.c          | 98 ++++++++++++++++++++--
 2 files changed, 96 insertions(+), 5 deletions(-)
---
base-commit: ac24e26aa08fe026804f678599f805eb13374a5d
change-id: 20241122-extend_power_limit-62c2d9aabfa7

Best regards,
-- 
Sung-Chi Li <lschyi@chromium.org>


