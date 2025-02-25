Return-Path: <linux-kernel+bounces-530326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D2A43217
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D02E3A6891
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62A34C83;
	Tue, 25 Feb 2025 00:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpRbg6D+"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180B04C6E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444471; cv=none; b=OTjCfFo2AT5NZpRnohWas3yNdx+hMsu9doKWnYDNMB0idi8V4M6ihXnwe4LrYUrWiDJTD+dQxHK96viS6fWhHV2QfoU65j1bNbuCiqSxllbFEh0nM7j9maI+YSZLs36fPosj8qTpkf6xHL2WbG36h4PSZ8jkrRbQ5ktJ/eBlJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444471; c=relaxed/simple;
	bh=mkjPI9d9ifZtKSDpEn3V0GV8js/BQUFq7lkKDMU4Nfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oySZUkTLnM8Jj672ziMGO6C1enOP5BWLHJyCow86CS97CopUt6TGPEx4Oyf+7JZ0nnjW0TWN9+k9ytLMuqSZOauqC6YZ/MEDRk6OkkbftlufrPmTdS78qFa/8RD5GT9KA0hmVTJ2RKdhYhK8RIMA+JppxRtAktK/k7QDjLrL8Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpRbg6D+; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e65be7d86fso57733526d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740444468; x=1741049268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpDv/XBjF+s4P5146GDNRKrfP1oGnV2PgjpHddvbttk=;
        b=TpRbg6D+UfFYnE/cJ9nSTd50M2vtGqsKL+tB0nLL65mRnIqRnrTGpZAhStNtfkQu67
         frmOC3gjjlAllCSj73w0J1Md66TZYyFzlMBjuWFjPYauGwbGOqP+8IpDOpiqkVrGJpJv
         LgWEKHwwyLhDM+YaTZOOALsHC/Y8dzkA5gZveyTUZhehjEgUqEE8UQHlgH5vzTOzSHW+
         b3Rwl5gUKXj729UYZAAiSHd89ps8AjBLbHgfO9IqY6V9EnCL4rGL0vPAcM9eFKnmBiVk
         9QxUfVCymUmhJTKVAFVwcJhwWfQuD7giRcl5hXh7e+RoMYDkh+Pj21m2AEQeA+IULQ58
         V+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740444468; x=1741049268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpDv/XBjF+s4P5146GDNRKrfP1oGnV2PgjpHddvbttk=;
        b=OXHg4UeT6ZqgZ17kIgzqzRmELwdN3C2egQErVKrTlROUgLhI5Oc78xll+xXmAHpl6s
         gpWB/Q6DHQyRA3R+sS5GHBSJs4SuhEtdMqrvdNWWmO1eLxbppbkqyC7Vc8zBHePD6J4A
         Q+WehXsmkLGtRymZ9vaLGcn3G/USIwSSsU4YWXmzocJOvxN4cX8FaV8XRhcMaF8ut3no
         L0Wqj0sO1cTrEBoB06i6M789m2s8tuGjLn2vibY6hirfC0NKC/7L9x0cH11oozHtJbkl
         xRcLG5qk+EJfxsM7dfp6dIWcRz24h86VFGsFaIt/8HA2EuorM4+KYnRbGZq2/mtH/jlY
         FiUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi9WGMH0qcSgXZsVT7dfBFzDHq+dSNh52bQi58SKbrBomrb+/FlIViIrr9Asxl7110C7XMBPs04ksMRM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsPyVPfLeAS/oaETyp8FCsk/0U81e+Fnwl+qUuKPzJ0t13CWN
	vO3M/Hg1VFbtyOdaC1kOFeYahMsJLTUe2r5guu8upST7us2ovefr
X-Gm-Gg: ASbGncu914SURwzcZG4fHuL8twDu4AGsdqXPtjtwcCIxqBDfH00CZWEuHIaqEu9mM9Q
	jMRpfZUavJ0y2sE78JAFosrq2k+FLnnE2N4anh9iV9Rmhll1+IN6J4WHdomFnVNVPTSvvCR/J1v
	9x/lOTCjU6J5CWmlCmUx0XnQLdTCShAgmUdtI0joSP54BHcttX73sCYRBtlt45EqFjhvI0oweIe
	m06IilX4QwDHi1d2+8nBB1E3nUxNX5l5L0nIlC/F/nnOs+8AcKuKbEkV4/7qPefTZ0t5YBJFCYF
	7xytYiyrwqq0UyHx4ufc9zdF2LNR5PxpOIQOJVTy9Qajk0E7yYOI
X-Google-Smtp-Source: AGHT+IG+6SM+Bt5UY1qGOeuFzoM5/5BVekUTVIxeOCAtQEf994Mkci1dcvUTDHwYRZ/LzO3ZtcuihA==
X-Received: by 2002:a05:6214:48c:b0:6d4:287d:b8d9 with SMTP id 6a1803df08f44-6e6ae70a617mr221340466d6.2.1740444467841;
        Mon, 24 Feb 2025 16:47:47 -0800 (PST)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b06dc4csm3561956d6.21.2025.02.24.16.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 16:47:46 -0800 (PST)
Date: Mon, 24 Feb 2025 19:47:44 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] drm/repaper: fix integer overflows in repeat functions
Message-ID: <guxzx56pabmen5gb2mauvpyazpxvod7ofmz6zmisluugrirw4v@mzs5yg6m4pox>
References: <20250116134801.22067-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116134801.22067-1-n.zhandarovich@fintech.ru>

On Thu, Jan 16, 2025 at 05:48:01AM -0800, Nikita Zhandarovich wrote:
> There are conditions, albeit somewhat unlikely, under which right hand
> expressions, calculating the end of time period in functions like
> repaper_frame_fixed_repeat(), may overflow.
> 
> For instance, if 'factor10x' in repaper_get_temperature() is high
> enough (170), as is 'epd->stage_time' in repaper_probe(), then the
> resulting value of 'end' will not fit in unsigned int expression.
> 
> Mitigate this by casting 'epd->factored_stage_time' to wider type before
> any multiplication is done.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: 3589211e9b03 ("drm/tinydrm: Add RePaper e-ink driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/gpu/drm/tiny/repaper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
> index 77944eb17b3c..d76c0e8e05f5 100644
> --- a/drivers/gpu/drm/tiny/repaper.c
> +++ b/drivers/gpu/drm/tiny/repaper.c
> @@ -456,7 +456,7 @@ static void repaper_frame_fixed_repeat(struct repaper_epd *epd, u8 fixed_value,
>  				       enum repaper_stage stage)
>  {
>  	u64 start = local_clock();
> -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
>  
>  	do {
>  		repaper_frame_fixed(epd, fixed_value, stage);
> @@ -467,7 +467,7 @@ static void repaper_frame_data_repeat(struct repaper_epd *epd, const u8 *image,
>  				      const u8 *mask, enum repaper_stage stage)
>  {
>  	u64 start = local_clock();
> -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
>  
>  	do {
>  		repaper_frame_data(epd, image, mask, stage);

Applied! Thanks for the patch.

Best regards,
Alex

