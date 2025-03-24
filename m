Return-Path: <linux-kernel+bounces-574345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5601AA6E43D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEEB3B4735
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260A21D6DB4;
	Mon, 24 Mar 2025 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOuCnQFs"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB6C8634A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847729; cv=none; b=drpAA6K6coSUHywQoz0EJqvPsyh2NJxC7UZIdOVRSWuwUVoZFSfjOooH04Arw3hqcqa4sNgQaUPLyVoUp00eFi2ocTXrwJgKK79vSUh+LAL4hd2Emqb2HO++ECnHTNF+tiLdIveWL3+nAlj7ZybNkq3lqwbnXApK/r1crCxIWyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847729; c=relaxed/simple;
	bh=FztcM5JzPEKSfZfhduO7XfHyNElQhOvgkbtRXZ7IDQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqJeL9dbUbvYowG9hXxrO/b+3OweWtVHWi+oq3qNFmzgMtZmKem6YV1jp9Nsu962OuiP9hmL3bJyFddzPFhJkAQjppTXjJB6cOtd0MuuOt0a9XVCaSLsMn8q9z3m/t2K/s0tCpv4avFQY3wpc4cEvxhroDEXcC4PiwPJsrOxT8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOuCnQFs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2263428c8baso13835ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742847727; x=1743452527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgVH1mDvEmNxyAJr/MBXbYbtV3ceuotfIxoUXuGJIzw=;
        b=hOuCnQFsd7Y/3w9j5F6O0zU8E45BrGrkt9jG+RHfPcoDQHEWALxVnJvp5MG/M+rTn4
         fId5nMBvGf81Fca3X+I5MBD+DXxr9aQ+Vc0aP1vPVIuTwi+IgNccscpFdr0v0IBF5B6W
         JagSxwgZ0ISF99YhLls3LEL+gDfGUH0qlPekuahCm6iPTeyHEBHVOH/xPs7PZAj6s+Th
         lQfDhZyCGV77OKsxFKfAb2lkOLbbzSNEkMlGVW1Wpfp/BhYPljzAfIQrrUjQCdMRGybb
         1842DCXwaqpSr8lYqooEwjS23NW1i0Aufic3VbxYq4XgxgBgLhk/o8Dj4OZ3q0MSS5Rv
         I8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742847727; x=1743452527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgVH1mDvEmNxyAJr/MBXbYbtV3ceuotfIxoUXuGJIzw=;
        b=CWBEF/cCkJmm8XUsbB6IEJDdI/uoG6vjLmPf2qC/D37vBMHyhye+jUaEI5PsmU+dwK
         tu2k2sXxh6d+24cPCBkhT/uT6XCmozejC4mTPOZa56bNFMjSwdccZbXEzDcXQb67OjGi
         7jbrxsusF4usRdT/zT8hj+fZU2l6MYpGIPDBimwQkqDxMn8BAFnBmncGvap+sucJySnf
         RZXeMMXcR19bZ9N7K5+K9EoninE2uEg6w2VrQ43+wyKnx6JaTpBT/bAWQnQcmatlGj+i
         LSeniECQ+EaoOtwcSQwKptAK7RKp6xv4HVFIlc3w5kab7NydOMjfUVfU4fSca98og/xA
         YfTA==
X-Forwarded-Encrypted: i=1; AJvYcCUwsPYnMrxKXrJNkdMhMRBzZKTxtZG/fsOJ1usaf1MNXGK3pbsjeTbPxGbzCUCxnhVVkfkpcEuuTWRkCAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5393k4wb9QyaDFbCnWz+zKd+Au9fahT8/BP/BSALYuhmj6Ylm
	f5GIxRKvU27mqhwG41+2wkGLJqLTO3bDItux7/zg6Snaeq0wILtCS6Du0siAQSDIXhxVNht8Xyj
	r073fG0gkk4WlYrGoGSXbObO+IVs8fQwBWCRGGj2ho6/IDOEfucxOhGI=
X-Gm-Gg: ASbGncvUh38NgAIn1u8v6ob/fvMKoorj+JLPCJV9B3Z7vQq/33Cc7InV5mUZoNpSyot
	AgYU8wArjzoRuf/i0nYxhyZdNF50StVBvOJX7+HS/iGZmf52UAKVOHYLkgmGE1aC0jka3PuF6nD
	YYkry1VCi7LpJI34HWQgaurgfdjelnTusk7pu7UHdNk7HUmIBpBHJj/wGH
X-Google-Smtp-Source: AGHT+IE4W70sX1ZkRQ/GL3sVoP5yTJpDgVL6YqdtpN5lSDwuzj4TMC8cSgGv0xiX+YNWSSPMj8XtcM3NbtNq1FWi1P4=
X-Received: by 2002:a17:902:f647:b0:215:8723:42d1 with SMTP id
 d9443c01a7336-227982aac1bmr6151675ad.10.1742847726910; Mon, 24 Mar 2025
 13:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309084118.3080950-1-almasrymina@google.com> <20250324065558.6b8854f1@kernel.org>
In-Reply-To: <20250324065558.6b8854f1@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 24 Mar 2025 13:21:53 -0700
X-Gm-Features: AQ5f1JoDwr-hcxtVGUvUER9Yz8iKDA7P1EW26_KEBix0QH-PaONcGrT5CHee4uE
Message-ID: <CAHS8izPTxxcQog3yA=wSyTn-B6jT2U3KsQDzYb4LDW546=uoDg@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v1] page_pool: import Jesper's page_pool benchmark
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  9 Mar 2025 08:41:18 +0000 Mina Almasry wrote:
> >  lib/Kconfig                        |   2 +
> >  lib/Makefile                       |   2 +
> >  lib/bench/Kconfig                  |   4 +
> >  lib/bench/Makefile                 |   3 +
> >  lib/bench/bench_page_pool_simple.c | 328 ++++++++++++++++++++++
> >  lib/bench/time_bench.c             | 426 +++++++++++++++++++++++++++++
> >  lib/bench/time_bench.h             | 259 ++++++++++++++++++
>
> Why not in tools/testing? I thought selftest infra supported modules.

You must be referring to TEST_GEN_MODS_DIR? Yes, that seems better. We
don't use it in tools/testing/selftests/net but it is used in
tool/testing/selftests/mm and page_frag_test.ko is a very similar
example. I can put it in tools/testing/selftests/net/page_pool_bench
or something like that.

Also I guess you're alluding that this benchmark should be a selftest
as well, right? I can make it a selftest but probably for starters the
test will run and output the perf data but will exit code 4 to skip,
right? I'm not sure it is consistent enough to get pass/fail data from
it. When I run it in my env it's mostly consistent but i'm not sure
across evironments.

--=20
Thanks,
Mina

