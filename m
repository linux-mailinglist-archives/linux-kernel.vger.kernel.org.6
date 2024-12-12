Return-Path: <linux-kernel+bounces-443913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F61C9EFD71
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0062C28BA82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5A11AF0B4;
	Thu, 12 Dec 2024 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oCTWCing"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567A18FDA9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035276; cv=none; b=WDk45UmMohdzqYLjEYMyKSqpWqHs/n9lM5/sZ+N1cpdhkbW0lNvJqm145+uzjpJSZed9sgeQ+q8r4jocWAptE67UbkIT+/02FaE+CfgOojwz5kDbVja9elQmkEF4bB9tpylwW510K8JzVjDvp74H4L/0Um9bgr3MsJHybyaijIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035276; c=relaxed/simple;
	bh=2rXihmp9pWl3LzrM5tfFee/d+Lbi3u9PgbARXkqiJbU=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUmpk/X3ar/dctZLiHN8bek4vZnqZMaQGtAIij7T1BkuyCMK6T/XFRZA2k1EzUlPCEvUp4YEhLoaJSKZJB1k7nzEPyU+HcStscX+LxMsgcbgG+tAh030F6qknG5zmX54z8yeb3SfS3qOxbkl6r274sJlwejPjG6n0DEPhTCCKNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oCTWCing; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso747858276.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734035273; x=1734640073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyH3eYb6Cm9AtiFQGPmrG/m4h3r5bZXGHe1sNdWmzvY=;
        b=oCTWCingdSS0MKYxILzGFoZI3ig1yvRCXI1FpH+6zlnmOcyndtUMNsipQRd+B51GM/
         SjJmn3toOfZAKLlquy+AGjTH6DMaDR6qNu58vCYuflKr1BPeuhHMThRmPELPEE1wMjpd
         sPbolgDS0zUCKElVIzGAMPoc5FbN9ZzFaiW9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035273; x=1734640073;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyH3eYb6Cm9AtiFQGPmrG/m4h3r5bZXGHe1sNdWmzvY=;
        b=DKCcIZOZuHuoFx26nKQ+4R9UANJzR8Qe4z77jTEcaufi/BpxkkXCyc7BWJNIeNgru2
         iugwkO7PmwWf6Lhz/b/LPgs6E3texRXIWbM+rlIgPiSioiWdjMDynwiS9y/wQIdprg0m
         7jRVstny2xbVYB1eRYc+D2Pw1vyPY5ueRPsv7pTL9d/CX8qnC/1nhouvIENNqBFUB4gZ
         Krx3pJm3NM/x0KherXF9w0Bcs8Zf6Eb9yXKbQ+XXFYVx17CDixkBcJPBl2kZeivSC8f9
         tcl1u5hCLoxnKy2UVrvP8Qrv6dWspOEcLxEAUCOddjZUD+rWloEOYawbUOsF3WdItXam
         WmlA==
X-Forwarded-Encrypted: i=1; AJvYcCVqkkRxznyRKThWYL6BTg/FiWwn4DwCa1z11LbDyfe/L35sZwzx7T5R73gnOWrVQOhsaZS8MAyqGsRuBis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWKx6ovi1ceEWFRNBvHKYyluqX/24RDoK10Cub/l7N49kHECP
	TyZQoIVBvWsRrzfB+OwJHoCy1ta8G2LORLj8Xu31VkVkt8ygTMC4YT33fhNc6eVJXHbPy13H8SJ
	lFI3rGsyowAe8E0x6z/VTbpm4xatSkhi1BxTh
X-Gm-Gg: ASbGncv9Y8iSCmiW3uvkmGh0LHbDpAtYXMExJuLU1v3rdrA59lZjkbL+vPS/1xjxtfb
	C5+lc/py9G/wh+zjL2Bu1U3OEIIbZ6+I+fHG6eP6mJEbxuUFHz+nxllpYdekJFk5f2Q==
X-Google-Smtp-Source: AGHT+IG3KC9ssh6ekayVwqUK7Km4JQfm8yz6hlNQTxOXGgPcqzMW7GAJJi4TlQ/fXN099DQlJcEjq7UgjR3xUuloAyA=
X-Received: by 2002:a05:6902:1b8e:b0:e3c:7fca:716e with SMTP id
 3f1490d57ef6-e43491ff2aamr112163276.6.1734035273092; Thu, 12 Dec 2024
 12:27:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Dec 2024 12:27:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
References: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Thu, 12 Dec 2024 12:27:52 -0800
Message-ID: <CAE-0n526i3eZbSsoyLgO=MFPb1_mU_v9c-zgMrdQGWgUvj-+Ug@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] drm/msm/dp: perform misc cleanups
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-11 15:41:35)
> - Fix register programming in the dp_audio module
> - Rework most of the register programming functions to be local to the
>   calling module rather than accessing everything through huge
>   dp_catalog monster.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

For the series

Tested-by: Stephen Boyd <swboyd@chromium.org> # sc7180-trogdor

