Return-Path: <linux-kernel+bounces-516996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA147A37AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93B187A30C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A2E186615;
	Mon, 17 Feb 2025 05:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avz/2J9H"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED2153BE8;
	Mon, 17 Feb 2025 05:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739769085; cv=none; b=n5UJ3N6E3YKf42r0gXYhPkSASUwO8jQbLsKiI452kuBIkt14diOdoEtmjQsaBLW7BibQDvCQ/N1LA0/cu8v9vDyD61gesf40KMtdPrxycBAxTRpViVbWIc7hrFmYvWvDP2k26ucZdX8ImUmTSTVNfOpZKXIgfAEL8sbklHQTOIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739769085; c=relaxed/simple;
	bh=HclQeSXNWk73MG/VCY0ymlf9djRRfgYtyS750b8YFf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FgUo0zdyKLELcZ7Zw2lfyxFAY4UZXJgHzYeK5WBvT4slRZevO5cwAnq0dTg1KPdXRWIfzCAKsHDrDJrHnnqJGTysuysxcXDFwQT1vRLwug4s0zPWF2YOUNx//y1cMNJ4qDjxFIYtf81pBmhHxHIU9zEbudFV6AB1/sk+JEr7k3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avz/2J9H; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43948021a45so40850335e9.1;
        Sun, 16 Feb 2025 21:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739769082; x=1740373882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Csbh9siOV35c/RvGSTUxPDPr6dab+119Jwb6H885+xg=;
        b=avz/2J9HZW4X078zlo2kR8UdzwEsW5w3gKgl+aYhBfLL8g9fUulAUXClWKNV22T+9R
         72IwjNtc3FUEdFA/aqeqJrza9/uI1SW/fKSHtv5FHcFVcv2+9jaadktKi+DVvQC1l3mN
         eQcdciaoAtqwhn+CtrVIPPT+WYl1tTR45ZfbSN/XCtafH5xqdc0eMQ1ockIRpbZfeFXq
         bB9jXYRX9O0LqWViqdbXXWOgoDYQRRfkC0beQGhiIvTWpequ35HdqzDcVxp62iV3fCCG
         q/t8ZAg135z54uPbjQ81VJL5upFicdHQklJq6Tuu1EXFox/o0wRexmTfmE+x+6jwIF6F
         +e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739769082; x=1740373882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Csbh9siOV35c/RvGSTUxPDPr6dab+119Jwb6H885+xg=;
        b=BU8PxgwgFmJNWSnD8EuRnqUIXa+B1kPRqeDhCFyPUB7k6ii+0HTrR+hhmvuZ1UVGT+
         FZQIWymUPzDdNSN6TQ/M71tnbtZQXRCyC30FnVTa4apzEvejYZuZDAgwRBNdeoyA/kXN
         r/Mwi0B/SW78IHM+8AUEjq0alKFWxpQB/9lfxxfmOwiUv9Za5o3j+fTJfYNDijH0Psgp
         3VyCpY1v68KISCGoqsIwbXlALTcMB72an7foPFmkY808jnLky6lAVu7K8R1JchSnSFOA
         cvbdQWX+GCOlZY8jYzVngxf7h97TurOxziIY0mmNL1zLc16rwYPITgy+haaMjLtZ/I+O
         AJlg==
X-Forwarded-Encrypted: i=1; AJvYcCV5nQ4a6zOHJPFzKhclNbuD/Jv8dTKF3Eb1V5I1LK3YA17FMd7vGtzVUHFBlWP3Ua4uWfkHQA7pbelr@vger.kernel.org, AJvYcCVKmvbAdRQsKCxkTm1koI37cyUN3CBrIsvVVTmz+eX7DVY78O64K0gJjkNthTdog05MD4o9NHQCBNxXu9YB@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrDBEt6t6rPjqh86hDgbgyivfO2w9TvfoFZXBzbTdoaItFTUJ
	nj4J1MTwyeeOe52bLI7VTlF0dmBK5m/lJbMLWMHnAGgeR5+fK3PT
X-Gm-Gg: ASbGncstIGGPbHi+3Oepg8J5DTp53jVvOY2XKG7OXSG9Uo/xlkTWTQbw/9e9fCq++8B
	wKKRtBBJs87lqussWRo7hhXnsmQrlVzqTxBU7ATmY9cRo2h31Br+TDaIqM6DMMqx/RVPXaQrsDf
	br1ZZwHXh4+yVLIFh99T6yaFYY6PI31EQqSFpadgDhzewyl5qEXOeRLRn+bQn6T3IpG1bV2jG2a
	grNKrLQIGfk0G3BtGklUfKk0bvQ1dN1rVKWuZdFsd5oVknOOeUCDem50X7iIOYZmI5XfzwRS4aI
	KgA65Fur1Z4qS0sOuEiVqUOWfGZffEjPSmqkrgngjIp3AaLhsvq+cf69mwSIEBNzh0CfLdipAWz
	KOFj/Q+VisSgthNwhC4E64qukMyyGBragv0GoZzQuGaEQ
X-Google-Smtp-Source: AGHT+IEev7UCX+KB+Zulf9PCQus8scd1kHZBNQzkI0I79EyeTz7edsqPt65G/e4DqQSVuA5jVAEfDg==
X-Received: by 2002:a05:600c:3ca3:b0:439:60ef:ce94 with SMTP id 5b1f17b1804b1-4396e70c723mr59935265e9.21.1739769081829;
        Sun, 16 Feb 2025 21:11:21 -0800 (PST)
Received: from thinkpad-p52.telekom.ip (2a02-8388-e103-2700-a24c-4303-c631-1166.cable.dynamic.v6.surfer.at. [2a02:8388:e103:2700:a24c:4303:c631:1166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398a64febasm3988935e9.1.2025.02.16.21.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 21:11:21 -0800 (PST)
From: Andrei Lalaev <andrey.lalaev@gmail.com>
To: linux@roeck-us.net,
	krzk@kernel.org,
	robh@kernel.org,
	christophe.jaillet@wanadoo.fr,
	jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	andrey.lalaev@gmail.com
Subject: [PATCH RESEND v3 0/2] Add driver for HTU31
Date: Mon, 17 Feb 2025 06:10:54 +0100
Message-ID: <20250217051110.46827-1-andrey.lalaev@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for HTU31 humidity and temperature
sensor.

Changes in v3:
- move serial number attribute to debugfs
- fix the position of entry in Makefile to keep alphabetical order
- fix the patch versioning

Changes in v2:
- replace DIV_ROUND_CLOSEST with DIV_ROUND_CLOSEST_ULL to prevent
  possible overflow
- drop mutex locking from htu31_read_serial_number, as the function is
  only called from probe
- add description of the private data structure
- fix the issues pointed by Christophe
- add an entry to MAINTAINERS file
- add Krzysztof's ACK to dt-bindings patch

v1: https://lore.kernel.org/all/20250123202528.223966-1-andrey.lalaev@gmail.com/#t

Andrei Lalaev (2):
  hwmon: add driver for HTU31
  dt-bindings: hwmon: Add description for sensor HTU31

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 Documentation/hwmon/htu31.rst                 |  37 ++
 Documentation/hwmon/index.rst                 |   1 +
 MAINTAINERS                                   |   6 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/htu31.c                         | 351 ++++++++++++++++++
 7 files changed, 409 insertions(+)
 create mode 100644 Documentation/hwmon/htu31.rst
 create mode 100644 drivers/hwmon/htu31.c

-- 
2.48.1


