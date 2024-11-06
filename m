Return-Path: <linux-kernel+bounces-397775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 201429BE02C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C301C231D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D0B1D3566;
	Wed,  6 Nov 2024 08:18:01 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673B18FDCE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881080; cv=none; b=WGS2Aog0FWSud7QQw3gmpyZk/cs1qqjAhzWGYEHosfVknqqAgwd8zRZHYUh8woubbGKDap18EUov/INQJtvtzt/2HR6qqoj8UOMuahmVx63rfbmvIPA0YEpkcFn3593bgpskdZ4u3oTiXWPCKCn7LKrN+94RmQxIwUruobvYw3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881080; c=relaxed/simple;
	bh=asbKfRtbqRz/dhxSc48q6tIrUjwCS8/yvOVZ5GkNLQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ujhli9cy/94rGdJHJIdfAnE4q9DMR2FHX3LKcTGICtMtVrtfwmboRHU7jZgtp7D6e0ZK3p+u0qVgeYniRJm7AqXWcNMGWyW/VRm2d1xW+Knm1S8P7Jrv+NYeuptJwWRKjfksVSG0yM9uXyYYAuTRd1EsfK66+S2VKTlUkARkg1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso8086927276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730881077; x=1731485877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kR2eScfyPIgGoKSiUmUzFN5G+h2FTQtl3KMTeFBL3X4=;
        b=bJDtEJjUC7rvNG7F7PLZ5h0ZCdX3B45rPakG1U+brFTZwu/RoMOjO2t4ZcAp/BjDet
         RzjBiOrGGyAph23rSsIQko1VDPdj0ggffzqjb9OO6Rq+V6kzK4PdowWFUpr6/wFzv25I
         F/rKNTGKgJEE7fw79h2Dipkcz4JHHu2eXIv4ugdHnT1yxnlB1O/ZMMefiNBWWPeXXqQ4
         G2GTsBcfSdB5lijXbJ6mG3RbcjtWUONMeLvtKzI7ipklfI8zCRsS9FMDhUJ7TLBgDuGU
         +ST0dPVG4Nr2+AtJ3K7nqrsGDSl0r0f0rFetB4DFlAGbtwSgPxa5YeUyJWq6u+JxzUHd
         NKkg==
X-Forwarded-Encrypted: i=1; AJvYcCUduCrEAQ4ml3GN1sbZFyxFOUFp40w2wMtd7OGTHEAQDCK3tbaC6G1/FalVKe+Lm4p2NA/xRVmKx3E2wms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhL7vba1/f/Mft2pSKfiKbxRnATxMgfrBJQBXDadOvbcDuADfB
	3uMtHYFmL0wO/L5NRUTCeCo3kfLjlRGeTFHEKtgVHLgmasTzCp6SokdGp9to
X-Google-Smtp-Source: AGHT+IGcY9XdYp0FWPlQe6n58sXFS+GZ22V0wWDBfKYXqLSqRonQUqfri7HI9a9rcZUXKtIC+6eycQ==
X-Received: by 2002:a05:6902:a04:b0:e30:cd90:b631 with SMTP id 3f1490d57ef6-e30cd90b761mr25082872276.33.1730881077223;
        Wed, 06 Nov 2024 00:17:57 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e331707f13esm2069423276.27.2024.11.06.00.17.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 00:17:56 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e292926104bso5563367276.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:17:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXKyzPrsud8Qhlxd7NZbEyIaQgkI3ZhMFWVRowIuFycG0i6QYgo3yoHcEbyr4sIuUvP/zuwI5D7gVHAbU=@vger.kernel.org
X-Received: by 2002:a05:690c:6312:b0:6ea:95f5:2608 with SMTP id
 00721157ae682-6ea95f52ff2mr103721337b3.7.1730881075844; Wed, 06 Nov 2024
 00:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a82e8f0068a8722996a0ccfe666abb5e0a5c120d.1730850684.git.fthain@linux-m68k.org>
In-Reply-To: <a82e8f0068a8722996a0ccfe666abb5e0a5c120d.1730850684.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Nov 2024 09:17:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX2WxBg-909sDRWmMWqGHL+PC63JU+mQ7z7uz2YR_ZRpw@mail.gmail.com>
Message-ID: <CAMuHMdX2WxBg-909sDRWmMWqGHL+PC63JU+mQ7z7uz2YR_ZRpw@mail.gmail.com>
Subject: Re: [PATCH] m68k: mvme147: Reinstate early console
To: Finn Thain <fthain@linux-m68k.org>
Cc: Daniel Palmer <daniel@0x0f.com>, stable@kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 12:58=E2=80=AFAM Finn Thain <fthain@linux-m68k.org> =
wrote:
> From: Daniel Palmer <daniel@0x0f.com>
>
> Commit a38eaa07a0ce ("m68k/mvme147: config.c - Remove unused functions"),
> removed the console functionality for the mvme147 instead of wiring it
> up to an early console. Put the console write function back and wire it u=
p
> like mvme16x does so it's possible to see Linux boot on this fine hardwar=
e
> once more.
>
> Cc: Daniel Palmer <daniel@0x0f.com>
> Cc: stable@kernel.org
> Fixes: a38eaa07a0ce ("m68k/mvme147: config.c - Remove unused functions")
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Co-developed-by: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, will queue in the m68k tree for v6.13.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

