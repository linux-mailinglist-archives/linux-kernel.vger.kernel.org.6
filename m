Return-Path: <linux-kernel+bounces-519578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8717A39E45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE87D17286C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA3F2673A1;
	Tue, 18 Feb 2025 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwFNbeBU"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C0269CE3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887552; cv=none; b=fenHtuHAMo+9EHIfboVeT1xBx7/dzy3ypyIkiDsCwqeBdoFrasMXqfjeUPAZssKRlKKg9EoVfSKDiccA+wUX4SIabhnXBFSREHPy542pWVWO3sQCmWFyDB+yQRhINzrRmiKy49kfDGSBSNTSgKzxcUB4aXJEK1a6sLuT4Jgo7Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887552; c=relaxed/simple;
	bh=oW9DZ59UCeivFpN968pPcHaSm038AsMBBTgzSI5Lgyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXg192T43dvrErxlll4uhI6nfFSc8t+K+NTbY5n0zdkzV5zZYa8ANaEyR6Z2xQB3GnObkJS2gt7/BfoPOdNMoWxmpgSYSXU4ChhmBhts5YccwF3zVA7dmSrXu46E9ZoVrEJGkVE3u7l38nWdJaTdFF5nNHAq4nVflJKo3GQHQP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwFNbeBU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30a303a656aso20306441fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739887549; x=1740492349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfGCLhfhNhyGMknk1g3ezGCgyL5j8xO0MfyidAobZeQ=;
        b=OwFNbeBUL5mmtwkvaXDIRPuQqlNBIXpVKIOLtgKGvXgJxp5BHzM13SnjFECFhx9i6u
         k3hNQbkqxL4gQembJ/DWLVUEk7yA9weN9ScuLGs3qdelIj+pyV46S+zgn/S91NuesEGP
         0o0kPzw/QX081J4EHt3H9OwNgGwEHceNXggh3O6E/SCyc4mCAh1UiqLVLOTbtM5obq97
         DS95v9GvCqkiUIpwtCcH6yl064JKbxi5J1evW8VV8I5N59NFTq+jhy9K+9PxFP4CmVDW
         tFAYx16/NSaJ/lQG5ZYFuVALUAY2Pwnh0OgZ2uOR5QxpEH6n9UITd3qhpaPAfdb05cg8
         uutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887549; x=1740492349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfGCLhfhNhyGMknk1g3ezGCgyL5j8xO0MfyidAobZeQ=;
        b=PDanTRhR4H+FyIms1rCx8wuvbt2xwkjeLL75GHsvdGKcyTtnb9i1KMHBFA3sSO9g7v
         Tri5tYZpkRd/UDWVovdedQhQLBCqmmvOlXUA9e+16Ht4EN47zssYX3CjYKN+wJS61UUV
         eiDIZSSiprKHoVquOh0I4xt1JPQ+liY62OZbTUzD3SeuBa1mrWHYsVkT/K7ZDQu002HT
         FFnuHBkzl9Mr6U64sYKI/AzRKqwX1bx6Gd4w+T7GLAeTw/UnOJ/OuTliKAT+j6fuOub5
         nPrx0A2D15VqlwdcRs5PQ8wgRZfGcWIeRUGvwW4lWMabLC3kWVhdch46dXQYrV5IOYeU
         KG4A==
X-Gm-Message-State: AOJu0Yzp7g6D/h9y7ufI3uXzqstxHgyv8y74kQvq43Apbj4fesNz/oVv
	mPGhokDymmMWYCOc7Wj63AwNUmwplq1Yr75348r4h+VkEJWhFJFns+QQzAJopTMV5qQHB1Ya+qY
	eRRjfHeNVVHyVp4oY00jy8mnH/A==
X-Gm-Gg: ASbGncuDRooI4gk2BREL/NbqXISbYwVJuW0+NYu42rtrYXaImEFGKZbma7Tz64XLHXV
	/HsziU7IYgQrdBHtLA+jof1PdUcroccrzRjfJ4DcPrP2kl9waaMNHN56CovlabWponyqnk0jJWu
	QCjH2j7z1R+W4=
X-Google-Smtp-Source: AGHT+IE8HftFXeqmGJovNxcwN2fcYte5/ynaApscx6zw0rc1nTq+5mm1kUCFvEt27QuImgX9fCKtL59teFhpWnBmpCg=
X-Received: by 2002:a05:6512:b27:b0:545:6b4:68c2 with SMTP id
 2adb3069b0e04-5452fe8f93emr4073021e87.47.1739887548738; Tue, 18 Feb 2025
 06:05:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <20250123190747.745588-7-brgerst@gmail.com>
 <Z7RNxf9NWmGZ6aDE@gmail.com>
In-Reply-To: <Z7RNxf9NWmGZ6aDE@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 18 Feb 2025 09:05:37 -0500
X-Gm-Features: AWEUYZnk_85bWld-FaglZtD1ihlpkM3a4fgwk9noLnSU0TrQOcAiKCRCkYzXDtk
Message-ID: <CAMzpN2i7-=2BU=4_SY_hxPHU+n5MMGRwS7BzApy-TGoeWTZHog@mail.gmail.com>
Subject: Re: [PATCH v6 06/15] x86/module: Deal with GOT based stack cookie
 load on Clang < 17
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 4:07=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Brian Gerst <brgerst@gmail.com> wrote:
>
> >  #define R_X86_64_GOTPCREL    9       /* 32 bit signed pc relative
> > -                                        offset to GOT */
> > +#define R_X86_64_GOTPCRELX   41         offset to GOT */
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +#define R_X86_64_REX_GOTPCRELX       42
>
> Uhm, I'm pretty sure this won't even build, should any code use
> R_X86_64_GOTPCRELX - which it doesn't currently...
>
> Also, each entry here has a comment explaining it - except these two
> new GOTPCREL variants.

Should we remove the non-REX version that isn't used by the kernel?
This header is not exported to userspace.


Brian Gerst

