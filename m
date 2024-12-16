Return-Path: <linux-kernel+bounces-447940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6001E9F38F8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108EC189118D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755FD206F0B;
	Mon, 16 Dec 2024 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K9+GZXRM"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2AC206F0F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373744; cv=none; b=kEfeuXOA4tFm1zIYIMpJov2zAssS/UuTcTa2CpsSaD83r9EHsTlcHAcVfPWj/ARnhubYuMCD95dA0iWA6bHam3ByHeoKBChkIHqI6YcFjJzZqoyjLPRRvymsoU/jDnLZWnd1DvaOqMoIQezrs8IAfllrgw3AmVHDGaiz16hmgg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373744; c=relaxed/simple;
	bh=/TIlSRQ7ahuGDkgFihn78l4akEjGDGdpYykjVXL65kQ=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDaMz21JAhnVu1Lo+ZtbnTM+Hx4okfPtcc6xemQIy4Tip3BDjKSxm5HUU/dydscJwNIvNAB7MFV0D7R/1zjnI5wsv7UaFCmsz8sAeSgSsCCbxgQZdMVzvXbr8gpoECFTWLapoGWcUF91WsgJBpPLT84uZVRoGv3i1sf/KBeiu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K9+GZXRM; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6efe4e3d698so34192807b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734373742; x=1734978542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TIlSRQ7ahuGDkgFihn78l4akEjGDGdpYykjVXL65kQ=;
        b=K9+GZXRMMQYZkdnH8nQsmphmmr4vjoiai6PTK5NGYoz9rWt5wHUl79cV6XG0UmDJg0
         +XfpkGlqBVScNPAn1hWwERQTYNyu+Ae844n2Lk4sXjjWCJDf9iBrVp4m7xF3i86Osrpz
         f0jUL6x603Hy5jZc0SUI4xj/qRa/cRA952dj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734373742; x=1734978542;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TIlSRQ7ahuGDkgFihn78l4akEjGDGdpYykjVXL65kQ=;
        b=SWDgRtzclHoJQwqc9y0kK5ajUFx+oSJn8yKL+TUlq3UOq0dZFA3zJrRUSs3JRO9+dZ
         2RDetFGTHcdgvYJ7eb+zq+sy9sManHD9DqydSBfzxckpN+2WsTQHrwnjAP64LS1sHfJw
         2G/z+RFWMWrERVGFdlkVL8ospFMgtkasuxmvYlV2LrnpmRREFBGHE51CqS3NpmAHnVO8
         PJy87ezOWG3AQmq6eYC+20bsku2r+TMCs+qcVvBaJ23vBd/apdjVaaC5WqQEty6rCEi5
         xJKLJQBbB3Pqf0i/tteAqh7eF75MFkIwzhLb4L3mFUAmew5o6dSb6ROiRLENgZ8KemXM
         K4PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZAu/VdC8D1ZW1D9fMyi65N8IiZa1Bto6Lw8fCOPnn9AZneLmeXjCwBH3HDtmx1/jYWWUAvmG6AMWo6F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+RvaNaoC3P/zr/pcQCLeff4O3crKgu96qoUp7FjArquFFQEo
	RRiiHXZQQjaQXc7Exh6c50q/i+ELPv57T1ayXBs6HrzoC5RdkVzEfO/4Lz2/pTMBBjO0HKC1h7P
	vfAl1jri1ZvJuzOwD3Qx4zvPAdLLbWuFiMS5Q
X-Gm-Gg: ASbGncutFZqJK3ceSGvQDTuC9Gv/lTLcTr/SB3IAFdLm/ieSptnZwQZjmTKgzT88bw+
	wO3R3IlQZf6UZ4jogUSY8OLrxj5MFjUeS+sKPBz+5rZ5IAAacMBz5fzQvYxYIOgcMew==
X-Google-Smtp-Source: AGHT+IFQ80scUMo8d9IxWp5aJ4xwNtnqqvy6ffJBkw26JRJsHSxXxD+1I6D1JK6A0t7aCTHue6+bvR9ehNx3WdpmehA=
X-Received: by 2002:a05:690c:b15:b0:6ee:5cf9:f898 with SMTP id
 00721157ae682-6f279b75052mr120990327b3.33.1734373742393; Mon, 16 Dec 2024
 10:29:02 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Dec 2024 12:29:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241216-fd-dp-audio-fixup-v4-5-f8d1961cf22f@linaro.org>
References: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org> <20241216-fd-dp-audio-fixup-v4-5-f8d1961cf22f@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Mon, 16 Dec 2024 12:29:01 -0600
Message-ID: <CAE-0n52S3k01eueL_GZ4Dk359x879EDiOJ7zHK_BduM3bkJVOQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/16] drm/msm/dp: stop passing panel to msm_dp_audio_get()
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-15 14:44:10)
> The dp_audio module doesn't make any use of the passed DP panel
> instance. Drop the argument.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org> # sc7180-trogdor

