Return-Path: <linux-kernel+bounces-512078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA02A333CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA851166C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8547433FE;
	Thu, 13 Feb 2025 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tR0PgMek"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148A10E4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405240; cv=none; b=mU9IOj1Q9yCLJH7AIqSh8WHNKKHMtYYCkeTYbvcdqbwHuH8+yFdY5g0G/72Tz6z1U1Sfjfm8MAADSVXxL9Lt0ov1i1kcntsZwMi72QIhbS9wtxFwycAaQKOI51pzA+jeWCz6PLHVJa8tbUkeSjdHDtkyZzqbnnZepxd0rRTN+vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405240; c=relaxed/simple;
	bh=wAQQF2/xUxM6dl/LsVAawc/JJGfCxfKXoI7le3pPCXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLnncXNmy8UJH7ZJDoZcfQl2hJNvxLDwHH7lxjgifh5dMPgVJRXz++QcqAaZ6SccK07Vi1PLavKWFpATza1by35Xn/3NMbMEwX3Cj7tx8er0kkt1o/eyspiSTLNbZvx0yqKOh7QBOz/1Opt/lPUf5ro5RUrgf4aJAu+QzOAvoHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tR0PgMek; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5451d1d56a7so314498e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739405237; x=1740010037; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pf8gs00/4/9w7W7B+PluDcVXqKZN7oOLtPqkB411rw0=;
        b=tR0PgMekS9KUItlPVTPZ/jPRopmyEbp7gCNSvovsQVRU3WNeZp3Lo3KkZnDu0szsnv
         WdFDlKJKsSfQEKdyspkhb6ffBFLzU1rHxngMWWUugHDjS0NaIyBqm7eQ+MtiKw/WEeq+
         c2vvBtpUONtGLLRM+rDlaJk4x/ocM3RIfOE88srufGBP1xCRNsBlaQCVfwR8JKvHrMdd
         fwAmzHGg8hnFFGztaKIIUG6gpcOB+CB4CB8g9mkv1eA85e7Yhh0EZcxeRdFg3VAlo/UX
         RurbmW+aeyEi6+TCBgl08WeicrBR8CKfLmDZfwEXf8tboeDRJ2SusA1xk0ftfrsX6Yua
         Ws8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739405237; x=1740010037;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pf8gs00/4/9w7W7B+PluDcVXqKZN7oOLtPqkB411rw0=;
        b=vgv7GdtAKRwoMXNLC+Rr/6sb5hdw6j2XvQg7ptZt70pM/EP7L/p4LbfjMWuEREPD8D
         L0R6Iomt5AuBTLwUikf1dXanCsmhy0vzRHHChrtK5g1CMnhX5jvfOCvpQzCDCYthC3EI
         GTpEf6dAY8bxiKOEz8dxSVSHL4QZUpHrJchbtvhj4Ejzw+mk+SUkApiyYyChcoETyfnl
         DbxocXYFXvBs3XBf4GeosuJY0hlwQW+zfFEjdswrqonabMlMKZdPa7LPZbVM1XiZWgbR
         E07WtnJjXbME7fPuvLPbawOLY9LokaYAhxhU5xDWPl01IVLqHgoZUrcuG8A6ZAi5l0Lk
         g4eA==
X-Forwarded-Encrypted: i=1; AJvYcCXHIXZ4dWtfxtrmryu1LjDtAJgZIrkkJ2IM1EVsC7eAWX9r4QGgPehJ+OtWT6nf9VRMFAzQHIA5vLNmkUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMoEkIkDr4H/ybuSja/wxQKOQCfpK8DLoTwNLsJqzXvFMt7chM
	Q4//2T3T+92KGITpMvI1qn6x0HAxKZ0J9ymJ/om50RzBMEnkrFwPGeqbv+FyZ3Q=
X-Gm-Gg: ASbGncskrsGhwMxLsClN8gxPrSDYbDDe1XskJUkYe60ygq8EubkJCwws55Y5MINOlaV
	X3XlXPK93SRtpGdtn79dgu6IfU6CWDff6DQL46ZoHCO9MMeczSbrDVaB1u8ORxIPrOx6ri/Ln0C
	127PRZ6SujoDEGyylol6N+2ZMwZYZT4yThh8UJMiMXqSBOL/AFJ8ArTLJ2h5zaz2mi0ZkDCeM8p
	yjk2olBEj4Ygj1SLomN7zqd1lAY7ASSEYpEso45rJLtUS0teWW/IZQ2o0OmKA4YTHFXkhGHoGIG
	XeSWAFYyHhP3O/ZMlW2KFEM4lLEFK8ZoNgAQLHBac9ERsD1cms3TEulA7Qj08MfhXPhgOyY=
X-Google-Smtp-Source: AGHT+IGgaIb79GOenbsc3e1MUpq7bHd0RnhtaMAeeGwuUeOTEKM4SryWszGVytnTQkm7zU/gnhk9pg==
X-Received: by 2002:ac2:4e95:0:b0:545:fdd:9ef4 with SMTP id 2adb3069b0e04-5451e4f0750mr213183e87.8.1739405237077;
        Wed, 12 Feb 2025 16:07:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105cdcsm13282e87.116.2025.02.12.16.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:07:15 -0800 (PST)
Date: Thu, 13 Feb 2025 02:07:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 4/7] drm/display: dp-aux-dev: use new DCPD access
 helpers
Message-ID: <g2md3uz34tv7atlxm6cvkdwa35pjulwovmlyj4ausoson7wrkw@vjvfpcaejrck>
References: <20250117-drm-rework-dpcd-access-v1-0-7fc020e04dbc@linaro.org>
 <20250117-drm-rework-dpcd-access-v1-4-7fc020e04dbc@linaro.org>
 <87tt9pn8uu.fsf@intel.com>
 <7unkxysvdn57fp6t7sjmgqsiacg5grbrk4lp3fbfdvaht3hq4o@gqshn45sa5ww>
 <Z601HHdh2Zn62skU@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z601HHdh2Zn62skU@intel.com>

On Thu, Feb 13, 2025 at 01:56:12AM +0200, Ville Syrjälä wrote:
> On Thu, Jan 23, 2025 at 01:05:47PM +0200, Dmitry Baryshkov wrote:
> > On Thu, Jan 23, 2025 at 12:05:29PM +0200, Jani Nikula wrote:
> > > On Fri, 17 Jan 2025, Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> > > > Switch drm_dp_aux_dev.c to use new set of DPCD read / write helpers.
> > > 
> > > This might be one of the few places where the old functions and the old
> > > return value was used in a sensible manner.
> > 
> > Well... Yes and no. What does it mean if we return less bytes? Is that
> > still a protocol error?
> 
> AFAIK short AUX replies are perfectly legal accoding to the DP
> spec, but we've not really seen them happening in any real
> use cases I suppose (although I'm not sure we have sufficient
> logging to tell whether something failed completely or only
> partially), hence why we've never really handled them
> correctly.
> 
> For aux_dev it might matter more because the common use
> case is to just dump the entire DPCD, and some displays
> violate the spec by having black holes inside the DPCD.
> What I don't rembmer is whether those black holes actually
> result in short replies, or whether the entire AUX transfer
> gets rejected when it hits one even partially.

I see. Let's keep the old interface just for the dp-aux-dev and make
everybody else switch to the new interface. This might complicate the
patchset a bit, but it seems that's how it should be done.

> 
> The other concern with not handling short replies correctly
> is that writes (and even some reads) can have side effects.
> So when a short reply arrives we may have already triggered 
> some side effects while still claiming that the access
> completely failed.
> 
> I suppose if someone was sufficiently motivated they could
> try to handle short replies more correctly and keep retrying
> the remaining bytes (assuming that is the correct way to
> handle them). Although with those black holes I guess
> you'd eventually have to give up anyway before having
> transferred all the bytes.

-- 
With best wishes
Dmitry

