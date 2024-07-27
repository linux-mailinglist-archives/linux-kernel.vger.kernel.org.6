Return-Path: <linux-kernel+bounces-264080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E75393DED1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0187B1F23682
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4455B69E;
	Sat, 27 Jul 2024 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkX24YXU"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803705589B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722077375; cv=none; b=Ec/i7BfWHrJX+ONBncpcYMpDsoN8HZUMtDOJn46wrUh5ZwYlklabJ9mHP+5eS2Txv5PM/KaF53ii5yjys48AbC+EgOe5AfEJoqqrnzxuUoB1Vw50Of4f1aLARgsEK1LWvIJm6eqh7iTKoJwP7zORY34vYb+z8bzRhYgE1ItUZWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722077375; c=relaxed/simple;
	bh=0oZ0fowpposgg1hmSxqfPXm1dtlRuKN3xpqiuu5rB6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHDLXCE7EzuQnZF+xAs5u5/S9NTX30ABkKoSDnZ/QWcQK+5blA80RA5+hGrp213VRkijkVsq0z9hlQE/ZulMYlwVi838PUj0ekTh5CACXZ+6MPlBBogRZ1YDb/1YbFsboFMT7IJrbIAla2Vnau+IyvU2UkjG2PbZUzE2eUzlogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WkX24YXU; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f04150796so3254073e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722077372; x=1722682172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yNKzx3azHXxh3j5OMY+IqqDu+KTxQQhcMUOz9aaOMTQ=;
        b=WkX24YXUsz4cQi/PxZhds/JgCJoFN72mJv3KS88/+z6++xWLTTqTKQN3BB7ezyyikI
         Whzy++mEiQrHfFSwRwq3BeEFmPU9yXMgufZT9QAc0mzJrwOlwK1fBSsKE++SvsyrYYFN
         g7jZVToC89yLSQ8HDojQU2RFzpzNFHOHpV/mRYOhhQqWz0nqYfWRLCNEAS1k+mcFfNr/
         YryXxtDJYxyPGsqAgy6T3EdPcVseylmHFkl368CsFCgQBQ4Gr/qbR1yJixFll5N8SK65
         FZcWxS8qR9PITOrXbdTb8tZ9Ouq14Q5rGc7oA78TesuOLLHfydVTZTQKvg+T66Y1aNYr
         6Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722077372; x=1722682172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNKzx3azHXxh3j5OMY+IqqDu+KTxQQhcMUOz9aaOMTQ=;
        b=U/1ZR99XU3pPPKf8e0NNe/7d/zXyKX02d8UFY1sLh1kHrhyahMmE0nP6OUquxOI5aq
         hMDAz/zvS6C/RVxvDcblKFrZj80YFr7PDyKtkPFuo9KHt9+rsjW1r4FtKraVCFSPN6SW
         MsXT2l7IeO3jfsZNHbDay5CC/469TqnP0nCm3LO3S0cUEVN+L7X5QXgw5Mufm8+bvaOJ
         ZTbN7ppLXVcAM0vdLh9rVEzCOyhhP/sGd5gL5Gtl42vM25PtePrhTUSfJv9EQvFaHnsQ
         mJCvwR/z2+kaFNidwfDBDcCVlVtQhwKfebvmuj50JDiIe1e5qaq38IQduPIEpbvCtKGi
         7+1w==
X-Forwarded-Encrypted: i=1; AJvYcCV8b8zXRPaDwr4pLE4k1J0YFPTIKuHWsDZDoNS8QqJNUxRj2gXF4dgJolNhz84R2ASaN86uI/ezFW7aiEEAXwwV7B+TC8/JJFGhho+J
X-Gm-Message-State: AOJu0YyWJPtVmS/jdDj+/MWBPPNTmxdQmnKxHYhKZ78CGPf2tW5t9FBq
	18y/Yv2X9IMCsOKjdmCRKE58AmRhLgq5+LuJGYZ3dKlx41LmG2kbb7snfpkNilQ=
X-Google-Smtp-Source: AGHT+IGxziVLosYTzs6fsYoTWkq3wWwSbcxZCa9nxslFM0uZIZe3gN9qbnNwurh64J1lmrZMg2moVg==
X-Received: by 2002:ac2:4f0f:0:b0:52c:cb8d:6381 with SMTP id 2adb3069b0e04-5309b270661mr1909187e87.13.1722077371627;
        Sat, 27 Jul 2024 03:49:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2c133sm734387e87.252.2024.07.27.03.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 03:49:31 -0700 (PDT)
Date: Sat, 27 Jul 2024 13:49:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] ASoC: codecs: wcd938x: Move max port number defines
 to enum
Message-ID: <uc3zgtkfw2gbgy5cm5hyf4i7qq54uagirxnp7sqva45wfc3zrd@wlqsuhx7mhgb>
References: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
 <20240725-asoc-wsa88xx-port-arrays-v1-6-80a03f440c72@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725-asoc-wsa88xx-port-arrays-v1-6-80a03f440c72@linaro.org>

On Thu, Jul 25, 2024 at 01:23:48PM GMT, Krzysztof Kozlowski wrote:
> Instead of having separate define to indicate number of TX and RX
> Soundwire ports, move it to the enums defining actual port
> indices/values.  This makes it more obvious why such value was chosen as
> number of TX/RX ports.
> Note: the enums start from 1, thus number of ports equals to the last
> vaue in the enum.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/wcd938x.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

