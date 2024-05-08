Return-Path: <linux-kernel+bounces-173179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72628BFCA2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A681F21BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C806823D1;
	Wed,  8 May 2024 11:46:50 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B282C6C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168809; cv=none; b=JkKEyJ0tHsW3glKwmP5ERsJqGBhhwDfa8M7a16x6dUnArATsNFcCpeH0oneLXWGR5AYLqS01AOeGsrEriul/YC4pkYC4HExWWvrdWwuy381qcu+z0i4RfUpRXpO4ZhY8j7WWsTU4uBqV0HsPtHNfVhP6fthv2+tGBFZfqBwg31A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168809; c=relaxed/simple;
	bh=SAlKIWE//lHoA+nc7JO13tI8bPAbZw4MA+BMyr36N8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayv2llBI2p38r4vIQT69UTuXbm2ffxOtD91Px7DxsL/TbwHWGc+5EqLNqTyQrSj2qgjscoVhx8QSorKrZ48LRgtthHs5p3K27FrD7FDSnL1E1guV/NTAm9Cl8PfJzXw7DTZgeALXKykiZG6EC9VZPcl8vCCNrJKnfmX21A8W0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61bed738438so45181367b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168807; x=1715773607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UIM/QXFLV/zOyVSdM/iHxl0eTqhK78DGC/2DFVqdW8=;
        b=GN2Xp8haHj5LPRisZitZZ1d5wajU54Jop2GJWDABFm0ensBePCTTkYKAcp0b+wUcBy
         j+XHMM2E+HtKuy5sEpepi6INA8DjqJaz2BJjPQzOjeP7VUKAIz7HSsPYJ3Jov+2FxECG
         JRnj3AYcuRf5LkkcCfKjsAhvFzNE1C03VGpIpOGkMViIyrPrjzH7c3RAgzey7KaLiiXT
         EQwmqyVnW8pnTM8ejLC7RQE97uzasPjulUWVw3/KeOJH0UMyJZZrpKCgLpfnmAlJWq7K
         gMy325kXq3pWBfi43aXM86u8yrV0eZOCgSYVcwyAeSweP6xJh0u76cBtg6uuqmui3ADX
         WV9w==
X-Forwarded-Encrypted: i=1; AJvYcCUsm0JxlakeWspClhJ2QGJOTK3hr/oUNeISj2RSOFjz2Z8emhl7WX2zMhEq5vt+t5CLy5Wz9H1jgfnsP6fGmuXHRKGxP87iwhrNV2Nv
X-Gm-Message-State: AOJu0YxqLONSvqs8UAkpS26BQcVROVo6vZUaKoaJkNXpvc2+5SnlGm2q
	61lFPZi2PJajSkf06WyRt/jzpzYPVsFHzNWoFK5rofEOCo0hIEWbPdjmiJpxnSA=
X-Google-Smtp-Source: AGHT+IF+G5TDpWvU0UE8D+cdVBNoaMwYfDjBAfyWOM2oS+eoQe8o+6zbKk2CW/5qdIK2Iv3tgzK0mg==
X-Received: by 2002:a81:b045:0:b0:615:1413:95c1 with SMTP id 00721157ae682-6208624132emr21298787b3.19.1715168807102;
        Wed, 08 May 2024 04:46:47 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id q13-20020a81430d000000b0061adccb38ecsm3257313ywa.10.2024.05.08.04.46.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 04:46:46 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so4760395276.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:46:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1vwlKmP89/7w0MC9Z7rb6uJ18FfFQP6PVpc177+Nx0/MEkUUhDZMAWonek2Y78eSKT2UCNZx5fDmuLm9SPgif1Xf7qD2GVXCRJrBD
X-Received: by 2002:a25:8050:0:b0:de5:53c0:b9e5 with SMTP id
 3f1490d57ef6-debb9d96d92mr2346115276.40.1715168806721; Wed, 08 May 2024
 04:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <480ebd1249d229c6dc1f3f1c6d599b8505483fd8.1714797072.git.fthain@linux-m68k.org>
In-Reply-To: <480ebd1249d229c6dc1f3f1c6d599b8505483fd8.1714797072.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 May 2024 13:46:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVUWZcP1E-T7mu7txYODhRK0vmBRXXTs51vuBewZQj_kA@mail.gmail.com>
Message-ID: <CAMuHMdVUWZcP1E-T7mu7txYODhRK0vmBRXXTs51vuBewZQj_kA@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Fix reboot hang on Mac IIci
To: Finn Thain <fthain@linux-m68k.org>
Cc: Joshua Thompson <funaho@jurai.org>, Stan Johnson <userm57@yahoo.com>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 6:43=E2=80=AFAM Finn Thain <fthain@linux-m68k.org> w=
rote:
> Calling mac_reset() on a Mac IIci does reset the system, but what
> follows is a POST failure that requires a manual reset to resolve.
> Avoid that by using the 68030 asm implementation instead of the C
> implementation.
>
> Apparently the SE/30 has a similar problem as it has used the asm
> implementation since before git. This patch extends that solution to
> other systems with a similar ROM.
>
> After this patch, the only systems still using the C implementation are
> 68040 systems where adb_type is either MAC_ADB_IOP or MAC_ADB_II. This
> implies a 1 MiB Quadra ROM.
>
> This now includes the Quadra 900/950, which previously fell through to
> the "should never get here" catch-all.
>
> Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
> Tested on Mac IIci & IIfx, Quadra 630 & 650, Daystar Mac II, QEMU.
>
> Some corner cases remain problematic. For example, a stock Mac II or
> a Mac IIci with a 68040 accelerator will still use the C routine, because
> mac_reset() lacks an asm implementation for '020 and '040 systems.

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.10.

> However, amiga_reset(), atari_reset() and mac_reset() do have a lot in
> common, which suggests that a generic asm reset function parameterized by
> final JMP location may be a useful refactoring. This would provide the
> '020 and '040 handling missing here and could potentially replace
> hp300_reset(), dn_dummy_reset() and q40_reset().

Sounds like a good idea!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

