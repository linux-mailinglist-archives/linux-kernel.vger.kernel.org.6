Return-Path: <linux-kernel+bounces-384694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D0D9B2D51
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2302A280ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766F61D3648;
	Mon, 28 Oct 2024 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MdZJAPhT"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1A1865E3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112631; cv=none; b=qgbrNUxvxRRUsHmubLSKsLgfms2ZcDmwRCi0yChZ/lNchZIY16iObevOGZ1TXhY5HjOqdCWwA7C7ldfSKduqXX4F8S9Kb1lrt3tIuZ6nzohqY/SJ4Q/7IP9U7byHUwyEvtdszxloasA2xZ4ED4rppXqlFqHk2RMh6saTAHHXCDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112631; c=relaxed/simple;
	bh=bU1Qtn48i5nUAA3O2eESXBE5C0blf2pcU1u+JOIFCEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hegEt+VhPVZtaJwQUfx+zP7peLhZUOa225T7HQynnNeqG+7YDANhc7eez7bSwTfxroMv7a+Re1d/Vsi5S63WeyXP/j6csSdL+o4PZJlTKioTwWKlh/X+8wEo/SnSYE1oTBsmA7WBD2ypGgDLulrW4aMrsiQ1+Ce/OhtDkQDgHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MdZJAPhT; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f72c913aso5215890e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730112628; x=1730717428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xT9gfcNhArTE1c2C7RUJiJlGQ17PepUqnBsoFt7gaK0=;
        b=MdZJAPhTIIODnSSzQwrL7Udzvl5F86lKqzhzF2ubIaBd0y3NW+aCb1p8c1syaBGCRc
         6ynJSRuhLIipgp+3kC00dgHe4KU+Jt4Qq4hlQAuD94g0Zq0KVL8McQfw/+Mwd1gQzU52
         r9cR2xmG7oN8Ne8VLnH/cYJeeJLh9zTBotUaMRB5zKhAspUWiLa2E/8nzCvWl6LHj5yb
         S8kjkDFAk0nkIALmXVuXldrKoKHfJJf1zCPpV/w8SqdkjYvM7JpZg9TFS0n/FYPgDQ2A
         a8F4U+IxHxch6cQggXAHECmT4DQtJpbJRwsgt8dc3T5x80x8J8rGhiHU3uCgeNmsiInr
         PtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730112628; x=1730717428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT9gfcNhArTE1c2C7RUJiJlGQ17PepUqnBsoFt7gaK0=;
        b=E+DsCmD5yMNkIsKR2m8v5zRuBdoTvywRt6LM58awylAbB3rTscNl+NAn9uqlwUQuNO
         bXqO//GoMkcfq0O2gAhJFeyeJ7tDm2ARxscxSD1bJDLxkal1SNhdGiJdxz7R1GizEEMy
         WCCt7DDKrAq64PKHah9GbF6srD5YMQmFb/6gY8eYVU6GEUCYBvLp9FSaIXDZb2/8S5zO
         p3OSQOshfa1lzrx6gML+J6g5T0BgGxeUDAzhO5bVOkDiHGSCMkuDrHowT5qsbaKLXzFW
         4I/Pa3fHyDjk6x2sOXdPGZlvFJk4zeh57cOsfpFV4JPGUhffZIChWLsjitkjYMzeaRYP
         fzgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU8v/eK7KnFGkVe8+YBE0Li1+/KLAb+QF0n/DmEj4LnAlSlX8El9pPwBMJSbrmY8CtsMD7ieBdcwUo/fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxouIQ9LstN5ra6Anlb5qgRs4jbIW9yudQNAzLcPV38ljAG4QGI
	QmugQ6Dzl0906c/+4jgBEQAm3zZqWmRNL+0F5U9JGh/a/tF65BydysXh3sXjzFs=
X-Google-Smtp-Source: AGHT+IH8FSgEZPGmIDpEZ2RxUjOJo65ME5pGZDusIyUmphRyeZHRXp0OHKNRYZxJAZ8p5+Tv9Q1f6Q==
X-Received: by 2002:a05:6512:33d3:b0:539:e7b9:df03 with SMTP id 2adb3069b0e04-53b348c3954mr3544985e87.1.1730112627826;
        Mon, 28 Oct 2024 03:50:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1244d7sm1052368e87.68.2024.10.28.03.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:50:27 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:50:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Arnd Bergmann <arnd@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] drm/msm/a6xx: Fix excessive stack usage
Message-ID: <pipbl5fxssydcw3ehqsq3oea56nc37un7ok3oersvrqrlssyo6@5ksxbtcixfbo>
References: <20241027-stack-size-fix-v1-1-764e2e3566cb@quicinc.com>
 <3fb376b3-2db7-4730-a2e1-958f1ddd9f5c@app.fastmail.com>
 <6b7c2ae7-3210-4d57-a7b0-2efea594b2b9@quicinc.com>
 <55ca17a3-8ea6-450e-8ec6-9bda97808164@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ca17a3-8ea6-450e-8ec6-9bda97808164@oss.qualcomm.com>

On Mon, Oct 28, 2024 at 11:39:16AM +0100, Konrad Dybcio wrote:
> On 28.10.2024 10:52 AM, Akhil P Oommen wrote:
> > On 10/28/2024 12:13 AM, Arnd Bergmann wrote:
> >> On Sun, Oct 27, 2024, at 18:05, Akhil P Oommen wrote:
> >>> Clang-19 and above sometimes end up with multiple copies of the large
> >>> a6xx_hfi_msg_bw_table structure on the stack. The problem is that
> >>> a6xx_hfi_send_bw_table() calls a number of device specific functions to
> >>> fill the structure, but these create another copy of the structure on
> >>> the stack which gets copied to the first.
> >>>
> >>> If the functions get inlined, that busts the warning limit:
> >>>
> >>> drivers/gpu/drm/msm/adreno/a6xx_hfi.c:631:12: error: stack frame size 
> >>> (1032) exceeds limit (1024) in 'a6xx_hfi_send_bw_table' 
> >>> [-Werror,-Wframe-larger-than]
> >>>
> >>> Fix this by kmalloc-ating struct a6xx_hfi_msg_bw_table instead of using
> >>> the stack. Also, use this opportunity to skip re-initializing this table
> >>> to optimize gpu wake up latency.
> >>>
> >>> Cc: Arnd Bergmann <arnd@kernel.org>
> >>
> >> Please change this to "Reported-by:"
> > 
> > Sure.
> > 
> >>
> >> The patch looks correct to me, just one idea for improvement.
> >>
> >>> b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> >>> index 94b6c5cab6f4..b4a79f88ccf4 100644
> >>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> >>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> >>> @@ -99,6 +99,7 @@ struct a6xx_gmu {
> >>>  	struct completion pd_gate;
> >>>
> >>>  	struct qmp *qmp;
> >>> +	struct a6xx_hfi_msg_bw_table *bw_table;
> >>>  };
> >>
> >> I think the bw_table is better just embedded
> >> in here rather than referenced as a pointer:
> >>
> > There are some low tier chipsets with relatively lower RAM size that
> > doesn't require this table. So, dynamically allocating this here helps
> > to save 640 bytes (minus the overhead of tracking).
> 
> I'd second this, said chipsets often ship with 1-2 GiB of RAM (which
> is still a lot in comparison, but you know.. every little bit counts)

Okay from my side. Yeah, poor Gnome runnning on top of 1 GiB device is
very sad.

-- 
With best wishes
Dmitry

