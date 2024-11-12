Return-Path: <linux-kernel+bounces-405885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBA59C587F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644C11F23270
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A444C139D1B;
	Tue, 12 Nov 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpwAvlnn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8D7080B;
	Tue, 12 Nov 2024 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416595; cv=none; b=Bi8C7PrCZa5CrWQYUXDmgljvioDn3jTwnKYJE8pHFBHAlPDgbmid/21sFZmirNkWwpqTIa/9F0LKoD2hhuFbz5wU97pKW5uKCd5w+cdnqe78IlC6dglsjamwc9l39sUd83/edxFQLeZ5G5xrszuojkNAMTd+jzO1WbjSj7mLax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416595; c=relaxed/simple;
	bh=ECj5XhRXQ/Zst8H3AmAZiJNySS2gWUlAEVZ/YWBAayA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mtELEnHttbyCOGszF8nO0Lk3ODwukeCeqHHebjJRqqJDAQ/xGzWSjzJJlE43sJoF+Vp1xJaUo2ObuXKKzKQFgjHhBmoOsJaIQlllAz81wgyXKuAYeq7ZItvc8DUIuglfO2BCS754rwrIb53l3ifKsgeuxEZEoeiLgGBMqLbZNhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpwAvlnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DD0C4CECD;
	Tue, 12 Nov 2024 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731416594;
	bh=ECj5XhRXQ/Zst8H3AmAZiJNySS2gWUlAEVZ/YWBAayA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QpwAvlnnxlHt865i/XRmNcaI0OA4JQqJXEz5crxqmyEuz9s9SLx9HXAvvt0iAPPNT
	 YxnWrQvcL6AgHJ2BrLQ4QRcG79YChUQVSwcuOGKPwC4LKSDDF5xZa8uP3dW7l19YZ/
	 SPFQGwoJoSweQOyWofxLHWCgitcHl0/lsI5CNiR6yhW0ZJgwfyPdm1ChaJ9pMO7CVD
	 6f2FG/zprkAyXEER9zc7AG0baJ0axKilO2f+U823YiKQmqjjdYSh4hlhHZc2+lnl+K
	 B9GGTfoQFqHe4MU2wLumlDpoIFPLuADA3U3LO5KFeP/GxHbrg4/v5mPD+aoKcNiIzy
	 /hXAwMEUZ3CFg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: peng.fan@oss.nxp.com,  m.felsch@pengutronix.de,  pratyush@kernel.org,
  mwalle@kernel.org,  miquel.raynal@bootlin.com,  richard@nod.at,
  robh@kernel.org,  krzk+dt@kernel.org,  conor+dt@kernel.org,
  shawnguo@kernel.org,  s.hauer@pengutronix.de,  kernel@pengutronix.de,
  festevam@gmail.com,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  imx@lists.linux.dev,  linux-arm-kernel@lists.infradead.org,  Peng Fan
 <peng.fan@nxp.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: mtd: jedec,spi-nor: add optional
 vcc-supply
In-Reply-To: <20241111111946.9048-1-tudor.ambarus@linaro.org> (Tudor Ambarus's
	message of "Mon, 11 Nov 2024 13:19:44 +0200")
References: <20241111111946.9048-1-tudor.ambarus@linaro.org>
Date: Tue, 12 Nov 2024 13:03:10 +0000
Message-ID: <mafs0msi47gfl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 11 2024, Tudor Ambarus wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> Introduce optional vcc-supply property, SPI NOR flashes needs power supply
> to work properly. The power supply maybe software controlable per board
> design.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

