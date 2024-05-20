Return-Path: <linux-kernel+bounces-183500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8258C99E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163071C210E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403831C6B7;
	Mon, 20 May 2024 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2Hig+8O"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF21BC41
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716194127; cv=none; b=XhuvMUQmnTOZx5Chl2WhghyzHsJi0C/+Ykw44oPg4J9d48ZqrFU7n4VckQEgi9BSaJW+qfm53YTSaUebuXe/ut6po9MrxxxiCnWUnr2COZhUvdLT25iDs/tvX/N2Hc/reY2Sig+oTKl3Oj+hQaCQvcGKnvbj0vD0lvU9KOHTwMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716194127; c=relaxed/simple;
	bh=pGR1qWiXTUPecq4OqlA1IrsQxJzyWJZMvAO0kM1kkyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqBWqrWfBfXMKKv8EespuRXswfv18hCJCKB2fC+JFKKHoVBvzCOyNuYiYToYTgrILTRxEwiV9Nmd2aDQizn1pwg2zdB3tf3BR8EX+lNiRFLMiGH4GMExv2+e0mCGkgja/9TDW9ukOt2WEKu/pHLp/nIY/GisLihHPgePdNLy/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v2Hig+8O; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1eeb1a4c10aso67193315ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716194125; x=1716798925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIsBb+eRFu3c1CtI64mjHrwU2c/P6ra4rdQLN4GGHw4=;
        b=v2Hig+8Oka3aTkFb8CQk+n7ZPFyUzqPxAcAT4qppXy97L0MC36LLM43wVreQkNKIF3
         3+6STW1i2j5D6cOjObZ8MJ7DF8S06TNBGyEL6D6Mw7arjeJQGITTLdNtyBj9TG498QVl
         iZ4iWiNda7MCeRo4RsDNfaOxJmKlaD/LbIR3MMjUyAcwu/idP7Zuu+MPm/VUT2pfwsn+
         A9FRPsn3FlZYaeXNMiGvyo9RTL94BiQeMm44hdrKUBiaDpmS6WZVodb4NEL5wTZ4c/1x
         Nk1NMeuUFr3Ixgq57WAH8ocEUpveULOgUUi1EDtu2YIDNyU4JjKKoCW71tCyNsyTwYAZ
         dUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716194125; x=1716798925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIsBb+eRFu3c1CtI64mjHrwU2c/P6ra4rdQLN4GGHw4=;
        b=RmaxA7U0nSjitfVZ3a+V0fpqnlrBgeUr2qeTE6uQoigBrpcChbcTZY1uRuvHYXOYY1
         425v+ZWcPLBgvOarP26AJWEuWQXsdVIdG7uuzoNz92OW0az4FEgeM/6SwIWS8j346m5x
         ptFJLshm1IolstOcVdIhfbShzP1hCvWvDrGrk7Yw7V4dknAC7hLC55hSQQnrNf7l3jq5
         PP78maRL5ay83j3DHsyqtGSYYY9IcETMUdcm6Y0mrkjCk73TVnkRyctZtnnOS2NoHqlx
         PNCW2ktLeg3/A1U1H8Wfw6759uF4SsWB5ez3igQjhBbkMPCfzOuGu0SHsHYq9TbEVm3d
         xReA==
X-Forwarded-Encrypted: i=1; AJvYcCWhh2AJp8ixI1015IutmXxyxsaB3NvsaSQ/V1J21kkvYQpAl7husH+FMX0ZZPocRHRHyw8N/vJizZ3oFBGOHoWLR9uz0GLv6Joyt15U
X-Gm-Message-State: AOJu0YySJgSpKYZqVmspDXWROgBa6zgPJ26UYMVRqpe3tUHrDkJK8bN+
	e6CrYZ+TBHWH6qTg56v9aURuJVyjafo24sozDDOccpGMYOh5OdhPwqwaBZqpesI=
X-Google-Smtp-Source: AGHT+IH7PSENgMsGNo62ZNvTY9oX8UT5YKyk73G2Rc3ZZ7+HceUfg79PFOiwl3cTGJZToyA+m90evw==
X-Received: by 2002:a05:6a20:c89c:b0:1af:fff4:6000 with SMTP id adf61e73a8af0-1affff460acmr23706598637.20.1716194124766;
        Mon, 20 May 2024 01:35:24 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13692asm198417105ad.252.2024.05.20.01.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 01:35:24 -0700 (PDT)
Date: Mon, 20 May 2024 14:05:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: sun50i: replace of_node_put() with
 automatic cleanup handler
Message-ID: <20240520083522.vvga3aqjg4w3adkj@vireshk-i7>
References: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
 <20240503-sun50i-cpufreq-nvmem-cleanup-v1-2-0a2352cac46b@gmail.com>
 <20240510184213.68f92cab@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510184213.68f92cab@donnerap.manchester.arm.com>

On 10-05-24, 18:42, Andre Przywara wrote:
> On Fri, 03 May 2024 19:52:33 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> 
> I haven't tested the error paths yet, but it certainly boots fine on an
> OrangePi Zero3.
> 
> > ---
> >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 25 ++++++++-----------------
> >  1 file changed, 8 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > index ef83e4bf2639..eb47c193269c 100644
> > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > @@ -131,14 +131,14 @@ static const struct of_device_id cpu_opp_match_list[] = {
> >  static bool dt_has_supported_hw(void)
> >  {
> >  	bool has_opp_supported_hw = false;
> > -	struct device_node *np;
> >  	struct device *cpu_dev;
> >  
> >  	cpu_dev = get_cpu_device(0);
> >  	if (!cpu_dev)
> >  		return false;
> >  
> > -	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> > +	struct device_node *np __free(device_node) =
> > +		dev_pm_opp_of_get_opp_desc_node(cpu_dev);

Won't that result in build warning, mixed code and definitions now ?


-- 
viresh

