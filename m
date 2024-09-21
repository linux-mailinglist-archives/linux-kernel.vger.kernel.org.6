Return-Path: <linux-kernel+bounces-334960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71B397DEED
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DE01C20D42
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2341513DBBC;
	Sat, 21 Sep 2024 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="waJAqIJL"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14C522094
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726952171; cv=none; b=eYghTE2id6JFJvHjI/zCH2pUnwNn9uKt+AqeDqWI48SdmTXu4MkO8ExN7oEvEhloZxuEQ0K46eTDZQotFDtJbC8qtXHySVYkzxvY3m7x54dU8GOcTequ4dxF/3VLx4WOp7uAkBv5QW26rBQfcdG7FkAPG1CTlPuCGckSgFJ66Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726952171; c=relaxed/simple;
	bh=7ZsOp1EOhXJL0YA4+fRX+BbvmLbbGGHyPnCTwYLWvlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPMpV8wnG+vcqCbK8/ke8+di5wavjCD+46x8PWNm3aXnxQ98Xgvdd4GLODkzYSxrLHFQJWe5SyaUGhqGXKef14S179lAsHhAf/P/MXUH1h6iuqO4V9ST4mMc+TZ9HzNIZe0tEolj+B34iAwpuHLp4RsVW86AYcaztu5K09HZpYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=waJAqIJL; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-535dc4ec181so3119470e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726952168; x=1727556968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNJ//WLJC+rT6bdE83w3ztydutKipFcS5oG1bOhNX34=;
        b=waJAqIJLtrFOazRHoGwfwkSmhoww/1u+LGhYaPbKcNtdzfxYTbS+o1eIcDCM/aoGah
         Cq8g6FmYtdVWeYzwFtqo4QktuK7z5QvbCA2tu1E6A/H7WxVtiKjADqom3JYlISe5eeYw
         mfq8xqsTeKCOr4vEraII30tOfl+tV84eeD1PjiXwqnPbHfdnA3NQbZCdBNtOymRch0Ew
         b0248y1V8unCJdKjXhwwQoyTcI4NvO4kedpTyvOtOqhKJ/j1tR+WYcuzXg8frW06B5Kj
         0NvqmceuGodNg/FrS6skf6nCWw+ad2ICrnxYEXBb88H+s650+YxtXWvFICQjlbvSBCI1
         IpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726952168; x=1727556968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNJ//WLJC+rT6bdE83w3ztydutKipFcS5oG1bOhNX34=;
        b=OAO8uoDVmUOKQCYTp32rBu6JIItVoECk4If0GWwTdKUuWbxA/8qafz9w+y+8Fr826x
         vkGArazWjLypBnW6ZPlyXDE3JpTgB4jRn7V4aemAg5/f8vxCTdHcgATmfzKjsNEQrCbm
         VHMdR12EwS+g3ve4XgihcswxpVy2QbqfagOQ5PtT5fKFkS2ISi+pA/jtodnj443Z7sqt
         QFqOQv4iQNBw5pISgBbZcDlBpruUZzyc1BhRlPvRfRSxrCMK4AgwQea8aO3f+G97w3eu
         NOBGb2D18tSo0eJQSy8b4Cd6SBD45+hFnTp/XokUMJk/ZhpOZs2ti05CGTvQyUeiJIVM
         2zJA==
X-Forwarded-Encrypted: i=1; AJvYcCUPqbVw6J2gP67vEndiczo2Ga82zByxWRMOWAu4Ekc1LvbvkM7ClaOz8+SkK2Gmpi+HGhlrwjnUw61vFPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjMuEbL4UrCMDEhn4kb94NVa/ZoL1WNXDf7tIftiD6pMiYKtax
	yKpscXRhFrZKH4MIm3cHi7n+WaLVOL7Y7a+5ZRoeFA/JCCFD+e1589HWpvZEpnQ=
X-Google-Smtp-Source: AGHT+IESDgIIdZzD9EVFYuqv0g8rCf9M48QrMLDI+CZ/amjCPR8cCdnPNrSLBhZFmKmw90fs3mj+HQ==
X-Received: by 2002:a05:6512:4025:b0:536:14a1:d660 with SMTP id 2adb3069b0e04-536acf6ace8mr3791045e87.6.1726952168086;
        Sat, 21 Sep 2024 13:56:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704683csm2702411e87.23.2024.09.21.13.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 13:56:06 -0700 (PDT)
Date: Sat, 21 Sep 2024 23:56:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, airlied@gmail.com, 
	simona@ffwll.ch, sean@poorly.run, konradybcio@kernel.org, 
	marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] drm/msm: Fix some typos in comment
Message-ID: <uwmnsmeno3i5uzbbizq62ffsnuazhb6g7hcdkj4re4l2z54j27@jndvshalzuil>
References: <20240912070420.2891-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912070420.2891-1-shenlichuan@vivo.com>

On Thu, Sep 12, 2024 at 03:04:20PM GMT, Shen Lichuan wrote:
> Fixed some spelling errors, the details are as follows:
> 
> -in the code comments:
> 	collpase->collapse
> 	firwmare->firmware
> 	everwhere->everywhere
> 
> Fixes: 2401a0084614 ("drm/msm: gpu: Add support for the GPMU")
> Fixes: 5a903a44a984 ("drm/msm/a6xx: Introduce GMU wrapper support")
> Fixes: f97decac5f4c ("drm/msm: Support multiple ringbuffers")
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
> v1 -> v2: 
> * Changed subject prefix to "drm/msm: ".
> * Added Fixes tag.
> v1: https://lore.kernel.org/all/pd76zf55h3kjpmgiydiu4br35bwlzsey2losublklv4o4ta7ko@z3gzy2eec5qh/
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

