Return-Path: <linux-kernel+bounces-301087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6767595EC33
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CAD280F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E5D13C69B;
	Mon, 26 Aug 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXJ5PEXi"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4B558B6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661676; cv=none; b=pIdkIA3t6yl35qyjS0832uzKFGOPlnepkDrvC04YkSl4DNW/toNt5IzQIMwRKYBtWFxCcrOxTPdTfw5Ifm3XrLIISfMCnUDFwTPVRxifxf49b80p1XAWl1DPbPHQsmfTK6lS7DKd5HkSnsbGWtSQHXR52w684MxrTF7pUWMvDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661676; c=relaxed/simple;
	bh=ZJqPV+M2ayctdGZHxpg+AofznRAfzm17VKe00rGKdUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQaYPTUQI6HRBM5swwkjwZPiodT69Gbz1leZYOq1JCe7xgNGI8P+6DPqFEohaLIGpnfOcdKvlXHkrmIEOCzi8slXhQAj2LlC8pj2W3sKVpJLil08Y7p1e+7lgDi5vBmnDBMT0kixVpm3+TpeBxvRIaLpXySFyFUXmL+Of+JmhG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXJ5PEXi; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-533461323cdso4538413e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724661672; x=1725266472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJqPV+M2ayctdGZHxpg+AofznRAfzm17VKe00rGKdUU=;
        b=QXJ5PEXimOZ13K98cB1Y/XAMdYH4RaTmfS5py/vw/c1EpBP3vuWDSuZ/nMvnJIw3mC
         th9iepXjNaYdXhdsoQTIRbFQPeTnWJ9w0gSc8+bypMPrFqIAYgt8xPbHZ/Zx6A4xn/rn
         Qa2oJ6jtE/GyZ/2LG+If+pNK+0yw1B4kGIf27Eu15WBiHnoggZ0s1DG8vbzIAXHzTDCC
         koN3voYr7wc997LIDXTOCa7wNhdEuIDByWc53MdoE7VNja8oCF3mZoieIvmFO/jm+PrC
         +Hu86PSoFs9hxZu1OZPqurQkKDezFdJkn6tfbYzd45OJKUSX7yaea0Vs8ejhvAOqepA7
         WukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724661672; x=1725266472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJqPV+M2ayctdGZHxpg+AofznRAfzm17VKe00rGKdUU=;
        b=GSNHizWKNSFepnWHIUwb7jkdw7PeTaJbcZbGGmtnAubtk7WgcRBy2XyDdyVq9gQyz3
         vjSjNgIIntzzIpDhfPdUOeb1cOqTu4k7p13cB9T9TV7UVpAJfaLkKUdDhJ18gJQjDiIS
         /TlPRppLYsaDEQJW0oWwTSmtKjn0wC7NwGiCHrCZnGYqh7AMMvR6fvQT9Y6vlmBRdeVw
         DYh0bKl5v1OVR+jyTAoT120eLk8PDDnvR/TMGmPWRfzbLOgWKbsb+Q6QPNXNUITuncp0
         Pj52kOUwhqhYmgppQh7cIU0Kmh2RJoSrN1WjlwEvy5dUGm5gh9Aa8mUe7Z1+aO81rzo4
         4NUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeomsQY2wQkNR3Ra9k67Caw19DiL3p1iXzO8s54wD3tQ5zVJzZKrk21HGCRQlkDh6EvRmxk678A/LUplg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlfigoyLL503/LS9S3jr/fBZpfU3lO/Smms0CXnZdFcE+R9Sz
	fdXlZaV3MB457vXMG+REYBJz7jnrjoYUziRQW0JCmjNzWuiGSRzyZab9H3RvH2aRXb/oAAv89Ex
	Bw4OQZV7Wuhpbqew+7uIsx9SqQhpzTr1mrTJLyw==
X-Google-Smtp-Source: AGHT+IF1xip2LZYxVRH8VpdWfcRa9uK7A6loLJRPHfWQskmDHQEUYxjPeikly02OaJhz/cUtMMvnXB3y1yNyya30do4=
X-Received: by 2002:a05:6512:3c85:b0:533:966:72cb with SMTP id
 2adb3069b0e04-5343885f659mr6807476e87.48.1724661671918; Mon, 26 Aug 2024
 01:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822084733.1599295-1-frank.li@vivo.com> <20240822084733.1599295-4-frank.li@vivo.com>
In-Reply-To: <20240822084733.1599295-4-frank.li@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Aug 2024 10:41:00 +0200
Message-ID: <CACRpkdb-MKYAcWA5KUDZ=oeREs86S68WjqzS9XRTrUbBhLbBtQ@mail.gmail.com>
Subject: Re: [net-next 3/9] net: ethernet: cortina: Convert to devm_clk_get_enabled()
To: Yangtao Li <frank.li@vivo.com>
Cc: clement.leger@bootlin.com, andrew@lunn.ch, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ulli.kroll@googlemail.com, marcin.s.wojtas@gmail.com, 
	linux@armlinux.org.uk, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	mcoquelin.stm32@gmail.com, hkallweit1@gmail.com, justinstitt@google.com, 
	kees@kernel.org, u.kleine-koenig@pengutronix.de, jacob.e.keller@intel.com, 
	horms@kernel.org, shannon.nelson@amd.com, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:32=E2=80=AFAM Yangtao Li <frank.li@vivo.com> wro=
te:

> Convert devm_clk_get(), clk_prepare_enable() to a single
> call to devm_clk_get_enabled(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

