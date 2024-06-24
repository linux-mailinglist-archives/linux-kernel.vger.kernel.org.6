Return-Path: <linux-kernel+bounces-227254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F0D914E11
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F3B2854ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5A413D889;
	Mon, 24 Jun 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbBbkXhB"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D199E13D605
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234717; cv=none; b=fXzDKbr8yxpy0nA2l5w7eFlg5l9670WbMXTdFwsWgJXu7mHxKOsBsXDFoHHLC7tE1jMNd+k5ItbmT0DysUmiTpacAxs1+csVqUse26YoORf87I4wa/FSXH8mSqwDpc5e6gUl6ozbq1/gMTYuJQseJCMdRPaOYpSU6dxBWZX4iYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234717; c=relaxed/simple;
	bh=VjNCFzWs4fMip61XK1/2tUG/6+rad2HUZJCzNnVtNt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9zHezYVDS8VC69yVbSHZk8SPkK6Vws/cTgumAzdSEMeKCOobcleg0wMPj5Rbhc5A5hpRihejkJY5nk1a/XWnl6L4ZzIo0adD4x/raBrmXnMAqR0VQmAoJBJZtIzPeEofi++2MiEWuDgqBhtzZF3rAblz3Nbrt+wGFnbkP9KF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bbBbkXhB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cdf579dd2so1789542e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719234714; x=1719839514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IPk/V6ZCtMtNKcTQ0BbQ1yW1GyQn/NuNLdo14/zbbMA=;
        b=bbBbkXhBa2nkhptAqEeGO8yEE7uHmESMz7hsnO3+2uVjxWH+Ug6zhZi7cmfZgtckhi
         jPlc4Q09Pa5oTVal2/ZXeCv73GvHcv9QGIL9NCI3Xhx3WURdmPN3RZZxagLrf2zhGCv8
         W/jp7nTU3Ca+5E+CYd3lSJejV06OG4KdSGm+U8Odg7cQVWqJgQPU8WPaAHNZjoD3S9M2
         VOjB8WSU4vOo5deTZL7nyPRcdfMgeHFswQWlGkZz9riNwJ2z1YfBJQ8891tRfQ/ly+lg
         aatL5cF8YLHpRDmhmaslhZpbdqhJn51um9dm6EOpK5lyhkWmF7wFDDY2b9srLcaSPY8E
         26pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234714; x=1719839514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPk/V6ZCtMtNKcTQ0BbQ1yW1GyQn/NuNLdo14/zbbMA=;
        b=qaH5QxbujWcwgRcMfGWNjFNJtoyn/1BMbMY439dJvr9GYqZ/XPL5xYsrfxtjSIm2sk
         ETOiNu/F15qJf15FUHlZRLj7CxMKRntIn5j/JlXc306Hr87IYCA4/W2UjWitVSj3LkHh
         pkvT0hnionoLSpdQVwYdPEMr2t87cGIFd/hQ67VQtAicOzRgEKlG3cC5cbOrqJ+EcN47
         AK5nUvj7RXfZZkVpaaKQ4an2ceQgiLStemi9wD2Amms0GZ7bKX1ss/Sqm7Lvja3PQb/b
         jvgU2p5LXBDSXB6i2R/tYo9Bk9w5mUvcdKaZEl8BLEn98qm6Tqr74mNBQvctTpRy5w02
         12Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUk0CeKT0LrxWjg2BWkaWtylO0GzdSU6P0XLhcKR3GleYrF3TzE+Klv4YV7digcvj9AbS9KMGe5kVXaDf857LUgyQ+4D15Q712ZZlSN
X-Gm-Message-State: AOJu0YxA3VVCBFJKQjZRJeHd40l0qHMaOlXNXRNOc9KNZr/zh/cplzvA
	D8njs70azi4QGmKPcNeGMWT52vB3ttD69nyIep07nOqoHdVjCurIze+5540iYgY=
X-Google-Smtp-Source: AGHT+IE6VlpPc92A70dxmbYGuqq6zvs+OwoLUdsYnDUUrs9lY4ROR5VlF1Z3d3UMo8Oryl7Nn+WZYA==
X-Received: by 2002:a05:6512:3e0a:b0:52c:8b03:99d6 with SMTP id 2adb3069b0e04-52cdf7e671cmr4286209e87.6.1719234714150;
        Mon, 24 Jun 2024 06:11:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd7cdf464sm947409e87.143.2024.06.24.06.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:11:53 -0700 (PDT)
Date: Mon, 24 Jun 2024 16:11:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8350: move usb-role-switch to
 sm8350.dtsi
Message-ID: <3yq7bdgvngxdmgoumyxkvcaj5ikut4i7mrsjhwly4hja3kuhcg@5f4mphitl3hp>
References: <20240624-b4-rb2-fixes-v1-0-8d763ee4e42e@linaro.org>
 <20240624-b4-rb2-fixes-v1-2-8d763ee4e42e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624-b4-rb2-fixes-v1-2-8d763ee4e42e@linaro.org>

On Mon, Jun 24, 2024 at 02:23:43PM GMT, Caleb Connolly wrote:
> Since all boards with this soc are capable of role switching, move the
> usb-role-switch property to the soc dtsi and stop explicitly setting
> dr_mode to OTG since it's the default.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 5 -----
>  arch/arm64/boot/dts/qcom/sm8350.dtsi    | 1 +
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

