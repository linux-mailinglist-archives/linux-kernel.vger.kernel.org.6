Return-Path: <linux-kernel+bounces-261293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A332693B54E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5B22813BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B922515EFA6;
	Wed, 24 Jul 2024 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krDg9jBP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4229CA;
	Wed, 24 Jul 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721839952; cv=none; b=WOCnvz3SPwK+MAoKXnxS4ElzTjaX9NuYhXvxhp3L/Ek6zjbbwyGkCciJS7eg1vMAbun2viUNl7uS8nMMH2v+ekIyCjd0UG6qv006moudfJPzce8VWiQT2iAdrWTuhYGQTNmQZXB1tWQsCRzsWNtbgnVzIC1r/eI39HclLXiARSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721839952; c=relaxed/simple;
	bh=MpyQsc0hU1GnVvadkjq2d6vR2ztC0Qrs/RgR86Rgtcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJJpqW/JieJ8gIYpkzp8wx1mw5T0Yp/oYrJHQe1AuRhsZuP/1c+OeeYu10YCEVjkOO4HLYvNnxR2WeF4ukuF9rUW97U72DAnXly0XO4OmZW9LRZuT7x8B8OzVulM7FjJM+MJmNqZX+EQLYiTVYLcz2qKu+kVk02omz/R9xMzMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krDg9jBP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d24d0a8d4so13104b3a.0;
        Wed, 24 Jul 2024 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721839950; x=1722444750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHOSXKCOPqcvZd3Rls/ZcliizqiZMqlPEJyXkYPHW+4=;
        b=krDg9jBPA0Vu9vfu+5qH54QxTsJ6ymDwoBQvOiaUcPLWlR9E2nNb4IpsmmsfCvA4da
         rIIAC/tQZBIm2icUN6G2ElUbF7/5jjC428vrsMT4g7SSO9MQsDGC1JV9xhRThn0RRh8f
         8Mk8Qna/7T99lN49fU7oroQTgsMr8xvnbUyJ+ZtZZAfnk9nq/EgwRcOO4qmqsOEr1Cto
         ZmpMJ5NJRiA/TMuhPXOPy9ebOHxKNf/onjNpFox8jHOvL6rAZcZEggkw/pG5qRczBbg7
         B2prorCaVUhEKP8iUHC/mcHq75yiJ94G7365CLesw1hyOksi2M7ySTviI70w3xLiymbt
         yg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721839950; x=1722444750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHOSXKCOPqcvZd3Rls/ZcliizqiZMqlPEJyXkYPHW+4=;
        b=uwr28nXK6J9QuZHlTeMfzsi813hGehxdqcfDB0WbQuaVFvYvm65kbmfemG57TKFJs8
         IV+tlCc56yn9FINnuNMJSZUh3XOBNiXOvWu81y2PkO3SgXG7om/su3axFOh4XwqgeaCl
         LeqPRs/cIu2i6HclC9yirEHOHp6tdcoj01Z2m7M82iMBFULzWvj55j5pqcl7hJrAycbP
         7vEm8SP/0I6vT2zGuApFaZJ4lBQjzSoNpJG28q4FsTtf5yOB06zYJxJeGBN/3KHN3vBl
         6isMnQ/JeKsLnnMIixJYywXBLD7qRkFIONcdYCMsh3YVFF2Mi61UFXrE7Av/v+pK8Nc5
         lZTw==
X-Forwarded-Encrypted: i=1; AJvYcCUZAPZ+PO5vojMuOHVuR1YswE0UI35Bfx7WdgzhvJ4v5rOWEW2ZuXolnIrbTI/6oRDV7n4Wu3iMNA5PvZrgdZSEfHjDEL0PV0wxtAKEKoqY5f3ClduaI4OO6gu2t/OUUp5+Jes2feOiJFGN1NwB
X-Gm-Message-State: AOJu0YwbzNQn6ga23qQa++JHdZqpvAJ6eHSIKZfD7DQ84IWrxyvFpr0m
	b/WiEuwmhu5B+AuPbfUl+nDGomLhIzyxkv+pOuuf+zxjaOMyXkcVSWYgdMfJ+Pl14viDyySCnlH
	yeUPpxJV0X9ElaV/QTpGOMH4jpKI=
X-Google-Smtp-Source: AGHT+IGVCG7JOT9xlzQlknfmeT16tN//PMYw1q63fUNnGbcSCCLdEteVrx6kyG3bL5BZWl10luLLhTaTz3653TByswQ=
X-Received: by 2002:a05:6a00:b51:b0:70e:8e3a:10ee with SMTP id
 d2e1a72fcca58-70eaa8f52camr96225b3a.21.1721839949856; Wed, 24 Jul 2024
 09:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724132428.2468883-1-colin.i.king@gmail.com>
In-Reply-To: <20240724132428.2468883-1-colin.i.king@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Jul 2024 12:52:18 -0400
Message-ID: <CADnq5_NHwwva2vN+MjnPohpjmzW0F5uLHN1bby1jUBiqetL6uA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix spelling mistake "tolarance"
 -> "tolerance"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Jul 24, 2024 at 9:50=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in a dml2_printf message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  .../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2=
_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_cor=
e/dml2_core_dcn4_calcs.c
> index 0b671c665373..5ba38d51382f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_d=
cn4_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_d=
cn4_calcs.c
> @@ -8267,7 +8267,7 @@ static bool dml_core_mode_support(struct dml2_core_=
calcs_mode_support_ex *in_out
>         dml2_printf("DML::%s: mode_lib->ms.DCFCLK =3D %f\n", __func__, mo=
de_lib->ms.DCFCLK);
>         dml2_printf("DML::%s: mode_lib->ms.FabricClock =3D %f\n", __func_=
_, mode_lib->ms.FabricClock);
>         dml2_printf("DML::%s: mode_lib->ms.uclk_freq_mhz =3D %f\n", __fun=
c__, mode_lib->ms.uclk_freq_mhz);
> -       dml2_printf("DML::%s: urgent latency tolarance =3D %f\n", __func_=
_, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kb=
ytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)=
));
> +       dml2_printf("DML::%s: urgent latency tolerance =3D %f\n", __func_=
_, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kb=
ytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)=
));
>  #endif
>
>         mode_lib->ms.support.OutstandingRequestsSupport =3D true;
> --
> 2.39.2
>

