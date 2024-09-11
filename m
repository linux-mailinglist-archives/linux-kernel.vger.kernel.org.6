Return-Path: <linux-kernel+bounces-325416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B015975968
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60971F2898C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17A1B372E;
	Wed, 11 Sep 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT9udGRQ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E941A3047;
	Wed, 11 Sep 2024 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075733; cv=none; b=JoZpZUmoCt8T6H+L4fyTHW0JsaeyD7zslwr4C3w+y6y4cx6hDCrBWjHXm+f5FXsbPWBbignZA753XFMFaG0YHYERplpi/bZK5awkphzSVcCwstG6Z8FUjbCxUg3XOXqhIX61d3PpkF4XAXDwcb1r8O3CQLSrZo91/W7F3SxCMIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075733; c=relaxed/simple;
	bh=oBI3i+AsjI9YGogqDz3yl94Ia3i97pq+a23rUrbU1/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qo3r2UnbsupwxMEhcYUXmIVmC4VCkPQpazaHI5AXb4L5gB3oOmHxB8mpNKj2xSL+TLgV4Uy07FaNgWnf48VevjT4l3ghfHUO534Gwaxgyzo9mGQ8C3SZGu5OBEk5g2ATuUw3C580Qyl+hNlJauQ4GiVkDcgZ428nEO5EcxzGpc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT9udGRQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718ef6a26dbso3928b3a.1;
        Wed, 11 Sep 2024 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726075731; x=1726680531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5EzSlXh1lS0icq6diShUrZshLQf1oM6mIWH0eLac6w=;
        b=DT9udGRQDFofUZwpco9vvlrsjZaXaLGXby+QTKo6KQty1nXbmXb0HO+5cEkydbwX/O
         Xznmvh/5/kf9fbbMTmUppURTParR7Agiof6F+P991vTIlXjpCuXfeI/6plfVQoPF1HRs
         FzC3NySasw9Rw3YPkE+UMnvV03PD4r8h4bfrcA+knmM71vINGNf/myc9ZP9huXPq/jFP
         lLdHPt7uiz9PrEPXans5fdKcEWDDPsqUvsoSqjegIA78WSjCTjkMYYr1IjtN9VmzrZ2x
         ZIVBHHvI4Mh7V0TMgBaox0VFbH1kbwhXGp90sOQCOdD6mUVSBHFGJECHYHYVFF7jnEra
         i7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075731; x=1726680531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5EzSlXh1lS0icq6diShUrZshLQf1oM6mIWH0eLac6w=;
        b=erAGWhzgb06ef1ZzDaBTngf41W0KRIJICyilddl9zb/AgGh4nl5JlkgxCE+Cm6XDTr
         vRXKbAzug/jiQqiBaxdCoORMN+OqVhFozGvQpjQZX+sB0RnxKes/j+FTj06TqamlsCO9
         iURvSxcfixSy1DOai5MzEgHZxRiuYxbedl7LKkC/60t0SB2Ulur11yYphcCu3G/BEFXc
         j9fOrwCRQip4SsDsMO/cf4P9bl5s8DsSNN6Z5zp4BfKer9T8JJivxbahJTEsuz3y10NF
         X7ZUFgsmsNeQ8O58md1t0p9wkfdtvg6pDYxS169cCPNMgJ0ft1n2M1Q9HpRB+bvluHbc
         796g==
X-Forwarded-Encrypted: i=1; AJvYcCVJkgPnibKJbnT1ueAMpngmBHMHuK30rPpUKWvR3YFmV7V9nDgQ7FV7TIfwoUdomrZMhCufM67EC6APywzVa3U=@vger.kernel.org, AJvYcCWiVVwTFLRYQZ3wv4lu9/3lK6PO649qKDec/b651oJC4Q5a0fggm9MSCSsPr5lTh20AsuSlnaFcYgZAYNgY@vger.kernel.org
X-Gm-Message-State: AOJu0YyNvnEJiWDmaN/OdjGICYiGIVp/pBa9NixmQxR8bKz8ED6AIyJu
	Q8V4knMknwrv5GXZLH2X8efvyUJ039QszCGRRKH1pJnL3ZqJGzOzxG4HjHSMF3tNdSNN20tAi2J
	FrgFSPvX68WYzvwrSKR5m6djgpQ8=
X-Google-Smtp-Source: AGHT+IFA0G5uZOCBy5k8O0yLZZs1R0rN4uQsSJU63PRF6WnRL3LSE0hcu7DKXdFxbgJhEXyTWbnXeuxNrWxsXZem3jE=
X-Received: by 2002:a05:6a00:1790:b0:710:51e4:51f0 with SMTP id
 d2e1a72fcca58-719261e77c3mr77539b3a.4.1726075731083; Wed, 11 Sep 2024
 10:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909224122.14780-1-algonell@gmail.com>
In-Reply-To: <20240909224122.14780-1-algonell@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Sep 2024 13:28:38 -0400
Message-ID: <CADnq5_NMW5jkWqq_uGXgLLvZmUHbeLvJGhOhus27iar6Ry8pHw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a typo
To: Andrew Kreimer <algonell@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hawking Zhang <Hawking.Zhang@amd.com>, Candice Li <candice.li@amd.com>, Tao Zhou <tao.zhou1@amd.com>, 
	"Stanley . Yang" <Stanley.Yang@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
	Yang Wang <kevinyang.wang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Sep 9, 2024 at 6:53=E2=80=AFPM Andrew Kreimer <algonell@gmail.com> =
wrote:
>
> Fix a typo in comments.
>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index aab8077e5098..f28f6b4ba765 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -58,7 +58,7 @@
>  #define EEPROM_I2C_MADDR_4      0x40000
>
>  /*
> - * The 2 macros bellow represent the actual size in bytes that
> + * The 2 macros below represent the actual size in bytes that
>   * those entities occupy in the EEPROM memory.
>   * RAS_TABLE_RECORD_SIZE is different than sizeof(eeprom_table_record) w=
hich
>   * uses uint64 to store 6b fields such as retired_page.
> --
> 2.46.0
>

