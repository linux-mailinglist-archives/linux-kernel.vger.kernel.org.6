Return-Path: <linux-kernel+bounces-420214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503749D7731
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 19:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ECD8B35C4E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA532130A54;
	Sun, 24 Nov 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IxpkEali"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE807DA9E;
	Sun, 24 Nov 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471026; cv=none; b=iOx+SiRSSwCj+BWqrmNZ7yvivtnnC+5xEPjF2NFr9LTqoPMMM0KCFQ81nuM80HaUPZ6JzgsEIsg2dBUePkTIRlZFkDAuTAekeX9euQdW5PVOSvgQiUuq8zl3PiRSkpR5QWOL/wLRSpiWV9tiCoHvyxX0d9y7SmW647ex2jKfy9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471026; c=relaxed/simple;
	bh=N36m4qf0vHUJME/BGWozQi52Ppm7rtH1eadVRTL7itw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXf0UnRo93h5S6uuB+iGD3ry9dphIeKsNPFIhcNHW7nsr48oMG5S5cwuReWqjX2PYRbCIFFyA2Nu55j29/mPXeHt49ktao/5GcjqhsZBIX1uztTBbLl6ackENHnmiFsf0ZtBzCInxvrT2NCEJuyGFP35AeLO4n8wTwy4Jr1vVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IxpkEali; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B4057C0005C6;
	Sun, 24 Nov 2024 09:57:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B4057C0005C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1732471023;
	bh=N36m4qf0vHUJME/BGWozQi52Ppm7rtH1eadVRTL7itw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IxpkEali8i4S2LiHQdJ1LYooXb3+eufGcBdQSgtKFEMm0PDE/wHPHHRhCxOt85Gn9
	 kK6SYPAsZFy5PTL68GMe6qVy04/Tc5SXgGrHA1i+7M5/qXJ7mHL6DPfAHiVIaYGVU0
	 lV+UzEg5gCqFzqdMCjraK0eldMAz5LdS3F526tUU=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 4BF3D18041CAC6;
	Sun, 24 Nov 2024 09:57:03 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Sam Edwards <cfsworks@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based on BCM4906
Date: Sun, 24 Nov 2024 09:57:02 -0800
Message-ID: <20241124175703.718707-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009215454.1449508-2-CFSworks@gmail.com>
References: <20241009215454.1449508-1-CFSworks@gmail.com> <20241009215454.1449508-2-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Wed,  9 Oct 2024 14:54:53 -0700, Sam Edwards <cfsworks@gmail.com> wrote:
> This is a series (EX3510-B0 and EX3510-B1) of residential gateways based
> on BCM4906, a stripped-down version of the BCM4908 SoC. Although Zyxel's
> marketing materials call this a "series," the EX3510-B1 appears to be a
> very minor revision of the EX3510-B0, with only changes that are
> transparent to software. As far as Linux is concerned, this "series"
> effectively represents a single model.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

