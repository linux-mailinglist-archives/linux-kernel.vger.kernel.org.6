Return-Path: <linux-kernel+bounces-230044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E49177B6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E711F23269
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5B413D635;
	Wed, 26 Jun 2024 04:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGTuJTE3"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9539C139D04
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719377660; cv=none; b=drPhlQ7/tA83OaWcTHmKo1vTkIH7LsFxChoPsKT7HcvYRr2hwxbhkfMjD0oDXIiFoWgpw15sXzfi9AAmUSMSXTvx3WuX2JmX9sdEUmjnFJvd+7Aaj/e8QaylBXmmu6HTDVLYni3s0X2px91cyeMa6uXpacw5Huh075d+7P/Qntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719377660; c=relaxed/simple;
	bh=MThcRH/5y0Z5+cdx2QcC+ZUQpATsAyR1GoKrsFAGF7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6yvo+oL4Mo0NPHHVYsS+a7oC+IfSWqmlFcEfO4YgHJBMqp5RWvn1/PcRFgSt5dJbCyzcKLmhcmDkNv4ug9Rhyo1h8MorCAU35FWr8HEv2ZyUIatIjX2m+Eckve5ywdB0cQuJlAYpGahpBl+Yp0Xe85UnXXxRmGJzcBT3ixOSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cGTuJTE3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cdf9f934fso3818310e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719377657; x=1719982457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDTuss67Yx7fd7cDafIxcHZxnByw4QHrUKzvfDG2YAY=;
        b=cGTuJTE3giCuWsReqZpu9Od9wsrtbrY3IWwNiE5AN2Gc8T4SFNY1oOanoTTQyRJEJC
         j7xhuTDo+yAp2Snkd1X9xSarF96BUV1UnxcRJZ8IXBy3c/jI/z7jojGmSOrekchzcRUk
         2R365PfnWWmCOArims1HXqpmqriCW28TSfgPlYE8mdABJj06HoJURP9n0+3GnM2sJx1d
         yIrauDMLqhuQn0BMQC1Kp335TZeDzMj1Z30ImQJlMRBqRRXEBVKmihW1RuMSxQbSTcRf
         oYwkF6UWWzrRhHtWF08Am1ikuAPfLTt7cgREXVtM+KCWdiF8pbJCTmYT6OUEpxRbXMJ3
         3w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719377657; x=1719982457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDTuss67Yx7fd7cDafIxcHZxnByw4QHrUKzvfDG2YAY=;
        b=E/UpOjR5EV2ip07Wn0mMdnQh730xIKu97tFRT5ausH1G+6KO6BSFLrdK1yjNqJ4u0g
         m3+MCbdxZIOZ3XtY4eNQIvy/k4AOBGEtYexkzNth+pfqMKNJkAuB7sGGU4SxU3IL40/i
         pxCDx5yQjhRFdVg5J2EaSwT8h6sCwiiQdQM9QCo+tgRrckooeXdX5iSU1Wg0TGhaC423
         HQRJ8OOSwwrX42vAP+PoGkrtk/6Ipd9gKaN6uFIU4J95zQlN9PhqRu1Pc8wL2EeMwW1E
         EScwzgPW6cwSgp/R4OUYYvJ4W/0/FDh0nMhgKlr0SHz65K4PIbgrSATsClS0LmWwV1qa
         /x5A==
X-Forwarded-Encrypted: i=1; AJvYcCUM2+fmuZ/LRdOb7q91sJtUFcfU5PQrdeUvPdlvaoAT7i1bogbvhiBwSiSjRsHcAX2CrWcAVvTvTJNe2as6HfANUe97fzoAALzGx5QQ
X-Gm-Message-State: AOJu0YxVrE8+mQ8rvaBHTGd+FFM+iIukypsPO/Cuxocvr8+qE+PngDbN
	bYPyLXKizeWd4LFT0HZDnKjySHuG71MdxWTVsFOomdTa/fS/Mlr0kh/SrcleonE=
X-Google-Smtp-Source: AGHT+IH5H9cgOkKO3nvbL83vH3jZYJen4Iv5JetxLRNvEOsW2fJhXlCV5czSrb1aWQsTV8ChH4Ge+g==
X-Received: by 2002:a05:6512:5cf:b0:52c:cb8d:6381 with SMTP id 2adb3069b0e04-52ce063e3f0mr5993129e87.13.1719377656650;
        Tue, 25 Jun 2024 21:54:16 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52dd3e25658sm63300e87.131.2024.06.25.21.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 21:54:16 -0700 (PDT)
Date: Wed, 26 Jun 2024 07:54:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: codecs: lpass-wsa-macro: Add support for newer
 v2.5 version
Message-ID: <pyk6pejxeljab2k6pgnris6u5yxje5kw4kbalo6h2q4ntvjm26@nsokskgdgg6f>
References: <20240625-qcom-audio-wsa-second-speaker-v1-0-f65ffdfc368c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-qcom-audio-wsa-second-speaker-v1-0-f65ffdfc368c@linaro.org>

On Tue, Jun 25, 2024 at 06:58:44PM GMT, Krzysztof Kozlowski wrote:
> Hi,
> 
> LPASS codec v2.5 and newer have differences in registers which we did
> not implement so far.  Lack of proper support is visible during
> playback: on SoCs with v2.6 (e.g. Qualcomm SM8550) only one speaker
> plays.
> 
> Add missing bits for v2.5 and newer codecs.
> 
> This is similar work to already merged:
> https://lore.kernel.org/all/20240612-lpass-codec-v25-v4-0-f63d3676dbc4@linaro.org/
> 
> No dependencies.

I didn't check the register values, but the approach look sane

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

