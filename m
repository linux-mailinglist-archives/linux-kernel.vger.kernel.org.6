Return-Path: <linux-kernel+bounces-571330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DFEA6BBD6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572E13AD5BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E3822ACCE;
	Fri, 21 Mar 2025 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSNlHN0M"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31222A1D5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564430; cv=none; b=uLsZGPU9322GTaVCLouI5VcWAII7Nfqmhw6CMfJXh8hPFbmptpkwS/hqpBoLuyscF9l1jc/iydDQKVJDfdsqlhVBICQ06HMw3XxWN/28gC28+mb4uqQ8CA1WHAUH+Vv+BWBXfvbc5XmprhpalP6krp8zVE/Gm4Ip7S0I3AgxB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564430; c=relaxed/simple;
	bh=opwfQQbAC3x7SJufn7aNqtclN/SvaHqpbhwErZD/AXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnLvoAiKwJ1qgbxT3+zte/+bDg7UsoE6OH41MI4lDZ8vBbLWH7FLDU1W0AdLnEcPMx+/UbpZgTPFZkjDE2bEE0qHno8vA3HRkYkqZ+CIXmTv3Xjba614TcdJDbC0hsefE8cazl9NHRMpwlYi+lz/w+/swne6BuAUMa4DKjQPzQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSNlHN0M; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240b4de10eso5581805ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742564428; x=1743169228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfrrjcE+zmYhHfkZPIBiI6f0xELcKRCVGZ0NwSalX9A=;
        b=gSNlHN0Muqnlxfw2iwXiCTQxBZzsi65Qp9iHzDTPaJk4BvSkU23K1/8XIr/SlZCcM+
         3fNmCaxbRp1UQs0TkRZCSbg03g1l2z1U5/r9TE83kxdiYxlN3CW8EcM0117xaZuCjUlg
         fK0BUZbftE+MYZi1NSSGMg2121MzBHATJdPK7XW/MLK5Yb4vQDccRpmOTe8SrL835jZB
         /U0I7ARR5hxfn/RsGfzLGfN0hTlG1gyT4/LWUTSiRX9NzM4vkkXjiqimWXmT7N1G6sno
         VjYQ1gQJaE4Jnc4DII9hSluPu3lfT9F/z6EzTp00apCiH6oRWuDUEqjOMHnBptyeRnsH
         EgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742564428; x=1743169228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfrrjcE+zmYhHfkZPIBiI6f0xELcKRCVGZ0NwSalX9A=;
        b=OzjGxORFrjjyicjg0gaQnpbQRze+6rkhPSW3bwAbvNwkqy2KVUo9jM1rzbwu0cnUHc
         I+e+kiR4Rk/8dPfHXpqxJRNBO7/isxsu825V9CUVoijS0MclZJKlYqqXZcOjfFS78aFM
         z39Yd3vYxcoAsOHDuHkt/14CwRubBrTwumRYtwz9fXmtks49ct7u3exDYfODSjKc4p9A
         AvmxPS8rzc+vqcaojuaKYY8CCrgGjr4E5km00V+3XfLv893qzMzNr9kVgC0lbsPsic1P
         JsNQB5ZRGBMt03uz4qWjdYRibMVMTe7wxOD031t+hF9GqS7DmvWbT4XFlFbKW9gttxnI
         kD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuF3mSzIN8tygLo9tGKkasC4pmnTgRmysanh/Z1OCE45ykzFyLvehgYGP4tMiu0zaW1O3yQen2++MM1Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ17Lmr2MMJh0oYYd+cNRRMWtyy00Z/xEJphsegI8xj923c5Z8
	zyKnzqXe8mzLOqncyuipZd0MY+oWP815FhzBzRVqv1hE5cN0thoNLL97V6394H3/TDjH3qiHnfo
	vPC/lRmnOXlFOlQAAxUCDFU/qhZETAQ==
X-Gm-Gg: ASbGnctVYoVrgHnXfZnIG+ygCRpObByvNSIIJ0Ihs0n4MA1AXEi0eUvb0ibnlCePr1r
	RfssysA4rvM+SeROH/nXKqXut4DHUKrar7TYTqYXtBv+kgktmGzvNkg8QQuRsb09wQisH3qlUR7
	3B7nTLNierkK7xxhVcXblTUqhqRw==
X-Google-Smtp-Source: AGHT+IGAned/y4rCBJOi3ppXyF873op1FX24G4PcGsaD5IjbHrfCRwXex5G2mH5qkLiDPIUGm0+MJ2q8gINY/vvWO1w=
X-Received: by 2002:a17:902:d481:b0:215:2bfb:3cd7 with SMTP id
 d9443c01a7336-22780df0f46mr20400985ad.10.1742564427489; Fri, 21 Mar 2025
 06:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321105239.10096-1-arefev@swemel.ru>
In-Reply-To: <20250321105239.10096-1-arefev@swemel.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Mar 2025 09:40:14 -0400
X-Gm-Features: AQ5f1JqaxGo0yV__5e9_Mt95IZ2ZGDSbqPVLFOF5KxJXhzOibt3Pbv0OgX88Ts8
Message-ID: <CADnq5_MsNtgObTgUWNQkS6EsHhXwVyi8EYROdhyvVin8YMsq5Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/amd/pm: Prevent division by zero
To: Denis Arefev <arefev@swemel.ru>
Cc: Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Lijo Lazar <lijo.lazar@amd.com>, 
	Ma Jun <Jun.Ma2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Yang Wang <kevinyang.wang@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 6:53=E2=80=AFAM Denis Arefev <arefev@swemel.ru> wro=
te:
>
> This series of patches prevents possible division by zero.
>
> The user can set any speed value.
> If speed is greater than UINT_MAX/8, division by zero is possible.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Applied the series.  Thanks!

Alex

>
> Denis Arefev (5):
>   drm/amd/pm: Prevent division by zero
>   drm/amd/pm: Prevent division by zero
>   drm/amd/pm: Prevent division by zero
>   drm/amd/pm: Prevent division by zero
>   drm/amd/pm: Prevent division by zero
>
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c   | 6 +++---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c | 4 ++--
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 3 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c          | 2 +-
>  5 files changed, 10 insertions(+), 7 deletions(-)
>
> I did not change these files, because the functions you are
> interested in are not used there for a long time.
> drivers/gpu/drm/radeon/si_dpm.c
> drivers/gpu/drm/radeon/ci_dpm.c
>
> --
> 2.43.0
>

