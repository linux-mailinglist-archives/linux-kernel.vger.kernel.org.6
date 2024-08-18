Return-Path: <linux-kernel+bounces-291084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE722955D0D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761971F21512
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB95F13A25B;
	Sun, 18 Aug 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7oCRESy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102A12B176;
	Sun, 18 Aug 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723992903; cv=none; b=cn3vqsQ7POkcBXj77xoMCcBHne25O7iFu20UgF/Lxm3M1WyavLvdBmm+oDJtoAiXGZth3khBDJSY0KmUo6vnQC+54l35+0gW6HCiBii+uTlJpz36x0MskzNxJeFj+aAW2ZtV+d4jscDnZPsaSYCevJ02ZkD/pL4gjqxNLvTUxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723992903; c=relaxed/simple;
	bh=rw+nzktVxqK0yA7mRMC1aFQ2MPxcNNJglg5wRzA5Nx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB8bHoOZ+HMv9w59rlmfFaRC1eSWfjolKpW35uB8mkkjszrqmQTQMn3+yQNCstI7+7QXfYND3FUp7Slx1WJfESZ3pDRDBS7eAhiH8bH3qTAr7MkMlYZua0sQTRXtvIIzxYZZ1SioqFS1s25HWRpzbc2yTZYk2T7uNlBIObuQ738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7oCRESy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37276C32786;
	Sun, 18 Aug 2024 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723992902;
	bh=rw+nzktVxqK0yA7mRMC1aFQ2MPxcNNJglg5wRzA5Nx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7oCRESyyuCoulq2rbLA3gOL5OJ15htMXsknsMdgiXKu39Av4ErfSLhAM2vFOMx3G
	 zKAGkMP9g4na/UJhsFNvgNFUaTgq0uhxdY/0n61okmWCxT1uX9kBn0Bi4h0ZwCTylC
	 LxD/rokCj65Db161pGgKZ/82pdY+fcE/bO0TyaIqfWUHaH/dN6c14PWumd4WVJcZ3R
	 qHYUcJlH4ZvQEBcTC2HHG2yznS8zDNRdeMLQKWgEK3KEnjzjIA6+MeeMARqKBZjmtF
	 jZQWOh4qU3is4bazrqui6wXNUHd5MUKXuXoU+t1NYvTREN6VA5VlBb8mQXwvzBQjbv
	 IQCOWLMfmC1TA==
Date: Sun, 18 Aug 2024 08:55:01 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Fabio Estevam <festevam@denx.de>, devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Michael Walle <mwalle@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH 1/1] dt-bindings: arm: fsl: add fsl-ls2081a-rdb board
Message-ID: <172399289976.66478.14367115507162901162.robh@kernel.org>
References: <20240812200816.3828649-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812200816.3828649-1-Frank.Li@nxp.com>


On Mon, 12 Aug 2024 16:08:15 -0400, Frank Li wrote:
> Add compatible string fsl-ls2081a-rdb for ls2081a rdb boards to fix below
> warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /:
> 	failed to match any schema with compatible: ['fsl,ls2081a-rdb', 'fsl,ls2081a']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


