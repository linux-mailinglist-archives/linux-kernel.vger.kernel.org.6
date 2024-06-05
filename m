Return-Path: <linux-kernel+bounces-202510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A48FCDAC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C72A8B2870F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6906919923F;
	Wed,  5 Jun 2024 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do3VtqHT"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECDE1C95F3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589077; cv=none; b=Nq7IYAuEdKitONIyv+VUOE1EmGWiI7Ym502G7jThcqcxWv8Pn9DuNeh4aoLuxuQ8/V0K49L2zl6IXwV6f6LmT6uJdHeVvUJV4i/Jf0TMMw4nziduro8Xu46TPu8VIqSMk0IMy1PASgSjQgHEc2E8yIOFhLKrtkm/acQJt4vt/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589077; c=relaxed/simple;
	bh=m84OVoVm5ii/jkR8JBTs1AiS6uReMQ5aalhNMwK9OII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pnwMfBCo7sG7DiMl9NHYG1oL9mQWZswJPV6RwvURq72jlLKo2XLgzIifvY7b8YnTiB1Ft53JY9YwWaJiCt2R8xH0bLs1TxIsE7aApp1lEXbXl1veM27udHKVle8ePbXNsq5pKTT1sduTCHVKCjPXn6nC/REgKpIJrgvLm/G7eO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do3VtqHT; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-440199acec5so1370521cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717589075; x=1718193875; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPuTc08wjjwpO86SOuNZKeHCnjPvY6giUw1ze6bOSPo=;
        b=Do3VtqHTtD+Pe8GtLPa+DbK1U+gKwvA/Wq0PsQLO8kT5bG4G2PVxNgOQtjDoae8+qG
         upB22BxNdFrj5MdhU4xNhHsLi+fF1OsR6pa0PGt3sVrQ/AWRnKA9bMmyinzFLGjUOdqP
         HbZJ7Xy1ZTJiXAR50IK2LytoUkydzDy+ihXXg3jvg66ZZG22auQuw2SCgo99CZi01KMO
         uGYUldNwTIN6CK/5VV7cPElFQP6SAR2lC34O4LjR7FioiDbXEoCusLWyhQHXK4ITmxjU
         aUAbhn2pcvxSfpv94yroaN86kP+S2bp0lap0mQqbinKFPvwzCGbB1jE/DwHVAriwi/Ji
         Px+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717589075; x=1718193875;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPuTc08wjjwpO86SOuNZKeHCnjPvY6giUw1ze6bOSPo=;
        b=bBCBSAfl6NlRmuk5D6+jXYbDgrVgcDJaCrNcRaf3geiXRdT5EIk9YnwiAwi/D65kw7
         cZRcl3swpB40gIbxH5yTIz9w0es4aXUCNQUy27YiCFsC9wwVNU3DFl4mi3rTJrtlRtYI
         nUDhxYNwP+EUbDEGxzIem9Ur8SiG617LiO/EzH1J6TNddjvr9fF+Lh1aN/L/JxyPoZZj
         UKObnj8IZw1lDdGZp04TJQ+zpxrueZt0Z4LfoF/ltb/OuZG3Fg0l1jdG4NDKRonefIH3
         kXql3n4QPDb4oBac/6fnuu1+DlsOp1UYnYhbyC4x6cWXVjLqMIDlc8ckmHZdqzF7vneY
         9jaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVnP5k7blljxoj6tqSXgKnch9jLjwNxXSbUL6xnYZ6w8mkldYV83TVogJ6YyA7DcfShvgkJzKm2ScAqKczFzPrB9ht0UbVLRJY1+Q2
X-Gm-Message-State: AOJu0YwP/Yc8+qVYVUAuyYMnTShISzALFEtGj6P/NSVc89PWmLsjy8ic
	7yoF0AxUTv6EczLqQOVKUj6KL2usloTY6Ixy5XTREyT2iCtJCXF0cwwjG2jB5pdy9o5p8GTfYV4
	A2XtZ5qJD8sQdY81YCNe0bmB3AGc=
X-Google-Smtp-Source: AGHT+IH08DASZwWkloRJgaFzndX3ohxbVhpChXg8kKGgMmIS7uWE00LXdMQ3IF+ghEagWVLqDXyH4FitBoiNT2IQTPQ=
X-Received: by 2002:a05:6214:765:b0:6ad:7a58:4e01 with SMTP id
 6a1803df08f44-6b030a489d7mr23866326d6.3.1717589074779; Wed, 05 Jun 2024
 05:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
In-Reply-To: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 5 Jun 2024 17:04:23 +0500
Message-ID: <CABXGCsN=9UFvGgKztzkkAM1c8cVN-h=TKLLxWhKgTm11h+H-eg@mail.gmail.com>
Subject: Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac
 cause appearing green flashing bar on top of screen on Radeon 6900XT and 120Hz
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, Rodrigo.Siqueira@amd.com, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 7:06=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi,
> Day before yesterday I replaced 7900XTX to 6900XT for got clear in
> which kernel first time appeared warning message "DMA-API: amdgpu
> 0000:0f:00.0: cacheline tracking EEXIST, overlapping mappings aren't
> supported".
> The kernel 6.3 and older won't boot on a computer with Radeon 7900XTX.
> When I booted the system with 6900XT I saw a green flashing bar on top
> of the screen when I typed commands in the gnome terminal which was
> maximized on full screen.
> Demonstration: https://youtu.be/tTvwQ_5pRkk
> For reproduction you need Radeon 6900XT GPU connected to 120Hz OLED TV by=
 HDMI.
>
> I bisected the issue and the first commit which I found was 6d4279cb99ac.
> commit 6d4279cb99ac4f51d10409501d29969f687ac8dc (HEAD)
> Author: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Date:   Tue Mar 26 10:42:05 2024 -0600
>
>     drm/amd/display: Drop legacy code
>
>     This commit removes code that are not used by display anymore.
>
>     Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>     Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>  drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h         |  4 ----
>  drivers/gpu/drm/amd/display/dc/inc/resource.h                  |  7 ----=
---
>  drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c         | 10 ----=
------
>  drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c | 33
> +--------------------------------
>  4 files changed, 1 insertion(+), 53 deletions(-)
>
> Every time after bisecting I usually make sure that I found the right
> commit and build the kernel with revert of the bad commit.
> But this time I again observed an issue after running a kernel builded
> without commit 6d4279cb99ac.
> And I decided to find a second bad commit.
> The second bad commit has been bc87d666c05.
> commit bc87d666c05a13e6d4ae1ddce41fc43d2567b9a2 (HEAD)
> Author: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Date:   Tue Mar 26 11:55:19 2024 -0600
>
>     drm/amd/display: Add fallback configuration for set DRR in DCN10
>
>     Set OTG/OPTC parameters to 0 if something goes wrong on DCN10.
>
>     Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>     Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>  drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c | 15 ++++++++++++=
---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> After reverting both these commits on top of 54f71b0369c9 the issue is go=
ne.
>
> I also attach the build config.
>
> My hardware specs: https://linux-hardware.org/?probe=3Df25a873c5e
>
> Rodrigo or anyone else from the AMD team can you look please.
>

Did anyone watch?

--=20
Best Regards,
Mike Gavrilov.

