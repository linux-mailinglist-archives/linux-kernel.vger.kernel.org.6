Return-Path: <linux-kernel+bounces-248032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5354692D78A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD37A1F24A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4E5195385;
	Wed, 10 Jul 2024 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dTd9390j"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839F191F8E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632951; cv=none; b=YJG736sFKPiSBlpNt6QqJhsFTa+xtMH2zQums+qhfkR3LiiU9Q9yFnxO6bSlLfZCzK+jYH7Puk98HXAKOMuNfSyTszbej5+5/FNuJRDbw/O/P+tkaqg9mPLxszaJDY8pThlWPRgkb8B9FPt2GJVUxqenDGY+FUuhzAX/r8CAsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632951; c=relaxed/simple;
	bh=qUtJuf7BpW7416xCDEnMAZ4qpPxi046SuSivO4rvOIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apP0GHaQhQUi+8SJy8Il5ooDgWy6ARP2neFBe8S8cD8/781mxC+q17xId3+eCXk/N7DspchpwzM18UluvTSXxEAawkm4UaCtN49I/AhjLcjuI7+G283GL1DPWZJlUnUy2sEzogXB8EtC4Zvsq1KwvkAlZqHaIuTyCUz7oqt3/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dTd9390j; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70360eeb7d2so2945274a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720632946; x=1721237746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq9tNUhoBsUEDC1UEIUaCv3t+k06QOX2ENZA+annY9M=;
        b=dTd9390jg/D/SmsKCxxhn04a7hRndu21txgY9l77A9b0DPU6V1LKaokKpULbIb6tq6
         Yv0ZaI778IJ/HFBOSMNHcR05d9NWDbwRunfJH5QwF71QjN2V5SQ5FONfHB/nT5AeFPGi
         A/cHioEtG9Y5tdXDCFuV2r9s5PF1mlK5J5QPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720632946; x=1721237746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq9tNUhoBsUEDC1UEIUaCv3t+k06QOX2ENZA+annY9M=;
        b=oQGKIXjlwzw9AVHTP4e0kbPAzcNUf85MCjaUfA/cWJ2f8nfPXqjHEuq41c9hJgn5V4
         mgl43pcCFfGBTjKF0k16FVj9/wzpqBn4d42sTtPOorS2WMKUX8YBqVl8N52wWlgKaBOI
         jwjfzwxj5vHlnN7OsW/pv7YQ/49jGT6AKt6fYq911plw9ZeuhIOW1mNlwscmpoBw1R2m
         iOznS1n5IibR4kriliYF3ViE7XfFMPDp3p/qZY8HnXBAel6x6qEa90PlqxAoK3szl1XO
         Tf4kAus6kO2wBNSZNYx/PsSeaT4O62SrafqrgXvAZ6Q6u0Y/F9HAxAvTW/QXhVbtlNh9
         xcsA==
X-Forwarded-Encrypted: i=1; AJvYcCUY55i0BO7aHNhz+wvvv46niAbrIO9ZaGZGiFX0lhC6/OaTWmOaSQ64fqplZ20y6A7LSUJbr6x+0y5eEgjbxfTxOWpsfV4SL5Vqne/9
X-Gm-Message-State: AOJu0YyzloC8ENKA2x3WYhljNHHwlWdRsUX+JN9GyQofoGXqwXVSlkQO
	Ow0MMale1vxrkdZiOvNAAAgyT5+1DIzVA7X/F5ey1bS0MyuYRhrdNRihuTyjn6p5/3HvjpFiqeX
	JYQ==
X-Google-Smtp-Source: AGHT+IFBJTf5d0mcFgPTo6uizkn2ppYgGw3RKBRrfO8YnhwA0LhIzV5baNtGY9mSfYL2ow04sU3Wmg==
X-Received: by 2002:a05:6808:189:b0:3d9:dbd1:88f2 with SMTP id 5614622812f47-3d9dbd18bb6mr2457081b6e.16.1720632945663;
        Wed, 10 Jul 2024 10:35:45 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff80c7sm214988585a.3.2024.07.10.10.35.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 10:35:44 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44a8b140a1bso24451cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:35:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1fNyJTCr1eTJbSAMwOaLxLFFwG3ln6Mwv2eb0n42CwURlCBLWcejGE4Qc1RFJkfWLHfyUjxsHDKxT+jQFgOz4cA2VXUqwJQYDYM48
X-Received: by 2002:ac8:5399:0:b0:447:f3ae:383b with SMTP id
 d75a77b69052e-44b1a14a434mr3218051cf.19.1720632943866; Wed, 10 Jul 2024
 10:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710-x1e80100-crd-backlight-v1-0-eb242311a23e@linaro.org> <20240710-x1e80100-crd-backlight-v1-1-eb242311a23e@linaro.org>
In-Reply-To: <20240710-x1e80100-crd-backlight-v1-1-eb242311a23e@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Jul 2024 10:35:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJuV12mStW3eUm5MHG8BA9W_fn0skN=BrtmqC+fnCZig@mail.gmail.com>
Message-ID: <CAD=FV=XJuV12mStW3eUm5MHG8BA9W_fn0skN=BrtmqC+fnCZig@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: display: panel: samsung,atna33xc20:
 Document ATNA45AF01
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2024 at 10:05=E2=80=AFAM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> The Samsung ATNA45AF01 panel is an AMOLED eDP panel that has backlight
> control over the DP AUX channel. While it works almost correctly with the
> generic "edp-panel" compatible, the backlight needs special handling to
> work correctly. It is similar to the existing ATNA33XC20 panel, just with
> a larger resolution and size.
>
> Add a new "samsung,atna45af01" compatible to describe this panel in the D=
T.
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml       | 6 =
+++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,atna=
33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atna3=
3xc20.yaml
> index 765ca155c83a..d668e8d0d296 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.=
yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.=
yaml
> @@ -14,7 +14,11 @@ allOf:
>
>  properties:
>    compatible:
> -    const: samsung,atna33xc20
> +    enum:
> +      # Samsung 13.3" FHD (1920x1080 pixels) eDP AMOLED panel
> +      - samsung,atna33xc20
> +      # Samsung 14.5" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
> +      - samsung,atna45af01

Seems OK, but a few thoughts:

1. Is it worth renaming this file? Something like
"samsung,atna-oled-panel.yaml"? I'd be interested in DT maintainer
folks' opinions here.

2. In theory you could make your compatible look like this:

compatible =3D "samsung,atna45af01", "samsung,atna33xc20"

...which would say "I have a 45af01 but if the OS doesn't have
anything special to do that it would be fine to use the 33xc20
driver". That would allow device trees to work without the kernel
changes and would allow you to land the DT changes in parallel with
the driver changes and things would keep working.

...and, in fact, that would mean you _didn't_ need to add the new
compatible string to the driver, which is nice.


-Doug

