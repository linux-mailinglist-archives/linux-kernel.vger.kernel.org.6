Return-Path: <linux-kernel+bounces-245675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FDF92B5DF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B9C1C217D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB355157460;
	Tue,  9 Jul 2024 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZid57NG"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5046155329
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720522288; cv=none; b=Wx7E05fp7nCJFH0jlYFQXo01zzngm47SwNtzLG0L4OWsVop1j7vQ1PIIg3zWdTbTB7ROJ1Y/TM4fPM9+Zy1ZS11Pta+0pG1XMOq2zc2Vb2JbrE4fEHRXpjB8R9SN38C5Pg/9turXS75bhZ7sPk/L5/JU59Xws9r0Z2PvaLEaI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720522288; c=relaxed/simple;
	bh=GuE84+tYe3IliZz36W/xwOvWAw5aen9f9pO/jTu9YLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joa2Pp3YU4xGi69JdtZZoSkSPG9xcDmaJbSKxJ8eqkRJEGNbnPk7Cq6SFm9JcLfy6JagFEjM+2Qkm3CML/FocQ67WhCKaljQeFkrd+ukx5ks9qG3/6XZ5c56vS93ZnzNrFgrkwPF5YLFVgsVQAjsrW71gjv3P2bbnScokwE0Nzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KZid57NG; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25e397c51b2so2464472fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 03:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720522286; x=1721127086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ne6sGKGQF4GM9jaPTveT7Fc90CaEuMuRCImmXptQf6Y=;
        b=KZid57NGukekwIq+9YW7ovSClgvK3OT5wht0YGeLtLx6issn2BPNVKA9xWfqya3Q4D
         rgrpdVUYupPbXsRQKFg2NaXugCsUps1748fntbGScIdOfZ15uvJ5Euqd4UtPVQ7yAUUY
         fjG95ovi6Q0xR5807E7E0kr3k48JR/wihioYOzF83ahwNXcc1OEwMjglQkvns7fNdSRp
         JCDaSRSkXEo1i4ly9PEOaZf+BHZoDgqPtGmbwqpOQ8WHtygCA8Z1Op3KmvADVJyx2eDC
         LSycppoCDueVOLW48W7qUbmnhLISHmwsqMKQ5G6aksqXlhaaTZbfkBpG8l941JaMmZsK
         6fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720522286; x=1721127086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ne6sGKGQF4GM9jaPTveT7Fc90CaEuMuRCImmXptQf6Y=;
        b=aqu8L3qFgexUcV6tfsARDNA9Xdopfx67Ek9Ssy7DoCjXrufJKhll2Ev0rCvA4OV5BI
         mIP7Gx9PB6x42xZjOSAMDmCj6Wj0WJ/sOTaGmIGyLYKekGg6svyihVvovmjE12dqfccy
         z+45dZDEx/1Jfxdq/bvlu6GqxanssjrOE/vhS58D+rcvWt17DsRuHfSjj3uUEltH9Sr9
         EP4D6UKsZ+xa/7e8XI+T9cDRNa07gI3SUGY0tjHEUS1vvYTw3ABZ3U10OCkmeZojBWG8
         TxeP4cY/o4j0j7Mh1dXWCVU7mGh67lrV7meAXm2oNxyKFRMw/Mjk6OzM1p4WGxhjHikB
         8qeA==
X-Forwarded-Encrypted: i=1; AJvYcCXAWEbyCGhJ+CugXDTImbYbl0meCEMKPAS4jS+KeDtWaYiIePU9Kh7whfHtFLieXl/01fT2VT7SJKTQe5EaAq9x+Al2w6smv5VgD10t
X-Gm-Message-State: AOJu0YxKaqoRDchn6ste6ZYkWsY30aklnq8ZCTNawzJqvEx8QQn4ty7x
	F7/nwaqQqQPXxYLUAc//zD/oMqBuJjqivTBOvMGBjdX38Ym+Q+acVvkHJ4tYWBbGz/Pn9bYrrGL
	jAmOGNGLm45HliEsp2JHJalRWupAltl1/rmpy4ARU5C8K7Y1GocI=
X-Google-Smtp-Source: AGHT+IG+y2y1lYDjW0w074p6b32KN/SNBfuH66xZOYYfG/aQ33OHnDDWnfHU1jSQkLv7VHnBWB5U5y0xOdhTHcklAQw=
X-Received: by 2002:a05:6870:ec87:b0:254:ccac:134d with SMTP id
 586e51a60fabf-25eae7575dcmr1763592fac.2.1720522285808; Tue, 09 Jul 2024
 03:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a956a3e2-c6ce-4f07-ad80-ec8a96e00d16@stanley.mountain>
In-Reply-To: <a956a3e2-c6ce-4f07-ad80-ec8a96e00d16@stanley.mountain>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 9 Jul 2024 11:51:14 +0100
Message-ID: <CADrjBPq13+k6LM=Xs3Eof9jXJwOHmcMoJUXAR18aHfp7fEeLcw@mail.gmail.com>
Subject: Re: [PATCH] phy: exynos5-usbdrd: fix error code in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Rob Herring <robh@kernel.org>, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 18:04, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Return negative -ENOMEM instead of positive ENOMEM.
>
> Fixes: 497ddafe915e ("phy: exynos5-usbdrd: convert Vbus supplies to regulator_bulk")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by:  Peter Griffin <peter.griffin@linaro.org>

