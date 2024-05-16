Return-Path: <linux-kernel+bounces-181183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7228C789C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E085B1F2269F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C489014B965;
	Thu, 16 May 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAZ4TJsV"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35441DFEF
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715870906; cv=none; b=aB0AxvPqxiajEFcBc1UxJ5WMn7YskJTs4efY8VG0+2oc2eyT3SOapUEiKC8O9qwa7gZK63eBaxk8cgGCFj/ZcQvYzuBgbKv2Ji/cMJCr0jcW4jskV4yxOK8kqmEvJ661voq/9rtcoGhVIpPM2voALvcJ5aEe1+a4ExFJcM3hqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715870906; c=relaxed/simple;
	bh=eiaL+oXnOrB4tMJ+WYNolFSimcxONi0+GTVHmKvgDq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQWFFypMpcYU+HqHPbqHMI/AxHrX88s+KU9Kn768j2RY/iSlxES7c0Nu7C/F6eck2v8ZR7R+IFWLNBn14mxFXRlCpltqhrOe/w+BrpCtAiLVOaOsUAxNng7eFIzHCJ3XZqEVZEbpSVaqvJAluUbBTJN2lK3sDugdPg8kGxA+r9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAZ4TJsV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6570bd6c3d7so228017a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715870904; x=1716475704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhAIBDZu/rZJp0WFWbpKewussVqiv729DUhCPvOQ+Vg=;
        b=SAZ4TJsV+IpG6vXmdnvnkL7nhNdIRGygOuT4sZA7x8fur1kdUu+PcVnFYAdHPFuUoD
         Zm1DrOUVvawjaEukG2HNy2bt9pKoxsFC3EgoRWNlOhfYKPnvgYUeBWxPzm1YE97JT1tL
         2pnVVJQ9mp31kNrBICiw9sFNPBhCYtn1wK3rDX8XxQ4xc8WPn1DfgFE1PQ/hmMsfazW9
         c4+1gElsR09ObZaodfJQIKzTljR7JQv5lfvh4zC18XWneCxM2vnpgB0/JfyYXDyorf0O
         lYgyVzXbjNTXKU6l8g8f9+8QgYfOCe/pP5XeICpZ3jzPex67y/MQJZX5YHG0vGNFjdj8
         vQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715870904; x=1716475704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhAIBDZu/rZJp0WFWbpKewussVqiv729DUhCPvOQ+Vg=;
        b=HIU1bsuuNBOK2GveYDE+eTK5eiGh/DgW+FwIsmScSomXFiGNxVtdiVwgjC6ZK33hrG
         AADDDWl7Qot10REIryFT0376CeuE3J4Cj3sfVopXsJyK7BU0UBa2sY8RAKsD7V8eoR6O
         CbsWdAg7atGY+gwHiqaNVdowacGqtFIwvCrM+e0lpnFtPfTPfUvA35QOpyxChJT6Jgth
         Z+nYaJfSKSvpWU8638OtWvqhKadQuF2ZUS7XQ6NWsjB+/tNNPy+4O2w3RDRmhQReAJzl
         R2kAWJAvQ4KK4f/Ldoa2gkWfgMtbNiKUoCK0lTPomIXzQdO0kDymvnO4vnH6eSj2RtMy
         b0zg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+zpH0LDVUniomMak/DTgeIq/K+UnFtmUStD+sTn7QERLCwlO052JOlraMseYPRFGOgg+nIHel9/FmaRrTKsQ/Pj5BTKokDHw/tk7
X-Gm-Message-State: AOJu0Yys6UMsO8RUkXUTfGLo16MZo8boy2UrDDyt9rbExIvrNvcNOzs0
	bC/axEPCdKdKm2ii6hsAZqhj5U7py0hl36o0oMNAZxkjnC4ACVjfG0rmCSPUWKWwZipEFDhTsyI
	clQTKknlpFqT/bb9YBf7TUzLCQhU=
X-Google-Smtp-Source: AGHT+IGDyRGeEWktoobtx15T/9PFq7l6KEse0HiGU9t6T6oxLbrOTpurB+ANPxqsvO+n/pvuPTmwzkJBnFixqo9pvtk=
X-Received: by 2002:a17:90a:bc94:b0:2af:a2a:ad67 with SMTP id
 98e67ed59e1d1-2b6cc34298emr15612068a91.4.1715870904070; Thu, 16 May 2024
 07:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516082200.73480-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240516082200.73480-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 May 2024 10:48:11 -0400
Message-ID: <CADnq5_O7cyNxuGXy+nv_sq8_FM9tBE4_FKAYQ1fP6La_cRkeZw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove duplicate amdgpu_umsch_mm.h header
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Thu, May 16, 2024 at 4:47=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> ./drivers/gpu/drm/amd/amdgpu/amdgpu.h: amdgpu_umsch_mm.h is included more=
 than once.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9063
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 1a14e0101dac..bfae3c17e9bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -112,7 +112,6 @@
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_seq64.h"
>  #include "amdgpu_reg_state.h"
> -#include "amdgpu_umsch_mm.h"
>
>  #define MAX_GPU_INSTANCE               64
>
> --
> 2.20.1.7.g153144c
>

