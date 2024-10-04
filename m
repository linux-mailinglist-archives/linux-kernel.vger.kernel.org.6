Return-Path: <linux-kernel+bounces-350855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A55990A8A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2355B2206D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20832E83F;
	Fri,  4 Oct 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGN5S/Ri"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5B1DAC8D
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064828; cv=none; b=aEZ/MBEIpfky7PmIC9T2sKVcqsASczVVf7XSx0DO0IFSHUn4DBEuqRLlmOR23RfPhuKGy42fDp+9vCHx8ms8sIYCrRLqP7EX04O5C8nkm7YofnQTUuJcjWWdYUZU/NCdOTViABQilRt/F42h3wgo/sEiMTuyhGpIn0/HFFV/ZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064828; c=relaxed/simple;
	bh=24SrSZcE9gFtxi3ujAeUld17DOZqCc/Q9kJuwTv4xgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCrZ2JatPj9INM6jOZ8hrmF1byvmFSBu2FQGAjFSqleuE6gRY1yd12xjU9kZV0wXink6u0C/6+6ZbD+DzVlC4nU+nHLE4C1aB0f2ZZ2vjtB+kMPopqb+hbkCmEDCnoKo5m31niZ3HNmzhHzhIvmNyBXPp8u40+xy47Na3WYc6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGN5S/Ri; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e084dc44bcso234657a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 11:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728064826; x=1728669626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKWT3sDU4NtrrluAI0QmU3x+uhGBRrICw49xVu95Gg0=;
        b=JGN5S/RiJ78vrcbG/+Tr6HssVUclWEKh7ldJnx9a9lq8jrhoDYjbwkv4z19km4qFzq
         uu6wjpyQfuu54iU2OZcm2L+7orRrKqifo5JEtzdK5HcU9M0dLw5wd/ZA7+wCv054gTf8
         tL9lBunfgj8u9VeiFKCNAUiDuifcgqZVouJYq3oJBa/4AD0DGnq0RntF20ydZyuXZJx6
         linPBa/7y7f9fCJHsP+XWXJZjxJnJwKEYBAWxkNYgVUUvn/sEGR50GiqO14HNUxAKuNN
         PwiOfR4gZBuMI1jRgzm9hDI7tm/8MLv2d8IXayOI16aGWOs1pfFUfqcl8IRVGXECjV1N
         8aXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728064826; x=1728669626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKWT3sDU4NtrrluAI0QmU3x+uhGBRrICw49xVu95Gg0=;
        b=H1wIqSVX54XFZqncPH1M3lwLXzHFi7RGp+utBEhO4qF0WdMPxNa4t5wkYIfrATuARP
         qwfExfRvBVATS5gDMLVhVPdxaEEEFGGrpzm8QzZCeGUdQKHdOoBIIm4ZbWJzzcVyGPbI
         D+h4Se03G4jY0C7PYYnbP33JnvRCXvMYsVHS0iMTAfRMIL0Wkk1GnQV/tnHRAaJI1Nyk
         r0cjl/uB5FsY8RneeWJoXUPFGuspUnDc8KIIhgirdkCpY5DCyPO9hwm1pK7P6G7gU6wj
         3R1OFzNjLFzmPxFXi5ZDLQ89KnaGV64PF9eNJ1GM3YSXonkixorJPm/cpT36ywqgCe3x
         kcgA==
X-Forwarded-Encrypted: i=1; AJvYcCV3JgMlQ5igKajdV05JSYiDN2AZUhoRtg7IfsqiViKqHTZ0caoNQfMW8FSYxzVGXUewSHJ+uTZaxS91Rqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygT+DPUawPvm424Q+Lzjr93sHd1QuqAOhnkQEz8kVSr+xczpXd
	z/eBu7eltIDF7UUyLp8Lh8oprPkVuKG5K4t2weI9kBhqnEsodaqF+kf/yDbcAyTTCUNGxY2IM/h
	HcbuZD10UFTEmy3t5/ifEPp9XDRU=
X-Google-Smtp-Source: AGHT+IGNe3YVRFKhWrgUI99fM++c+XkooDEtmM3ozfZ5VLPvyPYojqK0jLsnzBStdbGNJy4bDlX3c3UeSSmtiOAwF1I=
X-Received: by 2002:a17:90a:3dc5:b0:2d8:9f4e:1c3d with SMTP id
 98e67ed59e1d1-2e1e63237e8mr1635577a91.5.1728064826219; Fri, 04 Oct 2024
 11:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004081618.27599-1-advaitdhamorikar@gmail.com> <00761132-75f3-41fd-b571-30b0cbe5565d@amd.com>
In-Reply-To: <00761132-75f3-41fd-b571-30b0cbe5565d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Oct 2024 14:00:14 -0400
Message-ID: <CADnq5_OKww1YZ1R_OytEMLcNVwdq=-ckc2gqQ+WMyOv6AZ9kqg@mail.gmail.com>
Subject: Re: [PATCH-next] Fix unintentional integer overflow
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>
Cc: Advait Dhamorikar <advaitdhamorikar@gmail.com>, alexander.deucher@amd.com, 
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, leo.liu@amd.com, sathishkumar.sundararaju@amd.com, 
	saleemkhan.jamadar@amd.com, Veerabadhran.Gopalakrishnan@amd.com, 
	sonny.jiang@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 5:15=E2=80=AFAM Sundararaju, Sathishkumar
<sasundar@amd.com> wrote:
>
>
> All occurrences of this error fix should have been together in a single p=
atch both in _get and _set callbacks corresponding to f0b19b84d391, please =
avoid separate patch for each occurrence.
>
> Sorry Alex, I missed to note this yesterday.

I've dropped the patch.  Please pick it up once it's fixed up appropriately=
.

Thanks,

Alex

>
>
> Regards,
> Sathish
>
>
> On 10/4/2024 1:46 PM, Advait Dhamorikar wrote:
>
> Fix shift-count-overflow when creating mask.
> The expression's value may not be what the
> programmer intended, because the expression is
> evaluated using a narrower integer type.
>
> Fixes: f0b19b84d391 ("drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs")
> Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_jpeg.c
> index 95e2796919fc..7df402c45f40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -388,7 +388,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_get(void *d=
ata, u64 *val)
>   for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>   ring =3D &adev->jpeg.inst[i].ring_dec[j];
>   if (ring->sched.ready)
> - mask |=3D 1 << ((i * adev->jpeg.num_jpeg_rings) + j);
> + mask |=3D (u64)1 << ((i * adev->jpeg.num_jpeg_rings) + j);
>   }
>   }
>   *val =3D mask;

