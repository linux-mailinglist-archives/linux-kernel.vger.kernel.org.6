Return-Path: <linux-kernel+bounces-417545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0349D556F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C778EB24296
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6291F1D9A6D;
	Thu, 21 Nov 2024 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwIK5szI"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA5D1CEAB8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227998; cv=none; b=qccV6EStVwIrNPqILsgulpECQlEqC3CWxtchTSeAX/vmVLATt7Mx8TKYo6NgoaNmi/bP6lUVwQ5udknxEHTpe27yOzGjampcTRouZdxTdbSDvy+sZdhd2aNyJl3kz0+Nc5hk2ksk2iiDfBlJg/2/PqrAaFD5C7/i4ANieZmEPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227998; c=relaxed/simple;
	bh=MwpJjmqk4TaUXolDoFjm8xRXP+trTfjnw6QHzDw4V2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJW0YKQfzqLGnscjKZlL/Yx+rt+CH9J1m8XQow7ABzDvV9U/R5d1GluGIan0C5rHqXXub/enyPus4gm2YUl+MxISplj+4Fx16ZG4sB3H3YMYrOImdutJVz21ZktKZZJlBCI58+MJelj0xYUSdKxarKewETW4qnwtjLKJI8fWr3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UwIK5szI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so1594414e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732227995; x=1732832795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=67XPB05AyK/btByIcMqDcORxZdqhCZravm4pxfm3Pu0=;
        b=UwIK5szIklVZ+K8cHMJgeCno0m0tJ5dVaS/TR+mw7/db0hq5rJfH0TywIvegraB+uH
         V+IU2DeXkGBH/bx/5XR3E8XpZSU0OsO4TExqIxVqANJ6kzuaFSDqtnFcW1kxZKIdVyZv
         HLYbTZIM2o6OZABSqsigaSwOchfvcz1TaLnamHVkKT4jRWbn+RjXQqRLZwuIqc5M+A8t
         DPRKAtI3uWNQG/aRbk1dkQnxMJUR1W9a4kYjcMAy/1Q/cYf0b858zTviGASE/qAT4zcJ
         YhlB0XQF2l+Ky7iSQS5fmDJkvyBZvH/GXk/L8e4Yw47HcjRal4E1NMfCzBZrP7HJDJY/
         aCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732227995; x=1732832795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67XPB05AyK/btByIcMqDcORxZdqhCZravm4pxfm3Pu0=;
        b=hpT+u/vspmV1vusUIZ4MwGvoF1WnJTwy681VlBTORk8Gq928G5Xu2no20Va1E6Wo05
         gaRoU+kKKBp04PMifkeZ27hwhqX56tfYwtyaYzXHz7KsB8fyw5cjDQfkiM1DwfKmLZT8
         QXKfMgBSJrPW93IbrvFrBWoOdvC66A/jNN0g4g+rstiObH2vFw4YCjGe3cySBqUQUoYr
         ufkzV4L9t9mqesIi0xajfeavDXuLUJZrl/W98/C9blgCGi7R72YVebIZ5IdmFQy1voJk
         /qPD1D33aMlsFRvyxowBfVhQ/jTJa/QPtJg348RaYCatmx4jiCaLosrVbNeKZ0N2yaNj
         RGSA==
X-Forwarded-Encrypted: i=1; AJvYcCVDpP9fp6Unhh9smXaczLgkpblwPrawVZJJ2d8XqGlPO1vjccyxS/sgGQ8wDwf6Y13UyoEU5ILiQpEA+kE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4x8b8ACymnzWqtt7TcwBMmoA+scSguOZ6ftkWdP4KyCTltfW
	1IIVgU6cOPGyceZA9rGDfLLu68/HK16Nn3mvW8n+JmM6WUQ/u5bIIcXYZQtppNE=
X-Gm-Gg: ASbGnctEjwOJpl1o07R2KwCV4a43Zf5w6W3X0jM0PTBsaGU3sV2IO9gIUpPg47hSsKX
	dJFGVDQZmcyKDJW3ge8cmSjAqBGxCeeIexKMNntiX8cV0xA44m2jgwLf/9mpflyLYT1WNNvAIT5
	NBomNUc1Sqh6a/cVVHWXIeFptM3Jxj0Zm+WukL7dfCCsvtgreVVZC07vi3wYeTaxYQdxYuBPjlh
	82pwvscC3Wfyaa2cPsgv5A17lZRjJnKp4ijUdd0ifRro7HBsCblH9/1t3hDR0b70vo6KJ4pAhs0
	aRJP9Uow2uH4ZXJ5niKl2Fb49eG2uw==
X-Google-Smtp-Source: AGHT+IGyBizlR5e3z6q8Kh1rpMDNes/K8kFNxBRPrj+BG0t/rWUv5BsFgygFTTFBPiukIv0RjnFnNg==
X-Received: by 2002:a05:6512:3f0f:b0:53d:c2cd:79d7 with SMTP id 2adb3069b0e04-53dd39b5b70mr266678e87.53.1732227995234;
        Thu, 21 Nov 2024 14:26:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd244574esm99474e87.33.2024.11.21.14.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:26:33 -0800 (PST)
Date: Fri, 22 Nov 2024 00:26:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Akhil P Oommen <quic_akhilpo@quicinc.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/11] drm/msm: adreno: move features bits in a
 separate variable
Message-ID: <ch7vrgkjnhabjdw53l3tjqv4p7oyfcfsgctlfb7gxpm5qiqs6k@5vkjha5jkfy6>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-3-4deb87be2498@linaro.org>
 <fkezpguictntg2wkouwqipnaaiauo6vu46n7a2xzvlorzvyeaw@bbcpj3bs5eko>
 <CAF6AEGs6zT_kaTXNohUaA7KWZxZTr4byaoMoLAceuyqA7S+2CQ@mail.gmail.com>
 <dtt6d427u5yep3i3b3zxxef7uh572aeu3vtatmjvpbqfpjbvjc@epkkr7oumncn>
 <CAF6AEGsr2WoOdytWzDU_TJJh4myPj3B943LMisxisnA45rLFKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGsr2WoOdytWzDU_TJJh4myPj3B943LMisxisnA45rLFKA@mail.gmail.com>

On Thu, Nov 21, 2024 at 11:48:28AM -0800, Rob Clark wrote:
> On Thu, Nov 21, 2024 at 10:44 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, Nov 20, 2024 at 10:54:24AM -0800, Rob Clark wrote:
> > > On Wed, Nov 20, 2024 at 3:18 AM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > On Tue, Nov 19, 2024 at 06:56:38PM +0100, Neil Armstrong wrote:
> > > > > Now the features defines have the right name, introduce a features
> > > > > bitfield and move the features defines in it, fixing all code checking
> > > > > for them.
> > > > >
> > > > > No functional changes intended.
> > > >
> > > > I think it might be better to squahs this patch into the previous one,
> > > > it would simplify checking that we use .quirks for ADRENO_QUIRK_foo and
> > > > .features for ADRENO_FEAT_bar.
> > > >
> > >
> > > IMHO better to keep this separated
> >
> > If they are separated, it is easy to overlook presense of a statement
> > checking .quirks against ADRENO_FEAT_bar.
> 
> Maybe just drop this patch.. we don't really have so many
> quirks+features so a single bitmask is fine and avoids this
> wrong-bitmask-problem in the first place.

SGTM too.

> 
> BR,
> -R
> 
> > >
> > > But we don't have _that_ many features/quirks so I don't find
> > > combining them all that problematic
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

