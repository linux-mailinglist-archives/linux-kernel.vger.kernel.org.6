Return-Path: <linux-kernel+bounces-207777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095D1901BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863BD283112
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2BB225CE;
	Mon, 10 Jun 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SZGdlocX"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F522081
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004903; cv=none; b=gXj8/rgYo0GUIruF/S82NdokL5/ooz6YZnsHulp8LL/8jAX3KkOSHGEvkrGGD2r5eLIVknJQf+p5DItr47mtbpQUmWip86gMI9YqN0Mx0YF8LPcaxMUDXTFsGol2ghFpMbQDT/lqexZplPBmirNy4v+NQgcHBddcADRslXWq+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004903; c=relaxed/simple;
	bh=VliUnf1LC3h4+sX0On9wlPW+jzs8kc5Ixi7qA1fxruE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYO2dRg7q0ysCMpM57BZjWbhEaHrTlhwyhInCtWWS0o5vexWrlKEBUsvdVBdtzXIaaT0bbewch3TzOzJS80ayyCHo3n8XhSAAvfRErqXDIgKSf6Hxe9XLQ28Kxf2CLfahdVP7d36FhD5AKmEJnJQ4NoNPybnYUeWszTzXvKIt1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SZGdlocX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42108856c33so30056135e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 00:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718004900; x=1718609700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFHT2mQiPwOe9xw3h0sZO/aY5iVIcTCAjYd6ForW6is=;
        b=SZGdlocXOyAdK2HcpYRFrMYm4yYA9qWXRKeg9eV29kin8DLKdNRCUg2TbmtqTpgQWh
         MVviTjHtxNm4vLdMJMvBM6f8HpiNmnZaX3/FFZrTP1IuUbBolrWrPLiD0t+iaRpaT166
         9oVNMkA3aF0jqUb4sVV7PFDYvdKLZ+ZLZHdLmQ/o+Ae+YBobHagbNrZFEoNqHAGzfLmh
         MwPEInBzECR0opH+kHCU3Wp9Fyz1pJ8H/ocDjwW98FjUohkAylP2cEE6zgWXB9U0nLYR
         k1lR5uXDE6tA3UBtyihzs/mjhFDNMkTUcu3NKUp9KTJofZNT8aA1m4P9wFzDc/liC79p
         hyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718004900; x=1718609700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFHT2mQiPwOe9xw3h0sZO/aY5iVIcTCAjYd6ForW6is=;
        b=eJ9pXpOJAVyVSXK4MLnzufX3vvZfomoPMtps8UvhF5OlVc03a6dreb4uKWHu2cEL0K
         loqRElvKqQ9i9XgKFYJt83LHJuV7WmGlquv1PNQ6s9M0gZK/HL8FU3T8UhEmu/tRiwpC
         pZqVuTAke98SQ1sCYb6HjccLp9ZwR4334TMkV4vQNGvPdxemuyqG0x795/9B3fi8h+sV
         A+jmw+8JOeTK0ach7GzV5l46/lU+dOK+u6ULn4tre5H1F9ew93HcDJU2s1QdT86K8+Dg
         j92dZZRU7t9/bdAFTlTovakVQrgb39Ue9uWLtpas10sJT9cxKID5VzsK7SEw9vHThAXh
         ucmg==
X-Gm-Message-State: AOJu0YzOnwq5wo/7DyLQUTMT+BWm1T7EvlrCC/BKfjUJurTZO4X+3yCD
	6xp6s1RC23ijaOeyyLoMX9r7jw1Lehaj4t1RqSXFJOjmP4DYld9LktSxOtGIuQE=
X-Google-Smtp-Source: AGHT+IEo2JAEM8YQ5ACMdMdsTOq64tAsPg+t0zg39oLXt7yTkzc7WSJbbN+KIU+lY9quNUXLDIHq/g==
X-Received: by 2002:a05:6000:178f:b0:35f:27dc:4d53 with SMTP id ffacd0b85a97d-35f27dc4dd5mr678509f8f.30.1718004900021;
        Mon, 10 Jun 2024 00:35:00 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158110dfesm168181575e9.19.2024.06.10.00.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 00:34:59 -0700 (PDT)
Message-ID: <acf4e381-86d6-4cb8-a672-fcb680147c23@tuxon.dev>
Date: Mon, 10 Jun 2024 10:34:58 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip: renesas-rzg2l: Reorder function calls in
 rzg2l_irqc_irq_disable()
Content-Language: en-US
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240606194813.676823-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240606194813.676823-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.06.2024 22:48, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The order of function calls in the disable operation should be the reverse
> of that in the enable operation. Thus, reorder the function calls to first
> disable the parent IRQ chip before disabling the TINT IRQ.
> 
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S

> ---
>  drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
> index 861a0e5a3e97..693ff285ca2c 100644
> --- a/drivers/irqchip/irq-renesas-rzg2l.c
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -271,8 +271,8 @@ static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
>  
>  static void rzg2l_irqc_irq_disable(struct irq_data *d)
>  {
> -	rzg2l_tint_irq_endisable(d, false);
>  	irq_chip_disable_parent(d);
> +	rzg2l_tint_irq_endisable(d, false);
>  }
>  
>  static void rzg2l_irqc_irq_enable(struct irq_data *d)

