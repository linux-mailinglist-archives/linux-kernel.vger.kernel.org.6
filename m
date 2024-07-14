Return-Path: <linux-kernel+bounces-251819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA00930A3C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0078E1C2098F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF66136643;
	Sun, 14 Jul 2024 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="US/MZIPD"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8AE12BE9F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964439; cv=none; b=qOCLlWGK5MR1pxyDnZN8tLfAzPzwgirGgDCDLNj5splBAXkRiJp8leQBeqqwLpmsgxCiZx+3dTR5FQtrI6je3Lme7CskPvV3A7HZ0Od/0kEQcMU77bOs1/GLc3AvdNmbYNjkzkhqOFieB/AH3TFkkvjOkN3TxTF6Srf2RptwKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964439; c=relaxed/simple;
	bh=/UVFJ+9Ng2A0/YrC97CHhsFKHBGp9+uoljFecunxOps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvmlU2YX6ybm+2VuHHM/xvjKvl5JfjgbTwpj34QPdmr4+lavAMgI+p8bDU0qo/f6+mRBhZUCVtYvVWQfyVuHoy0wdVSx7oKSYR6GWnyOPUUE0YTkJdtrnvdItg8xGCEMUrsBX5N1s9RpXK1NfaegGRxE0QRX9r4zJshdlDLoj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=US/MZIPD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367a9ab4d81so2109266f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720964436; x=1721569236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHCkpVrGiuwJHDK5B9V2HOh2UvIkhWtlNv2XYBebC+I=;
        b=US/MZIPDpr7QaqEC/h5XVKomlme/29pmTLAKECicpQ3bYt7iVv8SJiXkjfqUpy+Qa4
         aDbw4qyB36LLtmZja8fxhauKlsDyDl3biaF9O3dUxQ0rypGF7BS1lAQPsjMFcXA5MRxf
         c4Fzh4MTHPtL038zU5oz94ibvxi+tT4nrOQ4h6YxYI8ZxZf2Uj+45nkJ8livBU0tBrEr
         CRYMx4DsxV+qzutJ+9Mmof+fZu9PXfNrGyQ4IbuP7MgZ/0roIXrFWdCXLF/jriFJaizV
         pz6zJpL/np0ichwGb5r2eLl5ePiUF0dLYLqOL/HNVmg47fc8POli6ZYe1OOACCAHHiGh
         VfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964436; x=1721569236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHCkpVrGiuwJHDK5B9V2HOh2UvIkhWtlNv2XYBebC+I=;
        b=O4eSxaRgSsExBcK99CaWuNBJ+C6aIlILM9d2nc+90kuK09ImDjj08b51LJ+cJndur8
         9Z46QcU+IAXzuQTfQSqCzvQ7AYpbf8touEPit1RpcRIW3YQFPM8dfhjAgzXaQOiVBUlC
         /bn/czVYad0wd1FbC4pAs1bRCH/ylpDP/bvQhC16cFmehTL1fMV3MSv3FHVgFG3H8rF5
         gvuDp/dXMHhr5ogCIM2kZ57A/2VYEJroxuRepqbDV+N0Ok/xoVt2xdGSL8vaKAb9Isq/
         jV73JWAX22TfSxNhgNcpGsgpkhL71wag1vKls9NWAcDBgpJyZMNyaVJ32J2/sAUuRsFf
         DWxA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Z1wzY+VcTuRnItG6SnYdpLe8+ajpviy1HlR45rcd51gWCFm3WD/65DJwK9TvY9aUhio5+JHYhrsUclRjoelry1+ByjlGUCXr4z2z
X-Gm-Message-State: AOJu0YyaP6IkIENgvlvtEEFZjvlf0M61UjppYIGBegVxiXJevXud6t/a
	jh/tqTE6ivc/FIXnq/RWAfU8oe5L/V8dg+bhuqGjjvZRsSdQuAVi47aB9la+4RA=
X-Google-Smtp-Source: AGHT+IG2FWtxmNntzTRnuVjsQhB6lgvSzDm6GV6lUFGg/HNmord4I1j0Qfrfs1hitHR86DUGQap1Yw==
X-Received: by 2002:a05:6000:1b01:b0:367:4e1a:240e with SMTP id ffacd0b85a97d-367ceaca8ebmr11048041f8f.50.1720964436495;
        Sun, 14 Jul 2024 06:40:36 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbea9sm3871306f8f.82.2024.07.14.06.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:40:36 -0700 (PDT)
Message-ID: <22700212-b3bf-4bee-ab5c-1c8b629260f7@tuxon.dev>
Date: Sun, 14 Jul 2024 16:40:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/27] dt-bindings: clocks: atmel,at91sam9x5-sckc
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102714.195661-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703102714.195661-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Varshini,

In my comment from v4 I meant to say:

dt-bindings: clk: at91: add sam9x7 -> dt-bindings: clocks: at91sam9x5-sckc:
add sam9x7

Suggestion was:
s/dt-bindings: clk: at91/dt-bindings: clocks: at91sam9x5-sckc

Anyway, I'll adjust it when applying. No need to resent just for this.

On 03.07.2024 13:27, Varshini Rajendran wrote:
> Add bindings for SAM9X7's slow clock controller.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Other than the title:

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
> Changes in v5:
> - Changed subject according to suggestion.
> - Alphanumerically sorted entries.
> - Updated Acked-by tag.
> ---
>  .../devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
> index 7be29877e6d2..c2283cd07f05 100644
> --- a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
> +++ b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
> @@ -18,7 +18,9 @@ properties:
>            - atmel,sama5d4-sckc
>            - microchip,sam9x60-sckc
>        - items:
> -          - const: microchip,sama7g5-sckc
> +          - enum:
> +              - microchip,sam9x7-sckc
> +              - microchip,sama7g5-sckc
>            - const: microchip,sam9x60-sckc
>  
>    reg:

