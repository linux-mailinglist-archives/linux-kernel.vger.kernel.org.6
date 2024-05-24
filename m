Return-Path: <linux-kernel+bounces-188746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCDE8CE64B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C96C1F22514
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC3D12BF34;
	Fri, 24 May 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNLBX/U6"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262FF48CCC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558295; cv=none; b=YN6cqX88BWmiCSZoPPwYZ6TcAd6uX/7sJpFxyLyz1+owhsj6VrAsm26Dl3wQjqnVqXUG4O+AjHFyOxkKiKuap2QCC7lIk6GBvhbbcqxC1E9bxJc7Ad/OVfDQ0WuHncNzwGfw4Cnk7VzXguXhSw4H6BezMrqahkgZ7iYXHf2KWtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558295; c=relaxed/simple;
	bh=Z1qJKbTXnCRCHyLHJMDq/SAZE02TCK2iE0pzpTFuZ8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEGEDl2hDg/5DILeAlMN1oO1eDRmlYpRcpFos8nztiYURGLkI1OubMM0hTEm2FIqCSq0mGGWJtrnToMbA+ym4aRAQkIuM3wDNnQn29lqQC/v1365NdcC0+9O3IZpKnFzqLPdGNcI08hglNGszAgerLOVkkkPY3yelGCMYP8IIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNLBX/U6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-68185f92bfdso604883a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716558293; x=1717163093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/zRPEK4vrpDADuLrDbT9ldxIUl5LtaBJ9hW8O0AF8E=;
        b=TNLBX/U6F2OtHMJfF8md9w73eLCXwjVdpl0wiN0WyX/Q1szx3TWA0sxSY5WoO9zqZ9
         KHBHnmog/JBKtzj+p96gQ0s8drflwpWQC/SK87FMXqLLk/lDZgWZhdNvmNPT8wLJSooW
         bAk7RT5t7KzMD26tDvJagDmGIMQyQXuIZEWlC9K5g1SmQVNT4582YcF/LwWdIsML1lI+
         4OPJo45DhtJOtguJzLgVoqxzfQ44bNvCjjodaWgG5qLfS2TqEoGo+FvIudvN7NhTiN2G
         TZLmU70RtUetrjOKaR0eS4DK1SV6yFeL2CFUUchJmhOqV6yUtX/C2mmf160eTYu4R+VE
         SyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716558293; x=1717163093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/zRPEK4vrpDADuLrDbT9ldxIUl5LtaBJ9hW8O0AF8E=;
        b=X2X9mzqUQeHKUAOrSfLQ5STzYDapgtRUKY/EXRF4EV6gyjg3tC3Lk2ui6UujWlVYRk
         IFjbEd2A+b/PoCjfk4AnA+9Sc49rHa7MCJwrpTnztLibgxT5kfVUrhs8dQEpfCElEJIa
         STo3+g4R79Pg9dU8Fnf/0Kd9sw8uN+uSHj2PjrbW10/CwoXnZ6BSRSPDMOr4BPCxlBKb
         yfyUWR1sTsGLGcbI6K3hK1G8w1JZok6oFtEGmidTka8u0BweZpii2JgQRkA1qJ3kOcsF
         9SBS/7morXpUFW22ob/vuUBZrkiXUjmfwDCObwOONNwB2eZn+aDzBiJ9XeZ2qwnkAtfa
         wb/A==
X-Forwarded-Encrypted: i=1; AJvYcCW2YG4dRx+QdMLrDuoaWJ1pDSm4FIs76LUMypsfXy71UyWzImlItSeWxvqU9xDEO5wAqxpq1jewG7htOd+NWqSerJ+35KcR6kzal+tb
X-Gm-Message-State: AOJu0YzKOurYuk1rD4ev0f5oQFiuPy7t5M1gb1hLs7Po3bJVJKDF59GZ
	+ICsWwjaaHGgVbeLRBqkWTORooNuZUP7nxhzt+I25dmmec5hBp1CR5y5W/oh1rRGK+IONUKJrHj
	eJw8DzQdrHNTzmAE7/Hk5ek/39m8/0Q==
X-Google-Smtp-Source: AGHT+IH4zyIH6ONvvDrxtjrqQxGvSq6pvYG67jVQYsK3CkygUktTLOWiWqxCX0URSxq0sqp/vrHGUwVVh9lyOWZ7KEQ=
X-Received: by 2002:a17:90b:310f:b0:2b2:9a77:3371 with SMTP id
 98e67ed59e1d1-2bf5ee145a3mr2085056a91.12.1716558293449; Fri, 24 May 2024
 06:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524021920.95328-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240524021920.95328-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 May 2024 09:44:41 -0400
Message-ID: <CADnq5_NaTbS-3tJGUg1Tr5-uEmeRg5cqvyYGezqPLcbxmmCy-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: clean up some inconsistent indenting
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Thu, May 23, 2024 at 10:37=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:5200 dc_power_down_on_=
boot() warn: inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9166
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 3a2101b052ea..4612c60edebd 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -5194,9 +5194,7 @@ void dc_power_down_on_boot(struct dc *dc)
>         }
>  }
>
> -void dc_set_power_state(
> -       struct dc *dc,
> -       enum dc_acpi_cm_power_state power_state)
> +void dc_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state power=
_state)
>  {
>         if (!dc->current_state)
>                 return;
> --
> 2.20.1.7.g153144c
>

