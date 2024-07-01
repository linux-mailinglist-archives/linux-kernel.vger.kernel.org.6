Return-Path: <linux-kernel+bounces-236909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B8C91E882
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388F11F25F9D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BAE16F82F;
	Mon,  1 Jul 2024 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYx3pWf3"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8FC15F3E0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861740; cv=none; b=jVUFiV3nBLOeNAJNj6poLs3Yg806Ls7QDEW5L9cyKCP1WT5g6vDVixu3iUa1sEQKpYqPls+IRoXTjsyawJftSoTD8LuSIQaKNYw8ZDnUdUHtQ5lEXcui6ben+P8R7T+rzq56ml2hjuSChiYhmnh6aiie4rpoBFVXeXN+7GdCm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861740; c=relaxed/simple;
	bh=jhRT1K6xV21Os/urlXYX84zmxP8MArFSxr/p511FRSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yj/948OK+9tS4mAFYnF9Dyu/aQmCXn6tc+OP43kpc9ZiazKBW8qrhrb3Dvq1nO8k/Xz2iUUJGrhaFNA2wN54GO/11jK3vHFnKdmSYmlJSARIMgq7dXZzB3ut3ZIx6puoOmaWufPS8J2Gs0DtjORpc/pZ9OzA+91ZNQQ4iUSyOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYx3pWf3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9cfso2024104a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719861738; x=1720466538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aymU97a1sGvobGJ+atGeteP+/v1F5zejZr+FSZsxR0=;
        b=kYx3pWf34TtSJmhV9AOJYgQKLXx+QSCqFrfE/vwbqmP3JCHadzEOGWV3s0xfxGd8EY
         tkF1HEyBzUaG8tefRfGWRW3FBlkhdBdYNUz7okttbjM1etwI4fYB5N/WdrMMTVhckytZ
         XCbHc4XWEfBYdeY59skXITUqI+fkNK1yqe1Bhs+xaqfP1sO/LzmyFx5V2xAy7RbOtHff
         iqeThIBnYOzMcCgMatjobpCwHpxIOw8bZs6x3ny3JiG17i2jrk2kt8Yto+UO7TufByTl
         DQlgHkmy7gRBD7VXRaOW6qmWSvk/h8tJZ2vqXID6P01wBqd9iwUL0EMPsFfOq6hbF6ax
         76yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719861738; x=1720466538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aymU97a1sGvobGJ+atGeteP+/v1F5zejZr+FSZsxR0=;
        b=CvozJTWqcasc2/jNEm3hKvb9gHBPmQ2GBhrCbI1NuQqRK6XXuP0rhDmoO1TZRmORZe
         1eNsLbAS958Q798LlSAzFxq4JjChuTU/DVfu+Cf/Iyddh1lAYoC1dmORJz8xhzXKNIIO
         CrjqM1TErbVDT8RQMgCiPJ+6I3tjo7rXUtvu9bhivTjRk2IDDGZHIB0ocShS66GhCbCI
         +EUXly3y+/M83fdETHKGZ3gXTsv44UunB4Tu6awU4ZYmwDrU1v9M9iiWzafll0vGqiUG
         bzReBE7GPEJlVI4Kw41ARASVXwIml/D8PSXk9IQufo62NsrXHttls4sxF500ow+rAx4y
         UMRA==
X-Forwarded-Encrypted: i=1; AJvYcCVOL7xLxHnyb4h8uFcV9kroOUZ2uD4bzZ1rjIFGUrB1XMxjH3ZNaVZIKh6ow8teaPEzTyavlZm924YZEwkVmyCZfmuT/9/z2sjdbxfW
X-Gm-Message-State: AOJu0Ywy/kA5MROr6pHwzOwMxd5yEVMWDEPXsvxXa9CrkNAPOj30PfFP
	kwwRx3qcu8EghRqvKFsdyE1uyb8r3cP8ncDcfznXQzp4OO11j8cLPniA/8Pxa1S3fy/JvaM3Iv3
	5JFx1DWkur41DktXgZcGdOtOYVMY=
X-Google-Smtp-Source: AGHT+IGWf9gM/yO+PqY/uzKDCywdTX9GVdifnKlIyO8850AhUVnit1KRSinpn8GzTYvf4biNxr3CAvdFFOwlgJrft6E=
X-Received: by 2002:a17:90a:e617:b0:2c7:5622:bf40 with SMTP id
 98e67ed59e1d1-2c93d6d4a69mr3298695a91.4.1719861738375; Mon, 01 Jul 2024
 12:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701070454.106083-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240701070454.106083-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Jul 2024 15:22:06 -0400
Message-ID: <CADnq5_P2KH0FioN-uQ0604mbbrprOs2TmgzuGX4S=J-goYTf3Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amd/display: Fix warning comparing pointer to 0
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied the series.  Thanks!

Alex

On Mon, Jul 1, 2024 at 3:15=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Avoid pointer type value compared with 0 to make code clear.
>
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_facto=
ry.c:14:12-13: WARNING comparing pointer to 0.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9458
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_factory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2=
_core_factory.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/d=
ml2_core_factory.c
> index 1a0da8c6df5a..f56abe9ab919 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_f=
actory.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_f=
actory.c
> @@ -11,7 +11,7 @@ bool dml2_core_create(enum dml2_project_id project_id, =
struct dml2_core_instance
>  {
>         bool result =3D false;
>
> -       if (out =3D=3D 0)
> +       if (!out)
>                 return false;
>
>         memset(out, 0, sizeof(struct dml2_core_instance));
> --
> 2.20.1.7.g153144c
>

