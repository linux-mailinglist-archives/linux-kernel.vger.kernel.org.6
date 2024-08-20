Return-Path: <linux-kernel+bounces-294491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EB7958E47
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F89428583A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8377C15ADBB;
	Tue, 20 Aug 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O8aqF6rL"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D2130499;
	Tue, 20 Aug 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179744; cv=none; b=rpEzDWkIyM3gA/+lOQMWTHjcXGeNDam4ky2Mge3BuFzTN0s94jQAmLQJxXvUcjiv4t0I9R73+h/PdK+cOWgHmvQPWAoITJ5HSBhrx+TI6VPWh9xun61Bj8gzsqUf1za0BeRse6Wu4id/KMqBD5Dt8TJOGnJ+ZrbqCbDIqCn6z2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179744; c=relaxed/simple;
	bh=C0r89rcEoDQ3h3tPnSyu9wf4bR9g6nPYmndJAE/Egl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oocRUnteN7nY+KOOkudo83PFnsBF4EzPY95B/cn8wv2zuYlhtmFIBkNyKP4pCpnd0jgewuf/E1Ikc3o9lyhg9C5jsxFGKOQkvk8E+AQU4xPAzDALHXu9670IwqgiH57AOmxFMj1K3M4Jd0FJDU/kfRWKtGmkNfng4et998BieVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O8aqF6rL; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id CCCF0C0000EC;
	Tue, 20 Aug 2024 11:49:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com CCCF0C0000EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1724179741;
	bh=C0r89rcEoDQ3h3tPnSyu9wf4bR9g6nPYmndJAE/Egl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8aqF6rLMxj1zLN6ZsdcUrmO4YrGhS7E5Lal3WKh7985dn8BqgrawZjcI3TYPLO+F
	 FkdeJfcSM5ChVvWK7gm8PEszO+MDlu03qOYhXALYWh7Qq1yTjysUAwj3mIVHf1Lvo/
	 lRKUCiHJfiSDs0m27rKcukUqlEiyBGG6/PvJseiU=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 64B4518041CAE4;
	Tue, 20 Aug 2024 11:49:01 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Artur Weber <aweber.kernel@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] ARM: dts: broadcom: bcm2166x-common: Increase apps bus size to fit BCM21664 GIC
Date: Tue, 20 Aug 2024 11:49:01 -0700
Message-Id: <20240820184901.266866-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820-bcm2166x-apps-bus-fix-v1-1-0478a3227e86@gmail.com>
References: <20240820-bcm2166x-apps-bus-fix-v1-1-0478a3227e86@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Tue, 20 Aug 2024 16:38:14 +0200, Artur Weber <aweber.kernel@gmail.com> wrote:
> The BCM21664 GIC sits at a higher address than the apps bus currently
> allows. This is because the apps bus was inherited from the BCM23550
> DTSI, where the GIC sits at an earlier address in memory, and the DTSI
> wasn't updated to match.
> 
> Increase the size of the apps bus to allow the BCM21664 GIC to work.
> 
> Fixes: a5d0d4a7bab5 ("ARM: dts: bcm-mobile: Split out nodes used by both BCM21664 and BCM23550")
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

