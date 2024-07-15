Return-Path: <linux-kernel+bounces-252619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3E09315FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D76DB21763
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3C718C180;
	Mon, 15 Jul 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ViF5AEij"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5681E18C169
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050960; cv=none; b=KBvBkIoLnefFSUyFL/59Vqh5fikZ6TPlYJf+uC4gOXZ1IEKCQDWqKyq69mq14QtOYso4cCrPYN7ad7XDVxigWj0xPNH/IxzWVIDRFE/WiUW7jYrDfxuql4ML7Yhq0+Ve85sKeHA0il6TJJRtiuNZSmtTRFQ/B2ugc4oZwIAt/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050960; c=relaxed/simple;
	bh=HzMPkWVhLvPMul5I88EaLUU/F4JRic0tMeYJg3OIcjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Njc+496LGdbspxcHougeiavIsswCjnr7sQdlGRPrpsmhvjgSmfu4rUQyx7FznDxd/7fyx0DB5IQH+C0fD6OJSLXpDhO/ytBkcR4OwfPw7PbLk06jFYWbFD2cGy/qKVYmiylC2DbA/PNdjzcqdcD+Vq1srocxhg8/jEmwjPtcrYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ViF5AEij; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79ef7ecc7d4so271491985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721050956; x=1721655756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiHzmxhXegf8gKt2fPo1cHqasKjx8M8WTgWEINZ3dns=;
        b=ViF5AEijNNjO3OSZJtSd8ZVMS/AJ3+jv5BtwthuwUe/EEqsji6I9FpsJNSNUPGH+QW
         cd7D0vSKp/oXzmdD2JmuODjLrjHHlRsItDq0AABx3ncP5/S2J1rKHB6J6jSzFX8kDD7p
         714eRpO1f5Px+C+kX0fK1DC5oGG8TuG68vduY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721050956; x=1721655756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiHzmxhXegf8gKt2fPo1cHqasKjx8M8WTgWEINZ3dns=;
        b=ATTk3oORkjL+Uoebd3zYN6kasgJPsHyo+ELLbMTcQz8LZWfPw0ksJv66ahzj8ULJxt
         IBOSmBeCtnmAGxDTki4k7sPf/LehdfBTVS+3MgSvYeoqi/AVF8F0PIiwiVFnZumb6WWR
         ihirh2HMtbJkiOwig5+4xX69sQc/rc222omqfrw0jkj9jhYoy9T6T/qjSP8ZCqK+LGZP
         edtqJV8UmCGKMQFgqHdxDyvEU2/OG+a+kQMnZ16oqN7pZzfz4CUJgXIgNDFT/EhFKPjF
         JzGJzup1Pks82lXracXUaFuxh8QI3xT7AuXwWdoQzEFhNJhWQeALhL2pXo6pq3B6AQF9
         K7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWkzADkjdxIfUUNt+JeXOrkK5l4FKpEzbKTfYXO7LrL9DEgYDnuwDgcV3iqZdwpRNblDDDzkqaQitsyRVlYebj42rHtmDV9hcy+2bR1
X-Gm-Message-State: AOJu0YwL3ytH6kyMtner71+scQBgl02J6BiUDPdYC8o8jXdjV6Iwzba9
	S1okZ/35eHUGKDrI2LQNq7Qr+HzpMoIij+0qiguKYUAuGCreJTMA5EI0eCfxBM539uuCpzINGZI
	=
X-Google-Smtp-Source: AGHT+IFrjhQ7XbPt+gLftjtsPYH4J2UfZP+IAWdHSgrgOqaDUq6P15CiX63SAEfpPVLkRZ/QpLTK5A==
X-Received: by 2002:a05:620a:410a:b0:79d:6d4a:a958 with SMTP id af79cd13be357-79f19a9c7b4mr2549612385a.53.1721050956362;
        Mon, 15 Jul 2024 06:42:36 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160be3fc6sm201545885a.67.2024.07.15.06.42.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 06:42:35 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44e534a1fbeso462721cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:42:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpLBDkhOL05LD6VbLtLzN4Ki7S/v4/6+iGLEWA2R/9JlCcctGC9LsiLgukqtGOtv/945MI4afojWITh3omr7qsuS6LmuYDcrWiGZGP
X-Received: by 2002:a05:622a:5a11:b0:447:daca:4b25 with SMTP id
 d75a77b69052e-44f5a2f9b4emr5548211cf.28.1721050954554; Mon, 15 Jul 2024
 06:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org> <20240715-x1e80100-crd-backlight-v2-1-31b7f2f658a3@linaro.org>
In-Reply-To: <20240715-x1e80100-crd-backlight-v2-1-31b7f2f658a3@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 15 Jul 2024 06:42:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VG3zNVKp75r2zsKzmjC0WfZqY1xrffSQ+jcuAJm7FaQw@mail.gmail.com>
Message-ID: <CAD=FV=VG3zNVKp75r2zsKzmjC0WfZqY1xrffSQ+jcuAJm7FaQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: display: panel: samsung,atna33xc20:
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

Reviewed-by: Douglas Anderson <dianders@chromium.org>


On Mon, Jul 15, 2024 at 5:16=E2=80=AFAM Stephan Gerhold
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
> Use the existing "samsung,atna33xc20" as fallback compatible since existi=
ng
> drivers should work as-is, given that resolution and size are discoverabl=
e
> through the eDP link.
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml     | 8 ++=
+++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,atna=
33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atna3=
3xc20.yaml
> index 765ca155c83a..5192c93fbd67 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.=
yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.=
yaml
> @@ -14,7 +14,13 @@ allOf:
>
>  properties:
>    compatible:
> -    const: samsung,atna33xc20
> +    oneOf:
> +      # Samsung 13.3" FHD (1920x1080 pixels) eDP AMOLED panel
> +      - const: samsung,atna33xc20
> +      # Samsung 14.5" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
> +      - items:
> +          - const: samsung,atna45af01
> +          - const: samsung,atna33xc20
>
>    enable-gpios: true
>    port: true
>
> --
> 2.44.1
>

