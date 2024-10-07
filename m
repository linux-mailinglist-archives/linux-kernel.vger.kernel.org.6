Return-Path: <linux-kernel+bounces-353374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0300992D02
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5131F23668
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0611D358D;
	Mon,  7 Oct 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGLPk81E"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2066C320B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307151; cv=none; b=b6GCY4GxYhXaubgcchjpDnjtMQkHEwPrwkgsJQSS1Ig7X0W6tcDRLD331zyO5E+4UZBOeD/DOod9vgT3CpDPADvV2Ha09C31e2cJIZ7bNcwJQuIiaVDiJ2eRxUjt97GePtnuAjxOuCDjiN0L1PDADnuWz4WHqR6i/EMExArEY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307151; c=relaxed/simple;
	bh=zSSnmBKELsu8+TP1ru4kMnaPcFuUD2Iazj9ZA8DZBs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+CAfpZVvnu2urQlqOBQCkpAXoTui9H3wn8WY/TrigMDJprRMeCFyKxkeQ5LcV41KyJEXuEJ6HgBJXZcP/LOfCfa9N4xLKQ1wYV9wp/ymhivR7rDQa+J8XZ/3fSD8A+8YXPkhuwlvQTY9QT0NlNrnppr3GvEfXPJuNhPsmUHQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bGLPk81E; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so5404236e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728307148; x=1728911948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xLf663k7Unb9yQSVk3+yd3X5tyISjr5HvAhl1UQ5jk=;
        b=bGLPk81E2Y0DhBdE/HvXdcfZd9jap3wHHpgLxMedujLiJEi/RtcZlDWs+uUj1l7sZ/
         GaGP1I5YbfBS+q2iuDajtmh2wNiwklWWfZSCK4X6hsKcegyjMPmjxoIpgphqWfbhp8uA
         47vpkU45CwrjNLkxgdmppvuqfXZEQu3VeWMGD8h3A2fA7ERM0PQeHiRxZDaiIjEKbZ7n
         segbu40iB9akFXca8y3CuuoQOHmOvi3tCeJdWY+XXineoqTT053fUNa4Yg8RWuPQsdzD
         rylLsejF0zg1Bk9i5FQ65Ez9xfczefT68T4v8ig7LMn41VfRyrsRWK4RVsbM6L9quk4I
         ZVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307148; x=1728911948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xLf663k7Unb9yQSVk3+yd3X5tyISjr5HvAhl1UQ5jk=;
        b=ApKSov2HlhJGWUWqm8JASxRu+CXthGoNNaH3X9q9i9JiheFEQ3riKauMVVlSyVCi1d
         ejQ5ESvNiWFgVm9pHck1T1PTbVlHOzC9v0jjqm0ES6iRce4it59/wLjyQYKNLkZIzPNB
         vZ9CaYz2Df9GZvvnJcrOaw0rjmnKN6MEA/g5ZtY5wggHd/5xLG51CLfHY8dOy7r6ne3R
         YuqVh4dGx4j50DztVbpJyyeQiqcqkUU0yYEKcao3Rg7J+cUkPI5LhA2HeX7h8Xq9AU6l
         J+0t9FtJkpwX494FNSdF8T8rzvkFWVtRfvgjdNfn8TC1UpTCk2H94D5q1ZazDMEAdNoJ
         5ONA==
X-Forwarded-Encrypted: i=1; AJvYcCU0P0u6naG906a83Pr4LCcSiR/zx3Y9kw6m6EicP+CXQavGl+9r7qti1oEJa87VESgr/Ww0PnOgisOQ17o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL6t6os0bXjy6h8fI/98fV4BAeO2/CoD5J+6I3kiYFhZ4mvtiI
	Cce/OjZd96f2b8sNcQvG7tffYNJtgZiAO1eOU+4YT0OY9sNwUkyTO/gphge6lpw=
X-Google-Smtp-Source: AGHT+IGYvxRBROgH87NQ+TOEw0fRmb9P07SdQ3NJxECmesIK4Eck3W4jA2bZJ7wyTSLJn8CYPOwSVw==
X-Received: by 2002:a05:6512:220d:b0:52c:df6f:a66 with SMTP id 2adb3069b0e04-539ab9f1187mr5089552e87.58.1728307148223;
        Mon, 07 Oct 2024 06:19:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec847bsm840205e87.96.2024.10.07.06.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:19:07 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:19:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	"open list:DRM DRIVER for Qualcomm display hardware" <linux-arm-msm@vger.kernel.org>, 
	"open list:DRM DRIVER for Qualcomm display hardware" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drm/msm/dsi: fix 32-bit signed integer extension
 in pclk_rate calculation
Message-ID: <uuotcdtdnh7u6emjozmxicvdmaeztrdfa72bxl7w2elzanf3qc@2q4nip75flsx>
References: <20241007050157.26855-1-jonathan@marek.ca>
 <20241007050157.26855-2-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007050157.26855-2-jonathan@marek.ca>

On Mon, Oct 07, 2024 at 01:01:49AM GMT, Jonathan Marek wrote:
> When (mode->clock * 1000) is larger than (1<<31), int to unsigned long
> conversion will sign extend the int to 64 bits and the pclk_rate value
> will be incorrect.
> 
> Fix this by making the result of the multiplication unsigned.
> 
> Note that above (1<<32) would still be broken and require more changes, but
> its unlikely anyone will need that anytime soon.
> 
> Fixes: c4d8cfe516dc ("drm/msm/dsi: add implementation for helper functions")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

