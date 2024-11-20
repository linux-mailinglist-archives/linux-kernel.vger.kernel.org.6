Return-Path: <linux-kernel+bounces-415076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E73D9D3145
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3363F1F22E26
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269A023CB;
	Wed, 20 Nov 2024 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHglNq7l"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E43A29
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732061062; cv=none; b=fJbG/kjM1FjXhSmflncKzcvqIapFOz5qq04AZ1dsPMhva3wfGHMrfJMRyxo3tkAbeuD/qtRpPYKdzNkXDvCpsLNkrRa+2w8v71Vr6/W1fsmGeCOCnnP4f74IL0WmOutLDeTQ2UCEGvvCopD5a/TrDCYZDyi7fTerN+jNg6XEL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732061062; c=relaxed/simple;
	bh=MQhxvv+Zy7kv/3CNiDL9k/dVxW7dLmvm7OupHSl2rH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6Vgdwll3UdlYVYWlSoca/J6TzgqNMIHPP/gmkivznX36j2eW0gsYd5XPqrEDAkgeAiKC0IuwWitoLlvkA9OO6iY+epmyrugjj9Bywj7eW5X3wJE0Uyqs+rOKQObmEhYKFRBGgipqMNaZX2y6FMoxeL5GMqI+6DSGtNRxX0a2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lHglNq7l; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460ad0440ddso8868061cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732061059; x=1732665859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ9wzI1TmlQXej6cFMiTpABwAkL1fHo62MR/nWPSxQU=;
        b=lHglNq7lz8Qd0x1wHL4PpVg1D0I7PaTF1J6jjDBICk5EGXHzeLv/2+3K1Cx7L9S8ef
         49E6J6LxG5G81oUQyvM2DwgSiEpTqaHRLLQn7u28D12We30mFamidMdz2jPE+fMqGUSW
         b2oGbPrdpgGptvutcIke5MmQCdWDFUG/ZZ/PlzGIaNRH4zhBqJ1X085BvJtXoDo/PvGp
         +KkMgcvkSZgwh9XuKyHzbvWuqtCNBGksYfM5vj2s0SVXI3nJnh3SRMbzX/jegx+L+5+s
         RO0HpXIode8w2izmSldG5H68DmFttbXvrZY/kwjInfOJHmR6/VjdRhI/kUbLjQlXVFjZ
         QQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732061060; x=1732665860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ9wzI1TmlQXej6cFMiTpABwAkL1fHo62MR/nWPSxQU=;
        b=O/7s3G7/S8x+9IyJr/J+ASS/RVeceRenJeqVE0u4EMvgRM2J7E5zrIVaNmKpwk+BB/
         ua26T58ZBQMPQq8OcDwjYHDcoQzXB2WMSUFiYGzYS3TJoG/ArRKSvhCcT7GmjXDggzOo
         sIbR0wYZb+a2+eDfX5eyDz3AuHV13zEZ6LC5zOuDI2jdzueWnhMgomdNnUcxcVvz/WxQ
         bknrNw4oCz2Z/69Uph5t07SKaSwZ/jLNk4MttmDgA9M1uIKxb/mqU+z7vlQHtM0BXI6j
         hkAmu4wPBiuQ0HhQoWQbsP/AeGYQnCarjAR8q45YEjWrNxpUSrEnw4S0X5MKaSGy/UU3
         tCUA==
X-Forwarded-Encrypted: i=1; AJvYcCUrzkyVGnVzPC7IxEWlc7U7sn8Enq8yxzoNHFrNjyKnClhwe3BIjetvMOdElVJ7uKP4Za7oMn59BObuOcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSyiAfDvwL8bf2hbhVaIIkuVvsQ+6VXxvRCk+lW3JUv+USrxo
	3ShwJeamsZGwYQl/wIhZ1pA82m277bzi78CqpLnuZjeiAeQXy/jJWXZu22Awnels71httrq2wJE
	Oa6RvGcm6HR3sIrRBTOieLFpUQKpgRC1c5lI=
X-Google-Smtp-Source: AGHT+IEWyuVUbKDwVZV4fuwYJYdtkIx/t21su1G7P/j2rRkl2QZ25EqdPTldFuoGQWpZi1iCXV6lcrxrrZLbEs7/8sk=
X-Received: by 2002:ad4:574c:0:b0:6d4:1a42:8f06 with SMTP id
 6a1803df08f44-6d4376d3a2cmr15211206d6.0.1732061059330; Tue, 19 Nov 2024
 16:04:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222540.27495-1-yabinc@google.com> <CAF1bQ=SwtGDpOJeQwhbnO6Md=kFbcmkM4iVgXUgjzNXu+d8cEA@mail.gmail.com>
In-Reply-To: <CAF1bQ=SwtGDpOJeQwhbnO6Md=kFbcmkM4iVgXUgjzNXu+d8cEA@mail.gmail.com>
From: Yabin Cui <yabinc@google.com>
Date: Tue, 19 Nov 2024 16:04:08 -0800
Message-ID: <CALJ9ZPMNrZW0TYxEVRMJo2FkvOfmGxSODwsV9cA1jUZUz-Q2aw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Allow CONFIG_AUTOFDO_CLANG to be selected
To: Rong Xu <xur@google.com>
Cc: Han Shen <shenhan@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, George Burgess <gbiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add George from ChromeOS.

On Mon, Nov 18, 2024 at 3:49=E2=80=AFPM Rong Xu <xur@google.com> wrote:
>
> This patch looks good to me.
>
> I assume the profile format change in the Android doc will be submitted s=
oon.
> Since "extbinary" is a superset of "binary", using the "extbinary"
> format profile
> in Android shouldn't cause any compatibility issues.
>
> Reviewed-by: Rong Xu <xur.google.com>
>
> -Rong
>
> On Mon, Nov 18, 2024 at 2:25=E2=80=AFPM Yabin Cui <yabinc@google.com> wro=
te:
> >
> > Select ARCH_SUPPORTS_AUTOFDO_CLANG to allow AUTOFDO_CLANG to be
> > selected.
> >
> > On ARM64, ETM traces can be recorded and converted to AutoFDO profiles.
> > Experiments on Android show 4% improvement in cold app startup time
> > and 13% improvement in binder benchmarks.
> >
> > Signed-off-by: Yabin Cui <yabinc@google.com>
> > ---
> >
> > Change-Logs in V2:
> >
> > 1. Use "For ARM platforms with ETM trace" in autofdo.rst.
> > 2. Create an issue and a change to use extbinary format in instructions=
:
> >    https://github.com/Linaro/OpenCSD/issues/65
> >    https://android-review.googlesource.com/c/platform/system/extras/+/3=
362107
> >
> >  Documentation/dev-tools/autofdo.rst | 18 +++++++++++++++++-
> >  arch/arm64/Kconfig                  |  1 +
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/dev-tools/autofdo.rst b/Documentation/dev-to=
ols/autofdo.rst
> > index 1f0a451e9ccd..a890e84a2fdd 100644
> > --- a/Documentation/dev-tools/autofdo.rst
> > +++ b/Documentation/dev-tools/autofdo.rst
> > @@ -55,7 +55,7 @@ process consists of the following steps:
> >     workload to gather execution frequency data. This data is
> >     collected using hardware sampling, via perf. AutoFDO is most
> >     effective on platforms supporting advanced PMU features like
> > -   LBR on Intel machines.
> > +   LBR on Intel machines, ETM traces on ARM machines.
> >
> >  #. AutoFDO profile generation: Perf output file is converted to
> >     the AutoFDO profile via offline tools.
> > @@ -141,6 +141,22 @@ Here is an example workflow for AutoFDO kernel:
> >
> >        $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -=
a -N -b -c <count> -o <perf_file> -- <loadtest>
> >
> > +   - For ARM platforms with ETM trace:
> > +
> > +     Follow the instructions in the `Linaro OpenCSD document
> > +     https://github.com/Linaro/OpenCSD/blob/master/decoder/tests/auto-=
fdo/autofdo.md`_
> > +     to record ETM traces for AutoFDO::
> > +
> > +      $ perf record -e cs_etm/@tmc_etr0/k -a -o <etm_perf_file> -- <lo=
adtest>
> > +      $ perf inject -i <etm_perf_file> -o <perf_file> --itrace=3Di5000=
09il
> > +
> > +     For ARM platforms running Android, follow the instructions in the
> > +     `Android simpleperf document
> > +     <https://android.googlesource.com/platform/system/extras/+/main/s=
impleperf/doc/collect_etm_data_for_autofdo.md>`_
> > +     to record ETM traces for AutoFDO::
> > +
> > +      $ simpleperf record -e cs-etm:k -a -o <perf_file> -- <loadtest>
> > +
> >  4) (Optional) Download the raw perf file to the host machine.
> >
> >  5) To generate an AutoFDO profile, two offline tools are available:
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index fd9df6dcc593..c3814df5e391 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -103,6 +103,7 @@ config ARM64
> >         select ARCH_SUPPORTS_PER_VMA_LOCK
> >         select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> >         select ARCH_SUPPORTS_RT
> > +       select ARCH_SUPPORTS_AUTOFDO_CLANG
> >         select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> >         select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
> >         select ARCH_WANT_DEFAULT_BPF_JIT
> > --
> > 2.47.0.338.g60cca15819-goog
> >

