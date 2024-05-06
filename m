Return-Path: <linux-kernel+bounces-170496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C8C8BD810
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3D11F219FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5144F15CD7A;
	Mon,  6 May 2024 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmMcYWU8"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7F28488
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037057; cv=none; b=fQiTWfuw9GfX7LpfI12u4ySJdJPTksiHR5KHiCV3cyNxsRoWikwLTZc2+RzDx9hIg9rEt2ZZ6YIuSt2K7RZJPd9qHDTWx919lIF35mbQ7MPhGS2Y6WVHtF3kHoc7OfwVR1PkQEHDrJ0NnzNwMQPAzokY7KKAtuyj4aCTewK/YEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037057; c=relaxed/simple;
	bh=FCWmkGKtCYFY82UHw0ipUvRiJnRCs/R5WWby7amO1H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KonaM6OpMuumXCIamyRLGcIovwwFmMUH/XjXh8ouyjf/8nGCrvRSVb3PjskDjXX0tRdjRiIcl6+U1Tn+KkAqCjaSSThZYzF3CUGE8XZURaa+fDy3DAi0UgPE3QiOzqStSQy9Pq7dHDzksWg9AbXkW5gOBp8/Yp3uZq/XQF4gqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmMcYWU8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso8304a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715037054; x=1715641854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=To7fxBOaNRZwDFrn2W07ozUB1mmlkd6/wYo0eU+RqtA=;
        b=dmMcYWU8qp3CHI3X4SLQNBnbXQg83gvQwgl+1AwyLqyanHLav25FCMG6UPCgH1an8Z
         Ye46XUbnT7DShnv3bcfaAxyRIau58uA68YgSfYF2IxLfrdZRss8gwuYqBX2xfvH+C7r6
         6nbmycAdxLhUf8d7BALfPi+bt8m5WQsGV4Ap/5d3dKuQMqe76UBjDp8NIe9eOqTfzP5X
         6wlgU93yWp65pt5+8nlrm478+TyY7TPH0NuDaNQ/mpifQHkBDfxEley7INR2pkkU2rhF
         Uf7sa0GEADpLfJD2QvvPl9FxeJ5H2h8NLtTInO2CmGjumTavrHn8mKRP+gTdJIxDLwpb
         lyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715037054; x=1715641854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To7fxBOaNRZwDFrn2W07ozUB1mmlkd6/wYo0eU+RqtA=;
        b=Epv4/PvTz2P/m8RkYGiNvcau/3EciWC0Z1JTcdNiUZ8fZHGsEBOJZ8HL8K6KVb7RQF
         jCWfZIrnm8D9n+VjXsFysU/OYvkhdHjdePkS5eFmHraRy1TWVg6/tTqxP79cPTqtIpzy
         ORvL+z1kE7Id2yyRqtQaBfUgDb/O09vd7xM87SMDewq1eVhaK5buWHXco0q3f8ToX0QA
         YeL6j9BKkbMUK44HnixXX7BCwrwXTRVd30yizt99gbiA0jwnhxMdiQW6aVsNOBHf7ma+
         Ucc3wRqvvNp3TG3xevAX6NXNDxVU3jaSEr4HbbjIZ+N5wWngpuPMnZyAMZr3+UudrdJC
         VIVg==
X-Forwarded-Encrypted: i=1; AJvYcCVhVmDmSQ2KMHpxBYxdriJHvr9fH2iAn9sONTzonyp1oibTuEjEq++sueQZksn2Qa50+VWNWH2rO8Xec3ZBJX8dSnp4xA56bB9IKHHk
X-Gm-Message-State: AOJu0Yy/29xYyxRcPnVKPvge/UF/Eq8C1B1WU2M2L3FCU81tDzQX1IDS
	RD6XmzPFByeH2CqySuxGKMu2c8JYo5TU9a+AESsSkM1eH5hD5e2zpGEvLoQm6ZXglEl8lHbcY6q
	zOTowP3ul4Qc/Jx7o+QVyu3+04pp2gDtDcVHM
X-Google-Smtp-Source: AGHT+IHGZfGOFMLPDtfPud/GsrF7tdooNnrZe5MoO9klCGmWbiy/B/k6yjkc3wPHejQWyh/ZbyKrPPcGutS3l9Xw+Rg=
X-Received: by 2002:a05:6402:4304:b0:572:7c06:9c0 with SMTP id
 4fb4d7f45d1cf-57311c1506amr107766a12.0.1715037053475; Mon, 06 May 2024
 16:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501180622.1676340-1-edliaw@google.com> <osgrbhnqlyh5yw4y4x6wjggx56dogsgje5yy3mkpu75ubs3zwg@5tliydzky37k>
 <b55272cb757743548c789aa8c0efa448@AcuMS.aculab.com> <CAFhGd8rAW4Mkctq5VkcfVjw_yr=jVdXaWbYXP-vmeVpw7q4ruQ@mail.gmail.com>
 <CAG4es9WYrN_tOV1Uxi_ytO2qDRRZW5_uN=2p3iCg=P0r3mM3Og@mail.gmail.com> <7332ff979f3440bd8362d37d4d1f34b8@AcuMS.aculab.com>
In-Reply-To: <7332ff979f3440bd8362d37d4d1f34b8@AcuMS.aculab.com>
From: Edward Liaw <edliaw@google.com>
Date: Mon, 6 May 2024 16:10:27 -0700
Message-ID: <CAG4es9Vn2F34UEmyG3upO-frtCZ00DVN8vgK4mRfX2548FKxVw@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/vDSO: Explicit unsigned char conversion for elf_hash
To: David Laight <David.Laight@aculab.com>
Cc: Justin Stitt <justinstitt@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"kernel-team@android.com" <kernel-team@android.com>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 12:32=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
>
> That makes a lot more sense.

I sent v4 https://lore.kernel.org/all/20240506181951.1804451-1-edliaw@googl=
e.com/.
I updated the commit log to reflect the change but I'm not sure if I
did it right for the mailing list.  Should I have added --in-reply-to
this thread?

Edward

