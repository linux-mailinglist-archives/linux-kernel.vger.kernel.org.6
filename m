Return-Path: <linux-kernel+bounces-331057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCCA97A7D3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528321C2298B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D80C15CD6E;
	Mon, 16 Sep 2024 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krbGFCPR"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F315B14F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726515214; cv=none; b=gGMX5C/0pSuYoK+cCRmNTj2HPplXMq4tEr8qNg0VkDsHgrwh1zHeM0uHrYwIPYJGAgIr6J2sWF4U0PXoEkjz+q/seTKCNzI+3H0uW+L88zeYFdR/G0LQho5YRuZVoy1HCN2oMGtwW2qz1ZccD4oHHSs+N2rK0+IULfWDkfFU5AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726515214; c=relaxed/simple;
	bh=lv075SZ/Xm4yCKbqpGNTKOnhifOuo/kr0g+RigSZvu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/fdmjqPh6y2JAvj6nXYDmWa/aypOYY53t2YIx9qZoOtbVB687X3OBo5OKECxAf2y6yx4XWnwmh2XxOpRBYhNSwE3VvUpJKAtAxPe12WS24K2pRG8iViR47mzsUxLmEUF9KL+GYG9MtSxCCMm8CqKdZQ61+5/3Yvwye9FqntlwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krbGFCPR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2db6b13c6a0so742840a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726515210; x=1727120010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdVG9kJTSsyd1MnLtlWcHTYmc5/C16VpC2Az70/1ZD8=;
        b=krbGFCPR4Hufg24/fkyRlNBWBzXAYzvhe6yrnp4y1B4REmkbKeVLeR2Cmi7tMEXh0C
         gZN+xVVQAAfy9NE08KWdnlbUq+XLVxC1+imcGnMwlKpC/lPH7IInVVFwiqbYlKylNAwf
         AZO+AyMbkFn35wryzsBxA12WRTOsf8oN27mni4FDjqAwa2vcWYXQlpx3BJjGVo3eb9vL
         +sPJppmXHJjoIv26rZhuLIqAWXEQsu7gkA/0wGLzJT1wH0AenIvKoJi92DveZoPcaKcJ
         Ozgs1EwBJxbZEr5fC4Q21q7YORZVxZW6eIevjWlHK3BWNvwLYGzamzdJxq3jG4+yZb9f
         2dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726515210; x=1727120010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdVG9kJTSsyd1MnLtlWcHTYmc5/C16VpC2Az70/1ZD8=;
        b=jx756Q/M+2lKDGXWWK7XSK1b7g1d2J1m+6E3EkxDYJPLuOtWhEDiPnqTzTF+hzTWlT
         2CMGJoXDkStmcdhqV2JPRROEzpb83alEFHb/YW3boquPG6DDpUsamyDIYOY1XRw9Y6OX
         Go1lz9zGbkqTKFsn0COg0JoeHgDIfBurV+LKNaFBTXNbnykf2DJ6GoKFsKL4c7XCAAb3
         CyxE3DBUAnx8p3hT+YT3sDyB/9in430Yxs5xAbhol1SvE2yvRaJBw7x3UUnhgEHmepY7
         p8PGIe8jFOHyjPaD3hRYLp8YnJ+ZfDq1Iz7fowyE0/Ns6j0kM+y02kOoCEljSq467nBe
         5g9A==
X-Gm-Message-State: AOJu0YzbQqbL7OBucHNNfWAanG5dx11jDgCOkuTd5ks6SFdO+wyeVqHP
	CIq7aNl5FghAnBZFDAw0CXDwfaBK1spcg8uSq3vyPHvzZ+DhdvrRgnfUfhAKvS/hKm1c9yaeCFF
	zgCrDnajFUlp4FYoSxXGKwgC5geg=
X-Google-Smtp-Source: AGHT+IFzWHeK/CLww1PcQw75RJhh602iYNqoaAB2CiAxnBOicoHCFayY9htxMAkWxH1CAEhSBqhWoWtWto6/rDgJ5tg=
X-Received: by 2002:a17:90a:d806:b0:2d8:8254:b913 with SMTP id
 98e67ed59e1d1-2dba0014995mr8218624a91.4.1726515209726; Mon, 16 Sep 2024
 12:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916185159.35727-3-pstanner@redhat.com>
In-Reply-To: <20240916185159.35727-3-pstanner@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Sep 2024 15:33:17 -0400
Message-ID: <CADnq5_N6dMAm0525Hqpq+yKFDRLfky0Ybu_78DZgYHYvjQu_Gw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: drm/sched: Add new maintainers
To: Philipp Stanner <pstanner@redhat.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>, 
	Danilo Krummrich <dakr@kernel.org>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 3:03=E2=80=AFPM Philipp Stanner <pstanner@redhat.co=
m> wrote:
>
> DRM's GPU scheduler is arguably in need of more intensive maintenance.
> Danilo and Philipp volunteer to help with the maintainership.
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10430778c998..fc2d8bf3ee74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7710,6 +7710,8 @@ F:        drivers/gpu/drm/xlnx/
>  DRM GPU SCHEDULER
>  M:     Luben Tuikov <ltuikov89@gmail.com>
>  M:     Matthew Brost <matthew.brost@intel.com>
> +M:     Danilo Krummrich <dakr@kernel.org>
> +M:     Philipp Stanner <pstanner@redhat.com>
>  L:     dri-devel@lists.freedesktop.org
>  S:     Maintained
>  T:     git https://gitlab.freedesktop.org/drm/misc/kernel.git
> --
> 2.46.0
>

