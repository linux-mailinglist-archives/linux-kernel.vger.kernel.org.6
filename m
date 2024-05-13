Return-Path: <linux-kernel+bounces-178192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2178C4A40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2481C20F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BF485C44;
	Mon, 13 May 2024 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZnqwwKZS"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8B285622;
	Mon, 13 May 2024 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644368; cv=none; b=Yx67hFKYT/ws0mRlihTCLkV/HYclZZE1kZOgOFJnBJlgnCz3WSjA8G/7a/pDNwLdv0ZBhhQIRTklmv8aIl7TJyOw6YT2cmD8oFh7+gyZKKBihKcVFy0cZyNMK1MnoTKFeOUGgSZ7Bradiv/dAlTptqkLXoZWsVfjvjvNNkjZm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644368; c=relaxed/simple;
	bh=YiZ/KTwPoAMviHDfw9kvqjjai+9ZeNnkqupC6XucNb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dTHQ4xy1DCxNC0I6CWJYG8vPmEFRPHgW7FYon3oBruIyTg8TliCCCY9B3nwCNXdTaPF2zm+64NT7EnFKCPE62o178WivF95Ij1fI3w4++QVTrIua5ktq8n1qoTFN6mLFG3o8OKqZgyJwYSdyPpwvEERqhDujHh+LSgyRtov5DdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZnqwwKZS; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id BE73BC0000E3;
	Mon, 13 May 2024 16:52:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com BE73BC0000E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1715644359;
	bh=YiZ/KTwPoAMviHDfw9kvqjjai+9ZeNnkqupC6XucNb8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZnqwwKZSmXN+7HsLzpEyG/7kwytc6nTK0Yygowx0CkwpwXuIMJ3SS7A/2FWcBbpEt
	 XclL2ETp84W6ElcTD9aMq/F4uQCIBfQ3KjI+U1s7CYcwETBQ7zx6OBlrJoMo8gaWMO
	 t1GifvcSLkB7N4t6T19QOp778xqnoeRfAbHmyu+o=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id A753418041CAC4;
	Mon, 13 May 2024 16:52:37 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
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
	linux-kernel@vger.kernel.org (open list),
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 0/3] ARCH_BCM2835 Kconfig changes
Date: Mon, 13 May 2024 16:52:31 -0700
Message-Id: <20240513235234.1474619-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series updates a number of Kconfig entries such that enable
ARCH_BCM2835 guarantees that essential drivers are also enabled, saves a
lot of configuration and troubleshooting time for when they are not.

Florian Fainelli (3):
  mailbox: Make BCM2835_MBOX default to ARCH_BCM2835
  firmware: Default RASPBERRYPI_FIRMWARE to ARCH_BCM2835
  clk: bcm: Make CLK_RASPBERRYPI default to RASPBERRYPI_FIRMWARE

 drivers/clk/bcm/Kconfig  | 1 +
 drivers/firmware/Kconfig | 1 +
 drivers/mailbox/Kconfig  | 1 +
 3 files changed, 3 insertions(+)

-- 
2.34.1


