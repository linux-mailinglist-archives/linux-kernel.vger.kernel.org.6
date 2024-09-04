Return-Path: <linux-kernel+bounces-314392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8013596B2A5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229031F2797C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49D413AD3F;
	Wed,  4 Sep 2024 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZuFbKfIS"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5F6BFA3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434238; cv=none; b=N+2NVrlmyjRI2TQUdV29urp9zqBFQUZDi1i9+06MmUUsu+p0kd+8O9A/M5Gx59mNE6khAPcetPf/FjEdyLwT4PrTxMWWwoOOe4duopzsBWnTsfk6vmtRqSZIwVfxtRmlpcvK5k/KoYMk5Cro5VIaKE7JeWE1NreSJNxMjdSANzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434238; c=relaxed/simple;
	bh=LbpLq/vPR2w+mZlKdmwfDZwAGt83J5oVRqyrOL/+UFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=snIMqrpDik+hMOuXRuZTw4o565LpEIenGKb5ANvWUShfzhFWBtF/ubDo8FilvPJvk/C4ZhoU8nEZgB93C1SNl0cgxWo/UFze77spSgq2xScQHBWw5beI26qKfycGJjYgRfVUuwudXqG9wJ+UKc76rZKRlLGF+qq/yxqfDHj40dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZuFbKfIS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a868831216cso733994866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725434235; x=1726039035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsvjth4cKCfUYiGuzHYQQ+kbojbVD/RacZP31k6844k=;
        b=ZuFbKfISI5dCvTUUGdsCo0qRWn+heDHFUR/HvmieqK38wAYaPrUfgNjvfTVFpyAsqh
         sCgz2jr6WqRekasKToq2sQBiCYyQvxM8o6UQB749Tezo3L+lnfdcXBUNsmMKquvaQz92
         ZFxRg98j90OlypTvJ28A7cABtQuRoAF5pyHY2ci4EQit7ZA/i025mbxMCX933j+AbTpD
         44Fdf8+yhcuyJic3v7WTtlRKfke2D4SCwrrdvG0ry4qKzV1zARCE6vWmp7/hRvsrAyMZ
         qjyjTrkZjNQ7Qu4mA+enP7QgcKBD0offq6bipX6uOX2q9OItUWdARtkQkvtdfDZNKNFS
         4GQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434235; x=1726039035;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsvjth4cKCfUYiGuzHYQQ+kbojbVD/RacZP31k6844k=;
        b=qv3B89vMQv9vb2IkHtwrNwrrdI+E+rd/x8LY1AfMiX6+HNKDFDhGNP8j1n3nBUptim
         XxkNG8WEnR2ILj7pWp4Cg/YK7C/gaqqr4rSsdyzCmEYL71EReRHNX6xeIkDWNpjFcf6B
         h5SGssdgEceRQd1MdTJsgDBn82DeWPe75IOvAR8430ePK9NeZL1MxVa+fTTQKmHf0St0
         Pot/PK7NEkIMgXzdWVrHcFNnZTCN7Ln4wx7W3uR1pkz68ShrORdi9B3k3VCX+Mk3nbCe
         pqpoc5j/SCKd/cjXnhMT+ziblVIve2H8gLUrSfbC17eYT+TxbhPyOrKfrXJTGzSeYoQ4
         +jRA==
X-Forwarded-Encrypted: i=1; AJvYcCWOUZLi3cihByLmtpWiUJVkhdOciejq+jDjK4HvuPKteV2vrojZbDaFzvmcYhr7xZCx0fMLgOJ3zkvpzB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKS4AAL0Cvxm4AMdMXhSyE3fnnIU1CpcLv9hdqgSHsG38EPhni
	Gph+4/EIliX0EZkFdM7JEbv6sEoFrpaBSN/msYUYX+Fs2tkSIXGpMG6xQCyLkSw=
X-Google-Smtp-Source: AGHT+IFv4lrVDt1gLuCGFBMw22m6pfst2PJdH2uvvS/FVnYou4MYSbqJIrb6/0Xa9ve4TB8e9zhiPQ==
X-Received: by 2002:a17:907:3d8a:b0:a75:23bb:6087 with SMTP id a640c23a62f3a-a89b9555f82mr1165836666b.29.1725434234948;
        Wed, 04 Sep 2024 00:17:14 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d7482sm767171466b.165.2024.09.04.00.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 00:17:14 -0700 (PDT)
Message-ID: <f6589bc8-0bd6-4552-ab3c-6a814814f366@tuxon.dev>
Date: Wed, 4 Sep 2024 10:17:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/12] dt-bindings: microchip: atmel,at91rm9200-tcb:
 add sam9x7 compatible
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>, conor@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
 <20240903064233.49366-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240903064233.49366-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.09.2024 09:42, Varshini Rajendran wrote:
> Add support for sam9x7 device compatible with sama5d2 compatible as the
> fallback as the sam9x7 SoC uses the same tcb IP as the latter.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Applied to at91-soc, thanks!

