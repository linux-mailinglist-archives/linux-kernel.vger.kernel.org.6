Return-Path: <linux-kernel+bounces-252864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A65931915
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088C81F21E65
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AFA481DB;
	Mon, 15 Jul 2024 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LULeNhZD"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295B2421D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063863; cv=none; b=GGVUwcefEb6MkW3CN3dUi1BwhGkhi7yIzm3flrZJnn48xgxBOMxhys15DpzZB0lfuqg1ahDjAVBtHcAberHmXGHd4AqXalcd+dcItO/YUg/oZfhISiDRBjIRjWqY9h8eL32MPQGAGHvSVFYGP5eWYgQxLb+b1xDSWk00Zlqvf/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063863; c=relaxed/simple;
	bh=3Xdjfs2V+VOJTStsyE/c2aZasIGokilvafa0s97/5rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQJcG3XI2RVk3NLs5F4q72YUS3McF9cyNUzlnZ6r72Bs40rCIMmObdSdsrk7rjCS29dU6KjoWgdN4HBFsh5qKGJhJiwmOqXvZftIgW/IbHZ6xbABiwadXYClg9jdIW7rul7KCBLAdNNdDyhMLxdrfUw7AREznRBbRGjtw1EfsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LULeNhZD; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-447df43324fso16541cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721063861; x=1721668661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Xdjfs2V+VOJTStsyE/c2aZasIGokilvafa0s97/5rQ=;
        b=LULeNhZDpjm70ZmbpLcvXYBPYIUGtOVVVl/sJFWaScmhJ/Lag0Std7XEYbpo2R1LwW
         j12syBqGNu0ODH6O23KUA9RjGtXNzzvUAfqyN5QkMh5gTVAD/MOodHIry6XudcxUaWR+
         V8IjklYOMQOsEIDa75xZ+mHuVyEgyAhPrjVlCv4qmmugu8vhGpW3YyVwPsqw0IT5ixSj
         Hm5tKVvEEcd0dtKCJp/sSRYuyCeGBKovsrKQOzw+4+IJL1yQ7Ey+sRGZg7yy2nHpVTQs
         Dvn53RlSZmSDl8c8HBMQRdA8k3M+UBVnOSpE8iNMRH7z4zks51wvWw1ssKmf/0/DBaIX
         yOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721063861; x=1721668661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Xdjfs2V+VOJTStsyE/c2aZasIGokilvafa0s97/5rQ=;
        b=FArgJbORsPmRR8ot5znyiZd0GS6pmYJHRwoohD+CXr/Yy4QVo+NovnXn4ri7aDqKhP
         R2IGwMVgUSztKfUyuxUEvc4jFC9yo/NHrXVDYhrx+PI9+3yDZjAz9oQvnMik9ppq4jEV
         Qt4Jq9aLNY1a6TYDzZ/MQwXZ/+TU1zTKQFVQdKKo1YqyUZMQjHilR0dgGjVNyd51qMXM
         D0P9mfcXx222Tsv6NfD48/4TbqRh8xl3HyLmG8ZSjyaMmEr5zlq9vZBamfpYOEaUpUH2
         v9lDwp7EpyjQeDtN8J5EN0kNsGrwIVU4NHOH0rA8TBiHXSLkx/j1XjyAbu5a68UcbWXp
         caeg==
X-Forwarded-Encrypted: i=1; AJvYcCUDHBqqrWlvtI/jFJvn0CGDzbdHFtPTreYnJh9rh/tVWY6VGkcfmAPbpU93K5VfB/OGC2KRPhgYtMr5jNHg3XgnkIB/daTNFZ6EH5KA
X-Gm-Message-State: AOJu0YzbvLng5SchDcdGQkyvaxZSqM6rqy1o65vGhkqEzu9hZ/JrfIU8
	XxJ7FiomgU5/vMHcVBlSIHTkyrJrgCUp2d+AyUroplPyuhFV0CcvIRqy6SFSHPCdo/ojAgKqJzN
	grZwwE2TIb1wsLlRW5+TcL54pDJKwsMtE67LD
X-Google-Smtp-Source: AGHT+IFb9zDvvS+Vrq10c6cOTFR5NGs6k7iU81Nxww3NB6dawWRh5ZhMk3ODOFenXm5ITfakyTbHjYhL+6IvKAzBBiU=
X-Received: by 2002:a05:622a:510c:b0:447:dd47:dd5e with SMTP id
 d75a77b69052e-44f5a2cce51mr5609411cf.14.1721063861071; Mon, 15 Jul 2024
 10:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715143342.52236-1-leo.yan@arm.com>
In-Reply-To: <20240715143342.52236-1-leo.yan@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 10:17:29 -0700
Message-ID: <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
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

On Mon, Jul 15, 2024 at 7:34=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
[snip]
> +Android NDK compilation is deprecated and no longer supported.

I think this is objectively worse than just removing the file. It is
likely the perf tool can build with clang/LLVM, I do it every day, and
the special case for Android is likely more about the libc (aka
bionic) which gradually over time has been becoming more full fat -
perhaps we need to carry somethings in tools/include for missing
definitions, but we build with musl and that's a PITA in this regard,
we've also been reducing the tools/include dependencies for perf trace
beauty support. We don't use ifuncs in the perf tool (Android's
linker/loader historically hasn't supported these) and the weak symbol
games should be okay and something I aspire to make less in the perf
tool over time. As Android uses Linux then it should work and should
be supported.

Thanks,
Ian

