Return-Path: <linux-kernel+bounces-513479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7840DA34ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FDA3BEA31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D7D203719;
	Thu, 13 Feb 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IwjNZi6M"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77F2661BA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464866; cv=none; b=aHZHu/1m8T8rp7Jak9ipALqCVwQYOcGHXjH3h5ufor2Z2O7Iq3CLlqZ/Y0BxXVowOWDVXXj9RZSiZxF9ZNFYZpOTTqjNu46aeMr2dUL6TpeNcKzM6tFxR1kyt4CouMMl3oEznVqdKaM3bsaqjZwtQTmW8utyIEKHhTohCBj+U64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464866; c=relaxed/simple;
	bh=z6pGoS8+GU5JM/DC1dczgsvwepaNLl8uBRYUG9BUCsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvwqzXZkljJ+q/PNuC3jUHeZWeGlP7QOFX1pWHdUQzpEeN3g8CTpfVQcYBFZ7XMrwxfTV2f4DRI1IxfFMQtN8sXifIrG7BtfAtU0qUHSA1p+VehmeoN73tIMlDH8YR1u8iHCbdp+sHXtrcbixtt2cX99ECtaZewEPSGoLBcfqCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IwjNZi6M; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5450622b325so1053634e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464862; x=1740069662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LIicl5cuKah00FtYW7+QDG+JbgsmQFASXThZ8eUvZ/4=;
        b=IwjNZi6MBjgKsIRJuWka7JWgcXTNvdTfrwXqA2pbxXZxfqs3pXkbrDa/HyuJ6AEf5V
         s0D3mHGOgLL8Hshu6g8e70WntK6wNK3eRc718fpBQ3Z/PgnXREMsSEEYqOg8TmD1k5BK
         67T6w/k+FhGxS95l+xp3823QjHaGPyFb0xFdVe7cUBioBwxZA694DuKUySz/u9oQCpNN
         oQa/RrWuB7ck5dKoE47qJHqNeK1wQ4zGWD5rQqHE3EG8juwJfiSSG0f5EI/la/PtwD17
         Vhd3eeVLdxfW47jcgS7Ee8P4p9JqLBMOboAldy71iiBtTmxXh1RyDJ3bcyzDVliNcvc4
         i3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464862; x=1740069662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIicl5cuKah00FtYW7+QDG+JbgsmQFASXThZ8eUvZ/4=;
        b=MXhPiey7fu6QZxM4CuzYkyUCGKFtQxgsC+sg2L4DPzlw/uW0SQUnRSgI+/hRqTpcEa
         j6QK3g7J/CPGD7GUhkI4bqrBYUS5HKjfpNBTRBdaEx7S0ttctQiGJsYAmEhLXaNcu1tM
         Us4S9zyBR8StnDHc//Wnrg3cFz3wPtOko+6aMKmBZ1lAOO8OuYLcmNCUvPZGYpvHjV+7
         OZvAwdDaYHYLQY9o0mwhe3fvJA3SxfT+a8ix9wCqnZP+3+URqZEetXrC/rJC0sKC8hlY
         cs+/+LmhJhGD4IJKudL5BD0zmTrqWp05y23J501RMWGuIvF3WGF43q4UWOQMDktB9KYm
         PsFg==
X-Forwarded-Encrypted: i=1; AJvYcCVrp8QWc1eHQ85KjpfLyYvo6OYfp86f4S0gQfswTCWbm2KsuRPOB2GJyPXQAquEDuMHBQAkJ35rtdpPetA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9iy+StSV5MK4eOKgqIplrrdYxCBofX14KvY5L1Y/OYOHrKRY
	qYHAHcA6G16y9gf5Q2J+jln0ekbQib24lw2v8xXRC6antVmeqsEWG4VO0rv6f3g=
X-Gm-Gg: ASbGncuRW2zMCrFHPUOiRR4LfQ97Cj9/2E4dQUivUT3yfQl5dwnA+GVhQsjpkBzt1Nl
	zMB5BReAHqQ5mr1vOIEimfkvFp00kCGQgUABiIBwV5v6Pe+IIiME6I54Lh29YbbR3pD5QrsT82h
	FiOPJpiwhC8V5qk87a36B2W4FxYbShoD39iuCvooGmHS/WLTETojDYmcqcjrEaCLYt4lhyEtony
	YDFhopkUMFti7rvhl65XqDgR/hdJk6EJIferD8KvAR+ihhiYgevLBdVDcckciS7Nbh1K+u7pIwB
	FA03fASxGp6AAvGGNjHn8blljEyfwQ9JoUQxXBJC90S76og+tydPEPWjts2MNYVxQaHLpxY=
X-Google-Smtp-Source: AGHT+IGXPm2oSAiNp+USAUgYcq5R8vaQHTvdte9b3EpR9UR/tAdW6Op7M3K/5FJNlGfQxo2kndNqqQ==
X-Received: by 2002:a05:6512:3a87:b0:545:1082:918d with SMTP id 2adb3069b0e04-5451ddcae2fmr1314169e87.41.1739464862225;
        Thu, 13 Feb 2025 08:41:02 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f09d0f0sm216233e87.101.2025.02.13.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:41:01 -0800 (PST)
Date: Thu, 13 Feb 2025 18:40:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 24/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_cleanup_planes()
Message-ID: <refz4lflzljjfcxfppc2imejjmcvu5fnunljjyuxudgpl3iz4l@6adonu75gu2x>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-24-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-24-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:43PM +0100, Maxime Ripard wrote:
> drm_atomic_helper_cleanup_planes() is one of the final part of a commit,
> and will free up all plane resources used in the previous commit.  It
> takes the drm_atomic_state being committed as a parameter.
> 
> However, that parameter name is called (and documented) as old_state,
> which is pretty confusing. Let's rename that variable as state.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

