Return-Path: <linux-kernel+bounces-266363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2A693FECA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E89DB220F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F076188CC5;
	Mon, 29 Jul 2024 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EpkRUYkT"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E6584D02
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283741; cv=none; b=u6Ks5DXel1cFzEwxec2PR8JVdumK0fZPHbTt1JTeG6/MAfbx7kr5XPt8YJAZuWYM1/h6HvQqg9aNzDG+oKXU/y+6JIij4XT6/1dFBTedNclHJhZGLl9leK3o9xnQC54747Uk3v7584kN1cekWS+aw+JBfeY45aJersA8U5f/d1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283741; c=relaxed/simple;
	bh=/jIHXG4vT+DDXeeiF4buw3dVqIn5OLZLpsCUv9QEgTA=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfzT5mIem9QKUXXyDUMgmFDr5qZGfQ1Q6ULPkMiopC+XTRz13owxGpJnM73uKqKYajIyVCQcLRl2eD3L1fzCZbNj0+akU7ve+dFlnX7zEkh2QhCBGGcZlAhF5un8Acv4Zbne1bRjfXhJ2sYN7ARTcOKKwOljSAxpsFNmivoKNuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EpkRUYkT; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7093997dffdso1072562a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722283739; x=1722888539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jIHXG4vT+DDXeeiF4buw3dVqIn5OLZLpsCUv9QEgTA=;
        b=EpkRUYkTaXcnqLodSHeZdg0yVhfC5+O0n73cKq/PdBlELTyIqBVZzh9ri7x1akmlsL
         JopF/MDUAguzSfDJYk0hlEPn5RJXmBVWrziByXpQyJn0wK8spiWbavbEzjJz0tRo8u7J
         xP8yDQmdMsb74zpUtWk03SbsdanPk9ufXaTvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722283739; x=1722888539;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jIHXG4vT+DDXeeiF4buw3dVqIn5OLZLpsCUv9QEgTA=;
        b=uevvK+S/FBoIdoxhBXA+4GEkdQ5QY+zBwqR8OpOew2h7f2YC9ArqH5Zdnrhz42iil2
         ar1EBIF2Os/F0nhfF+sFbdESqjkuFXODGaxh+gpwSlqq84NvFvJ+gKwRK9xLbuDB80NK
         QMftsjjFK6w+sSMwP7eZYtJ37d+p8nzxFrCfXgGTglmoHPMgGVlKqglD7rW95e3KDD8k
         EHaQP/ryXPr98bx/NrkbDbaF5HDmRQo1XUwf0wqKJjund6PXo9HCb5mQmu+AwPBxDhNm
         BtN2AIegZ+ewFD5RHi6jbdzmKNf79gDfz2m4EAX/4/yTtfR3CW0ix73QAcNS7M15ysnD
         2vxw==
X-Forwarded-Encrypted: i=1; AJvYcCXbmYoZebZ5HFLzZ+DeOhRiDb/ryx3Jbl3KX0YkWg5uiqJJQ789e5m26r7FvWBoA7VrQuQOQtkXnGSZgU17uqI4yPABTstiGA7DtNI2
X-Gm-Message-State: AOJu0Ywd6Y7GyErPxHL5cJ/Xyob5R7TguDL2qhUJs+rQl3dwC6iwbY2h
	bJ0Y2/gNFSRgN2MCzO48hB6kEeChEh4bPdJRGqXoIehpVKVlRxe3ku9ZRzn5sDTjIg5ze+PBSor
	Jxy88RJg4pUGA6NJugTYmc0l4hrwiuvB+PvYm
X-Google-Smtp-Source: AGHT+IHpeBg5e8K4m1AjsYDN5Lf6w44ZrVNCRytKZPa/zJpkcs95lHEvp/x4E8DP9QtdgZhxg7CCNODor9FG/pDAGIU=
X-Received: by 2002:a05:6830:2714:b0:709:3b82:7680 with SMTP id
 46e09a7af769-70940c1aa9fmr12988155a34.19.1722283739275; Mon, 29 Jul 2024
 13:08:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 15:08:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8fa86c0c-183b-4787-9525-38dfe6bcecc6@quicinc.com>
References: <20240725220320.130916-1-quic_abhinavk@quicinc.com>
 <CAE-0n50mBEX98HH+5BurM-uRyzrxcPXFJ7yLg__hFJHfYjm67Q@mail.gmail.com> <8fa86c0c-183b-4787-9525-38dfe6bcecc6@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 29 Jul 2024 15:08:58 -0500
Message-ID: <CAE-0n537mpOMkVWrXGSpjU8cHZtUZXFfdG1YTfevu2SRo1hPTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: fix the max supported bpp logic
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Guenter Roeck <groeck@chromium.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Vara Reddy <quic_varar@quicinc.com>, freedreno@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, quic_khsieh@quicinc.com, 
	Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Abhinav Kumar (2024-07-29 11:28:35)
>
> Thanks for the feedback.
>
> Your change looks valid. We can use this and drop the max_t usage.
>
> Let me push this with your Suggested-by credits.

You can take my

Signed-off-by: Stephen Boyd <swboyd@chromium.org>

and either squash it in or make a follow-up.

