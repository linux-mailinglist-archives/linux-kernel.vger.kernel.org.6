Return-Path: <linux-kernel+bounces-566201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B35A674D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145CD188898F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C787E20D4EE;
	Tue, 18 Mar 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITuCYiTM"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D220AF9F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303926; cv=none; b=hD3/ywShlpYN5FOIxuyzuOwtCl7cl88EBx7qWD6eJi7ZYBEz0R3n33tALEAVzEYYrR1ZxzoBVoUg0+89V2ipomVEl/SEk9npuU/O58klLYw+B3YgfOAJ3YovwFzyO8pTxBtXUEg1+h8b9vav4LJ5ZC9ZoA0VnSYhoV4If9UmLQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303926; c=relaxed/simple;
	bh=X0/iIZ/BEZmiFYO6TRbwjn9sEuZ3v66DepdOUnYHXrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M87t8P1F1NyLEggYiqHQQB+Ppw9s3eBKth6iYUlywYGy+89GK9d7l4Q6MtdgvIx3t7cIKT/d+APw8ZHaF4yBjjoakd7TwmAsTRT1Y2uLMSTo3XrX6MWX6WfB0hcHhRquGkr9HngXS9shXZA72B+K8scaSeK4h29JpG6XDYG0748=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITuCYiTM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301a6347494so128516a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742303920; x=1742908720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69ljFS1rk5l/n84/nsOjrOvJVy8Zq713HHIVitktCPE=;
        b=ITuCYiTMvbCSKxAsy6idodg4uPuGBH/kug3ZmU3LY21o1WnLi1UWmxi8wdlL3HznWY
         La9o06Lwil/UIVRbrzBB+zze6i/hKADrYDtUgR7FYBl56QKv6n5dq8gT1MigUpCjIv6m
         ihjDw6joscb3pqAikAI5I/vqob0BoqvRcvGetJhl6d2xU6jdzTfY5vjDp++zIwgt+iZI
         v0U+XCzfgyYtTZs5Q3uTg6vfPhU8QQEO4tZo9hnictUi89ct1WIter/2fHUsfNm6qtLZ
         F/EvjnP8K6MBdHk3PQ1KmxFia7CzrXoWQ2tqf4cWXhNz8Vu/d1WyrqGbIZr0Ft1geTgA
         lp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742303920; x=1742908720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69ljFS1rk5l/n84/nsOjrOvJVy8Zq713HHIVitktCPE=;
        b=p3moBbr7X9F12nKRgVG1M7JIOXLmFsOssomV4Kfh1H/foAqxjXdEZdQUmuhLC9VN5d
         MqJ+p3JYG7L0QqJ9yPLXBF7QWhlZy8w6zHG2Xk8xdSKuepKLVfx6vHVAVidylZZzwikO
         3qyNjM6+EAwxHnV9r8idYAS46fS/OBkUY4qMLJcYi7qHqshpFIFoRbVfIkC21g7J0XB1
         FPvys+fsCKA/jAvcVUJRH+mvBJQyrDgiWYoVFUD6AKYfvwgbVR+Nem42SNCVTCjtOY2c
         9DEYXVaYUjenu6DOD2RUkzWU0Qmi3XUpY4atJM+ickrbdZBT3E7P3Q+Aeu1lDiVRt+wQ
         Gn3g==
X-Forwarded-Encrypted: i=1; AJvYcCWBX7Oyz1RlaCDHEN9bIq2hOBDdR10SOnjfCLZ0Xn/FMv66NgMGtfEf9MVwRXtgtswu4ZHzbnKSY5241gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYoPXMMqP4a5B5m8LoB6We6c9CObxEnnoV0nJ1W/5ffJCSXLa
	5ZX08JLGkeL2tmilAlydTEDJTQc3kCG0gVgXHwhYQmywG+5lPjvw4YEYZPRFyDGVpk6dEfhrGne
	3CZIPubZoCBYJ4NixBPiHCU+8Nnw=
X-Gm-Gg: ASbGncu+Kqe9SW4ffmpthKK5dPKgn4S0lKRdgPhCLXrA+eqtU3DJAQ5Ks9ZPV+NVPlk
	iRfvhG3s9ttsxyLhxpGjq1pZAQCOETXxIEIPXT+vMd3zTSB++rAHzCgdu+fC6+SNY6qtDBH6Cvz
	4+o7ne8+3vTLgxRjs2jHw5PHC7JA==
X-Google-Smtp-Source: AGHT+IEEe/F89Tj59dekHZVix785LRmaFuqwTiIW6CIe3px67aEzxBeoL9MiMt8LVYSdURPPL/N3zxHZHkQKIGd63F4=
X-Received: by 2002:a17:90b:3b52:b0:2fe:b45b:e7ec with SMTP id
 98e67ed59e1d1-30151db4d3emr7959340a91.8.1742303920446; Tue, 18 Mar 2025
 06:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317105745891-NnPPMd8T0guyJikMgM6p@zte.com.cn>
In-Reply-To: <20250317105745891-NnPPMd8T0guyJikMgM6p@zte.com.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Mar 2025 09:18:28 -0400
X-Gm-Features: AQ5f1Jp1fYgt08WGJFwuUkumJ3kySBxvtJOvetoAFqgET2sWxN2RMM0_b9DHL3E
Message-ID: <CADnq5_MyyomPwhQ6DW0GsfS8XNogLECM-h3-8AODYr1OTrm_ug@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/uvd: Replace nested max() with single max3()
To: feng.wei8@zte.com.cn
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Tue, Mar 18, 2025 at 2:18=E2=80=AFAM <feng.wei8@zte.com.cn> wrote:
>
> From: FengWei <feng.wei8@zte.com.cn>
>
> Use max3() macro instead of nesting max() to simplify the return
> statement.
>
> Signed-off-by: FengWei <feng.wei8@zte.com.cn>
> ---
>  drivers/gpu/drm/radeon/radeon_uvd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon=
/radeon_uvd.c
> index 058a1c8451b2..ded5747a58d1 100644
> --- a/drivers/gpu/drm/radeon/radeon_uvd.c
> +++ b/drivers/gpu/drm/radeon/radeon_uvd.c
> @@ -961,7 +961,7 @@ int radeon_uvd_calc_upll_dividers(struct radeon_devic=
e *rdev,
>         unsigned optimal_score =3D ~0;
>
>         /* loop through vco from low to high */
> -       vco_min =3D max(max(vco_min, vclk), dclk);
> +       vco_min =3D max3(vco_min, vclk, dclk);
>         for (vco_freq =3D vco_min; vco_freq <=3D vco_max; vco_freq +=3D 1=
00) {
>
>                 uint64_t fb_div =3D (uint64_t)vco_freq * fb_factor;
> --
> 2.25.1

