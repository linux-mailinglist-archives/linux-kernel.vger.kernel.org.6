Return-Path: <linux-kernel+bounces-521521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999BBA3BE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952441887E65
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0501E102A;
	Wed, 19 Feb 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oq0a/efE"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7C91A28D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969149; cv=none; b=pNDmWjH5ww41ez8TD/Uy12KTqsprKXLyh/QDcUR/qtqa4Q/L8dEIiMjBtQZDIAvZ8b8JH1/rVhrAoenfVBgi5hTnMxAgTlHmrL6waIDq/wbJNizHTaARqZQzm6Th0B+XQzGnGMcd/HoaH8vipyKBeNulSrJkfaNnTfis+ul1PA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969149; c=relaxed/simple;
	bh=fkexAl6M5DyJT1F89Ttgt7gmRIZVsmlf4VohxNakH4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoUpPg9tUJsQiAY3zRMRXBaB2HLymCxKXuQt2JeD9Wsi2jZLkSXFVovVL7Ix7I6qcA5dCZVu9xHch0dzu7Jvp4nHgtF49q7vHKcP7shpTeh3gtuJjf/13j77QiRI1eJF1F5HZ/u29aaRYAScE5lyXa/shFfvRB5kx1JcjqaqKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oq0a/efE; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so69490331fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739969145; x=1740573945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPuwrJxY2WcVgAzy4da4UTcGT1UhygelXhUrEvq+Dmg=;
        b=Oq0a/efEAlGVhDJ3mwE8X9hFQrQHgu9MM9R2b+l2CQB9wVtDvzQexNm6uVi9FXQP70
         I64Pkz3Uo/S1Oq3PkP5PB3fCe/ND4XFCL48jCnm2DAqwXst723ntNbiZIrMRF/tyPBuo
         efra33d4VI9zrtsgOMlsSt+VIqYB0eLy5HhR1grhW3yLmCC86Z44VRVp8y5Th6S+6i5l
         tyEZEvfHoZ1XZml/IMJM6zgXzh6/cWEkh9INl3ynivHjoyV971HV3ehgOjUkcdc5Kj4K
         3wI0Ily8fLtFuxboWYLB7IljSHt4LhQpyrMRue5UYl+Xz/D3/L2vuJKBnbUuITkCbYyk
         yy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969145; x=1740573945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPuwrJxY2WcVgAzy4da4UTcGT1UhygelXhUrEvq+Dmg=;
        b=irdm03UZJShg6Zr2QmJeN0Pg/W7+h+kF8mQuA8m7G8HHpMh4FHNi7UF289QJ4yErqa
         nJ8KRu6IWk+arSAU9h9UhxKRkR7w+wyWy3A+QljYdnDvb4MZrXsuJOcH52rUMoD9CIKA
         PJkE2Ny8+e/CmtHGvcQ4WVvXn2IxUvYD5zaEbZb7dsB99affo+saG7QA9BO9RITQWH9V
         lwVe5dtH4Qe/iapleiAIHgva6IECSVNuvvauQtSiVTsR2JptPgs+7rr4zN1Q5cFGHeBP
         GsqJx77QUFL+V/IMwCTu6+Xuqc2S0+Ls96z0NKGLGsgVkw4hECDLleVUde6RSaTt7iMl
         XaJg==
X-Forwarded-Encrypted: i=1; AJvYcCWj7Y9+tuvE6DuBktK8YSs+ubcHGV8Mnwm+KgZZFek3dstQDAoPfXdKoNZd/N45EhfiFL78knRat4qNk7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOT+5pV6a8ILhJp6yt5OY1xzi0FvZGllWwBcWpqJWxbiGHcsV9
	LusTACRQYz6dsUT3g2XXSqeaV5YX8bVarvmUXACIogAzBrp4WrIV7yFOUti7ekY=
X-Gm-Gg: ASbGncux0nWFN9DHQjqdfrqQ+PItAnXNt/2C/RNperCpkBzGHH0hx5eq5gwbEc1HA1s
	fOM/byYjwF+o8Bq1FX6kaxgMJ2zkeGG5oLMWiGlcDcc3M3OIWSejyEGUhh+HTe+VwnpOzmOU7Sf
	6vuQ8+4VOEyGeNV8rv1YkwWMMQdbGv30aEmdRG7JLlg71yqeJxjk02mtcMYB+zbgRYP2JejJhVV
	2oTp1thuxEx9fTiHKRu1SNd6Cbem4A1peG7MMaanafa73YDxIR/tBZWblHoEG6BEp30TmpQ+uFH
	3ETMTw7XVTiIeeDKPH40xQ4JR6sMXkHv3SfmBb2rsrNC9vhFk9WRncFOSIEWjNUyuhHUBN4=
X-Google-Smtp-Source: AGHT+IHqzXvswBBHdB6BuGTvdIaOpP/9m10nx1rxuNNktCu7rOUQ1riauWad8Yd8fM2T5tKt6/n/Ow==
X-Received: by 2002:a2e:780c:0:b0:302:40ee:4c2e with SMTP id 38308e7fff4ca-30a44dac851mr10131541fa.2.1739969145292;
        Wed, 19 Feb 2025 04:45:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3092fb236cbsm14835491fa.69.2025.02.19.04.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:45:44 -0800 (PST)
Date: Wed, 19 Feb 2025 14:45:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, jonathan@marek.ca, 
	quic_jesszhan@quicinc.com, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: Add check for devm_kstrdup()
Message-ID: <lwtvnlt7rfmsbdgyo32fs4mx2xbcyrnjsjq53nkk5pdzrpqgox@nn27ythhg23k>
References: <20250219040712.2598161-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219040712.2598161-1-haoxiang_li2024@163.com>

On Wed, Feb 19, 2025 at 12:07:12PM +0800, Haoxiang Li wrote:
> Add check for the return value of devm_kstrdup() in
> dsi_host_parse_dt() to catch potential exception.
> 
> Fixes: 958d8d99ccb3 ("drm/msm/dsi: parse vsync source from device tree")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

