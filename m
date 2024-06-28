Return-Path: <linux-kernel+bounces-233560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B84191B97C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DF81C2275E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E5A145B31;
	Fri, 28 Jun 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUzWbMw8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4499145324;
	Fri, 28 Jun 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562169; cv=none; b=OmHG29S05uR3pGaO/5fjthZKI/f/1WhXFQyMtei+Zw/xpCyxbeFLnaudgFWYz4sTebhWAccdrOYbfdyOBxFkHJH9MBUBIgHVbTqBlpb4nB9tJvbSK3V8VNXDtRZ8gG+GZEx/aS/IdM3Biiv/m3xe9nTEOntgljKQw+3XTdplEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562169; c=relaxed/simple;
	bh=5vS/mMQZC3JkKaiRFF3Tn7JqbobZpJj4qZogBGJ1g0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzgI4dQ8BUojHr5NiBNXjRd476SgyfaiiXZ4BeAIzndTK6TomUFbMeuH1C/dXoobXSfeVZophRd5l8jbfr4uiIpUbcgaEC61xiY+p+8Ug2ZoXoTuxopZ9D5ISTrJ0z5QRZyrVZxuQvNNo7t5AanGp3mjq2zdjoAbyGOtoI9ZIl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUzWbMw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D4BC116B1;
	Fri, 28 Jun 2024 08:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719562169;
	bh=5vS/mMQZC3JkKaiRFF3Tn7JqbobZpJj4qZogBGJ1g0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUzWbMw8WXSUjoMwXoAmfSYVcTPs4dvXkGY0zIfB3h/UumICz5p/1ZQogGrDyKVCB
	 ItQ4KLZhoO3B2gNiW4Q6MAbYDxrk8RuWUDb9/2ohjfVTYmZhTRDwaqRXDrgWQY0prW
	 TFV4JUwOiKEfC7xAJMvHZ16AobS0OL+BjMExnqRTqkrBGMwGwEVm+sBa3Gtx7NKSgs
	 NaSQXtA10RVWoop5i3sRU8O8wRBmbgnommiR/NIlL2dpVUHE1eKLc1+U2mYIrg6+Ja
	 exYrNdG9EjP15T15D/EqepqVyGMfBRUxCd50UT749YJoJwVBMxqpZ3D0U1qkI+SYDY
	 dEbqIopsgkvoA==
Date: Fri, 28 Jun 2024 09:09:21 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Rahul Tanwar <rtanwar@maxlinear.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Nishanth Menon <nm@ti.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rahul Tanwar <rahul.tanwar@linux.intel.com>,
	Amireddy Mallikarjuna reddy <mallikarjunax.reddy@intel.com>,
	"Zhu, Yi Xin" <Yixin.zhu@intel.com>,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v3 0/7] dt-bindings: mfd: syscon: Document more
 compatibles and require simpe-mfd description
Message-ID: <20240628080921.GK2532839@google.com>
References: <20240626-dt-bindings-mfd-syscon-split-v3-0-3409903bb99b@linaro.org>
 <20240627081853.GF2532839@google.com>
 <58d1e88c-b2cd-49c7-b250-84104e82ed67@linaro.org>
 <8a30fc06-4152-4489-b991-184c8e816254@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a30fc06-4152-4489-b991-184c8e816254@linaro.org>

On Thu, 27 Jun 2024, Krzysztof Kozlowski wrote:

> On 27/06/2024 12:24, Krzysztof Kozlowski wrote:
> >>>  .../devicetree/bindings/mfd/syscon-common.yaml     |  71 +++++
> >>>  Documentation/devicetree/bindings/mfd/syscon.yaml  | 306 ++++++++++++---------
> >>>  .../bindings/soc/intel/intel,lgm-syscon.yaml       |  57 ++++
> >>>  .../soc/microchip/microchip,sparx5-cpu-syscon.yaml |  49 ++++
> >>>  .../bindings/soc/sprd/sprd,sc9863a-glbregs.yaml    |  55 ++++
> >>>  .../bindings/soc/ti/ti,am654-serdes-ctrl.yaml      |  42 +++
> >>>  6 files changed, 457 insertions(+), 123 deletions(-)
> >>> ---
> >>> base-commit: 8dc7c29f608649f3d9eca826e9d4fe4b8a32c472
> >>> change-id: 20240517-dt-bindings-mfd-syscon-split-37e23996523d
> >>
> >> Okay, I tried to apply these whilst fixing up all the conflicts, but
> >> lost the will to live.  Please rebase and [RESEND].
> > 
> > This was based on your for-next 8dc7c29f608649f3d9ec "mfd: lm3533: Move
> > to new GPIO descriptor-based APIs". I'll rebase.
> 
> Ah, I see now in your tree Bryan's "dt-bindings: mfd: syscon: Add TI's
> opp table compatible" which will conflict in tricky way.

Thanks for rebasing, I'll get to it at some point today.

-- 
Lee Jones [李琼斯]

