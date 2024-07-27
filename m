Return-Path: <linux-kernel+bounces-264076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF7793DEC6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2541AB218D4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695BB55E73;
	Sat, 27 Jul 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTuR7ebD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7D20DE8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722077205; cv=none; b=LdB/k3uL2oV2KpIZzlYJMZFvWgyAksRjj6BNaqOXduYwYUPTRI2GUmdnwjgTm2p5CWwV8iCalFd65pom13dY5loWu4ZixzCjknqTlZOKl14n1NRgH//AfcgSaG7f5Oq2vKnwxls74r9/KYIi5H3zDA01r3+9/q8eOPy5wpc+WZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722077205; c=relaxed/simple;
	bh=eOfry3nuvu3HHLuEem2iFGqJmfkmEBKnxmiPgO/CPE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGXo6OWI6KoGUeZ4EpUcmGhawkJbhgBIx+D5VT0Mhy9Kgm3vXCFPN9p9JC8nYFp11UjFtyOivFpqZ/0INsGazNRWmBXSdVjI8lA1pbNBMDqjyu+tGnNN6Q07TE/PGnQNg2p4K9xQhwfYcZixlNiBxOV/90GWd6ircvMmde8CLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gTuR7ebD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f0277daa5so3143603e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722077202; x=1722682002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WVI8E/Sy9x/V5MZN8kodRJsfEHReFS0Uyz6SOoGkWt0=;
        b=gTuR7ebDTw7OuoUlBzXeM+9+buk4aOWwGmH+ogH89n67LSG687iFPe6pF6f8fBQo/c
         9ABPblWDVDQ4q7rxJB/X1kjCUCJd8RtSH6i2CHCf7/GVRInHQXDBantFcrp7GenZdlwG
         eeV5+P03tAdVrC93J3329xA2lPqmEGZFPINxox0EsDuW3H0FaSfIQPvXYPmps9xVNzR7
         RFcyH5WS+K5DJUbLro5iRmzD3jId2V67lF3HfNXWhtCClOO7Ghe22/nl8nlzExnc5wAt
         FaJHXM6wwFBIfDkW6+OJrDLee32KenEwSZK6Pm3Zuw7FYDrvc7dc/zFCYTut+3PlSIiN
         QfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722077202; x=1722682002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVI8E/Sy9x/V5MZN8kodRJsfEHReFS0Uyz6SOoGkWt0=;
        b=G5m3k9E2u7fzmi57eQbZ6k7724821q0q6wUHL0LlPdZnoHPDF3laf3q1dNQVeWqO2T
         vzs9UQRR1bQAsNYmeKX4rC93WdEFrWUzxudE7nZX6JS/kGFHyvD3RRB7r1/yheFX69aa
         o5H+Pzqn2ul05SFGXUCETgq6+sIkCtlZVLkPH1Ifr1+8egg4/mMo3BGwXCBBI5DCELPF
         yIQ4QVs5FqC9zY15EERRyWxYUOW3efxvdSN7+0R8f9zWESrQ0YDMe6j7arfBmPWvcq1A
         8BL3Z9vX015Kg84ZVHKHmaIKSkcygJ/ArJVRftseUbh/j2bkMX0WAMvXmaVUEbdqnpsK
         BNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqjBr+d5xgJhjMZjerd8EoMqUpoxXh/WurJvMpKYBCvbsYyNCC9RaABLcOcpmzM/48lnwykT3ZdiCAcgTEvn7i6SdriC9la1s5zQIm
X-Gm-Message-State: AOJu0Yw4ZWdjL4FhIgV34uCkaT91CV8yS1cBV+pq4FQSy3GZewKEFWRI
	IKuVHmBXQujm0Id3Ps0WruPGMdvi5K3priod+DUzMjueopG4Hmf9fMyi1zTHBxs=
X-Google-Smtp-Source: AGHT+IEJNsQBjiCy50HzlScOL2HDolaoWtEKLNxWFk06ri5hkBtcRmQ7gig1E9sGyOIgWavI8qXGNw==
X-Received: by 2002:a05:6512:2144:b0:52c:e0e1:9ae3 with SMTP id 2adb3069b0e04-5309b2c79fbmr1374032e87.57.1722077201922;
        Sat, 27 Jul 2024 03:46:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd11dasm727514e87.85.2024.07.27.03.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 03:46:41 -0700 (PDT)
Date: Sat, 27 Jul 2024 13:46:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] ASoC: codecs: wsa883x: Use designator array
 initializers for Soundwire ports
Message-ID: <dd7h6dg6uutup4av2dxvmtr6ucxhojmicsfnxoj5y7wtglnuwn@r4u3httvsn63>
References: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
 <20240725-asoc-wsa88xx-port-arrays-v1-2-80a03f440c72@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725-asoc-wsa88xx-port-arrays-v1-2-80a03f440c72@linaro.org>

On Thu, Jul 25, 2024 at 01:23:44PM GMT, Krzysztof Kozlowski wrote:
> Two arrays (with 'struct sdw_dpn_prop' and 'struct sdw_port_config')
> store configuration of Soundwire ports, thus each of their element is
> indexed according to the port number (enum wsa_port_ids, e.g.
> WSA883X_PORT_DAC).  Except the indexing, they also store port number
> offset by one in member 'num'.
> 
> Entire code depends on that correlation between array index and port
> number, thus make it explicit by using designators.  The code is
> functionally the same, but more obvious for reading.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/wsa883x.c | 42 ++++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

