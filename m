Return-Path: <linux-kernel+bounces-173849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E9D8C065D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0143D1C2140D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079B6131E33;
	Wed,  8 May 2024 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g5YtGiqx"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05914130E24
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715204371; cv=none; b=GmWdBSXrjj1lI5soEw8n3PNN8Ryb2NxyLjRFetpDdvk6iDHco2tu8ncdMY2FpvYQbJ38WsLEeOBniSfehBHJ+aUp+E13vqzG1GPOe+va+R5jWKO09cLrbTz3C8iFbAcGKVNHo270YJAF0IFW9jv9eiFnlUglR9WekhW0ua3GQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715204371; c=relaxed/simple;
	bh=fLuUqMOyqwAemlEtU6y43xs/UkhZZNiNquIaNgSxjzE=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdo7JnXTEU8Ddd7HgN6VbSzalp2N/9kT9i5fDQjVJSiNdB28L4GQa+j2UaZzhvXuDEbpXULNb+uu1Sob72AkxpFF1P4Eqv58ffXG+85i4cMTJsaH/+AR6zvdS8I7nBgW4IY01hsmq0PmQNm8gK3ZbElzR6e9MJ9yG1aGQuP2P54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g5YtGiqx; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c96c16bb19so158383b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715204369; x=1715809169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLuUqMOyqwAemlEtU6y43xs/UkhZZNiNquIaNgSxjzE=;
        b=g5YtGiqxpM16sbbWIHodvoIa6UZfhmO2r2bwzDHYd5SS+ljyTpFJ01BupH30raFvYv
         oWXPw3Y/8n822w5q6lIgoHiP8uCHXqKFWFovgmJBiKhi/5CuJtoiW+px1xEr/l4dIx6n
         nfuzZUzM7pwnyvmaMq+JU5T4cDdfR96YhvpXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715204369; x=1715809169;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLuUqMOyqwAemlEtU6y43xs/UkhZZNiNquIaNgSxjzE=;
        b=VYozg8hw4+THiw1kjk7q3/lLitcWugTQcQER36cXuOf+W3vsOPid1dIg6k12KyQNZM
         VWp+vQxx/lw71fEKCX0HD5yoOSevRli2GsLEbSLH8rilOjbSP4lcJHmBKCylBv6NN5LN
         iGKd+c40YjJ7/5/EmuT6j7/tk0YS16+in539wv1Zf/Vzm7nvvk8dVSAXW0TKGxL818Ty
         9WX3zNYIzi/D0K5onUGEXcksZyhRPLJvgoDZ6Xxf+CQGBra30LoqhWThvI8EgRRy1qr9
         OjyQWJ5csEjxO81zaRckIpj2WFAtHR0ypxc8QrlRGub3hnv9C9125/Grip8vix/YCfwk
         fxaw==
X-Forwarded-Encrypted: i=1; AJvYcCV3vHRXXfE6LFmqHQKZdN6rhMT7ZfZ4FCG+iPXAmkp0jWbi8E6d+m9XST64YUXxhkgfZY0WhH3xUDsPcg9Qyx0hbZkFBooF4pzdWkQS
X-Gm-Message-State: AOJu0YyVvf1fiiFYsHucuTKTMq4GuNANq7xzRTWAQrK80quaVFQjNCzR
	fnXqdABOAtLd9FU+L3sKc+/feGIfT6jPTKaa9qQvD+YBPA3mAtLTic5zaQJkik4SSGwtdthrUgz
	8Mum883LWnz9urHAdRX/QWXeSKerR2xSd/ikT
X-Google-Smtp-Source: AGHT+IHTzxXDmZMVoKM9TOncVAludJOi1FwzkVfFIbGgmkth5pm3mfFjMj3E6fdSHQ2QJ3au3ZXk54+dk/use97XVF8=
X-Received: by 2002:a05:6808:6c5:b0:3c7:df4:8fb2 with SMTP id
 5614622812f47-3c9852cc63bmr4189134b6e.33.1715204369104; Wed, 08 May 2024
 14:39:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 May 2024 17:39:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506150830.23709-2-johan+linaro@kernel.org>
References: <20240506150830.23709-1-johan+linaro@kernel.org> <20240506150830.23709-2-johan+linaro@kernel.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 8 May 2024 17:39:28 -0400
Message-ID: <CAE-0n52PYe6tYGY__ZWKQ01C6pz3U+gWn_Xm5WoyVWA_5+WHew@mail.gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: mfd: pm8008: add reset gpio
To: Bjorn Andersson <andersson@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Mark Brown <broonie@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
	Satya Priya <quic_c_skakit@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Johan Hovold (2024-05-06 08:08:18)
> Describe the optional reset gpio (which may not be wired up).
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

