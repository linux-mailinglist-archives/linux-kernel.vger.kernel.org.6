Return-Path: <linux-kernel+bounces-449866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF089F5720
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47E91891A62
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FE21F8EED;
	Tue, 17 Dec 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O/6wdDHL"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2E31F941F;
	Tue, 17 Dec 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464690; cv=none; b=TOdCeLGU2dWu1ptMZEgeQ3YsSXwqHzNbiTEHPFlqRSyteb7Ikkx35J3kXScyfkIYx4M+19aFEw+//2YqvyfrC2+6PhSYFm54B5u/JFZN577foErWcLvOx11Bzj8eggn7OFh17bFeF+LuT1k2olYQU3pxC/7cdzLYcD0RdCGT5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464690; c=relaxed/simple;
	bh=PGKhh1jB7fq6v57AxgFxk9LUexegKCttSolkeo1YU0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjOYTslXL+EuOO6TPziBlGohXS8mN50ghxslyxh67NKe2f/28nxjk/BecLrkwNtyMYWEduBh5mPZgshqiwVjQEFBqqGaMJHL4ueFLp2pup4hhgcVClBK2Tmsc/6OXNCWRFz3TP3tyGWv0e0Nej9OaJE+b2MEdzjyseQ/UChQuZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O/6wdDHL; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 853B7C003AA6;
	Tue, 17 Dec 2024 11:44:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 853B7C003AA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1734464688;
	bh=PGKhh1jB7fq6v57AxgFxk9LUexegKCttSolkeo1YU0U=;
	h=From:To:Cc:Subject:Date:From;
	b=O/6wdDHLTKiiWim0FUGD/LM2ZihkoKaIOdKYJuM8w9Zl4q1/1wOAN4U5LwArnsFBl
	 GSK6x0muViTi6C0vDsGoZ8ZbUbGKEijGGVC1chW/RuKnSpWUt0il+z+kmvtSesjyi4
	 1uAf/uPSDAA6UTxH/lhfxRkHjrvLcl5KXikqcWJI=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 2928E18041CAC6;
	Tue, 17 Dec 2024 11:44:48 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org (open list:MEMORY CONTROLLER DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: [PATCH 0/2] memory: brcmstb_memc: Support for BCM74165
Date: Tue, 17 Dec 2024 11:44:37 -0800
Message-ID: <20241217194439.929040-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series documents and matches the compatible string used on
BCM74165, thanks!

Florian Fainelli (2):
  dt-bindings: memory-controller: Document rev c.1.5 compatible
  memory: brcmstb_memc: Match rev c.1.5 compatible string

 .../bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml    | 1 +
 drivers/memory/brcmstb_memc.c                                 | 4 ++++
 2 files changed, 5 insertions(+)

-- 
2.43.0


