Return-Path: <linux-kernel+bounces-538362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE82AA49797
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95D17A6BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC5B25F79A;
	Fri, 28 Feb 2025 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7aCqWu1"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4625F7AD
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739205; cv=none; b=VlHqNOlEckuNRz5l0yDKHKaql9GMpXqeRe1qQjFo1e2N4hoSBOAvW06TGtdJ7ucrRnh9mbQLqQiyJl6SKHW0TBjT6F+M6hDF8vsDXlmOMNQB5Smg2LZPrcPYJ2uNdRfMfqYMDAQUmRBWJgFnoP5oUmDJSVCGDHp0VnaM0Z+oEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739205; c=relaxed/simple;
	bh=dfgjmv5F5JE7raR5i3ywX4SocyL6xGBj4+cj0iwFjgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnUkASP27cQab5M1CRVPA27ihU9lTwUXNlcrCv/Z8/7IEoH4WlYUTjlmIv8UJv6ezcLKycqbQtYGFxFraxCdmylmRk/DjVYAS72AusA48qlvIj/yQ/R/t7vAyajxnuoH+pvuGc7ixKVaQYwnYpR87+JQTvC+itbNPuhTVkGz1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7aCqWu1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso20208795e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740739201; x=1741344001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi80ttWsp61rFaPMRzcRoSBsD+icdSl9C9Rjx5VP+3M=;
        b=L7aCqWu11i8SVuQF7I5Wz2z5gFDeCLx9h/FqqYJmp5YV6itZ7ciw/xc2VDIbiSrXF9
         7RtF52lqH0LWbtVjh1pvCjWrJ+KsaBlFHghiAQmKxypTXhW18lgkPOPnrSVtXjiX3EDA
         gMXFb5YU/qKjq7orVYeBkU7dYne/a80cpytVBGXcQamWCxRrPTR4CIYEWz3hM4EuoEzM
         EPM2wjfQQfC0qmh3zhqAQWco/crNquUpU7UR+ftJd9m50D6J86Zo/jAloE+ZF2Wl9cqm
         LA1JSaN+3/y2xkneDKdxiGXvmGB02Pyku8GVmFetqcEUEGjW+sq343Gsezf4euhsedvO
         rFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740739201; x=1741344001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fi80ttWsp61rFaPMRzcRoSBsD+icdSl9C9Rjx5VP+3M=;
        b=tOQXInwsctvCEtMtW6JDuNV4BZ941spZPBYGDMIpf8G2+AkwzhRPcjIkHAhpi8wmyO
         /OTKNG2QI9nEjn5PrPetCSbhswYS9LBk6xqpR9WaaXLoiE+9JFHeOCH94J2XwsB8ne7+
         NRTl0Tbf7faAMqHtWJXC5TfK5iQb9oA6Mh0YYjYrWbNXcO/zOdKS9fPRtOA8jB59c5Rd
         dScFyzwn0y3lC/db60eAP54pcBuHMCsIWfFzVRAwNFKN0R4sA5J8/W8fsZRU1TYMKz55
         M5rKeQUk4la4nJl+1PR9jUXSZ4ysPhtvn+F9fG3YxjxsnoymEbzUNbj94FyI/sHAgE1W
         Yn+w==
X-Forwarded-Encrypted: i=1; AJvYcCX5kDdGLT2auPfWC+K+6mC9FwhGtQnIfwuYDPnKfVafg3sDn2LGX8gGlRyErKMazycg0/9iLxV6DwhUScw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6+aXJYcD2NOAVhnMJq/0xhFNQrWuwePE58cQZXm5cq/Mk63d
	OVVisAlQLlYzAEtLiPOCP+4erzetW/BV+I5ibHzNrLp8+SLcM63l
X-Gm-Gg: ASbGncutC5ujPOpFjhWJhzFXgdjJbPA11VijN/C/Qtvv2IBa3flcol54aIL7pikQmIU
	cX/LApVyZSqtU3vkipMAFnl0sK6OIwNMwfHjbq0wUJirnMKoB+ejaxM5stY6T0+H07jbqVq6BlT
	I42BqvgACzm402bBvnvrY9UAxm7r3PxlLF9XK0j6E0PiSb8Y0KIm4bsp4jchiP8JApquhysr+IZ
	BB58s8DvpR5OzPzWEj8MBE7qPujOjzeSzRjVPJjIo2chQ6Lr9r4qVTjax5VjcqPKpP3imy2Edqu
	dJCZxfuXBtxEcIze4m9SffKZ40UZLcGsrq36Na8XMw==
X-Google-Smtp-Source: AGHT+IFZ+9Q0/YRqcF3z6Eyi5tLIR/2s8CMepw/0ILneK1BAb1xfCwMbUhjYYRJlgvj6BOKAvv7DEg==
X-Received: by 2002:a05:600c:154f:b0:439:86c4:a8ec with SMTP id 5b1f17b1804b1-43ba6704456mr27891215e9.15.1740739200632;
        Fri, 28 Feb 2025 02:40:00 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:31d5:4145:8035:cb68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73703caesm52078855e9.12.2025.02.28.02.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:40:00 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	p.zabel@pengutronix.de,
	tharvey@gateworks.com,
	hongxing.zhu@nxp.com,
	francesco.dolcini@toradex.com
Cc: linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] phy: freescale: imx8m-pcie: fix and cleanup phy
Date: Fri, 28 Feb 2025 11:38:32 +0100
Message-ID: <20250228103959.47419-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The imx8m-pcie PHY PLL fails to lock under certain conditions when
returning from suspend. This is resolved by asserting the PHY reset when
powering off the PHY during suspend. This ensures that the PHY is
properly reset when powering on again in resume.

Stefan Eichenberger (2):
  phy: freescale: imx8m-pcie: cleanup reset logic
  phy: freescale: imx8m-pcie: assert phy reset and perst in power off

 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 24 ++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

-- 
2.45.2


