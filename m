Return-Path: <linux-kernel+bounces-405890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6BF9C5897
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8022028116E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6A313BAE2;
	Tue, 12 Nov 2024 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au0AuZi/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D343433C0;
	Tue, 12 Nov 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416812; cv=none; b=XZWU/mWp8k/LDBXS1Dgh/FRVKzdFN76aRjPjMFNNPOFY2a6m/CBuFk7UcGmFWuSgEFFNSndJwPaXTUGxeMq+WRtA8KASvtnuFdqF0BDDf3kNlHaWgJ1dXHvnaHZSH546A52OhqqS0Bl7vHrv66hDw+pKRVlwSpOPlkJUiLhIFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416812; c=relaxed/simple;
	bh=gZIoQGeaxcISi/ApxKkNhmG1J31HpPDf5Fz9RDF5j7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=riOiiky7T+4aLMnlY5Z34wAF/XWH+dO3BFR1+MhnCX0fE1M7Smn40vGNvFYnUs5b5racjxYzN/nO106rfENqkrJmJAbkjCwpOVtIaGcFbvjjN+yJiro86vqugDDkmdhJ/IpxBhBu3MQGf3GKe7tn4TzgMbjacboZ9P1rG0GRjtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au0AuZi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F54C4CED5;
	Tue, 12 Nov 2024 13:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731416811;
	bh=gZIoQGeaxcISi/ApxKkNhmG1J31HpPDf5Fz9RDF5j7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Au0AuZi/Rn7AT215+X3xhBpDv2QBrk/MG72TFVKe2QDEBUqSbF2RjZqR+WR8H9H+r
	 wjTZrGv9gG25+EWAjHc9b6VPh0FREUb2t/EcqUpmliZVIv64CMEr35eppyew9b6qlP
	 fLTpgOxWbf5DgmG7T5Nd0nioGzwM9Xq2t8PzA6oTncpLqdODXHj2OVoejZPa4sk9vC
	 9Hag+ZCqioZWlLHuaJy5BcfCQKSK7ogdCsE1RNYZdkLalye/3oG/iqGI/GPgMyvpJv
	 Bc1vFGxS8HavceXJANJIZMk1o3JEXDkmles1llhgqgMMLLWBqJGKz1o2eJsneNduvS
	 x+kqoEbZ5Pcdw==
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
Subject: Re: [PATCH v5 3/3] mtd: spi-nor: support vcc-supply regulator
In-Reply-To: <20241111111946.9048-3-tudor.ambarus@linaro.org> (Tudor Ambarus's
	message of "Mon, 11 Nov 2024 13:19:46 +0200")
References: <20241111111946.9048-1-tudor.ambarus@linaro.org>
	<20241111111946.9048-3-tudor.ambarus@linaro.org>
Date: Tue, 12 Nov 2024 13:06:48 +0000
Message-ID: <mafs0bjyk7g9j.fsf@kernel.org>
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
> SPI NOR flashes needs power supply to work properly. The power supply
> maybe software controllable per board design. So add the support
> for an vcc-supply regulator.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> [ta: move devm_regulator_get_enable() to spi_nor_probe().]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

