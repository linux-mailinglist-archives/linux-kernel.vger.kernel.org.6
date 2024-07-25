Return-Path: <linux-kernel+bounces-262473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579F93C77F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79541C21DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79FD19D891;
	Thu, 25 Jul 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VRsW9J1s"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F031F1B812
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926986; cv=none; b=m31yRTHdPAj7cIYN4ifjXRdVveyILcNPvb9SkPnM2m4ppoae0a4HqDfZvYatv5QUe+W1tkQptrzUim+woL7t9ghaN3fkHlpAk1kH9pzmN4Veu8FRka1aWWehoIiRjQoskwWwn2bySxX9JWbHEWUl2aTv6edH/oaWNZE+Trqr5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926986; c=relaxed/simple;
	bh=ShgQ0JhyjtWoViG5e0U/sbL9/kIAuqN/XlVVMl12WLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1+4P8EgZ9iXtwMJ0NdD8LWr4KWVos8ba6U6o7B/zY5j6RQvh12DWTK36edii0c27Vsda71O/9aXQ1U1+zf4u8Gl6Dzui3HlP4ME4FLSWB2td0PoTCzjGlHRxPPYpagRqrBlfahRtsALo/OaJbBSeT49RYDolYXUlqqTAeEUFig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VRsW9J1s; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so91099166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721926982; x=1722531782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uO1vLwT5TgmbirPBYsCNupkLZDUfDp6exkmMnd87h3E=;
        b=VRsW9J1sQ0F7XKUTMWCZXQII8kkfwMgZVIj7AocdbumVdJMIOZSHxkhDlfV0VSK+HO
         D0IyMBA6jV5Yn8umn3kP+jUadieyXlc85bnzFg6lIGT4fCG3FfhwQa81EJAFpka4pOjm
         ByqjMSJfpbd2F/Kx4Pj1GOQkTb/2FESVLA2pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721926982; x=1722531782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uO1vLwT5TgmbirPBYsCNupkLZDUfDp6exkmMnd87h3E=;
        b=SXaBvf8JIo+y6ogs5rTbNDwzUtDrC2br9AxLahwIcwWdXgpM1qQuP7YbJ++szZLm3I
         9D61nyOHqyDBfcUGZeeiP/yWAyVBkmqMaPQ8Oi8b7Fg5PiG29DwvCY40ikQEGOrtzOox
         jhDWHnPGFYq9o+tyQGSyQFJC/GxDnrA2RTWNrHWwLIBEPcPhbqQPY/02qj2+aQKCmm6b
         FBETe5JyxLRutmIL5PoTEf9JsFFF8KSiT/27OqsN9EBAgqMFScn0iWlIJ/okeBRXCnq8
         MX6cpPeI4h0N+Hik+LIs6/DKs6b/rw6i7s9a7vcceeZ+drGZYjo9/DfenJ7M1BLZt9Rv
         HaXw==
X-Forwarded-Encrypted: i=1; AJvYcCV6RgvioGVUzVpDUq0zDQmyup6d2QaMHarAQMegjUtUuLoj5pdFyT6N+ASvPWHuoM3V7K5q4dIkdkVx3sb6vTnLWHwX16jHmlDRDA9z
X-Gm-Message-State: AOJu0YxfXDXfSiUnVHslcuBASeEqBQj7I6sIhxboUQH8Ae19GiY2zFsQ
	1ejuFwWaCwVhMGsxgh67qQIYAkLRk1S23kMczqoy9RtsIXPw74d2wF5U/Cknh0Ot3CrfRJ3wee4
	SIYk=
X-Google-Smtp-Source: AGHT+IFKNSSoFuL9obl9PQkOhESa7WXGl/uUrlpuTbRJUQ4RBjGiZFCxFqIDugEE/As3oE+JPuPMVA==
X-Received: by 2002:a17:907:2d0a:b0:a7a:a212:be48 with SMTP id a640c23a62f3a-a7ac5087e56mr275018966b.56.1721926982013;
        Thu, 25 Jul 2024 10:03:02 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb98a2sm88810466b.217.2024.07.25.10.03.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 10:03:01 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so1575855a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:03:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWK6BiCazU5zStO54xtCdEhqUQjk72+YZs5XwC4+QlH73K5JWrl1Z6nodHELtEOgYdrCmyfX/4TRYyxqyMHtIFH3H+EzPFTaTvcIGmE
X-Received: by 2002:a05:6402:3587:b0:5a1:c43:82ca with SMTP id
 4fb4d7f45d1cf-5ac2c1c73b3mr2343280a12.26.1721926981090; Thu, 25 Jul 2024
 10:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <03601661326c4efba4e618ead15fa0e2@AcuMS.aculab.com> <ef130c0a-b82f-472f-8c53-f7ef4c236c44@app.fastmail.com>
 <CAHk-=wh_+muDANgpjC6_31QMh4OnKEOgbZiD_MymHxAHRZRyqg@mail.gmail.com> <5a129d04e0b84b48ba6c5189a047ac8f@AcuMS.aculab.com>
In-Reply-To: <5a129d04e0b84b48ba6c5189a047ac8f@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 25 Jul 2024 10:02:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLcr11D28vu2NotZYn3GNH6BCTK57Zw4d4v7eut39z=g@mail.gmail.com>
Message-ID: <CAHk-=whLcr11D28vu2NotZYn3GNH6BCTK57Zw4d4v7eut39z=g@mail.gmail.com>
Subject: Re: [PATCH 4/7] minmax: Simplify signedness check
To: David Laight <David.Laight@aculab.com>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 02:01, David Laight <David.Laight@aculab.com> wrote:
>
> The condition is '>= 0' so it doesn't matter if it is '1' or '0'.

Yes, but that's because the whole conditional is so inexplicably complex.

But the explanation is:

> That gives a 'comparison of unsigned type against 0 is always true' warning.
> (The compiler generates that for code in the unused branches of both
> __builtin_choose_expr() and _Generic().)
> Moving the comparison to the outer level stops all such compiler warnings.

Christ. This whole series is a nightmare of "add complexity to deal
with stupid issues".

But the kernel test robot clearly found even more issues.

I think we need to just go back to the old code. It was stupid and
limited and caused us to have to be more careful about types than was
strictly necessary.

But it was also about a million times simpler, and didn't cause build
time regressions.

             Linus

