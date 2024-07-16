Return-Path: <linux-kernel+bounces-254149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC6D932F84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EBE1F20627
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505F61A00FD;
	Tue, 16 Jul 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BWM6OdOD"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8F19FA94;
	Tue, 16 Jul 2024 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152481; cv=none; b=KfDy1fymICTROi7G8SUY4Gv8eQbg7s2qyM0pREflzFvbRbOwbKO/jZc7lNB9PDWWWqF81N/2hdEwCk2pVYwnpQnZifSbhfYu1AR2SQ6nW8UVR9w7uu/e+lD46xePRVjTrWF8eZ/0t9an2SdrUAxKzv6NJOZB0XH0QN/zh5moJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152481; c=relaxed/simple;
	bh=prgjPxYij3SHyZHpzob8UsPYte+J2xXXXesa79k4KJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYg9toVTuqmp4dDehahAlDES8Hr6N7R5Hif1js5fAyHzSKJPmel8DbS9v8yt+B9ze7IyrlgfETNalX/fKawNxA9Nz/43RzWDZVgjRgfRxEaFwZP3NT4G/tPI5VpuWUfvIkfls+lCJpwQnfqEIrdRxVqhufCZuDxOUV/ZanKI1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BWM6OdOD; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D3594C0000E4;
	Tue, 16 Jul 2024 10:47:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D3594C0000E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1721152049;
	bh=prgjPxYij3SHyZHpzob8UsPYte+J2xXXXesa79k4KJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWM6OdODQlUfSYOS6Sw8LT+MMM3a7TcFGdn3NHt2X6T9ZJVEz2K/BSvr2p7NWtP2T
	 dIdevqG9cT9+9U1q+TntRym7i8YSKa1R8D3zufLa5BxAl2S0AmwO1gLHnckFyoXAdp
	 tzXFxoakoZkUk3Rpra/Gl3m9rPbSEnB+Gu73AsyQ=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 5E6D618041CAC4;
	Tue, 16 Jul 2024 10:47:27 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Florian Klink <flokli@flokli.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] ARM: dts: bcm283x: Fix hdmi hpd-gpio pin
Date: Tue, 16 Jul 2024 10:47:29 -0700
Message-Id: <20240716174729.197020-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715230311.685641-1-flokli@flokli.de>
References: <20240715230311.685641-1-flokli@flokli.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Tue, 16 Jul 2024 02:03:11 +0300, Florian Klink <flokli@flokli.de> wrote:
> HDMI_HPD_N_1V8 is connected to GPIO pin 0, not 1.
> 
> This fixes HDMI hotplug/output detection.
> 
> See https://datasheets.raspberrypi.com/cm/cm3-schematics.pdf
> 
> Signed-off-by: Florian Klink <flokli@flokli.de>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian

