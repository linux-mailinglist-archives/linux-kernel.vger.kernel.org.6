Return-Path: <linux-kernel+bounces-363338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5187599C0E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812381C23790
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D85B1465B3;
	Mon, 14 Oct 2024 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtwniOL0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF42B2DA;
	Mon, 14 Oct 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890062; cv=none; b=nNE8KO3lbNSXy5pmhbVkmgf6bfcPjyKj/grZlpRit85q9FKIPJwR1hrHrIVwv9zC/ysnq42tUaLm8QFyll/HyCjPM/jv5Y7iH6LygOuX5NaPXTWZKn8t2i2DSttHBV8KG1M/SqldQ6QhJtTv99iLfgBUcoNyxNmIfBf2TEpVvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890062; c=relaxed/simple;
	bh=dX2gYGAyAH0L9uSffl8AQXYQwhZkX3NRmm3cjU2gkkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCCG43J18oGYWgU/TwQkNpLe/Evl5XsFDf1JSrVfSBiFBhhq3pUEzhewQ96WMP7fKpbqmKFObyj2sgZHtVKmf3Qd1SO3D3pH8XB2+4cmhpnv5lUrCLTZMEEDGVDCO0ZGncVtEVH+/8eAZcYuryJVBOpyr685MUWOHAoCVuaoS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtwniOL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AFFC4CED0;
	Mon, 14 Oct 2024 07:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728890062;
	bh=dX2gYGAyAH0L9uSffl8AQXYQwhZkX3NRmm3cjU2gkkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qtwniOL07HzUOp6RdhplycrVnepfforCAKmxtWq45162oV27o0XwpsSav0/5P7SaF
	 9YdzVg8MnXzTKnFejZQ9y9SLG9Ii2MIuQ9TUh8h34qEqljwSsKU/+Y3ZEQSP400Jyv
	 hGCvr6CZ0zTY07H+f9RWPYHp59aL4XFKdpykELOjNflapH4jcviQpbZ7D8CI2tQsd5
	 ZjFcyJOdqC20lsdsaXWs88A2/UbLdwja64APsPh8II1CIZhj6vR02kMO7oC8w3bygf
	 IXGMhBJnUmzLOpY4HSHm/o1VYFGQ9jbvfCDXKJCbaTg9arNq3uVpZnBt14dpNNf6bs
	 i/yoFJj95hvMw==
Date: Mon, 14 Oct 2024 09:14:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	Iuliana Prodan <iuliana.prodan@nxp.com>, Tushar Khandelwal <Tushar.Khandelwal@arm.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Frank Li <Frank.li@nxp.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/6] dt-bindings: dsp: fsl,dsp: fix power domain count
Message-ID: <xx7n7gubb376mreajyux2kzjj56cg3kkokb54pssqexi7b6rlu@4kcgl4gb2wr3>
References: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
 <20241011150439.4027-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011150439.4027-2-laurentiumihalcea111@gmail.com>

On Fri, Oct 11, 2024 at 11:04:34AM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Per the current binding, QM/QXP DSPs are supposed to have 4
> power domains, while the rest just 1. For QM/QXP, the 4 power
> domains are: DSP, DSP_RAM, MU13A, MU13B.
> 
> First off, drop MU13A from the count as its already attached
> to lsio_mu13. This decreases the count to 3.
> 
> Secondly, drop DSP and DSP_RAM from the count for QXP. These
> are already attached to the DSP's LPCGs.
> 
> Thirdly, a new power domain is required for DSP-SCU communication
> (MU2A). With this in mind, the number of required power domains
> for QXP is 2 (MU2A, MU13B), while for QM it's 4 (MU13B, DSP,
> DSP_RAM, MU2A).
> 
> Update the fsl,dsp binding to reflect all of this information.
> Since the arm,mhuv2 binding has an example node using the
> fsl,imx8qxp-dsp compatible, remove two of the extra PDs to
> align with the required power domain count.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


