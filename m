Return-Path: <linux-kernel+bounces-554509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C7A598F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D81A3A4583
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E325D22DFAE;
	Mon, 10 Mar 2025 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX2SR+SE"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0B2AE66;
	Mon, 10 Mar 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618856; cv=none; b=gC2+QG6RZ7NgOE1AqjM12JRClHgMBbABbtA/93Y6BufqAnDDIwPKMhRMypzZquZuBYvYXAFW5QgcDfQuz8x/6iTV7WUSOJi47GYTFLtdhAkzlqpYj57trha0qm1JD1cezaS4jiloSg7lglk4H+wHP9ueh96dVT+hXnAFlRXLios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618856; c=relaxed/simple;
	bh=fD2jJrazp7IqrQabozk1F5EdljhfR7/yUpDUfEvu004=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fH/dFSe7mX5vKS22uugpf55wCg3D6w0G/e2Nzul7Tp5zYAS+5Tcl2lG4UEDR0HNO5FmfG3lLFZDtwPElM4no4Z15xsjyahK/B7u9jRXwz2oVI8LHewHzPdyBamN4TOplqoQBKW2vXx3BSSriwJ25upsOCz+jRxAlyeAm9+kHUzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX2SR+SE; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fd02536660so1204060a91.2;
        Mon, 10 Mar 2025 08:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741618854; x=1742223654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pik+SJ6TeRT73WeaopsJrOapXLaVVKqUv0DnQJUUmIc=;
        b=AX2SR+SEP0d5p1erwV3gXruAF7EB0kGdFn4u6wRj15L2zOGbhR+l1ozwMubbaDa+c/
         yIe2ChX5m6+OIfU/zw2JDUrVH0tbxNy7Vop0xkJRDZGIYvA4ZyzH+IwZM4AGCtEBUkMF
         uHjX7XSLYgBnhyWH84AgE/gho8uox6Tv5B1TMK/49IRuiNEy1Ajfe/4uQJNljkX0w28H
         yesgfhmxNIJ0RpsBrufOJSkcqtHIBwiK4HjZtzz5ArNPRiN0mRXwgH2CZV8TCctuFuJX
         CQcFn6b2yjaBurpYDDG7rfuPs+alyqrSgD3nP6ZSGmN51UOxJDuNDP+GAl/RBlbMmLio
         Vtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618854; x=1742223654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pik+SJ6TeRT73WeaopsJrOapXLaVVKqUv0DnQJUUmIc=;
        b=b2zVppaR700Q4b6srwyuVC/AmqeoDHQ75Z7qUNyvvrsPSr4xrYWm7JXysVcU0LpxPI
         fxEOXkbHCqyvOJHJcaFj16PnsCiC1Tx6VfRk5nsa3UOF/pPq8QwbiYgmVXGSX7IvNNPT
         KNgtCqtiMqcE9nn4sfPxWuuRJAPf3chldxejqL68ouwvAlJXd6zTa1YbhvBMO3Ot1Fz6
         9kwgC4wZ3mr8g3AuMMXnh6dnNKP2D/AH5dB+kPoBkoJq+kuj0gJZxDJ+0lds5CzwRTLe
         7b40enzgHw6vmWV9XqthG+Ri95ngYCQUgivXn01T6eoYng3g6im0gycOjjDP0B20ftlk
         5fLw==
X-Forwarded-Encrypted: i=1; AJvYcCUOvYI9I6txN1q10Li7WmDm70Ql1+1wU3wusIZ5n9kz/heZoQAk9mLCs2nwSWpWr/0b2Hz8RE3eaMQ5iXqe@vger.kernel.org, AJvYcCV+srWDXrU3Y5DgdNnc0/bn92tgM5gv1MVmjhC5NLCmDj8ICKqqJMnTlbtsO9wHquWfAKKA0NJdkWTG64cieYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0sfV0DmQqlVWBdkjwds9vpnRePbi5uzc9+ZswldptWmjn6pl
	WrXWUdAuthPFK9eixBG5D3vdce4R51d+mbi1Zua7Dd+fs1qb0Jqz2J9czFcPBBszyscGbSpeakf
	hkK28YWLcGWDNcTxLLX8NfPTxK0E=
X-Gm-Gg: ASbGnct7XiNIIHuxBnrwqq4ByCDDCA0YSF7yNRdNzRN1bclLqPxbX8diTIaWWPnRGet
	PPrm+de8wykgd/UfOtcRXlT7hx5lxMa+pzGfDJ0u+38da4AsswiL/OuTF42JRssfH1DBU4YKHvZ
	urT9KnRcbkaiTsm4PtoK2WiotqTA==
X-Google-Smtp-Source: AGHT+IHuWmERPlE+4ZNLC90fXXCO1PHzcp3LKpUguGUQ5r6EGa2DRmmvlJlS8B4Wb3tJXau9KQwIQ9GO609WUZ393FY=
X-Received: by 2002:a17:90b:3b4c:b0:2ff:6ac2:c5ae with SMTP id
 98e67ed59e1d1-300ff724725mr68013a91.1.1741618854030; Mon, 10 Mar 2025
 08:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <92b9d527-fa20-4e4d-a4ce-7c442df9df0e@stanley.mountain> <47a52abb-61ae-467c-9cf2-27427a5057ac@amd.com>
In-Reply-To: <47a52abb-61ae-467c-9cf2-27427a5057ac@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Mar 2025 11:00:42 -0400
X-Gm-Features: AQ5f1Jqm9WMU4lBdVptaUYa6Os9jtW4_wZaL5H0Ev3cSsBOqS0XIQez62ZUgzTc
Message-ID: <CADnq5_O=aawGH773SZ2KVwvOTRz0CsnoAuGPZTsAR=Fcqy3udA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx: delete stray tabs
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hawking Zhang <Hawking.Zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
	Jack Xiao <Jack.Xiao@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Mar 10, 2025 at 8:18=E2=80=AFAM SRINIVASAN SHANMUGAM
<srinivasan.shanmugam@amd.com> wrote:
>
>
> On 3/10/2025 4:17 PM, Dan Carpenter wrote:
>
> These lines are indented one tab too far.  Delete the extra tabs.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index a194bf3347cb..984e6ff6e463 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2002,8 +2002,8 @@ void amdgpu_gfx_enforce_isolation_handler(struct wo=
rk_struct *work)
>   if (adev->kfd.init_complete) {
>   WARN_ON_ONCE(!adev->gfx.kfd_sch_inactive[idx]);
>   WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx]);
> - amdgpu_amdkfd_start_sched(adev, idx);
> - adev->gfx.kfd_sch_inactive[idx] =3D false;
> + amdgpu_amdkfd_start_sched(adev, idx);
> + adev->gfx.kfd_sch_inactive[idx] =3D false;
>   }
>   }
>   mutex_unlock(&adev->enforce_isolation_mutex);
>
> Thanks!
>
> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

