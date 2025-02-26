Return-Path: <linux-kernel+bounces-534881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42353A46C37
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E28C7A1D15
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091332755FE;
	Wed, 26 Feb 2025 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyGHRe93"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EBBEEBB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601341; cv=none; b=TWpY/gogoIJpk9arl+s13MBMdz4K7guWVRjS8PxLM8kWqrqrB6Fc+jcL0X8/so7ugK58PiRM3yckqE5CTrfP2ifpXtDds0qJ2P30xVKxLwqbGVp3TSh4TPMGo3orajYmJTKlHl1CmQ4YZ0xr0aBeZD9PO+0Jf+2MDQSWCKIjJd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601341; c=relaxed/simple;
	bh=2yI91M11oJYuKDMpnA26v1DUN7gvrm+j1JKyo///pNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQ0G7YIw7VVCA1y+XPXI3KM2jhXN4GbJCm1SkY3ccnP1H3lwW/v11RT6vYAwYtcq0g/UC06Uq+E7Pa/xw/tnpiOthUf8TyOiUhrcglMA4y+qH3PW5h47MabJCT2vPmBddMBOWJbziXxcRwOsLhkXI1PULeJilgLS7ASVmTK8KKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyGHRe93; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so170192a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740601338; x=1741206138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1vDmtIQrMsy1qqwpZWxFUiy2B26yzWBbUqZcyfJHmc=;
        b=RyGHRe93nXQuUsRAv4g+3RCfl6cIO+JDXRh9yJ5NDCp+ZCAdiFoFrf1+8lqGcD7WzA
         ToDDOgzQL0A67NlkHhsnmvK8HFgotzgp5gtQPq+ClznobGqb4C/YBadI02tvrvTpM773
         ueJjjMM2wPkAj2nuN0av7AUvJLHTxzE+Tm9hrY+CRff25W2SrQbtcSeZWFZiofjkOlQC
         ugjMrLphVnp48GjN47Az+wYqXPDd8G+spZrfxe48GmiVUNE8TDJKUdZdjCn4lQUg4SF+
         rOUdXCgL4pNbWWa2NOJZ42TTun05CoxeNUy59NfsNd/GhQpx/85VJSN03tkN4BQCShEk
         o2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601338; x=1741206138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1vDmtIQrMsy1qqwpZWxFUiy2B26yzWBbUqZcyfJHmc=;
        b=WFDkGm6KKxZ6pDEyFpTn7nTuwdpv0Dt1MDIWodt8DPWBow0rRNzHsJ06a5mJX+Uk7U
         yKq7dovgkA4gc3/Qj+K4CDn5wLFK+grs4GlCMaW/AEU7KS/Ocqk5R1BIFMPomfs3yrhA
         EkUZG1cy5Cm/x7KVMcGM6uRvKgwX8FrW4M+qQUzqSwDlFkSghpbdW3b21Kbm1jwWRgqE
         yIGVxNAo4IhptulxyatU2wZ9Xb+vhNv7dTuJZmIq/UHggHN0lEPNIi5td4u+r4BSf0lj
         HuS10ECKDzgyEm8t3FHkjITHI6V0PPa++mjN1RV7t4fL8HyMV1utAHuMDbXtN0rnGQDy
         6p3A==
X-Forwarded-Encrypted: i=1; AJvYcCUm5KsAJgNMIy2R5CfloWxnJkb5eH5vy6zbgDmhc8hQvvk20xyA59191sHnCUtHiSfO8QorjHF9Y1vvGwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEf7kgk6jXuJGVrfWK44gV4RUjxgJv/wqXoiy9FuhlkfcqLNQl
	9htE+dnVngnl0KE6gMAlL3MGmlb/PPTY/N7iK8WwouXF82wpNIHFbvASg/ejk//ZJJ3v1LP+Pnb
	SyJX6CfZocgfcWz2huAftd3kPYBw=
X-Gm-Gg: ASbGncv9LGUUaf2l6m47rkQ+o9TsuQrnA9Zf+r69VGBt1/gzwEu+c+JJMia9vv5RHUD
	qUYrOu8sgLhUhi2j9WsKp7aWLrjjPjdlUFLjs6SLxrO6FAbhfPJ9aMeKjZwWejcuBjrS1Q22uKi
	3caLmizWsXZw==
X-Google-Smtp-Source: AGHT+IG4/LTA9VORKAh51/6AHK540icwK8yAJ1ehhOtvAKagYtTRj15neS+9RcboR5sP60eFuY0oWpHLuLOCjG2ILAc=
X-Received: by 2002:a05:6402:3587:b0:5de:3c29:e834 with SMTP id
 4fb4d7f45d1cf-5e44b7635damr10190157a12.27.1740601337838; Wed, 26 Feb 2025
 12:22:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217053719.442644-1-vignesh.raman@collabora.com> <20250217053719.442644-3-vignesh.raman@collabora.com>
In-Reply-To: <20250217053719.442644-3-vignesh.raman@collabora.com>
From: Helen Mae Koike Fornazier <helen.fornazier@gmail.com>
Date: Wed, 26 Feb 2025 17:22:05 -0300
X-Gm-Features: AQ5f1JonnkitWo-lyzBGKGAx2v3pmOJ4LrXR_AOBnSKv7RbGNmxa-AbuRJBkKFQ
Message-ID: <CAPW4XYaGgfck58HQy_Y3y4YTjCHOYHFDofJR_8k56i3Cj1U1tA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/ci: enable CONFIG_DEBUG_WW_MUTEX_SLOWPATH
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, airlied@gmail.com, 
	simona.vetter@ffwll.ch, robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	jani.nikula@linux.intel.com, dmitry.baryshkov@linaro.org, mripard@kernel.org, 
	boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em seg., 17 de fev. de 2025 =C3=A0s 02:37, Vignesh Raman
<vignesh.raman@collabora.com> escreveu:
>
> Enable CONFIG_DEBUG_WW_MUTEX_SLOWPATH for mutex
> slowpath debugging.
>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Acked-by: Helen Koike <helen.fornazier@gmail.com>

> ---
>
> v2:
>   - New patch in the series.
>
> v3:
>   - No changes.
>
> ---
>  drivers/gpu/drm/ci/build.yml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/ci/build.yml b/drivers/gpu/drm/ci/build.yml
> index 274f118533a7..6c0dc10b547c 100644
> --- a/drivers/gpu/drm/ci/build.yml
> +++ b/drivers/gpu/drm/ci/build.yml
> @@ -67,7 +67,7 @@ testing:arm32:
>      #
>      # db410c and db820c don't boot with KASAN_INLINE, probably due to th=
e kernel
>      # becoming too big for their bootloaders.
> -    ENABLE_KCONFIGS: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT"
> +    ENABLE_KCONFIGS: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT D=
EBUG_WW_MUTEX_SLOWPATH"
>      UPLOAD_TO_MINIO: 1
>      MERGE_FRAGMENT: arm.config
>
> @@ -79,7 +79,7 @@ testing:arm64:
>      #
>      # db410c and db820c don't boot with KASAN_INLINE, probably due to th=
e kernel
>      # becoming too big for their bootloaders.
> -    ENABLE_KCONFIGS: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT"
> +    ENABLE_KCONFIGS: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT D=
EBUG_WW_MUTEX_SLOWPATH"
>      UPLOAD_TO_MINIO: 1
>      MERGE_FRAGMENT: arm64.config
>
> @@ -91,7 +91,7 @@ testing:x86_64:
>      #
>      # db410c and db820c don't boot with KASAN_INLINE, probably due to th=
e kernel
>      # becoming too big for their bootloaders.
> -    ENABLE_KCONFIGS: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT"
> +    ENABLE_KCONFIGS: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT D=
EBUG_WW_MUTEX_SLOWPATH"
>      UPLOAD_TO_MINIO: 1
>      MERGE_FRAGMENT: x86_64.config
>
> --
> 2.43.0
>


--=20
Helen Koike

