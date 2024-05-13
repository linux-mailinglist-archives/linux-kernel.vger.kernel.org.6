Return-Path: <linux-kernel+bounces-178045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE39C8C47D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5B1B23CED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E79F78C9B;
	Mon, 13 May 2024 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qw+C8GQZ"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22D77106
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629671; cv=none; b=rowRoJswPhuVcZKY28e3s2KYnXnK39atwoej91xCRjAeo9efcjh1WIZH1pZ9Xgs9mwN87nU++uFLnhomhnI7vEBm28MD9b43gEO4mu7/ioCM0y6M4M7j7cQSHMC45cHlzEMBzZAhDKqrPDc41Mo0tNw+9GzsLIF5hdaTILMy49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629671; c=relaxed/simple;
	bh=z8Twj3N13mhdW7sEoJ5gZMRJ0MxEOmkRN+36+9pgaRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGbMTBVAiJifZ4Nnu5IN0JkoWJ/ytwx9oIW7ZwNH9SF/8CX5wD0x5g9JX8WnVVT8v3C+134AOeXH8iU5hR7lWW9puPe7e1RoDaiyIl34hgNg2dFclWF38cqv9QVGXG+5p+l7IrEcQ3oNM/A1Ysc0LeOdTH4qeRFULZNJyqOeuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qw+C8GQZ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61bee45d035so49364257b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715629669; x=1716234469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUknfNXk78tNoNSV/FKbuOTqBHWDprugew7p/EYSaSg=;
        b=Qw+C8GQZR1kRCheFb/tzuinNqtjxndae1jJV2IlZxLZpGFwyByfWdboBhSfjd0+oHO
         ikkCEN5sol2iEij/ZR6hBQeVdAx0x/jp/M6MZtw/aopXSUHclN3VOgTa/1mHYPyX46IB
         XfXwoCSFNdn5HYEAht3xnYEzDVYG6iFvNt9t0doukTC+Je6uX2G0FyJD7MJoS+iVxpXA
         HueoN2BJMXtuwUjarm/049cypgeZDEDWwgunNoqv0uu+IdTS1gK8L1h7ODnV7Mx1qL92
         AQ941Fwebiia9A7Kt8nYVTfVYTDYA+l5NDsE2r96fVpPURxOph0qDDoBP2g6W7Ts3XXn
         HAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629669; x=1716234469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUknfNXk78tNoNSV/FKbuOTqBHWDprugew7p/EYSaSg=;
        b=FObWktoFiDnYwgt3P22hP4YLRP4ZOd5HY+qG97MFum7medDtyDUyxDG+zVJQQ3h9FY
         +QIG2W7vB6seyb8F5nRGwJC+Y3YmFSsWVPTsJUy+7pRQeEyjUnAWKD8uuvuMRKL1PZL7
         z6AUzsZaDvXwsCuO06bbh9mxzcwQBohU+EKXdDXAWVPvIuMkd2219Q3R9xaFZZQIlZsa
         WS5SkfB/f+uWNk4YAgzK345uVVJz5kCJ3ywzeiZlTzKgzQ+0UTnHQx2T2M54C3YTY/GK
         n44xsRw95FRxb4R9sQrrpFV1c0J7GnwsytxfC/8m2qD27RDGRw6RtZ/Owd5ftVZwG56T
         XAEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLR+/lTPmN1ZMaCnx9udW5ZduXeGR9/UhN8DkcdMVAwEeaU9dK+LUiSpX+DhD0ez1R3TUwICLDIuvytG/LHDYNRTkZnPZxNDZzXRHy
X-Gm-Message-State: AOJu0YzSTKh7VvCYikHb4eCVX+MkHGmYY4mAS3iQC0IVOkCLSO+fAJUI
	nH6lUuNhzc34G6tQFEFxv1E2dutv6pgJ9Y5bZw8U6p3VVIK+TSwbJDF4sYdi8N50k5r0okHQPvF
	tn5b8ShNJW7UoyCVQmBP+9BjIGSLqdb4DNLkSXg==
X-Google-Smtp-Source: AGHT+IGnYYmt0EOnAPY00AN8x9tLJNXpR+W6Srvl1WDn62aWdwxJ3ONetwGbkGS/UdOHkoVbG62q60/rx6bF8LH6+Ns=
X-Received: by 2002:a25:f90e:0:b0:dc6:ff32:aae2 with SMTP id
 3f1490d57ef6-dee4f3356e2mr8656703276.63.1715629669087; Mon, 13 May 2024
 12:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-dt-bindings-dsi-panel-reg-v1-0-8b2443705be0@linaro.org> <20240509-dt-bindings-dsi-panel-reg-v1-3-8b2443705be0@linaro.org>
In-Reply-To: <20240509-dt-bindings-dsi-panel-reg-v1-3-8b2443705be0@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 May 2024 21:47:38 +0200
Message-ID: <CACRpkdaE0tMQ5=pSofT9pGVcSBLp=dm_7WedpO2EnkbP1w+08A@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: display: panel: constrain 'reg' in DSI panels
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Konrad Dybcio <konradybcio@gmail.com>, 
	Del Regno <angelogioacchino.delregno@somainline.org>, Heiko Stuebner <heiko@sntech.de>, 
	Luca Weiss <luca.weiss@fairphone.com>, Dmitry Baryskov <dmitry.baryshkov@linaro.org>, 
	Shawn Guo <shawn.guo@linaro.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 11:43=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> DSI-attached devices could respond to more than one virtual channel
> number, thus their bindings are supposed to constrain the 'reg' property
> to match hardware.  Add missing 'reg' constrain for DSI-attached display
> panels, based on DTS sources in Linux kernel (assume all devices take
> only one channel number).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks right to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

