Return-Path: <linux-kernel+bounces-332633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B797BC40
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA9F285C50
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA694189F32;
	Wed, 18 Sep 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+2GypYD"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D5718952A
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662747; cv=none; b=Nv9J6SWPhUIZ9ori80BuSz8YFxdF4tRmgK9AYHaiEWvGYeOP0Oh6G/XmwMw+ucGMY0CA3fF768lFo4XT1JLX2y6V6cgHunxc+uUMKTyueTLAayt5SkkCispqFXLWrj11F56ZkKTznZNg3Dznw8Qn92y2Tgp2CZOQcQIlaSO537k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662747; c=relaxed/simple;
	bh=3gVQ9JaYTaBdvDz5MGdsXx0ayVEISpaMDfcREkdX9c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1qDzE4Fv7BWplJ2BgKKOIDK1JoqFwF3N/Xjxw/04tPBqQmNcI8rN6lveZwDuBaMaz5PYd0LxiSsdTD6lwhHmbq0pk6IqmbOtwrBkkhuHN9IJpoOrasUCcjNUKEezF/4m9HLmTQpwL8QMtydNsbTbZw8tZP1WRY10nyiPLh0PHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K+2GypYD; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so1351907e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726662743; x=1727267543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QldvlS8/eJZac6pG0e6NEdXcfsAi5+t2N8DBgSFO8Rk=;
        b=K+2GypYD3gvqB4wezdF1ONJGmiuElFPIW3MxSawSSrNDMxe3f9v/pSSpnkpq6OXX/Y
         aWTS3XIpx9iz5CLBWmoUqqMLgB5nJlSU+z2IowwLG928nhWsgldW0u3qFptNAtAEkXa1
         uqsT6LLb/uVXoypoWodr1Aj3jRT3XuNfXssLoCjPfJ+yq26aWG4Is/lrXbygXj40M7Qs
         bqAkP0Yz5HtnAS+qWbosrohj1+VED2F8RMgCIGsbkjJD6i91jZvMemNZILZcD1fIuscp
         b1bZcsUEeFrRkx/mWf55chIaQskhYvl8ymzbHDkPAIH8wU4Xa+FFsstwChP8Kso04Ecu
         Tb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726662743; x=1727267543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QldvlS8/eJZac6pG0e6NEdXcfsAi5+t2N8DBgSFO8Rk=;
        b=VKyqfwi2H0yC7IaZ2tlTquaJMYoOqZTyQWK/fNuRmOY8mZzTwOAB24+ztZArpwCdNs
         9eA/nJUTMfKDJhhv0XrsE2S5hU3VNIVjaK+ESxrM1xuwDXt/fPZ8vhpABMMv24Z0ZCR7
         Ydmt+jHfsp30OotBEOvh94pfDbSesfUFx83v+5HqyF8rSAhqdC7Bst/2sFFeki7zVTRK
         aNaKAv2fiv/I507oDWlcM0ZxoMVgxZTjtw62zobVbAOjccOx79Axufww7w03So5+Uqvb
         jOGknaDm7vpfhuaRW6xaQsgzUIV5IFkEy/RbFphQe72Y1tFmhZRwUpxh4Gffg2yhL373
         MzTA==
X-Forwarded-Encrypted: i=1; AJvYcCUVG41HGx860zCmCNhkGJJj3Kstjfu19YymhRapkIvSM9mdMQm/aj9O6n0pwp0r9YQFgqQXF+Ff6VTLHG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyng2mfAJMcjDUBKtTzvmWMB4CcW5CgKCDW8HVOC+ZH5ZUlnIqA
	08lviXKvW5/v1CEFbyCp3gK2NdEflZPZT7AWV9NMl87KFk6XSvwt9WoXOZuhr1g=
X-Google-Smtp-Source: AGHT+IErvjmxyimyd57IGMkKNpdAXZ02gL2PuI7e7vGw8BlqbmJRMt4iCTe0zO0FnjQKvmbmHIhaUw==
X-Received: by 2002:a05:6512:33d6:b0:536:741a:6bad with SMTP id 2adb3069b0e04-5367feb95bamr9279710e87.12.1726662743277;
        Wed, 18 Sep 2024 05:32:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53698c3dd4esm797163e87.13.2024.09.18.05.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:32:21 -0700 (PDT)
Date: Wed, 18 Sep 2024 15:32:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sachin Gupta <quic_sachgupt@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_cang@quicinc.com, quic_nguyenb@quicinc.com, quic_bhaskarv@quicinc.com, 
	quic_mapa@quicinc.com, quic_narepall@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_rampraka@quicinc.com, quic_sartgarg@quicinc.com
Subject: Re: [PATCH 1/1] arm64: dts: qcom: qcs6490-rb3gen2: Add SD Card node
Message-ID: <4g6ao5bbt57wdro6sroq7nodxtgdk5ecdxsdkrfvttfrsm2zmw@jik6og3np75z>
References: <20240917090630.1025-1-quic_sachgupt@quicinc.com>
 <gyasvmb5q3e4pgmfpj7njovclydwhsvsxt4ayfxzbh5njwgwsq@zfhlm6lqfirl>
 <5c0f627b-058d-4213-9c2a-5adb2f174c0d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0f627b-058d-4213-9c2a-5adb2f174c0d@quicinc.com>

On Wed, Sep 18, 2024 at 03:58:04PM GMT, Sachin Gupta wrote:
> 
> 
> On 9/17/2024 7:08 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 17, 2024 at 02:36:30PM GMT, Sachin Gupta wrote:
> > > Add SD Card node for Qualcomm qcs6490-rb3gen2 Board.
> > 
> > Consider adding mmc0 or mmc2 alias for the sdhc_2 node.
> > 
> Thank you for your input. However, aliases you mentioned already exists in
> the sc7280.dtsi header file.

Ack

> 
> > > Signed-off-by: Sachin Gupta <quic_sachgupt@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 33 ++++++++++++++++++++
> > >   1 file changed, 33 insertions(+)

-- 
With best wishes
Dmitry

