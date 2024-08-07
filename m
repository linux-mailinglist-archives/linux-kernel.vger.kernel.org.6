Return-Path: <linux-kernel+bounces-277497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D2694A23E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661CB1F27F78
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8AA1C8245;
	Wed,  7 Aug 2024 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anwCg6J1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C42518FC9B;
	Wed,  7 Aug 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017485; cv=none; b=KeKrCUM9bC5aRf5PWqabfzt8QLzlcg/FoxlTTtPZynMhvmXmgfPUI6/XbOTKG5hpJXDnJL/WlG3J+Q3I/MdjxT+OtfHpqkctrQYQUT4fWzhV+WnBW3Cstwekx5Y556ipcDgKzYcuoAG0V3GV8NcBNl86APfNau0RHt/aoQfPBDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017485; c=relaxed/simple;
	bh=nLbyuHjGzIfM/jyH5hWPI4ArCyNHyZ1V2+dg4t2WdMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gsah5/V+6sOK/myw+SPEhztVT3UtCt0GIs7nj4EDmp/yhx39rfGhx22b+a6OL+jhPLVvghgOtkZlVKpkpCJczBlW0nGOr6WQZWNFZaSjVepz+IXuehXueaDTnaSuJifUSRG6Cbxw2oqEihHIJaMlG2cfadIFrbUTF58BsCAiUAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anwCg6J1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E143C32782;
	Wed,  7 Aug 2024 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723017485;
	bh=nLbyuHjGzIfM/jyH5hWPI4ArCyNHyZ1V2+dg4t2WdMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=anwCg6J1UKj5r1Pv4xNah8Ql0QyutQ3OZKJWFcxVd0KRVeYe/Ynv5nXV4R89v53pV
	 l8aDKcoz0vfI5M/+aVPg3wI64lv5PfNKVe2BRHKsG0jXT5ZkkpW10LsbFZLhxg2ksH
	 LXpfjyuTAgpLUVGSReM2DVB2xuAq6deVjrrXgzinCehYxdXmnh1yYcM8fG5jHWJ3NH
	 uB9e1zph+E30Nn3tG1jsX0wfeGP4IFYyLZAxCjuCm37H/iKFmzx+iEDGFUhhjZZ7EI
	 xM5Lw+GcczaoFjFaL8I8p9cuVMQXnNkdC65w8Sg1LpB/rZBGVytCL1qREIl9nXH5sB
	 1++Tmo8wuHbJw==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/2] serial: 8250_platform: fix uart_8250_port initializer
Date: Wed,  7 Aug 2024 09:57:44 +0200
Message-Id: <20240807075751.2206508-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240807075751.2206508-1-arnd@kernel.org>
References: <20240807075751.2206508-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The first element in uart_8250_port is a structure, so initializing
it to 0 causes a warning on newer compilers:

drivers/tty/serial/8250/8250_platform.c: In function 'serial8250_platform_probe':
drivers/tty/serial/8250/8250_platform.c:111:40: error: excess elements in struct initializer [-Werror]
  111 |         struct uart_8250_port uart = { 0 };

Use the modern empty {} initializer instead that works on all
supported compilers.

Fixes: d9e5a0ce2f16 ("serial: 8250_platform: Enable generic 16550A platform devices")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/8250/8250_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index c9ef988d58b3..2a3765334843 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -108,7 +108,7 @@ void __init serial8250_isa_init_ports(void)
 static int serial8250_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct uart_8250_port uart = { 0 };
+	struct uart_8250_port uart = { };
 	struct resource *regs;
 	unsigned char iotype;
 	int ret, line;
-- 
2.39.2


