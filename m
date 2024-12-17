Return-Path: <linux-kernel+bounces-449279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D569F4CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FCF161F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532F71F427F;
	Tue, 17 Dec 2024 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYs4wme1"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BBB1F4274
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442911; cv=none; b=qjxHoT5+J7P8iUkpMnbeWubtOImEdTxuzZ490VdI2ul7FCipGSRqzgCcwOk11INHe43pyO60iaByNCSVXtLTyQ6Bma4Ij8/uMXn4uN6eAiedJjfDIZy2aqn7y78iZY/4vLkQcSXCtDJbl4FW7JpzhFQmDwibGUBgbjphOMlhH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442911; c=relaxed/simple;
	bh=OQPsyR7dAWj0HH5X6ewchiw1dxigQ2xEs+aOiFD7V1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6KHjh7vZuMPw7HQ7HgD0zxXAaX8ZjuMlbUP4FNgNikCH6iGu7N058UUCPYliF5OoVdcmGpnYuUMGhjhJbfJrUYhNoGIOUpSXSK08FwdNbqGoYvls1BzfYKRHN87/yqQn9UeC1HSZsPZMTuAzv5hH3vO5X6cRZ7tW2bvWd2+ghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OYs4wme1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e384e3481so4845763e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734442908; x=1735047708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQPsyR7dAWj0HH5X6ewchiw1dxigQ2xEs+aOiFD7V1I=;
        b=OYs4wme1GEwKY4d38JqDMXNdEKzwge2PXExNyWixOX/Mzn5fAHbXICAhr3A5oDGwsE
         y7c9mp6DRPFxkFSe4JC/yDjbrZ0ubDGIcf0DrkgO1VYml+anAOw98xyXiFT5Fo7iqOU2
         ntF+9h59piz/aZU8j6SQKKRIw7Z4otMxSJWvgYBFm1XGhXWHZxxr8UqK1GH7Y3b5XUJS
         A0RvHhd6vxygllCBfkVIqD3ecou4Gyn9hpfl7U9MRw6hpuMKeP3gxFeVpML2w7a20vJs
         us0TN4Ud4N005Z9rThQTHHbHUXvKmFBbcsyL/qalhQpERFfSvqgPERCnyhl0gPlTS/V0
         n2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734442908; x=1735047708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQPsyR7dAWj0HH5X6ewchiw1dxigQ2xEs+aOiFD7V1I=;
        b=cvr8eQaVpcQBpojfW4QzfKraFQl5Q5VZxNt9pDp5FUxw/4lRHuad2US4Hbz7Z3ttA5
         lV/ikVE5vSHZR5D8jZYc4TFKjBOJ8MmhFEJKrV0KL/pks3xhSWjm8HaANGelbEcNRcpP
         WNBtC/veLjB5VYuURoMd/zfn38u+PN/njQF1ay8Fv1W8TBK5V3YC/CelAlgveowV6ayR
         uSvJ83TSV50G7Y1II8ubQBDM7J7Cl8Xkt6c3MygApmZRlH7oj1I7/B2vzvKGIJbPtit7
         pFI+2EmMyaNojOKykbhMTvd1AngLSI5vkMmOziFgnO2xqgzuAlOHYuarsvFMf8pU3VSo
         kuRA==
X-Forwarded-Encrypted: i=1; AJvYcCUHJ4fhuYUinPE7Xj3B2pbImQ4Dbv/eQIIL6mOK9A2DhpQwAImhrFVAzbodlvkWFkW+ZTtWHmrFK4fQDaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw398+n41fGwAN9vDWvY7c3Pz04wpQEPDFgkUdL6wzMxOzlO2GE
	m4NIp3vDVE2DddRM7tVT58N79rU3yEEQWMUsWK9p1bcE1TjHBxdKczr2hwnxymc4sQxCrZwaMgw
	wnnglxCV4DKff8SFreKBVYcfQjg3QdwfQlaQ9hA==
X-Gm-Gg: ASbGncs8J/NulD4n68S//3cXXYEwKiSqg7jbORT93uAmIadaGuiH0Glrj3dPcD6YfLP
	tXpnnObJnbFmmps1IHjNFar4QuxLnGXFKyYDN7A==
X-Google-Smtp-Source: AGHT+IH4HRXYBmosVzpwGFebPuano60MtISoT9J69VFwW0An/ivv1V9rgWffgN2jJxOLz0JsvxSobN0rBrRAtASDJGM=
X-Received: by 2002:a05:6512:3c85:b0:540:20b8:7325 with SMTP id
 2adb3069b0e04-5408fac7aeemr3900258e87.2.1734442908199; Tue, 17 Dec 2024
 05:41:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119140805.3345412-1-paulk@sys-base.io> <20241119-prudent-jasmine-lizard-195cef@houat>
In-Reply-To: <20241119-prudent-jasmine-lizard-195cef@houat>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 14:41:36 +0100
Message-ID: <CACRpkdbcDwJaLmCa_YoP2zFw3fiWn-d1Q773jGh9kcVN8aWQKQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
To: Maxime Ripard <mripard@kernel.org>
Cc: Paul Kocialkowski <paulk@sys-base.io>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Paul Kocialkowski <contact@paulk.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 3:43=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:

> [Paul]
> > The pinctrl code supports an input-debounce device-tree property to set
> > a specific debouncing period and choose which clock source is most
> > relevant. However the property is specified in microseconds, which is
> > longer than the minimal period achievable from the high-frequency
> > oscillator without a pre-scaler.
>
> That can be fixed by introducing a new property with a ns resolution.

Perhaps, but I think a setting of 0 should just yield the minimum
resolution in this case, as apparently the debounce cannot be
turned off? This would also make sense to expose for
gpiod_set_debounce() as explained in my other mail.

Yours,
Linus Walleij

