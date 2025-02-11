Return-Path: <linux-kernel+bounces-510155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F75A318F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2EB188D16E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886D127291A;
	Tue, 11 Feb 2025 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oZcJ7Pk+"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A1272917
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313559; cv=none; b=FkanZ5CGGOxBymY7xSlR/LT0TRO5rsaM5sUsLCTnAuga3vF4sy3k91H7S+73fuYrNUF26GUiY8EoDjmiUrF2H+NmTttQONRgiY45dx/idcnlWXjjs6jhOdfbCFre1SuBhbSb0fev66RJG/sfjERk+O3KnvCO/THuAO9kJDmdbHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313559; c=relaxed/simple;
	bh=+rxztfAaepIvxroPWZrjETMbmBSAZmiGeMmEEmwWnq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTm2vitOoas3omtVtFdl4EeNg8v8Mt0hy7gPh7ehtABTkT00hHPwQbqoQIpWtoP+6tEq4tNydrUOIa43yJMP2kUJ7OJrXdwThjDDHnmdiy+7uInGBmFk9pQqD+WI167TKTZ1Qp1s+10vopIW91vd+qV0+6aFx9YK69IxaMEowLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oZcJ7Pk+; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A59DB3FE77
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739313547;
	bh=gkMw6duxxbJfB77Dmk59/srgHXi1HXapVPCmFg+N4GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=oZcJ7Pk+ZMqegGRCPOfrL9c/VbO3dNr/A0n2rBIZUjHg0Ay7GeFpx5d6Vcst/5ikj
	 4dlLK70BayjYA7WsTmN6aJ1Tf7Z5CXqspc4QbcS4yYrvKDuLWB8CLoXZnI383QYbGM
	 pmOVg6EQW7/Qr5wStDSVAwM2gvhnd1TBid8cphlUIXqAKmp8jC/2d9wIYSsYtFC8j9
	 S/MZWZypZsSDYjkwMo5w0JQP3iL9ZmeLhWpp55ZrRVYYD6XnmBsSbn8xOH1ZqPDdjy
	 Am98zHuD/AXIv3CX7WKAB4+nB5+eKDgVw05U+949+TlnQOaKeRKDPRlHt/YSR/s0pu
	 z9dpH1c2qLtUA==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5da14484978so6651101a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 14:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739313547; x=1739918347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkMw6duxxbJfB77Dmk59/srgHXi1HXapVPCmFg+N4GY=;
        b=P6C/vNqj/dAg8SWZkbyYunjIXC+xu4XTemW/YXc9pH3N2pBoMb+f3uOuzMDTiOIVj7
         s1dL4kspm0nUc/FhGbP5NiqzHqbSqollcPa8bfBr21g/svJ7Dnf2oBrQVquocKxf1MhG
         CRM4u8CDXTwNiy8jGKWF5U2gCKSJnLJNEy8IGQ7xO1dKC17mGcqTint9BfhtkdI8PzVq
         Rb9e1xXIHSZBhnmnoBDce/rN2J42AIT9F9u3RpaNigY7BZY/Jhfxg1cOIs2p09oW03n8
         MQLPM2pwhl4h47ghH8Z4wDcDhQDFjkO2TgurIr4pOzeueKmJ4QjWfS4cGdd62Y8YTLEk
         Q3wg==
X-Forwarded-Encrypted: i=1; AJvYcCWdQ+vL6D+zsRjrC2bwDqR7z6qQBtiwsuv62qsmZkAFU6g2CIoNXtYn4EdRVEmw/aalqMChgtSx70oa+C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVyqbK3I0vRZ0GX8QYRGsanIpnEEPmfR9ct4UJKawA/NtghhoK
	4Ylciz+67JHWWR94wV0G6hIMDDvaMhlTPG5/E5hp/Mwau4kGxS1D2u5DKISdFnDu5W2fakeEI6r
	Iw3ijsrnfmtD6jbyANpYF73NKyP9ePH5ZnXkx6BKHHDYggzhcQMju3kF8QWGujA/t0cgv61k466
	TEB/1PHbystvnMxtaeYhniu2oNEQkhTz7WluwqxmESSEcWcklSj5yq
X-Gm-Gg: ASbGncvD4Y7CMyUMx/6j+efztRSNmCjrXDHweZva7II5J4oCAbSn4WA1i9qgoL8uL7g
	JlLwVf/BZ3S0ootgvw8UA8a34DW+eAQzda0qXfgoWX/T0AcM+qDUZnyHfa3Lr
X-Received: by 2002:a05:6402:51d2:b0:5de:5025:2bd9 with SMTP id 4fb4d7f45d1cf-5deadd936f0mr915533a12.11.1739313547020;
        Tue, 11 Feb 2025 14:39:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeXeNOatBL8lSa8MFqwcK0SmN6a59+iekzjKdNDyEiFXRd165z7bm7gHTT7X9urmoNWySmmNrC1TNzRw3pWYM=
X-Received: by 2002:a05:6402:51d2:b0:5de:5025:2bd9 with SMTP id
 4fb4d7f45d1cf-5deadd936f0mr915515a12.11.1739313546627; Tue, 11 Feb 2025
 14:39:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210210109.3673582-1-alex.williamson@redhat.com>
 <20250210220010.GM32480@redhat.com> <20250211100502.GA9174@redhat.com>
In-Reply-To: <20250211100502.GA9174@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Tue, 11 Feb 2025 16:38:55 -0600
X-Gm-Features: AWEUYZlnKNzZTDbCsc8502Eq31gjprPZsr33NdR0NJiES3nE_UoqvPy1bRypWdw
Message-ID: <CAHTA-uZ5dxh81D090YFVWbeJuko-+ACPbNFVQ8_++j_8sBjaAg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix BUILD_BUG_ON usage for old gcc
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ilpo.jarvinen@linux.intel.com, David Laight <david.laight.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Ubuntu's (modern) GCC 13.3.0-6ubuntu2~24.04, both proposed options
also build as expected for me when howmany is set correctly, and fail
as expected when I force howmany =3D 7.

Tested-by: Mitchell Augustin <mitchell.augustin@canonical.com>

On Tue, Feb 11, 2025 at 4:05=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 02/10, Oleg Nesterov wrote:
> >
> > On 02/10, Alex Williamson wrote:
> > >
> > > @@ -345,7 +345,8 @@ static void pci_read_bases(struct pci_dev *dev, u=
nsigned int howmany, int rom)
> > >     unsigned int pos, reg;
> > >     u16 orig_cmd;
> > >
> > > -   BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
> > > +   BUILD_BUG_ON(__builtin_constant_p(howmany) &&
> > > +                howmany > PCI_STD_NUM_BARS);
> >
> > Thanks!
> >
> > Tested-by: Oleg Nesterov <oleg@redhat.com>
>
> Just in case... I agree with David, statically_true() looks a bit
> better and
>
>         BUILD_BUG_ON(statically_true(howmany > PCI_STD_NUM_BARS));
>
> also works for me, so if you decide to update this patch feel free
> to keep my Tested-by.
>
> Oleg.
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

