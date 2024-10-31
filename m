Return-Path: <linux-kernel+bounces-391288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B89B84C4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0521C21E41
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E181CCB3C;
	Thu, 31 Oct 2024 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB+M9nsD"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0DD1CDA3F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408253; cv=none; b=L0d0JZ1syUUCNk6z3O6Mx4SIyhRASQBdfQh1uv0PY+OV2T1odIGXFU8+9e+20yKRytjDSV49bkys+MDtQXPCh2sv5RJYGKRh4F6rZXXetOfq0pat3NiXNmhVghyhK+kxiZ9M8U6H9Gh2GKCVEQuv2CKX5rQHWDqHtgV9sXrWkLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408253; c=relaxed/simple;
	bh=qqfmQwWGNi5gSLmw1HABwNExxBu+L4ODwUKeBji42II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYB8V5gl8L8Xs5br8Kd0j/WW5SVI4t0QYn7hrEpI+lkUugtgQgu696leYLzl6DdBBVsv+Jn02t8vNNuJdIGuM1CK3WNAfJxxqd4q75UY/FboK0JXbUpukH4Xu4JNN6XiyW8uATk/XS98h6LYi2mHutmv8QHxOdgcK5IHLzOZuR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB+M9nsD; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so1049207a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730408245; x=1731013045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqfmQwWGNi5gSLmw1HABwNExxBu+L4ODwUKeBji42II=;
        b=fB+M9nsDtOlILkDLKoRzuOUo5z93+sm0d2iMi9dA7Zlb7qu/s48Pv1GYUU5C4K3YjX
         ue08VMreXBV6EF68uZss9doev19K+/IdZD4uN3ezJjYFjqF4ChPBFI6MMtuddfIGejXt
         iDLMRe0KTRgNyv0o27w9HeK2p+mo/GHJ+TA7V2WJFP/lTuJ5Viu7Spxi7LJ4FTUGdOKz
         F42HlyIcLnGO6tPN/mRlqTerC2qNr3/Eh+LF5S3u4b7Q4mDa6qh8YGVwvkqjyGaLYzUq
         fUVJcix6+cgMD8upvhxBKZmqLi80rxM+Z39mDIZ3vcjaM4iQINxw26r5euMoGVp3JZRk
         KeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408245; x=1731013045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqfmQwWGNi5gSLmw1HABwNExxBu+L4ODwUKeBji42II=;
        b=izWLluLWyan9/sbAQcS3A/SgQnDwvBZnNym/TTYFZVzmzT2aik9ZuBL0hdrXIVnJn/
         qD6KJIu8XTwUqztkrmKDYRlSGsy2fT4re+G3ZsT6/r9mVV6q8ZW+AJ6CqLkg4WhIcLrc
         w+KXi2UcTfAnY5Tv8dTSqjIBHKLtM38KzwL4D7AcRCJKEWRAXpoMmN2T8kpVeEiXZqjg
         PheigYG8H6A62iYkhnPp+18T+DNIRkSNrqw7ZYAbbVznrCzyr/ME/zsH0aJgYVkSQu+z
         QnSTkOqzkDjGYMuL6FGtZuA5oE8gOpB2EAW51D6uRvHnXX3ZtEH7acm2p+ZejVGAwzXz
         ri8w==
X-Forwarded-Encrypted: i=1; AJvYcCVEdyovg20/GxT7FL3tuGiH70rL6PhXsiokCSFAc5UxVGFa8RrBdzxlU0wKdhdw4iF6KMH8XMu3CyXhclo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU6JGSchHxa5FWkYCnaBxLW8vShXTlH6QeDXa3AkM6rcBAsYF7
	GFFxtRxGhHChZWIA2JCWa9d3laX6cZd3SaIWghXqCoS7CNJeywHfQtP6+WroR/JvzMu8Rt6lLDJ
	55ScUEuWTwzyLhH+vqs8Vcr83occ=
X-Google-Smtp-Source: AGHT+IFIw26pXtZcuM6AN/ZqMYbGVsCgRkzH5TP7hpaJgtgceL/sAoqy9JWxKl/WqX4itdzDFO11igw7MP0bP5zmrpA=
X-Received: by 2002:a17:90b:5306:b0:2e2:c15f:1ffe with SMTP id
 98e67ed59e1d1-2e94bdf49acmr1809259a91.0.1730408245293; Thu, 31 Oct 2024
 13:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020204156.113853-1-christian.gmeiner@gmail.com> <8f050428-53b0-401f-a60f-3d4732c0a75f@igalia.com>
In-Reply-To: <8f050428-53b0-401f-a60f-3d4732c0a75f@igalia.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Thu, 31 Oct 2024 21:57:13 +0100
Message-ID: <CAH9NwWd8iWALZbVkcPUsMGWNZSgh-8ARgyHSTULJpOqVj+88zw@mail.gmail.com>
Subject: Re: [PATCH] drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Melissa Wen <mwen@igalia.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel-dev@igalia.com, 
	Christian Gmeiner <cgmeiner@igalia.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ma=C3=ADra,

>
> I have one major issue with this approach: I don't think we should
> introduce a `global_perfmon` in `struct v3d_perfmon_info`. `struct
> v3d_perfmon_info` was created to store information about the counters,
> such as total number of perfcnts supported and the description of the
> counters.
>

Ah okay.. got the idea of global_perfmon.

>
> I believe you should use `active_perfmon` in your implementation and
> don't create `global_perfmon`. This is going to make the code less
> tricky to understand and it's going to make sure that the hardware inner
> working is transparent in software.
>
>
> Only one perfmon can be active in a given moment of time, therefore,
> let's use `active_perfmon` to represent it.
>

Relying solely on active_perfmon makes the code hard to follow. I need at
least a flag to indicate whether we are in global perfmon mode.

> I couple more things came to my attention. First, I don't think we need
> to limit the creation of other perfmons. We can create perfmons and
> don't use it for a while. We only need to make sure that the user can't
> attach perfmons to jobs, when the global perfmon is enabled.
>
> For sure, if we go through this strategy, there is no need to have a
> count of all the perfmons that V3D has.
>

That is a fantastic idea.

> I would prefer to treat the global perfmon as a state. Ideally, we would
> enable and disable this state through the IOCTL.
>
> One last thing is: don't forget to stop the perfmons when you don't use
> it anymore :)
>

I've sent v2 of this patch and hope I've addressed all your comments.

--=20
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

