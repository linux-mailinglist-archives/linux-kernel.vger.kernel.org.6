Return-Path: <linux-kernel+bounces-530027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACE7A42DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D203A7640
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C4024290C;
	Mon, 24 Feb 2025 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWb+AJ2m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C615886C;
	Mon, 24 Feb 2025 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429134; cv=none; b=k+ec16wrZG2A0ULZLFY5LeCgjYBzTtTfq5fwHTYKIHGCAXc4MiUjj4F+uL3HYv+hNPX27uvhwyLlTS2IbPXq165Yc5Z9MVxA2CYJpMtzSIDFNR1PJisqSGCH7GLvYDXPTqPO/BCNNupqZCzwTB/uZowElGBI6XeQGpe52X2kyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429134; c=relaxed/simple;
	bh=LEHxu5uUmeaV7+NU70Sza9810F5pHO55NG+jcIxXdLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1yvoHm+GFqDz+rd1DhPjgHJ+v3y3H5NlMjVIoZ1huo9wkxkkZ3JslsGlvwnSjs5KZPATxezY9D0tcbBm5+yoaJZiceAfRqXs9ux8hj7ZbPZ4coal9+cHmS60tC2DQas30KuoXs8+diTNpq1CqCxG5SpL+VPDWl3Jqb+0xRSph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWb+AJ2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2F2C4CEDD;
	Mon, 24 Feb 2025 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740429133;
	bh=LEHxu5uUmeaV7+NU70Sza9810F5pHO55NG+jcIxXdLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VWb+AJ2me2apk+gmPLWDZXowwwAyEGuesvKDYbTkGbZHkofFvMw3X3ejLPs2COr1o
	 ZgWG/ZCnkVCXoqmgHOlJyw+MFXK10bkkBCq0uU8+r9oj8XVlreLKT9zfngo86iM40E
	 aPuqms5vxELWLUCfMdDPKextu5DeajD2SxRgSCZ2P3x3+EQAI6+YZY9vNjOxIFmkFJ
	 EbuLfaAacYExZJfr99LMkww9uW/iEkHAJg3kx8mPaiQhp5p9Ywi4v05Lb9LR3WoPfv
	 Lg537vsSWQwVwA2rJXRKVGHKoCT5bnYp/D99eniwkRm/sVY4LM1Kl4VrxGEXC7IfKu
	 m3ysrKMt5H7uw==
Date: Mon, 24 Feb 2025 14:32:11 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Liu Ying <victor.liu@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
	Simona Vetter <simona@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 01/14] dt-bindings: display: simple: add BOE AV101HDT-A10
 panel
Message-ID: <174042913116.4047506.14844482036971785905.robh@kernel.org>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
 <20250224-initial_display-v1-1-5ccbbf613543@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-initial_display-v1-1-5ccbbf613543@gocontroll.com>


On Mon, 24 Feb 2025 14:50:51 +0100, Maud Spierings wrote:
> add a compatible string for the BOE AV101HDT-A10 10.1" LVDS panel
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


