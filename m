Return-Path: <linux-kernel+bounces-515196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD82A36197
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F567A6351
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20E04D8C8;
	Fri, 14 Feb 2025 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wP+u+xHV"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427E2151999
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546552; cv=none; b=uiXFTTrPUoKbYNI78s2HKpCsGai88ehQZYXPlCOhNsRXQP6bklzzTyyhshcBra62oZZ+QSn/FdPgIYDiC7JZqhJLvsYLui89yqfHgEBkdToGRl1XFVBKElzeJdbv5gIvZEHtwUYRQaSVGsMecXtCDnERk2ItLyTb4K2D5BuPxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546552; c=relaxed/simple;
	bh=qAZ+7NciQnpT5One0BQKVQ6jDdDNpz7ei39w2YEACvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0BcAF7QJVR5WTIdCIJSGmi05RM+qNMzj7jXJxFlBZHYEdSJjgxd0po1KD3yVlSLoXH8kFPt7dXf5oZkCjX37sRbRwgOa8Wiu0Bn8bLCOShaLVWA/ngzZwmrjLlq3fC7QvCNUPNkadY0wTrBJB7DhIU3kRbJXMR0QB70nPYvf50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wP+u+xHV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5452efeb87aso268635e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739546548; x=1740151348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fJot5B8/dqhQxIfQ8JsIVVHPjrU/SK2cqPunhk+EjbA=;
        b=wP+u+xHVZaiIXHzELGCWPAy87LoEGMClZXHM+BZUfUcjb6/w4F0CjhznOEu+zEdeNW
         sIdD9VOqyI+cqRPnIR5uP64fEI+gGZOvCTvldqTvZWJ0lCYJaGwoYU+/0kNRfmTah4Hp
         iaVzuXhGdUjjjcdjK69ufclY2WBHQ1VRd4dsRCF3gC3gxN2CEUdx3PjHr63bahc7+7uX
         2kZF/m/oLHSgmOAn7BNJvxbHZ+uog0CRSnjOiW/UvBfGl0eEfzasfvPrFOSiEmTzX72v
         BkMnXquQAe7ItqrwAMBEr2PbwNbISunD9d+hfRsYmlTyHPpKx7BlDlw6RE3KH5OTUqVZ
         Ui9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546548; x=1740151348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJot5B8/dqhQxIfQ8JsIVVHPjrU/SK2cqPunhk+EjbA=;
        b=URLEPV4CJI8Zm7V/7j/NfDOeyreRhW0XDDibcoAFKOmveJnzfvkSUtSi3X74/j17mY
         /WmavHho7nqjMfHFnfFhupKXGeIHt5KJEpDPsWU2Qn/bK/ZkwWqziHo6ihjThbWF8OGp
         /qaMLNd6heAQeZTACYmzSXW6Lypd4yIt0iZHl9hwaDUDF/h8IyhvkWkMNF3gHL1LE0Xi
         wTTKTKny37DNa/QZOiWgcmcdDsSCM5vUVasY7ivEphgbDLhPTZB9lTKIJvmX5dte/3/k
         Frqrba7NjEvrgW+A4KMSyJyTWarPgW4Pq+kUM1Z0yF3kb47Fm3MQuT7LRZEjrGkfTsPG
         Cd+w==
X-Forwarded-Encrypted: i=1; AJvYcCVauhrY8vOZKPQXJoltQiMvAop1WZ/07rhjtk+RFjObaf1qQGj9Z8HsZyZa55feM7MmgZB5b/BedE58ZwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXlj7TZeTDdGpl/CCtdiLQVaW5KiQDVV3vzkli9ox6GkaclMan
	eaTo1vAAgOUQ7SwNxRMQXbqIEama/cDZadS21fIv+PkLLURDBjKEq9y8QWJdGfI=
X-Gm-Gg: ASbGncsY9j7OMdU5C+3oPEHVeKz1+RmynZhPwv11ZdjDl1yGNogy4aTgQWDMQywPa8C
	/nxgZnAhCgneimeb/CYaSqw93cfhsJ1hXxJHW+nUVoUZGnFufRhC8teuLxhl2afowI5dKSlkzKJ
	fbLG6fgFIMHphmuI9nm+4mvl2YVcVw5vYViZtZWEZylXqNGSSb7XDcup//JeSA0eis/RIWL7Mv1
	qHqSCqldYpnDUO2YBLIiY0v3LA5a2e09bd5RVt65BtAr1g6ivtysStgTIs9v8bbzfyPwVy3HfIe
	MR4R3N/36RJlIqxMZPvPRGecXCK8jj8I1oOUBXnt+sYIskqEtFFOoeAqcNK26ZmThRsPbcc=
X-Google-Smtp-Source: AGHT+IHd6YyZaJ0gJzVV6IzMidNDXlHHAg8FDIw7tYf8COTL3g2DYgMEui7KrHFl59zy7pcT2QzHdg==
X-Received: by 2002:a05:6512:3c86:b0:545:2a7f:8f79 with SMTP id 2adb3069b0e04-5452a7f908cmr1095665e87.16.1739546548279;
        Fri, 14 Feb 2025 07:22:28 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f09aae0sm569393e87.64.2025.02.14.07.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:22:26 -0800 (PST)
Date: Fri, 14 Feb 2025 17:22:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] drm/msm/dsi: Drop redundant NULL-ifying of clocks
 on error paths
Message-ID: <aarbydttw4zexzkorcr4yb4swscw3crn65u6eactutpfgpnt4y@fg4zyd45xwln>
References: <20250214-drm-msm-cleanups-v2-0-1bec50f37dc1@linaro.org>
 <20250214-drm-msm-cleanups-v2-1-1bec50f37dc1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-drm-msm-cleanups-v2-1-1bec50f37dc1@linaro.org>

On Fri, Feb 14, 2025 at 02:17:44PM +0100, Krzysztof Kozlowski wrote:
> dsi_clk_init(), which gets the clocks, is called only through platform
> driver probe and its failure is a failure of the probe.  Therefore
> NULL-ifying specific clocks is pointless and redundant - the PTR_ERR
> value stored there won't be used/dereferenced afterwards.  What's more,
> variant-specific clock init calls like dsi_clk_init_6g_v2() are not
> doing this cleanup.  Dropping redundant code allows later to make this a
> bit simpler.
> 
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

