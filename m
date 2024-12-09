Return-Path: <linux-kernel+bounces-436908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746319E8C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E0E188649A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB3A21507D;
	Mon,  9 Dec 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsBCo1Vu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E037A215060;
	Mon,  9 Dec 2024 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730126; cv=none; b=jrwh4aTDNmYJSkYLGvz5foqsemeQRfzR3GRk1yjLZctbRerkBmcgy91HTCopwo42TBDtI/SMG9dtzx0lCn0/TUaYoe2t0tXhenzdXrk63fdMV/QiKJh01Lgy09UybhYUTx/qXhDdW6JJfypXs0QJqGyLcteE2X0A1fx9n7FDHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730126; c=relaxed/simple;
	bh=iXDqLuzxLZKBI8aoHt6mcXjhjBAUdKfhlnHvvviHoMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxG6B/BMCBbhINqqc5gyCxOb5emVShnam+Ub2i38wuWWYQMgyIGKS6TVofWQN8N9Jpwv4yu1i5LrmlYSgFQrA17QcvMgT9fnH0NbpbT+fgKJo1rrF8ZC+HEClWxZxgsBFzfKpfIfjTwyhB8cdvdVtoNPZ64OAiI8o6ZyyHx6FWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsBCo1Vu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40FFC4CED1;
	Mon,  9 Dec 2024 07:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733730125;
	bh=iXDqLuzxLZKBI8aoHt6mcXjhjBAUdKfhlnHvvviHoMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GsBCo1VuY3xVO6bn2VZVSkTjt9jLXpByR4Y6LEzN/Tpb3RJnl5Hu+64YUYFlnx4LH
	 xapVtQWJGQE1cf5d5jIQKHE5/4MZ4IhM7AdyByGk5A0TP8BAejBaXgTMPxq17lkTyx
	 qq0K7Tse3yot1UbEsfP6mb8QmDmBVV4t2SxCTOHHxaZAkD3MBgwHU+QyLsdpV62jEK
	 ZwpkbeBEgS9DnFDwa5yfImwROByK/zE30UDxD1doaYey0CDJoedwRH57HxtOcVPvHe
	 lv/X1rhrmznuTy2yB6JJRju3Jktp1AqS5jopYUyWrydCLrvHDTCodnujDRt/CUcJSh
	 XmmSCL0H4K5BQ==
Date: Mon, 9 Dec 2024 08:42:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrej Picej <andrej.picej@norik.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, marex@denx.de, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
Subject: Re: [PATCH v4 1/3] dt-bindings: drm/bridge: ti-sn65dsi83: Add
 properties for ti,lvds-vod-swing
Message-ID: <lbbayope3b6nkzfflgb2fbgakxpx7uewcslw7mynn5gki6vlxp@4amjbijjcrnt>
References: <20241205134021.2592013-1-andrej.picej@norik.com>
 <20241205134021.2592013-2-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205134021.2592013-2-andrej.picej@norik.com>

On Thu, Dec 05, 2024 at 02:40:19PM +0100, Andrej Picej wrote:
> Add properties which can be used to specify LVDS differential output
> voltage. Since this also depends on near-end signal termination also
> include property which sets this. LVDS differential output voltage is
> specified with an array (min, max), which should match the one from
> connected device.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


