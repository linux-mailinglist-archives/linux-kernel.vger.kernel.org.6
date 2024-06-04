Return-Path: <linux-kernel+bounces-200124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA508FAB69
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395A71F23EB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5538A13FD9B;
	Tue,  4 Jun 2024 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NqNM5DeU"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158C913E888
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717483987; cv=none; b=rFwI4kPFkJAx6dviy5HWaSHhtA6TiMqcPVwC+Yh4z/1wvKnqiADurV5W6GcjxqNQ7SF529sXgT1TLrHRap7169t65jNIv0rCD3f3kvr/iRA2EeWdcsAGvr7SBjAsLw5dI+LSQumc7ZeUy048/fuRcCqjwKpZolsG+V4zgWGuqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717483987; c=relaxed/simple;
	bh=Q/s+/2HLOEshSXyevA+kwwuV9LKh61E8wNAoTbTnOcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsMTls6iVeTgjeH/u+A2Unw6MI+0EJdYY7CS/v5ah24ly1Xlmcw76tWh4MwcBuFnZH8TMxiONYIOsgiaQcCs2j2GJ+StF5zZl4H3eqjU4xcAhlt7/L64YSMbwLz+WJ9mEJNYhEi8Z7NumPmOr3Udt1/YFnnmIrqF1oEP94MOLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NqNM5DeU; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e96f29884dso6740251fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717483983; x=1718088783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxQuguER/BLQYm1ZxDJ/qSzZSNtAmQOi2t1QHj9aOVI=;
        b=NqNM5DeUKXfcBuHHiexLviXzsrj8yeBF8DLFI7inoLjekwHDBLbj9KnuG1hjzr/AP0
         dSqCRHsIrGOS5svJcLvUF7Egf2lJa2ybYsGugqXz2n02KLLxw/hKFQuENQ48SjwFbrR9
         Q2y/xw3JYOsHYcrLaAvSvmmGBVkaHzOBKyHatvpVnblES9/YlQGj91HhXPWIEyyeHraA
         sm+y02xkbqc7NBkM+OTdNXlpUq+XH+0vr4aopphqHMrpjLFV1mJwHqekAHoVzjyyYdYy
         Z06dDGmk7dIIu7fD11Iq9j4PHmyX6rH3vGqOvfxTxzuWcnt3zOJHni5hWscUvAu4XWfS
         MH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717483983; x=1718088783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxQuguER/BLQYm1ZxDJ/qSzZSNtAmQOi2t1QHj9aOVI=;
        b=HPOtd3/vnhF6vl4zEwFc+kGY6aaEUZKG5yzP3d/y7lhivfCsMG1cUL120gVNTPIYHT
         oxCT3udPk8fNGkNW1SewG1LcQEbyVr5NeohMBqfBCwXLI5tEB+A5C6w9GGWESLwaDbLi
         vt3QI97anaailsW6GCGSaaYd0SosonvcHtC31xsy56K1FO5Ob/J24wArI8UI2/ejSOAR
         WAe0PeToB6xtOp7wURCW0I2sCAvsuXI/OKX6ttR/3NhxgKU2lZkHN2hpD9ocxedZN4Lu
         T7ma92/Tm+axBkil+/4Qr0+YuFUw+u/biVcqtJIlaX6OQoPhIRlUbvQxpNzWEFU9oLht
         B9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVoqqDk8eF/pJfFW6N5dXSbx0bmfRS44ZjHOC5nmlSc0tQ1o6onoaOa3vqtoUpPJ8yZbRxUPeoeGuSv6EITgMgWgwmoZD5+WFrBwPV/
X-Gm-Message-State: AOJu0YyvzT2UFMjuNpJHJIyvAOqPL0X7/3z3m7nUjnIZeTrvlIgfegha
	+G2L2s689cuQGPJZ8IbAVdHfdNAfNEoYeb+lBwS4zGdlme6NfL8zIw25L1zqh5c1V3STtt2lRaN
	rmVw3rNKoL7GDDfM1bR7DMWKyVd2wBv5LsA4ulg==
X-Google-Smtp-Source: AGHT+IHggwyuAzryxCFutJC1tfJ+3ZKkr//fbN9+PVWQCSu4HBedgiEUAp7ppj5bkGkwiOXOwRFyEwgRUKUmWYk9oag=
X-Received: by 2002:a2e:9016:0:b0:2e6:f1f6:7dbe with SMTP id
 38308e7fff4ca-2ea951e1cccmr71890431fa.34.1717483982951; Mon, 03 Jun 2024
 23:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527144538.155704-1-brgl@bgdev.pl>
In-Reply-To: <20240527144538.155704-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 4 Jun 2024 08:52:52 +0200
Message-ID: <CAMRc=McurmN4Hs2MVGCjF0z_FX+84v0psGuTse0K7caSVF445A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: qcom,dwc3: set minItems for interrupt-names
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 4:45=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There's a set of compatibles for which we set a strict list of 5 interrup=
t
> names even though minItems for the interrupts property is 4. One of the
> USB controllers on sa8775p only consumes 4 interrupts which leads to
> dtbs_check errors. Make the last entry optional by setting minItems to 4.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Docum=
entation/devicetree/bindings/usb/qcom,dwc3.yaml
> index cf633d488c3f..4251dc25ee9a 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -468,6 +468,7 @@ allOf:
>            minItems: 4
>            maxItems: 5
>          interrupt-names:
> +          minItems: 4
>            items:
>              - const: pwr_event
>              - const: hs_phy_irq
> --
> 2.43.0
>

Gentle ping.

Bart

