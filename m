Return-Path: <linux-kernel+bounces-532036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6191A447CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789E11896E31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636B7198A29;
	Tue, 25 Feb 2025 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5HEA/P3"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0122B194A66
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503696; cv=none; b=rwgWTUoOWwIWiGkt7nSMVbekYIc2kTyQvSMKf8IaKjWXv6/49nL+fYsbMupQ/OWAzSPiehIeB9vEb3iMvgX1aq6ufQbVvVscLOwD/86+7czrBoGXVFhNjjMpkgNgmBP/yocA0XdAI3CRJPeY2UeX7d3jC5oTcpkkT+EZ0oYHaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503696; c=relaxed/simple;
	bh=jIu3Rpw1Xfn7e1gbxAcLbkp/beSC/XjwOVnR7tMlyDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hld84AVR7peWO4e8M+eXQu5PsRgC14dv26GajlnoaLTc3jp8c349Z5JO/2O3Xvsjt4CcuXRxxRdJB47PaF+aJF3+lDJlVUoPA6dkYJ9hAechWFyK7OXQRAh/rhK1to/HB0sFj0cCo74CuqZDI0I3u441r1rRibSCc6YPBXhlPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a5HEA/P3; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-543d8badc30so6820278e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740503693; x=1741108493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dODZ+7MTPPBH6S67MBivWnFKuk0Orcv5ZDM65vBwrU=;
        b=a5HEA/P3EGo8ijezskDUs0+Xo74Tl4X5pShqCfJtmnzL5UgFapbcbDt5Qb2x35cQBO
         fzTvcKk+8SncWqko/oIHF5K/fqLcjxxX8KzHs8XH1LSibIHsSiGY98oBVthvED/QDzDd
         00wdgLkYV1+0vl2qDGTQqQls37k+Nm3iSZfJK++xuW+AWv/BAdpXa1YKTfJayWxFUmMy
         yPZL8De+zfgA+gGG17lWspfNcdWVGIfIKgJ4n1CgzmWgaXUkWmdb29HVr5sjNrHKKwdj
         OV9VFrYrJa4AMj4uIyvd2TbtqLy6dp2d2uHe9i+RqhrmO3Zs7rffQk/MAy1BdyichASK
         xTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503693; x=1741108493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dODZ+7MTPPBH6S67MBivWnFKuk0Orcv5ZDM65vBwrU=;
        b=c7SZ9p3Sqp1NObTGKCTZWxibY1cQ5nBiP/BPzOiuDZVjQlkaqZb3+PJuc0rA0iJ8RS
         tPm10TAC3yD89bG9VNXF3Qu75Z2pY4bRNshC9RH8vN6Jp+IdsbcwoltqcU+580Bn9QzQ
         AI84rkdnd9IpbsURrsNqNgNtK0vcwGdb+tKRsp1lglOg0NzpDmSa40thCyAOHo5XOOET
         zpUu5plabXTt1XBLeEs1YM+U3nCxmjLT+CnX+1zPycghYw+IopOTJrhjE9+uOjUGotLe
         Hasbx9pLVRMcxTy7ZTy5JI1f8beUxemiLt/YjcOXU4BPblHMjXhanWXd4RnfJglBCvDk
         UmQg==
X-Forwarded-Encrypted: i=1; AJvYcCXvKmx0TQOvLYjhjLM1Ze0h1e1L4fm2/qzxX3veelTcMqkyh09Mhq8Qii0G+Xz1w+Ha5x46/GQVaAP4gGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyubZJTH2iaoblD8zIywRWTMtqffjMj33v5JXuTxKr1KrLCbjtv
	byEri6plQH5D4ZywoXxYtWzUbKZARoHVI4M5C7swIBVdP0rq+41idsqin+Yk+aA=
X-Gm-Gg: ASbGncsTEOrHykZGwwNOURfEeRV+kuONn+a2LdGafoX38bd/NzhWq6TWQkmNZ9wiWyr
	ffvhw4v8zTiiLovG3CRTYP2IqfTu6E3HlwyVJfQekOIGPQijopok5Mo0af7F4rTfdDjJdx+9fea
	WfguqMOjEBmh2ecvNYVOY1YMvyCwLvbZir6PTAk4H1or2J19Ia3UFL/jNqOaSrE4i7ZUEdR2o/K
	ub/vgfJBI89QplxwiahLfDBCzTIiXcI7DPuvs22OxWfKPKLcky/zM6FJNdbBF3p+Ap8LZLk7kpk
	dgA6mDCff8eUvTDeLOVawJ6gBM97+ySnp4pNmso+ADBt4rKwivjqd86PZVfkFNevfdn7Q5SmPw0
	LNzwW0w==
X-Google-Smtp-Source: AGHT+IG2JNWtG5t9NbVNuoQ9NN6EnQTrfMLDjiH8gZ0sx1WPbonGS4f2ipr94i56nk1lp01l/rVSZw==
X-Received: by 2002:a05:6512:3d16:b0:545:62c:4b29 with SMTP id 2adb3069b0e04-548510d2891mr1850229e87.22.1740503691782;
        Tue, 25 Feb 2025 09:14:51 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b237bsm233549e87.4.2025.02.25.09.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:14:51 -0800 (PST)
Date: Tue, 25 Feb 2025 19:14:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robdclark@gmail.com, sean@poorly.run, marijn.suijten@somainline.org, 
	andersson@kernel.org, robh@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org, 
	konradybcio@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, quic_abhinavk@quicinc.com, 
	quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com, quic_jesszhan@quicinc.com
Subject: Re: [PATCH 04/11] drm/msm/dsi: add DSI PHY configuration on SA8775P
Message-ID: <jrlpgcg4f4p76muibh4hypdjag2fl7ex55bspxhkjya6dyqjin@gcsrrrtoggcg>
References: <20250225121824.3869719-1-quic_amakhija@quicinc.com>
 <20250225121824.3869719-5-quic_amakhija@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225121824.3869719-5-quic_amakhija@quicinc.com>

On Tue, Feb 25, 2025 at 05:48:17PM +0530, Ayushi Makhija wrote:
> The SA8775P SoC uses the 5nm (v4.2) DSI PHY driver with
> different enable regulator load.
> 
> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c     |  2 ++
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 27 +++++++++++++++++++++++
>  3 files changed, 30 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

