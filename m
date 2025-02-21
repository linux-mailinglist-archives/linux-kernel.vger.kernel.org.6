Return-Path: <linux-kernel+bounces-525978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A6AA3F816
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE10702C40
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD6321018C;
	Fri, 21 Feb 2025 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3L5f0Cu"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68974BED
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150541; cv=none; b=U1tZpPBuQIQf2qhKHL7PreBphc5vBinoXM9sisHv3cvWieORESgv75gR/WHlV2sGvX55iO7x/NCLoX2Id108Q4P1dGWiCXhvzhbE1kuzThSDd2gzM4zlB5MWbBvV080r5sOaHGG57dGMTw4Tci6dlrytKNfuOAq6A8qkB0hiDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150541; c=relaxed/simple;
	bh=c5xn0MfChQYvshGz8ppoxuhPdTV5UG4Px4s/vruRdNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaaoMbt9W/UUodUjxXX+Yqd6mzOIQ+eohQj5469HvlwuuQWTVZssWvwNZsNLOV4Y7e/LZ7ybPsZeWxfnNU7AE8YvMI+OtkpYgNFikptU9Olih3/u6klVnbJOE74f0CMOVCv3sVVmLRlpBQD+E2pyNm/Y29h4VSwipByfxawYlgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3L5f0Cu; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fbfe16cbf5so546315a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740150539; x=1740755339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1z9enPprBTCltTD6Zq+9N/ViPgRVx/V8w7eQeJHOME=;
        b=O3L5f0CuJj+cLCpnHQYNeV8IDYrG/dzWTNTGEkLngyv5mrq0wN6/Bs2LmbvK2anHqF
         Zbe8ftV2cjN9iexDKj2ruZ0rFowfVXpUledytmwnyjJ/XfZfJdccvGYm0BQUPaegJFBn
         QtU6WPDfZwWh9FXrD3u8UAFH4l+mKpkn9MeYf/l8hZ75yqw25AGZ42MlT+h7botVqQmT
         cdc+69NMWsF0vz8eWqwrmurXbfPg8zt/OIVbHT9QXV0g39JPDITwh1Tfiqlc9DCrvazm
         YyiD9m6lKrZX+qm8BeADbQIdh4KTYcf6RUWbkTfCTOML5F3vXqMOqrJowWdYO6Eez01p
         m4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740150539; x=1740755339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1z9enPprBTCltTD6Zq+9N/ViPgRVx/V8w7eQeJHOME=;
        b=oL92NYmMUGO/gWBgKe13JFuEVk0P1lxlaWMqwN9Vrb4P+wASZz+viaFAmLPrpV59Wy
         +w3ev6faFCM3Oaa/XCeVqlfDXgS2iuy50Waf7egrOCcYgZ2roGzX0K+OnsI3FO1SbQk+
         /sCBOEstg7/aR4vmr/C3OIqCCcOJnIkB1dpCYy6EnqAUDL2bk7PM99ZtETK/hEoBlqvm
         ml0GIRiT0SRaRQIxAc+8nT/drYRqvNM0346KwtUm7vT71vm6pizj4g2EG5HTKfrnwUfx
         HdATZUiqO9apAQ/I6r9lPCCv4+ggH+QpQv4XMa30V5JWRcgwqCdWhBJYiRVJL1nMeo8y
         gQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYBSffMK4Elv8pTwlOkqimn+vxfK4+fascLAT+lHkkcqxk/yJRZLU+VgZKv3hTzpjZZRqx8sj7KSIFcT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2qIwZkrrsiO1w85bljBRohTdfFmjzCxnxssnMUZAD13zpsbE
	MCIfIzBheqwFV1VquhoJfxVWb9649s+2AFobNSXZRlQ2e6p8lyIjoeWmxh4VuWMstr263dOyTGm
	rszRc0CT6rM6Yg/Xq3S4oasz8mn8=
X-Gm-Gg: ASbGnctwZYBruzSue71mbl7qWMnII7F2+RBNqgOddElKV2irQv27gAGqq7pny4wZ9DC
	D0dqZubGUdoj+EcZUyoWZ/XIIj2qETdIZOCnw376b3TbK/tI16mFwFeHXXy8yoefMP/iTB0m+aW
	rOW0OZGBU=
X-Google-Smtp-Source: AGHT+IGVbL0tZlk1tlZK53o23pxJBrsTiqCDJQSUOvTrPIgvq9iQeap92OR0l5X250ulFPr8H3Fb1ZA8O3be8c51hRs=
X-Received: by 2002:a17:90b:3b43:b0:2ef:c419:6930 with SMTP id
 98e67ed59e1d1-2fce7b028bcmr2230885a91.6.1740150539294; Fri, 21 Feb 2025
 07:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220162750.343139-1-andrealmeid@igalia.com> <20250220162750.343139-3-andrealmeid@igalia.com>
In-Reply-To: <20250220162750.343139-3-andrealmeid@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Feb 2025 10:08:47 -0500
X-Gm-Features: AWEUYZlDBUXP17Cs6I6f-XW5ymhm46Qk9g76RKaCWVyT61CDlmLAQDsLOybc4CY
Message-ID: <CADnq5_O9NnvVObz5BPr4rx0RpWXY-2UWmY0tw=7WhnzG4khf7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/amdgpu: Log after a successful ring reset
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com, siqueira@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Thu, Feb 20, 2025 at 11:28=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
> When a ring reset happens, the kernel log shows only "amdgpu: Starting
> <ring name> ring reset", but when it finishes nothing appears in the
> log. Explicitly write in the log that the reset has finished correctly.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 100f04475943..698e5799e542 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -149,6 +149,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
>                         amdgpu_fence_driver_force_completion(ring);
>                         if (amdgpu_ring_sched_ready(ring))
>                                 drm_sched_start(&ring->sched, 0);
> +                       dev_err(adev->dev, "Ring %s reset succeeded\n", r=
ing->sched.name);
>                         goto exit;
>                 }
>                 dev_err(adev->dev, "Ring %s reset failure\n", ring->sched=
.name);
> --
> 2.48.1
>

