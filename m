Return-Path: <linux-kernel+bounces-430920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1F19E3737
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E7A281664
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0771AA1DF;
	Wed,  4 Dec 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQ8oa7oY"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2547618A6BC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306988; cv=none; b=aY0JiuSdng7VOpXsc210R+9gxk0lNKrKOwfho3uDEm81I35a+Tq6HzZZUYt57ooczecmnAKROngUwoaTwfy47Q60ZIX8VL2W7zsqmBMhHAKFkm1o2VkmfGKObqds+VDqCeOHjNtFeiX7a0W1evvDoEZTqWcv107Zod/gzGgtfGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306988; c=relaxed/simple;
	bh=BMQwoaYseFJ8zeLch2xIJKZwOwqQ/RVh74KuCupqhhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETATsDNUhgBmWzdZkxZiCGsBh9fl6w2DyxYFUhWOgMXIknvj2eghUJZB4N4jIhhcGfQ02EGVkjHU56ycOGBnEJX1hTecSKCZxFLaPN98Uyf/xjKC14d2w/VuiDY7ZoL8hC4IwTsioLrWYU+mm+HzNztksBJlSHXe9NdM4+ajFXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SQ8oa7oY; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53de556ecdaso6712523e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733306985; x=1733911785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GG/C0igHoeNKj2mH68ClLF3Ygx5izj48/Bea3x0gsc=;
        b=SQ8oa7oYZi5/XnZWCzqe/pqdSvKEtDPM9ZVAeqbKbk0ydq0syhOsXVzd99XlEJBRCP
         qFhthVZ2OFSFplEPKTR171an6xEPhm3ws5Z+xxHQEaaitvao3zK6pST7VeX/tyhW175Q
         ERSo/manyr87A51YFzB0Z8QYaYNy3OqTHEhI+5P51nUNrW2+rQ74mEFYPZuAFZ59Tks/
         hg+ZilgJVjUM8Eu7rLSW0HMuWwonnYGbR4gT3Ux6W0Wqrf3qetFua2s1EilOaLxR0siP
         6wUq0ShlHLMtlrpvqjCCx8uV5e9UwQX3wz8BvuOlj9AZ2To2Ul71luXzJOcJ1F1//nyC
         ZpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733306985; x=1733911785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GG/C0igHoeNKj2mH68ClLF3Ygx5izj48/Bea3x0gsc=;
        b=TN2nQ+KFifwdEeEQsMcZyqj7PRBTglW/uKF2vjM/EFA83HmMz/UATLjEiSmIVAR5oM
         Gf/TDQSY2Vx1ipPlgtOxpG5IEU4tgiannQiNsaKA+HILkG4gsI/VhoewtMA3h1MUdl7o
         6gK9NeTBrs1NWXPmbtRy0yY4je7OVqO81/SNPgA85PQpP2wB43iZHmSx3RZnTOkXznfA
         WNDUaJXQPhjig7YYC8m+JwVI/vnYATjht4R/FlWT6iBivgpsg8Nc7PR7gjB8bFdV0ONY
         7PnC1OKEd5hRLoSI1SvejWGhI82lDZnjHttVOh8QIZJmREq61rM+NEruswI+H/qrujP1
         3k3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNEjoNFT6ZjslAgzyIIlPIXL2HreWCd8cVjEHpGsGY0nB4S75TevH8ks3jAvRoCz+VWEYpk3DKF2HjssQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfUIs9K9tWvAxPLhQsS/EoXfneKfD3B6XuHzaGYilSEBa7Itz
	LOpKcSvZrH4rpmGonC9eZ6dhN2DFo+kZfFmFsu4NqiQ9c481eSyWeVnCbmVE02M=
X-Gm-Gg: ASbGnctygtYm1SrMxyaDzhARrQmNB16JoRvRp+p+mg9BU1DiJzLwnpzmAYeLKG5mnv6
	k9t4Nziqz9wJ44WbzglDee7O95mSsIWKGIySzTe9JpMn+YtJfcKT0EEEQJCHX7dF6B3bLaMFjJA
	JlNLS88HZpbQdwqqUErAtf+EUlWwo7m5NLO5UEYqx2HZAHDHQyJxmjxX0sMaphRWBim3EtyMXs4
	ohG9WE9kwvUCVdrCDQLJPy15Usulef5+fdF0zDMLhJjap+3R1nrTM9Z2qEYsiMvbqxdP/CO3Dcq
	2QH4k/Z/RdgR0IUFPw5fwBzr9MAcSw==
X-Google-Smtp-Source: AGHT+IFeChx3JdkEVrSx44qmoT8HCpAzvLzptFBGVf0Lu16LK9AmpqVP6+Unh/3j2hROlEszt0kJ2A==
X-Received: by 2002:a05:6512:224d:b0:53d:f82a:deb8 with SMTP id 2adb3069b0e04-53e129fdd73mr3741737e87.14.1733306985190;
        Wed, 04 Dec 2024 02:09:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e14f97649sm495602e87.146.2024.12.04.02.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:09:44 -0800 (PST)
Date: Wed, 4 Dec 2024 12:09:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Mahadevan <quic_mahap@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: display: msm: dp-controller: document
 clock parents better
Message-ID: <pxi2nf4h34xtkickkkuwh4svvhbtsutuz5u3ukzgfgd5rzzcps@g4gct5zuc6kj>
References: <20241202-dp_mst_bindings-v1-0-9a9a43b0624a@quicinc.com>
 <20241202-dp_mst_bindings-v1-2-9a9a43b0624a@quicinc.com>
 <bfa857c2-cd74-4fe2-a88c-3b35a58710b0@kernel.org>
 <gpqrugcsyhz32bvip5mgjtcservhral2o5b6c5nz4ocwbjw5uo@eypv4x6jyrdr>
 <hqe2pipkcnxftoq5mvdk36xmkj3ybr3oto6eghimq75rqlncsm@v45smglhedy7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hqe2pipkcnxftoq5mvdk36xmkj3ybr3oto6eghimq75rqlncsm@v45smglhedy7>

On Wed, Dec 04, 2024 at 09:02:18AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Dec 03, 2024 at 03:41:48PM +0200, Dmitry Baryshkov wrote:
> > On Tue, Dec 03, 2024 at 09:01:31AM +0100, Krzysztof Kozlowski wrote:
> > > On 03/12/2024 04:31, Abhinav Kumar wrote:
> > > > Document the assigned-clock-parents better for the DP controller node
> > > > to indicate its functionality better.
> > > 
> > > 
> > > You change the clocks entirely, not "document". I would say that's an
> > > ABI break if it really is a Linux requirement. You could avoid any
> > > problems by just dropping the property from binding.
> > 
> > But if you take a look at the existing usage, the proposed change
> > matches the behaviour. So, I'd say, it's really a change that makes
> > documentation follow the actual hardware.
> 
> First, this should be in the commit msg, instead of "document better to
> indicate functionality better".
> 
> Second, what is the point of documenting it in the first place if you
> can change it and changing has no impact? So maybe just drop?

So, do you suggest setting both of the property descriptions to true? Or
dropping them completely and using unevaluatedProperties instead of
additionalProperties?

-- 
With best wishes
Dmitry

