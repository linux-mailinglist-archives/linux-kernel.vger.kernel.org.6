Return-Path: <linux-kernel+bounces-436324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944F09E846F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 10:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C3428180E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 09:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FE713D897;
	Sun,  8 Dec 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="ukUsVD3Z"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8C12D758
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733651413; cv=none; b=L4wn8K6v7wf25Gzb+jhgKFU/xnTaC8N6mE7xikF9PfhF4b1WVCDwtLmFV7ZOS5p/q7NK4BXHNIavPVeAlrdLRS0tTPMql5gf/ULcFJa+W+hkOoQdCV89vali5Rc0qx0wj5oWrF4F4EXC6hKVCPpQ5OEj3vmjRAQBfbXu6dlaZvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733651413; c=relaxed/simple;
	bh=4VphnPQb+6q7qtjsx4nt5xZ/a0VCfHj4tzIsDx7BG8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+dhX/uE0QBTF7jP5H30Wccz0Lm83DfKhH6pUzjR45pKk5I4Z9LlmRxBsmg22TRXCpo+X42YykiUwnODC0buDeLuIZn5V8RqqLnwB+hN50j8fNjwtj3XlnHelhOXN2xIFI7W7ScsTwnp7Pi0JuOIqTbLvFMXDzaB/sCfEu/L38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=ukUsVD3Z; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so31428011fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 01:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733651410; x=1734256210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmsak1Ku2aVkAx8thMEta/V4E+yKJNfIXiujSGDstyk=;
        b=ukUsVD3ZXEfzDHR5yKoHG1bjTWV6RlMf3dw7ATgXlCKF7cZqqKu2ZXBC9ZDq5x6nJb
         ngE+H1cbq5j8HBCx9UsJaEpg6RQ/YaofTw84SK8tgiFL0qWi1xNbf1lEJQ155pAt79de
         fcz7jds4ZqNucd599GsDNqduTTf8WmCgMyox/TZ0YJT7XWomA6BBQbq9Gwu8oEUO1FUx
         1wXMbpLCa4v+Vdk61hpHe7geNcPl5rGgOHFjvzJpfTRHtctj0wClorwMtadY8HbcP/24
         1KK8w+Zzt2AkdDCTHRG1EuHSSbwjjn5Yn+h/dJYiLh9z3FN5hGA6zQiw3bnXWzjJ/LM/
         yfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733651410; x=1734256210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kmsak1Ku2aVkAx8thMEta/V4E+yKJNfIXiujSGDstyk=;
        b=bCcvrDT994t1qX05KusAsO4Y97BJ326TkOxLEb+A7WUDCURykyH2k6f0f7dOmFb5iK
         QohACSjj/mb/oD1nQwPxKlfH3CmRh1oGj+YkSNfs3IArHz1Ow3nKYlUkr/sMN7Hfa8gU
         burMT8GfnuE84KU90kim54aYVV6wweOE6Se1o3FR3e+4/FIVEyttCGprsNd78FzBq8lm
         DlLCANMAVf5Zu8vEPSgKOPh+5BY6+tkU4WLJ8g7SGxeV4zl1Yt4s9zeKGPSUwM18EtKY
         BIdpFsf77qmI7TREds4f8cyoRl0ylA+bV8VGMn1oO1zbOuRbl0BxviddX2EWB7g4Sdrd
         X5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCW1G+QYN4zbYMxf64nMZuD16+dxCEmuxMLLxcd8678k/JAiQmyjw3v86RDcCfCbx3K6ejQUcfFUBpm6znQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLRM8xxtnneY3J/Sc486pCuJddWP4Skbkq3wIOjCLEto4WP+18
	GNLK8CETg11UDo5e3g7jJ7cJWtCNRYin8cHn5o3TZ4+MQFiXScbmE8NTK9a7t6k=
X-Gm-Gg: ASbGncsdEdUiLHjfPFZ0jDnkWYi0oUdAmp+/E6qV3SUmEuIb6lIlvWFwydbQoLUJSgM
	8RZvIGGPyEk8AdDWhGKF82tskdh5RvYYRfi/BpXZZnbahVYM+kkzSU5RnTOSskfGJzA+tVojeqg
	12MwgY/eLT8EJApNyjT9iYdqPCYj29vEVNzvr5/qCddtT+6vnwGe+/GeHuRvzaCe+dAw2bcawXR
	i8GjEkIp8cJvDZz55DtspBvXoj7oiPDxxLX610MhI28tSYqlUleFY5Vk7dtJZNh
X-Google-Smtp-Source: AGHT+IE6074+O76DqP9gNjbyHYu1uvrO8N9MNpuHLhOBhgZMLbN1rXyI1oimwgf6csuc4BR7wvP0oA==
X-Received: by 2002:a2e:bc26:0:b0:301:2d8d:a3ba with SMTP id 38308e7fff4ca-3012d8da433mr10577291fa.23.1733651409856;
        Sun, 08 Dec 2024 01:50:09 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30031b80e7fsm6645311fa.120.2024.12.08.01.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 01:50:09 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net v2 resend 0/4] net: renesas: rswitch: several fixes
Date: Sun,  8 Dec 2024 14:50:00 +0500
Message-Id: <20241208095004.69468-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several glitches found in the rswitch driver.

This repost fixes a mistake in the previous post at
https://lore.kernel.org/netdev/20241206190015.4194153-1-nikita.yoush@cogentembedded.com/

Nikita Yushchenko (4):
  net: renesas: rswitch: fix possible early skb release
  net: renesas: rswitch: fix race window between tx start and complete
  net: renesas: rswitch: fix leaked pointer on error path
  net: renesas: rswitch: avoid use-after-put for a device tree node

 drivers/net/ethernet/renesas/rswitch.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)
---
v1: https://lore.kernel.org/lkml/20241202134904.3882317-1-nikita.yoush@cogentembedded.com/

Changes since v1:
- changed target tree to net,
- do not include patches that shall go via net-next,
- added a new patch that fixes a race.

-- 
2.39.5


