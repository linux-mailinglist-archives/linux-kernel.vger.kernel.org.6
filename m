Return-Path: <linux-kernel+bounces-225584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C76891328A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 09:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A2F285541
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 07:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A5714C5A4;
	Sat, 22 Jun 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uft+2Pf9"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4372914C59C
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719040694; cv=none; b=Lu+y9dabzok8cJDmg8ywz27NLKhaEGu5nOvmJCx9+amJH8vWA+AtrGr34g67+SgPrxQvf7/FVmJTTmKzB4qv7HBllwMxjGXyUEMcWEUEfS4CSuxsngEDGj9GXaDr1B0AkpUZb7kf0XbBE6USpm41GpU/qMXJwa7zICbVru24tLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719040694; c=relaxed/simple;
	bh=Dwh3hngqTIwFb9W9PD6nYsx0EywIrvynYVJ8Zbfh+NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBrOtfTAy+MGG/2vKBfb3dlNOxm1qwL438xPy/UM1fysOj0vXU1ZV4eeF2wUoG7KLUPeqxGoAtcrxP95qJr8akGtLY0G2xJXyzy9kl/Nwa9qGjLA1B7EgIgiuJaX+FKs4WpvyY70G4Zi4gcMsy4EaOT0R0Qd1f1cuabr3iW9TIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uft+2Pf9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52caebc6137so2904765e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 00:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719040690; x=1719645490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gk/WLnrU93BmHjjlJlU9hm1kE/s/S+tE20JTbJQLcY=;
        b=uft+2Pf9nsEFjIor9cavmXcCshY19VLeboJsSUyAhRqR4/cRu89yH064Izsxtd9cEk
         4uqBB3/IUx4aBy9X21kZfPrF5gaOKd5bmYIarSM3I6BMpdbwy2mnMMVGhLmUJBiRQuAC
         ELjnE4HeiQYpmRHeq2I+A+dQERnu3JMVHhiYtMqU4tyIUnvlx/IssrRupyMEueD0C2I0
         /wjcVeyESSt9Vq5o7k7ocuyvseXkiGKGBl2+23aQnhgVtIwKuC7ZAKkOy7fhK9ZwjhZW
         rAWYfxm51zGsSFMA2eYVVeitMEE6OYs0HVRHsWVu0GpiwyxTA63h5/zH879N4QpYt3At
         LxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719040690; x=1719645490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gk/WLnrU93BmHjjlJlU9hm1kE/s/S+tE20JTbJQLcY=;
        b=sGV70sQrCh5wQUSwfXrjgEqzkBJYPoUrSTUWTpxMmJevmBqfHQf0k4e40YpTfLdC1x
         13VQjaedOrzbNI1fdkKEguNkm/Hk17sr09YkhmFo6SMLNRw7n1cg4Ef5dLwa6wjsq8BL
         NQhW40a62XEm/gQjVkno7vDzkqhK9o5ozNfxTwvUZhgT1QkP02zGsWSml3BPXhuJMhEs
         vNRp4aUabaM/7sQNiZcKEl2amgW86j8dd0/rYFamMJdc0lakTK++qa6zDDebJnaOnaUk
         TCALWH/HPKrZfRTQAd/iyj/vqEk34Pk1LwHqpIRFYoaMWTjIc6JGex8QyCWySzeadfpa
         9sBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvZFuzTnK0M3WHg2JQiL7Eh8TLA+ojY7rlHjIeMhKSIom5ZHBkVLsav5ITZTiNb1PI1oJ3/uLKQ81FnF94Zp4alzQBeMMsWK4UeVmF
X-Gm-Message-State: AOJu0YwDv9rHlIvkI9WaQUzrHcgDBO56D+L5GxfgLOJ6DDLxh7VEcWol
	ffEQUg32jHudBzfRWHuEVsetJbXPXWP//bSuGvXuOmwpUBGzAYTlWBFnjhvA+aw=
X-Google-Smtp-Source: AGHT+IGH6cKb0i17ESt2t11EWg7ayk6aCghT/OhE/tqOJdP/a/WQUFUKJeG5X8SncZ7fxcARxG/8OQ==
X-Received: by 2002:a05:6512:3e02:b0:52c:5f12:5317 with SMTP id 2adb3069b0e04-52ccaa9268bmr8340293e87.44.1719040690325;
        Sat, 22 Jun 2024 00:18:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd6454a96sm409678e87.303.2024.06.22.00.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 00:18:09 -0700 (PDT)
Date: Sat, 22 Jun 2024 10:18:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Simon Glass <sjg@chromium.org>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Amrit Anand <quic_amrianan@quicinc.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Andy Gross <agross@kernel.org>, Doug Anderson <dianders@chromium.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Julius Werner <jwerner@chromium.org>, 
	"Humphreys, Jonathan" <j-humphreys@ti.com>, Sumit Garg <sumit.garg@linaro.org>, 
	Michal Simek <michal.simek@amd.com>, boot-architecture@lists.linaro.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RFC v3 0/9] dt-bindings: hwinfo: Introduce board-id
Message-ID: <uz6f2tie4r4zlywt7vgeb44zl7hoxzdkmdsaluch2zlpp6cosi@jfhmdj4zbii2>
References: <20240521-board-ids-v3-0-e6c71d05f4d2@quicinc.com>
 <CAFLszTjexpNEjo1sGVs67L0CAgGZLNkyn9RGfHRD7iHak_mtmg@mail.gmail.com>
 <20240605100246481-0700.eberman@hu-eberman-lv.qualcomm.com>
 <CAFLszThbe_aUAq_5rCCiPV-bj60oq9UCc=vdDHwM3i6t44ohLw@mail.gmail.com>
 <20240621142054973-0700.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621142054973-0700.eberman@hu-eberman-lv.qualcomm.com>

On Fri, Jun 21, 2024 at 03:40:20PM GMT, Elliot Berman wrote:
> Hi Simon,
> 
> On Thu, Jun 06, 2024 at 10:00:54AM -0600, Simon Glass wrote:
> > On Wed, 5 Jun 2024 at 11:17, Elliot Berman <quic_eberman@quicinc.com> wrote:
> > > On Wed, Jun 05, 2024 at 07:17:35AM -0600, Simon Glass wrote:
> > > > Hi Elliot,
> > > >
> > > > I am just picking up the discussion here, which was started on another thread.
> > > >
> > > > I can't see why this new feature is needed. We should be able to use
> > > > compatible strings, as we do now. I added a 'usage' section to the FIT
> > > > spec [1] which might help. I also incorporated the board revision and
> > > > variant information and some notes on how to add to the available
> > > > suffixes.
> > > >
> > > > Does that handle your use case?
> > >
> > > -rev and -sku don't fit the versioning scheme for QTI devices, so this
> > > isn't a generic enough approach. Patch 5 in this series describes the
> > > versioning scheme for us.
> > >
> > > In the other thread, we had talked about using some regex based approach
> > > for matching the root node compatible. I haven't had chance to work on
> > > that proposal and will try to get to it in the next couple weeks.
> > 
> > OK, I look forward to it. Please do check the FIT best match approach
> > and see how it might be extended to handle your requirements. So far I
> > have not seen a need for regexes, but it is certainly a possibility.
> > 
> 
> I spent some time collecting feedback from the team on using compatible
> strings + regex-style approach and we're not able to add a regex library
> into firmware, so this approach unfortunately won't work for us.

Why? What is the size growth caused by the RegularExpressionDxe ?

> Because we have more axes of board identification than chromebook, using
> FIT's compatible strings isn't a scalable solution for us. I don't think
> we have incompatible problems, we only have more than 2-3 axes of
> information.

Well, not using compatibles / strings results in most of the phone
vendors having just the 'MTP' as their platform id. It makes then
impossible to have an image with several DTB files targeting different
phone families from several vendors. What looks like a nice feature for
MTP vs QRD vs HDK becomes useless with the end-user devices.

-- 
With best wishes
Dmitry

