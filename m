Return-Path: <linux-kernel+bounces-194629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F67F8D3F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4D5B23132
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C221C6891;
	Wed, 29 May 2024 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3QGKidW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57679D27E;
	Wed, 29 May 2024 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012775; cv=none; b=accu0qIVFNlAOPm94d7e7h1H6GWZ9wT5BYlcQtjmcB+doECkycsLYdzmEQ1jEvKoqmhQD0hE5/Oy1U9zFyv5NtoWTjAk4c5QNhIv37hEU7s4sjYj08esuFigkDkGmBcgrS6LenbFSMUR6evfHbHm58H3PJlGG9X20gfZnPDV/Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012775; c=relaxed/simple;
	bh=qh84C1aPyUvP46Gu8Dv17j5i6PpcG0j1xKFVooUqkcE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g1G5QNMYpxIS3JE2X6L15/ax++TC0wYynouQGE90+7V8hskL7CwEOZ9Mq/sOxvB+Up9azbyDnlf9UYWxI01/jjTEuSMf+aP/QnvU4req2i+3nx78bEGd/Rco5nV98hRAmN3AVRmm59ftRbxxxA+F3rjkaWNzOKLOIyOBAqGbduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3QGKidW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970E2C32781;
	Wed, 29 May 2024 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717012774;
	bh=qh84C1aPyUvP46Gu8Dv17j5i6PpcG0j1xKFVooUqkcE=;
	h=From:Subject:Date:To:Cc:From;
	b=r3QGKidWT4gN19Wv9KIVZLNIHhVjnObmNEvgLKX/521M45DWEkZSeYXtNaEUYAdIs
	 3OUgmfdVvbNYWqQqTLAOg8Jc8xvi+GaJdRdauRp+A5ecDvNbz8EkFaMqAnuaIXiTBq
	 p/nJAK2QoFbFM84yY1sPGNEAnOXWQj4ZuH8ZRCgKaJo6rwk7nMuyCKApuqbPTMfHG5
	 K5M9tqknIXkfcJVJLEVe+Rpz5QLJkYJmYSKmdEStO4YtgNOk2uujdE+28frpES1WI9
	 UOwB+Ypqt42Odt5wa4NrEoEkuwd/BCjj/Kl7R0gUxtUQq1Yw75ZRoNevC89LwdwD+w
	 EgbkF+EfZ9JYQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH v2 0/2] of: Fix interrupt-map for fw_devlink
Date: Wed, 29 May 2024 14:59:19 -0500
Message-Id: <20240529-dt-interrupt-map-fix-v2-0-ef86dc5bcd2a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABeJV2YC/x2MQQqAMAzAviI9WxhTEf2KeKjaaQ/O0U0RxL87P
 CaQPBBZhSP0xQPKl0Q5fAZbFjBv5FdGWTKDNbY2je1wSSg+seoZEu4U0MmNVLVTR841MxnIaVD
 O+t8O4/t+vykBzGYAAAA=
To: Saravana Kannan <saravanak@google.com>, 
 Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
X-Mailer: b4 0.14-dev

The duplicated parsing continued to bother me, so I've refactored things 
to avoid that for parsing the interrupt parent and args in the 
interrupt-map.

It passes testing with unittests on QEMU virt platform, but I don't 
think that catches the problematic cases. So please test.

v1: https://lore.kernel.org/all/20240528164132.2451685-1-maz@kernel.org/
 - Refactor existing interrupt-map parsing code and use it for 
   fw_devlink

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Marc Zyngier (1):
      of: property: Fix fw_devlink handling of interrupt-map

Rob Herring (Arm) (1):
      of/irq: Factor out parsing of interrupt-map parent phandle+args from of_irq_parse_raw()

 drivers/of/irq.c        | 127 +++++++++++++++++++++++++++++-------------------
 drivers/of/of_private.h |   3 ++
 drivers/of/property.c   |  30 ++++--------
 3 files changed, 89 insertions(+), 71 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240529-dt-interrupt-map-fix-a37b9aff5ca0

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


