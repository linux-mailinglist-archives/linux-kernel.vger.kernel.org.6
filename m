Return-Path: <linux-kernel+bounces-217250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6934D90AD69
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC881C22D64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA39194C71;
	Mon, 17 Jun 2024 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPxn/b8c"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17219308B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625328; cv=none; b=PGMQAmH146y9kBxkVagO3AYjYouuzTTsCwDsWM1NJBfOAnjZSV8MRxINeRXHjpoMT5iCNop9nmxMas7ebYkNZJdOEdN33e8wSJw5JLT+HJtMjAqtbEdLXxl4x0JSSjqWBb957aC6wKVda0lWRJerKmgm/HI8zfJREHy8ZgnuRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625328; c=relaxed/simple;
	bh=00DCuDnUAcat8mQsQF+YS+SKMvLS9LnmZjzXlxSo0ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTbEWAmVup1R7+rS4xjGE7VFcKmczqDM0M5P9rA9SxBZGden9HQDXXziwmE84gC0EMQ1MEp7RGbN5bj9ybJdcNxn1YgdrXriiT71EFUaa/Std/u1TAvLMaL6/v5Oq7VVaSTTSv7q7joamaOz5OJ16yxQdiuuKM2kk6iVr4KkfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uPxn/b8c; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so49047001fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718625325; x=1719230125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BTP9DM7co0CqG/PyEvgqiBat1H97eczrXBXnO7IsIQ0=;
        b=uPxn/b8c5ekwuElYtDTZbFCqc8hVgU0/apOiMl27VFLp7Y4M6GWPMSDKNE1z23zCVV
         ftJuCJV1/5JOsFtw2KrbQteDaKZTpts2ZGPMfltcRRtJtfJSZNIrZxAP9w4cm4bd8myr
         luowCrSazYyZNxecuJYmaK1wTLJyn4YwZaGoIkyk/VoS67P1Xfc29/42FcNNma+LqOJL
         xCmz6MAlLHmWRZYCf3hMbhxC6xahsuf7Qn5zbzKM5iZHZJ7l4UajhfLvP8xXcThrq5z0
         LZSFtYJQ1tnCC7p+pE/2/u8SUHSWoQBV/tgu9A1IEhSLbgyt7oAc6ItcxW8JjY73MZNz
         smww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718625325; x=1719230125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTP9DM7co0CqG/PyEvgqiBat1H97eczrXBXnO7IsIQ0=;
        b=l/xBP8j1E88HvspRLYRQJDYZqBINb87MsuQIcevP9IAHUI0DJnjc5h8LFPfSvkDknU
         yH+WQUhqxLaKxu8HKwtfoZL0RIFZT/QDlJrHBInKPscsAe47dKdiAWa0xPX0prk7bEZx
         keEqHpSUtVNMvmzdmQZhl8VmgSifth4GFDPgZCBLCfe0L4y96qK0ImqI62h4C1Mgmnhr
         dVnM4ryBm1Ao2TTUxZcZ++6d1o/EyObIz7qI/ga4qxbz/AcMKqZZg645WRsGg3FpO8LC
         3R1fPh6xQXEWTIk1PPT7Ssqb+VPpwnEjAU/f1XfV57WTuy05yn0S6rCgIAk4toaLmNJG
         FJng==
X-Forwarded-Encrypted: i=1; AJvYcCX2CfLW1hbqRl2bZw5DUaHxNTDttRybt9zvPG/VqeFMOEE9i5m2w825L//BSRcJPH0zLMe7J5xveJWE+Blh5/WjQ2JeW5XQrU+1Ow0b
X-Gm-Message-State: AOJu0Yyi7y7vFMzaDf4RVHV025h5n4Ntbw6uWDw47EP+4FMkQJTfWB+3
	Ou/XqkcICAZ2MgoGFsmmZk5uBP8KG+sLANJ1oSR1dCOSdCZvieD3jWEhFOf48/Y=
X-Google-Smtp-Source: AGHT+IFLaKeMhww3DPJ8alINmerXwIJfdEn65l/MZqsr/LBdFmg8y/Oix9ULNXsk0CIZxIubiFcLig==
X-Received: by 2002:a2e:9a8b:0:b0:2ec:c8:2755 with SMTP id 38308e7fff4ca-2ec0e5d085amr57141031fa.24.1718625324912;
        Mon, 17 Jun 2024 04:55:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c8b0ebsm13614061fa.121.2024.06.17.04.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:55:24 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:55:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jean Delvare <jdelvare@suse.de>, 
	Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] drm/display: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <vsrsvmrkqnmxs3ncqv5m2gevzefiq55tr2iolxlmoehsvgcfkn@hyx37vax6r5e>
References: <20240617103018.515f0bf1@endymion.delvare>
 <xd2yybtxvzte7gwqwg2vudzvhoekqao2dle6zsuduzjzi3rsay@xhahwof2prph>
 <20240617132348.5f20bf89@endymion.delvare>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617132348.5f20bf89@endymion.delvare>

On Mon, Jun 17, 2024 at 01:23:48PM GMT, Jean Delvare wrote:
> Hi Dmitry,
> 
> Thanks for your feedback.
> 
> On Mon, 17 Jun 2024 12:57:19 +0300, Dmitry Baryshkov wrote:
> > On Mon, Jun 17, 2024 at 10:30:30AM GMT, Jean Delvare wrote:
> > > Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> > > is possible to test-build any driver which depends on OF on any
> > > architecture by explicitly selecting OF. Therefore depending on
> > > COMPILE_TEST as an alternative is no longer needed.  
> > 
> > The goal of this clause is to allow build-testing the driver with OF
> > being disabled (meaning that some of OF functions are stubbed and some
> > might disappear). I don't see how user-selectable OF provides the same
> > result.
> 
> Historically, the goal of this clause *was* to allow build-testing the
> driver on architectures which did not support OF, and that did make
> sense back then. As I understand it, building the driver without OF
> support was never a goal per se (if it was, then the driver wouldn't be
> set to depend on OF in the first place).
> 
> Some of my other submissions include the following explanation which
> you might find useful (I ended up stripping it on resubmission after
> being told I was being too verbose, but maybe it was needed after all):
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.

This doesn't seem to match the COMPILE_TEST usage that I observe in
other places. For example, we frequently use 'depends on ARCH_QCOM ||
COMPILE_TEST'. Which means that the driver itself doesn't make sense
without ARCH_QCOM, but we want for it to be tested on non-ARCH_QCOM
cases. I think the same logic applies to 'depends on OF ||
COMPILE_TEST' clauses. The driver (DP AUX bus) depends on OF to be fully
functional, but it should be compilable even without OF case.

I'll let Douglas (in cc) comment if my understanding is incorrect.

-- 
With best wishes
Dmitry

