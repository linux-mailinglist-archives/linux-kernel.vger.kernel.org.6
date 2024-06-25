Return-Path: <linux-kernel+bounces-229653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE13591726A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06FE1C20B21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9396217D889;
	Tue, 25 Jun 2024 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lOZfsHmd"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499716FF52
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346815; cv=none; b=CDd4cY/sYv8qGuwtthrfw158zOnR3fQLgI8XhzEg6wJ6mAqTgP2wBI2At8vFJpXgLp1r57oDTZ/2hiXnsd6moNzVVfIi+5pRX25xsl8DhQ35YRnYWgR/aDzfmESnfEufdOU6wl0FKfCf8V0WM/h2UUMiSZcoCMN2+5lEayJm5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346815; c=relaxed/simple;
	bh=5y9LBhcsnEYEf+f1m7NNXon4iChTwxBnf532sB4veBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrwWO39A9S7NMZZQGs+9TpZo8rRbBMOtqV+OfTWS1JNVvHveeq1mkfF3nRk8XS0SyMly4bywQMzHHT9lI5tbLXORfO7CAj7SqqY0gyOZomuyjhw+C9r+EPGVb/Xg2SOcDiHTAxEPkrFSKRcEGtI8d8T7D+3bHhYROahP21mxJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lOZfsHmd; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0272692096so5163728276.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719346813; x=1719951613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DALwJlK2ARCJSSDqUvIVUXkdGRcly/r/299uWG55Xls=;
        b=lOZfsHmdVfNt1LB7bD4/KHrXDYRM/QQta4JjjGXx702P4hFp4BWabHyoHVjOowvbW6
         WBlNBD/cqJoJ01DdIdt4yClC0FKUdW1bRZgUKSIg68Xs7pNFy6ziNrar653RqQAIEya4
         22xU4CuTlv6QDdLkXIviabbo29pRY1+m5GZGLHqXmrxb+MT4DRqVTNofi+h5vztskk4U
         4JGbqta7vIuJQQvh/CNllBK4WX73mCBsftrVKVYDocnvRW9VHFysp+h175X4ItMBmWXz
         QEkkHNs1LmVnT2+D2xUHma1esnPHkRKYJ0lmzTUj0bh9vVo7vr1CWn/kqOl7kIiJJavM
         u0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719346813; x=1719951613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DALwJlK2ARCJSSDqUvIVUXkdGRcly/r/299uWG55Xls=;
        b=vxRnhYGKodQHTYzOjnrylNT1mUnzUKCzFTY2ngsJAiJeJq2/tzX0sKAx7/xgNSLmT7
         HC31zpTSAVxtmhO5+v1ExX2jCTbbRIfuijbc68zvecZfeQKbNQsLrOyaSTXlMPRCaxD+
         pWoh2DjDr8LYT0/le9vTOStwQ+/Gv9BzmHh2A4h08sIV9AplzSpMT5KptEYdlR4gj3sP
         F8lLJVrr8uHwwoasm7IuzdKVrVr2gmGzF5Sy5f86R1vtI3OpH3pW9JKUu7cg2baphprD
         7PcjILIM52MtAX9iOpBHY5Xxtfm3kjxSPB9VgglmIwFyHwSfi8kPNzJFOeaPBCR3asUf
         flOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3xIQwTeltNTjjcPuzZT1BI3lcXQgMesucArVNJdYv2ErfxSNb3QAImn8x3wyvEswnD//RP6S05n4klDJmaMwzaK0ghldfWw9CmPJI
X-Gm-Message-State: AOJu0YywVAkSLvDYLJeHjadUozfLm+kUCapr8QLfDD0fSpARro7Fe/ND
	yErpLKYOOzPmIDz4kn6pdzQgG3n/p73LLvt04FHCGXNH2H0HFcNIJIOCZLhcksKPzfKRAapibo0
	RkBuxQa4m3SEpJhusnuFaj9dIY848Iyc62Ht7bESpbLGd4uIK4rw=
X-Google-Smtp-Source: AGHT+IHc1N8cdXnOekY/fB5EQn9UtYA0M5VUrWEfImUf2l5menZg5peEHCsjMvw2qLy6pLFOXbVvbc4dD7/Rh87mw18=
X-Received: by 2002:a05:690c:4905:b0:646:5ae1:b74d with SMTP id
 00721157ae682-6465ae1bb94mr47631727b3.48.1719346813387; Tue, 25 Jun 2024
 13:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-dp-phy-sel-v2-1-99af348c9bae@linaro.org>
 <bbdb8f56-4948-b0dd-55bd-ca59b78ed559@quicinc.com> <0ae0fddb-07f4-3eb9-5a62-0f7f15153452@quicinc.com>
 <3a5f68fb-2487-bda0-91a1-18ecd414937f@quicinc.com>
In-Reply-To: <3a5f68fb-2487-bda0-91a1-18ecd414937f@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 23:20:01 +0300
Message-ID: <CAA8EJppd8Vm5uGzzVofWoTpVkfxE5atv6VOt0WMUsu4oYP1UZA@mail.gmail.com>
Subject: Re: [PATCH RFC v2] drm/msm/dpu: Configure DP INTF/PHY selector
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 22:28, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 6/25/2024 12:26 PM, Abhinav Kumar wrote:
> >
> >
> > On 6/24/2024 6:39 PM, Abhinav Kumar wrote:
> >>
> >>
> >> On 6/13/2024 4:17 AM, Dmitry Baryshkov wrote:
> >>> From: Bjorn Andersson <andersson@kernel.org>
> >>>
> >>> Some platforms provides a mechanism for configuring the mapping between
> >>> (one or two) DisplayPort intfs and their PHYs.
> >>>
> >>> In particular SC8180X provides this functionality, without a default
> >>> configuration, resulting in no connection between its two external
> >>> DisplayPort controllers and any PHYs.
> >>>
> >>
> >> I have to cross-check internally about what makes it mandatory to
> >> program this only for sc8180xp. We were not programming this so far
> >> for any chipset and this register is present all the way from sm8150
> >> till xe10100 and all the chipsets do not have a correct default value
> >> which makes me think whether this is required to be programmed.
> >>
> >> Will update this thread once I do.
> >>
> >
> > Ok, I checked more. The reason this is mandatory for sc8180xp is the
> > number of controllers is greater than number of PHYs needing this to be
> > programmed. On all other chipsets its a 1:1 mapping.
> >
>
> Correction, number of controllers is < number of PHYs.

Thanks, I'll c&p your explanation to the commit message if you don't mind.

>
> > I am fine with the change once the genmap comment is addressed.

-- 
With best wishes
Dmitry

