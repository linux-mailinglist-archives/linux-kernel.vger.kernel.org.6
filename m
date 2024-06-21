Return-Path: <linux-kernel+bounces-225323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD625912F17
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184D51C213B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAFB16DEC6;
	Fri, 21 Jun 2024 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOuwP1Dh"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2652F155A57
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003725; cv=none; b=s72CW2BEfBBqMkkGKwRyb3EKNqSXA31eUR3s9kHgUNAMycZJK7DisIvkH47o5GrZSLJfOY3tiln9xtr9+HUg88p/TY7jcr0iCVIoTTyfYy6LYuF7x1g0T6RNYsbZFi8SEXCAFvRYb8k6bCh9N74rSeiYXtkxvw5z9hgvfGBvprk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003725; c=relaxed/simple;
	bh=SIn46AlZrvPMNaN1mv87TjU0Fs6J3JAzxJ2rAf+4bvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nham9e6OZ7rwE4Ipm310sghqkTiJSVIcSQeuks4M+xCLcdswh8iNWtCDZ8DL2vLfeq0QM/FYvGEOhGHhUMGGh6VSeandgJtn4KNpWfbpZNbGN7V+TuI3bEORRaspptCadav1V2NQ2jkBTGxmnlyaYC0PaXOzw/iTNoTq6o8v5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IOuwP1Dh; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cdd893e5cso182222e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719003722; x=1719608522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQaUecEobjZqzwLUd9GWjgt4QLJ9UfoOW6siZZKNEAw=;
        b=IOuwP1DhY9A/+LeI4hpgSfRp1/IqIw8TGbhn9M9dAKIbgCf4NJgxy7mFmmBPtyD/Nz
         KsCyLluxgvyBw+z9TmsccgM2rpaTCEa7eNuCd7D2YP0bHryd0ySqfoJ9YDKVxWvocX8O
         yJlrJghc5ojXkXd0b+EZ41irLEQNkWpK3ZqLXt4FdeZiiD/CrvXuHVcwv3qwcWbSNP0H
         HlNHlxBR8hd9G3U35zRlNg4GPsbXhxj5UGoBq+mdPHfBtimeIY51Jj3a9yHXK8Py4HjA
         HhCYMS71u2V0o/oSnh0Y3pRJFEkjMH0/sRb88JvZ7JR5eoCz2yYGx4brwJRlZuTjiHgX
         IT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003722; x=1719608522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQaUecEobjZqzwLUd9GWjgt4QLJ9UfoOW6siZZKNEAw=;
        b=GXr4FVl8ty4MglQD9GQLni+9mXyIjeedSVWeGi538WzSfZ/mdDDs0jPxqSpIcbNUv8
         dVRL0McyoPqyOTfq1gXQQJgHUHaNXlkvvVNi6Esd9xCBK8NsJ0e2dHFj1sEziraoYw1g
         Oz7Y4M5yfbaX3DONBGazXeQTIRVzqUOowqEtfUAMT0J2umEKOXwbGC+6od15Azglv5PX
         Q8ZmsNhLxOlbOxISkR+BPgoD9nczVHMarHyXd06pTlfidws4VlFvm25pkNTHB5oOaWia
         TePyEcY8uaeOYPwxdKFZjBIhXJthRLhzNGVNQahc2gwTsSronJF3ahU8kskP5Cisv6Pj
         aF7A==
X-Forwarded-Encrypted: i=1; AJvYcCWVnLVa4W6AL6XQSPR9b2UEy8/jDV76pX9KQ/SOz/JygLrYiy19srgLyGI6KbTg3bq/N042ifDIB1gEysy/3X2HjdyCe32Z6OaHvpVu
X-Gm-Message-State: AOJu0Yxr2K1/4NXc9mXNLI7oBQsnAbLgqWRpW4qaFK5Mlhe8PuD+ynSz
	xNVq9acwsKZ7uxqyHkQAjAoIAjzkCXRpBMBYeZYDjR8y8HcY4sVHPRnvf716mm0=
X-Google-Smtp-Source: AGHT+IGAV6WldJ9dS5FxJhQ056SRdKm6+iAz5aBUPSV5QDpaX0C+WSe/0dUyReDqDGBqVFs2s3BreA==
X-Received: by 2002:a05:6512:68e:b0:52b:9c8a:734f with SMTP id 2adb3069b0e04-52ccaa53e1dmr8767018e87.50.1719003722411;
        Fri, 21 Jun 2024 14:02:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cdcdb981esm89295e87.122.2024.06.21.14.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:02:02 -0700 (PDT)
Date: Sat, 22 Jun 2024 00:02:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm7225-fairphone-fp4: Configure
 PM8008 regulators
Message-ID: <u3hldruxjqlelinhbitgvt3wtclgskjss2slpoj6kck7mgrm3b@skeezbyy5yj4>
References: <20240621-fp4-fp5-pm8008-v1-0-dbedcd6f00f1@fairphone.com>
 <20240621-fp4-fp5-pm8008-v1-1-dbedcd6f00f1@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-fp4-fp5-pm8008-v1-1-dbedcd6f00f1@fairphone.com>

On Fri, Jun 21, 2024 at 10:42:30AM GMT, Luca Weiss wrote:
> PM8008 regulators are used for the cameras found on FP4. Configure the
> chip and its voltages.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 109 +++++++++++++++++++++-
>  1 file changed, 108 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

