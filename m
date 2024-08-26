Return-Path: <linux-kernel+bounces-302237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2570195FB78
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF38B1F232A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F3719D080;
	Mon, 26 Aug 2024 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="fH1JNZy4"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B9019D077;
	Mon, 26 Aug 2024 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706925; cv=none; b=JrdVFIcpjaLyJPsN3g98AlORjDf79rKLLyD0w/+tLgNtmbY6tTuMMkvu3lYy8mLfbY7Ygdi+KqcgN/VnE6Qy33YyEaeMUypQb9WL7/B9WeAkv1VthtXbspfBAWxy9W7htBiDDXUb4lcu1GmWZBiL8GgIqdSDCMaEA1OCNi+C+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706925; c=relaxed/simple;
	bh=mM6+g5wroDgkKb/noEhYUpj7fBvaFJFwKiGkv4Edx2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p631mQOEDoyQ49JrVDj+tKgG4cDhzSZWGv5TGLGtuePSGKT3GMZiFkpxQaOtKSP9ypJs0KmjYFrfhz52WyVF2KlOU4zLKgXkVCmVyIJflC7kBtqpFVaB2gvVYhyiKV2uMdonX57My1pkmbABuv7uMPnmgrQg6JLFX907dwK3pM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=fH1JNZy4; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=M4jMhQCM5evFj6f4LOutINFboj8l7YeZYYihUNfpax4=; b=fH1JNZy4NnPiIgZxkysudbtsp9
	gNfbH/BZzTzaxxqD+k0rMqLRMCj0udxkM4rYG6PEjgxdegRPpIUuph9GKG4QVLuQC8ORzGCJY6EAJ
	vYkiYJXnsb+Y3DA1WIDKUIYa1emKFN4AqQWewbmTDycXQkeU4tx8Ook6Ejz78DhAEb6I0Wrdowqkf
	m7Geeb5gyCKRB31tkJFLEiBOGJW4ofQfUogZD+T0J6G6T2Hvt8CPAGLaUil/IXOlut9ueuJy/ei0u
	xQ02apIYTZPAMiFIpXZ8EK4tME4c/9nBnzFTnzdgKSP8lnZ8Nf2Vv6DurOfTJOsiqgjmGQiLL+K1q
	FwuyhD4Q==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1sih37-005vDY-1v;
	Mon, 26 Aug 2024 23:14:53 +0200
Date: Mon, 26 Aug 2024 23:14:50 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dongjin Kim <tobetter@gmail.com>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: arm: rockchip: Correct vendor for
 Hardkernel ODROID-M1
Message-ID: <ZszwSswuKvZvX6S6@aurel32.net>
Mail-Followup-To: Jonas Karlman <jonas@kwiboo.se>,
	Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dongjin Kim <tobetter@gmail.com>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240826205538.1066103-1-jonas@kwiboo.se>
 <20240826205538.1066103-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826205538.1066103-2-jonas@kwiboo.se>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2024-08-26 20:55, Jonas Karlman wrote:
> The vendor prefix for Hardkernel ODROID-M1 is incorrectly listed as
> rockchip. Use the proper hardkernel vendor prefix for this board.
> 
> Fixes: 19cc53eb2ce6 ("dt-bindings: rockchip: Add Hardkernel ODROID-M1 board")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 1f23b8b05a8f..f08e9f2f5dfc 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -595,7 +595,7 @@ properties:
>  
>        - description: Hardkernel Odroid M1
>          items:
> -          - const: rockchip,rk3568-odroid-m1
> +          - const: hardkernel,rk3568-odroid-m1
>            - const: rockchip,rk3568
>  
>        - description: Hugsun X99 TV Box

Thanks for fixing that.

Reviewed: Aurelien Jarno <aurelien@aurel32.net>


-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

