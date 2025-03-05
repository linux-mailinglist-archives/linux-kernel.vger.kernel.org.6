Return-Path: <linux-kernel+bounces-546941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0235DA500F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24D53AF9FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C2B2500C9;
	Wed,  5 Mar 2025 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="mQFr02Xf"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9378A24C09A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182239; cv=none; b=F755J8zrmcp86bhn6TyfrvfcbLejBJgrmHuE+FwgEkIzX6abRbgcyTaUxYebrIaVkGDyKgcBt0s3xT/mlGAL8sKZtsAnpndvZB/Nlcb7snDufEv/lUBOLygxQZs/h/6T5OKRaau0q0aWF5KgNOjzCsDD/r2K/yB0Uk+3r1ESut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182239; c=relaxed/simple;
	bh=jDpqwgqRS0Pm7vrRuf7qtk38rTRX1aLJvoi4v2uLx4k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EK1O7aP/gfGbKtIDjCv72TiPx2xvz3bwbVbyNsnt8sb6tsrnP3omWj5kMI+VGk02lXcwd3SNBfhh2jGfcfwO/AZhfDHpAR7CVu2TL7rPAr/5kx5Gfc6UP/VCuvj94B8L/Jo11mPdcggp/oQKadS0ukRqqyxywJu9eCvqfIPar6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=mQFr02Xf; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1741182235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QO9qKoULzoYWBABgf51NjYdGSNxXU0EMfpVjVSk9Mzc=;
	b=mQFr02Xf/PCIkBtVH8ROPNcA1j26gf1sXqPL3epIxfHi3UC8BpWHrc0qm5fGbxC8Lt0gG8
	GI4jfqo5mTnEFtPDiKPxgu8apCWZdIjwKidneo36lLjI6HV6/BTGBTK7fzMjA3E7yISf6T
	NPpeqG3Fruhu2vc2vx1977bIZA863Mptjma1YcjBPPyZbAWm+EL2FoEu8nYdn0D5IYDcRw
	i0Ijl0xPRfwQcG68W0K3b8j477UEcxEtQr8X9hzUfeWrLToGPkjY15Ii0OZtNaH6VM7Qjw
	OotUMUUDicGWrvuiygnZd/pmxp64+g3AI36H0egvb1zWG0a9Ze3Ee/MOX/q68Q==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, 
 Janne Grunau <j@jannau.net>, Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alyssa Ross <hi@alyssa.is>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neal Gompa <neal@gompa.dev>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250224-adpdrm-v8-0-cccf96710f0f@gmail.com>
References: <20250224-adpdrm-v8-0-cccf96710f0f@gmail.com>
Subject: Re: [PATCH v8 0/5] Driver for pre-DCP apple display controller.
Message-Id: <174118223158.156873.6982508045942987984.b4-ty@rosenzweig.io>
Date: Wed, 05 Mar 2025 08:43:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On Mon, 24 Feb 2025 12:02:15 +0100, Sasha Finkelstein wrote:
> This patch series adds support for a secondary display controller
> present on Apple M1/M2 chips and used to drive the display of the
> "touchbar" touch panel present on those.
> 
> 

Applied, thanks!

[1/5] dt-bindings: display: Add Apple pre-DCP display controller
      commit: 7a108b930a84e71be71c3370eef6dd96fbb8f618
[2/5] drm: adp: Add Apple Display Pipe driver
      commit: 332122eba628d537a1b7b96b976079753fd03039
[3/5] drm: panel: Add a panel driver for the Summit display
      (no commit info)
[4/5] arm64: dts: apple: Add touchbar screen nodes
      (no commit info)
[5/5] MAINTAINERS: Add entries for touchbar display driver
      commit: 4d2a877cc0efefa815648f1ed5f5b2b796f55bab

Best regards,
-- 
Alyssa Rosenzweig <alyssa@rosenzweig.io>


