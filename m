Return-Path: <linux-kernel+bounces-200926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D368FB6A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE0E2810C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8313D635;
	Tue,  4 Jun 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnuKCai6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5498BF7;
	Tue,  4 Jun 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513791; cv=none; b=STVP7jUPk5LhAJ5R1iqeFjTNavTeoLSlBmScdhfrBUGiFjz3GjpEqkhpmbQ4Id52X5pSfktxjU+QYLqwI1pnAJ/ATXAZviJzZGkEwAGnE0RHHiVG1qBbTLwGc1Cghadapme362lN2FnXd27s2vjq184h839N1QlmI0v8LkxPj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513791; c=relaxed/simple;
	bh=qgvY3ZxrCm8UCZTIzcUkLkRfzacSiyAz5Xf8BE4E0MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6fSvewgOBrR3fqdSivUwgD2C17G/A8FqX0Gpy9wZD4TWKbdjCnCOp0A7LrjfTLEMU2MMwSB0P3kIiSMVoonRYcYVek9lOx2kpKNu7upAioV7CS/pfNYC2sn8WDc0WBy3K6jZudfjKTsdwptLcIN1gmRix6REPx8GaZD9VVKWXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnuKCai6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B6DC2BBFC;
	Tue,  4 Jun 2024 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717513790;
	bh=qgvY3ZxrCm8UCZTIzcUkLkRfzacSiyAz5Xf8BE4E0MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnuKCai6CwOptzGSIdaZYUzg9oGBe+X44x6I3lJul7UQSVWQOJYR+XKH2J6IAZdio
	 7uh58GgCwfguO4a45msU0mNg2AWGRdvnbScDlVgehU7gKVr9XVYS61Mqur3xTYzPr0
	 wElKLfvSSU/spDClJRAz5IRzquameRiA8cw2vG8dzTDjK64HiIfV2DxRaAJdGyevJX
	 MlLI1HU6eYPm051i9fyMu/gcM4RZIbtZ8g9JK1trDL1/RexwWWrC/VZwePsoTuhoCp
	 m1PVCitIu7KTpIZlHsBgkKEHR5vEkLSrIT6bW9k9S5fjW4f4Ldum3q9bnz7I3ATcIN
	 W+hoCsy0sZeLw==
Date: Tue, 4 Jun 2024 10:09:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: Markus.Niebel@ew.tq-group.com, joao.goncalves@toradex.com,
	ping.bai@nxp.com, frank.li@nxp.com, devicetree@vger.kernel.org,
	m.felsch@pengutronix.de, abelvesa@kernel.org, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	ye.li@nxp.com, hiago.franco@toradex.com, peng.fan@nxp.com,
	tharvey@gateworks.com, m.othacehe@gmail.com,
	alexander.stein@ew.tq-group.com, imx@lists.linux.dev,
	s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	festevam@gmail.com, shawnguo@kernel.org,
	gregor.herburger@ew.tq-group.com, sboyd@kernel.org,
	mturquette@baylibre.com, aisheng.dong@nxp.com, bhelgaas@google.com,
	leoyang.li@nxp.com, conor+dt@kernel.org, kernel@pengutronix.de,
	hvilleneuve@dimonoff.com
Subject: Re: [PATCH v2 4/5] dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
Message-ID: <171751378585.661386.7201045079394724891.robh@kernel.org>
References: <20240530022634.2062084-1-pengfei.li_1@nxp.com>
 <20240530022634.2062084-5-pengfei.li_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530022634.2062084-5-pengfei.li_1@nxp.com>


On Wed, 29 May 2024 19:26:33 -0700, Pengfei Li wrote:
> Add the board imx91-11x11-evk in the binding docuemnt.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


