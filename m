Return-Path: <linux-kernel+bounces-335453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE597E5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547742811BC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA12175AB;
	Mon, 23 Sep 2024 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ey99H2Qi"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E410A3E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727072194; cv=none; b=kQbU/daU5EmSITwNTW/DZ6quyFJabC7RMDBZQMUBF8ooC1Ik5LwJlxl8OLaYRQvGWgYjnsY4V5h+CrrWdgn0c6GC7WwSSWtjg3E9Jmmc0u91Iv+Nd95fYYrBbcxydySRg2x2/H/om2h62LrU2yWfhhz/PqQpBJE8SSvI4hUnHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727072194; c=relaxed/simple;
	bh=KiFYkoT5PyoVu7kqvo8vYE8SqLUhpD7OPhp89mVKlzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gytpz2In20JpzihWV+IH4dDV7INQDQN0+bCGFetAzgvZTp8RUkREK6htdJWH2hGk6bnpAsWp6ke542s2UYO8jChrWD0D0bfBcoYDvjjUB+PPZYx3QFm8+HJFi+MdBMQpAoRQKcjET49/mkcfKL9uVSEV8mWMR+Rl/7uoLwAvZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ey99H2Qi; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-537a399e06dso216298e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 23:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727072190; x=1727676990; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HsmFsHE7XzzhoDSXVK/Q5axcYBPq9FFiEYtiI/KoYqs=;
        b=Ey99H2QiprO/Qo0uiLxvnSmDgVoj30tTk3UA94kRNyivzCke3Fwzn+2fef/lHbO68t
         8EAfc3jq530Bg68h2GTTeo5s7s3Z7OslLC3AcOfHpFRUYikmOkgzddGe3CdBVomM2fen
         ByHcZk0iYANBqGvlcgXQCzT3Oqkm22mOjlKrQ8oksrVFv4Jdak9iXFlHHZPsdqAf+f6M
         SmFuU9JR80rwK0WDbx9CchLcgUNrRBBQJxnXLXXnFTDD2d4EGzVo+/JEIlCAPWrT7yNB
         HyltXB4QJkqT3VGf6fbnwsX+pGNfHV7ijqi9VoRAd0rTpJWcgao7LdTOOMVTFAfgfUMQ
         pqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727072190; x=1727676990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsmFsHE7XzzhoDSXVK/Q5axcYBPq9FFiEYtiI/KoYqs=;
        b=WehxlqCrWddw46J8VsyJRxKqbPQWmEZiE0aZcM0DHP1s6UhrCKh2QmJ69SbaMjctxx
         WEp1f31FlsmzbEXm3Ek9VnuOQh05ORQFK8ZwCtEeEkOP11fOjDtf7PIjJMZyFwhXnwhi
         CnpQM+/OH7OkR2Jpta8uAgokZpHJzFH0Ap+mBClkjuAhELATKLectxDvgK302fVqVHYd
         BjdwKmLFEEBgdKI3MIKsb/FjmYzMlDZ9IUlLCCZBvDeDgCM4NQBz80jV2b/e3yTwTsvd
         X+Cs9cICx2tUNqO7gDo955obmU9KqfsxwnUtFF63hSBLLD6RQt7xN82yQyXgXGISMt95
         zsNw==
X-Forwarded-Encrypted: i=1; AJvYcCUDyE8EqazuyD5dCiZs3p/zCQqdx9TO/cFq8YRPEe/QqOQM/0lvbgCEiVbpVflE83rf+YlZM9M2uFwqfPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweViSwZYoK+cX0vh8mVEvljaO/crZrCNDha8HFxUrQv+0LAI7h
	r7qabbeoqHia3c5p4IctMzpfigqR7dbJ5R/REHcRXWnU8b/IpwEeCnrIoZsYSaQ=
X-Google-Smtp-Source: AGHT+IHmW7JOpyVhjNX4M0lOzlw3ScfVv0bo0OAeE/aiMXJ6/c/MkV8H7Thi9KSkuorm9g8St/aSDQ==
X-Received: by 2002:a05:6512:695:b0:52e:a68a:6076 with SMTP id 2adb3069b0e04-536ac336d8emr4520518e87.49.1727072190066;
        Sun, 22 Sep 2024 23:16:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a86c7sm3192855e87.223.2024.09.22.23.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 23:16:29 -0700 (PDT)
Date: Mon, 23 Sep 2024 09:16:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes.Wu@ite.com.tw
Cc: treapking@chromium.org, a.hajda@samsung.com, narmstrong@baylibre.com, 
	robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Kenneth.Hung@ite.com.tw
Subject: Re: [PATCH v1] drm/bridge: it6505: HDCP CTS fail on repeater items
Message-ID: <kek5orlxcrejicq55mczj6gmjgq2pgynzxk2qup65iyuedcwdy@maird5uixbys>
References: <20240919025551.254-1-Hermes.Wu@ite.com.tw>
 <CAEXTbpc7N2v4LwoZ4wpHXi7ogyqGwYC3Gpt5sqfxtOpYrngPLg@mail.gmail.com>
 <nczuje3ur7sf7uqkygtziwnz5p6b4b7bf5on5crljr2ijmblrv@ym3fkvqxbjq5>
 <467ea5d3380843a1ad1f2f2429bb2833@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <467ea5d3380843a1ad1f2f2429bb2833@ite.com.tw>

Hi,

On Mon, Sep 23, 2024 at 05:21:41AM GMT, Hermes.Wu@ite.com.tw wrote:
> Hi 
> 
> Sorry for the confusion caused

Please don't top post. Answers should come below the original quoted
text, not above it. Otherwise reading the email becomes really hard.

> 
> Last patches did not switch to drm-misc-nest. And I need re-create patches.
> 
> The HDCP patches is now on tow threads.(This one and the one include MCCS patches with cover letter)

Just make sure that when you send the next iteration of the HDCP + MCSS
patches you provide the history of the changes in the changelog (either
in the cover letter or in the individual patches). Also please don't
send several patches using the same vN. I'd point out the 'b4' tool, it
can automate a lot of such topics for you.

> Should I keep on this thread or restart a new thread?

Please always send new revisions as a new thread. Otherwise your patches
can easily get lost.

I suppose that [1] is the latest revision. Please review and implement
the feedback that was provided to all iterations of your pachset, then
send v3 as a separate new thread.

[1] https://lore.kernel.org/dri-devel/vxs3eklfifsnaq5rn6kppegfv3plsviqaq5nvlzo3fgazwj6y7@od4atbvf5ep3/T/#u

> 
> 
> BR,
> Hermes
> -----Original Message-----
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> 
> Sent: Friday, September 20, 2024 11:50 PM
> To: Pin-yen Lin <treapking@chromium.org>
> Cc: Hermes Wu (吳佳宏) <Hermes.Wu@ite.com.tw>; Andrzej Hajda <a.hajda@samsung.com>; Neil Armstrong <narmstrong@baylibre.com>; Robert Foss <robert.foss@linaro.org>; Laurent Pinchart <Laurent.pinchart@ideasonboard.com>; Jonas Karlman <jonas@kwiboo.se>; Jernej Skrabec <jernej.skrabec@gmail.com>; David Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; open list:DRM DRIVERS <dri-devel@lists.freedesktop.org>; open list <linux-kernel@vger.kernel.org>; Kenneth Hung (洪家倫) <Kenneth.Hung@ite.com.tw>
> Subject: Re: [PATCH v1] drm/bridge: it6505: HDCP CTS fail on repeater items
> 
> On Fri, Sep 20, 2024 at 01:27:54PM GMT, Pin-yen Lin wrote:
> > On Thu, Sep 19, 2024 at 10:58 AM <Hermes.Wu@ite.com.tw> wrote:
> > >
> > > From: Hermes Wu <Hermes.Wu@ite.com.tw>
> > >
> > > Fix HDCP CTS items on UNIGRAF DPR-100.
> > >
> > > Signed-off-by: Hermes Wu <Hermes.Wu@ite.com.tw>
> > 
> > Reviewed-by: Pin-yen Lin <treapking@chromium.org>
> 
> For the sake of somebody applying the patch because it was R-B'ed
> 
> Nacked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> The commit message doesn't describe what is being done and why, it
> doesn't have Fixes tags, etc.
> 
> Hermes, I'm not sure what's happening on your side. I have seen several
> revisions of this patch with minimal modifications (and being a part of
> different series). Some of them were marked as v1 (although you've sent
> different patches as v1), other had v2 (but no changelog, etc). Please
> adhere to the described process of sending patches.
> 
> -- 
> With best wishes
> Dmitry

-- 
With best wishes
Dmitry

