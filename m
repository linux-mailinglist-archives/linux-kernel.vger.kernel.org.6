Return-Path: <linux-kernel+bounces-435261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA209E753B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7557F1886095
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDA920DD58;
	Fri,  6 Dec 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8ukGMjU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A525420D4F1;
	Fri,  6 Dec 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501519; cv=none; b=AIVzE8WP4Y8CjPWh2t4hChRq3EHcr8BjKLxU4G4mJx5o/gYCXkbD/8HsfhXRTLEJ9YzJjFdM7FaNf1DffhvNrVMu5e+eCQ2F55IXavY3b3ryl0/FBLdcqb2FM+vIsoJNR4Irx7o++ZCBU5C6PfOVZRzyduP9CV+zplkpPEZmae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501519; c=relaxed/simple;
	bh=Lt+SQSnBA9wnvSKApsndBQdYloKh5o8e9F3rbhths+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TrF68dzCwRI++s5cyO5e+l1fbz4JAee1/h2e+Ko7FCsixumhkEl8/cYdpzuvWloVPe9Zb3kBQbOKyqf4L3HZV9tXKLDRbXvMDHx8Op5prVlNXyX6MjPWeQaiF2qXEWQ3H7uG6C54ubQJseSziYWT4+fWycx0IEb2ACJk7uyvp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8ukGMjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC63DC4CED1;
	Fri,  6 Dec 2024 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733501519;
	bh=Lt+SQSnBA9wnvSKApsndBQdYloKh5o8e9F3rbhths+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=d8ukGMjUHk6PkzMdwsDHJk25IJAW25BZLurKOFFGTVT8de4gyVGMxe5CQKDjvgpWP
	 mri+WBEwInVTwZIkags5zCF6nySHtsmH/VsljHe1aUunJM3s3Gurwm/vakaPhXjV4y
	 Qj1Q9rT9vEFrTZ1of0fc4KxeTVl7t0b0XDDh/jX7RrmrHrekJJBWUK1mEfxOFkSXjh
	 YsU+cTpyGdRDGuWyZQHM4gEApjXjBgAJz7OpMexnKGRqy1Z611UnRccEmqgm2LOqAJ
	 JKbWSpZYuSDmLw+xpMbbYiM2Db09YNbLuH7NU+kdXmLxZrr0wU5Le7AyOR2emkjN3M
	 j5ym0sDbLLGlQ==
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
Date: Fri, 06 Dec 2024 16:11:55 +0000
Message-ID: <mafs034j04wqc.fsf@kernel.org>
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

Series applied to spi-nor/next. Thanks!

-- 
Regards,
Pratyush Yadav

