Return-Path: <linux-kernel+bounces-420225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72549D77DB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 20:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B726B2B251
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BAE13A409;
	Sun, 24 Nov 2024 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eX8VceSo"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D259B3201;
	Sun, 24 Nov 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471378; cv=none; b=Y1X7yzRBDI9w/NwyRtFjlMJz+JSm6+tWbv//7ATvwkZkru6xhgUKHXZzHxQOZgPqvaUNUaUqWg5bK5I7yYLg8obCYoLtYG/uoV5pyzAqoA7TsD2SicfnICtMqG0N6hy0Zf+8h6Z7ZzO00ewMmwhtNUL9CigsHToscq5WxGeFPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471378; c=relaxed/simple;
	bh=/2cY9gzo817mB41fvzRaH6gWD65jFTEbyCXf5Xisr8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTbRWkxcCZecdyams1iE71G1U3TmlqmsxXPtcvp3AKz9Z2lK8FA1Ci1R0GAmSweC1WCUkTtsASIOnallcsIjVQ04KZhuIY3qFBdJJswutD9VQ+Ek+cCs3mqwY0gre0fEQX9eJTnuXQG7+eoeLcOxs3sE+fOFkVujPtC/j4SwU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eX8VceSo; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id F3DA9C0005ED;
	Sun, 24 Nov 2024 10:02:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com F3DA9C0005ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1732471376;
	bh=/2cY9gzo817mB41fvzRaH6gWD65jFTEbyCXf5Xisr8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eX8VceSo/s3qUvA1dEbDZvcu65yNUUqGpCWj1AJvWVoYTWlGHIvhpI2qjdrPlCl3K
	 DB73wX63Ta3YW5CTkpcHEZvcIuMv1i3X2fhVnCC/vn3yQoScwEoG289cNBF+29Cd7O
	 ZLXUEorjAES3Gn4R2MSnBzlk4Jw6EpAmkBExq/Qs=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 944CA18041CAC6;
	Sun, 24 Nov 2024 10:02:55 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Rosen Penev <rosenp@gmail.com>,
	devicetree@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:BROADCOM BCM5301X ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: meraki-mr26: set mac address for gmac0
Date: Sun, 24 Nov 2024 10:02:55 -0800
Message-ID: <20241124180255.719987-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021015147.172700-1-rosenp@gmail.com>
References: <20241021015147.172700-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Sun, 20 Oct 2024 18:51:47 -0700, Rosen Penev <rosenp@gmail.com> wrote:
> Currently this needs to be done in userspace.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

