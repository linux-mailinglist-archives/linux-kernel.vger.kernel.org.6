Return-Path: <linux-kernel+bounces-542339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832D4A4C8C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73D63B7186
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E152459E4;
	Mon,  3 Mar 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J403ZQZG"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB8E21E0AC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020103; cv=none; b=b2E20R0GiT2kweB2mfCkG+Tc2wg1GLMUhDY4r9faXyDtOd2LTsjNJlqNW3RKKdtyqxxnA+vg6slGi2m1wuNOA2FZIurLCo+BpNG40/wU6tk5x8qxscE+Ynvf1ncsR/e0u725sWL8M1pADSydf/Vz4nl5hj4D/thM8xZq2nfvSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020103; c=relaxed/simple;
	bh=+AjtrQlz+KLrjwfA8G1AGGNPTniOV1aa8jhPXsw6fio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRP5DwSANdSyE5kNtRO1IS4mZtx8zxIY1Q6D4J0Qdj/tefIDbnED9kXtSz07LYJ8Y0IEy9hqefAYIQyNPMWEEa7TVs8/rQgCy56jyFrcnDwPyhrOln4F3CM+bmKERb/k8NPSy/OHWzWHe6WAvhIIbCoYu+0Rro+XwM5E9XotxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J403ZQZG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fea4cc08edso1077314a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020100; x=1741624900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47bsIKlcqHp5H3TD9jYyEu2X6naolmhs59XvhjHuXVI=;
        b=J403ZQZGw8sfGzrr+oJjVdP3VJFRyWajDchlu1D/gEMIgBAT+r8T3D0Md5vaq8z1zC
         AtcllhzWBJrhyavYpS35eo+4Jg4gjDvzCM9ybMvGRshrNIbQ6Du+TeW5KzW/fhe1U7m6
         HiWHm5gmkOEV1U8dD8F6u62P/o1DZ1bP5ldksbrQwfWcQkda+x0/r7N0r//AEwIUmEb/
         ZsshNIvFTW91ECf1gRIRG19NuWse/s3+k+dMmBbVWEHFDPjTEBkD9cdTCNXokyChvu4Y
         zJPnKkeqU+hFHtU7ohIvMNExd3X8f/6ZyRlkP0WBDq8ep2S10yj/DSJFG8zn3bY8HzC/
         61xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020100; x=1741624900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47bsIKlcqHp5H3TD9jYyEu2X6naolmhs59XvhjHuXVI=;
        b=wxAU16KErOs7X6PoFRhJcMuQDxdXOZzAvypz8+I1uWbOMTiQkTRfspiGhALa+f69Xg
         Ir+Vlcl5ECvrnhkX1n6h4H4C5ossqINjH/06ndQSaeJq56aqkvKxIq5yC1T9iJUKofdr
         td4LsogpP8PE6AmR1LMLOX8wa/RHHWDjceLtxxK3Wmn0yAFgAeJmp3mKGh89kQDXbB8R
         eDoBxlT0a0UsrCENFLkK3MJhB/za4b24n+3LZlRoHM6jdAb4F1jRtu1z3eigtigSOXbC
         N+jc9+blvKrF0lik3kLDHVSEK010OZh057PyZR/8uOV2glk5HA2xs/I1La/l+1QHMOSD
         B2Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXExZVP88/a1ILXIXYEYXYPhcd8iLTSJg18675ejPtLZ4R7iu4cVMpDW+cYSTMUraQmgODHn95M+cGwXko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsIB5yr7CNRFImWFb3k5q1r6T/w2V8Zeh2a+aVdgC/vdc08zmW
	C0wYfsI6RUw9xeDtFriuigbd6qHRvKoaThjJ4pupS066i7sVRALrFsPSMLWn9krRJFfB7+VD4Ww
	v8+ENTqqeqIjz+eVtttjUwkD5NYo=
X-Gm-Gg: ASbGncudzQXJwcNM+KbkT4Ic4znAjJD+vo/D15wl2ZNHhNTKwKM45WjqhTgPJi8Mn/g
	PVt5hsJHXp0V6BAHDpWQ16oMu/guJTsOW3zZS3zmg+YPrqUXhSxgjDlZMXsRS7YpsZqanKvN56r
	ttkPbH/78UfV2IIKB5auK7PhaeBQ==
X-Google-Smtp-Source: AGHT+IEAJzJpNaIfKrGq6gWR/l/GrV12fhRWU68m5gj94YkVE5KNJFVW5RIOxT9G5mqyQ2NgSg+1fySiP9uwEYuDi6s=
X-Received: by 2002:a17:90b:38c4:b0:2fe:8fa0:e7a1 with SMTP id
 98e67ed59e1d1-2febab2b8dcmr8430918a91.2.1741020100399; Mon, 03 Mar 2025
 08:41:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303143922.36342-1-linux@treblig.org> <20250303143922.36342-7-linux@treblig.org>
In-Reply-To: <20250303143922.36342-7-linux@treblig.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Mar 2025 11:41:28 -0500
X-Gm-Features: AQ5f1JqMkiUo-EtSFJEpEP0sLmjYwcpl5M0qfR0G_2Hgs53cXx-WZsW_hzhnm8o
Message-ID: <CADnq5_MmWqwgXQ5DVyp435ziPbpTE_EOhqgN6L4ZTWVXvVYtiQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: Remove unused pqm_get_kernel_queue
To: linux@treblig.org
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com, 
	christian.koenig@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com, 
	siqueira@igalia.com, austin.zheng@amd.com, jun.lei@amd.com, 
	kenneth.feng@amd.com, linux-kernel@vger.kernel.org, airlied@gmail.com, 
	simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied the series.  Thanks!

Alex

On Mon, Mar 3, 2025 at 9:49=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> pqm_get_kernel_queue() has been unused since 2022's
> commit 5bdd3eb25354 ("drm/amdkfd: Remove unused old debugger
> implementation")
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h               |  2 --
>  .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c  | 13 -------------
>  2 files changed, 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 2c22e335a02e..bc26a2609f64 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1363,8 +1363,6 @@ int pqm_update_mqd(struct process_queue_manager *pq=
m, unsigned int qid,
>                         struct mqd_update_info *minfo);
>  int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>                         void *gws);
> -struct kernel_queue *pqm_get_kernel_queue(struct process_queue_manager *=
pqm,
> -                                               unsigned int qid);
>  struct queue *pqm_get_user_queue(struct process_queue_manager *pqm,
>                                                 unsigned int qid);
>  int pqm_get_wave_state(struct process_queue_manager *pqm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index bd36a75309e1..2b30ed0cecb6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -652,19 +652,6 @@ int pqm_update_mqd(struct process_queue_manager *pqm=
,
>         return 0;
>  }
>
> -struct kernel_queue *pqm_get_kernel_queue(
> -                                       struct process_queue_manager *pqm=
,
> -                                       unsigned int qid)
> -{
> -       struct process_queue_node *pqn;
> -
> -       pqn =3D get_queue_by_qid(pqm, qid);
> -       if (pqn && pqn->kq)
> -               return pqn->kq;
> -
> -       return NULL;
> -}
> -
>  struct queue *pqm_get_user_queue(struct process_queue_manager *pqm,
>                                         unsigned int qid)
>  {
> --
> 2.48.1
>

