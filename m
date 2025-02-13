Return-Path: <linux-kernel+bounces-513470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7E6A34A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B221B176E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BD324A04F;
	Thu, 13 Feb 2025 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrwtFm6g"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A124503F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464753; cv=none; b=CgH5iCt6xkPPJ5R65wlqK7vstJ2O0MggCOjlUC+hhlszchtQNdaLJHOpDwARJCZssLhAZQQjH9jV999zkKi6EBj89GZ3aGMtohXTCePyvTQhUiyCU4E7m94aFicuAC577S7jemFK+DTzdb4XQqIwz3wNNn7ZlQsnMi2CgGUCcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464753; c=relaxed/simple;
	bh=K/x+wxzY84hkyxz05mK28fhYgwGCbSl0IyD3hIaW2bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwTJ7zXI7AKghYaPv0wl497GFV5O1sDL1nZdZmeWDm10YddOlljJrpsCY7CeSfstonYDJVSt2nmOaU61hEdIKDuAme0M4KFKxgNvsG0AfGnY3Oxn7gAptBo4kiRlZ3gmd2B41Nd036oY+rbr7ZIKw9JgsKajFteKY8SVDl0qv+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrwtFm6g; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-545097ff67cso1094819e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464749; x=1740069549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ROkBhlLVVwSUfxVQE5hWrNfgh2+kXGToJyAm3nJurYQ=;
        b=rrwtFm6g8hKG39n4YMeaN+PeksNqjLYKfjx2w06g+ZOinSedu1s1kmzdFo2EblSkfM
         cLKfb0q123eFjN8nSmUYhPZ09zWYuXeFrHAS15/QeFPUfCZfepRPp/UXucW5i3hHwT7N
         1S1F7u+7Ja8QftdybIGo1C2HFNgDhlj+qAGKCmdjvuvw4NgM3ISXRKDWv/EmHnvhHS5j
         bPKK9aoDitAK9d7ttW3Y/CdEE0LAIVoeDAyHfM++TzpvdBlp9s6mU3Se+SzyZxzjl9cL
         mFdmNcykbvI6a4mr6HZd/CgXj4IZ4LfWMifoa9/9qiA3T/bwfOUEeF0aO92TURsSgNFz
         yhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464749; x=1740069549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROkBhlLVVwSUfxVQE5hWrNfgh2+kXGToJyAm3nJurYQ=;
        b=U2ith6X7NKgXyWyyM9sL1ErlbLGUc+sWlMbXX5NfqTgonbXD9ioxLTkkb51g8WKvEN
         FLOLj6zDmfj6q4rjIGSrySIyf5JnEt15Qr1Ztp4m5kWZ2fpeaKKexjZm29HbTWWhZqOu
         2iY5kwlnXRVP8m5EqmJrc1RBZY2Zn/TixJsA4b0sM0w6jbpBcvdzNWtFf9r51lExGJqU
         XvGoeTzN+Tg01fV3zDVsr5gvsH+tWVcoKhu5LKNSlShpmNeq5zG/uk+E8qNOu06OGNMX
         M6kDUCNiajbRD5ihBQCGS5FMnHqPPKoRElC+nKSAhBnaVGCPVe1YjvfB2gr6MVw4Ts/n
         /DMg==
X-Forwarded-Encrypted: i=1; AJvYcCXt/pktFVADolawa8tToFEXChr227Fp41gHDG5GHqO7skq8mX8dvSs+hZMApNM5gDGHfT+GNWN6xbRDoN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdL7jEoU2+zFCBzmxPTjoshsU7jdSyEaczjsor1A16ILgug4z9
	ZelzmQ4Ftkebne5h76yqJi66vM+fRrXlxdkjNXgPEUrCFGRiLO6oPcUIzeTP7sU=
X-Gm-Gg: ASbGncudtNxd5eX7fALrOen53AvsbhFL7iuDZ6WB0LIsvNhazGHsWfCwQ3GRkr/2vyQ
	WiKEVoyn02y8mLjcNh6daQV5IbS99A5bAfYDK53G8wmoiJPsr8OSNycG2B/hRBMkOso80hcxZj2
	UBW0BKhiLLnJa6JvZIr7IvMumsrz4mJSFGSUZn1upd1gwPICNhI/OygJqSud3ug053dCNKmUr0l
	0NsmWSojYGaGPx60lICrK/muQkZ+eqA94iDfmVmO2t6eCSjcTU3FkLiou5UJ74oC1himJaZKWyf
	NROeRAQuFQg8BQwnzNLQCbaWeW+bLFmH9P64NZhrELFz3V06GbWPE9EbN2W2MHlbarbcIuU=
X-Google-Smtp-Source: AGHT+IGNm3a8hYI5z1IHDbLi22s0Uy12h1aBxG2214iD9koo++l//qklYRbDNgtDVT4jjatgBNZhFA==
X-Received: by 2002:a05:6512:2019:b0:545:c51:4a29 with SMTP id 2adb3069b0e04-54518290086mr1844942e87.25.1739464749574;
        Thu, 13 Feb 2025 08:39:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105d08sm213806e87.134.2025.02.13.08.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:39:08 -0800 (PST)
Date: Thu, 13 Feb 2025 18:39:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/37] drm/bridge: Change parameter name of
 drm_atomic_bridge_chain_enable()
Message-ID: <jykxa374atekniahxcjnlhx2pcqej23zckr3m5ykx56vm4tnpq@ubjjwy36jbhk>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-19-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-19-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:38PM +0100, Maxime Ripard wrote:
> drm_atomic_bridge_chain_enable() enables all bridges affected by a new
> commit. It takes the drm_atomic_state being committed as a parameter.
> 
> However, that parameter name is called (and documented) as old_state,
> which is pretty confusing. Let's rename that variable as state.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_bridge.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

