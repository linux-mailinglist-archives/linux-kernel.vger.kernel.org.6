Return-Path: <linux-kernel+bounces-253011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C803A931B34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023FD1C21AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC2313A3E8;
	Mon, 15 Jul 2024 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXOIM1Ta"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E7013959D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072700; cv=none; b=Wt4kSuoohgCKx2XvbD333qK1sjXB7IXzDMvxeZUl/31aW194Tg8vM/1iFFOnrpd1ZJdacrLfaPkWtV8016TcZFt2+PJhK03D3oBZ0EsQ7alCB1DzV1lT1Qfhv2JuzgpEoTFvtLk8QckUE+fgyz4mPxuKCzMz4mKjxERSLzCV1TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072700; c=relaxed/simple;
	bh=nGUwBIX4yxw7k/f7GbN0ZTgpL1uP9fGjMbhZIFFzJZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaBuqBjLoqTQtrL1M9x6ZQQDrFeWxvAuWn05KT5xrFYNn+8M096g2NdfPPKJCpvklMDNPATX/7vZsiyoJp3tWaeSrgmMoGgZusutN2AvteAQ1qDT6A3iWF7QvJJyTkdd3uz1z0hBJx+ARcOWvk6pWr1nvNPQFmJMXPKZo+yKT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UXOIM1Ta; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc312a36f9so44635ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721072698; x=1721677498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+hvk/EPFM/vKFN4nzaGg15TTdVUT+jO3pRUPZO+dik=;
        b=UXOIM1Ta+hZWZNgd7kWQcj+fjrhOR7A1fSIdFjQdrxssIV2QHKhjRHi8F4O15dkwvJ
         GOC653d2bJ4dLPBuSJhqCWR1oY4o4NCZKgITXYkAQk2xmt97myY3JyJC3vRuuL8miQhy
         QuFnpiv2/VOvl3u/EA4dxlUfuoTfKE0iQfnJFo+FzihdRmjnNUnDUOAY5U44QJsV1MMB
         X6DVolYGCPUFLpvmIyMVXJI2OdhqoXIOX0XOVbI6qxjJfPcrrrKnJU2WOT0uwP/5mrmo
         8/+NUQqaGT9cUiiEFpuKFqzR6CZoEiKIy6nTJ0IOv9xywqbLbjph0O1zyjCSYOYHfwf0
         nisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721072698; x=1721677498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+hvk/EPFM/vKFN4nzaGg15TTdVUT+jO3pRUPZO+dik=;
        b=eSZS1osq4xjs0F1C4ITpzFdyUPiHhwbpJo+5Ndg+fP4hp/dsBBRrCrGdS2Vi8o+u79
         1ALX+f5onRXUfDqOlIvV2ZgQR61cUL4BojXjaQb3xuYk8gQc7rDmxUmhJe8Q6NCRvPun
         C5VPKP+x4/LRZyS8k5is6Rv8Eoh5jYNDEaz99TNSeor5hLC54z/cX41ybeE/mtjrFcv3
         1VgVz+m3F5EdU1rOKYX+XbGn2VsazBz9sKkzOq/RHrfnDWB8CMsb08HU1Yn8WbImHlZJ
         crJ2I2k4+mIoH32cj0MhiI43t9LuMacZZ8X87o0hRZWMic/s9wblpsX4OpW2NYGJVqYJ
         J90w==
X-Forwarded-Encrypted: i=1; AJvYcCVhuxBYC9wkJ7TkBc5nad3mQ3te94grKEkDsgRtPPFMD7Abe3F05TFsJpFLY/RN5wtVz6V7GQmNnGmJX7QTA3NVhKOAvoq+6EfE9nU/
X-Gm-Message-State: AOJu0YxT1rI9j7NsV9MkcSrREJQLNuIFZg6zg0Y6Cv9eVQKLrc8JI6zT
	ZOPqaUbGCn8a+w8O9RFQN0hl0hcUKDOpK9L+bWs6qhBFr0CuqPxgdj9edUxLzRBrx62k6F1UX4m
	CT+DWE8Ndkk0KYrPGyUdQpMJG1cDaYT2CM3YW
X-Google-Smtp-Source: AGHT+IE4EB9vKEq94MiOkEyx5kP827nITZnnvUgEfHJR69nSKAKd/6X97tBIk/65VNSmjHDCgSqJW+VQza2dJRIthyg=
X-Received: by 2002:a17:903:182:b0:1eb:3f4f:6f02 with SMTP id
 d9443c01a7336-1fc3c75117amr624705ad.12.1721072697879; Mon, 15 Jul 2024
 12:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715143342.52236-1-leo.yan@arm.com> <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
 <1487da55-24dc-40ef-a6e8-4bf4b153fdc3@arm.com>
In-Reply-To: <1487da55-24dc-40ef-a6e8-4bf4b153fdc3@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 12:44:46 -0700
Message-ID: <CAP-5=fUGJmOr9XcsVWWCREjr1A7rUFaMk0VPkQAKDAEjTLKJVQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 12:31=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
>
> Hi Ian,
>
> On 7/15/24 18:17, Ian Rogers wrote:
> > On Mon, Jul 15, 2024 at 7:34=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote=
:
> > [snip]
> >> +Android NDK compilation is deprecated and no longer supported.
> >
> > I think this is objectively worse than just removing the file. It is
> > likely the perf tool can build with clang/LLVM, I do it every day
>
> Just curious, are you using LLVM/clang for cross building (e.g. build
> aarch64 target on x86_64 host) or just native building?
>
> Clang/LLVM is a natively cross-compiler [1], I installed Clang-15 in the
> offical package on Ubuntu, but I failed to do cross compilation with it:
>
>    make ARCH=3Darm64 LLVM=3D-15 VF=3D1 DEBUG=3D1 -C tools/perf

So we're cross-compiling in bazel, so it is a different set up than
the makefiles - I'm happy to work to share the bazel set up if other
people care. I'm having a play to see if I can get the Makefile
working, my first attempts are clearly mixing x86 code into the
supposedly arm64 build, which would appear to be more of a build
system rather than code problem.

Thanks,
Ian

