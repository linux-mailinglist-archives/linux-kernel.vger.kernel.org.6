Return-Path: <linux-kernel+bounces-264075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD40A93DEC4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825601F21BB3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79AA56452;
	Sat, 27 Jul 2024 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zS0aIosM"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CD4A05
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722077192; cv=none; b=QpHinJykU47dLA6sWeO3SbKcz8T1biy0i5rrdTDF3oeMHRRydfjBEMvPBpvZaWLkVXhAq8NOGNausBgzCGdol3s0V2MbquY8cgBUOgE4kgkhKkXExoIeY+iA/o5X2DfQ5n2qhcqz5mFlTcwRVeeIBJDUJTh3tV/aO5fQA90A09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722077192; c=relaxed/simple;
	bh=fa7kLGj++0G0Eg231uyiEToWORgo2WWIgnIiDtLOJqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAl8F9HScyiJQoAuDiVe2kosbZAoFMC5ZVNBUlDo7BFzSgAf8xEns7an6NEfFWgw3Wkm7koquJr5yPXWI+W9PHfq2M22PW88dGWC/PxbOeqNiRwNZ7bEpEdWGiHF637JmPJqy6S4222AiFrNWpEzCGQ0wg3Mv5pWXDwQxrV9/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zS0aIosM; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ed741fe46so2200165e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722077188; x=1722681988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ/xr1RKgXgl0tJIEKuoNjq+bUa/0Y66j4NiEBoptb8=;
        b=zS0aIosMcof1+y4RkLmOh4tKkhirP6S0w7mO1iwPqyPhFbHYI9MctmJqqdEnyF9maq
         4gQEsZGlVBoLKmusjkQ9BrW6cFXDKZZodsT9EKmZA3M3BcJtX7jqVGqQJlWeDUOioRtl
         L46x0+ehiKxIAxSd+gLEd/07j58ZkRfKubhon77diGL2iy0SqO3VDDSq4UYCG6xXDjML
         /y/cefwqOn1rR/8tHR3NQ9h4mnfxqt21uQ+OM5iRwjsP7h5O+jyUpWUTaM0zPi0BEZGC
         CNRUnO6oee+pR/+ZdoAYV4okoOxWrT/zpQ1MBW9h1PW0tMpji3Ywr7V6GPJx4GqmYYVj
         jnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722077188; x=1722681988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQ/xr1RKgXgl0tJIEKuoNjq+bUa/0Y66j4NiEBoptb8=;
        b=vXsiPHss9rX4lTQ/TFIVOBfQVLPrz4ENeRDF0CLaPeu4fNkEJL/DWhVT6mseQZeid1
         vtr+j2dZTQBPEgFzpnuVvCpHerNzl8XEKebbx9NSCNYpKTMy5guZG+/MJpPwyRduoVmW
         uCYF/CCPYrGCTeVS1hNNt1l0Q0nJcs1nif6JJ+2XfhEioPJi5B0MvoNKbAwj7OFHP/dy
         MWnmQuoUb44EDrUpAwrRvJSVjJgYhBvRIGuU/iFEdLOl9Nr7czh1vii4IRYCujQzcgIC
         43DR/Sblr0hZrVe9eHU1krxwXlklEU6sB8T2HvdomWx0cwugZVKajqlpxrzuIo1CdbiT
         7pVw==
X-Forwarded-Encrypted: i=1; AJvYcCVdwdh/whadXZyWvzg1Wz1lEsuQpsn1tEBrPnOM6JeCYP3rcsiLIxUwCk25cAJJx8SuXeP4DjILEBnlM8aJzDa4lAjOfIKXWh8rxezi
X-Gm-Message-State: AOJu0YyOOUCGzruHvGd0GPVsvCNIEmoe6WOFnQxE7pQUmcldfTK20/W4
	5Uj/btbA0XPjrat8HJ1tl3Eitiuqnj/NMQw7JiiKfUrZVvA+yPgR7Vd+UFOT0jU=
X-Google-Smtp-Source: AGHT+IGGP1B2SaB4xulY6ueyuAVpyf5RWWcSGeN89eSnIuMZurceJMYLWHdDgl7Jret0zGlTBndyrg==
X-Received: by 2002:a05:6512:128b:b0:52d:582e:4117 with SMTP id 2adb3069b0e04-5309b2ce92dmr1450181e87.54.1722077188458;
        Sat, 27 Jul 2024 03:46:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c09109sm729450e87.178.2024.07.27.03.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 03:46:28 -0700 (PDT)
Date: Sat, 27 Jul 2024 13:46:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] ASoC: codecs: wsa881x: Use designator array
 initializers for Soundwire ports
Message-ID: <bsnfiskyvzf2zrsarek47irjmt3feqyqxi5b6s7zbanagkh7dl@yhqpncgaxgtv>
References: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
 <20240725-asoc-wsa88xx-port-arrays-v1-1-80a03f440c72@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725-asoc-wsa88xx-port-arrays-v1-1-80a03f440c72@linaro.org>

On Thu, Jul 25, 2024 at 01:23:43PM GMT, Krzysztof Kozlowski wrote:
> Two arrays (with 'struct sdw_dpn_prop' and 'struct sdw_port_config')
> store configuration of Soundwire ports, thus each of their element is
> indexed according to the port number (enum wsa_port_ids, e.g.
> WSA881X_PORT_DAC).  Except the indexing, they also store port number
> offset by one in member 'num'.
> 
> Entire code depends on that correlation between array index and port
> number, thus make it explicit by using designators.  The code is
> functionally the same, but more obvious for reading.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/wsa881x.c | 42 ++++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

