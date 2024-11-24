Return-Path: <linux-kernel+bounces-420201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D64A29D76D7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706E4164189
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E6F7FBAC;
	Sun, 24 Nov 2024 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="lbZTG1Mk"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417F75464B;
	Sun, 24 Nov 2024 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470334; cv=none; b=LHtzvRFWasmLhn+4bnflsi32wHoq8Q25ZH+653Dl1l3mzRO+68VZyH9aTBdxRTGS98U75iEFwO4Epa7i3RP391C2J43/49Ddux51a27K9V/wz7QIfhCWfAJ5E1JZXfGcnP2Wv9hAsiQD838J3VcBJOx3A2Ek7FTIqAbkLF/wDVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470334; c=relaxed/simple;
	bh=KJiwNKB+6HY4s6PD4bB+NeEGvWMCyutvgtWEsQJTrvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcmgWMkwXBXMkSjJkKiU6z6o+E1unCZSUbwCsGmnkcs3/yqlEUPxYV/bWjpgvAInpVPWf7Dg3pJSvaGHjhmjrcEes9iwoBJLbomHo3jaPsVsNGHL5XViTmkJlaw39CqFfv/96CQsXyLUN6BEEjS5NsBrtBTmvTzLUWXKFTnK5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=lbZTG1Mk; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4372AC000C6E;
	Sun, 24 Nov 2024 09:45:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4372AC000C6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1732470332;
	bh=KJiwNKB+6HY4s6PD4bB+NeEGvWMCyutvgtWEsQJTrvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbZTG1Mkb0L/Jx10XXxz7b6ZTbbN8ncH9TAxu3AwewBIkWOT+sMwAKfPZtKCIrP4w
	 YFYGPPcjt820H3YJ4g6xLTjl59uB7A8oOf4Wy5e72PBB2ugkanqrq1wgZ23yrgV+by
	 MiC0NkL/FEVyeHrM2CVBxYu6j7EytreyBk0IM0SM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id D296718041CAC6;
	Sun, 24 Nov 2024 09:45:31 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: dts: broadcom: Remove unused and undocumented properties
Date: Sun, 24 Nov 2024 09:45:31 -0800
Message-ID: <20241124174531.716317-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115193904.3624350-1-robh@kernel.org>
References: <20241115193904.3624350-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Fri, 15 Nov 2024 13:39:01 -0600, "Rob Herring (Arm)" <robh@kernel.org> wrote:
> Remove properties which are both unused in the kernel and undocumented.
> Most likely they are leftovers from downstream.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

