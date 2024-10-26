Return-Path: <linux-kernel+bounces-382942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF29B154B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1578C283487
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B7166F29;
	Sat, 26 Oct 2024 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="mVpMcrwv"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20411369B6
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729923358; cv=none; b=t4UVZzYBIPAYoS5Lo+HmZhmKKx6sBXC+i2cTKYV9X3NmFxr/iMdfDLvlw2PkeiEcba0ahcKuobJlKxgvnNhvlFKUPO0/NGJm3aVND30a+XdNGWaRB8zS0g9U1rW3Ms/W1+lqiyZkA2d4rca6NQfx6khjhHcyaFvULdSp46b0G10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729923358; c=relaxed/simple;
	bh=ViTML40RPtV1KizDlF/xI5rZvtc3SFdRO6QSEecAG7I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/acHmuLr+K+esYMeGYE18cjbLaMZz18avOeGhS1elFo5aE8iHzmDuH4ruX4TjXERdeSjysT7TytpGudJzA4QvE/owDmqDZ9TpybU7uCiDjZpKaJrofS8aq4dlSe1EG1KbYSTJMWFGHkp5XWIaiBiBqvUemcC1jUIVR505MDevs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=mVpMcrwv; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id E8528177103; Sat, 26 Oct 2024 06:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729923355; bh=ViTML40RPtV1KizDlF/xI5rZvtc3SFdRO6QSEecAG7I=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=mVpMcrwvkBxFTw9X/XXkCQR6dV4te17tB4yrDoMrpMd5wsb7rYybsnyPqXXn7zBvE
	 yz/4BePXCRhaAvzk2LhO1lClfXKknNfKd5yfgUyMtuqKb8s2ESspQc264/IkZatblV
	 /YsP32CmfUYxL9yX1tigf5VVJvhBT4Iv3Dd5NqqqpVGZfEqWvemLDoqnqyd2nsU1DD
	 ZNx4D6FVX5ojunq8CnX1Hxkdb5Wn3tD/Vysx46Dc4G1raGgUTiGeGouTH6ht6hw89f
	 SQPg/fwuLXUF0UzdmRLHqkfIVPvFDyMmydsKqv4BZtsfBe4rVRx3cMBAfQwItJ15PU
	 +hYcOZYlSegIA==
Date: Sat, 26 Oct 2024 06:15:55 +0000
From: Nir Lichtman <nir@lichtman.org>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] kdb: Fix missing argument in dmesg command usage help
Message-ID: <20241026061555.GA887785@lichtman.org>
References: <20241022190217.GA846685@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022190217.GA846685@lichtman.org>

Problem: Currently when running "help" in KDB, it shows the "dmesg" command
as having only a single argument, when in fact as can be seen in the
implementation of the command (kdb_dmesg) it accepts two arguments

Solution: Add the missing argument to the usage string of the "dmesg" command

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 kernel/debug/kdb/kdb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index f5f7d7fb5936..5f56ade565a6 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2827,7 +2827,7 @@ static kdbtab_t maintab[] = {
 #if defined(CONFIG_PRINTK)
 	{	.name = "dmesg",
 		.func = kdb_dmesg,
-		.usage = "[lines]",
+		.usage = "[lines] [adjust]",
 		.help = "Display syslog buffer",
 		.flags = KDB_ENABLE_ALWAYS_SAFE,
 	},
-- 
2.39.2

