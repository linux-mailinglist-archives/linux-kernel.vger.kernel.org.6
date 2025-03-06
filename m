Return-Path: <linux-kernel+bounces-549771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7744EA5571C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD3D16E687
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D751D270EBF;
	Thu,  6 Mar 2025 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U/CyXPeL"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131918B47D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290613; cv=none; b=a8EAg0UlrNZ2qGtI4yb/2DpfcwMiTbrI/KT5WE3arKK0BEkxeOjQ1VsnFpJGeEVeAbVTY7cKXpv0+cGuHxt6HHgJHKamWUrFAOva7HA/wZxQlRdM6XW3HqtPVz2OcOI0FycEWJSX0SKRoJAXdiB5rAXurewvZZiYVoQNsjag6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290613; c=relaxed/simple;
	bh=SeYj+5vmQMk9Qek2o0j+zoxvhCMdTopO/yz69EP+B5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qhcgzdcfysm6h2rOxIl4fLlQxsA6jns8FMX31KM4JCorYOh6q8k1tnJCGZebSZ3rS136+Yea0uoHzLNG7CHUambsROFXaL3FhuV9Fn/Zhv2e2t+c3cDTz+FJNGzc1LgFBiIJ8eT/Wkb4FgD5x4MHf+Qx28+2pDF0pU4AS05qSVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U/CyXPeL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso1801682a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 11:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741290609; x=1741895409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5UzXSAjCTYVMhmStXClPBVrbuKzccqNEtXPxciKvgg=;
        b=U/CyXPeLw37zbeKGg4GBk9NtEWOj9VXAykiAWOyYZeJ92RZSOTuahf5g4qSKZI6TTy
         FGV3uBbnV7Nm1KzyXvhd9eG4echjxN1wq0JWST0rHlC4egzt4Y5PNyFqE1eXnQB1aprh
         iZXMLYeLvgz3p7rHZyAU1TwFjGELFmYcmg6bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290609; x=1741895409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5UzXSAjCTYVMhmStXClPBVrbuKzccqNEtXPxciKvgg=;
        b=iN7XfeAvWQcVVPBVRvR3w4w9Wz400zagWgSLdPrv/LV7ZrSRJvRaGXeM1gqanOYlk1
         8b1kX7N4uX0txSWCdFh12fTcUblorMrTIIX4vi9/uNX6qeo5zT/nATuV19mi7nXIZbeP
         gbr41I7XP6rQJbDfO+xX2YVwoDuKa0Tuq8/6uVJ93hUsiMH1GmSlWkEjwvevIyoO8oye
         ePnWx45cdw6dppnXEWY7+VArAW3Xaai2LWVbuK+X+OJIKFYu+v8PfrfLJabr+YYdUoSJ
         xIERgHNN46/Uuz+Bk+GnoFEc2PwpZhcGeAvKeuY4DyTUlZ8U+Q4WsLYkbeD7D6yuNLr/
         ybuA==
X-Gm-Message-State: AOJu0Yw0A9uNfxAEA2IhEwP2tNrQD/DVpsY43QWdBgEDC4ezOV/LGLRg
	uLSa+QwijJo1y51e+lzXzwDtzJkmUN2415sionCI9k53aL9D7lQ1RtXeVFNg9y/GaYlF4x/kYgW
	XQG4=
X-Gm-Gg: ASbGncsgTMB48bfKd/ceaJlPcasThSiwaRIfq3C6GsDoB3xQWNNF54gJ4JaQOmoD3go
	LdkT9G2o8EhZe1t2iObW8mO1Rt9CumpOHTtD+JhC//II6lJg+ye8oqd24FEnu5sesi370kW8aQ5
	vTReWuZiJWsQxS1FxOQMAzw0QIafU51G6VKuk5C71ydVRgx2ICUK/1BWSKCKjjG6/1ti/wuJzjl
	tjkPlscbaKAzzhOLneUQLmC+8Nlv0zFQmpCNCdYHYc+LjOFNqXQDuMA8xcJ3mhuoDzH8hdnV9k0
	RcIjgiCEbAqUCwDUTQR08deHkJGWCfM00jU3goMApKgp/Y+JrBtSog85ISV9wPWOE8vWoVcRbEc
	sBRxnB0F82qUEUVu8lJQ=
X-Google-Smtp-Source: AGHT+IF8TdYVj78+9MQ7qrZsC6n2nepy0y4GvQ8CeVFo7ruUNf3dbFqxobv2/pji6RAAs0Fpaf/T6Q==
X-Received: by 2002:a05:6402:1e8e:b0:5e4:cfe8:3502 with SMTP id 4fb4d7f45d1cf-5e5e22d90e0mr545016a12.17.1741290608818;
        Thu, 06 Mar 2025 11:50:08 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c76be409sm1368778a12.81.2025.03.06.11.50.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 11:50:07 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso1961577a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 11:50:06 -0800 (PST)
X-Received: by 2002:a17:907:9455:b0:abf:425d:5d3 with SMTP id
 a640c23a62f3a-ac252f4b12dmr39156866b.40.1741290605907; Thu, 06 Mar 2025
 11:50:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306092658.378837-1-andriy.shevchenko@linux.intel.com> <174125602814.14745.12946945836213678532.tip-bot2@tip-bot2>
In-Reply-To: <174125602814.14745.12946945836213678532.tip-bot2@tip-bot2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Mar 2025 09:49:49 -1000
X-Gmail-Original-Message-ID: <CAHk-=whTGVy1aaEashu3K49wuG7-hARh02xbAr_hMm3844Ec7Q@mail.gmail.com>
X-Gm-Features: AQ5f1Jrmr_jLOp0tlshhDmwAms2O84ODqe4i1s4V7Wh5J5oNtXIjYzua0O7oZ3M
Message-ID: <CAHk-=whTGVy1aaEashu3K49wuG7-hARh02xbAr_hMm3844Ec7Q@mail.gmail.com>
Subject: Re: [tip: x86/mm] x86/mm: Check if PTRS_PER_PMD is defined before use
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 00:13, tip-bot2 for Andy Shevchenko
<tip-bot2@linutronix.de> wrote:
>
> x86/mm: Check if PTRS_PER_PMD is defined before use

I'm not at all happy with this one.

> -#if PTRS_PER_PMD > 1
> +#if defined(PTRS_PER_PMD) && (PTRS_PER_PMD > 1)

Honestly, I feel that if PTRS_PER_PMD isn't defined, we've missed some
include, and now the code is making random decisions based on lack of
information.

That's not correct. You can't say "I don't know the size, so I'm just
assuming it's 1".

It should always be defined, because it's normally used
unconditionally (just grep for it in mm code, eg mm/pagewalk.c:
real_depth()).

So the undefined case really is broken.

It should be defined either by the architecture pgtable_types.h
header, or if the PMD is folded away, the architecture should have
included <asm-generic/pgtable-nopmd.h>.

So I'm *really* thinking this patch is completely bogus and is hiding
a serious problem, and making PAGE_TABLE_SIZE() have random values.

                Linus

