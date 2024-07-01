Return-Path: <linux-kernel+bounces-236832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA9591E7A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1962840F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A54516F0DC;
	Mon,  1 Jul 2024 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7DRoX8X"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346AC16D9D2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858643; cv=none; b=p0l0czn7aOmWDXwYDs27sONJffL9CqTupF1kye7OhjYFmqHhpGAhrPnpnnYrPmUj8Cp1tbG3l6VGepBojS7IV29DRenGvqr0hLB0UQZAdbMJFGqfbBjXbjrP8nyzWzaWGfApUwTTWiv0q5bwDrE9aMcGKrvlaQGFyQ+Ewi8rc0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858643; c=relaxed/simple;
	bh=vDGLWmIXVVyB1exjrHzcvgHK5kCnv8kyZp7T/Bw4t/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6djetzDn1xvjrzh1txHnIhw+oJOdcOTe2kAyFVzChBrly0bh6/qob3WB8u4bdUd+KnzrVrrcMdGmjQXw2Df5twZyKWTEXYFl5YB/HAoOwIHIU/nKAwLpiSEvdQP2rHoTi00CbCaZ6o5onMjR04NTlZE/xr5AmIfpjWstDom42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E7DRoX8X; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e7693c369so4409851e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719858640; x=1720463440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sX/O4fr2+8PvQYguZGt7KddLq0tEWxhads05D+kvVqE=;
        b=E7DRoX8XUsuQKBE6sEK8C+sMH7d66MRgw/lYDSkPfgrvPydJc478nuv4PpfbRoFiSo
         xBpAmNRnd5p8xdDeo7CHJ335c2Cj5oNRAHxiQnHF6l5volPDRJ4m+VIX/aCivXEJgCnO
         aRCu1jl4Wu7+pYT+fQuQsyh0ghF2kvg6EnVGtcCvoG36yBvWwBJmm5dAZGytIS0JSR1n
         Z0U78MXtcmcKSuYWvI7t820HE88agjg/SLoPrnlCnwyAkKZ33tqOfik0P9+SM631vncM
         rHlg5KpbqSByTI3U93MSlPmA+WxbAWA7w1TPhTQW4KqB1oHhrH+RX2wvL4//merPEpT6
         oglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858640; x=1720463440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX/O4fr2+8PvQYguZGt7KddLq0tEWxhads05D+kvVqE=;
        b=uRNRQNRbZDlMwnEDoLFO8X2jBacwYCb9sZdvg5rFSQ+3JJ3BPwLwebPMB9awLXaYct
         ZYzUIbhnvEpKyRwY96DIB0+peAS7QMrTRkwwSjXkMtGHBKK0aGc3obCrEfQuNXfzBstg
         9VDuG7YPXsMkh2oo67oTm2LY0B75DWF3pnhXl3Vjo49wv9OMMzttSYiw5Sp1PQ22BW+S
         T36+ie2Ncaw83kAuFyhi9xuFHvfZ+bNyHfyxAUTCvJdCcJHMksLjiWTeYirUFb8zAjDJ
         mbQBfGMTH6Wylhx+DtKgGZCbSxsb01FMDmUw62BQStWiBaroFOH+x3B3wB3kF1NXv/gV
         Gdpg==
X-Forwarded-Encrypted: i=1; AJvYcCWCOspYG3n7yU7tR0o5SB6lsIsPHFWJk4w2kQ2flZrliVKSGlGXlz/JcqUtx8UPJBsF7Guey2Mp5C99iNZNpcf8m20vFissSwissG9u
X-Gm-Message-State: AOJu0Yw2aP3TDMqGDvrnUvkZAxy/scL8UGHl8YCZQp33/eknA+u0niiX
	R9BraweneawUAANy2V9IyELD4LpSMAYxudS0sNEAbG7bw3d23ny+YydWCtR23rk=
X-Google-Smtp-Source: AGHT+IGYAOEefMGp+PasSD6aXVE+wt5WaW5Ihd9eWiI8BlyAfQBL2BD7FLoq6KyCw0TQKGNw5LYjtA==
X-Received: by 2002:a05:6512:3e28:b0:52c:a5cb:69e4 with SMTP id 2adb3069b0e04-52e826f12d1mr4520600e87.54.1719858640404;
        Mon, 01 Jul 2024 11:30:40 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab1089dsm1502831e87.86.2024.07.01.11.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:30:40 -0700 (PDT)
Date: Mon, 1 Jul 2024 21:30:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: codecs: lpass-rx-macro: Fix using NULL pointer
 in probe() dev_err
Message-ID: <kblpzus3lr6j6xnitmjk2qt2vpfbutqar2zdxrjbepcvey73no@j6f6whmsk2mj>
References: <20240628095831.207942-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628095831.207942-1-krzysztof.kozlowski@linaro.org>

On Fri, Jun 28, 2024 at 11:58:30AM GMT, Krzysztof Kozlowski wrote:
> The 'rx->dev' is assigned closer to the end of the probe() function, so
> the dev_err() must not use it - it is still NULL at this point.  Instead
> there is already a local 'dev' variable.
> 
> Fixes: dbacef05898d ("ASoC: codec: lpass-rx-macro: prepare driver to accomdate new codec versions")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/lpass-rx-macro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

