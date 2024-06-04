Return-Path: <linux-kernel+bounces-200897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D8D8FB62B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E5D1C23C64
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4226148823;
	Tue,  4 Jun 2024 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OnFEoM76"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9513048F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512382; cv=none; b=pfOitxF6syA9mRa1ygQ7qHara9e7SP64G4h+AN3rNnddnki+HoBjNaUZDZpIJ6QbAl1KWl94pAOvo8dsWf4TOXp15M1qQvPpA6zD5pa+CJzslQttnUKOt697HTZdFsubwSN0mqS11/bK3PDogz4gQjrBen8RqwLudh3cry+N1Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512382; c=relaxed/simple;
	bh=6p0sp9pgFRo1PqbzlDQMsuyY3COLLatNjO1bz6AsYto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccsnZFVrnjpoZvZZjAUs/43IVB+mORxzHNvOjjshcTmxi0V1zl1j0yp+KPRXfbaiHIHgOnZ9IvrhyGDaQ20ZtWwwHHA7OubrbqZDf8m0aqThQBMEgoWoWlrEnRZKV/BChnRx+6OuO4q2+6zlq/TVMgKBWtkkbwbgNgZI38EYSiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OnFEoM76; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ea9386cde0so57016021fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 07:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717512379; x=1718117179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fWM9RazXmkrrcf7cVm+FJhwHBnlPawdSsHuisHuA/0=;
        b=OnFEoM76/ZmXM8SuDUkkn8piPsXCy6og/EPQ+XgUV/6rDrspml4LShHfeNgjpv3hZC
         eBihZQ2fF8SMMtn+pbUgIEEol9MjCcXgjH8t7PBMfbULNxpStHDFGTk3f3BQ3odF69Pj
         ICMlhrGHOXlgTz1Zq+Wa3QJkOnIUDWOZ0VSxmeR3gA5sDnYamnupNTXnZYZ0p8xB2W6L
         H+mS1xaoLfm5SySt4ieCresd14e0k/CeA8WCCs/wj8qGw8+Ld14HjEx0z53Ajy+07ANd
         /YWJkepUN0jQnNgof/YyxMtiHJ2X8tFL24bZnhUVRhZP3vCVMT+slqdAKAHUhhpJY1by
         zyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717512379; x=1718117179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fWM9RazXmkrrcf7cVm+FJhwHBnlPawdSsHuisHuA/0=;
        b=eX8t65LuxrPYlW99VjZvg20P+BP29wBEF3HXozTqrUEy5lI8BrEJ2reqFAt4NePktL
         7HjIO+uLyWl9zWJM4tiM4RXETPlTnthdYBUNz5C5J10GUCEost+0fr22zImFoJqWTndW
         bKm7Tsg3nQBnyyj8044trIIAfim+oTxTFUhi61HvyeFRC8Up5qIyMKMVKmNCvntSWtIm
         DoyAN61Wpt4tMyhEUtLgcU/nnDqV+CVa3KEVnUkcPKsd8kKvHiQsJfdDnFgdONgNtmlx
         Nfr8WbGqTHsgjnV2MI9uUKuLWAMGAD7IwzA6z9gS0LT2ZeFXaHIENp3Avi3ds7pNAM1g
         KTIw==
X-Forwarded-Encrypted: i=1; AJvYcCXZrdoMs+6wcnQc6lBf0RXRYcKFR7cTxJevg1m4xwIzvC9SjFPprGToS6do5m8oj3zMETUwrPEBUVUOaHEp75UtL+FbtOVwA/c11DIb
X-Gm-Message-State: AOJu0YzAVYUAj1NrHZPyWDmAO+xkpQsznnt1UEFHZG/tkLJhagUfYi0/
	RH96FyTLn17yjk4a/AlLq+oxO1g6YbwuaxRZ9GKt5mszwPyW+hPnNrbhszMppXs=
X-Google-Smtp-Source: AGHT+IERd+pOKeaU4WAUxdb915FWhHyou0aFSqNLEgCX/8v3BAB2Hl1Vqes5cCRKx30uO5efQiei6w==
X-Received: by 2002:a2e:6804:0:b0:2e9:81f2:ce03 with SMTP id 38308e7fff4ca-2ea950f70c0mr70279431fa.20.1717512379323;
        Tue, 04 Jun 2024 07:46:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31be4df2sm7465219a12.47.2024.06.04.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 07:46:18 -0700 (PDT)
Date: Tue, 4 Jun 2024 17:46:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: [PATCH] ASoC: qcom: add missing MODULE_DESCRIPTION() macro
Message-ID: <7a0cde5c-db6f-4de1-9dc2-aa2c21fd0210@moroto.mountain>
References: <20240603-md-snd-soc-qcom-sdw-v1-1-101ea8bcdd38@quicinc.com>
 <0bd0a518-4d85-4251-9bf9-d056dc3d7b08@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd0a518-4d85-4251-9bf9-d056dc3d7b08@sirena.org.uk>

On Tue, Jun 04, 2024 at 12:56:09PM +0100, Mark Brown wrote:
> On Mon, Jun 03, 2024 at 05:16:07PM -0700, Jeff Johnson wrote:
> > make allmodconfig && make W=1 C=1 reports:
> > WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/qcom/snd-soc-qcom-sdw.o
> 
> Is anyone getting any value from these MODULE_DESCRIPTION()s?  This all
> just seems like a huge amount of noise and I'm having trouble thinking
> of a use case.

The missing MODULE_DESCRIPTION() warnings are very annoying.  We
recently missed a link error issue because the warning was drowned out
in MODULE_DESCRIPTION() warnings.
https://lore.kernel.org/all/202405182038.ncf1mL7Z-lkp@intel.com/

regards,
dan carpenter

