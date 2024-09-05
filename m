Return-Path: <linux-kernel+bounces-317042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ECB96D889
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123831C2130B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7538819D06C;
	Thu,  5 Sep 2024 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAG2FSu+"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76C19D066
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539247; cv=none; b=L/Et31tW7L1QdSwmzLgCafn3nKNPnQZWWZQV/vjF18uGPpsVXaIzs73kZAjkxayalcW6yz8Jhuz+3iEK6yWBTeOkcn1+fqsBmcaV2NoCxmEdg7IIr9bP2bbWmx6bYhlKVTClXiKZjmbRWzhUTo+bBSHlT0BEGt/4NJmSk0WUUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539247; c=relaxed/simple;
	bh=4GL4wu0MXv5Zo32mStDpWO7XiaxGz/eqw951ir/jrpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Df3zFkXAtu+vj7ovcIqPeerzGQIsKi0ZzJtvehIGOG1Q0H+BmaD9qKf78M++29Kd3xFfqLUWsJEHcbN79TEKo4gSzaxqvYgLUhwzvLMR4lonCJWsIaAe+amE2cG7eG5HqK+P/nX8b2P5JSqSdg+LfZeGa8ZNqiO0LKJnQFGQ1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QAG2FSu+; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-699ac6dbf24so6301677b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725539244; x=1726144044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IpuELiuDCnG9ORAqJlu7U8YtP7sU10a0q1Q1XH/Cqew=;
        b=QAG2FSu+AGeFM1z8wApc0EeiWKLr+FukS/3zK+qYFK169R8JYmCkkevrZEWbcgqhTY
         c/6o+aefarwz5urCbe4699RG+4TmMLsuWsTG1DLTkSelh5u31YNOs7fh5yG7Sgqmw4kQ
         m1XViLw+7aP6Hm3phUwr+mtSpjI8D4QVmJJZi7QRgK8ut2ZzmnDVnGhJGi4Fauisn3Q0
         sAH9IbBD9Jiyq5w4dgz4QnxHM4ISClgvJS+qomf+x+ecfRZnkLu295r48S8ppPiEjsII
         l5JuLqxgxt0xe50CuZ3d/pWFRlC6v5z+82UHDbY78zeq4RSpD2I4/KO0D9yJyCWB9/cr
         Idlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539244; x=1726144044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpuELiuDCnG9ORAqJlu7U8YtP7sU10a0q1Q1XH/Cqew=;
        b=V7uqNMAS9mi1XlW9tGRZtSfjLEXIkmlQPgttQjltmu5RoWL3ya9k72EU2AfLhNZuru
         Iyp/6BGAOTERlaf54gnsH+g+nK0KFiOErawuks+WQjwqTCz1XnBxG/dtfGBEaJGl9KAM
         IIEuZN27pK3OleylyvHS08EWTBWwJ9eXlVGCZDxcyjSYzHfIHzWmgQv7WOpVHRm05i3I
         BJFQY5YouckcwrokQk4N+3WXuwgZKFQaSb8Tm+5nTC2ygt/lzoOUSnCN7zRtdOPjNbCD
         RBtxIF8U/O7zwzqVnf5I5peooxBkvzpYoKnEaWVUnWI8RGIcNihcG05ltlbRCXTMNAuD
         Hskw==
X-Forwarded-Encrypted: i=1; AJvYcCXNfD0UJlJZXD6qzhTNjItNncGjnfdA0GFzIC1Ii7neuU5IqCipYuAFLijQpNKj/S/5WGDJbfcgGKwJe9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzbxuLqDcJlg44L0ymKP1o6/Ou/yA47OtiJqL6o05FABVRUjjB
	JZn8rcRz2RurfRXUkQFaQ0e1JTlVIU9V5dwyY4GDqNqUY7fCXPcm3ZvSX49dyywirxyZsDpWcxC
	t5SigtdwR5fbVcBzBPb44b/Uwt38vcER3vfimlg==
X-Google-Smtp-Source: AGHT+IEipp3nFbghziTxQBlyaXZKzf9SpRdRpCvdn45rRKpyvNaBOhUVm88FSmPAi+h9oMcNOuFo+w8gOWxk5tjCOY4=
X-Received: by 2002:a05:690c:d90:b0:65f:d27d:3f6a with SMTP id
 00721157ae682-6d40da7efecmr224769407b3.7.1725539244170; Thu, 05 Sep 2024
 05:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905122023.47251-1-brgl@bgdev.pl> <20240905122023.47251-4-brgl@bgdev.pl>
In-Reply-To: <20240905122023.47251-4-brgl@bgdev.pl>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 5 Sep 2024 15:27:13 +0300
Message-ID: <CAA8EJpo2-P8N92XFRYszbZwo1gDbRPe+O=THafxWSbk1ZH-BoQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: sc8280xp-x13s: model the PMU of
 the on-board wcn6855
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 15:20, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Add a node for the PMU of the WCN6855 and rework the inputs of the wifi
> and bluetooth nodes to consume the PMU's outputs.
>
> Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 98 ++++++++++++++++---
>  1 file changed, 86 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 6a28cab97189..88b31550f9df 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -400,6 +400,67 @@ usb1_sbu_mux: endpoint {
>                         };
>                 };
>         };
> +
> +       wcn6855-pmu {
> +               compatible = "qcom,wcn6855-pmu";
> +
> +               pinctrl-0 = <&wlan_en>;

pinctrl for the bt-enable pin?

> +               pinctrl-names = "default";
> +
> +               wlan-enable-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
> +               bt-enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
> +

-- 
With best wishes
Dmitry

