Return-Path: <linux-kernel+bounces-246178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6066E92BE9B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8315A1C213EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF2A19D889;
	Tue,  9 Jul 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjNJ1Gz/"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85DE15FA78
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539556; cv=none; b=Ulhs5GgiAAmQJxZddEEx/nWT54AqWdFfTgzu+SdxDIrTis5s5ONapHVtz1UjmD8tK5nQWhDExLvSkfjFtTHW2bsk5+wQY/ULc5xf7DF8gIG2iJteJq5B/1LfNrQhTFej5FnDcIeQ5P76t3FupMvtmMp8veuuPJLz6eGeONdL+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539556; c=relaxed/simple;
	bh=iM7dP4+UBWQBZxTzBsXQgEJRsca+txEglysSJ98yCAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yja1IsI4K/KthRmknqY6Yx3iMFMIzKcOzqeCEfbTial5i3lX01RJbPY3p20ixCsrqIfun0XxDQW5LPXhwKuDfuqZ7ixh3OHZgAb2S/SR+ff40o47qSKIf1uzVQCjWE7KXiKbnEc9kwbM9EoWX7cXzeEuDZaCfPlFRzXluxZi72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KjNJ1Gz/; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-655fa53c64cso30267497b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720539553; x=1721144353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf9OSDzYDVAe/q1Sw42NKjpmTZk3nIkNTh+ppL03zVc=;
        b=KjNJ1Gz/Wgbxl6/8xucIIB1ZotHtguC6thJahNV3n4IupooYfrg2/HIrRd2jgdIhtp
         zolPDQD08zsbQu4/rJ+a+Mg+/kcauSQGw1WN5uaFw2h+9Xt++v6zd+oGcLI4BkxG/QQP
         8fSibLSzgPW6y0kS/NXAEhibTb1bj2+Xou4WLZwUnd7oDIwWE3wd56Jhvv2lsAF4RlFg
         ArQiDTvZc7oNSYb+buDoLY7mgKAjrgAswYWU6iR7VpXjdmrc+mioEg+4vnuA4p+AzgLN
         DdnKQPW+iNBc2zyvKCKfbx471FPwGveQmaKOgBpXJcr29G3pehl70CbEMbuJ+9F+xKa6
         v77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720539553; x=1721144353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf9OSDzYDVAe/q1Sw42NKjpmTZk3nIkNTh+ppL03zVc=;
        b=dX7y+50ERLWioPTxL4OFe2Psg90Kdn9L3fDJ1j3/hGMYwD8pcVHyZzDPFz/DxilIn7
         PUOUWVYHfIZAULa8QodMp4EkWYKqgITe9Dx/Um6KbNk9zAfjgsP+I3ZXCz1bClHRiyaH
         Lv0vEdlHG0l7/cToIh0wcAVlsOUxACUSJHWJlRzjsji2wbFdp7bmj6SQz5eU6Orp8D0J
         TvebkRrN+NlumguhRD1B5JedXbtFSWejthR8fwvxYTfxV1mgt21+Gn8dWNHWS10vXhr0
         0blY7madMJwEIflTDAeSWr2eyO/i0TglpVVASpJcchMdNZihtXAFeTKhQwyD/nHkQJtt
         p5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2jQ6F0bwFoF4kJpFj0DpOHSoJoxy0mWcAyUs6f64696Hx4UnLpEPhlZH0909hO6WhNx7XrgFGDvr6zevKXbimGBM9oV7ia9W/E/RW
X-Gm-Message-State: AOJu0YwEs6suRPL0c4y9/Qug5Yt92Efe7Y/rWUmft7j+l64ygFD3p9yx
	hjwWPBiFrKhm0eJaY7YUgQKpvDP61snVY6M9/WIuxk6wHegBL3RDdG55o7IKDpKVLI84y3zefbt
	VLfCjKeRN8Cpn9C1IViz3MTscyeqrJ6QUD97uMw==
X-Google-Smtp-Source: AGHT+IELN6BrB1l1a+7hxJEdA4r49wyMBZ63w0/xGG40B6OA89/EbeiJJj84Igc7BT/S0i6zEg+VHQ94rm+Er6yb3lk=
X-Received: by 2002:a05:690c:6681:b0:64a:4728:ef1 with SMTP id
 00721157ae682-658f02f5ea0mr39620207b3.39.1720539552828; Tue, 09 Jul 2024
 08:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709-add_qcs9100_tlmm_compatible-v2-0-d025b58ea196@quicinc.com>
 <20240709-add_qcs9100_tlmm_compatible-v2-2-d025b58ea196@quicinc.com>
In-Reply-To: <20240709-add_qcs9100_tlmm_compatible-v2-2-d025b58ea196@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 9 Jul 2024 17:39:02 +0200
Message-ID: <CACMJSevpinkT+jFTK6ijpRF2ULEeAFiWLkWEmQ6bJfJdofyO8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: add the tlmm driver support for
 qcs9100 platform
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	kernel@quicinc.com, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 15:05, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>
> Add the tlmm driver support for QCS9100 platform.
> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
> platform use non-SCMI resource. In the future, the SA8775p platform will
> move to use SCMI resources and it will have new sa8775p-related device
> tree. Consequently, introduce "qcom,qcs9100-tlmm" to the pinctrl device
> match table.
>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-sa8775p.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-sa8775p.c b/drivers/pinctrl/qcom/pinctrl-sa8775p.c
> index 5459c0c681a2..4687e11dfe75 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sa8775p.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sa8775p.c
> @@ -1519,6 +1519,7 @@ static int sa8775p_pinctrl_probe(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id sa8775p_pinctrl_of_match[] = {
> +       { .compatible = "qcom,qcs9100-tlmm", },
>         { .compatible = "qcom,sa8775p-tlmm", },
>         { },
>  };
>
> --
> 2.25.1
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

