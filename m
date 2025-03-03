Return-Path: <linux-kernel+bounces-545093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A12A4E8FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F0E19C1320
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E712836BC;
	Tue,  4 Mar 2025 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o58TizPz"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57892836B7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107722; cv=pass; b=Iji+5mvbfo/RrUn/l0RXHvfd6Xi3gEvyy2o2+9G1BAn9J2kxx18hQWZYyR8Wd4aT4FQDD3f5X9O7lj798w2Ced9Vv8IEYNi7gmuFN6Rtyg9+LJ0Of9pmKAmMIfOENOXTXaxkrVH+dAEktJIXPfNvzJNfN/029Yxf7PLdTEBToT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107722; c=relaxed/simple;
	bh=PiRoSmACwYfEYA3h6HovgqIoBLv0oqC8cx0YgXVH0/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWJeyT57m0ELWUaSD60MzIWDUG2uDY0IStgWNwIW491EZkXPT0eT/f0zrfI9+bf/t6KwlkjK0wW0EIGQGwwOjx5g/bQwpoPbPHoWSz/F/K7Y1LZmcdVGcSwyjYHInNbNXBi30KTe3NCDr6rJ3T6jYVO9NDXBY3C13K2V3DlFSgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o58TizPz; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 1803040CECBA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:01:59 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o58TizPz
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g1y5zVgzG0s1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:43:18 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6B9E342722; Tue,  4 Mar 2025 18:43:10 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o58TizPz
X-Envelope-From: <linux-kernel+bounces-541827-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o58TizPz
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 8C8FA4014D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:36:14 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 42393305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:36:14 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157F2167CAC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11F1213240;
	Mon,  3 Mar 2025 13:35:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B631E86E;
	Mon,  3 Mar 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008943; cv=none; b=qLl78/ffx83XakKpQN4WQQSgxRYp0+MHCaXuIbQgTFxm5INU+bu0D6H8fdLFlD2cfbnxZA5YQd9DfjFn58yukSOq6YBYZ+gUN4EWrISe5th8JlC08Kr1WPw2srJdN96N0esECcaW1vozrv9BxrqfxsQh/9xQQvJIIZQN5QT2wK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008943; c=relaxed/simple;
	bh=PiRoSmACwYfEYA3h6HovgqIoBLv0oqC8cx0YgXVH0/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6OL0hrIUZlh5gm0RdGj/lFDDwTANUxwLaPT5MUQkw3dSRYYyZmrKO2vFqLrCXX/sbpHQdla375hoVRjRGvh2hkdswOHdnkxsEq1QS6FzWyc81Q/XuOoKItSxaDhy/YSdml2Q85nde+OCSVt/p/wLEG/g1RsVPolX84LEIhXMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o58TizPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64513C4CED6;
	Mon,  3 Mar 2025 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741008942;
	bh=PiRoSmACwYfEYA3h6HovgqIoBLv0oqC8cx0YgXVH0/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o58TizPz8YP3NjSU/HW3uwAI1fbZfROCeXfvdYjtfvLKVbkvU6L7JzzfYKFs96BwI
	 UUJ1eiM6U5+xYG7qRu3eY9fAGuTc9WjCoUb0/jau6ehqjqk3VBaLV4e/pbt5ovMHUh
	 940d8tjKWh+LUv5Bw2zUEop4q5w/FjihlyaWPNC6lYV/8m58iKYWR+BiaT3sclGYDi
	 jMiwR65OkLm6D1cPQtVX9UfawN38g41tM/SFx0aBZis73Mx7YsXWzYBZKGXFcsJmeZ
	 DqD49kVtiFy3XBA4Qma0w3RqddrjR6QSzfoJVLpAfEFRdJTUOdg/YrUPFtIaIR02aU
	 AjxXnYaB+8IKQ==
Date: Mon, 3 Mar 2025 07:35:40 -0600
From: Rob Herring <robh@kernel.org>
To: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Cc: thierry.bultel@linatsea.fr, linux-renesas-soc@vger.kernel.org,
	geert@linux-m68k.org, paul.barker.ct@bp.renesas.com,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 03/13] dt-bindings: serial: Add compatible for Renesas
 RZ/T2H SoC in sci
Message-ID: <20250303133540.GA1681980-robh@kernel.org>
References: <20250226130935.3029927-1-thierry.bultel.yh@bp.renesas.com>
 <20250226130935.3029927-4-thierry.bultel.yh@bp.renesas.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226130935.3029927-4-thierry.bultel.yh@bp.renesas.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g1y5zVgzG0s1
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712409.13988@7Qoj2eCWyDaPIelZ9V4QJw
X-ITU-MailScanner-SpamCheck: not spam

On Wed, Feb 26, 2025 at 02:09:22PM +0100, Thierry Bultel wrote:
> Document RZ/T2H (a.k.a r9a09g077) in SCI binding.
> 
> Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  .../bindings/serial/renesas,sci.yaml          | 64 ++++++++++++-------
>  1 file changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci.yaml b/Documentation/devicetree/bindings/serial/renesas,sci.yaml
> index 64d3db6e54e5..2c4080283963 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci.yaml
> @@ -9,9 +9,6 @@ title: Renesas Serial Communication Interface
>  maintainers:
>    - Geert Uytterhoeven <geert+renesas@glider.be>
>  
> -allOf:
> -  - $ref: serial.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -22,6 +19,8 @@ properties:
>                - renesas,r9a07g054-sci     # RZ/V2L
>            - const: renesas,sci            # generic SCI compatible UART
>  
> +      - const: renesas,r9a09g077-sci      # RZ/T2H
> +

Perhaps explain in the commit msg why the 'renesas,sci' is not 
applicable for this chip.

>        - items:
>            - const: renesas,sci            # generic SCI compatible UART
>  
> @@ -54,8 +53,6 @@ properties:
>          - fck # UART functional clock
>          - sck # optional external clock input
>  
> -  uart-has-rtscts: false
> -
>  required:
>    - compatible
>    - reg
> @@ -63,25 +60,44 @@ required:
>    - clocks
>    - clock-names
>  
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        enum:
> -          - renesas,r9a07g043-sci
> -          - renesas,r9a07g044-sci
> -          - renesas,r9a07g054-sci
> -then:
> -  properties:
> -    resets:
> -      maxItems: 1
> -
> -    power-domains:
> -      maxItems: 1
> -
> -  required:
> -    - resets
> -    - power-domains
> +allOf:
> +  - $ref: serial.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g077-sci
> +    then:
> +      properties:
> +        uart-has-rtscts: true

Drop. It is already allowed.

> +        power-domains:
> +          maxItems: 1
> +      required:
> +        - power-domains
> +
> +    else:
> +      properties:
> +        uart-has-rtscts: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a07g043-sci
> +              - renesas,r9a07g044-sci
> +              - renesas,r9a07g054-sci
> +    then:
> +      properties:
> +        resets:
> +          maxItems: 1
> +
> +        power-domains:
> +          maxItems: 1
> +
> +      required:
> +        - resets
> +        - power-domains
>  
>  unevaluatedProperties: false
>  
> -- 
> 2.43.0
> 


