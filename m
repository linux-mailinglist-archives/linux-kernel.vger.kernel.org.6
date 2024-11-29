Return-Path: <linux-kernel+bounces-425854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 040B59DEBE3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D12DB21607
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF2E19F461;
	Fri, 29 Nov 2024 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BDirmJJ/"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3751199EBB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732903046; cv=none; b=M0fBPY/8XGkIOpwxQriVx46dd1C0wps8AgGRocCx7NpS+SxZHnKvKY7dQO9hTL9IXUZfd1HCn5jLx9ecUG6IX7BPBEWipvcBrQROH2A5UzXYQxm1XrfEeP0KChqdxHig3ugU/cd9wk9+I33R/sGjZg1Km4LA18sNzKxXAMxcEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732903046; c=relaxed/simple;
	bh=JFzVcWDEm5CXgDdGuAL/NOGwKd89apFnmRbV9WPyPEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7b040ZRGflmaNqUiEdRVa8A6v5A1PnY9z7DnuH++TV3PXNZXkQmd65CXV5mqMQgHPNMcP++D2X3yvVF+ZP38GnLPV9H2i/CUQXoDbkD7FETcQtMEXUAjBGjnxKG64Ym2F3AaT41L5RVPiK4tAbPV+GHAogWCGh6Aprf+0etDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BDirmJJ/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724e1b08fc7so1956524b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732903044; x=1733507844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ru996n1l3z6WbctCEOJjxSCZN4opuu+Dv6+UYOpspPM=;
        b=BDirmJJ/VBQV0srgOV0jMOJZxP3wk7K6mmuHGbTh0E6VZYHwyLNOjemiUR2d1jmU4t
         FsM9/kN9g7peU1cp2r9/wBQuEkAD8xdahHc9qy7sXHTXvppf1+jOcme5OSUgELJ1pZmW
         C1AV+yLST+o+L8WSk/1J1ydK/m7k0kQn22Q8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732903044; x=1733507844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ru996n1l3z6WbctCEOJjxSCZN4opuu+Dv6+UYOpspPM=;
        b=JLFDkLBRILKnYNdixnp5kkBGHeb0XCI3RYWfsXBJJlCJZNvstkvrMVQGNb4g9iV2os
         J7A4Bon3Okx5bnxz0mZWZsbBApCI8LNuWaPfgcb4XQckuqfVqsGxIx57XiGC6RPnyECZ
         LHGgy337rgUVvPj8tXmABqWhtVe8WhaFD1sEpMIOlhP9WBOWavbv6GDWRrJgAkY7mwe8
         0k8uk+a5c8ZsZ/ais+XQanfKlMaD+fuA81aO2+knQGqcqOSG+XW6MvsQ0gbBVcEuNiJI
         X15DL6TlGoSzABVYS2oK3iFGxAyWm1msrpSR6hgtvYVVqnX0GRScTNXS3rSGPTunPo+g
         9KoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcqgkBO5c71E3TjlmrIpeXSZ6Ph9XvcASSFOwQhhnC9c2FV3SabMTjTaq+Mb+iL3s3YU0PWU4SSI7f3TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymFtConPWG+qzwRVVhKTD9SxQK1oK0AMwMh6DzQpS8X4gu345d
	bBGPlx3UU8aLzUwPacrYcf/oM/j5mAtTODxy0hYPCR4FMuPR0zCQagvypu+F6F+R1xnoBX+aC3o
	=
X-Gm-Gg: ASbGnctB2BApTP3l29tvsEXEhr3hIJ+VQWDVjUZff09untXWfkWjr3fVk0CtjcHzUJ9
	jT+F8qPC2laa3LL1pNj3Dl95RsmTmh0UfXbZjCQxJGqgWPrPFB6N14hA83SI7iUIxxw17KOcDgx
	7CkERK6ONCLGwyyx0IJJpC9kSxEm5oEMJhrL7SMm7un4LZs9QVQP4iE2fmwYtcjlXPoeMf4h6R7
	kEp5+vVsx3SVxzYnV0LHT6frH+Ah/TorC+Djnr9pORO/hXcKZCzKB/DtncRA37ZAZJGXM41TOFn
	gq7ETy4+/6Ip
X-Google-Smtp-Source: AGHT+IFfZxSSwf3CP2oj4v0a8UvKgzjBZjXemt+5h0tTF0kO+X+8OGchP3SGpsxehYTbFjtVpauimg==
X-Received: by 2002:a05:6a00:4f88:b0:71e:cc7:c511 with SMTP id d2e1a72fcca58-7253014a11amr18029880b3a.23.1732903044060;
        Fri, 29 Nov 2024 09:57:24 -0800 (PST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com. [209.85.216.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541814848sm3744693b3a.158.2024.11.29.09.57.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 09:57:22 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2eade1cad26so1518866a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:57:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjgrzQUuPh89fu2gn4REnfKv6vVc4J4eXbl4qq46Y+22QrAysVl00PwFDhGG2fJuaOFT6p7X2TLm/nwYA=@vger.kernel.org
X-Received: by 2002:a17:90b:4d0d:b0:2ea:853b:2761 with SMTP id
 98e67ed59e1d1-2ee097e3d26mr16074171a91.37.1732903041929; Fri, 29 Nov 2024
 09:57:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-lan966x-depend-v1-1-603fc4996c4f@chromium.org> <20241129184500.6d72a7e1@bootlin.com>
In-Reply-To: <20241129184500.6d72a7e1@bootlin.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 18:57:09 +0100
X-Gmail-Original-Message-ID: <CANiDSCtVdPh4YX1pgRQ+M+KGTD+k5UPxWhZM09FBiT5+hDifjw@mail.gmail.com>
Message-ID: <CANiDSCtVdPh4YX1pgRQ+M+KGTD+k5UPxWhZM09FBiT5+hDifjw@mail.gmail.com>
Subject: Re: [PATCH] misc: Kconfig: Make MCHP_LAN966X_PCI depend on OF, not
 select it
To: Herve Codina <herve.codina@bootlin.com>
Cc: Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the headsup

On Fri, 29 Nov 2024 at 18:45, Herve Codina <herve.codina@bootlin.com> wrote=
:
>
> Hi Ricardo,
>
> On Fri, 29 Nov 2024 10:41:17 +0000
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> > Most (maybe all?) the drivers depend on OF instead of selecting it. Thi=
s
> > is more convenient for CI because we can have test scripts that do:
> > make allyesconfig
> > scripts/config -d OF
> > make olddefconfig
> >
> > Without this patch, OF cannot be disabled that way.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/misc/Kconfig | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 902c306bc972..2ea5f40ff4e4 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -612,8 +612,7 @@ config MARVELL_CN10K_DPI
> >
> >  config MCHP_LAN966X_PCI
> >       tristate "Microchip LAN966x PCIe Support"
> > -     depends on PCI
> > -     select OF
> > +     depends on PCI && OF
> >       select OF_OVERLAY
> >       select IRQ_DOMAIN
> >       help
> >
> > ---
> > base-commit: 7af08b57bcb9ebf78675c50069c54125c0a8b795
> > change-id: 20241129-lan966x-depend-8bc69b4954e5
> >
>
> Not sure it should be done that way (See [1]). Also I pointed out this
> patch in the discussion.
>

I have no strong opinion for my version or:

depends on PCI && OF_OVERLAY


Shall I send a v2 or you prefer to handle it yourself?

Regards!

> [1]  https://lore.kernel.org/all/dywwnh7ns47ffndsttstpcsw44avxjvzcddmceha=
7xavqjdi77@cqdgmpdtywol/
>
> Best regards,
> Herv=C3=A9



--=20
Ricardo Ribalda

