Return-Path: <linux-kernel+bounces-363353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A38899C135
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2994280A03
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483A0148826;
	Mon, 14 Oct 2024 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDQISWmA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C6231CB3;
	Mon, 14 Oct 2024 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890651; cv=none; b=PkZgkrmWSntxxEfOxskCG6QQrAz/DH0kGT0SKmxC+SXydHM4/DLOdm77fG1mOu1cLvyS1v5CI7ot8VsIQMeARyju4kL0akH7BenfWNAOjVzBfdjV5c6hzdQ82bCxu2IeHUS74IAgf+g0hPg1ABnt4mZsjqUkFZN1hGMDKDQnjvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890651; c=relaxed/simple;
	bh=1X/AWdWy6XJyDSO7M/cdfaBQEjMbptSwkQxF6EyEVbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdrUiLLJ4eykJuOlp+IIjdtPX0gCTJusgh04haBz3Kc4k9b+dU76Q8dWtLm9dzYnJdT+yNRt9bT+7QaOkj8IVtmFS/YbccJYcpEYgjQS6kMjL8Bh/cihOcZLcJl2sgX1uMX69QQoYl0ii2pWjGz+x9RCOZjXBmxWK3KNt1n5WNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDQISWmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634EEC4CEC3;
	Mon, 14 Oct 2024 07:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728890651;
	bh=1X/AWdWy6XJyDSO7M/cdfaBQEjMbptSwkQxF6EyEVbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GDQISWmAdJ2QhJIV6et8L0aeC7GtZDidTob1al2lXnVGaLjAjRZaXVKt3CppjYhXS
	 q2hQmiCPk+1O4lqE1WlyCj0DS6qSgAXRb+1eOPtdFTSRia2ghEq9Fx1J2c6r/H5HDW
	 QfJCpfi0263dyj7KvIK9XhHza9m6jD5QCuqoKcrNlDBe5FAbgqWkMAJmouW6m9RF7F
	 QtsKAykI+wHXl6FqvuP4hCSfJ7v2hDC2z31Gi3wKlezg9NMfz/wpH7P4Ucxk2M+oDP
	 UXoakmVjM0TZ/91Ra7MOYu9oJ6zL2DQDFO3+dlQBNfmNWxuq/bA+nlXIkSFgANAzQc
	 a5h707NufGLKg==
Date: Mon, 14 Oct 2024 09:24:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Chris Morgan <macromorgan@hotmail.com>, 
	Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>, 
	Andy Yan <andyshrk@163.com>, Jagan Teki <jagan@edgeble.ai>, 
	Michael Riesch <michael.riesch@wolfvision.net>, Jimmy Hon <honyuenkwun@gmail.com>, Jing Luo <jing@jing.rocks>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] dt-bindings: arm: rockchip: Add Orange Pi 5b
Message-ID: <3khrvo5fhft6kagr33oamfo744iqdriaccd75m5le7lsk4n27k@6awyomnakwv3>
References: <20241013213305.310844-1-cenk.uluisik@googlemail.com>
 <20241013213305.310844-2-cenk.uluisik@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241013213305.310844-2-cenk.uluisik@googlemail.com>

On Sun, Oct 13, 2024 at 11:32:37PM +0200, Cenk Uluisik wrote:
> This commit adds the Xunlong Orange Pi 5b entry to the device tree
> bindings inside the Documentation folder. I know you said I
> should extend the Orange Pi 5 one with an enum, but I made a whole new
> entry, because looking at all the other entries, they also create new
> entries in a case "like this". I hope this is okay, or maybe I misunderstand something.
> Thank you in advance.

That's not suitable for commit msg. Explain the hardware.

And no, use an enum.


> 
> Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 687823e58c22..130f6ccc1658 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -1053,6 +1053,11 @@ properties:
>          items:
>            - const: xunlong,orangepi-5
>            - const: rockchip,rk3588s
> +      

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

Best regards,
Krzysztof


