Return-Path: <linux-kernel+bounces-570886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00755A6B5CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05D6188FF3E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359C81EF08A;
	Fri, 21 Mar 2025 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF2mgQ8J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7971EBFE3;
	Fri, 21 Mar 2025 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544649; cv=none; b=lADAR4eAGBFK+AFMUJ2bxvIH6ru6rxrW6SlI8krq+gpAi0tSHOEXh3sg2hzNvvASawwc0pXGScORoweM+7vArxEcE4Kkq8rDDMhXtcTjtycxT6LOsnpAEX9kwnSXd1qgTBOYnLZF4/4JXpAJA6Qd8aQJU+j6KahPolHMDdaqX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544649; c=relaxed/simple;
	bh=+rfm0VgNi58UlS6Mr9jdwghnEVpDGqTsgyDvBE7vOrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADCIHG1KoGjFi/jTKjUmhAZ+DIzHNT5Xmz5Cgx+FOudVYf4zp51CVK4ILaBEsTM8chtjbPBTwmnRk/BMrFhDd25v8iLQP6zWXCPeebe7baj2VwT8x5msWQsU9q8e7aKn1ykhChnoMdYmVnL5WCxAOs/RFYPCcH0fk0Ioe83bw6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF2mgQ8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077CCC4CEE3;
	Fri, 21 Mar 2025 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742544648;
	bh=+rfm0VgNi58UlS6Mr9jdwghnEVpDGqTsgyDvBE7vOrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YF2mgQ8JjPnKzwus08IDSkCkivQKkXgZE6e+3yN1hLybBSFtVGiIWMlGQQcbZLzbv
	 ZQuUxLQ65euXlF7MdP7Q1iPsc8Ez0c8XdhHWdu73kj1Pkpd2PTYSIGlJnTu+8yVzo+
	 3NevVzi8mWz7j7XWEJ382MBTpt83nTTuPSEYAxEVusWz8i4cWoddYWOlmszThmjciU
	 QIvgV2tVJ0tx4YeZ85yMyIYWm/wUsrKlQ2fclkP+lVXZYsIE289NlSw33RUZGRJ1mX
	 Gg4qoMgIgmXF/4LHaZhPEMzRWtgV0XyCm4tM0O8GKDpX6uzDyy4wt5ts9pqkF6ZNOY
	 znmnTomGgFDDg==
Date: Fri, 21 Mar 2025 09:10:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matt Coster <matt.coster@imgtec.com>
Cc: Frank Binns <frank.binns@imgtec.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Alessio Belle <alessio.belle@imgtec.com>, 
	Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: Re: [PATCH v4 02/18] dt-bindings: gpu: img: Add BXS-4-64 devicetree
 bindings
Message-ID: <20250321-liberal-muskox-of-reputation-edd6c0@krzk-bin>
References: <20250320-sets-bxs-4-64-patch-v1-v4-0-d987cf4ca439@imgtec.com>
 <20250320-sets-bxs-4-64-patch-v1-v4-2-d987cf4ca439@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320-sets-bxs-4-64-patch-v1-v4-2-d987cf4ca439@imgtec.com>

On Thu, Mar 20, 2025 at 11:32:12AM +0000, Matt Coster wrote:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: img,img-bxs-4-64
> +    then:
> +      properties:
> +        power-domains:
> +          minItems: 2
> +        power-domain-names:
> +          minItems: 2
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:

Instead: enum

> +              - const: ti,am62-gpu
> +              - const: ti,j721s2-gpu

Best regards,
Krzysztof


