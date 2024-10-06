Return-Path: <linux-kernel+bounces-352612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5663299217D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 23:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891571C2099D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9581518B487;
	Sun,  6 Oct 2024 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOiaGrP6"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8AD15D5C1
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728248466; cv=none; b=Nq9n+aFJTSzmy86/tu3Fqw2Wriq3OF8rwipAIhl+KJ6pd8owqXbQgtGDZsmHUumy4Pz4wMGr3vEuqG/JXJqJ3S1zLbR66m2cem6P8H07e4kH7862quKBTmiqwgmXYq8s/jMXt3Dil497Fl4+6aHXbN15PUlpQJUBj4uBXf/seDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728248466; c=relaxed/simple;
	bh=pc8//kKVPVBXlvabN/hzt/gk3ZNBOboLITX4xE4dMvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFAv2Qm4hx8foCeyAL4s6CgQjaf2X74ZNq3gNxeVvc9pKliR7y5+7veIWhpkz+wF/28/QOWGj4w7hUToXAnNLEyWB9L9EAIsWTyIBcKk+ntuJRbrsL7vw5fmiAO128lEjwtvbYY5FV1aCb+LzsDLLDzpedMm82xXuQpWBFTGXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SOiaGrP6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5399041167cso5601366e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728248462; x=1728853262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wHv+kTlolQRcaMKgigpNuG/Kn+91LTfDW7oca6ZBhQM=;
        b=SOiaGrP6W0sW5S7Vzta5KeG3XzGkKvxueLtfLetofvpmdtI4KfN0UIN6gRADvsZY/o
         Xst9bOUSu0bIBh5MjmfQlN2CLgLLI4VDrZfs34p9LfW3T5vVyjS6U74C+F2CcNPH5lbz
         ExPInU48MUn7evi3jIMkaCAQW6zi5T5PmwSGCEVcaRwuDvCHSfvdEYuR9j4KRR62rYOY
         K/p+MGxJt7OCLK2FUUEjiXP5fDfr3Ewy09ST59NlttIHQiEcBzWyY35U4n82F/SPmBMj
         6Wxqv6/nbai/HoVufrUouqFlo1h/sCJ5HFel28QAnsnZF6HAmO/Go2kd6J2tmui6E8Bg
         x/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728248462; x=1728853262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHv+kTlolQRcaMKgigpNuG/Kn+91LTfDW7oca6ZBhQM=;
        b=CZiG+sQ8gX9aldQ9VDDQW4Om434mpwlLUxf4C3hK65tESgN/HZfAyTaDpPgYqb5oeo
         utI1dN0/8PtzvSpnwZ/oWsBspMGXJT1+GMYMbR+3vEp/Q1jCMeVEjWf9kJYyGW9hX3W9
         LL428WIyrCKEFoDG6CzQlePI4GJ83rMR5SQ+zYBOeQZlRBOipbC3tBsfkkNMWsxrO3ig
         e16ZAc9Gr280DnJ1DDv13GmpWUT8ey6hPw2NZo+qc+6+KuuqDxuOo76I0BZrHL7XZhhN
         HvWN2z7sJQZy39nKXQsCB0L02Y7Chd96dP+QKsUEDvpXy/E3KrdhQMWX7iTdR4X/IylC
         02Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVZ/nEEl6vLyaQjFCi1fk+FHuu/ne2PyOM4sRa4+tb9Wy6iWZ+sJQu9MngdaLX5/cBR1CgkjZo/UtGeq0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze6TOBFQCplFzOW3YgtwCkZ9d/krv+IArR0zN7RILR/6nlnRUw
	pFhAIRyE2J4ovZcsLyiqObzRH5jcGhHqeDkkwXqgh1uLaM2xa09Ou+MmLllzDOE=
X-Google-Smtp-Source: AGHT+IHGmws/UH8b4s8w+FVVdPBTcFdBRKUyJvo8OGeHGkHtmr57c4OGi7cgQH4rp1ZuhGQyFAI+uA==
X-Received: by 2002:a05:6512:696:b0:539:8cd1:848 with SMTP id 2adb3069b0e04-539ab9ed8b8mr4691760e87.61.1728248461451;
        Sun, 06 Oct 2024 14:01:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d10bsm613526e87.137.2024.10.06.14.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 14:01:00 -0700 (PDT)
Date: Mon, 7 Oct 2024 00:00:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jianhua Lu <lujianhua000@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8250-xiaomi-elish: Add
 qca6390-pmu node
Message-ID: <ir27tt5fllg2hpumh43myeib6v6mikwqblbhmjh5gwxfnv3mba@begbmdmaqdkw>
References: <20240929112908.99612-1-lujianhua000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929112908.99612-1-lujianhua000@gmail.com>

On Sun, Sep 29, 2024 at 07:29:06PM GMT, Jianhua Lu wrote:
> Add qca6390-pmu node, which is used to manage power supply sequence for wifi and
> bluetooth on sm8250 soc based devices.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
>  .../dts/qcom/sm8250-xiaomi-elish-common.dtsi  | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

