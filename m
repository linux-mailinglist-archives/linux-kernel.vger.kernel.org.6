Return-Path: <linux-kernel+bounces-443850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1478E9EFCAF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9A61634D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DFF19AA58;
	Thu, 12 Dec 2024 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QMm2vgcY"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BFF17BB34
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032651; cv=none; b=ovPOvI5Io14R/U0xZQWzBTNlq4spEUrovdnQrpT08DuPDC0JniN7OrZr8KjsWtSY/Q0hL2cmK129olCL/kN+XvvBY7f2dG/DTd2p4OHXDiVSP4MbGddefpfYDkLfKCpzdieTvxCvM5nXB6Ms4uszf1Gwyw/apLrJoKGSrEAY9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032651; c=relaxed/simple;
	bh=UOwm6pPXwkM6tnMe7tNVUkQBZxbqhnbT7YBGfwH78PM=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awItBv8TvuhcPR8iaRGtgD4lYoSLGaVHUdcPzuofQn+MHNeDFbpbd7z2eILsK7lV1arpd3RqD8pzaUqVlgOYAsmxpNcSyvl7pIyUsVcZkB5b/1Qc4myU8VAsMRfSRMBN71qjKsOPhRuH636w1AU6Js2zfI4WgaktjpOzrjPd1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QMm2vgcY; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b15d7b7a32so98694385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734032649; x=1734637449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOwm6pPXwkM6tnMe7tNVUkQBZxbqhnbT7YBGfwH78PM=;
        b=QMm2vgcY/cPb1BxJZxypGYygMZbPvr0pLbuZnAaib3ifuAOE1sxblhY+vcyKdzTrj6
         jyictjQz45hJsUoyi3QLRu8WQXsjDJn59B0YpE1jcKwH8ECb+fuHSK0imamo0MLuIdYd
         1pxC3KdxHFVt/CV29hJFa7bXLY1Czf4bNSlco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032649; x=1734637449;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOwm6pPXwkM6tnMe7tNVUkQBZxbqhnbT7YBGfwH78PM=;
        b=aeDjUpqFQsKKfRvg9SwS4q4D9Em4F/Vq7FVmusiGw51PoLQ3MGKsA0PQY6//tIpJ8h
         WSDp8emk/Lgy4+r7YeoNsgMDDVwuuGMCb+1+GKcHaUOgEzH6yemLl/5yfu6BaYIX3Stf
         3i2xRyvMMCNGsFotO+Sm2LbB4i1MBI1w+Ou8NUm0U/oG0ab9P+nRz0fdxcTopfK4mLo0
         J+oXWlP1UlL4lUetynvqxwxzzWgUR/V+xHlnjZ/XayeROqD071pJ3/Ik2SOqs+pmLpwL
         MMBl3+W1bGBbEkTJ6ilDq2OuMlScp/ICcoWH4MitoZsWLd6AcHHUgENCGIIuRrxUHJkP
         I+vg==
X-Forwarded-Encrypted: i=1; AJvYcCXi0WrfudtI8TzeFaRGwAhIi8IQrtCxoUiqWVx6D1/PMeBkRwRf6sYjET/kK7EoUrxdffD7/Ptuu9OiefQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5H88oodG2Du/dkUdhoA27I7mO8KfmPZi8yPI0527dvtZhvdq
	O35TVAGEVCm1+VUMFyNgs9534YZQKDsWbMAmReafn6lzoNqIlHCtNq7IplXD5gCFHbt3DsfKoEK
	QTBURbQhjXY+/03bShDs1keUVoB+72orYhUa3
X-Gm-Gg: ASbGncuWBTxlWDG64DtkBmqMrL9fkARAQyjlg3nIAizX+Dcl5fzChSdcnMl2NEWSTM9
	gVOAWMCm7LzECKoRKzKLiycr+MXmlL7FeBuZtSBg2LNmOZkg2HI1wFrIpownzDfiCmQ==
X-Google-Smtp-Source: AGHT+IHlXSEQ2wG5xyF2Aa1OBgLaNUi0yxcdOEzjtF/Id9mL9j+4TPLwCfOsk3qZGjqHtCyb1hPI6wo56A7bYwjCxyw=
X-Received: by 2002:ac8:7fc2:0:b0:467:81f0:6d63 with SMTP id
 d75a77b69052e-467a15c7a0bmr31511991cf.17.1734032648880; Thu, 12 Dec 2024
 11:44:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Dec 2024 14:44:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241211-check-state-before-dump-v2-1-62647a501e8c@quicinc.com>
References: <20241211-check-state-before-dump-v2-1-62647a501e8c@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Thu, 12 Dec 2024 14:44:08 -0500
Message-ID: <CAE-0n509akHPXM8t6QCTO1cydhJzv_Tu9xTtGze8=bY-rUN=oQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dpu: check dpu_plane_atomic_print_state() for
 valid sspp
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Abhinav Kumar (2024-12-11 11:50:26)
> Similar to the r_pipe sspp protect, add a check to protect
> the pipe state prints to avoid NULL ptr dereference for cases when
> the state is dumped without a corresponding atomic_check() where the
> pipe->sspp is assigned.
>
> Fixes: 31f7148fd370 ("drm/msm/dpu: move pstate->pipe initialization to dpu_plane_atomic_check")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/67
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---

Tested-by: Stephen Boyd <swboyd@chromium.org> # sc7180-trogdor

