Return-Path: <linux-kernel+bounces-430778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5749E357E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D08167F58
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D915B192D6B;
	Wed,  4 Dec 2024 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKEAdfmq"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB6194147
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301196; cv=none; b=jQjLU5ygM6MPGPjUQp8puJMHfI6Hc+bMs+iKM9J+AhIjW9bA7Aqi1yPzFSm0rh3FlVFg2Mg5Lf077EW0WC9UthkcJMxbQie+YXOe4YvdAObK3JHUpNzDf4jU9n8tGgiNjEzINrGc0OtHAOiIXn4wevu0PFrH14yzwG5yf7mH+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301196; c=relaxed/simple;
	bh=M2eKzihSk3zbwqoKclOvGsiEA5sAA8t8v+QDneKkB3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k93Zx1X4PTtySSmhX0s/lZhn28tylQDz1q6HKivFmiiIsIbyEtcjwXWJFw4BXwI4ZgnLIqwkhOef7DMU7B9JRJe7cGHh3NlOKT84k6lKr0oSVLaWmAMnksXIKRoKcU8/57iiHpOMt9PyYeLoU3Tu1q4hmGHih/KzTRYEN1hm7Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UKEAdfmq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so58550655e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 00:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733301193; x=1733905993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0QxTyPXrbU54XhvjWQfoHpd062jsI/RF0Hf0rs28i8=;
        b=UKEAdfmqSetK47Xx1WcUn7Yr2shYmfYvV+/JjXBF+f741WqDt3W4gmGSL8OkffN/hD
         3DISG9Kv8+nEGytaO0ztJ3UrRZqP2jeF8XL1V73J61YYmxJ/BhP+MzuegtjPKrpjkLIQ
         Ss/q0q9cQYVB9FYhoraigz7/ckWtSGoUGq4fnFFqESLQ05LwhGP2SSd3cDJTxn8YGDdA
         fvqx3Dej2wPsETbNM2KLSQGqspWpJgSVLfUDxcFgB742psW1vL2YWUwhe2GfMNWZbF+n
         oFcycxhVa3YhZGXIPEHkPpWItteqzAPE6Jn67SjGG6OjInXCeFC65TZWKLC8p6GYYz7W
         TpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733301193; x=1733905993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0QxTyPXrbU54XhvjWQfoHpd062jsI/RF0Hf0rs28i8=;
        b=P9FbsU3U8jlguh04mgOLSIcKY6CrXLEvhzq0lTPcR88M75pITc3MoVmjH4dvXtx0ME
         AEjoxZV1ia4VjLlbG/+H4V8S2lEKq14NBQmTQodNlZZUFJytzlBhoEKAat+W8Jq+/big
         yQ8NOedw+Ndl4gA9rKFrm9VXlMUD8CeE9IlrM0iZV85JNm+gCXsWht0EVpY0lExyah0D
         ewzapVUG1DN501HqLcANQcOzKejTOaUDNImJUxLhOUSTRe4yKcU8R4XNuT2U/u4je9Wb
         O/S0RxF4p3W5ZfPqDqrvE8MlQodaJCKst/kafgQTDsCCcXPZO2Cxw1kotG3m+eNPUD7o
         tyoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDjCsR2gXLVg3R7C8PLWiNNLNTmMXVibc0pSx8atkCA0LvJLAXXFXvnjAgMA6pRzqW8AW1dKhwMaBN010=@vger.kernel.org
X-Gm-Message-State: AOJu0YwstixsNpEJz5jf+hfqKyu/155kPDb1XH64A4laDuFVAD5DtgiF
	m3nU6zg7JqAu70WcQckKnHufvQfs3l5uMnUk8Y3lj9VA5WOZEoAXhdGynTL8dEF2H9pbL2OegnV
	z19g=
X-Gm-Gg: ASbGncuDky20ZI/sG5Xzo9pfRVB8hNojsiTKSjM5GvTZvf44p4eqHci8uaWMxnnDzi6
	TRpBlzLpCReX3jcYrlcVcI9bPBj5HUzWpcCJNek4n7tSl2v4cJduiCLqijuLN2aSPkwOpoNwASS
	KiMw6WBL8V0OgB7vKOnYSTyqjuiKk1EceE7X8f/ZX0JAxz8oIoxlGEEwHnmeoXpmEsFMPa6RybS
	1S3wgSmhyzPEWymoldAtNLzsLjAZ5QI5rTnotH3HKVCRVKgcYewfcZDxQl6oQ==
X-Google-Smtp-Source: AGHT+IH/7NRyoCVatSSiPzY0lDOkM5NNriw1/JOeMDKXPeT6FeWVOrUY6eKDYQWOZSPdNThD4dF1gQ==
X-Received: by 2002:a05:600c:3509:b0:434:9c60:95a3 with SMTP id 5b1f17b1804b1-434d09b50b1mr47760175e9.11.1733301192760;
        Wed, 04 Dec 2024 00:33:12 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:9a15:2a41:210f:f75b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5281229sm16285055e9.26.2024.12.04.00.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 00:33:12 -0800 (PST)
Date: Wed, 4 Dec 2024 09:33:08 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100-crd: Drop duplicate DMIC
 supplies
Message-ID: <Z1ATxAsXFhQraQwH@linaro.org>
References: <20241203-x1e80100-va-mic-bias-v1-0-0dfd4d9b492c@linaro.org>
 <20241203-x1e80100-va-mic-bias-v1-2-0dfd4d9b492c@linaro.org>
 <f65e1559-b409-4906-aabb-eb24b5b0fcf2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f65e1559-b409-4906-aabb-eb24b5b0fcf2@linaro.org>

On Wed, Dec 04, 2024 at 08:20:15AM +0100, Krzysztof Kozlowski wrote:
> On 03/12/2024 18:44, Stephan Gerhold wrote:
> > The WCD938x codec provides two controls for each of the MIC_BIASn outputs:
> > 
> >  - "MIC BIASn" enables an internal regulator to generate the output
> >    with a configurable voltage (qcom,micbiasN-microvolt).
> > 
> >  - "VA MIC BIASn" enables "pull-up mode" that bypasses the internal
> >    regulator and directly outputs fixed 1.8V from the VDD_PX pin.
> >    This is intended for low-power VA (voice activation) use cases.
> > 
> > The audio-routing setup for the X1E80100 CRD currently specifies both
> > as power supplies for the DMICs, but only one of them can be active
> > at the same time. In practice, only the internal regulator is used
> > with the current setup because the driver prefers it over pull-up mode.
> > 
> > Make this more clear by dropping the redundant routes to the pull-up
> > "VA MIC BIASn" supply. There is no functional difference except that we
> > skip briefly switching to pull-up mode when shutting down the microphone.
> > 
> > Fixes: 4442a67eedc1 ("arm64: dts: qcom: x1e80100-crd: add sound card")
> 
> If there is no functional difference and this is just redundant, then
> there is nothing to fix, so drop the tag. But the point is that users
> might want the low-power VA. You claim they don't want... sure, I am
> fine with that but there is nothing to fix in such case.
> 

The fix here is that two mutually exclusive power supplies for the DMIC
are specified in the device tree. You can only have one of them active
at the same time. The Linux driver handles that gracefully, but the
device tree is still wrong and IMO deserves a fixes tag.

The functional difference is that we skip briefly switching to pull-up
mode when shutting down the microphone. Users won't notice that, but
it's not the intended behavior.

I don't claim that users don't want to switch to the low-power pull-up
mode (VA MIC BIASn). However, we would need a different mechanism to
give them the option to switch at runtime. "audio-routing" just
specifies static routes, so the current description does not allow
switching between the two modes either.

Thanks,
Stephan

