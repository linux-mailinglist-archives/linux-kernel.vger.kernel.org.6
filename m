Return-Path: <linux-kernel+bounces-177850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF77A8C454F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB881C22D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C971CD26;
	Mon, 13 May 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MX3nZAXk"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915931C694
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618998; cv=none; b=uHKmIGVkx3kQBODzxYlSJ8U82GFD+Z2kURiWL80+nyN6D26jZVfV1GvDYAoWSoi0p2hm6r60kX6Q9eFIWUeQ7o7OMoZ96tPVzoUFR86UattaxvkciZJNPqkbP/bcAJygkKAPI/qlXPOvjgMt+qj7WNNxUdT35YbT5VmLNfpkMFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618998; c=relaxed/simple;
	bh=cj8rJejB14OhovDU7mN2qrJaZ+XHTVvKDLhBqzNr4WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaDT3il5WsUGfCYGLt+W7RJdFNDPwMuf9D5j/x49J9O5dHPiNXaUs4nx1MK89XeNHX7tH8XwgZUH8oXxq4ca7XgzvKnE6r9/0ehOTW9X0Ff9I6eFq1Be8k/Y3EWE9Xsyl4z3nKoLxdFAGYiIJiaatU5dxVXDc6z8WHOD6J3WJl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MX3nZAXk; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b5a87505cso22203146d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715618994; x=1716223794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OM85BfQlIgcnJ/1dV+4zfpQvFXRIYFAfmerK9P8RRU=;
        b=MX3nZAXkF7R8bcfEIMene3P+Of4yjC/xDvel6VbAqUQc56WG3T5UKpQK6H2OdSR54Y
         puDtIW+OpgugbWz6cVLeK7TZus6AHl1z9QAr/s5kFtrhXAaU5tb7Vo6rUhx1DY5jvQbh
         TX8Rql4XPmEwWeysEycVV16q9tHOeTrMicMv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715618994; x=1716223794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OM85BfQlIgcnJ/1dV+4zfpQvFXRIYFAfmerK9P8RRU=;
        b=YZAOsIHobHcPSe6jGKJ5wu+f8UyCgxY2e2WxIRSgnjwckAgDiVfARDbm8Qeykvr5p5
         Fr05fQsEmbgK1qE95sdjz/fGCwBOVwFJOfSzW/RErYzOI03OzlFmH49Dz7JhtgQ9W97S
         vQVmGXrM8POstlxGBjNa5cAWxbZ0JJ/NrO+pdMibpmcAtwj35GclZsb7tU35vmISkW1v
         X97hgT8nsAcIW2C9V8Fi1uJxx75DHePLODmOAcWRTAwx2+arspKW1BDWAWlsNzXBsE13
         2igHbET1Ltrj5X/1gbc4QfaC38+XTjmf/VmJ6WvNF7vLPQ8PLi9DtSCaS2Dv+kPH+Gpv
         eerQ==
X-Forwarded-Encrypted: i=1; AJvYcCW240rOURHvyDKXho3bEWarCKsEgIft0yOLzOHZI6xBBa+8n/d0m24B74qI8mfKincdSU1yBalAV4uM0px03sHuez7sY0RoDh2yorbL
X-Gm-Message-State: AOJu0YxG2SqZ/J0p6il4b6ovoQLc3YXMqQ5H0hM/cAxtgVVumrH0Heej
	L0swTbRtDATKiFijb2TMar1QH0PchBF6GrZ40z/pJNG9r6OOSOoRQP39Hlc3UaJJ27gUb5P4Mro
	=
X-Google-Smtp-Source: AGHT+IFnJy/ZXez//nzd2UGrDWSAd0FZodbRKCYbq226sT8saYDWZPwFhwDutFTuKRbK58UqR/9N3g==
X-Received: by 2002:a05:6214:458a:b0:69f:a5a5:4eeb with SMTP id 6a1803df08f44-6a1681cb4e4mr129129486d6.38.1715618994506;
        Mon, 13 May 2024 09:49:54 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a161adc751sm42620306d6.21.2024.05.13.09.49.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:49:52 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43df9ac3ebcso767011cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:49:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVscE+ABo1TPgYvcNqJ/fqw6X9yVRrZ3+t13CvIW7GmS8IIuPMIu8XkoeaRWkdkEzJ1F7dKr5GaeHQMV9uT4RjjIwiiFb/4Y2MYJaIY
X-Received: by 2002:ac8:6f0d:0:b0:43b:43c:2e05 with SMTP id
 d75a77b69052e-43e0a223775mr4615311cf.19.1715618991681; Mon, 13 May 2024
 09:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511021326.288728-1-yangcong5@huaqin.corp-partner.google.com> <20240511021326.288728-6-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240511021326.288728-6-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 13 May 2024 09:49:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XrmxSV1O2S+Z2_n11=sh7WACvg24xiAquGTMMFFGDEPg@mail.gmail.com>
Message-ID: <CAD=FV=XrmxSV1O2S+Z2_n11=sh7WACvg24xiAquGTMMFFGDEPg@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] drm/panel: himax-hx83102: Support for BOE
 nv110wum-l60 MIPI-DSI panel
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 10, 2024 at 7:13=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel, use hx83102 controll=
er
> which fits in nicely with the existing panel-himax-hx83102 driver. Hence,
> we add a new compatible with panel specific config.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
> Chage since V6:
>
> - No change.
>
> V5: https://lore.kernel.org/all/20240509015207.3271370-6-yangcong5@huaqin=
corp-partner.google.com
>
> Chage since V5:
>
> - Adjust inital cmds indentation and check accum_err before calling mdela=
y in init()..
>
> V4: https://lore.kernel.org/all/20240507135234.1356855-6-yangcong5@huaqin=
corp-partner.google.com
>
> Chage since V4:
>
> - Depend Dous'series [1].
> [1]: https://lore.kernel.org/all/20240501154251.3302887-1-dianders@chromi=
um.org
>
> V3: https://lore.kernel.org/all/20240424023010.2099949-6-yangcong5@huaqin=
corp-partner.google.com
>
> Chage since V3:
>
> - inital cmds use lowercasehex.
>
> V2: https://lore.kernel.org/all/20240422090310.3311429-6-yangcong5@huaqin=
corp-partner.google.com
>
> ---
>  drivers/gpu/drm/panel/panel-himax-hx83102.c | 133 ++++++++++++++++++++
>  1 file changed, 133 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

