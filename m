Return-Path: <linux-kernel+bounces-282856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E4694E986
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0916B21862
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717AF16D33B;
	Mon, 12 Aug 2024 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KAMwVOSS"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F078D20323
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454219; cv=none; b=ez1g3C1cgC3GuMBa3LR6kQEuCbSjTlHMKL0W6OvmswXSwWwjz6fWL8UkipWqUACDoi18tUEnWRfcDA0tjK+fOFFNHMZjJWczV1cse0hin7KvcCGW04pCLVqt2P0hnRCZgClzbIAQti0okyAIleRcx76Ug08xcfsH+P1+pmmDJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454219; c=relaxed/simple;
	bh=PEFhonk+PZwX1LXmFTVPLydUWuGxvjd3R27W1uM5wEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIR196RgmyhkJUpkZKEjD7QKhrLs+CoYb4hr5GYCizIPQjFQvienw1x6HDTMu/3QQpAY3tONbL8OFY3pFkgoxputc3jO4zU7K6vAKXChItyB5ouhM3ZZJu7OQrBfzD86PoPm/hJKuyP/gDI9Qm8v3jp3K5aMlQWzCNXZTTfL9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=KAMwVOSS; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f008b40d7so669645e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1723454216; x=1724059016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fozpmkVWWoUxRzczgwDre6X/R/fGJO0cgQAfwJipm1Q=;
        b=KAMwVOSSyi8oJqn4N/ECzmoMiAfOhjge48fiFl3wQDaYtZDQi3t9Rc7MOSkK44+fIl
         Kr6XfCt5RlLcHVGGy4cLbLcQtnURNnrPYreSt0fIvFKNBCBVkVjvdh3QOUiyAYxAwCBQ
         3OYjHeSKjiCRdn9nFCAX55gxxRR9ZmdZtLo0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723454216; x=1724059016;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fozpmkVWWoUxRzczgwDre6X/R/fGJO0cgQAfwJipm1Q=;
        b=CfyCgnf/MLfmqNXRBLp7Oj8B/haKeQ7ET5CU97K1kv09sIMDGZcXhFQTkPUefm6Knv
         smrq9elvOiekVYlFBIWw/NxHZ7ssn9Y01oaUhXdmpPsutXFRDVRWBJrvVlikYtqlR+EL
         +Qt+Fcbkr6udbHUTLBDsk0aw/mSV6uEnC/3ORvOmdE+b9NyZ1pC5rq0gJVlT8ViMDcbQ
         JZpVPCWs511zL7rzJHZXGgh2/ZG6Q8BBg5MIG8DgjPozeKsPJglHvzSyI85akesAAku9
         VEjeEJz8uGUPSIXPOvCDcHv8aiRS3GOWk0Z+igNP1UgbP+Wbya0w4ErTvoVIwPdRyPLZ
         /kdg==
X-Forwarded-Encrypted: i=1; AJvYcCU/v/V6ONBGRZPHUwa2FswgRm1yFiA1MYRfI39tivgAw7qMp8RoIK6EzwI+u3Z1rakkiJtDt6fyq2+OkHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7SLD9OFIc94qJ4snXP3hQkP2jBuGFFk3bdX5CAgeig0UoIQm
	bDvLmzTGz20iZ2tu+Eq2zGf8N5+F4749IuCpjFdmACc+AhV1lhAvKwEuZDpOflQ=
X-Google-Smtp-Source: AGHT+IHKBjjM9DjOVxrp2iTIQMmX+DJ0sYeTd6fdCEHk+BQHbEmoLJVR94CfcpRFMvbYy+bSd0R12Q==
X-Received: by 2002:a05:6512:3b29:b0:52f:413:30de with SMTP id 2adb3069b0e04-530eea25cc4mr3498999e87.7.1723454215812;
        Mon, 12 Aug 2024 02:16:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb090253sm216583666b.16.2024.08.12.02.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 02:16:55 -0700 (PDT)
Date: Mon, 12 Aug 2024 11:16:53 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Add missing documentation for struct
 drm_plane_size_hint
Message-ID: <ZrnTBWq0fpKhCvpB@phenom.ffwll.local>
Mail-Followup-To: Mohammed Anees <pvmohammedanees2003@gmail.com>,
	airlied@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240811101653.170223-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811101653.170223-1-pvmohammedanees2003@gmail.com>
X-Operating-System: Linux phenom 6.9.10-amd64 

On Sun, Aug 11, 2024 at 06:16:51AM -0400, Mohammed Anees wrote:
> This patch takes care of the following warnings during documentation
> compiling:
> 
> ./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member 'width' not described in 'drm_plane_size_hint'
> ./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member 'height' not described in 'drm_plane_size_hint'
> 
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>

Applied to drm-misc-next, thanks.
-sima

> ---
>  include/uapi/drm/drm_mode.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index d390011b8..c082810c0 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -859,6 +859,8 @@ struct drm_color_lut {
>  
>  /**
>   * struct drm_plane_size_hint - Plane size hints
> + * @width: The width of the plane in pixel
> + * @height: The height of the plane in pixel
>   *
>   * The plane SIZE_HINTS property blob contains an
>   * array of struct drm_plane_size_hint.
> -- 
> 2.43.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

