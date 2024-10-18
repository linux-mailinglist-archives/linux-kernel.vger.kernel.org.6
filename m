Return-Path: <linux-kernel+bounces-371786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 956D89A404A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F88EB221BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C34374CC;
	Fri, 18 Oct 2024 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWTPB9DJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5483383A5;
	Fri, 18 Oct 2024 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259155; cv=none; b=sBt5v9DQWd+zR3PK65nkUWGYvVlUGTfMtFtUNt+h/MQzEJIUXE/0uil2C9KxVcGhfw15+QgeislEqbNFJW7E/PEOAu/XQD7MzThQbbkCPgfMg6mLiCM5Sazdew9s93DUhp1kCqA6XONcw0xugMGO/3m832ATsl1O3wG39PKxM5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259155; c=relaxed/simple;
	bh=CklTe/sXewxTep/j2tX2kpLI/u7HR37XRwOnv0QXBoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL2kSNdBEtld7bEKS58EsUXozuaqu05T2FJXR6VB3jJigTsuxV/sSqVdDjMduser9UhvtK4ASShXAMzJY76ETwWphYjqh1sCcYSmy3ypxmo+3V/5Za2Pcp88IPnOoE6XdhGOPBpIhLN7FkXUqMmyRpQEsNFE2EvmYQZfq7j8TzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWTPB9DJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AB9C4CEC6;
	Fri, 18 Oct 2024 13:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729259155;
	bh=CklTe/sXewxTep/j2tX2kpLI/u7HR37XRwOnv0QXBoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWTPB9DJFYBjqHATlsU3j74Kyfijd/bxM6XtTF7Kv2aZdrgndLqrHZwSyOWljZiQ7
	 P7XVNQ9L9tQJ+rGU4UtxqtUDfTPfst3MxzEc2/hjnPkZtxcoj0VJ5xVt6uK55iS4fK
	 gQf8xY2KMCN6gyuyyHppQ5u8w7d2fAJOQ4RBRqONYnTU2agYBTP6sqBfmLgu/Egqd/
	 E5A7teDhUM84DxbKG+ksnccow8rmRFkCvCEtjt1pbdxDvaqo13RzjuSnmZ2hKBPe+y
	 66jxPFULuf0+/Gh9Sjl0QOgr3BwA2LtugZprgF1sJnmQkk18J5rgi56UVGWjWjn1GT
	 FTg+zwEpCkq6Q==
Date: Fri, 18 Oct 2024 08:45:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>,
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, krzk+dt@kernel.org,
	imx@lists.linux.dev, Tim Harvey <tharvey@gateworks.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	shawnguo@kernel.org,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] dt-bindings: arm: fsl: Add Boundary Device
 Nitrogen8MP Universal SMARC Carrier Board
Message-ID: <172925915337.90053.2297657985749667518.robh@kernel.org>
References: <20241018091023.29286-1-bhavin.sharma@siliconsignals.io>
 <20241018091023.29286-3-bhavin.sharma@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018091023.29286-3-bhavin.sharma@siliconsignals.io>


On Fri, 18 Oct 2024 14:39:28 +0530, Bhavin Sharma wrote:
> Adds support for the Nitrogen8MP SMARC System on Module and
> the Nitrogen8MP Universal SMARC Carrier Board.
> 
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


