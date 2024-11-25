Return-Path: <linux-kernel+bounces-421407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1203B9D8AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2E4164722
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE44A1BC08B;
	Mon, 25 Nov 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ij2t0Ehl"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5481B87DF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554282; cv=none; b=WA+QX7Dd6cRnV0um2YVZi816ZKzUjgmg/lNvf3YWTO3Un4Mocxu8TdlFW5n+SwnInHA8vVa/hj0/543Z521Fq++bn/qFFsMvgl/48zY/rt5BXVuNnclzUESRQTO/6+ns5fSgEpEIR/571D4sOxl8KMJDuzshykihXFHe20Nzxqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554282; c=relaxed/simple;
	bh=/Cs4hfj9obntVomONyvV6xiN7rgE7OfVdzENAMostJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6TwhQyZLGMh4nz6oP7OhNyW2geozsdXeFK/q9dTPCOtJweKtxYIWGFMemsuxLfUHUN6Et7dRmW8B4Yyrz/T50WaSKox3ZsN/dWtKl4lXzjxOaC4zpAN9Jj1ZLOj+XitbGfLWvny4vhkowEMLwBrisracgYDLG1w17Pi2oTm9m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ij2t0Ehl; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53de6b7da14so818173e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732554277; x=1733159077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOqS7XycPVasCpLUmsgPysaSQK/jkK7vxYxhUtuGR7k=;
        b=Ij2t0Ehl9Zljn86ExxgiSFiNxYrI5HuIEjRtlouGz4ERFzf3PoS3LBoZv4f0RGoeAM
         qSJw2gmPvITWt1WeNVLdLpg5TDDcgsKpoX96uVGRzAcdWXOnHa4JUlqa2uYjLwHYohj1
         iHF5pIkrAMOZ3wcq1FBdEmeoQNahLK3O3nxHKMPzaIY9PZtfif9ZiCUUh14IoA5mnp9+
         zUOBG9+ODXlmAbP3lIoghprd0a929dZPXjbumSuOquB+7YcAZfRnPqmZKedJcbKaoqWk
         Q4PF1/42ub24pvRJ4BDrh5jW8MU3pYt1SHl3Q8udYkd0XbRZHU1JFW0TYyJyXoOFltpw
         Hszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732554277; x=1733159077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOqS7XycPVasCpLUmsgPysaSQK/jkK7vxYxhUtuGR7k=;
        b=j+Em3MR+fUZfVvZtD38uP4AoDTr7l3Tkec5AK1/I0/QrqHyPOhIxm7q/kYxpagsQKZ
         3ly7njY36y529M1kRYZPn+bNUFXnpXAW1U18QgJ7nKgTj0NUJOY8bBGOeJqz6rDguDGe
         OSxFbMmNEtywJWZQ/Ws5hfi/sthyOl/n03NBo4gXm0wdnDroV3Sj6PJaAq/L+z0ITw6Z
         LEpkPTMeaVQDN3SAKguJkKkKIAUgkihqeUj4CyGSeTD0z54IzRHBNZ9xcktXwgdIYxfm
         SlZ0qJ98s3pkjrhk0QfJ3E/dM5UttQS+6DebseuQO6dYQaJUKyJopZuQF4sYPXaiDqeD
         IcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpgKNVq3N+zGbm14I/YDHnzVIf61JHATw+2RWdNks+YVuh/dgVBKUnQcRuUGNB4nwpEpWu0kiCDUWy0po=@vger.kernel.org
X-Gm-Message-State: AOJu0YySesOhkWlljOo0zQ6NiaBlRQyTDjdxixBNuq3xHfBlyYwLzuLa
	crKMC9vojv25OpSDqdaIv4AYV9TK/GMExSZGcQtizYxA9rXXxNd7H14cP7nM/KLMkoiULEK8g1T
	z
X-Gm-Gg: ASbGncttkBvoIjey+IdgZtPh6LbvtrWlvAhrqyMIkU8OzkISwUgzvE4McfgU6DpYMpQ
	FQ17U1LDZST8eptn/Y8nNoLf/liIZZnTwmY0aurrX3ttnBfo6TubWVe9hWYubPuodEK7VEE4stz
	AqZDuVEZJKhfiDxx3WWEpNXCKcAPQkjExGrWoVOaKio+O6wBtm7tg+IuSwBHKkHePmeGXHLSAZG
	cvF1WTD8/s+PXh5tG0gZ2jIpXDv5PflCRIVcpJj7Xlieuv0nYetvoUA/VVdBdpVcil9BhG4Z/6t
	wyrNRTuDL0W/HfXJco0nXs0iCCqw3g==
X-Google-Smtp-Source: AGHT+IHAWOCIhn3v6jdT3oe9Kgmdlf5AUqH+NzlAaOE4/2CkcMdsXewmUrNDNbExMP9HdvEzf3cYWQ==
X-Received: by 2002:a05:6512:1252:b0:53d:e397:2ddc with SMTP id 2adb3069b0e04-53de3972fe2mr2227535e87.5.1732554276908;
        Mon, 25 Nov 2024 09:04:36 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53de59e1ea6sm283947e87.53.2024.11.25.09.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 09:04:35 -0800 (PST)
Date: Mon, 25 Nov 2024 19:04:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 2/2] arm64: dts: qcom: qcs8300: add TRNG node
Message-ID: <ulzzcla5vkwil7bs4himipguovx2yegp5k66ehornzmzix557g@wlglv6up5ey7>
References: <20241125064317.1748451-1-quic_yrangana@quicinc.com>
 <20241125064317.1748451-3-quic_yrangana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125064317.1748451-3-quic_yrangana@quicinc.com>

On Mon, Nov 25, 2024 at 12:13:17PM +0530, Yuvaraj Ranganathan wrote:
> The qcs8300 SoC has a True Random Number Generator, add the node with
> the correct compatible set.
> 
> Signed-off-by: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

