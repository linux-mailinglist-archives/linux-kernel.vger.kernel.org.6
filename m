Return-Path: <linux-kernel+bounces-197516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BE68D6BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E70CB240CD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AA4823A3;
	Fri, 31 May 2024 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="enNyDBaD"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F67B3FE;
	Fri, 31 May 2024 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191329; cv=none; b=SP2kn775coKfvaynNgpICgMBjJFVzFPiFf0d7uOV4FJkta8IYnNYjVrpavhbkfrkcjQKs9bddkTvpavbg03AVpyJl73yM0RSa94OUofYEvV5OhTQX2wncRqZFYOW/rLlj48Zr4QleRtRs+wnGxrgW9F5fLhwExOXTOngla2pqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191329; c=relaxed/simple;
	bh=Hjbv0vY/WAOS57siO9eq3ZzjmixVescDcu/4Vlum1ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrRyl8poZcgq8Rl4L0Tyjd3fGHswfUtp/7Lqw0McVMeTWyV/eDIVKIU2JvU1mueqAJvDPBQeJ/k9IOshn//hqoUeY8NDrt1nPMkkYUwC2vl9KUUqpVZJR9xo50InWzc8vsiMeO51fB/gxTRMlqDTVWbqxMyVodr9mNXm8ZbwR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=enNyDBaD; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B603FC0000F5;
	Fri, 31 May 2024 14:29:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B603FC0000F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1717190984;
	bh=Hjbv0vY/WAOS57siO9eq3ZzjmixVescDcu/4Vlum1ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=enNyDBaDdNktJssD2YRLwQs5kDierD20XwF5gY6y+4p/uJz9UP4OLA4AhMmu5nPD6
	 DYFxetmORiVTZEL7Z4v/Nsv0Z6wcS8oAJVPTzmfvGhe3vJyy7Jd6PDO/kmUhIkyY7v
	 HyIYGf8zLwmStYqledjIe0z9z5jlVDORteWxATaA=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 9F6E818041CAC8;
	Fri, 31 May 2024 14:29:42 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH v2 3/3] clk: bcm: Make CLK_RASPBERRYPI default to RASPBERRYPI_FIRMWARE
Date: Fri, 31 May 2024 14:29:42 -0700
Message-Id: <20240531212942.3340484-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531212942.3340484-1-florian.fainelli@broadcom.com>
References: <20240531212942.3340484-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock driver is essential in providing clocks for UARTs and other
peripherals, make it enabled by default.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/clk/bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
index a972d763eb77..1b7d799bc7e3 100644
--- a/drivers/clk/bcm/Kconfig
+++ b/drivers/clk/bcm/Kconfig
@@ -106,6 +106,7 @@ config CLK_BCM_SR
 config CLK_RASPBERRYPI
 	tristate "Raspberry Pi firmware based clock support"
 	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
+	default y
 	help
 	  Enable common clock framework support for Raspberry Pi's firmware
 	  dependent clocks
-- 
2.34.1


