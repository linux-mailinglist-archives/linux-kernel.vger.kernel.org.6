Return-Path: <linux-kernel+bounces-209537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926F2903760
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4DC1C2315A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5A6176244;
	Tue, 11 Jun 2024 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxVxevJJ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8030579C8;
	Tue, 11 Jun 2024 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096606; cv=none; b=owL9/WiSulCqLLUNdhkdL5h7girnNe0GsNV4xsFD48Y7J43UkswWlHUH/UxTOWQf4NHuYk8VDHnIafZT+eRONtGUE+FGZe3z+LnMwacO8hgzU2NpDdJF3tcuR1WxPiJ7l2wp7k4KbuanQibL2oUEOQEQAolAEcxGzm5jBzoxatU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096606; c=relaxed/simple;
	bh=cFBtMtud7strLsmIoucBTehp9+ujneQBRiuKV7REWKA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WmrBo1Zms8Sg/njjoYh0CSIrbdmCiuDpwSCCnV/7EdV4/BhoPehh5TYQAWNRnAHeXMaOK+igIwzeuCEVB0zNuY2n2u4EJTOI9D12uuvlkQ2cZH+hD7v0qPxt3x8EdtD7gk/sbG1ewku2D9tuSiIFrkPMlEOhqkyHd5xaRgLx4w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxVxevJJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f04afcce1so90319266b.2;
        Tue, 11 Jun 2024 02:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718096603; x=1718701403; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MaUvDD1ua4d11/mNYdxEtsIhc9jZ3PvUExTrYcCwUcM=;
        b=RxVxevJJN8rTcVKZJBYsbqSuJ7hyiDalJGOUlaQRG8vyfCWualWnWLZCZ21IOJ+3DS
         Xl0XtZtkwDHIMb6BIKK3KhmBGozeDA8IBwtAlEzYtBd02NUBaEYmC+Q5pgBuxUfJY6NP
         NLv/si02wjTTuN7hc450/LN+4773ZFrF2EnijxSpKKEriC8DL+vkJj7JYZVwP5i3m2kt
         Bsuzj0ZKENiutJcjBcU5jtBildGT9JZjj949fw9yZdUburWXgXogQhmelgMNgOPMg1IN
         2WeBKHAyO/JWXkgiAfCNK2FYpJD6xbVG38rZZiohlc6ayJcas2A0LCo0ggWRoXfY1oND
         92Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718096603; x=1718701403;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MaUvDD1ua4d11/mNYdxEtsIhc9jZ3PvUExTrYcCwUcM=;
        b=qk4bQq76iJzw5NE5EKqR0Fw3af8l1DrMVldc4DglQJOxk07VDr0qVF67IXPO78wYrr
         uzEPU3mYIytwqN7Aelb2/MNAALLqe6UURKSfxlZ9wjPbAV62q4BFOmbf/sEwqzJGQiJO
         IbUNNlBqhbPUv1TmMjGyQZbgudRc7pDtHv6OY1SByxfWFYwNwMrXa51aTsoklIZ9uLiM
         rWlSiqdtBvIU0ESgcEjrNW6cfrGPEnAHG51C+ucVRgoIVJgJ9XorD4DKiOCy3jwKnroy
         M74BNhmd8wjRyWVSabzfEF8nm8jdmDbatbPeanJu/wpLyfTGxi5jABHuJmDvrDm0QrH1
         mafQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9kl/ZaF9luIqKmnHxF5lWn0CkaKavYdCthw6jXepZVOnEwqFCHgtvYThXWHn5CUUNKipXKXlV3WvFYILN0hk1OEgvBB54FxzGkq3S4lXSzEV8hbGts6l84x/YmztGsmojtI5Q70+gZrg=
X-Gm-Message-State: AOJu0YyBnUnoKhrd2fUSj+kz9Qx2QeKX6qYy8ObXpgKjRLYuBgHNPAGg
	AK3f465GFMv2Y9OB9yx+GZkfcGOm4vBPFAKyUESiLTkdzLLs+S7K
X-Google-Smtp-Source: AGHT+IF1p47KrotDUyugQTZUcZ3xIm+l6ILxJywC0yVVgkBB72xEYlqMNGH3djepNLmIPJAx0EWjLA==
X-Received: by 2002:a17:906:3cb:b0:a6f:2e80:6e04 with SMTP id a640c23a62f3a-a6f2e807573mr232587566b.19.1718096602571;
        Tue, 11 Jun 2024 02:03:22 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6e2e1d4cb8sm562848766b.5.2024.06.11.02.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:03:22 -0700 (PDT)
Message-ID: <5f329f81cdfed31771f014d4d3cc35f4d13ffb0e.camel@gmail.com>
Subject: Re: [PATCH 4/4] hwmon: (pmbus/max31827) Explain why enum chips must
 not start with 0
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, Peter Yin
 <peteryin.openbmc@gmail.com>, Potin Lai <potin.lai.pt@gmail.com>, Daniel
 Matyas <daniel.matyas@analog.com>, Andrew Davis <afd@ti.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 11 Jun 2024 11:07:10 +0200
In-Reply-To: <20240610181046.1991436-5-linux@roeck-us.net>
References: <20240610181046.1991436-1-linux@roeck-us.net>
	 <20240610181046.1991436-5-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-10 at 11:10 -0700, Guenter Roeck wrote:
> If a driver calls device_get_match_data(), the .data pointer in its id
> data structures must not be NULL/0 because device_get_match_data()
> returns NULL if an entry is not found. Explain that in a comment to avoid
> confusion why this is required in this driver but not in other drivers.
>=20
> Cc: Daniel Matyas <daniel.matyas@analog.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Acked-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/hwmon/max31827.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> index f8a13b30f100..391cb059e94d 100644
> --- a/drivers/hwmon/max31827.c
> +++ b/drivers/hwmon/max31827.c
> @@ -46,6 +46,11 @@
> =C2=A0#define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
> =C2=A0#define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
> =C2=A0
> +/*
> + * The enum passed in the .data pointer of struct of_device_id must
> + * start with a value !=3D 0 since that is a requirement for using
> + * device_get_match_data().
> + */
> =C2=A0enum chips { max31827 =3D 1, max31828, max31829 };
> =C2=A0
> =C2=A0enum max31827_cnv {


