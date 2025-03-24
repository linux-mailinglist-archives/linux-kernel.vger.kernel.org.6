Return-Path: <linux-kernel+bounces-573459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE5EA6D794
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761B93A7D66
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669E25D913;
	Mon, 24 Mar 2025 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IepI6eE/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5781953A2;
	Mon, 24 Mar 2025 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808999; cv=none; b=ej9lrVKjEg+MYsDQ4+labJ51IOfPGzfPxFbuSj3L+8fGQa/+X2xBAgMHcwrG8EQJvOUZFz3ck7n+WQGTEaQl6kAteTIFx/6P5rBM44TcMlycLYFfGP6BVo2F8u7X4/Nsu30kGPSuF1rS1fYlCg2RiLgU33GxRZIrkGnXPKhK2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808999; c=relaxed/simple;
	bh=PJzZLmVcfVBTyYixEnKzvpzn4eT4hlh6iQAK6VQBE3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5byzwCF6OckAWtOYeqmo3UqkHWGYs2c9+PM1G19GCplVuF+wQC9Qli/V0EUNB9pB80M4oNT53XyhuNFGD18gCzL6+BOLSum4aXz7BjiTO385XtdK5+GwF7tp3f/3pdGrKQg0YC+S3I5JNf+8w731OoUHUfVSc6ervn4CXJvC3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IepI6eE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F010DC4CEDD;
	Mon, 24 Mar 2025 09:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742808998;
	bh=PJzZLmVcfVBTyYixEnKzvpzn4eT4hlh6iQAK6VQBE3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IepI6eE/HrjMOv4BkqvK3/BA94amIdm+TWEoIBz/29IkPA7bNK6NAJaZW0AqnHDPv
	 E4DZfUi67CT3+W30Fcdi9b8cf/GuDyljgLmaUgAubP4QHh9eUAf2nXn4oru0jIgW5i
	 bup58hM18Mwfzcuh12bXP3ZdJClglMQfD7Dm7Vv3r85ViIUfbrhwbhyNT3Byc93tPm
	 Dpzw445pZKzm6AH9RlR3Tr3EVOuxOzOI1GWpmz6G0ATNakDTlSfft7dJnTrCK07M/O
	 VuWaiy9WlSgfakHBSZxq/uiDCRo7p02Ro261R8eadCg59G/JbtXuKYKMmF4nyhtxRd
	 i0VFiGWVlB8hg==
Date: Mon, 24 Mar 2025 10:36:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "paul-pl.chen" <paul-pl.chen@mediatek.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	chunkuang.hu@kernel.org, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	p.zabel@pengutronix.de, jason-jh.lin@mediatek.com, nancy.lin@mediatek.com, 
	singo.chang@mediatek.com, xiandong.wang@mediatek.com, sirius.wang@mediatek.com, 
	sunny.shen@mediatek.com, fshao@chromium.org, treapking@chromium.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 04/15] dt-bindings: display: mediatek: add BLENDER
 yaml for MT8196
Message-ID: <20250324-vigilant-vagabond-earthworm-b4e2c9@krzk-bin>
References: <20250321093435.94835-1-paul-pl.chen@mediatek.com>
 <20250321093435.94835-5-paul-pl.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321093435.94835-5-paul-pl.chen@mediatek.com>

On Fri, Mar 21, 2025 at 05:33:33PM +0800, paul-pl.chen wrote:
> +additionalProperties: false
> +
> +examples:
> +  - |
> +

Why did you add here blank line? Random changes happening...

> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        disp_ovl0_blender0: blender@328d0000 {
> +            compatible = "mediatek,mt8196-blender";
> +            reg = <0 0x328d0000 0 0x1000>;
> +            clocks = <&ovlsys_config_clk 29>;

With fixed code:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


