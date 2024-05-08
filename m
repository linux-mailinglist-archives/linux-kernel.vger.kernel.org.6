Return-Path: <linux-kernel+bounces-173872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAAA8C070A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548881F23306
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669D8130E4B;
	Wed,  8 May 2024 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nDogj2yk"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4974E823B8
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715205629; cv=none; b=LUHaAlAb8c99g9SyHuyNZ/BwGj9hiyS3+J8qs2LiAMu7tX8QMHy1+T5BdmHns1yJL5gVjSJfdfjbKGUtypH6El9It81CCNlbMSqsg4ZlPi61u5TrOSa/r563A9MA/YwWtGrzDJQ+AbTZqTvBU+pDwcwjwn8c24VAwNyaewQLoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715205629; c=relaxed/simple;
	bh=j/kLQd0cbrp1oqeSRoP/JS2lmoMLaylq5Y+PhH7Jb3w=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcooGV9SU7ftii7Pu4r/VhMGUEudXIec/mwRPv3unDNlRy4cZ+X87PkCFy4s7c9dl1vI+dPI3BnwRxROVU1Bm7y9TFBInd2Qe+20T2vqbgMcxetcNOwuLnXhAPmDncF0q14RnILshRFCpCQPKP8yucSCD0rfhldJVW28B4gEfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nDogj2yk; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-792bcfde2baso11399785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715205627; x=1715810427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/kLQd0cbrp1oqeSRoP/JS2lmoMLaylq5Y+PhH7Jb3w=;
        b=nDogj2ykG5WBXYRZxYQUI/bXNGRmJVSxzwhzJuC+a6+x0sZ5N71FiMwUrsORnSBmd3
         6hgDhCggYTfpdCE0SPD9u9RMfc9I6QODWqiXXtkln1sIxQzvJDJ/WxPndGkGIvGxiPCk
         CT/CEVdfm+0POe2OVE44OWC4u6UVvAX9w9WE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715205627; x=1715810427;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/kLQd0cbrp1oqeSRoP/JS2lmoMLaylq5Y+PhH7Jb3w=;
        b=fg+OIvHtYvvJ30Z3b6PIHZ33vY8EllPvIStgxozwSJBHMV150KJKkrZ6lgifQ23uFi
         iNvpjn+bFMuHhwc//7oGA3qMlhoNa14W5cyizZ0XvhqVZ5uRtihjNNzRd+5XnGu5z4Xy
         UNLFEY2hBv6ih0vrNSgHhz5CYhUPtKJadE+KgnzadsPLBC2PbMekfoyJWwtgbg+/BHhz
         yYbaRZX7lsWE/CK4F9G8GRWHgkpbr0QaoFjTdksQyB4HDVAiIzGPqHZgHiQnMq5TJncX
         E7OD2vH+Bz67cZeuFNPx5S12jHPqgn89JCYRYbm0nUEYkgYGu7V4Kn3VGm8Ic/iI2WyL
         JB1g==
X-Forwarded-Encrypted: i=1; AJvYcCU0vlxhfWyTQkwYXI+w1v5S7tPaR50+d+R7bihcKyUSDLHkc2RRsIYkQnO2OVNULFyFH6aBlQru5HWh/F3X12ni8diHlhI6znXH3s3h
X-Gm-Message-State: AOJu0YwF+Jf1IjekQFbp970UQJKutTJtObiM1lYGZs2kVbSWrR2M3yMK
	HQntDe3K91oML0Ksv5DTRwZd0SVzudDroHDZrXawPK/vu24zDss9zG1kmWnUYCgkXNqTfIQpjJz
	T2jU30PSs7D5MOebqO+rVJ7a4MsxvHpNnVT03
X-Google-Smtp-Source: AGHT+IGWqLU1ICb4oSoi/9XAMgJVPuBLEWgl/SHPBap7kXqtX8RC2o95pm9Fnnk+3bonio7wO95HePihNpjGcIn3FZg=
X-Received: by 2002:a05:620a:3721:b0:792:b938:7769 with SMTP id
 af79cd13be357-792b9387953mr305283485a.11.1715205627263; Wed, 08 May 2024
 15:00:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 May 2024 18:00:26 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87a5l0lmlv.fsf@intel.com>
References: <20240507230440.3384949-1-quic_abhinavk@quicinc.com> <87a5l0lmlv.fsf@intel.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 8 May 2024 18:00:26 -0400
Message-ID: <CAE-0n50O22Mn0N4jMUAK6YMRJiDvuW9VhPnLg=TLV-SecS3p6w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: remove python 3.9 dependency for compiling msm
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, freedreno@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, seanpaul@chromium.org, 
	quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Jani Nikula (2024-05-08 01:43:56)
> On Tue, 07 May 2024, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > Since commit 5acf49119630 ("drm/msm: import gen_header.py script from Mesa"),
> > compilation is broken on machines having python versions older than 3.9
> > due to dependency on argparse.BooleanOptionalAction.
>
> Is it now okay to require Python for the build? Not listed in
> Documentation/process/changes.rst.
>

I doubt it is ok. Perl scripts have been replaced with shell scripts in
the past to speed up the build process. See commit e0e2fa4b515c
("headers_install.pl: convert to headers_install.sh") as an example.

