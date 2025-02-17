Return-Path: <linux-kernel+bounces-518476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A73A38FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB6A188FD8E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3F01A4F12;
	Mon, 17 Feb 2025 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwNOSG2R"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260D7404E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739836016; cv=none; b=o9zCIxnP0LnD3F675tAumnKe0LWXRIhSEE4pzPgDqty6ZurOwInRa+0riIGHvB+WE0ROcuDJTZZP7nE8Lj7CWd3e8SnEoBCrGTAamyAJuQgWFZLULWeRcW4M8HNuW1pjVdCh3SfzfQlqrKJIMW3oMRlF7WRHTvnO0uu8fO5JBRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739836016; c=relaxed/simple;
	bh=Bg7EzNsp+wMRTmLzZfXKYZLT5XEacDQC24hUqBSOG7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7hmdHiZ3Uk83a9MpO3QMAqs3zrECbi9URH0KNGDgsiZU4iBxlIoNR8lAvaO00tQdmQ8kpxS31Xafp5QUQoVHtnAbspQ7syYAlz9l8GMA3S/KKTwTXN1IjqnPnGN7YZHCe/2Dbq/GKRDZPFYbhHbs5fuvJoQ1Vj+hjZe+Pg1E9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwNOSG2R; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so16211881fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739836012; x=1740440812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FM8gssIggd7QB1mF6kqIFjET31jYUzg6Outzr1oqKbM=;
        b=ZwNOSG2RGORfXkn8e+BRkdn6HxBe/MxkHHaVQOV2BZjHlswsh2JrDYeyfm8CVS2YIK
         awtaSmCZvWpn/Vy+ZaBvDzlLIpDkwIjii9VaElwVu/rueEcNhaZP4FQ3Mj9F3/W0chh9
         iakyIRoo/e3u+mBuAYOICI2ESYswQuOfs+bF5QHn7v/LEO6vSjE/oYTrfgyxrGshvBeu
         v8MLtuXWRTmY5FX820JkHL5ZiaRguJAUL1t3KB/Br1nGUscQBucuT+Qu5OCHBrEh/l+2
         eiei01A8dLG4qv4hqaTDltYsCwIJJbVLRyP4HC4rquFi2q2INgAzm85FmA6wEz3t2mW9
         x/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739836012; x=1740440812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FM8gssIggd7QB1mF6kqIFjET31jYUzg6Outzr1oqKbM=;
        b=AbkUqy5SSa9NYsNR4JvlvNSEXGh3/iVBUkBSrxYIISjSbSpJhTbz1g7agN4XV2SOCT
         xulSb9kjzE0NP4k6wTd13DjZiYyFoV96yda0NLjpaEsB7wKM8nZgnW7EVxX2z1oVKXes
         A6KvhBcLZwFHXReYFMuCWMi9X4Y6NR2QyDs9SVL57qxNIv6b0F1G5cVRPJAk3VlT5iu4
         jxTTnDMqyGH8nKyjgrE7w53si3Z3pxL5vgROYIs6BUHtJCUtQPA1nwx2Vyh2MGW+477D
         TfF/l+Q/eVLxl9+73Rh6lgFnPL14Ooq9bMdJ5KHAWfzQK6H4at4YvACIr+L0Un0BLVfL
         BBGA==
X-Forwarded-Encrypted: i=1; AJvYcCVM22Shr6u8Wb4dZte6LkSyhXJMHkPFoEMcbUJGFoY5MGmxWY4XkgF+T9MT7FQzHziP/P2RrVL/6oYJ7DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMdMPtY/N1yyZfd3UsIabDg0MBTI3xi7WYNq8q82fSHuJOTanR
	Y/ko+ku5diPzSIbqWgeEHfi/2QRhgogJqtuJgSmWQ4pI6EelSMTuyS5DrKrV2j+I0Ja9FrMPgnl
	YLXJB1941TmQp0kxFGpSqgzO+xIM=
X-Gm-Gg: ASbGnctLITA8CRIZM2AEO04FnzdNcWhwkHI7roLSKNVhYSKL8xYJMpdQExzm/PGvRVL
	2D3ht/ZXNHqQ1YBG0O9i03eqCp2UQFzWl6WaJGJluf+hdy3IKtxgXawcGuG24fW8ODsJNQtyp
X-Google-Smtp-Source: AGHT+IEN5bTcsmKi2lfEIiRMKXu9LKo1SwbpnnYE7Q+3zxcf8RfOO11Rwp61iWEkvk7mMEmMRKSWDwyxuUtYVqZV69c=
X-Received: by 2002:a2e:8615:0:b0:308:f6cf:3607 with SMTP id
 38308e7fff4ca-30927a59acdmr29272921fa.3.1739836012177; Mon, 17 Feb 2025
 15:46:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-nouveau-gm10b-guard-v1-1-0d96f0068570@gmail.com>
In-Reply-To: <20250217-nouveau-gm10b-guard-v1-1-0d96f0068570@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 17 Feb 2025 17:46:41 -0600
X-Gm-Features: AWEUYZmJtDHUMPg6NAkLDss-aidiECufB4dsJAFV7McUhunlncLVMlVRtKKZwog
Message-ID: <CALHNRZ99cs=rcR07jqsZE7Q3ndLqteKG8K8zpAm4vaEhsYwTLw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/pmu: Fix gp10b firmware guard
To: webgeek1234@gmail.com
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 5:43=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Aaron Kling <webgeek1234@gmail.com>
>
> Fixes: 989863d7cbe5 ("drm/nouveau/pmu: select implementation based on ava=
ilable firmware")
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/pmu/gp10b.c
> index a6f410ba60bc94ec9d52fc78868acddfc6770e19..d393bc540f8628812990dffe4=
c2f7e9014be07c5 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c
> @@ -75,7 +75,7 @@ gp10b_pmu_acr =3D {
>         .bootstrap_multiple_falcons =3D gp10b_pmu_acr_bootstrap_multiple_=
falcons,
>  };
>
> -#if IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC)
> +#if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
>  MODULE_FIRMWARE("nvidia/gp10b/pmu/desc.bin");
>  MODULE_FIRMWARE("nvidia/gp10b/pmu/image.bin");
>  MODULE_FIRMWARE("nvidia/gp10b/pmu/sig.bin");
>
> ---
> base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
> change-id: 20250217-nouveau-gm10b-guard-a438402b5022
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>
>
>

Apologies to the maintainers for the multiple resends. For some reason
the lists weren't accepting my submissions. Looks like it went through
with b4, so hopefully I won't have more trouble in the future.

Sincerely,
Aaron Kling

