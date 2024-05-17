Return-Path: <linux-kernel+bounces-182663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFDB8C8E37
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1B91F23A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8D11411F0;
	Fri, 17 May 2024 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="oBVgypP0"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1A4C69;
	Fri, 17 May 2024 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715983245; cv=none; b=oLaBQmVFSacrbu5aG+mBKSqdUA4UKaKSo5EwXPJnm2QgOpnSENkIvLEWptX0G/O5QSH2SJd3ufYXobxtid1Xd40OE7uBBpiuw87ubTdNkg7ZLbayzf6O5dwoN+XEDa9lptdgU6ayVhefOwDygoXL2gX/a/nvMgSCgcCFq2MrPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715983245; c=relaxed/simple;
	bh=0yxqIjgr6bvtqQ/rzyd8UYI0B7lEklxten+qoHj5f44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oW5I3mZdEv0oG0MmUEkXaJz/hZFCdoKoE2Z/9D32Au/LtRdDz3g4NhHL3Qp7g3U+AXZSXQ8IWDBXE0TCEVPNfkJ2p/pHH1CkMQMQmcf7GCKiPi1POqUAWc7SnhOSKN4XBugu62/167c/NLo7Ig3SC1jLVjvx5abemOK/Sm7PITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=oBVgypP0; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A3159C0000FC;
	Fri, 17 May 2024 15:00:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A3159C0000FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1715983236;
	bh=0yxqIjgr6bvtqQ/rzyd8UYI0B7lEklxten+qoHj5f44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBVgypP0BsjU2kHvbHGEnmBgjya0DaZxwIeNVJ1ZF+WbJVNoN7VLB5UKqRoM7dI6M
	 +AyMWvGrFLx00FQ/KKyJpsb6+eWPFC5ZvVxpVusLdwCQILnu3gSfoKHWZ+LIxJJqPQ
	 hU8zdbDf8AzzF+rzUdr3qtMAt/2bvVEg1pCdcT+Y=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 9BEDA18041CAC4;
	Fri, 17 May 2024 15:00:34 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: bcm: document brcm,bcm2711-avs-monitor
Date: Fri, 17 May 2024 15:00:35 -0700
Message-Id: <20240517220035.2017272-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517125138.53441-1-krzysztof.kozlowski@linaro.org>
References: <20240517125138.53441-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Fri, 17 May 2024 14:51:38 +0200, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> Document alreasdy used binding for Syscon / AVS monitor:
> brcm,bcm2711-avs-monitor to fix dt_binding_check and dtbs_check warnings
> like:
> 
>   brcm,avs-ro-thermal.example.dtb: /example-0/avs-monitor@7d5d2000: failed to match any schema with compatible: ['brcm,bcm2711-avs-monitor', 'syscon', 'simple-mfd']
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

