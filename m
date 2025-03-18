Return-Path: <linux-kernel+bounces-566906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AE2A67E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492623B3F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26520E700;
	Tue, 18 Mar 2025 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdnpyz1O"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C91C1DE8A6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330897; cv=none; b=Yav20b8GhRxh54wq59rFiEkZSaBnZkrCy5Cd4wd9zAaEpysOtni9El1dAybVcfqx5GSBkGlphSOiHrnRXX6yMJBpxw/L9K7yWxi4/bxwmAJOo8o0oaXPhGrnzP7h4ifxOzJL97txrtpHyzS+v4RLtPz9iFuBbZ3B0dL9qy36Y24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330897; c=relaxed/simple;
	bh=SXreAV2ANUNLXOCGHNmgwnuxR6Y0ADaUa6Mv3KQ5Clk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RV6V8Nwup8gu+l+T3QtPzmE1Bqbp1QqLLYZ/al0ilst8PHxxOxdC3OjKL1W4XSXcEUdzTbXG5ACaL6mB82ZIPqCIgCcwqH0axGYJhme8lisWpTj90+N3z+m05/Vb7u/Otvs+ytUkLxvy4rNuD+i/yjjTNIM29DoPzORS6M527mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bdnpyz1O; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-399676b7c41so1669503f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742330893; x=1742935693; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SXreAV2ANUNLXOCGHNmgwnuxR6Y0ADaUa6Mv3KQ5Clk=;
        b=bdnpyz1OsdfqlnPx0wd7CiWcp42YqNS06leuc+oXWbiLzbpcjynZqr3aJ2BUNXMTo/
         XiOwFtp1jdhoFyRJ2YYCtSaXFTEoouo08D2QOskBHnLszjP16NHmkDuYEMKpYnpn6Lkx
         mHvqJz0iD5U0L2pY0UgQhg9pTuh6b7srmQ6Lp5/DPflSLoJO/Ubj6EQB5hX7ezZEuKry
         Pkgd4orEiuc5mJEhzPxVNH6Eo/EHs/nI+8nOcnvHtI264FQ40afTPRC4MyAgoJt6Obbm
         hgwmcFstr3BLlWoeMy4+0maLydIeQRJ/5qwEcgBchBDZqSCRrAUfM1pzmtUvWaY4iEXx
         vqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742330893; x=1742935693;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXreAV2ANUNLXOCGHNmgwnuxR6Y0ADaUa6Mv3KQ5Clk=;
        b=t2OtyBEfIcwwN4EqFF7QUL50D9WJ3MawosXRLXsnk+pO6YvE1QRWTa3zVmdHBZANss
         dAVAINm6/td3KPYugPZpqEJ3xN+tILLthTuAL/zp5hJkIOy6XatiJErdQuDQSX9ISYIP
         wXDgau44xq9mnhKYkHSMONZLJGyAlOdpqN+FD3RbN+zDbdilgWzQzNniXtwt4dQOYt8m
         451Ifs2UzI7fndmKxFptDBntqtu9ANvrC7MDZiKmIjpTklfkpDofNnJcjuzZCaXX5fzd
         +mZQ3fB1Cxofq0WfNEFar9OASCQVTZDr6V2asUxfiLP6UOwbwPR1k/TCaQgtTHuyUlIB
         AbRg==
X-Forwarded-Encrypted: i=1; AJvYcCW8HYjC93XSr1MT9s06tOVTSnKRG0Fvx67oueSkw0xiY0ILA1D0/Yk4PyjumzmTjevqoDmMgQxhSsVBOl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPJDOZV4LKS/gNc+/LdJG4q+GK5kTFw+EHP5oKrgSJv6/YDp6
	6KtQLiOpfrsqYD3FGAlHIl79sEcxkLpGnNox2S2w8jT1qJpp9uUjBlidPnnV1gw=
X-Gm-Gg: ASbGncvsAdYx7K9rQks7qgkzXOAxi2kNbkWSLIcteEAJaTS6jlEIHjKiqo8ViXODuRi
	Je5NJarwjMJm+2Fp692FxAMzWPR1bQMQoCbsxiFEeX2Ma/0Ui9Y8pCAo11jucEybBbRgpgLN04K
	eIbuIQFYLARa4FX0U0WdQaCrIICywWBT0MbHX8w8V4KRfimUeZy65UpNmBrEtN/vtqbindPn/8K
	BR3TY1COBsHA8T/HJyyApsCEzOJxTsv0VkCYmhjAc0BkpcmAmzM226lned10H4rWopUAwstqFN6
	7fJNrTSnIJ89przgs0GNPX2LyZlT0rel8umKParBMdNTNbHA
X-Google-Smtp-Source: AGHT+IGFPGJRCtLFFy23VSE/m+QckBBrVhU9c3ZgD9sj7uRUJ9l394Djfqcd3htbbBE+Wcpd5jsTmg==
X-Received: by 2002:a05:6000:1448:b0:38f:3c01:fb1f with SMTP id ffacd0b85a97d-399739cb086mr153384f8f.30.1742330893184;
        Tue, 18 Mar 2025 13:48:13 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe294b5sm144621675e9.21.2025.03.18.13.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:48:12 -0700 (PDT)
Message-ID: <632522cbc66e456f3b12e884c6c140b38e101aa6.camel@linaro.org>
Subject: Re: [PATCH 2/3] firmware: exynos-acpm: silence EPROBE_DEFER error
 on boot
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Krzysztof Kozlowski
	 <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Will McVicker
	 <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski
	 <krzysztof.kozlowski@linaro.org>
Date: Tue, 18 Mar 2025 20:48:11 +0000
In-Reply-To: <d2e162cd-b12b-47e2-9190-2ecce3489b9c@linaro.org>
References: <20250314-acpm-fixes-v1-0-ab03ca8e723f@linaro.org>
	 <20250314-acpm-fixes-v1-2-ab03ca8e723f@linaro.org>
	 <638cf070-9fd1-416e-8172-75f189ab0dfe@linaro.org>
	 <d2e162cd-b12b-47e2-9190-2ecce3489b9c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-17 at 10:48 +0000, Tudor Ambarus wrote:
>=20
>=20
> On 3/17/25 10:26 AM, Tudor Ambarus wrote:
> >=20
> >=20
> > On 3/14/25 4:40 PM, Andr=C3=A9 Draszik wrote:
> > > This driver emits error messages when client drivers are trying to ge=
t
> > > an interface handle to this driver here before this driver has
> > > completed _probe().
> > >=20
> > > Given this driver returns -EPROBE_DEFER in that case, this is not an
> > > error and shouldn't be emitted to the log, so just remove them.
> > >=20
> > > Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
> > > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> >=20
> > Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>=20
> I see you kept the error message though for of_find_device_by_node()
> failure. You either get rid of that too, or maybe transform all to dev_db=
g?

Thanks Tudor. Seems I missed that, I'll remove it, too.


Cheers,
A.

