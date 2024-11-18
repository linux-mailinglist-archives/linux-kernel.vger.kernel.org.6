Return-Path: <linux-kernel+bounces-412787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D19D0EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E942829C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F0A197A67;
	Mon, 18 Nov 2024 10:52:58 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D8192B66
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927178; cv=none; b=e5Rnt23pKWGJKIB3kfY0xtj3mDg/waAfTCIrnzP7W503ZkQk3sc/qNV8KVvYSW5EkOqdH/xfYDYXECuKMW0PqGbRrNZxeEk253Zg3jGHlrAeS+KpchfJ1kFeC6cY/Nq0uWCQ19vZEzFUfqUv+5miuEl+6y9zuBNGNsHXYv1peGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927178; c=relaxed/simple;
	bh=BbzqMfy6aUfW9yswDEM1hlw0Fu0MrL6aZokYdECl4DY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HEJhahUAhS7GYwt777AWhmzOszAeS9y5P7Ug8IuNHbLc+ool0LQz+He1iavkgtjFTzuYGw91lyWT9LeQ/q7UBuoODtBDgfzMUeQchxOeKrQ2tLH0vIN0AnHKp41Uzz/pgqwx4pV15QBeA0OcmMjYLWGkvmVZc8L1wzCV/CuR7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 18 Nov
 2024 18:47:35 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 18 Nov 2024 18:47:35 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [net-next 0/3] Add Aspeed G7 MDIO support
Date: Mon, 18 Nov 2024 18:47:32 +0800
Message-ID: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The Aspeed 7th generation SoC features three MDIO controllers.
The design of AST2700 MDIO controller is the same as AST2600.

Jacky Chou (3):
  dt-bindings: net: add support for AST2700
  net: mdio: aspeed: Add support for AST2700
  net: mdio: aspeed: Add dummy read for fire control

 .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml      | 4 +++-
 drivers/net/mdio/mdio-aspeed.c                            | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.25.1


