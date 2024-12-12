Return-Path: <linux-kernel+bounces-443124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC909EE7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFF328177C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63A0213E70;
	Thu, 12 Dec 2024 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AybPPPEC"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3301E531;
	Thu, 12 Dec 2024 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010473; cv=none; b=O6eZDaKkjZ9cqFNHwB9mK5+AE32IR/bM2Fna2I98O0xkkMo2R9wsH31LGaFtBhKS1TXNcLOC/COy+4CN0Nzz6ez+UwWok5rDjDqEoSu5Yit6HfvrvM90KVMWuq4gkMNKfMOnWe9ut47tylvIkhNHn6R1/Nvvb6HDmo4wexfzp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010473; c=relaxed/simple;
	bh=32CA1jHaNK9Crgki2iScB1Jsa5UU4ZiUaC6kP6JbU8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qFgY+XScMViMqmeMVS1U343c/QsXObRiEWybOva8AHXs7W4Ttf6mT//KnrnI156nDwL0HXMO4S83tl6QohfCY2dx1wAnoJkfBq4ZGnGTSDLtJ2DickxvBPFjcetW9S95nYyyaR4+vgK1zNyAY+LRxkJbc4HpUMVgAI6lLLCvllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AybPPPEC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21634338cfdso6399245ad.2;
        Thu, 12 Dec 2024 05:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734010471; x=1734615271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKFRdWgT/v4NOhdFzS4ffyMVT075WEVDQYQZtJx6dJQ=;
        b=AybPPPECkPkfL/LK4GTid/lx/Ad/nrTbDWltUB5fxe/7Y1QRX+wx2cvWFzulEhj00l
         rC7jqnb3v2sUyfrvVKbLSBubrSrcTsy4MtcIa9Xv4UykokEGiNNx2rOQOeqWhneK/RVR
         kOl7TejUiigD6Ve7bpxxP/OJEH1tcFfTkbUC+pVsdpwyjf1EHYAv3GOeLmsrUSOeDGZy
         LPEtzgE0sMQUN7wUxvX7ruoX0DzVBC21Wq53kMCUdEBdt0uMxlYc1ft40I7eSSOL6QAL
         bfCiWCYffapBUCZ8xvF3HmHeYH88Kn5DpiDEORDzWStC3aqbCSK3zskZWg+tRi4KHn6L
         Einw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010471; x=1734615271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKFRdWgT/v4NOhdFzS4ffyMVT075WEVDQYQZtJx6dJQ=;
        b=tlRT8H15t8WW+y3x2D0fAPOowVPZ1bUvNtw8DCGLvhAa3qf/HVI756EDjo/UTHN+P7
         S5Dv1gBRYzSPByR/M139jKD1VWKSPRpJ3rYU0f1XmnfD7PIZzNe8doLmUI/Z0w1q137L
         HyflgWVQ/ACh2Frb3sLXr6fVOVkVhtKiJQEGii+lZvGglNK/Lkd6qR2ni0Q4XeEtdhYu
         fKBvCJZokLDlkMtyuOzO3DpjhMfls3mTSEgmc9EH3NCsjfOlXiPmrcI64HXVWlCZscz9
         cXOuMWCjQrMAGYnLOE0wzS8Mlzz1jew4j648PSUy0ux53p2FIHtlfXUwOwGQ5r0pCS+i
         AOVg==
X-Forwarded-Encrypted: i=1; AJvYcCUxoWThr/kqqX8ZQlPZYr8gZW8n6DQ7D34V1ASNGkpJhT5zPjye/dqJXnUETOxqU4DdnCheQljq/gax@vger.kernel.org, AJvYcCV/enzj2P0+OV0xvFDTCw420BwhlOI9JYIDyrf1R2U+tJtaF3ERc9HiPO8nzzVKeNRAhZK3Jxwh7W4GkoSE@vger.kernel.org
X-Gm-Message-State: AOJu0YwbI0eoWzIRWoiEZ9ZEAnqC63QH7Vw38YSDgwWwPCciGpcV+AQo
	F2L6Jz5GWu7sOXEpQiWMKQ5HImJajRZYqL6rWVREnJp42VRF10By
X-Gm-Gg: ASbGnct4DpQdY7e1VgiVHojz7q3WBZsa6zMhUqQEN8EkYsMdYBkQiVmsPRyVLUnpV7z
	A7t/cTJNcDofDQpP5mMKhPWas/hvNm/7wStCixQmK4UovcezPgGXaJIESrcH7er6Rkg/6726qpq
	h5z8eZXa6bifeYNkdCKQSi6130Mkxz9R1G8rmLOtslXtrDdsmQebH4p9M07U0QvlKM4IV/C0Ao1
	c8ZIdEv7U2fi2utNFS6WLMnXDGnEesF/LKIU8Okvwyn+3Il+vBIjIHhFF2XimyUyMPEY23wSl3S
	OlCAo3O94TNfq6FrMD4Al1GyDctoVduW0O4ft8JAWlM9MQhVsvn5b3zUqS9Z/xBJT/RZKFbUF3X
	K102N
X-Google-Smtp-Source: AGHT+IFir8bmrbK56qwR6cJik9C730y6CMb6VE/C33OoWpwM9X30GYCxB9rlmJ+qw66LkELlDihuyA==
X-Received: by 2002:a17:902:ce92:b0:216:48dd:d15c with SMTP id d9443c01a7336-2177854b4f2mr84668205ad.27.1734010470917;
        Thu, 12 Dec 2024 05:34:30 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163562a838sm83390165ad.29.2024.12.12.05.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:34:30 -0800 (PST)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz,
	amithash@meta.com
Cc: Jerry.Lin@quantatw.com,
	yang.chen@quantatw.com
Subject: [PATCH v1 0/4] Revise Meta (Facebook) Minerva BMC
Date: Thu, 12 Dec 2024 21:32:22 +0800
Message-Id: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revise the linux device tree entry related to Meta (Facebook) Minerva
specific devices connected to BMC (AST2600) SoC.

Base on:
https://lore.kernel.org/all/172722509817.374662.7338401100529556748.b4-ty@codeconstruct.com.au/

Yang Chen (4):
  ARM: dts: aspeed: minerva: add i/o expanders on bus 0
  ARM: dts: aspeed: minerva: add i/o expanders on each FCB
  ARM: dts: aspeed: minerva: add bmc ready led setting
  ARM: dts: aspeed: minerva: add second source RTC

 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 523 ++++++++++++++++++
 1 file changed, 523 insertions(+)

-- 
2.34.1


