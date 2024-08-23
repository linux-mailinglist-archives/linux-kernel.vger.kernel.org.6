Return-Path: <linux-kernel+bounces-298809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F9795CBBF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86CCB2299C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3EF187568;
	Fri, 23 Aug 2024 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRLOsPoW"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6C185B4A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414045; cv=none; b=t/yQyM2nOD5PQVjONvTC+XGDjRn+Jt80tQRzxNSQh/79YPRQgXv8ZNILAAgx4s1reKLpPjagwnWqP5LW1ptfjltqGBrpAPjGihlWUDFh6SfCfCIepIZIK5uaq0W8n5c0Uvs+Man8qdUwoa4FQMgENekga5+N46iUnkToWC6YLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414045; c=relaxed/simple;
	bh=gKw3mfDoieUEYpqRJTguyzP/vFWISN6ZSkSYTFfhwkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFBZHU/NreXn+eQWhRhxn8+Q9yfPQdmMSjO8suQ1AHj6uR8nzCVE9iWcEFi19eRMkA1ENunV+zINqBJKLNSOzl6mGVQuolgPzkh5K3Zbi6h8EykGgx0RbX5z3kIWJJURhSJbhMmnIVdbirnTmfpC/owlBc6xordtLJYzUhh1Zwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRLOsPoW; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70949118d26so1668026a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 04:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724414042; x=1725018842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qn6mU1Z7uEyGrrtLdzWFgv92xoJ3V8ymO1UfoJbvTv0=;
        b=rRLOsPoW9Wx55u7YdlmLr0weZJe2hQEJcUCTahWi20EUhecaSpuGhF1cuZWKZmpuo6
         qWFJjDWUx3ydj5MpI2YBAFd8/L9ynWaMpfgUH3fkvNYJWNXh757wOBjKORQnvnmiz5P+
         L7Ga0ViE8WYWjTceifBweUeMIALt8Y54r2/YDxKeIbPydSaOmHT6RNlhpl1G5xjq/yQM
         syk3nFXLcOAk+CRLi9Gyc803Y3DkgGYAveoufq3+ON53Es86QB6dBdLJIfTZqaMWI1wG
         ZGsi7WoKb75PRA5bGLB+E+8djPdi9VSurIT7FJfiPttHLmXhEjACTl6llV/iHz3fJRvQ
         87cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414042; x=1725018842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qn6mU1Z7uEyGrrtLdzWFgv92xoJ3V8ymO1UfoJbvTv0=;
        b=Ko4OHOhAdeJhCA5WmgdxR0oSqMpMRoyinL0UlRmJkqyE0a7Il26tds3umGrSBf0/15
         siMbrekiqMRv4G7aKbdwhPY1GSTgqLlpbPMg5oHl826vwNWvu9dq14ZaIYj/LCgdP6oh
         TDTQhBXhLr9YVYxG/CChmz/t0bd2ivXYV4TbgJG6CKOavhlxsjBJlTGCf+BA9Ok6+W8f
         SW70C1W8irJGskOJGMVZXnAaJ+88wX48ZybpTwhRaeqnvImbBXONX09ysupaaOZWSOKe
         ZZnM9az7l+EF2XA7qi3xBDjfxQeNvCL8RlwhdxfyHQ3ICtFF7YS7v8n1s7Co4d08GvmO
         Ptyg==
X-Forwarded-Encrypted: i=1; AJvYcCWje2UzMNaqfrTFJJqP/t1XcrZzcKgzT7HrYXUSGDp7/IeLC3So3NLE72VKy08qUqPcutwznQmmXnbqYIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnNob4UDnDPdefJyFjOwQvWB2NN77bftnIiHNDi2HGXYfqTIM
	aXwnSx6YgoTR/6sQ0C8+rPvvBq8DzwBbORh5RYc922CabIw68WIc7yV1Yi+dczRuTCfiYczw5i3
	S8Qx/gUsefzgOi+oMjA/cwPIeD/4tJvq1ctnDUh7SsxBlQ0+q
X-Google-Smtp-Source: AGHT+IGTtVIAQIlxuwXUOrvMubq/AS7vZkR3Y4FPpwazrWTnw/W47IWkEwa2I9+QW8yQ2Ag91mmC06S30C9mmpPw+zA=
X-Received: by 2002:a05:6830:6384:b0:709:3792:5e0a with SMTP id
 46e09a7af769-70e0eb6cb5fmr2088812a34.17.1724414042288; Fri, 23 Aug 2024
 04:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823083657.7100-1-hanchunchao@inspur.com>
In-Reply-To: <20240823083657.7100-1-hanchunchao@inspur.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Fri, 23 Aug 2024 19:53:50 +0800
Message-ID: <CAHwB_NK3Jg=7VC6dMgB3LuVCu2ZxWu_MO8PGWcoXpG=JnqzORg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm/panel: fix null pointer dereference in hx83102_get_modes
To: Charles Han <hanchunchao@inspur.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	liuyanming@ieisystem.com, Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Charles Han <hanchunchao@inspur.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=94 16:37=E5=86=99=E9=81=93=EF=BC=9A
>
> In hx83102_get_modes(), the return value of drm_mode_duplicate() is
> assigned to mode, which will lead to a possible NULL pointer
> dereference on failure of drm_mode_duplicate(). Add a check to avoid
> npd.
>
> Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as  separate dr=
iver")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/gpu/drm/panel/panel-himax-hx83102.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/dr=
m/panel/panel-himax-hx83102.c
> index 7c2a5e9b7fb3..e61ed7d02729 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> @@ -566,7 +566,6 @@ static int hx83102_get_modes(struct drm_panel *panel,
>
>         mode =3D drm_mode_duplicate(connector->dev, m);
>         if (!mode) {
> -               dev_err(&ctx->dsi->dev, "bad mode or failed to add mode\n=
");

Your V2 patch should not depend V1, should make patches on the base code.
And when you send the next release, explain the differences from the previo=
us
submission in a cover letter or a single patch.
see https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
respond-to-review-comments

In addition, Doug made some comments in V1, you should CC him when
sending patches.

>                 return -EINVAL;
>         }

nit: remove brackets


>
> --
> 2.31.1
>

