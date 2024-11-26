Return-Path: <linux-kernel+bounces-422253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B19D9677
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30164163A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE711CEE97;
	Tue, 26 Nov 2024 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKBV0blt"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1431CB51B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621772; cv=none; b=SSqRAwb0/cLEJeyRU9Q07E6CW6p8EFNO8av6HaJjOrW3inzx0CPXOYEAeOTYQc/F4Mkapajg0r9PErH4n9y2k6DX1qA6zhB/2VWD90syCrDDJIxREEP86keb1mYM1lvqBEV+Z58syttRlZSGLGMcwRfMOgWtc6rIGZXvTzm+IWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621772; c=relaxed/simple;
	bh=DWw67zE2lJp2DCEzhU+vtzbe6cSTq0sENaYdnpP0uZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJtpCXT4lu23RKJsPYKvjaBHeXAIhjePVI7RsFUXYn+/OCiu2ttMFlV91EuFYUWq79gS0X382cIgNsveIveEE0ekzGybgA2yaiOtTvCxvQFcGYkyHuaZngefdvFnIaoaqIU7W6WbZ64PS3yqi2E2l3cDz3F+TY0AIi5fiI60QXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TKBV0blt; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffb5b131d0so31400801fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 03:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732621769; x=1733226569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0808uU3LOgHtR0xR0Opk5zAIVpmbB5OAomrT6pxSII=;
        b=TKBV0bltDmspAG7iSS+w1kD5wxJgo/T5eqP1+o0DirQ4d+PtiBVJ23fu5RT6+Q+ZtK
         qob4kY8VWuAPkFvSBL7Xmbfj4mBN+amw+IturHQgPDbp2keJzN8LQazsucF5DOsAo3Jh
         3OnzuSoISo/USTyrnXfz/TR7m10c7y/zXPht4nx4ZT6bICj3xOJ7hDF0fOlmbjedh9X0
         YXhkhjBpvzpqnmOL+DPk9LI9g9WP1yJBuU0wEsvO6HBX4TPtbF2tTu4td1tV0IAtYZNZ
         7yDKrL1nNiqjdbyBh8NvvRTAtkhB7YQrSwzXYrplOz7fOcvCB8VFIpAqwy7KdZPq7LGm
         1Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732621769; x=1733226569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0808uU3LOgHtR0xR0Opk5zAIVpmbB5OAomrT6pxSII=;
        b=W76cOTYZx8O11o2df1QMlzaw8mo1iDmB1+FnVjRnbmXKcFhrDjMrBP34jqZdBaMgpb
         /GJ0XLYs5IchcABCnTXvKZXXyY94Bi6nHrd1cLtEBKAcd8HXZmSeqSIS1mFZ+EwyPtid
         IH19PNj4ACbP3yqJYZdQKfBkqJWN36a2rclgakLgfq1/mulkLk+NMatgWgQa5VT0WJMy
         O0uxHYqkjnjXEzLr8Bntw9HAf2lKJDk+aYVSpzSAlKOlbUAEmEl1OJ9WYkJTVNImY5rs
         Lngp+mCidTNJgo2eUIRQxb9XV8CK7kIvG7WkqtJl93W9OfR26qCddAEtSSMK93cp81kT
         p5fg==
X-Forwarded-Encrypted: i=1; AJvYcCUugFwhHsat7ZKdJM2OAQIoxoyrHPiYgqeBxkJT+Jf8fEjpQgH/48QFuVxRTl72lfUYZeLJIoTj4ZsEKkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXADBgzp4ANkVoyVmPgBAj84Kn5FvLRkS4FE5Autj3v+e8qhd
	2SnMLxwJ4HBnWdl5ZTfK2viEbtmQIdQhgWwXFB/2iIuouidKWyBy2fGukJGo5xI=
X-Gm-Gg: ASbGnctciAr6iwEeoXsU0+jG3m72KJwbtftHDRvH9qJSjEbIIDuRPEPmk3oMT3F63lS
	VFl9Vw1VC/wzWghoKV0OpBF47IjruNZ5AxQkWG/Qr8ZoEZBBIZanao94FIaOE6HdKXGwxgO8TZ9
	aiRUsDq2LPdRFgRwt1NHZvM8b0tjW5cqsp10PPOaZUg8YyVAVRPG4YyLcrgc63Hgn7QDe4qrTyS
	gihZlHJPncUGXHiPyaqaO1R0l+jP52zX3ERaRovyWk4bFZmkMIio3jrHGZcQTv4A0rqtoirYwMS
	4EWnkdpRbRqi7b/vVpDdaWMF3Gjuew==
X-Google-Smtp-Source: AGHT+IEU7idZYH7tdB8+JrK/IxXdtauSD0OGplAdnzOdck3dh+fzMnfl7OJHmYrF/am6b8KRWcNcwg==
X-Received: by 2002:a05:651c:984:b0:2ff:c6cb:60ba with SMTP id 38308e7fff4ca-2ffc6cb62c8mr38677691fa.34.1732621769421;
        Tue, 26 Nov 2024 03:49:29 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa4d16f9bsm19527931fa.19.2024.11.26.03.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 03:49:28 -0800 (PST)
Date: Tue, 26 Nov 2024 13:49:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8550: Add 'global' interrupt to
 the PCIe RC nodes
Message-ID: <f2tmdxywunlvyzr22f4uxh7yzha4i7azls6ssw6s3x32w37svl@f6pxwi55y7tt>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
 <20241126-topic-sm8x50-pcie-global-irq-v1-2-4049cfccd073@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-2-4049cfccd073@linaro.org>

On Tue, Nov 26, 2024 at 11:22:50AM +0100, Neil Armstrong wrote:
> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPUs. This interrupt can be used by the device driver to
> identify events such as PCIe link specific events, safety events, etc...
> 
> Hence, add it to the PCIe RC node along with the existing MSI interrupts.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

