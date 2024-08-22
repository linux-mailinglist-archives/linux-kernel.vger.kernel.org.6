Return-Path: <linux-kernel+bounces-297709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B624295BCB2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12831F21D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DA21CFEBE;
	Thu, 22 Aug 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZnkEv5e"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270E1CFEA9;
	Thu, 22 Aug 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346215; cv=none; b=B7x29HLVro0RVYPaSvHS2MvpVeils4v2uXWwe/jlOg9kDrFoLyreEd0uITiTlpJqhZr+yziilxDYaHw1rjAb0RjIno9R4Ptsa0+WpOuggSZ6av/mAMVBprFdgq8lR6SEGNqXDAa2vZCW9xyPezXKfe6iNZTzTpWjBUMd5+JH4CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346215; c=relaxed/simple;
	bh=A1Ie/PkrptChw4lwJ4EwiA8zgvpKq6Q4n7/F/Q1FHu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghgjyfz91qZHO13FCro4WgSmIKYAhOA5qx641+9YO2d4ccGuEWAIFYxFAoIUdTJ9BluVDw+lruMH7cRZuZzAn5A+cEp6xfa/xSp/Mdno7nX/fwiL+rtbbD+xUld+o4AcXiNmQpB6evCA8srEY8ia+2xInPY4Fq2LQEp34sd2mOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZnkEv5e; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5dc93fa5639so735512eaf.1;
        Thu, 22 Aug 2024 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724346213; x=1724951013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VCn9+6arz6SwXDvtWZRy4SIeKUgiiy9I7P31lPptUSg=;
        b=TZnkEv5egRUIMY+9VXRilOKhuopYTpqOAn5V4pTJXy5Vt6Sugz10PJhpUr1W7BRjwi
         fRsoMIHTdQS7Im8uN/S3B3W9SYjTW8356wcOIVNrrlq4XRGKBfaz0zrIe32m+xpP0zk3
         j3+fhg+7OZYhC/zCdYPHVy5YS6v6CJqxfFW6VU57OnhMW31DO3048CPGX3J/hAw/N8nK
         +lAcFgc9ESRXrSxcMywvlY7g6GoNgqMXXq7Q+Ej69kXnRQhqAluQ4kWHh5hI+xqvSng/
         cQ8owV5zKe/MFsye0hBxhdwcZs/BSV/K9+fkgXoy/GUJbe0etBU2ZK1Apf/sEZXPQPHH
         uHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346213; x=1724951013;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCn9+6arz6SwXDvtWZRy4SIeKUgiiy9I7P31lPptUSg=;
        b=nf+MHLf/SpRgT5IsTiRMRQoLSb6kX74nSmpgwjZyy0DuWqJdElDSLNAHCm/50/CQkE
         1XDcjQ1VenrnmuHmTufC/2kJMIjyvc93P1hdZaSuOssdBnwUSwcXU19IpbzG0ErhCIMX
         okvo3GPPmi/VfFHrnFQCYqOHxZR5yXZcazyfEg1caf2nrKf4g9g75DnJlYfsh4uEquMz
         15J7gX2EFKIWmXtPUROQ6qEj1yh4jgFIWTJZfD2JVzPb9PlJzsZ0OMZTwlEUbt301CK8
         Au6j8cRgYCd3008rJSdiDsl1EOC/p5ZdN01Wno8Nj8bJW6YdpY1txn75+RlZ0Dt6mw5u
         2q/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWmpbqKmBV3Ogj9gJqb8xSYVEd3GKvZeK1VVMD2upEHVPYBw+RYZ/2T56oJ754aBwPEhz5j28qrkKJfwyMN2CBYw==@vger.kernel.org, AJvYcCWO0fo+7nb0HJ/xNh9dNBmiN/kt6A1LseNtJEC2wZw8L94EOTVgmQ+YL1xRuwwgMlhv4ZokA4wdluZhHWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qxn8OA1hrthByKu477g5HHIrWqNk016EuE2sOdgrnOLoMvrh
	d50YIK955GtXJzdiHMcUhGO9pdsaJaZULeWgPbFKopYS8sik3iJyrZCE/MtV8KOVsIicPuucLZs
	tXTvZZqwZhj0mPFRO04ORssWA0Tnf6alBna0=
X-Google-Smtp-Source: AGHT+IF1T5NRVxeJWw2lhgbTZC7Qyt+LvMLNcFvRuuB3gMpW0hOh815foleADrYgtGWwVTlEe8ST175eYGYbhfMidtQ=
X-Received: by 2002:a05:6820:168d:b0:5dc:a733:d98a with SMTP id
 006d021491bc7-5dcb685ac95mr2592254eaf.7.1724346212508; Thu, 22 Aug 2024
 10:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <ZsdKhLaPy-uzKsuH@x1> <ZsdUxxBrpbuYxtXN@x1>
In-Reply-To: <ZsdUxxBrpbuYxtXN@x1>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 22 Aug 2024 19:02:52 +0200
Message-ID: <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000778743062048a323"

--000000000000778743062048a323
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:10=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 22, 2024 at 11:26:16AM -0300, Arnaldo Carvalho de Melo wrote:
> > So the cast is ok, I think we should disable that
> > -Wcast-function-type-mismatch for util/python.o when building with
> > clang.
>
> > Lemme try to cook a patch for you to test...
>
> Can you try the patch below? Notice that there was already a patch
> disabling that for !clang (gcc) for a similar reason:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Db7a313d84e853049062011d78cb04b6decd12f5c
>
> -------------------------------------------------------------------------=
-----------------
> perf tools: Fix python extension build for gcc 8
> The gcc 8 compiler won't compile the python extension code with the
> following errors (one example):
>
>   python.c:830:15: error: cast between incompatible  function types from =
             \
>   =E2=80=98PyObject * (*)(struct pyrf_evsel *, PyObject *, PyObject *)=E2=
=80=99                       \
>   uct _object * (*)(struct pyrf_evsel *, struct _object *, struct _object=
 *)=E2=80=99} to     \
>   =E2=80=98PyObject * (*)(PyObject *, PyObject *)=E2=80=99 {aka =E2=80=98=
struct _object * (*)(struct _objeuct \
>   _object *)=E2=80=99} [-Werror=3Dcast-function-type]
>      .ml_meth  =3D (PyCFunction)pyrf_evsel__open,
>
> The problem with the PyMethodDef::ml_meth callback is that its type is
> determined based on the PyMethodDef::ml_flags value, which we set as
> METH_VARARGS | METH_KEYWORDS.
> <SNIP>
> -------------------------------------------------------------------------=
-----------------
>
> Can you please check with both clang versions? I just checked with clang
> 18 as available in in Fedora 40 and it failed in the first, na=C3=AFve pa=
tch,
> that simply adds that -Wno- variant:
>
>   GEN     /tmp/build/perf-tools-next/python/perf.cpython-312-x86_64-linux=
-gnu.so
> error: unknown warning option '-Wno-cast-function-type-mismatch'; did you=
 mean '-Wno-cast-function-type-strict'? [-Werror,-Wunknown-warning-option]
> error: command '/usr/bin/clang' failed with exit code 1
> cp: cannot stat '/tmp/build/perf-tools-next/python_ext_build/lib/perf*.so=
': No such file or directory
>
> we need to check if clang has that option, we have infra for that, the
> patch below works, please try it.
>
> If it works with clang 19 I'll add two patches, one enhancing
> clang_has_option and the other using it for this warning only present in
> clang 19.
>
> - Arnaldo
>
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index 142e9d447ce721e3..649550e9b7aa8c8f 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -17,7 +17,7 @@ src_feature_tests  =3D getenv('srctree') + '/tools/buil=
d/feature'
>
>  def clang_has_option(option):
>      cc_output =3D Popen([cc, cc_options + option, path.join(src_feature_=
tests, "test-hello.c") ], stderr=3DPIPE).stderr.readlines()
> -    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is=
 not supported" in o))] =3D=3D [ ]
> +    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is=
 not supported" in o) or (b"unknown warning option" in o))] =3D=3D [ ]
>
>  if cc_is_clang:
>      from sysconfig import get_config_vars
> @@ -63,6 +63,8 @@ cflags =3D getenv('CFLAGS', '').split()
>  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-=
parameter', '-Wno-redundant-decls' ]
>  if cc_is_clang:
>      cflags +=3D ["-Wno-unused-command-line-argument" ]
> +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> +        cflags +=3D ["-Wno-cast-function-type-mismatch" ]
>  else:
>      cflags +=3D ['-Wno-cast-function-type' ]
>

I tried with your diff with SLIM LLVM toolchains 18 and 19.

Both work - see attached build-logs.

Yes, are right that LLVM/Clang v19 was first introducing:

-Wcast-function-type-mismatch / -Wno-cast-function-type-mismatch

[4] says for LLVM 18.1.8:

-Wcast-function-type
-Wcast-function-type-strict

Feel free to add my Reported-by/Tested-by credentials if you sent a full pa=
tch.

Thanks.

BR,
-Sedat-

[1] https://mirrors.edge.kernel.org/pub/tools/llvm/
[2] https://mirrors.edge.kernel.org/pub/tools/llvm/files/llvm-18.1.8-x86_64=
.tar.xz
[3] https://mirrors.edge.kernel.org/pub/tools/llvm/files/llvm-19.1.0-rc3-x8=
6_64.tar.xz
[4] https://releases.llvm.org/18.1.8/tools/clang/docs/DiagnosticsReference.=
html
[5] https://clang.llvm.org/docs/DiagnosticsReference.html

--000000000000778743062048a323
Content-Type: application/zstd; 
	name="make-log_perf-install_bin_python3.12_llvm18_acme-diff.txt.zst"
Content-Disposition: attachment; 
	filename="make-log_perf-install_bin_python3.12_llvm18_acme-diff.txt.zst"
Content-Transfer-Encoding: base64
Content-ID: <f_m05in6nd0>
X-Attachment-Id: f_m05in6nd0

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
--000000000000778743062048a323
Content-Type: application/zstd; 
	name="make-log_perf-install_bin_python3.12_llvm19_acme-diff.txt.zst"
Content-Disposition: attachment; 
	filename="make-log_perf-install_bin_python3.12_llvm19_acme-diff.txt.zst"
Content-Transfer-Encoding: base64
Content-ID: <f_m05incvu1>
X-Attachment-Id: f_m05incvu1

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
iAUKjgG3NYFWDQKQ+kTJ
--000000000000778743062048a323--

