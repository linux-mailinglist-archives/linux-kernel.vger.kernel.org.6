Return-Path: <linux-kernel+bounces-566571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BE1A679F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703333AB15C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBD6211477;
	Tue, 18 Mar 2025 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bOJtO65h"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4E210186
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316106; cv=none; b=FqznHvCGrp+kMN89JTqBVwh+6MczEWmq2W5r7SGL02j/UZCqQSEtaHpajO2UFSvpwJuo39frcEFPdOTS8DY0hWkAWjDpIPhB9VtCCJfdZJCCBJtzz1W3lpn0d2QinjP8HQX8SegRsVgOKNNPz7CyaTlC/15XLPD/LPhxKGJlxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316106; c=relaxed/simple;
	bh=+CwDqE0Jy7xemprqpdbhN6+eMuZiaFCKAqG81f7NNf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HG0/dlKlT+1U3XJy9caW5JNCJzTjxMUWr1TFKVwxXYj/sDPbA7arF7gVz+EDrxF7aKufh5BcsX9Z5BNDdQ/QDx/iioTeryfsq7PNbOUltaJD/LsuQxEkILg7TIUkTNaRpdYxlD/KX+t2Km0269irv/9lEK/Zp4hsyrSFIFKShLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bOJtO65h; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549946c5346so5956967e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742316095; x=1742920895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOg4onZlczYUopmqvMhF5e0J5/uBp1U0C4HX9hJitis=;
        b=bOJtO65hq9vqD+Y+UjSvbfVrtNOqnydPjYzFRf8t8aaTez1wMs08xV/866RZ6XoMdQ
         +ucpAASaWN4T24/KU54hnrq6jOHOmysXbyYtdDfQwPu7pQa07EFX1CvnmhFj565zO31d
         OJ5gb4NpfnqMLXr6ApKPUqtcuIS0FJN0zMESM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742316095; x=1742920895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOg4onZlczYUopmqvMhF5e0J5/uBp1U0C4HX9hJitis=;
        b=CBOW8cBhbP3gxEM2Rj3FmVGXeO+XEASadXuzQXQvja8iwz3e6/5Q4zHuudC24RtO6x
         tQhbzuEGmCkwcnvYSoGdYQ3hj/reb399snVVOXGhTPx3w1qE6Z00oAATyDxD3N8DDxZY
         RXVR6ioCvkkz6qTiEOI+UB4tb7nmZI5XiV6kfAPMigMkf7+9i9R963bb8h4gddkbuRFH
         fDUgeomTZLWO99yDJXnQe8s2oGouOSC5KpnSLxdA17fNH1N/zyFU22F2HCoyWI0+6E9n
         6hueTRpl00sI6i3Ik5VXkoByi+NUnvvH6AVOs7LBTRDYOTAZDRVGBsZVxKKpONQPRiSl
         lA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIaHUpOapQX/brTdyUrk1clwzQW2NP+d0bIUV5Buo9O1W/Tg138+XUWXriX2Wq0/XUbF4A2Wx0uRQa7cI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1knIf/fp+UuQqemJkR3HLkqn+m2Y2pniJCbNnxoYK6GY2xFc9
	2XG8SvfRS64+O+WS5spWMsUR7uIvUjDlKLuTlOR85cSeCz3tvo1VT2Npjk+LYxB/U6LPK2sXsp1
	v3A==
X-Gm-Gg: ASbGncvAOko/9hJXxcLUgcsU7PbewlXLjdqIPOAyaN3b0KIpVszVMcl6FFJJjXoWyi5
	9G76gEBB1ZLRqjUzLP+5zOfqGgeBEMqizPk+8Xoy2hWX1fKU4gNuwd4O3xy1/FL0I066n/4NMxb
	dBN6VYuOmo+1bBYBeAFDB+xFJ0bjMi0MGIBsb3/kHZerBfrdcpdNdC5M8VbB0vs0H9nqpX2YQ34
	lW5wg4l7skDQpPrNkH74W2Rub3fOr9wbhwA2Wp56QIfl3AfNCIfiomEVJcMPCimD38UhaJM0NtB
	p7A/RuA2BXbJMKMvCOR7HN1RSQ0kRenM8ELxst62U0onDGCkiGAuQiRCp4ZH+TsjJeIdp/vkGJA
	7/1aPd1dR2H/+SGAFkJo=
X-Google-Smtp-Source: AGHT+IFRbNP0BGIkHRiFtnt4TILSR0NwhCpcKx04xJgJCeD0OGwb5Tcu83bkDItC/mswVjp6cXksaA==
X-Received: by 2002:a05:6512:1395:b0:545:2550:7d67 with SMTP id 2adb3069b0e04-549c3925101mr9719404e87.36.1742316095467;
        Tue, 18 Mar 2025 09:41:35 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864e81sm1760312e87.126.2025.03.18.09.41.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 09:41:35 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549b116321aso6416840e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:41:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOVgBwmVo2JWlmgUSKBl9lIvBEnd+y1WisTn2ebjoCVTQCvhGenLbLeJtImwg4MViNuYwrs9n71PcTWY0=@vger.kernel.org
X-Received: by 2002:a05:6512:ba8:b0:545:109b:a9c7 with SMTP id
 2adb3069b0e04-549c3924ec3mr10662030e87.35.1742316092405; Tue, 18 Mar 2025
 09:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211002930.1865689-1-masahiroy@kernel.org>
In-Reply-To: <20250211002930.1865689-1-masahiroy@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Mar 2025 09:41:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V19pgzU8NSyWwHSEs85kU_Fbofcn8uJVj-TE2DNKfUHQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrtVKlA3T-hQmTx0UN5J-nOczdtlwAB856CkOgr9IjXZF78oLoe0IpSDm8
Message-ID: <CAD=FV=V19pgzU8NSyWwHSEs85kU_Fbofcn8uJVj-TE2DNKfUHQ@mail.gmail.com>
Subject: Re: [PATCH] tools: fix annoying "mkdir -p ..." logs when building
 tools in parallel
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Borislav Petkov <bp@suse.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 10, 2025 at 4:30=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> When CONFIG_OBJTOOL=3Dy or CONFIG_DEBUG_INFO_BTF=3Dy, parallel builds
> show awkward "mkdir -p ..." logs.
>
>   $ make -j16
>     [ snip ]
>   mkdir -p /home/masahiro/ref/linux/tools/objtool && make O=3D/home/masah=
iro/ref/linux subdir=3Dtools/objtool --no-print-directory -C objtool
>   mkdir -p /home/masahiro/ref/linux/tools/bpf/resolve_btfids && make O=3D=
/home/masahiro/ref/linux subdir=3Dtools/bpf/resolve_btfids --no-print-direc=
tory -C bpf/resolve_btfids
>
> Defining MAKEFLAGS=3D<value> on the command line wipes out command line
> switches from the resultant MAKEFLAGS definition, even though the command
> line switches are active. [1]
>
> The first word of $(MAKEFLAGS) is a possibly empty group of characters
> representing single-letter options that take no argument. However, this
> breaks if MAKEFLAGS=3D<value> is given on the command line.
>
> The tools/ and tools/% targets set MAKEFLAGS=3D<value> on the command
> line, which breaks the following code in tools/scripts/Makefile.include:
>
>     short-opts :=3D $(firstword -$(MAKEFLAGS))
>
> If MAKEFLAGS really needs modification, it should be done through the
> environment variable, as follows:
>
>     MAKEFLAGS=3D<value> $(MAKE) ...
>
> That said, I question whether modifying MAKEFLAGS is necessary here.
> The only flag we might want to exclude is --no-print-directory, as the
> tools build system changes the working directory. However, people might
> find the "Entering/Leaving directory" logs annoying.
>
> I simply removed the offending MAKEFLAGS=3D.
>
> [1]: https://savannah.gnu.org/bugs/?62469
>
> Fixes: a50e43332756 ("perf tools: Honor parallel jobs")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Makefile | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

I happened to sync up to mainline today and noticed that my build was
broken. I bisected it to this change and reverting this change fixes
my build on mainline.

In my case I'm building in a ChromeOS environment and using clang as
my compiler. I'm also cross-compiling an arm64 kernel on x86 host.
...but the pure mainline kernel should work there. Presumably the
environment is a bit different compared to the typical one, though?

The error comes up when doing a clean build and the first error messages ar=
e:

In file included from libbpf.c:36:
.../tools/include/uapi/linux/bpf_perf_event.h:14:21: error: field has
incomplete type
      'bpf_user_pt_regs_t' (aka 'struct user_pt_regs')
   14 |         bpf_user_pt_regs_t regs;
      |                            ^
.../tools/include/../../arch/arm64/include/uapi/asm/bpf_perf_event.h:7:16:
note: forward
      declaration of 'struct user_pt_regs'
    7 | typedef struct user_pt_regs bpf_user_pt_regs_t;
      |                ^

btf_dump.c:1860:10: error: cast to smaller integer type 'uintptr_t'
(aka 'unsigned int') from 'const void *'
      [-Werror,-Wvoid-pointer-to-int-cast]
 1860 |         return ((uintptr_t)data) % alignment =3D=3D 0;
      |                 ^~~~~~~~~~~~~~~
btf_dump.c:2045:4: error: format specifies type 'ssize_t' (aka 'long')
but the argument has type 'ssize_t' (aka 'int')
      [-Werror,-Wformat]
 2044 |                 pr_warn("unexpected elem size %zd for array
type [%u]\n",
      |                                               ~~~
      |                                               %d
 2045 |                         (ssize_t)elem_size, id);
      |                         ^~~~~~~~~~~~~~~~~~
./libbpf_internal.h:171:52: note: expanded from macro 'pr_warn'
  171 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS_=
_)
      |                                                   ~~~    ^~~~~~~~~~=
~


I don't have time to dig right now, but I figured I'd at least post in
case the problem is obvious to someone else.


-Doug

