Return-Path: <linux-kernel+bounces-306234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C02963BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE161F210EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402A7158208;
	Thu, 29 Aug 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nX0pz0CI"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1AA132124
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724913140; cv=none; b=im/VvSzXvvbsk3LC0LPO/YwpCVducD8jKS9RkhCCGTxd33q9k8JXxLoHA7Vr8jg/ysoGX4U6ZKn0JgESzEpPjExVqQ0rWZHHrrVSvwU9QPxa56F+tRqlqwRsjRNyWMIkVbLtFqloNNxPx34s2gebG+MGOqZGucMv7X43NaMxSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724913140; c=relaxed/simple;
	bh=GUoe4R5n0pDxD2C1Es3g5kp8GiffOjVUblfHh9WwSvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnxiILZhA6UefwU8c9nZKbybFd1pY0eJ9cwVDp/fZ3zBq9RU0OZ1sGlLJ6su9NW9XkSXF+Xw6G7SQ+0O1yJALpnwYQFXsYFW/QHfVR3XLPmHKO21ynK9trk00rZbfROoNiB89HBBu/RmqtZlU1YvWu/qfGNZ89akWtflrpjO2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nX0pz0CI; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d2cad030cso134555ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724913138; x=1725517938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfgIRxVT7Ef98/Q8EkLzF2XWR0ePSyt/jN1rlVa3xyI=;
        b=nX0pz0CIM/GgbE/c+pmu8ehUxzjv9RCzSBCqW+k5VzLDIRt/20ZcFcHhrO4xDKl8wc
         6BRllEG9gtDeRz4tE/vA+v8hwR/m6l2SaZ8VKZ6zEBkRtyeEUKha255SC864goJ3ttzI
         P3FcBEic2FIiFxJrcABUF2wCFx5GWooc57iaWvbswoCEz9QGeB8i+Eg8zUJVx3ueOX7o
         bT7H5v0Rr9C/4nW0E65siu7qwMgjiRe8EerkMhW+EaClCdaJDLZKxL0g1MtJqqcsl9ty
         p6i+hh9ojSuG9bhq0SclloyfhwCHh7PBielTAFGVFFJQMhJ8kMk+2IXmA9iyEYxpEmz8
         YITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724913138; x=1725517938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfgIRxVT7Ef98/Q8EkLzF2XWR0ePSyt/jN1rlVa3xyI=;
        b=wNGt4h1pTbrpsKJyGz87T1CORQaiAZUCbd/HqwWKuIYrQq19artFAXKGoPhih20XJm
         i7vObnzSLIC8ujGq3tJ0fhXp1ny7KGsPxLIAWHyIdbDyJ6pNS1zKceqjQFLLKfwOnhqQ
         oRGICJhwp0cY6azKzg0+nSBChyWJGgfTfv5m/lQyiAxO2Z4eXq4RbNG1yTcoNuClhufN
         XvjD7XfV7qATPlLQ7TgeOmXiAG7biw780DhGAAHAigg0nN0UY2PEXCpvWGzDqug6WOy0
         M6cAyI1wiqpD7qTqafc4OvdHQkUTyDYSoDDzbLZ8SVAsLoDlcy3pGnCsYHrqnSShmWTh
         pvTg==
X-Forwarded-Encrypted: i=1; AJvYcCU0G5QMfBDbN3+JqjSbjnUeUweyL5ohPEpn6P4aKhWgTPg2WGCSnh9frY6anacyzcRjHQc4nL/MLnB6w0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFVyP4rUuYLNDVJS4cWcW3eFQNlTjxNc5i2xBExGcNeCTS6hGx
	noVDFWUW+KUXCpe+Hjz8yxH1mloixHEqg+OS1s/Q4IwNS+DzwsTg5A+u7whILgUKS8g5QX3sjtt
	+vQpAm2G9APyYm1arwQuHEqzaoRlgjJK0QRkQ
X-Google-Smtp-Source: AGHT+IFtCfsrhtn8mXjAs3tCgE4MVJvHd9sd/dkTW88EJFAO+M8DVX6ODJ8YaQB1sYLm4W/Sl49nSmqVKG3pe13HJk0=
X-Received: by 2002:a05:6e02:1d12:b0:39d:3c85:9ba with SMTP id
 e9e14a558f8ab-39f3949bb1fmr1622065ab.15.1724913137935; Wed, 28 Aug 2024
 23:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zs-gjOGFWtAvIZit@x1>
In-Reply-To: <Zs-gjOGFWtAvIZit@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Aug 2024 23:32:06 -0700
Message-ID: <CAP-5=fX-Viz40=J+WQTT8PUDQ+Wtsj1sjA5ZPTxXY4eZo2eXUA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools build: Remove leftover libcap tests that
 prevents fast path feature detection from working
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:11=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> I noticed that the fast path feature detection was failing:
>
>   $ cat /tmp/build/perf-tools-next/feature/test-all.make.output
>   /usr/bin/ld: cannot find -lcap: No such file or directory
>   collect2: error: ld returned 1 exit status
>   $
>
> The patch removing the dependency (Fixes tag below) didn't remove the
> detection of libcap, and as the fast path feature detection (test-all.c)
> had -lcap in its Makefile link list of libraries to link, it was failing
> when libcap-devel is not available, fix it by removing those leftover
> files.

Isn't the feature test still in use by bpftool:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/bpf/bpftool/Makefile?h=3Dperf-tools-next#n103
I'd deliberately not followed up in removing it because of this.

Thanks,
Ian

