Return-Path: <linux-kernel+bounces-237649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189C0923C1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F191F25639
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772B515AADA;
	Tue,  2 Jul 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PX+uurSk"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4F64CDF9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918627; cv=none; b=hXRJIIZ+BJF+9YjXXEJPtg2arPu3OgJurGZVBRV5dakQ+jXFL1o90ZwOxjZHloEucrrgynu3lbLSRpJR2DgI/fIrmsOJXBEj9tuStGNR4FlSukYbG4j9DAu65GZkOk5SJzwvDgJlTsxtasNd3aZLnb0qSEkLtFk2GtXx1Jz/rog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918627; c=relaxed/simple;
	bh=SfEjw4cFfxixrvq6qtIfO/ZWv+HyMAbCOPeV0PYn3fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwwnlZksatofxTbpqKRxO3vfGU/1swvZAtILkkFJD3UeScfE5WfbfKcNCBypKZuLPmKbG57bzJRR6ihC4XVTpdIxiw6gfqlKtcHtCt3jnmj9mDQ5nuLSPtU8viLd6e40t7DbAks+7CRo41Lj/UkH5R1XjAw9b//Bh0fszhyyknU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PX+uurSk; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cd87277d8so4164434e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719918624; x=1720523424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUL6InU1s2oamDAjQ14QR1sgjo5CD0g2L+SSERlRdFs=;
        b=PX+uurSkYHA1OXCMSJiiocGz/VMb6MGfNCpF9I17uoPpoPG6CXxgi5NMmn02ea5UiC
         UmGyUuKbwePN7euLN7YLoRTG0ZJ43SIhKLyMnzZnG93mXMzM0zrkZkZTK84//LLAYrOn
         fKn3OUHgPByZjw6vrwr73varjOKs4lBK83v9l/KkWgraRvLgw/brJz/+DBetzxe/v33n
         JC4MXeaSJ7XU0+aYgLx8626K4HXBi/k89ZBlSTlSXlcLaujLorWpUvGmnkCjNP4Wxt3i
         waayR4dzXvH2SB0kyEggRy1eH9QccRjngkEIsKwxU6E1U5E7O2GYr9DxVbbRpqeS1BMq
         i05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719918624; x=1720523424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUL6InU1s2oamDAjQ14QR1sgjo5CD0g2L+SSERlRdFs=;
        b=rRl8NzHMmRAD9qsV8p9PTnzDZzQEL8h3YvqBaA6QelRohhtUqU5ucCOV+bVS5kqDZO
         nfiWmIdfuflaf0sYuDb5uBlIJTTIV0hdt1FFS8jG82VE+COP8TCXkFrPycrsTUb+gZmg
         4zBo9IHr6AySNfWayhmHbrvymmZADd89QOMgONbOrulPNDYZmmmuTBcSkYTR+/tY4DLu
         teRf3oN7AnL9fFgOMjqvbJLoB1YbCQVRGq49FhN6nSa+GWmt0YCluV3l46jXeI8EexSy
         w2zLRgO/FSsNLtt3hdZwPPXLyBYtOnqcSej1iFf9tKlfPeD3SzzILub8XWnhNVBA65fX
         2/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8tZaQBSVwa5Q26YZtCYHrmQJBPwf1yMDZ89mZO2CJHAysnFh6i+Ps/uNMJH/5t6lFX/5mKefKoAIaBdzJV7Z5gjKGKkUOeU8NGPmj
X-Gm-Message-State: AOJu0YzwiRx1vLVNFKtrrhtJvBJ4ksV5OegAx5bINfTmv+JJt6cD68jL
	enGVSOdDpIbW97TdIUiB4e8pPHu3OOz4C6SHfbe4tYWgESe492zdbLlJj4vTJPA=
X-Google-Smtp-Source: AGHT+IHsgF9I8uZJmqTmWCz+zNt8GwFkL2X6pxZhrZeGft31aGGDWcnY7hGJ7WQ7OHecVueU0YVRJA==
X-Received: by 2002:a05:6512:3996:b0:52c:a1ad:18bd with SMTP id 2adb3069b0e04-52e82651a88mr6252854e87.6.1719918623990;
        Tue, 02 Jul 2024 04:10:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab30a68sm1775997e87.242.2024.07.02.04.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 04:10:23 -0700 (PDT)
Date: Tue, 2 Jul 2024 14:10:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Amit Pundir <amit.pundir@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, 
	dt <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8550-hdk: add the Wifi node
Message-ID: <he7q4mzj7u7t3c4pndu565m727e6hqpf2srrqgbdltjdffugdl@x3xrwteqpki3>
References: <20240702091655.278974-1-amit.pundir@linaro.org>
 <8ba07bbf-e8b1-4244-882b-ff2575368b20@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba07bbf-e8b1-4244-882b-ff2575368b20@kernel.org>

On Tue, Jul 02, 2024 at 12:42:02PM GMT, Krzysztof Kozlowski wrote:
> On 02/07/2024 11:16, Amit Pundir wrote:
> > Describe the ath12k WLAN on-board the WCN7850 module present on the
> > board.
> > 
> > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > ---
> > Kanged verbatim from 490812872449 ("arm64: dts: qcom: sm8550-qrd: add the Wifi node").
> > 
> >  arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 97 +++++++++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> > index 12d60a0ee095..c453d081a2df 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> > @@ -279,6 +279,68 @@ platform {
> >  			};
> >  		};
> >  	};
> > +
> > +	wcn7850-pmu {
> > +		compatible = "qcom,wcn7850-pmu";
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&wlan_en>, <&pmk8550_sleep_clk>;
> > +
> > +		wlan-enable-gpios = <&tlmm 80 GPIO_ACTIVE_HIGH>;
> > +		/*
> > +		 * TODO Add bt-enable-gpios once the Bluetooth driver is
> > +		 * converted to using the power sequencer.
> 
> I don't understand why hardware description should depend on the driver.
> Either you have this GPIO or not. If you have it, what does it matter if
> there is no driver who can play with it?

Then there is a conflict between BT and PMU, which both will try to
access the gpio (or at least the pinctrl).

-- 
With best wishes
Dmitry

