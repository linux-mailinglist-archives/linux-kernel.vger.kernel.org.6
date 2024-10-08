Return-Path: <linux-kernel+bounces-354834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF14994325
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFF328CE8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76EB1DEFF0;
	Tue,  8 Oct 2024 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JwPa/CRV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976C1D07A3;
	Tue,  8 Oct 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377690; cv=none; b=tHjJ8zRrrph2+nqNVs01XQ259mQAvlQR9CJT1bd+mKl+n8q+QvrvMAXxJ+iycUBdKd2lTju9P/U4wGSQjX1h1fCqBZ/ZOkz9JIj32O9QT1/xVNrY4sKt+ak4n4IbCWQkr5q3xIBEk8/6M5nTeRQQVZDl56scHfG5lyaIbPEgBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377690; c=relaxed/simple;
	bh=AWG6oEPgkDnw7LKNBFVWOBnbxOnDKzU9e0dST5ZmFXE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j820SWmRjdwxSIWPOXI/0aBcKf2a/aFOSFgBUV2XgCIyO7vMepjdgEvb965mD8OfW6pYVyPLFGtLVRxKMkxb6BL6N4/705fTUCNA5eaVB2BZqXZBpnfXZ/gPjll+PubOziDd5oS0nKkx9Y8RgZqBI8/fXrGz9jFgo7bHVBCeIM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JwPa/CRV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728377686;
	bh=AWG6oEPgkDnw7LKNBFVWOBnbxOnDKzU9e0dST5ZmFXE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JwPa/CRVOdDORLtFLtBLkIoZG3BujChD2qm5GonXu+9uVQo3g+8ZfJhWpeF/Q81L9
	 zAObKF9dVyXkXtUy5ksZfdiwcwOz+xQzGG3Oii989v8/CLf/QWKqQXTxICHkLxvCQr
	 sVHC7UwJz6C9Yzo7Yktu6tWupi+yLfQqB6/Z0hwjHt63JsXVuOwe7kBsDVdLdaAWZk
	 6cYv3+/UMNzTYdAvMrmSGQQwxujLIWqq9klc4WxB8rnySOf3l/TXPKbSkYwZ7Mf46I
	 DIPrsPHSgpiNVNsXK0U2zXyRVR0rrdOiuvoaYbBiBmmuVfCf6x1gmvsV8F8GW53oF9
	 c4fwmLwDEyWmw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B45FC17E10C2;
	Tue,  8 Oct 2024 10:54:45 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
In-Reply-To: <20240909-i2c-delay-v1-0-4b406617a5f5@chromium.org>
References: <20240909-i2c-delay-v1-0-4b406617a5f5@chromium.org>
Subject: Re: [PATCH 0/4] arm64: dts: mt8183: Add i2c-scl-internal-delay-ns
Message-Id: <172837768568.33038.2488434052434863943.b4-ty@collabora.com>
Date: Tue, 08 Oct 2024 10:54:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 09 Sep 2024 07:29:02 +0000, Hsin-Te Yuan wrote:
> Add i2c-scl-internal-delay-ns for each device.
> 
> 

Applied to v6.12-next/dts64, thanks!

[1/4] arm64: dts: mt8183: fennel: add i2c2's i2c-scl-internal-delay-ns
      https://git.kernel.org/mediatek/c/5bbddfd0
[2/4] arm64: dts: mt8183: burnet: add i2c2's i2c-scl-internal-delay-ns
      https://git.kernel.org/mediatek/c/3d3bc7cb
[3/4] arm64: dts: mt8183: cozmo: add i2c2's i2c-scl-internal-delay-ns
      https://git.kernel.org/mediatek/c/02586956
[4/4] arm64: dts: mt8183: Damu: add i2c2's i2c-scl-internal-delay-ns
      https://git.kernel.org/mediatek/c/65b99309

Cheers,
Angelo



