Return-Path: <linux-kernel+bounces-363332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5727899C0CF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138F52836C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44D7146D45;
	Mon, 14 Oct 2024 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1n09hrq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2017A143890;
	Mon, 14 Oct 2024 07:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889851; cv=none; b=cq+x/aLv0pHHTSd51xZahUTXsulKdWL5/uEE8bpXRADdqotNxJ5TeU4NVaC9SIxPzbbaoXhkGnTbH2fOkzEtViC8YemCwMrkq9cCgUBRWp58h6pDhlUVncKa8iqX4tQfJ5dSx5uHfMcvqtVAS0pJ4ROgavs41dHZsspMhkhVH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889851; c=relaxed/simple;
	bh=FJBw7ZIUo2NEVgH4S4KSccbKhXWxyCD67qRXO3xAU7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRqytyihPEFV6Xtracwybx63bXGlxIuJFE/qCVNNnaHmpRBoEP0Zw/NcJu4hpufgL7H3hKuIEzgYWVGnxWAPoYCzS/ecKlmbDbsTw5+xeZzmzF+GQUaiVhodv9qfGBANFg1Hs2Xjr53dOZZsPl0y7Um90GvTKAWcsrcOcGCVGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1n09hrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F02C4CECE;
	Mon, 14 Oct 2024 07:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728889850;
	bh=FJBw7ZIUo2NEVgH4S4KSccbKhXWxyCD67qRXO3xAU7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1n09hrqqJiEuQhiatvDTOrzixrB9dCraf3ef+ILClbjfwsBa6VfGe+EG59mVBDdm
	 m8kF4J8tbv/p02MdqGLvsm9EfacOjWMhuL4KQ1AymCZVlZ9lHLqiJYclF0BVtFWVqv
	 qwGCzTo3lCxroZ6YAHm1UhwZv3r41fkn+sHopuDAY806I26FW0uniT9oY/ZERb9PP6
	 YYwq/D1UZ280sV54pLedGqD18xCICokr+2/8nGrgxWaWTkXvPNyaBP/BAntXEZK0zW
	 nzjpg5EQ0J0jSTo33Nk5/shKkvPCqBGhBXJnpJzgP56+QaZWARGN/ruYQXiXJ6MmiO
	 XVhJPXBY3xMtQ==
Date: Mon, 14 Oct 2024 09:10:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wenbin Mei <wenbin.mei@mediatek.com>, 
	Frank Wunderlich <frank-w@public-files.de>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, daniel@makrotopia.org, john@phrozen.org, eladwf@gmail.com, 
	ansuelsmth@gmail.com
Subject: Re: [PATCH v4 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
Message-ID: <l4t7pgiuvnqb4dcpr6w7mmjkb2mvu5x3fdmid7txoi2gl6vv4h@75roixcfbamz>
References: <20241012143826.7690-1-linux@fw-web.de>
 <20241012143826.7690-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241012143826.7690-2-linux@fw-web.de>

On Sat, Oct 12, 2024 at 04:38:22PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add binding definitions for mmc on MT7988 SoC.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v4:
> - drop minitems because of errors
> v3:
> - fixed minItems on clock-names too
> v2:
> - fixed minItems to 4
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


