Return-Path: <linux-kernel+bounces-235984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D3791DC0F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6DA1C20F06
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DF912A16D;
	Mon,  1 Jul 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wc/4M4cY"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26DF3207
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828337; cv=none; b=RJ6hqQ84MWyNj5D8D3mYbg2KPZ4H9nDuv7shyuLQm6kxOTlimIRTP6pc+fTqbp2nyDENizySOGEYIGgekQ40xzMqtmEUcP7sXumHzihPH+xttps88/8cfgYeh7Wh1R4+brU8209CBfCCo9F2hEw8KJP7yl7LeMLNNTynhNzqf9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828337; c=relaxed/simple;
	bh=PcbjUIaNFUdO8prWOO3zwLLEe3a64pHF28ZtjbLenhA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ijdGAIbELXftqUyHB8/3gSDD/1fOPhwVlPmJ4t0jLQjm2kpTsyuKRo+pXG1r04w7jCTZRxLCg9P5fvqluzAZGePSc73SJ9Wb+Jo6XiFHYDzBLYw+YvidX+HWBLpYf0h6rSoK71y7HswjD7kywUvY0LhAU6LlKihTn1G+rwHEu/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wc/4M4cY; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4f284ef075dso2257772e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719828334; x=1720433134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I4DXBAWMyQsPIP/BlZF0MhKJYIvvGxN8nErZr4nhF+E=;
        b=Wc/4M4cYqFAw9SBvk7WMR1x28NqqtrqQdGLQ/gZyeWAj8aORVZwzcclKy0TxFa4KoC
         ZTL0QtxhuLqpZ0J0ltGtkgSrPsh0kRgK2gAlXfSMBDcZGi9na5SA78LkNvOzZHnhEW+e
         lj3opS6E0/ZFeewzQQOAdDwBuBY7usJXSl2qyon4PEjHXaW44OWpmIDQ8OmbnrO4+Ywo
         12cMWyAuCQNEM3YKQq+jpOgmR+taVbzq/GcWQjl8a2Iu5xsP9hnweVG0ItgB9xLhtqsK
         dHLdykSNPvfGQAlX11NzERPQe4mAfru+xK32XFI2wg7jBK5E17stfqi5h+jjBniU6B/C
         4FHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719828334; x=1720433134;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4DXBAWMyQsPIP/BlZF0MhKJYIvvGxN8nErZr4nhF+E=;
        b=YCmujYhv9XDSwmVU7a0nlpPZRj16XVG0Z+BPJ/x3FqUJRgwSYGvJPXN9c9ijZkim8x
         Re06kgcVaTOWFjjfJkv2Vmin0oJ+9z04sUAvBC4S13itB4k0BXiJ9YrtuxpPMfmhmdIT
         I3DF/wSX4DLFgO5he8jMfGG7PFA9Ul3I03FZ28ppKlFd/3v2de0BtYtOKBEu7i+Tblg3
         sSe+pqab3Tu+TsoRwy35CvEz9E4SzvSPt/0S26xCfuFY/JvMh0ptp+CIxuetoVBisFGB
         9xmSi//uK/l0Ai2DWmcAz/J2ePlt2/UWCUqh0dBTjtuKc7izCZ0fiGssEJjARTHL3YkO
         6U2g==
X-Forwarded-Encrypted: i=1; AJvYcCX8ZIpjhLXpHUaPmz8NNYAz2QFT0NRq/lnVbWQZ6vjvDievbqLj+RRHmF0wICTzIO8x71mEyP7pSvNpdoIFMBci+2WQzsD28lphoKJ3
X-Gm-Message-State: AOJu0YwhExoQbtG+iI1jkQYJPCRig7mgZ6ijRwjqJ4aSXcqyQnmbz2tj
	eieMPlhLZJ2Qv0c3V7dMhQa85UNM6Zs1FsIpDWLdBNU2GlwNQx6V3vEXobH96hkxRmVs3g3OdwX
	6OPMBnS53cx5Xxvux/NXalRKwtFgMmtT/WsmHgQ==
X-Google-Smtp-Source: AGHT+IG/UJLtDpqLnWBEhTMwLbgorI6NfFHGnvnXUhY4RXRD1i3Q/9cj2Xrr1s9Ry+0T5PQVhvZc+dVzAoKpfP89VE8=
X-Received: by 2002:ac5:cd4f:0:b0:4ef:8574:ce18 with SMTP id
 71dfb90a1353d-4f295e9d7cdmr4071960e0c.6.1719828334606; Mon, 01 Jul 2024
 03:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 1 Jul 2024 15:35:23 +0530
Message-ID: <CA+G9fYve66bw-4xVrJnfeXtRV1et1UhEZMFAvvTXbKB2-m--fg@mail.gmail.com>
Subject: mm: gup.c:2827:22: error: conflicting types for 'try_grab_folio_fast';
 have 'struct folio
To: lkft-triage@lists.linaro.org, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-mm <linux-mm@kvack.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

The powerpc build failures noticed on Linux next-20240628 tag.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on powerpc:

  - gcc-13-maple_defconfig
  - gcc-13-cell_defconfig
  - clang-nightly-maple_defconfig
  - gcc-8-defconfig
  - gcc-8-tqm8xx_defconfig
  - clang-18-tqm8xx_defconfig
  - gcc-8-maple_defconfig
  - clang-nightly-cell_defconfig
  - clang-18-maple_defconfig
  - gcc-13-defconfig
  - clang-18-defconfig
  - clang-nightly-defconfig
  - gcc-13-tqm8xx_defconfig
  - clang-nightly-tqm8xx_defconfig
  - gcc-8-cell_defconfig
  - clang-18-cell_defconfig

Build error:
---
mm/gup.c: In function 'gup_hugepte':
mm/gup.c:525:25: error: implicit declaration of function
'try_grab_folio_fast'; did you mean 'try_grab_folio'?
[-Werror=implicit-function-declaration]
  525 |                 folio = try_grab_folio_fast(page, refs, flags);
      |                         ^~~~~~~~~~~~~~~~~~~
      |                         try_grab_folio
mm/gup.c:525:23: warning: assignment to 'struct folio *' from 'int'
makes pointer from integer without a cast [-Wint-conversion]
  525 |                 folio = try_grab_folio_fast(page, refs, flags);
      |                       ^
mm/gup.c: At top level:
mm/gup.c:2827:22: error: conflicting types for 'try_grab_folio_fast';
have 'struct folio *(struct page *, int,  unsigned int)'
 2827 | static struct folio *try_grab_folio_fast(struct page *page, int refs,
      |                      ^~~~~~~~~~~~~~~~~~~
mm/gup.c:525:25: note: previous implicit declaration of
'try_grab_folio_fast' with type 'int()'
  525 |                 folio = try_grab_folio_fast(page, refs, flags);
      |                         ^~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Steps to reproduce:
----

# tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
--kconfig cell_defconfig



metadata:
----
 git_describe: next-20240628
 git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
 git_short_log: 1eb586a9782c ("Add linux-next specific files for 20240628")
 arch: powerpc
 toolchain: gcc-13 and clang-18

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2iWYcbTLGMcGuxl7caQ3jwv9C4a/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240628/testrun/24464887/suite/build/test/gcc-13-cell_defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240628/testrun/24464887/suite/build/test/gcc-13-cell_defconfig/log


--
Linaro LKFT
https://lkft.linaro.org

