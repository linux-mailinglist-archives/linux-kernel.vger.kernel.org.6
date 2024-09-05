Return-Path: <linux-kernel+bounces-317071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE0196D8D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3C41F2868E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC7483CC1;
	Thu,  5 Sep 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxbC/NB5"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF1719AA72
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540029; cv=none; b=P6Blob4I7IgmHRK51DiVkdt7MO7HbyU+4VdwfzdHH+A3cTGjkfgVizUB/LCC4XLO5U4LFeYWZr1kVEn7edwcDHb9XavTptZ/bWhK8oFydLMT61s8RHQhh7qpgBZP+Da19lIuyk4F4RA3tr7eOakzhQBVGrV8vTs2SeZ6Rd2Af5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540029; c=relaxed/simple;
	bh=fzA2hdbSwtF6yNj/lg3pCMgfy9iVOOCh6iuP0KhmpcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTz3TP0hzDtg2kBMnQHrjjDt4fyJGnCo9+Rb+QhlMssrA+n6l+papYkEyJDoz+YpckMAs2OsFGlT+KyDYl0OfDiHrvJkYbWHv+axfOVgjsXzORB7sFC0VDkwPOnV2RQxoF1LhfB8HghpR6TRBBU69DGrby67wVcb2yc86PM3KDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QxbC/NB5; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6d5893cd721so6369617b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725540027; x=1726144827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cAsWnhIXMINBCA2LD6vZLoTkLzPunHo5mBHMYdvy5yQ=;
        b=QxbC/NB5B7kx9KoMYzo3Cgxr48xfdHA1le7nE5iAut9AEcFqI2UcRcfpM60mnoNs3Z
         384JCx7fdsT2eqf+BGdZbClF7kcdh+SjeufTlgHWoW0PJRCrPsmZ10CffE1Z3v/lJeqB
         7Gydk2V0NB7m7IFgtGqvyaqA9WRnM3v6ytkLf2PguL97MxRFevR8ZyURN8VGcsKDVyRS
         zs+bDXB/aeEcxhvApv6n9s0zTjA6tmVMBoXSEa+LHc+jwJBylKPf5+Vt58/NDEL8fyXz
         pPEs4onJhCXIhc45/zBfBvXVymWdnN2ppMb8mIs5UOBA0XLlil034rscXq1MDPJqTTez
         6Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725540027; x=1726144827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAsWnhIXMINBCA2LD6vZLoTkLzPunHo5mBHMYdvy5yQ=;
        b=G+z6dkdSNNewrQxMIsQH5zDF9GIuMVR0Ndj9CEbWCQJ4YMZKh2uLxAUXdWRhvwXIt8
         Am9m4hq8+X+xxm4nojJvgOve42V+05/A2wyqpMfHDNDY+WBmEtg20r7I3N4GlmlbnDpX
         AI1YhM4jBinVRf+I4R31rcKa64oxTNGd3Z/Tzml8fK4bRkS4lk2XqrZW3Ltr40jF7jgf
         jEL5iDlOiaH6I9EWKB29uIEVTNpwCDY1HTjtxtb4mcCK+5V2J38lprDEuYJ6LdjpNftY
         U10MbPMv3AlVHT9apY9HqwKKxZOInTGGJ7Q5ODh8eWqiVUeFL1sBHfBUh1fGDFpZSGEf
         nbvw==
X-Forwarded-Encrypted: i=1; AJvYcCXubhCS/P3HGYmvQqTSetMVicyV40Cbzr8TLqGxVSLIfsqtWlXUI0l+HMuqi6b6dSUfuc03B3imdSg50ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMxwc+0P1tNbpFwE3DPwITcO6nvXNfMdqVLYXYcua2/1cCZOH1
	Qcd+OzOuUkTlY8yfQeffr6FN8LIOJMT/eoWXKwct2FDoOebmYwdT5BjN/na5eJHWVBJjsPhJVhL
	DH8xxosEgXdoyNM96L6mG9UW/GFmsrCkfTswR5w==
X-Google-Smtp-Source: AGHT+IFIWLL0YlxXEHzETETRS/4fXk/TAU6J/4Fvm95WECnhr++irvMb/d6wkqFe1PbO8tUu5xvRXYLr+luqmfEBPLA=
X-Received: by 2002:a05:690c:6481:b0:6d5:7b2f:60a0 with SMTP id
 00721157ae682-6d57b2f64f8mr207770997b3.34.1725540026953; Thu, 05 Sep 2024
 05:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-fix-dsc-helpers-v1-0-3ae4b5900f89@linaro.org> <172552245933.2905944.14392896379200688443.b4-ty@kernel.org>
In-Reply-To: <172552245933.2905944.14392896379200688443.b4-ty@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 5 Sep 2024 15:40:15 +0300
Message-ID: <CAA8EJprBwTH8R9-b68g-U6yA-FN6z_pt4YComNCj-xvXwvzcCA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm: add two missing DRM_DISPLAY_DSC_HELPER selects
To: Maxime Ripard <mripard@kernel.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 10:48, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Thu, 05 Sep 2024 06:08:20 +0300, Dmitry Baryshkov wrote:
> > Add two selects for DRM_DISPLAY_DSC_HELPER which got missed in the
> > original commit ca097d4d94d8 ("drm/display: split DSC helpers from DP
> > helpers") and were later reported by LKP.
> >
> >
>
> Applied to misc/kernel.git (drm-misc-next).

Thanks!


-- 
With best wishes
Dmitry

