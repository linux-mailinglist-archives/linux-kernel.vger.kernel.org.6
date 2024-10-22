Return-Path: <linux-kernel+bounces-376080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0C19A9FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26FB1C20EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8B3199E9F;
	Tue, 22 Oct 2024 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GlADng31"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6DF1547C4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592214; cv=none; b=RkLeIFTmPZZdVl3sjAwG5kyl4EP0tq+CF+8PsWv1qymSKGfFFdOUBNmXZZurcTDOAE1SevAFfdy1jjrYE0d+qrcFVLgwubcuItYIMoxFpPyHY5YeT8Osq/8AC0KFylhkDIj/bRLtTsQ9YH0e1KKY/sqdxf3+YRINaaUziS/zsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592214; c=relaxed/simple;
	bh=5+T9sKhiPC31wrXFvuAykfhWIuRofahIOMT1fX7Eql8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dcly+Yrl6WjvcOu2ZzU4XjcedhdTB5xe01YXJ4HcA//UFPY0/uy79EMgnUO1Ng8JtDf9hTGkAW8orKq8c+JdxwE+AqZla8sTSgvL8hmnngrM8VVuGgBHkdo+WHpunurW7NICT/nUj9VoSmXjbRaBoT/6JIN5BDQrsCrTed1yZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GlADng31; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea16c7759cso2897295a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729592211; x=1730197011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxbsV5OatFVKAj/cbzY/Z3z+++Rf+JtDnESZsiutVZI=;
        b=GlADng315+UQS62Cdexlx0qewwwi4VzoQbiCftuvr8JCe4VtkLt3GWxPW+C0xt8Pzk
         z75DVp5hPU8zhRvrx1tE1gkXPkMTJoSJPGJjP29FJHChF6EnXHkPqq0drMB4PnqRDnwu
         h27eQXUM/LqTCGPbdb/Jk4jKBIshRwEeKPaT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729592211; x=1730197011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxbsV5OatFVKAj/cbzY/Z3z+++Rf+JtDnESZsiutVZI=;
        b=uZ0GRlwif0qE/i/mTZxv2Lp+PxewQ9jxw2Jx9p4hBjhLywpCniwUL83MnmnsNN+/sf
         PTShPSQ0P+kWhOQJjgleNkBxkR/Tud3DWmm+7xwoIhoWRrBlEGQ5EsODimRcQUjqACJ1
         COqyQLjZiEZ6k7YJXe3a7gpHvxUL/pXd5/dMjEakf3FCI7s7y5b9RP6NtxdKEgZdR0H8
         xYgAO2/Bw6hHwblYW0QIQGl4G5xrFjqHxjRgpuf2umDzTUInz6Ze4Uv8OvawcfG9PAO+
         umyo9bSUK+3Dk8p03S5DscQnAnhfPLO5JnB/LbqdxL60kFKsi9u2dNWkQp91U9MWsP3E
         VpYg==
X-Forwarded-Encrypted: i=1; AJvYcCUg6eFGDtsWN7sJgrXvGUEgY5hHvQ7zXedXZJsCNLIdQRU6MLliztAlvqwI5x/WDTGgaRZRBeTooCAoIjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZf4Gk3bUNEojnSHxhmZs3fWLf8WfhDBxwI3pwErqPkLv4133l
	aZeo5Xoc4VlmVV6ieessdA4933fYH7ebf9SAfTpGPBBZcxkUxLuXR+zpL9JTWbU76GZlSR8goFs
	=
X-Google-Smtp-Source: AGHT+IEipmLL0qAuTdeI3AorHwhq/LCAgYjEGhfU0JoeLxPqz7RA5B5p4h5QnW6+rpYnUWPwhR8Mdg==
X-Received: by 2002:a05:6a21:1693:b0:1d9:183f:380c with SMTP id adf61e73a8af0-1d96debe75emr1956722637.20.1729592211476;
        Tue, 22 Oct 2024 03:16:51 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com. [209.85.214.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d74f3sm4397619b3a.130.2024.10.22.03.16.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 03:16:51 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c8ac50b79so169725ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:16:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2o1JIxNYPfn3sQdBzkpsiEUVgnUj7Yfmy8Lpz1gbJ/bjfY6NcR4vdxfifAkWl3GuynfRk+a2j36GVZkE=@vger.kernel.org
X-Received: by 2002:a17:902:db0b:b0:20c:a97d:cc83 with SMTP id
 d9443c01a7336-20e97fd5e19mr2449955ad.16.1729592209876; Tue, 22 Oct 2024
 03:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-vb2-comment-v1-1-8a755f3d98d3@chromium.org>
In-Reply-To: <20241022-vb2-comment-v1-1-8a755f3d98d3@chromium.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 22 Oct 2024 19:16:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Dkrr-U5jgZb5vN8zw0-2cYBV+y2podSQO5zuEq761CBw@mail.gmail.com>
Message-ID: <CAAFQd5Dkrr-U5jgZb5vN8zw0-2cYBV+y2podSQO5zuEq761CBw@mail.gmail.com>
Subject: Re: [PATCH] media: vb2: Fix comment
To: Ricardo Ribalda <ribalda@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Pawel Osciak <p.osciak@samsung.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 4:56=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> If V4L2_TYPE_IS_OUTPUT() the information has been initially provided by
> the user, not by the driver.
>
> Fixes: e23ccc0ad925 ("[media] v4l: add videobuf2 Video for Linux 2 driver=
 framework")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/common/videobuf2/videobuf2-v4l2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/me=
dia/common/videobuf2/videobuf2-v4l2.c
> index 293f3d5f1c4e..9201d854dbcc 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -231,7 +231,7 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer=
 *vb, struct v4l2_buffer *b
>                         break;
>                 }
>
> -               /* Fill in driver-provided information for OUTPUT types *=
/
> +               /* Fill in user-provided information for OUTPUT types */
>                 if (V4L2_TYPE_IS_OUTPUT(b->type)) {
>                         /*
>                          * Will have to go up to b->length when API start=
s
>
> ---
> base-commit: 698b6e3163bafd61e1b7d13572e2c42974ac85ec
> change-id: 20241022-vb2-comment-f5e93ca193d1
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
>

That's correct. It's not really a fix, but a clean-up, though, so the
Fixes: tag may be confusing. I'll leave it to Hans and Mauro, though.

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best,
Tomasz

