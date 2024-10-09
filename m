Return-Path: <linux-kernel+bounces-356907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1CF996888
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C4EB2380E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2541C6BE;
	Wed,  9 Oct 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xo+Hnc0X"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0645D191489
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472889; cv=none; b=G2tVgviRmRXLKLGBE8hLQN+lMzynMIIl6NcSN1HSKT+ckWqPvd3PZpTnoVqHXey2qVxtRTDlua+icA8+J8soQLLl+9w0zjOTW+GvGOaOJZTnkyQzgUik7KIvKsZgmpaSJTsMkZOGCsdWc9gpsnrCMdp558SdMLMxwNKRSRV6ykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472889; c=relaxed/simple;
	bh=K6vtvPB908Tq38kLIBtEKe64ao89wnx025O4nGdzLHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6pyYq7TJyYK+Edia4AVdlWRed7dUcBxK08cWO0RRPMs8bGntc9ELoMy5U9LlRfHhXVgFHI0GRSOEh2wXfLdafFru0U0KVQ/73lZevIbe1VcUy4seyQiU8WEkpYCvWO4GtjMcdKDb1UV/++mzPhXpVw4EKHcL7oG/5BEuPsSAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xo+Hnc0X; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fac9eaeafcso73288481fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728472884; x=1729077684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6vtvPB908Tq38kLIBtEKe64ao89wnx025O4nGdzLHM=;
        b=Xo+Hnc0XpxoDGOXSnRl0hFyz27Ox2/8zcdpESIqxR5zmN7oWRp5UasuFxUBGqTuPxh
         z37m1zsXt2K3sZlnIaHBmPCl3+myBmC50uM/lZb68hTAtTeDHeE/T7Kz+nDIRIcdw16f
         WsFWos1HIWWdbB79gTriUoy9kiRmKJ/fa26K4RclIqPtlX9njNZWK+i9HnTvHnFe/qzO
         cxJ+hyeUQQVGexpVAEPWNkQCr4easf4tFvsMEPqfq0RyvC0grW+7uNxRu6gYelJyFE1B
         xcjpm7Wt75AZhTytVj9TlPgx9yFM9GQjKOY4oP7ACRtBp24SclvB39mgvdLcR4rRihyO
         Do2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728472884; x=1729077684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6vtvPB908Tq38kLIBtEKe64ao89wnx025O4nGdzLHM=;
        b=VpLn6I+e84mEN1rcfnyo8wWxZworDxsH4bwXHlxjCPMiK50cgwf14uN9isxGDxUh4r
         UpTOd4JH3hGVICRG4Q2whG4IrJxiw+2at06hSd7SWuRBLcRZnul6y5RyDWjRU7kPYNox
         AIPxhNT3+o5vJMvO/Sw1jqy2kJHQtu/RvRAIB5NlLnxdPI/OBMlvtPsCgmrZgQWwLqwO
         vjkoJnHN/wNtKW6khJcgqx8c6BAiHR+5a/MgQJue7wcFzlQsNgaBJWftw5aXxYa0xUtG
         RGECD/ZEsgcu5TmAhRfOCxsY9RIiyRttIH8cRO9MmTN7or8XFPIgN3ilPNoSU3BcIU6E
         TRwg==
X-Forwarded-Encrypted: i=1; AJvYcCVwKULjgWC2OG3H5F8z23hREaKQDKPiZ1VjOktvWCTtdizBesCSGoZzwO/DVmCqdH2GOe2QMwqp2e+pIBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHxTf0nZpEH3GVqy9PsxNYeUWlOv0wzoziML/5QOimObrTXjlr
	jxXcij0Ml/aFQnSPqaRD33O5/BbHrSfgwqS98wmo4QXYXQ0ulHkeepfiS6eWTTNeafO/4EhOrnx
	HvWmdBRzKzNHyeKgVnRRtZyx4puzD39vP6RJ78w==
X-Google-Smtp-Source: AGHT+IFmEU5oJ/7coIsQusC6z/KBPVtggdarUFKeOox4L/etbXaEuzXf0rVsMoW/uJRsuAKWRkyIQgcPek93JhTv9Bs=
X-Received: by 2002:a05:651c:1986:b0:2fa:c841:af36 with SMTP id
 38308e7fff4ca-2fb187ac41amr12317131fa.30.1728472883961; Wed, 09 Oct 2024
 04:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-mbly-i2c-v2-0-ac9230a8dac5@bootlin.com> <20241009-mbly-i2c-v2-2-ac9230a8dac5@bootlin.com>
In-Reply-To: <20241009-mbly-i2c-v2-2-ac9230a8dac5@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Oct 2024 13:21:11 +0200
Message-ID: <CACRpkdYym4PJ5HkkNCerXMASfA8rx2ABzwJ-vz8efRhrq2Ts5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: i2c: nomadik: support 400kHz <
 clock-frequency <= 3.4MHz
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 12:23=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Hardware is not limited to 400kHz, its documentation does mention how to
> configure it for high-speed (a specific Speed-Mode enum value and
> a different bus rate clock divider register to be used).
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

