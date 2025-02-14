Return-Path: <linux-kernel+bounces-514856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F8A35C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D8716EADC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA8E2638B0;
	Fri, 14 Feb 2025 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnn/A+eA"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2115C204086
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532630; cv=none; b=ESWIBv3oFdnehoPK4AsCTRQ90yLA2azBDSWbaA6D1EvXvZ/yHViPA3A4iOcBXtI+Se6s2ZaV5INLctnT6CUSd7ToevPw0C0hGr4EmWtv+oJsN4rMBugtPZ2Wx20FcoHTE9Ph1FwGy0d6QF4sX0lLQEjU9zLS1Sxw4QxcQYVwCMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532630; c=relaxed/simple;
	bh=aOk/8lcb5DDM4fG8L4cmHtutp/x17bXsj0VDjmgE+JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV5fwT9H/zOtwLn7S6l2wnSDDeDtyM0tUsv4MlEzBSmXEhmTP6YPoZde5vXeU/Jrp8MLTfjOKR4aEuZccfjk2r0tYRAOkPFaO9BWwFFa0igVrovS6wSgDbXE7u2I/j5INpsypvw/5ws5iigCdjRS6y64li78at45LIcWLHe7sDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fnn/A+eA; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30227c56b11so19955511fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739532627; x=1740137427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUXfDOQe1PjE/GwHmj5OmmzZEaxV8TIkFPa/Dhe7pKw=;
        b=fnn/A+eAFIO3vUswb7CBk43/CDMnQzrg811ij+Q096mVa2AbZdPxfZ1B0Tx3KHTQYN
         L5HZiXKbybrxpmKhv+YTMJAWeykIptM+5tDrVW0rNCdTWnoJTw0+PvflZ6aVE7tD2M9D
         gD4ryPJSsWXDSvzkIVFQAMyXVdn6ugbaWMgC5ncvs0HygEh9ZOvk0Iu8kH0L8cLTln+h
         +9f72ixpgW+L/gxPzAruamoSwzN3OUydTsvjkgHM0pdSuJoMZvcHnY86qsl+9TAmgRHa
         ph+UbrBARG5RefCCFcTK/xR8RdFGSm1ymDpP+5R1DajWBdvmuEjnF+EmNcZqtmvucaPO
         wqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739532627; x=1740137427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUXfDOQe1PjE/GwHmj5OmmzZEaxV8TIkFPa/Dhe7pKw=;
        b=J6W1x+JnuOmHYWSINM/DKNBAN1CCp83dXe6qGtt7z5y7Ev1Z3ygO1lnFudR6zQ/Tyx
         FKokwtrPM9VpyHdN58gn70swToSJjdWzp09pxFla1mHDAUcXnEwAWlga2ON5uizuCCs5
         /MkbVoQlJRcdTIO348cV519j8xT6xhH/ivdlFcWecVz8ZFb5CrI3Yvzi8crxeJF/jWiL
         RJ/FHlBTh9T4YNbkglmGFDnPCClb1mV4l+e0mbkAbLqp0HJNoDAH7LpXrQuP9mla5Rpi
         duAq9VuJVaYgeH5fNLxUynYSnK6YWutKHM6n/3tZeRBYAlV8OTqHKxtiIV4XRX+g5etf
         jw8A==
X-Forwarded-Encrypted: i=1; AJvYcCUIyWyFRPYJU/cy5HBYN8DgnHnaFnsym1hUzCJCjQdFuCQbtQu7J/AmUIdlm08rrXhnUp9mxdl92Ia76t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuVB/6Ot9HPPt2hgfQ0JvKwrt89dWp8t8BDoGaFbhGClvpBpEm
	VrKQYelM9tIsUHRmdGHhAJm/BbThO6/d1CmBAtoAnElhtyhluN9UcxCyGMScnfk=
X-Gm-Gg: ASbGncvQv6Nf8iw0PqjLXp9hHLtx7z93Klf1ofs1p5Vtx2V71OHv48haHSBYdIHSN02
	0x24A9ifA/iQvbyir+2fgVy9H2vuq+7B+k7m802lDUCJM/zShjudMjlYLVOufeZMTFq0K6xTHob
	+y6MJ3xGYciXIXH1Yn/aMfBRLNMnys7/ccnkSJNuUF8RUTTUS95/Fe6FXOYynBSWFvIaixNU6VD
	QJ36gAWMoQcZbeYlR6wbO/px41Bt85zO4WlAQFSRGKlpn6+d7vmqfSBqpqASfN80HtTbKp+l4aS
	L8yRPUhiGmrazfFpGNId3vntKGeAdzPuqOYf3yPIq8PYN4JbOrkPEVQIBtBxIFuKBEkGJyo=
X-Google-Smtp-Source: AGHT+IG1HjnIzHq0g6LCLS2rLFVsIGs1tP/QSpXsX3Vtdfzqpm5vZz4Yto5JghYhTAcD6DaFR7+wyA==
X-Received: by 2002:a2e:a58a:0:b0:307:e498:1269 with SMTP id 38308e7fff4ca-309050e318bmr35230061fa.37.1739532627133;
        Fri, 14 Feb 2025 03:30:27 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091029b769sm5097411fa.101.2025.02.14.03.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:30:25 -0800 (PST)
Date: Fri, 14 Feb 2025 13:30:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] drm/msm/dsi: Minor cleanups
Message-ID: <r5mq66osrzle4xbduvaqhv4ypqc5dfkjrhvqwchjmni2q32sbd@gh77gkgj3imp>
References: <20250106-drm-msm-cleanups-v1-0-271ff1c00795@linaro.org>
 <ad2bc7a7-2e28-4599-bb94-fd66fd2ba88e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2bc7a7-2e28-4599-bb94-fd66fd2ba88e@linaro.org>

On Fri, Feb 14, 2025 at 11:52:14AM +0100, Krzysztof Kozlowski wrote:
> On 06/01/2025 09:49, Krzysztof Kozlowski wrote:
> > Few minor improvements/cleanups why browsing the code.
> > 
> > Best regards,
> > Krzysztof
> > 
> 
> 5 weeks on the list. Any more comments from DRM side? Can it be merged?

Are you going to repost for the patch #2 commit message update?

-- 
With best wishes
Dmitry

