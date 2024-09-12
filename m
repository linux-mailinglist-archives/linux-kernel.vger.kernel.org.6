Return-Path: <linux-kernel+bounces-327301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051C19773AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FBC284978
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D51C1AB7;
	Thu, 12 Sep 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsGkpoP3"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43519259B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177003; cv=none; b=L2oadAf131nxNcVp3ybV2zpnt0xCKwGD0xhc5q4H1VCqivfeDDlMz+MObYOFPGAhOfOX4MkOsZcYISIsjtVEO122ADPKGZCyJM1kcmmuIhl2NgHekCf/SmC9bdj8Z2GC45PKBiCCBnPErTdf/OAPDAVzj3/4UHOxLFqvH1GCe6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177003; c=relaxed/simple;
	bh=pDqhAgtaGUIk/5wz/QDpvGvuqyiDlqtUCUYvT654FxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlNhtmiDwSSdG7s8FfWOnZcT5gM8TWcSaqICfOoQJqihfwhsRbJuEu5ZMwlE0jnkLz5atlLi7f7F7y3RcFjLqYP2BW99e7yBqkHNCY+J+ZVczvuN+q47KxdcvFKi/IMF/PN5I/8GRVWt2lzv7pYnbftYUdhb/Tuez7bF5blxp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsGkpoP3; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-49becc93d6aso398547137.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726177001; x=1726781801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV/uSQHel3G7NaBIuUYTK9WPHlxT4nG6GtUVNt1aiiw=;
        b=tsGkpoP3WeGnT1Y3yRFPSNgHhYDFWlGngGv3H9MtrjvxtA+cpAFWULYs/5lrwoToJY
         V+STe8ps1yP2aGj/9Ahlc2Y7n9NzHFUs1E6lzO8Ysx7tjmnc0x7OWd/8mSzfsRqkQLr2
         7krdm+MLVn1t3V72OcTlHqIM/wPleNjSsX0wRyMLKO9qlVr3OtcIyB5mv9FFb6JAgC3U
         YAVKoZDyV05qHit1vtrJ+MMxO8ZrhqhLZ74RthkeuG4+k8kPhpPcnRfmgmSG2NOh/O/q
         d+33zAde4EgIZyPvsekkwwtfqfpX/fqkdzpzZnPVMQCn3DZGZ53WAkUC22us0Ta7jil0
         x9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177001; x=1726781801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV/uSQHel3G7NaBIuUYTK9WPHlxT4nG6GtUVNt1aiiw=;
        b=vbL+jyXczk7VulohBU6vExL4Ge2IBq0362CvaCHKPl5oqEGSAiNkVszrjwE2+R9lv6
         Vp2nuldvaq40de8ANNs6l5RU/XtVc8ChYZxZROVuTfzMBlpfsJYpm7mVg4rjDaUx5G+q
         Z1w6teJakd7S9kx7dRKVS9AyvG4a9rXBiTR77N6+hhD7QLS/zoJRzvBuXvIGaWAZhYVe
         7V3zWvT9E1phBNPwSHRqBR57bYsMtCy+805KCQS+0ieH1kB49rAnu0WeEt2SBNfSCWr5
         VxBrr/LvjDrkaxIU0Gipoe1gRhhRMEy21s/bGbiMioEaemKzXvcTInfrJOQgTRm//Whc
         YyvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsBCuWwoiQiyVZVHEtpcHphXV71k5HMYKcJvNzlbJGu2WkzZtueyWHw0c24qZpaWjeYgu9VCWSsLwRNVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxl3OwLC/2gUDdRqo6GdT7YlK1XHXxdfcIs3x+2AyYJUK53UgL
	9mU8yYSXF/dyMheVAZfqikoxhha1wNeFmilwWSBy/LQibqpN8QqjS8PvM8uEZmoMjuDc5LPNYE0
	TTH+3AvpIhq0mmWGLmPsZQaiJkc8i5GGlxFnY
X-Google-Smtp-Source: AGHT+IH05pjtSDhnhSat0T4TMcHpVIIy9ELPbIRaoAr2cIE1oDrkYRJOYxE3o0MeBcNuyMPFcCB85eDpRsk4NuzwEyU=
X-Received: by 2002:a05:6102:511e:b0:49b:be3b:8812 with SMTP id
 ada2fe7eead31-49d4157c4eemr4055765137.24.1726177000369; Thu, 12 Sep 2024
 14:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516-kunit-compile-commands-v1-1-05fc32b79312@google.com>
In-Reply-To: <20240516-kunit-compile-commands-v1-1-05fc32b79312@google.com>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 12 Sep 2024 14:36:28 -0700
Message-ID: <CAFhGd8pLAa7vkVUtcdhvdk+oq=dOSGQWCOf0oZK7pszaLdsKNA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Build compile_commands.json
To: Brendan Jackman <jackmanb@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 12:38=E2=80=AFPM Brendan Jackman <jackmanb@google.c=
om> wrote:
>
> compile_commands.json is used by clangd[1] to provide code navigation
> and completion functionality to editors. See [2] for an example
> configuration that includes this functionality for VSCode.
>
> It can currently be built manually when using kunit.py, by running:
>
>   ./scripts/clang-tools/gen_compile_commands.py -d .kunit
>
> With this change however, it's built automatically so you don't need to
> manually keep it up to date.

This is great!

>
> Unlike the manual approach, having make build the compile_commands.json
> means that it appears in the build output tree instead of at the root of
> the source tree, so you'll need to add --compile-commands-dir=3D to your
> clangd args for it to be found.

This is annoying for some. For my setup, the discovery of
compile_commands.json depends on where I open my editor from. So this
isn't really an issue as I can *choose* what compile_commands to use.
I think some folks may wish the compile_commands.json was also dumped
in the top-level directory so clangd can discover it easier.

>
> [1] https://clangd.llvm.org/
> [2] https://github.com/FlorentRevest/linux-kernel-vscode
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  tools/testing/kunit/kunit_kernel.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/ku=
nit_kernel.py
> index 7254c110ff23..61931c4926fd 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -72,7 +72,8 @@ class LinuxSourceTreeOperations:
>                         raise ConfigError(e.output.decode())
>
>         def make(self, jobs: int, build_dir: str, make_options: Optional[=
List[str]]) -> None:
> -               command =3D ['make', 'ARCH=3D' + self._linux_arch, 'O=3D'=
 + build_dir, '--jobs=3D' + str(jobs)]
> +               command =3D ['make', 'all', 'compile_commands.json', 'ARC=
H=3D' + self._linux_arch,
> +                          'O=3D' + build_dir, '--jobs=3D' + str(jobs)]
>                 if make_options:
>                         command.extend(make_options)
>                 if self._cross_compile:
>
> ---
> base-commit: 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
> change-id: 20240516-kunit-compile-commands-d994074fc2be
>
> Best regards,
> --
> Brendan Jackman <jackmanb@google.com>
>

Reviewed-by: Justin Stitt <justinstitt@google.com>

Thanks
Justin

