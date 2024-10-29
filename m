Return-Path: <linux-kernel+bounces-386927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962249B49D0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFCBB21B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD85BE40;
	Tue, 29 Oct 2024 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UvLaKqzW"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867A220514E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205438; cv=none; b=pEYjZ/I05AQaIAJRIqEsaLTHCw2xG9KRVh+i4Gb4QEZMeuH7BBmuVWT1F4H8Sprsy51MkEEF9QpHdWSV7nQ3WaGVKeWAsjfkaYqWPf4qECfYGmEWufvNPqzsYUPHo6MBFmIDSt71wSGfdXsDGnjJn+mlC2x2KjrMJ92DOLC8/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205438; c=relaxed/simple;
	bh=FZupF2iD7kfxaR3KKKJqyQpVnPKYpKS8+01BJjHzlyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFlFO678ceNjcbqzWHyt4n/kBED1Hp2pUWra6JelVJxPXnllukwDeMFEGahlQCqD11o+MhX5MTF+q3n9/k0HrnEKETvvPvDwAZ3B5WPfZ3KZ+2+TcCXVkdcizSehxdYJPzp8Mqr/fcWP8Ejof6TZT6Aha1LMokFyw0sivTgjFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UvLaKqzW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d3ecad390so4665139f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730205435; x=1730810235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SKrUgSOUxnIh3q3e4Z2f0c72Gp6Ecggg0tzc6ohRH2M=;
        b=UvLaKqzWFxb5Ty323zmEiZnegJ8HOZdsBdgZKs5V+MaWY5SOUgj03MgGwaKRI1AOo2
         jsJsjcHUQWU6aoHYi+iUpjOeMhzj+C3z5HBqFwEgRIIyGaFv8pWYbx8soYglUWY/9QuQ
         eYV0cic4NxLcMZOe9bHnYDO2+vPPtvckPdryZyo01CY1pfTnZwQsWJ/ViwL3kZxNO83D
         mxRRBzoBopnV599t6vVMpc37dJMX+sgM0AoaWzSwddZ7JhD+kUz5K3vJ98UvM4PpExqX
         MQDrhZ3bOvAUtuRp4XnLeDHLm3zpVW9FEZZY/B1eVsJGhguO7mUBdM+9GjjFEo4Dvzi7
         Z/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730205435; x=1730810235;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKrUgSOUxnIh3q3e4Z2f0c72Gp6Ecggg0tzc6ohRH2M=;
        b=Yb88pqy/V3zlPW3YHrjapHmOwZUgSC9PcQ0cAUTg7UVq80bjToT8ZQQbAI1nL0sfsb
         F2fHCBcnzqPFTxlvtLmmypH8GSuBV3lybXJbEfAsW8nd/E9yl4HouaKVynMK9dmrNlzO
         DNQxZb0tF4d/njLHgzKZIaGQTGZgq1AnXm6N/D4ZK/CLjrdmPDY4JZ9loPSqptTNMwGb
         gxXWfVEBiBPCUfldlbL5weHlY5JBgAAgDXscORcSlA1vBWm3S+c+66fIoIP4JHBQxQvN
         ZQRAG0DOxw9eEpA5H75jNRILnTJU2W8ytjC8ipADoSQRSf7uybz/CP/nzxLMP/UhgDKY
         dvrA==
X-Forwarded-Encrypted: i=1; AJvYcCWr5zQoVhwTWh+NEtTD71BGCF5z2z9vKfODO/ZUb8NCwpH2gG6d4Id/6mH0BBOOA/06yGFmDDXFLjJq8PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjXAGiFq2RS0uOKNRq+1eI/7CjX1tvzEFMJ563zwYV94POvNRp
	ZWw/B07E+FBnx0ClrQvp9HXD5+g37HVbF/9/w5qbvMZNSMFPCZzZ14UKxcLSADA=
X-Google-Smtp-Source: AGHT+IFEbYVOveGst9KWA5oPzBLhzFiKooQTvMFPL4MtunAPaDwMDkZFYzsRBozZtnKTUn8MLA6f7Q==
X-Received: by 2002:adf:f844:0:b0:37d:3baa:9f34 with SMTP id ffacd0b85a97d-38173e61331mr1789406f8f.1.1730205434495;
        Tue, 29 Oct 2024 05:37:14 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70c73sm12585846f8f.72.2024.10.29.05.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 05:37:14 -0700 (PDT)
Message-ID: <1b5f9e16-4c82-4093-8950-12188b662c39@tuxon.dev>
Date: Tue, 29 Oct 2024 14:37:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] pinctrl: rzg2l: Fix releasing of IRQ and status
 reported in pinmux-pins
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241025114914.714597-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20241025114914.714597-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Prabhakar,

On 25.10.2024 14:49, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi All,
> 
> This patch series aims to fix the reporting of pin status in the
> `pinmux-pins` file and properly free up the IRQ line when using a GPIO
> pin as an interrupt via the `interrupts`/`interrupts-extended` property.

With this series, the Ethernet PHYs IRQs switch to poll mode after a
suspend to RAM cycle. I've added the logs here:
https://p.fr33tux.org/3e8193

Thank you,
Claudiu Beznea

