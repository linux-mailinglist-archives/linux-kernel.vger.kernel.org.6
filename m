Return-Path: <linux-kernel+bounces-225819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6549135AD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 20:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578FA2835A1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 18:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94233CF74;
	Sat, 22 Jun 2024 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVCU7IF8"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9E83BBF5
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719081532; cv=none; b=iao7Vru/vsdK9HP/nQ9P2r/lOkSYqQmXDN+sGu2oxzf7arXgdsJlXXRGu1CEQr/oeLl2mnvnnhWFosur9o0zvYW9LkkGt46EBIk+XgDLeov8rHoOfHYTWWYDrDN71DRc57h0mPmhFsPnm5yAgTFvdpFRe/Y3BUzGIxFWIiCym1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719081532; c=relaxed/simple;
	bh=eKSY7iA1dK6kJuYssYwbw6aV5AwOfW5tqa3WM0e9Pow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSEh8+aiBDc7bBMSJxKFrWTLPEZkIpgfHhglugE6Rni6y5wOexkTpBs2/gwQ/4QkNnSw2bVIldeJc7ZI4GN35g0LBf2MqAKz6Jvw3kcMn3YAjLyzNoGc0VezXfk/dWnq/oJWzdLPx7D1zCWFkm9VRh0cbbcT4Xcc4sTuJnDQiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zVCU7IF8; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so36043761fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719081529; x=1719686329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsJSKrhXwcm2yba7E5HX5qGoubHmUX2L5c9+i3qWphk=;
        b=zVCU7IF8a/bVMmcYezFcX7bIaxrOeb8sPETyqZFfBn41HHu77rK08WlgsKVEcOSOBZ
         g9ODixoXZFbkhA++N9KOsTzsoQaCytfq4sSyAD/CP/rUV3MzCRbN2880s/wGJD0CIomN
         +mbTPtn4liyREUlh8nzRjfz/6niwCxmzUP0xpr1dZS4zudjn1NrSC8fXFzzHIotyUKAi
         olgSY9Jsq810PvEnopXbitAirJhxYuImKkWXphkX7lW3ocDA9g2AK6ZligvXTqGWxvdL
         V4jUmk1X9B+hYlUIcPPEJs3zAWptq2KIaZfMN+YcQQFChZUUHei2Fgfwgwuj/70IwuXQ
         KRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719081529; x=1719686329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsJSKrhXwcm2yba7E5HX5qGoubHmUX2L5c9+i3qWphk=;
        b=ZW4UrsXKLGSVJb6Do8Og+YbnjdXWVCCq9aMerAGZf7q5rYf6UX87eL60nHoumCD3hh
         G+Lk8ka3LmfQTzySjQGDJLdIJb0qVZAVMAyyKk31Z+w+GFfmHRwi4acPM1zf21oMNKgM
         EDvPWAuOC3eNBSqNXn1+Gs1gcZaNy00c3EnB7WD48iGOnIDd4mR+0HuG4zU0AG17QRu2
         jD0LTw4NXt5JNXPtzUSc0fzIdgL6FAjswGx0cso73P0d79FqEqillXPrqYT0Nlj5GPwL
         r1EwyXtf0f7fCaewTch05m1VqxqS7uu1NPqzimikSaBubcg5nGrvlhJvozlm1kX5xB7E
         buxA==
X-Forwarded-Encrypted: i=1; AJvYcCURowTBszzbGnzEV8cXtM4QvAQQbeuRZn6E5H8IX74kSb0XhdLN2nKwvyh2JEMPee9XlsTqPo+hFFYsOuLylZCEQvVuSg3ZbXozGcJR
X-Gm-Message-State: AOJu0YzstAXVDvP6C1ylzyWhAHAmJ8e8DAJGqrgv9swHmXLgZFSrRraZ
	qHgkSJrP7GHIQ3k6El6Tf2AkuIvQ1dd4gVjFoJoCcWqN/Wi6f0wHcgiSrypRSWM=
X-Google-Smtp-Source: AGHT+IGqcGI11MWIfY68szD5ztVc1o4rd7pFp2twsqj4FUSE4E3dSVNIKwV1+jMYc1r2GKjj/rspgg==
X-Received: by 2002:a2e:9ed7:0:b0:2ec:5922:920d with SMTP id 38308e7fff4ca-2ec5b36c1c9mr2988801fa.51.1719081528501;
        Sat, 22 Jun 2024 11:38:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d758224sm5073161fa.96.2024.06.22.11.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 11:38:48 -0700 (PDT)
Date: Sat, 22 Jun 2024 21:38:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alexey.klimov@linaro.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 v4 2/2] pinctrl: qcom: Introduce SM4250 LPI pinctrl
 driver
Message-ID: <mzltplcf2p6aadrxorazl7xyir23rdhxpbenvldbtlc45bqovq@sze2jt2o4x3n>
References: <20240612-sm4250-lpi-v4-0-a0342e47e21b@linaro.org>
 <20240612-sm4250-lpi-v4-2-a0342e47e21b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-sm4250-lpi-v4-2-a0342e47e21b@linaro.org>

On Sat, Jun 22, 2024 at 05:49:31PM GMT, Srinivas Kandagatla wrote:
> Add support for the pin controller block on SM4250 Low Power Island.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/pinctrl/qcom/Kconfig                    |   9 +
>  drivers/pinctrl/qcom/Makefile                   |   1 +
>  drivers/pinctrl/qcom/pinctrl-sm4250-lpass-lpi.c | 236 ++++++++++++++++++++++++
>  3 files changed, 246 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

