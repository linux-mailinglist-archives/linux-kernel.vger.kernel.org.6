Return-Path: <linux-kernel+bounces-511800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B16A32FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A721C3A9B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810451FF614;
	Wed, 12 Feb 2025 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlbpXgJP"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E41F8BCA;
	Wed, 12 Feb 2025 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388985; cv=none; b=XsvqC96B4+O5i9S/9UovXYB/urkxyHpnvb5+Hhb2nQMPQvZyL6hayvfSFjK0cIOlpXo/n9TEeyhWQ0fMEKV2y+sHBZjjAS0Ff3/hFmFAiXtIZf8vFm21VujIzoZjGHqmJYRtvz4casKEGXr9BWuQp9rX9v2cif9BrIDIEFhdApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388985; c=relaxed/simple;
	bh=QO4/KNc9x4dzK3QBi705JZGrxHHJJZS+sDqwNV41osA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVJMpmqEHMR8Fe0T+bDLb/b2vRqykxj6iL7e+OOwuUw+9iONj2NOdPsqioHKjM5zMRtwI7u9TIRMbxo08is9tcM+bAselakFLjH4yYtBDbpnvOqvQPGGRH6+/HALOwsYJpifg4Ahue6Z3uZJv7qMNhoAUIIiSsB+HvRG0JEY0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlbpXgJP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7c07e8b9bso28235866b.1;
        Wed, 12 Feb 2025 11:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739388982; x=1739993782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nj8WHZGsoOuauuYxbxbB7oKPr0MKW37ni43BF0NAcDg=;
        b=MlbpXgJPjTDxVQl+8o1+S4FQLUDymcFGF/idWH1AHcpSpW22L1t6WRmY7kjnLYveMA
         PTTRj3ao6M6hHJ/sQPN3S9ZJu49pJOq/YbOZ//KpIs89O2NdYzWoMU3DnbMjSZSwUHXT
         R/wiEKuidHvtIISI+eyfS/BhS4aXoHq+S5kmDvkYBMFjhf7V2cxfRnX9571fyX56LJrD
         EhnRC0TgblsMqPA/S7sOnM19JuGK/DreIDbcrggjOVCoWvzfvJqFIsULOZRn7zfdZWjN
         1OiY65D9X6YloEXhb40WUGVs9qb/KKxr2LFF2G8/HK5L6S74OHPiC5n+6L00LC9qfYUs
         pPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388982; x=1739993782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nj8WHZGsoOuauuYxbxbB7oKPr0MKW37ni43BF0NAcDg=;
        b=DmEnsX4ZEXEjQoFK7QyGEFydtngaxKFWcQuqNzhwvb9qUgxqnJlnUtmk1AwD+zC/zM
         wwNiZcovKfDdu7iJDzLoKRFyEYh9ZOR+bb8hy7RLMT9DLccHHJTfWKBWdjKJEB3Edmkc
         bmxgmCsInVNGgaxjyoLHHV2RqvbaK9+9LC+tefJ4EBig0sgWfn7NiSkwtDXs9oozwU9y
         AOXyfm/aBLIRLzD3jdc2uAu5nWY0bXkOqYrHu4C6NS9EQzsYEWpporfsgOBvEIK34Eda
         qrZadVDcNGP8S+h7G/4lX2aW6irH03ElyuZ4dOXdt/HUMrJtgTH1ce6jz/h6pOLGL3nX
         wNqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUq0Ma7JQHlk9S3lF9IySoQxZWnEVeMt368hQxvuLcy4cgH7v1pwgvYPIyGNHHRi0xcXDQrxtO1zpw+mo=@vger.kernel.org, AJvYcCWfhMY3KNg1SYndXeWcWld1t0XTWXt9mAeTx80+8OowbdKFENci8coqaHWl/zRMFvsPHPlrF64tEBzwZMZV@vger.kernel.org, AJvYcCXwrf/HdyTFq7W0v/rU5/oFn1PfRvIUkPIKN7uxCA2gZNHy2r11AXNRN2uvB+KSH6LFCWTLkz6+jDis@vger.kernel.org
X-Gm-Message-State: AOJu0YzmEDPi44muMUy45cBn+mhK+182NPR8i203588oIxQ6QWNCX0V2
	pumQ4Hkx3GrnlCILzwDFoJLdk02SR4n3umIfvOZov6PDXB+7epku/h7jq6U2
X-Gm-Gg: ASbGncvNxwdXITrfPKJe+zi6AFCTWwmzjiCVUydOb7uc24XiE7y+9xtwv/l9GQ4anat
	rTPwM2U7V0OzYxB8bIayihx0X0GmMiANc6cCa/TODn87pwfi7nAjsQIiHwgiJF/PAZIXZm3J0eJ
	T6QrkZXs5ll8pfSkdyrl/cIaxzssLwoWTqWP0hQ/zF7zu+64pnVJzY1rukWWeRiijK/VEHIj/4e
	5YsnKhI/fC+wy6UBoptysEZvQFNG1so5XTxLUxXNAuo/oX58vSAhHYjUpfGIa3CPiw0+Yb367PX
	xvVL5h8d64ixU+hsHTBn2bBeNRpLcqkFlQ+mj4i364nl
X-Google-Smtp-Source: AGHT+IGL83Kis97/b459m6UtdYpnAuiWRMSSg5OjvrrLppYn0/cJ+CJ1qwhXz6yKmy+MT4z9GaeW5g==
X-Received: by 2002:a17:907:c1e:b0:ab7:9b86:598d with SMTP id a640c23a62f3a-ab7f33c1e0amr401910866b.17.1739388982053;
        Wed, 12 Feb 2025 11:36:22 -0800 (PST)
Received: from [192.168.1.130] ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f49361sm1319997166b.33.2025.02.12.11.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 11:36:21 -0800 (PST)
Message-ID: <e45411df-1b8b-4f21-878d-d52e1112e62d@gmail.com>
Date: Wed, 12 Feb 2025 21:36:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] ASoC: dt-bindings: support imx95's CM7 core
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@gmail.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, Pengutronix Kernel Team
 <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
 <20250211225808.3050-2-laurentiumihalcea111@gmail.com>
 <20250212093610.x4ixrackmn3u2xrf@pengutronix.de>
 <CAEnQRZBeQdnC+K92+Udb5awTmom10YHHNt7Ld-pYK4A1i8sr3Q@mail.gmail.com>
 <d66996eb-f49b-448b-9743-d19a3c3eba52@sirena.org.uk>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <d66996eb-f49b-448b-9743-d19a3c3eba52@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/12/2025 2:38 PM, Mark Brown wrote:
> On Wed, Feb 12, 2025 at 12:11:49PM +0200, Daniel Baluta wrote:
>> On Wed, Feb 12, 2025 at 11:38 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>>> On 25-02-11, Laurentiu Mihalcea wrote:
>>>> +    const: fsl,imx95-cm7-sof
>>> Albeit Krzysztof already add his Reviewed-by, can I ask why we need to
>>> add the -sof suffix instead of -audio or so? SOF is a software project
>>> but you can clearly run different software on the audio-copro as well.
>> Sure you can run a different software project on the audio DSP but
>> you will need a way to distinguish between the different projects.
>> There might be different mailbox, memory configurations. So you will  need
>> to invent another suffix specific to the new project.
>> We can make  const: fsl,imx95-cm7-audio as the one used with SOF
>> and think about a different name later for when another project will
>> want to use the DSP.
> I think the point here was that the DT should stay the same even if the
> DSP firwmare changes, just as how changing the main OS shouldn't affect
> the DT.

It's rather unfortunate but based on the experience from the 8 series
(imx8qm, imx8qxp, imx8mp), the programming model can differ quite
a bit (e.g: remoteproc vs SOF) even if the core is the same (i.e: DSP core).

The different programming models also required different DT configurations
(e.g: dif. mboxes as Daniel mentioned, some extra properties (i.e: reg-names), etc...)

The "-sof" suffix was chosen here instead of the more generic "-audio" (or whatever else
alternative) because the DT configuration is specific to SOF's programming model. Other
audio applications running on the same core may have dif. configurations (e.g: use
DTCM/ITCM for memory instead of DDR, dif. mbox count, etc...). I suppose this kind of thing
is bound to happen to some degree since the DT node doesn't just describe the CM7 core
(but, rather, it also encompasses information on the memory, mboxes, etc. used)
but perhaps I'm wrong?


