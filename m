Return-Path: <linux-kernel+bounces-436480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC869E8687
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60CE163BA4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBE31714CA;
	Sun,  8 Dec 2024 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Qp1/DbZZ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2416EC19
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675666; cv=none; b=pEg3pmHEwvFega+brzK2d8IWMMbQgGHbX9cHO/n9Nd733SeuwmyGtQZPZ5a4M+Ol7turv7N4VUXoLuR3r699hqzOdA/lRieOHzkrxcNJ0m9IZ8+xiDpLme9LNdHKn//70LpJJ4+U9igo+febJ+W/zCjsJUdUKeUxlrscXwMEBOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675666; c=relaxed/simple;
	bh=sfwHUbpW8XDdoQtwvphDU/WFW5sPN+tjwHvMRp8wfok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xttci+8DnCk2G6HMBTEZVM5uNMvN5SSDgfqRzaE0BaAF6xDnVSviXJ6q4cK9w2xmVD5aZXpnDJRh72dPl4CsS9cHuN4yrWStu4SHiVmigko5QbsdjpVnmjN0UM+SeTeyew8g9lOwIYqDy+zWVjU1+NqcrAdr7XFImu+LO5LyW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Qp1/DbZZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so4437640a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 08:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733675662; x=1734280462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1iT4NSRVpd0erHt+8HYNhpTfhW4lFJNhq1fa73nwHoQ=;
        b=Qp1/DbZZx2NGqg7d8a+PsUD+4gr75eDQYBm/GAQqKy3W44kbIF5ZRsXDdpQwfWmapi
         J0j62l4c/cEZijGgoxTW1jXxIoxpBn1NKr1TSH9KAb1ynmMB1pU7j+U0kalioAX1lFA/
         xngEgTOiSVlQ/yByDnSqrEbZTmCNYyLilDculHjIVpDcPpaoOUTt7iGnUgknRI9jtyR+
         R0gqqBTY3927/kyVyRY1+H5lD2tMWJGVxsvtegnjeCWoQEQIsdEImYlKRF02seft2PcQ
         tM7US9+v1TPP/arR/+lxFpV7qxttnolxheb3JOpXPEQgNAT1Rtb+4Ut7l+2MCYCPJOWx
         qyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675662; x=1734280462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iT4NSRVpd0erHt+8HYNhpTfhW4lFJNhq1fa73nwHoQ=;
        b=gbCa6FhP73yrdTCmspTUAG1Z4wX+QZFg2fUkV/XxQEbi4MZ/jCRjiwePWpO1DCEcsX
         2fVRZe0sbZdV7JT/NVMy0+BwQmQU84yBvqTUzVPf6qMEli6whQHlOMr3Gw21HT8qF0ID
         zKljsW+/stptG736uhtlRTW9jV7TyU6sDmit6Rb3JVJDW1Tz4vI+HDKRIFe2tWeuqKbI
         G/a/Ui5RIGnCRnQ07m2OKci1/V6q/fpYjcvtuArX73/iyzi+R8mmdDDfdLT6H/WJ5VKD
         Tm+AZOLibA8kJ5bjRxiX1E9WOKqb10/VEaoMDoHVqrmXmTG1Dr0hPn8YeK/vGMyegr08
         1kVA==
X-Forwarded-Encrypted: i=1; AJvYcCXFyrkmp1HSc3RkTWP+BlutGgHctP01R2U0aJZrxn6mWuFcE8VEyFvr2i5acHB2AQ3kHbhHtIKaH+CzCJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOAxYANcaOBq5SHho2TSJsaeTIy63/fhZu77oPhXzUrvsewwsL
	Z2Ca8O+XtSww9oKpd5y7lQ+PQD0bOJUT5h+8UEiqOKLq3mDYIxTjRvyavxlmHLE=
X-Gm-Gg: ASbGncuyxicM67Kp7cdugf1oVEdNuTrSu+VJ/re5bhAKMtnTS/9tdddlVAKd4frksB9
	osZHZFgngyEo8DGi2caF9rbKMJzp5ZNMz/G7GKsNkDMEyC5xmjRAwShAFaFXmtucTi+6IYXmRZS
	+rN2z0Gr09zaXuXhbgiAd3L7u+xz4pEjRgYkBisP0NWG5UurtZP4+J/aEK7fMroSEBgNQYajyzK
	ZcrQE53CKdWyJ60Lr3ov2pF4xb0lhGU8IIAsB1b0bSEFbDFH1DVlE6/0VE=
X-Google-Smtp-Source: AGHT+IHiWExZ8bPK4wGroZLlYPeAABfeeYHqCY2Pc7mcSXStanDyIam/ppcbW7eqPB4JrD4ws75z6g==
X-Received: by 2002:a17:906:314e:b0:aa6:57aa:1fe9 with SMTP id a640c23a62f3a-aa657aa2b65mr521603366b.51.1733675662072;
        Sun, 08 Dec 2024 08:34:22 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67a4f8dc2sm113804466b.179.2024.12.08.08.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 08:34:21 -0800 (PST)
Message-ID: <30d2d8af-836c-440a-8b39-4131e8c85540@tuxon.dev>
Date: Sun, 8 Dec 2024 18:34:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] ARM: at91: add new SoC sama7d65
Content-Language: en-US
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <465960c9240553753e96a7f4ff3f48879ade7558.1733505542.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <465960c9240553753e96a7f4ff3f48879ade7558.1733505542.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.12.2024 21:59, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add new SoC from at91 family: sama7d65
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  arch/arm/mach-at91/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 344f5305f69a..2c7179b1baa0 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -58,6 +58,15 @@ config SOC_SAMA5D4
>  	help
>  	  Select this if you are using one of Microchip's SAMA5D4 family SoC.
>  
> +config SOC_SAMA7D65
> +        bool "SAMA7D65 family"
> +        depends on ARCH_MULTI_V7
> +        select HAVE_AT91_GENERATED_CLK
> +        select HAVE_AT91_SAM9X60_PLL
> +        select SOC_SAMA7
> +        help
> +         Select this if you are using one of Microchip's SAMA7D65 family SoC.
> +

Spaces ^

Other than this:
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>


>  config SOC_SAMA7G5
>  	bool "SAMA7G5 family"
>  	depends on ARCH_MULTI_V7

