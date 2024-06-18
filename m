Return-Path: <linux-kernel+bounces-218892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2E290C772
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6B7284F50
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547081B5814;
	Tue, 18 Jun 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqOs41jZ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA1815279F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700798; cv=none; b=jifn8ri9gH9tmVMg5uR2evocZ2LDV6kqzyg9huRkryqfB7TICTkmFNlPPbJo89jcw6w60eRV8zbljguTESj4Y3GqD3Y+Nqi2rpoUOVNUTNVzc/8DY1yYL+5ewXTBGDy5r2ZpTMg8I50lgmMc2TsJJkPcUb3OSqd5zOWfLIRs2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700798; c=relaxed/simple;
	bh=RuQ7uu+pYGcqSmZKCsPEtQK2tIYuAQvUzRvdyFLI0GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hho5GGN7QkmDaq8+L43WbRKOEQDMngrWm9ZIDq00VdyM1lXUEtThVzRmY5ns2bsDUR1qIZPP0UiZwa0TNtGtbry7OUxCY+BzSWzMiu+G3ZpbacXa7466Q6IgEO2D5gItrpNoXfChrWk26j4bucgN8uRdqnPz3rQDLRvH50NDfoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LqOs41jZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so54827601fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718700795; x=1719305595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sVER3ppowxMPvCNe3SDX+A7Me1Hrn33qQHZFeWMqsbE=;
        b=LqOs41jZIzrZY/Kjjmb+aNuIiAdu8YiDp/VGiX1CQH+aGqRKWo+Gt7aI7YSpoVSIBK
         CVX+pZj5a2TOtBIZZgrNdn8V1kwqGe5dt5Fbnxxt10bx6CgaFbSMT5MQlEc1qgjDjydq
         wCXJ6y4sLPdiGnSH4zDq1l1YUanTqUTZjPPo41+Vwmbe6osfUeUtsqX2/u9V7HQxL9ra
         6/4lfCBFqIwyBKAJKZqGPx6dgaLtL0jSImTxTBIPfAIA6rnrsPlHr+ZQ4nwg9YyQIa9q
         1HI0QyJ5yMOHhOFUHdOKfNhqwZmUJNru5gPYjiP51GSm1t7zTV0tuppFdv2Hg4NqoDoC
         FbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718700795; x=1719305595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVER3ppowxMPvCNe3SDX+A7Me1Hrn33qQHZFeWMqsbE=;
        b=XkGmav2SpyyzRGT2PxVa+DUMDg5mfjl7ZRmtsQqnJBrvAXXoqeZVK8nk7t0B4mszxG
         4g10cxONZdM4wIPg0G9CjDtmlr95mbZNNgcZDXTqSFfwwq0P0yI7jEh5YuikVTj9xHsy
         +2drCaPtjSj79Ehp2cY990xOLJbQNCgUZCD3KZDC82fS7zy9c3zrjRfJF1tQtj9ik3IZ
         twADWsXKT9dJajbCpfTrk2II03Ta4lN0ASR+gw6WS0SwvwcDVSBCFMTDDcXAy1gyHE8t
         ABpb9YTCJr68KB6b9Iq1xyVOmeNF7sarrjhD58InIns8Mi8IBYiLLFpoH+B7H1SnvOhW
         iC4w==
X-Forwarded-Encrypted: i=1; AJvYcCWFbmYDX3EHi+eYrk4+0xCINxOZfaReu6yDU1v9P3f8LHNSPRBMYqt8t9BBsMsehNm/5TtCRbdkkCa81mklUcl4d9k4vBxpAJb8/w72
X-Gm-Message-State: AOJu0Ywy8S9Vh6Qc/j8/DkHR/DXJ2dtmRQohVkqLoujlsKMMOrPPP9Ri
	p0XWbgji5vg2740Y1PgEKwfm+gWKNa9pMSI4TsZPWcCAcf78dTZ7Qh2joHtJBmA=
X-Google-Smtp-Source: AGHT+IHjljSrzg9NpUqW7k5AdRVnTpSNq4ainlTzhMuboYE5T1cHBMCyozCY9/8dplx6irn8mzOGmg==
X-Received: by 2002:a2e:350e:0:b0:2ec:2b25:3c8e with SMTP id 38308e7fff4ca-2ec2b253d64mr35720221fa.39.1718700795066;
        Tue, 18 Jun 2024 01:53:15 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c7840bsm16409561fa.98.2024.06.18.01.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:53:14 -0700 (PDT)
Date: Tue, 18 Jun 2024 11:53:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Jean Delvare <jdelvare@suse.de>, dri-devel@lists.freedesktop.org, 
	LKML <linux-kernel@vger.kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Andrew Morton <akpm@linux-foundation.org>, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH RESEND] drm/display: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <w2el7qxjvc2utmgn24l45ltuh6gjre6pfgyd44ehb6iciwfxck@rg7sdypno3pe>
References: <20240617103018.515f0bf1@endymion.delvare>
 <xd2yybtxvzte7gwqwg2vudzvhoekqao2dle6zsuduzjzi3rsay@xhahwof2prph>
 <20240617132348.5f20bf89@endymion.delvare>
 <vsrsvmrkqnmxs3ncqv5m2gevzefiq55tr2iolxlmoehsvgcfkn@hyx37vax6r5e>
 <20240617201814.73a07702@endymion.delvare>
 <jbqbn6zaqq7j5htxuqxb34tjrf5lnqabkh5ywtnklhd4owyc3h@ztvolr6hjrti>
 <CAD=FV=X4qVDTOdMFQeEiJi2DD=tuEj66vP35XQKrSj5-r_YADQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=X4qVDTOdMFQeEiJi2DD=tuEj66vP35XQKrSj5-r_YADQ@mail.gmail.com>

On Mon, Jun 17, 2024 at 07:12:05PM GMT, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jun 17, 2024 at 3:26 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Mon, Jun 17, 2024 at 08:18:14PM GMT, Jean Delvare wrote:
> > > On Mon, 17 Jun 2024 14:55:22 +0300, Dmitry Baryshkov wrote:
> > > > On Mon, Jun 17, 2024 at 01:23:48PM GMT, Jean Delvare wrote:
> > > > > Hi Dmitry,
> > > > >
> > > > > Thanks for your feedback.
> > > > >
> > > > > On Mon, 17 Jun 2024 12:57:19 +0300, Dmitry Baryshkov wrote:
> > > > > > On Mon, Jun 17, 2024 at 10:30:30AM GMT, Jean Delvare wrote:
> > > > > > > Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> > > > > > > is possible to test-build any driver which depends on OF on any
> > > > > > > architecture by explicitly selecting OF. Therefore depending on
> > > > > > > COMPILE_TEST as an alternative is no longer needed.
> > > > > >
> > > > > > The goal of this clause is to allow build-testing the driver with OF
> > > > > > being disabled (meaning that some of OF functions are stubbed and some
> > > > > > might disappear). I don't see how user-selectable OF provides the same
> > > > > > result.
> > > > >
> > > > > Historically, the goal of this clause *was* to allow build-testing the
> > > > > driver on architectures which did not support OF, and that did make
> > > > > sense back then. As I understand it, building the driver without OF
> > > > > support was never a goal per se (if it was, then the driver wouldn't be
> > > > > set to depend on OF in the first place).
> > > > >
> > > > > Some of my other submissions include the following explanation which
> > > > > you might find useful (I ended up stripping it on resubmission after
> > > > > being told I was being too verbose, but maybe it was needed after all):
> > > > >
> > > > > It is actually better to always build such drivers with OF enabled,
> > > > > so that the test builds are closer to how each driver will actually be
> > > > > built on its intended target. Building them without OF may not test
> > > > > much as the compiler will optimize out potentially large parts of the
> > > > > code. In the worst case, this could even pop false positive warnings.
> > > > > Dropping COMPILE_TEST here improves the quality of our testing and
> > > > > avoids wasting time on non-existent issues.
> > > >
> > > > This doesn't seem to match the COMPILE_TEST usage that I observe in
> > > > other places. For example, we frequently use 'depends on ARCH_QCOM ||
> > > > COMPILE_TEST'. Which means that the driver itself doesn't make sense
> > > > without ARCH_QCOM, but we want for it to be tested on non-ARCH_QCOM
> > > > cases. I think the same logic applies to 'depends on OF ||
> > > > COMPILE_TEST' clauses. The driver (DP AUX bus) depends on OF to be fully
> > > > functional, but it should be compilable even without OF case.
> > >
> > > The major difference is that one can't possibly enable ARCH_QCOM if
> > > building on X86 for example. Therefore COMPILE_TEST is the only way to
> > > let everyone (including randconfig/allmodconfig build farms) test-build
> > > your code.
> > >
> > > On the other hand, if you want to test-build drm_dp_aux_bus, you can
> > > simply enable OF, because it is available on all architectures and
> > > doesn't depend on anything. No need for COMPILE_TEST.
> >
> > I'd probably let Doug respond, what was his intention.
> 
> Is this me? This looks like a straight revert of commit 876271118aa4
> ("drm/display: Fix build error without CONFIG_OF")

Thanks!

> I don't personally have anything against removing COMPILE_TEST for
> this given that I wasn't the one who added it, but make sure it's not
> going to cause randconfig issues.

-- 
With best wishes
Dmitry

