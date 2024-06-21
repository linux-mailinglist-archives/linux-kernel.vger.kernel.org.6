Return-Path: <linux-kernel+bounces-224707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BBD9125E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0258F1C21311
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90032153819;
	Fri, 21 Jun 2024 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkzlhiA7"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1822C1534EB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973838; cv=none; b=Cm7Cyv5iHzKZiDTLg3b0UtIhRRr0F86b0EIW2kHcWw7UY85Gl6bM90dbYq6MygqmuB8UnwalTOOG8Fq2lt58h8ZBngbZotYWX5ftrQFIX7wYM5v5eRfZfL8pNZ+sSSxp6VUHE9nictebzlaVwzQ/U6GL1+UL1q7Eh+bZXFsCYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973838; c=relaxed/simple;
	bh=FZAmzEQEeho/09liB6hFeg0Hi315IVmPFVcjTn4Fh14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOFVdwnWREx+hjzjs8IDdtgReiONKRmwxCqHgKMI6vLyEVHKJyXw2EW513vVPbjKOYebHWI1qTy1U57heNFs8t2y9wnBvgKJt3hjazNrsUgXrpyXX92zhBpb2ZmosFbLxjTw90OxDwAy4+WY/nLwrnefG/HyhquYrqbW4IAZsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NkzlhiA7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d280e2d5dso1471191a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718973835; x=1719578635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58qxmm/t3zau3gvpFhApfDkOSkGoEMC5DQ3Arc2tulg=;
        b=NkzlhiA7oHTf9J7PBtl2Zus7HBlM7CJ/BRwH921QUnuR+dKAG64+5gVmb998+dg8pR
         +xcIYDkfEXZ7o4K8Rk2Hbnhon4uD2itHXXWKykP+g20e07SHzuCjtp6MQE3xSU36qIGc
         gqyigGuKxVEcYlrCvERdUK8oDzCKhOLU6PtGTNwvdg8au3a6JFGkf52NGyfnBdQ5yBKp
         Ac/BrbMTshKcZ9qzSh9ZIRy0IiqImxeWJWX9LhxNgfWxOc7cHD3XgIFTXuRMBp3913DZ
         +is6BCfiog94GDFC4TGGn4TRqsEQAP6xpuDw7XG1YDHbomUHzoq6ISzih0bzeooLV9mz
         EWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718973835; x=1719578635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58qxmm/t3zau3gvpFhApfDkOSkGoEMC5DQ3Arc2tulg=;
        b=Mdn12mZQzmbzgMMT2gglanvHK0lMhep3aG7Z9ZNg2dLWM0SA1RRIP56FSBB+keXZfU
         Yuw6WxxSxxbNRvujSNTWqLL420t5ntrDVhkTK0wvxy+AGIzoVa9JNNpPETvmmpG8h0SR
         mCiNZpHjrsdb8csTrYgcEhHcadlaqZ7JoCWmbUDUjM4VEOyYM6dEeiSeR3Be7OE0l8wk
         6tIDRf82I8AGmZvojOenIEwLcDSPw7qvEoNpK9I+v1qwR9rwUoU/5SY6Ush5NR5fjo7M
         VpR9J478H3tYRykoxAjPmvMnsaSYEyrN1IbTzMfv/wBqu2siWOGz5HjWRRfEICoUIvww
         CKCw==
X-Forwarded-Encrypted: i=1; AJvYcCX3u1GVh4njXn45yo+E2aKW9QD0SNTBm3zw8QnQLSyq6Qadsmrlv3kdTAPlaLXfTfMaXbdFGhR3odyFPlldogtzNCwAk2p8bTTNc3DE
X-Gm-Message-State: AOJu0YzGWx24oeLvV/JSftCVVjR/wcJOMdedwaDJ+PT0X603F/qjgYRk
	PEW2oWR/4H8kWnpA8jFdcz1DWFBG4qRsEyEekKw9Xmc8pqbE1qBYj32cKd3td/3KCcK06zWxyPB
	A0Gs=
X-Google-Smtp-Source: AGHT+IEJfI1YxYhiHTZGeDyNtn7lcMGcyPL3K88HQ37hx8DhxxKPIoLvSrmIiONOLGTArC1CQoe3xg==
X-Received: by 2002:a17:906:1cd9:b0:a6f:1b3a:8898 with SMTP id a640c23a62f3a-a6fab60b9c7mr422650366b.2.1718973835355;
        Fri, 21 Jun 2024 05:43:55 -0700 (PDT)
Received: from ?IPV6:2a02:8071:60c0:a760:7f1f:9088:c2be:1cb0? ([2a02:8071:60c0:a760:7f1f:9088:c2be:1cb0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48b47fsm80772566b.59.2024.06.21.05.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 05:43:54 -0700 (PDT)
Message-ID: <cb70c6c8-7e84-4b3c-97e0-1fbbcf88fda8@linaro.org>
Date: Fri, 21 Jun 2024 13:43:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: fix w25q128 regression
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Esben Haabendal <esben@geanix.com>, Hartmut Birr <e9hack@gmail.com>
References: <20240621120929.2670185-1-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240621120929.2670185-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/21/24 1:09 PM, Michael Walle wrote:
> Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> removed the flags for non-SFDP devices. It was assumed that it wasn't in
> use anymore. This wasn't true. Add the no_sfdp_flags as well as the size
> again.
> 
> We add the additional flags for dual and quad read because they have
> been reported to work properly by Hartmut using both older and newer
> versions of this flash, the similar flashes with 64Mbit and 256Mbit
> already have these flags and because it will (luckily) trigger our
> legacy SFDP parsing, so newer versions with SFDP support will still get
> the parameters from the SFDP tables.
> 
> Reported-by: Hartmut Birr <e9hack@gmail.com>
> Closes: https://lore.kernel.org/r/CALxbwRo_-9CaJmt7r7ELgu+vOcgk=xZcGHobnKf=oT2=u4d4aA@mail.gmail.com/
> Fixes: 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
> As mentioned this is for fixing the regression and a proper fix will
> make use of the TRY_SFDP (or whatever it will be named) mechanism.
> ---
>  drivers/mtd/spi-nor/winbond.c | 2 ++
>  1 file changed, 2 insertions(+)

