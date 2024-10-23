Return-Path: <linux-kernel+bounces-377413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778769ABE7B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B44B280D53
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D13147C79;
	Wed, 23 Oct 2024 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="TZPihWbs"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AABC145B1B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729664061; cv=none; b=IubiBLBNojw7jDorVkD3NbkyYjl6GUGDGGuS/PuSYyKbvR7kyl3g58ZI3s/HfUA4mmDKdOVx0HOOBciR6wIF0h7j56p51PvZaM2WQek9+rS2bf/i9DnwLjLXRsKTYGvz9yuPyCfX5vQuUrr77BroX4bZ7BgSvquXcJjtDLTnzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729664061; c=relaxed/simple;
	bh=nqh7gLyzY+i65hjx8EFoScR4DFxG12Nr8EwO1Gal6os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsjhXozgjfwl2seTxpqrvtIoCAhapoH/6TH6Kzrd+KpryMvodk7wP7/H043cfenuYaSbFvg9tMI/rxy4wW+zyCj2Y/44dM1u7cT2++pIn57eiAbC7sSviv1ysTwu1SXJiTYF85YleM9Zt4hk9oAkKq/0cerWKt8fcNyY50qcM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=TZPihWbs; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e290d48d3f7so5824486276.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1729664056; x=1730268856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoS2U7s/nFksZ9J1s9QFWx+X3+eAJT+8MCN58PfkFnc=;
        b=TZPihWbsrHb6PASNwB/9hVmXG28lWrf0hnusu1Hnj8x7+jvlivaiw3/Hg0ZHonYPQ+
         jo1VVf/H+vLZeETT5qFv/48HRVxk8wJGh30vx96y8A2A4n9Rkx64R6FU5wtYdDU16ykv
         MZ8OKVjQaj5v6LZm6Zg6fkTxiEuDPjqFeO0j01mALvfGyt8kH8kpHz9ut2p2WDn7D84e
         sMZUdBf0cHHcrnXhCQ23RVZp9fv6J+G5gBCkSq1s2bTXLsKG+k1kUDOwIr4DYFa6GhHc
         2NxkSPtRLV/U2clMee3jEc5UcJJskQRy6ttmaMLDhLuH9tY1KKxdZdOWMHVBCWk8Nwzi
         VKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729664056; x=1730268856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoS2U7s/nFksZ9J1s9QFWx+X3+eAJT+8MCN58PfkFnc=;
        b=ocjM3jkGpmaCKjnRoTZvhPPKvTLKJx4Bmu/vgzoBMXuq5V9gyADa4x0QCVUSdlRQ8j
         HuqNUKGWkoffx6UCPsjPGFj19qI+wi9dT2KttCstkrLgaf0LLIUcC+MnozXGSlNhmDwv
         K5oqlYRohLpDOta253Z0yvXEaYwx5sBiQewN6D+CLOKktDrVXVt+4v6cIhyOxxoo5/K5
         dxKylL8xsMjgdfHfu+6kEpqRUTO/ECB+HmkxPhejq/GajBOmzBmt3purRySUE8lbf9W0
         pOASHlE/l0wK5bVSbt7LBlXD4C8p9I4eRaMs6pvjyt1001Dqy2nTtQgsif/Rzl9dBkJO
         gWVA==
X-Forwarded-Encrypted: i=1; AJvYcCUUr7dkX54ildjKVSg8Dl5M4LKDhpAeA3K2CRpZOm4fr/bGKSx4PC6L9LBdKyrb4FsNVY63Klm3AH7MlKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+VfRZtAeT0P4X35/cawudY3t/ckKezLXrtIC+nQMjEJ1x5fQ
	QU8Hx4/OhlgahjDQThS+RWdw8mY9KPgh+FFrf2GdBwKY99etb0hMmJGP9PxbEMeLrGh3aujYXbc
	gDDTl2a1bR++zAvvw2DDNSEQvvxK/vFNrMLqDC76KN2jfDhvNZA==
X-Google-Smtp-Source: AGHT+IFA5LEZ6NSkdL+eAT7VRNLI9QSpKEtQ/weC0pt7eFRLDuRnLq3OtL5MZy9G1Fwyy6ovNADqFizSPXG6bmNR0hg=
X-Received: by 2002:a05:6902:848:b0:e2b:e1be:f7b5 with SMTP id
 3f1490d57ef6-e2e3a609706mr1383172276.8.1729664056118; Tue, 22 Oct 2024
 23:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502173132.57098-1-thuth@redhat.com> <834e8e07-b77b-4921-ab42-87cc434f50e9@redhat.com>
In-Reply-To: <834e8e07-b77b-4921-ab42-87cc434f50e9@redhat.com>
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 23 Oct 2024 08:14:04 +0200
Message-ID: <CAHTX3dJiZodBSBxPOEFApH=jUXfqdaAGAf61Rzvykb4bx6q65w@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Remove empty #ifndef __ASSEMBLY__ statement
To: Thomas Huth <thuth@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 22. 10. 2024 v 20:13 odes=C3=ADlatel Thomas Huth <thuth@redhat.com>=
 napsal:
>
> On 02/05/2024 19.31, Thomas Huth wrote:
> > Likely an unnecessary remainder of the scripted UAPI cleanup that
> > happened long ago...
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   arch/microblaze/include/uapi/asm/setup.h | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/arch/microblaze/include/uapi/asm/setup.h b/arch/microblaze=
/include/uapi/asm/setup.h
> > index 6831794e6f2c..16c56807f86a 100644
> > --- a/arch/microblaze/include/uapi/asm/setup.h
> > +++ b/arch/microblaze/include/uapi/asm/setup.h
> > @@ -14,7 +14,4 @@
> >
> >   #define COMMAND_LINE_SIZE   256
> >
> > -# ifndef __ASSEMBLY__
> > -
> > -# endif /* __ASSEMBLY__ */
> >   #endif /* _UAPI_ASM_MICROBLAZE_SETUP_H */
>
> Ping?

thanks for ping. I didn't see the first patch.

Applied.
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

