Return-Path: <linux-kernel+bounces-278161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5ED94ACE4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17D51C22A9B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7F612C470;
	Wed,  7 Aug 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OPLHmfDe"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5712C473
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044565; cv=none; b=MEIg02abpuYMCBpHE25fq5lPR5VzMrmHFxyiKWDRTFsBnJ6aivozjyo1xOs9Jb8pboDDLT0brtVP4WfRzf7mGmzhLU4LZldBYGSzHmu1Ey57oyJnLgMRnS29F9tH7uB/nz1z4JBFMBiJMiup3qvid0GWXqsffp4W/HLQtTsO6Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044565; c=relaxed/simple;
	bh=B3qUjQUBKSoj6DiE5izmtCoNi2oQX3kGXMYImbc+tBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nv/wflrqM8iYDy65zyJzash4HMmQrCqhfiAB+vODPSoIdwFeEDTaOlrfnz1WG361tH4eFGm4j4LzNb6IJ6tBmCj70+n/iSt1h+UdfEOumAqccOEqfv3hoi/WJmNNpkNBLxzeneiyYGOELZb48nz//QaSXcTclx9vSsTSXlIG88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OPLHmfDe; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-690b6cbce11so19418217b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723044563; x=1723649363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKQ9M/o3NVnkKygQpCqhb1IVgEtJMwyJqqnPTlCGvnU=;
        b=OPLHmfDeHvharH0vkYihAnB/ZGgtqUKLbKoW+CEPsh4Dx3rKc/CHDdcllju+l3ra31
         7ox3oLQL4Hnym4ajlIc8z/paMK6mA/AG1PRZlfVmVal3DU7w1Q1V+1EYrIt8ui7GEhqv
         10OWiuL5PDl+CYHGjhwg0zTG8tokh0CEPogjz7jvykwVXXBeThjwABHD7UOpkhKRxcKC
         sMIUUjkYs+VWqpB9/skIUnmT8TK80z18eyNqaNruxkzaLq87N5N++oQ+F9EnTkegS07k
         pugRWXKAv61wUzYeLvIHpr+bKaYdJqICSCzHXXORB2mooUp7QSYmwafYYzY2YtY+dIaO
         F/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044563; x=1723649363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKQ9M/o3NVnkKygQpCqhb1IVgEtJMwyJqqnPTlCGvnU=;
        b=LNiHltfkgBeILW77M2RGzuoFiI8EO0bmntCR0gdEStCm9qr+mprnMo+VydztuiYpMn
         GUoSB0D49HXklSVXhmgbS6J/wytcPbbHki74JLTvgHgGFOukLCNukPNdkO7k33+Jherd
         uLNJbrvOlILH56m4pA/aLfrBSFVKHiigyhlERtU4R9CV1i01PUZ1uYmRkyH2D5n//2Fb
         IovRM0hyqSTo0oCBYISEz/Lk3wx9zzzlxTz1nN3vfpx2UlPt7ebm/t0LPPvc3Ktr8C4k
         Cl3aWCVXfVWbEu+PV5pr/zMu9PVrmahGCD3eGJAb/bXxW//jSfB9DuI7boDzA/8cWM+V
         xTTA==
X-Forwarded-Encrypted: i=1; AJvYcCV1FDvr/DbSJatcRtFVshNnBPwMnWIaCe0pGwKbYNcx7XonjryDr66UIstiLhCg882yO8fyHzbGY1XPcXZSZWU/NcUl5zxINjdKf03U
X-Gm-Message-State: AOJu0Yz8w2fR+iS//L5OPt8siEe9HdiROHMmmkaFBTuZSI7657esRNFA
	Lx7fQyNre6VKlEvQtp11GkvhqoEj3USlt9JueF6LuKrGdSV2SO7znJO+mN1V0AV7SbUsuXs+EU1
	WQ0TNuf8dVPbaj/8ir5V0dkZhrFwIasU27xBA
X-Google-Smtp-Source: AGHT+IFxKYsOrG4ilAXTKiWlIY9sugsT5cdso9SZyJ4+TO3rkpTxQeSesfajzSgpUnqosNMbojqCvWGpQGpS+lQXelM=
X-Received: by 2002:a25:c341:0:b0:e06:fe1a:ffd8 with SMTP id
 3f1490d57ef6-e0bde3ee72cmr18086030276.31.1723044562667; Wed, 07 Aug 2024
 08:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-macos-build-support-v1-0-4cd1ded85694@samsung.com> <20240807-macos-build-support-v1-6-4cd1ded85694@samsung.com>
In-Reply-To: <20240807-macos-build-support-v1-6-4cd1ded85694@samsung.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Aug 2024 11:29:11 -0400
Message-ID: <CAHC9VhS=KGRCbk-zy4aMiNfi2aMRX6YBP8H3VNAw7pY85TxDRA@mail.gmail.com>
Subject: Re: [PATCH 06/12] selinux/genheaders: include bitsperlong and
 posix_types headers
To: da.gomez@samsung.com
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	William Hubbs <w.d.hubbs@gmail.com>, Chris Brannon <chris@the-brannons.com>, 
	Kirk Reiser <kirk@reisers.ca>, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, speakup@linux-speakup.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-serial@vger.kernel.org, llvm@lists.linux.dev, 
	Finn Behrens <me@kloenk.dev>, "Daniel Gomez (Samsung)" <d+samsung@kruces.com>, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 7:10=E2=80=AFPM Daniel Gomez via B4 Relay
<devnull+da.gomez.samsung.com@kernel.org> wrote:
>
> From: Daniel Gomez <da.gomez@samsung.com>
>
> The genheaders requires the bitsperlong.h and posix_types.h headers.
> To ensure these headers are found during compilation on macOS hosts,
> add usr/include to HOST_EXTRACFLAGS in the genheaders Makefile. This
> adjustment allows the compiler to locate all necessary headers when they
> are not available by default on macOS.
>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  scripts/selinux/genheaders/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This patch, and 7/12, look fine to me.  I can pull them into the
SELinux tree now, or would you prefer them to go via a different tree?

--=20
paul-moore.com

