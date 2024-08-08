Return-Path: <linux-kernel+bounces-280034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848BD94C4DA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C991C21E70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C673E146D75;
	Thu,  8 Aug 2024 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bszYXO0E"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB784D34
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142874; cv=none; b=gtLdArGv2OwAWcSn/yDsSo7IpxZ7ryZoXMej6pKJZwx3BEUcZyYlZrJVnbNnKXAfl7vkJ/+M0zlymUPdcsemc2KnlByKRqlvwCFealXZ7QD3fzz5ljRYAe+XFSLbKbgXb6fkGGbdWqtHFQ2kaQhY65GLLr8NRKZ4bGK2Ow79e/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142874; c=relaxed/simple;
	bh=DxAhgJ/3bbQzplbG8zkMxDwOCad591X4kdiUjx5+Qxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJuB4BK0Qmyq3ptouOWWMiQMYvfA8xyLZCb0BfMILpF0/G0rkV5ws0jhwxJDbcKKCGXalZMz5jU1N/vkd0v25dQoaPhi/zxVI9/Yj3K/wXTALFPofvazKwNeOH/LY8fJZ9XCVuo027mC5eQpYCQ8DQdbSDRgzisBycQwPo4HzsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bszYXO0E; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-261e543ef35so842769fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723142870; x=1723747670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aayk2Lttmn0wD83xXMa7bzpsBk9VzLksOrAAh6yDi/8=;
        b=bszYXO0E3sr9l1xf7+4I3OEHGnjeA560DeQCj7H/mDNGx2Jv/W3TOpk6LRoBedlBTA
         2pPDMk8CG/cNwgHW99sis4xXhkjr/Qwn9qC0uM31qHzC6kKN23bu9sQFQ/5QKh9M3dRK
         eszydkSpAWgKhoKDAqMNF0c0d14PubeeKODXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723142870; x=1723747670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aayk2Lttmn0wD83xXMa7bzpsBk9VzLksOrAAh6yDi/8=;
        b=FA96SkI7FhkUh2+i8o0ddky5+A5QIhYPt5DGoNm58jLK2gK8WvSyRsygN39dDPwS/q
         H/n6t0qc//AK6irxNxbiPiYipyitOrDJq23aTvCGldmaxkz7qDQWGfBdiFr0IJBq1EVi
         Nx+UiLHGWaL06AXXLdG2BtU5NipeKA1yI1kUAm79sJ97eljndgD0iS4fp/Tx/sLf9jHI
         DdASt2ozT5MpKwYS8mmhRE9cf4VRSMQdoOgKR8F5E9Pnzvaox6CrlS8pr4xVQ3xWfe57
         tDPvXx1h2We8Mu1ErQRz39heqFsI3nFZkvU/IJ6uzOezDnFA1pcfUEaKmDw9hn1zL9VG
         mPtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFLyU+B32xhrWW/5Auk3MMWZqaTeavBHQYNiR2qZNfzuD3xXqJDuomJKlG5DzIeQ5vH4IxWZv53oNT9bv8GO06rHj3ZMKfhmod9yUt
X-Gm-Message-State: AOJu0YzFCYm6AUtMBUmaem6y6T5bXyXZuVnj9Uqw+YqhHg6ye7Ma7EDW
	5ua92xKaaB4wrBuHoxNe3btOub/V5qS0q5joAuyhAtR4bjxVWyVh6ZVKQfPTJu8QaHkAIVZoyXM
	ziFJO1KBbRX7SaTMgx1UnOJ4Y1HAzv4zylMeK
X-Google-Smtp-Source: AGHT+IGcE9MOFmsH0Ui6LQ5gDODf1sP6ILA52lvJYyRoqrcSMR7DavF+iykCGMACE/oztRceFKqzbwHJtLPCcEEwgLw=
X-Received: by 2002:a05:6870:391f:b0:25e:de4:9621 with SMTP id
 586e51a60fabf-2692b69db3bmr3285147fac.24.1723142870500; Thu, 08 Aug 2024
 11:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808114407.1.I099e8e9e36407a0785d846b953031d40ea71e559@changeid>
In-Reply-To: <20240808114407.1.I099e8e9e36407a0785d846b953031d40ea71e559@changeid>
From: Rob Clark <robdclark@chromium.org>
Date: Thu, 8 Aug 2024 11:47:39 -0700
Message-ID: <CAJs_Fx7GN1_2xAM0Qg8oezQ2Foxy2smOXb3zMhNiJxCDMPUNug@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: panel: samsung,atna45dc02: Fix indentation
To: Douglas Anderson <dianders@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 11:44=E2=80=AFAM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> The yaml had indentation errors:
>   ./Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.ya=
ml:21:9:
>   [warning] wrong indentation: expected 10 but found 8 (indentation)
>   ./Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.ya=
ml:23:11:
>   [warning] wrong indentation: expected 12 but found 10 (indentation)
>
> Fix them.
>
> Reported-by: Rob Herring <robh@kernel.org>
> Closes: https://lore.kernel.org/r/CAL_JsqLRTgQRPcfXy4G9hLoHMd-Uax4_C90BV_=
OZn4mK+-82kw@mail.gmail.com
> Fixes: 1c4a057d01f4 ("dt-bindings: display: panel: samsung,atna45dc02: Do=
cument ATNA45DC02")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Rob Clark <robdclark@gmail.com>
Thanked-by: Rob Clark <robdclark@gmail.com>

BR,
-R

> ---
>
>  .../bindings/display/panel/samsung,atna33xc20.yaml   | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,atna=
33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atna3=
3xc20.yaml
> index 87c601bcf20a..032f783eefc4 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.=
yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.=
yaml
> @@ -18,12 +18,12 @@ properties:
>        # Samsung 13.3" FHD (1920x1080 pixels) eDP AMOLED panel
>        - const: samsung,atna33xc20
>        - items:
> -        - enum:
> -          # Samsung 14.5" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
> -          - samsung,atna45af01
> -          # Samsung 14.5" 3K (2944x1840 pixels) eDP AMOLED panel
> -          - samsung,atna45dc02
> -        - const: samsung,atna33xc20
> +          - enum:
> +              # Samsung 14.5" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
> +              - samsung,atna45af01
> +              # Samsung 14.5" 3K (2944x1840 pixels) eDP AMOLED panel
> +              - samsung,atna45dc02
> +          - const: samsung,atna33xc20
>
>    enable-gpios: true
>    port: true
> --
> 2.46.0.76.ge559c4bf1a-goog
>

