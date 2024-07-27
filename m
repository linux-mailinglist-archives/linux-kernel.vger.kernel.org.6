Return-Path: <linux-kernel+bounces-264078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F98F93DECB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915301C21458
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DE557CAC;
	Sat, 27 Jul 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vd809/RX"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC042A95
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722077265; cv=none; b=WEbNwD3Hk1TBTq15OeZzOZFM4DnYFUQ61aP0sGdjLtldk6rdReUfjc/4iz+U9EiA79K74jbMir6tD+yrv5OZjoNC8RPC5S+0xmch2GnI0J9t38XFxFJYMrXvNvdq6ix2MTu3ZpksEhgoPJ5wbgEsJw6FkYGWSlpRuFBIRElx1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722077265; c=relaxed/simple;
	bh=CxQCaVkPKiM+dSjOjWGM0B5dxgOP8eZ7QW6Iaue7xE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD0pP7+Es2xTBzqhLfcPzGXyQ+P0gL1hfPQiuAdG19MovVjN0VfK9YsfefaIqPiaJ/1zghgpRRPkqaYSWtLFwTAWsodjRmlyVKxOszttr6GiFQPdGFGUBslzzboGSnj6ZqMTqImiPYoBnoh4ORQJSHasdh1CQ2e/ZbVwPiSw+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vd809/RX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f042c15e3so1826856e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722077262; x=1722682062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PgZxzidyEshqEQG3bGebzLz9u8Tr8K9k35MYbayHhxk=;
        b=Vd809/RXii9JNNmHpkXbcVs43XkeOSFaw34SjtOH+6tf8YkhPlOz3LNuoqH/LNVqXP
         FX61XCh647KLtO5/mdTQ5Q6PtK6h6TSmUtyFFBlxYM+BRar2b8uvmasLbZyV0WCFe1fp
         7jyZ53fDtXokjU2AO/N8ISuebyt8k6qhT4UqIgSUnoTmQzLBTMJUCyayOhbY5CeACf9j
         za/UmYoxmxcPAj15Qt6hVFAo0/SlZ7/JCkseKBkrVYNwx9HekNhh6XYWcxqAM1sYdNIM
         dxE1Drw7PUbO5kBx5D5AnlpvqgvDw25Bry2hkCf53yy1Oq91gaQVJWd3FFk3MB3h7vfG
         XEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722077262; x=1722682062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgZxzidyEshqEQG3bGebzLz9u8Tr8K9k35MYbayHhxk=;
        b=jqaB8q9vyyDbCYD4hNJNqkslXfczUYzj6N/r94niIwWyydEBGY3EVpFHm0ffmlv6cR
         2dGFXLo3uQZ9Yx+WROWUpfkxztx+rt7350w5kUrJzvX033CwaE4SgQ/HdooDPTVUNeD5
         6CHhg6QWY3PcnYTa2JZCmrWgIqnzsC5TAQIuOi4fILYohpaoakdR+kHHJeyrjJpGJDU4
         znRDrmgcPhf4fr03KOSMIxy9AbmAfDPMbc7zqr34sbsPaW7glhsLz7QOGiHHAy7SHdGk
         NXxU2iRjpMzStqlQ77Um2Dqqb//AMJrWPIGeST9s3l3bZ75yZAYr4yDSBWKwD22QyuPt
         +dqg==
X-Forwarded-Encrypted: i=1; AJvYcCWdwJWiChkyHbfSy1SDnq6ymlDXCGwrA8E7X21a8Pbobjr8XWEtyUnNVx5OZEPjZsNAHhKjcDzjAAkzOvVsWTlA6yKbFDL0ZU30EZ7z
X-Gm-Message-State: AOJu0YyXdeOwmrtaIoIPc3ikqsNaQ79wDPeI9QLqnE0ZnnWRDr9zwwzS
	gLFKMLBZwpHhcFlDpoxX9509IVOMgo0V8LEbU6GfJwpwN8wqb29S63GEw5lfPgs=
X-Google-Smtp-Source: AGHT+IFinSpQ7BYm+GtIK2AR4f2kI+7iSE/VNTey3Ki9zIDB4o0fctoD8bK6ZZn9hTNYPBvsFYkIVA==
X-Received: by 2002:ac2:5e23:0:b0:52c:caf3:98ed with SMTP id 2adb3069b0e04-5309b718d49mr435661e87.24.1722077261761;
        Sat, 27 Jul 2024 03:47:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c19ee3sm729586e87.220.2024.07.27.03.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 03:47:41 -0700 (PDT)
Date: Sat, 27 Jul 2024 13:47:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] ASoC: codecs: wcd938x: Drop unused defines and enums
Message-ID: <vcufh3cp5ulm3phbgucsofqapfrv77bqgf2e26qolftviia4wj@aztjalnuxqby>
References: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
 <20240725-asoc-wsa88xx-port-arrays-v1-4-80a03f440c72@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725-asoc-wsa88xx-port-arrays-v1-4-80a03f440c72@linaro.org>

On Thu, Jul 25, 2024 at 01:23:46PM GMT, Krzysztof Kozlowski wrote:
> Drop defines and enums not used in the driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/wcd938x.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

