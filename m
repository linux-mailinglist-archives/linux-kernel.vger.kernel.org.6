Return-Path: <linux-kernel+bounces-558631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE73A5E8CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBE0173CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA811F2B87;
	Wed, 12 Mar 2025 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PFk0EfgC"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32821F153E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823617; cv=none; b=TfLk+1rL29zqZMMWCP7TuI6k/bs9tgVie++aqIPfcXYNWAzD6GHOpJAF6lBNSkeQ8R7jIIY6umioimXFjQHp4rEGag4D55ABhQyqm3TGvWU9BL1hypqt1aX7YphKWPCchaF/RtiEbRBd91dfbnKmgoW+XRCh/V7qIICMtoTcqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823617; c=relaxed/simple;
	bh=AeGft02PCfpVr0FAIZGX6Xlm9LKJIDZ9am3sD5SGW/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPAxgp9afyXt/J/RZL1uIwg6wOxcGeMN/E7tAjrF/BG2p9k0BbXaj0OUzu5UHKbNOlGCQ+WlvFMdw+jrQiXWzokfCfmVGk1Dzl208/3gtFYLlFdRm0gnwDMhtuqOtctEdjfMQP8Fxjr8oJIF0qvjU0jMtFp4ccSYWK+4Jug2bBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PFk0EfgC; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-601a15186f0so60899eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741823615; x=1742428415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8H6u01PvxgJprnkIiXjJQ4sDMD89dhh8rkhvlxkSKIk=;
        b=PFk0EfgCfcgTGmQiHNt80npqdJMZ8eCdoQhyKeMatewoigAbHyC9cqdPtdFZpMV1mk
         nlzki1esIUEgmRlJ7MFmUeiiGCxbkummMPyXIAbg0gU3mv/d+03Z2tGObrNoT6/DVVf1
         YAut3E4fAVA8jg1WMymwmH8GcPPEcfxQzj2Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823615; x=1742428415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8H6u01PvxgJprnkIiXjJQ4sDMD89dhh8rkhvlxkSKIk=;
        b=eKQNo/FCe+uTYVX85xim9IJxTih+IGXajHYWG7eHgjxrGPnXCJclc3ZVCDzgi+K5/m
         CvYxfm2IKPgvbW7zfGlO9NioypHRk8RnjWBDN9bB0YQd4YhetiTcfMfn9LW11CssT8Em
         t+f7oS7+StSdYCFk3PWyhuTIf1dpoYubQ6RxW+tj529lWoXVuq4MVoXhtk/R8ewAGDsm
         WAhwdJynqAoz3/UD4Ar30Aff0D++PqPBCccRKcMUK1Iu78Rl9tuGPXm0zDM/xXZIgyPh
         C6WseIhl/VRQL+Admu2COFwTIeGTiy54TZUrKvSevldYl8eMQKtYcz+5yrtUgbo62ePA
         spiw==
X-Forwarded-Encrypted: i=1; AJvYcCXjFXgysnyHpj9ju2Ao8RijyjX5cm8odmOblqPk+9o2VmqxAdJdKGB4GuG8S69wmVJ1/OQomPR5RjqLrG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdbDzLvuyYnzn8ro4TvJFN7x4/KYZj/nz7sN/eoPL0OeYdrvw8
	2jgoDgfodnfNchmKLdclUBhIviAloKR4L5LJTO0HJn6VUTKRgfHQUJl5puVYjbBdWOP64D4Fk6X
	eBHdsxF1UA6MouHHrD6ubbJSGUx/t0pA76UDW
X-Gm-Gg: ASbGncsUNzs2lpfJMYLU8kBWnrxrF1xIzbE35RRd17pLb+vRK0B4BXxronoTDE13L6v
	Gbkv+3uvzDv/cSZ9iGp3QuGLuNEZ3iixZ/+UVnawwZI8xFXxh90JQ7kAKtMujYLYyZ+rvdOP/Ao
	gHefjjwRFWZzXtcxSDom+nXsGY
X-Google-Smtp-Source: AGHT+IHjNAYQ0ub88nN1552iMB2eL8X1RV4+1cI8aJCntlA0geWWYJiWNKkJ8nP6eRkdBx32XB4wFpN6HoYn7iau44M=
X-Received: by 2002:a05:6820:458f:b0:5fc:92ed:639a with SMTP id
 006d021491bc7-6005a21992bmr2215701eaf.2.1741823614821; Wed, 12 Mar 2025
 16:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311123326.2686682-1-hca@linux.ibm.com> <20250311123326.2686682-3-hca@linux.ibm.com>
 <CABi2SkXWD4Pg7Y7TG9fMV9eat_1fOGwHjvEUKHXREN+pRe18NA@mail.gmail.com>
 <CABi2SkXzqJ10NW3j1y-FtmrheDkqzL5QgMcN9UN6UvhbXFHCuQ@mail.gmail.com> <20250312153946.10610B02-hca@linux.ibm.com>
In-Reply-To: <20250312153946.10610B02-hca@linux.ibm.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 12 Mar 2025 16:53:23 -0700
X-Gm-Features: AQ5f1JqCIcxEvjlYrZ3A0vTQkfvlQ3azH4ngw0Oh5F45vZFYCocj3YPdsQosWIk
Message-ID: <CABi2SkVk-LNWioxONFDppLJNnd8kj+UH9PXG3BU-5GKcUJDavA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 2/2] mseal sysmap: enable s390
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 8:39=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> On Tue, Mar 11, 2025 at 03:12:55PM -0700, Jeff Xu wrote:
> > One more thing: do you want to update mseal.rst to add s390 as
> > supported architecture?
> >
> > Currently in the mseal.rst:
> >  "The following architectures currently support this feature: x86-64 an=
d arm64."
>
> Thanks, I missed that, however I'm wondering if it would make sense to ad=
d
> mseal to the generic feature list instead (no, I am not volunteering to d=
o
> that :) ).
>
> See Documentation/features/... and scripts/get_feat.pl
Thanks for this suggestion. I will add that file.

-Jeff

