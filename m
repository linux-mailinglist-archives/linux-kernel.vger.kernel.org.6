Return-Path: <linux-kernel+bounces-262460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC5393C764
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBA01C21F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C45C19DF78;
	Thu, 25 Jul 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RylKNUxC"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC4197A76
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926143; cv=none; b=DV3PvPliyMtXXbM64MEGktVhyF/tN1DWRUOjLpKOOavOz/TjwVpdmAF1R2h4pCsrS+mkIhPuIYT7llg73jaoNkLJbRNQqnxSkHkysXF/wNh7avRORK+McXPCulBGJNESlNQL89u7JFqLqFcBExIGc/mII4pCpDyWvr63cNu2Bi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926143; c=relaxed/simple;
	bh=zl9tyaX3atF1FD6Oj4CMVfjVeFukwL1OauJx8MZgj8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SL19WBiDjOlenWFhFl7Bl99wJHlxlOpsqHsmDU8EYY9AYyEYKfZxtWIw+BfadpAZAIl6XFqq2I69ZXUZY/D2Ufq9BqWsbzYJsRwmtkfu7rBVAldJ6T8tn92DqJONcZo7DJCvIg5WCfPjAXxSMlTvLtpixu98pHYQRBSz8unZ660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RylKNUxC; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4f50c673e83so361979e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721926141; x=1722530941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jKCeuZLzTZnQ+M0GtznLWK7b6OnFbkvquUnPvitUBac=;
        b=RylKNUxCOMpWmu5WLb1960ne3PH8OYw+ng7cLM+Dn3ELYqI+n9KR0WEa+PYsq2JjfJ
         vnrmzgrFewtZLoAbJmU0Gd6CITa066IGlhg4IQ8DkIXygAkCqtwnB3H5/6zkaZSGRuDP
         pfBhz3fsxzMJoHF6BEYKYFWVpypS05puQU3ZXvnVqWcvEHHo7wlu74s02LWkBOQMV4Y4
         I5XQOvAnfF+83uv2LR/BJs8jqyfkIhA+nScZe1g0+TYi70gCBfWn5huiESl5xkwphxkW
         Xkc4yaHjF04sLLHaj7eLWmdljWzz5GndhAcECILamY2phJickP8iwJtibuRaPoJnl/Fi
         fHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721926141; x=1722530941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKCeuZLzTZnQ+M0GtznLWK7b6OnFbkvquUnPvitUBac=;
        b=GI29L0v7L1S2iSi/2Di0s6phVrOBEsPJNVAP8dXfiL9aZ7YYnviCgDsxe++GTTUfUk
         s3XLQ7RtrHiJtt4iYIRaFHsoXmKM+4lwtlqg2qXyWhxFgrLnTXDAc9PzydLjfUsmkc9T
         w7nIT0z1m/3keXGXNrLJO1E8YbI9xWWYSG6E8EBV7LCrgRGU7vf+S0u34i8As2dttPRb
         rbm4CIbtllZA0KXZ7a/X7EG8qusjL/G+DI/dkKLwTJsYi3NQj+s/Nb+m3xSSMFtUHj+x
         7EOyME0H8dXvlpgqDyTwz8PPtONqyVFi0f4PAI5BLO62AU1r2900n3cItZS/iACBu3yp
         txLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr+mX/zSvY3/96I6woLZjLHAPaR96tXh5vdFFXwb39cnoOcnTIvyxWRqR/TX326r5SpSeTr1kEyYeFIhs45zJI4bbgKf4OsfBAdIP4
X-Gm-Message-State: AOJu0YwCmWhyVdORKVYe/KB5qawBK3eB2ripspa5w7xX0v5YCD5IF+fJ
	tvoA98J4CUSMOU9xMQLBtF7/0tDOBECX2efQQ+YjPDEyNindYm2jgSoccsVTG3dc2do3FvlY700
	2jNEnlO6YtQvLkQdZQ4lXLkbpeCtnZ+X+n3Nu/w==
X-Google-Smtp-Source: AGHT+IH+sca/eScSSpr1hspS4ecSOGX3fro/SHs8Yt+aVmqnAYTWGrfofCR+92nWoCEokUgsHg1b91tdBPwJtE+Jp5c=
X-Received: by 2002:a05:6122:1d4a:b0:4f3:828:7a47 with SMTP id
 71dfb90a1353d-4f6ca2da2fbmr3128684e0c.6.1721926140905; Thu, 25 Jul 2024
 09:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142738.422724252@linuxfoundation.org>
In-Reply-To: <20240725142738.422724252@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 25 Jul 2024 22:18:49 +0530
Message-ID: <CA+G9fYvCyg1hXaci_j-RB4YgATb458ZqRjJSye4qub9zYrmL_A@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/87] 5.15.164-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 20:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.164 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.164-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following build errors noticed while building arm configs with toolchains
gcc-12 and clang-18 on stable-rc linux-5.15.y

First seen on today builds 25-July-2024.

  GOOD: b84034c8f228 ("Linux 5.15.163-rc2")
  BAD:  1d0703aa8114 ("Linux 5.15.164-rc1")

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-------
from drivers/net/wireless/ralink/rt2x00/rt2800lib.c:25:
drivers/net/wireless/ralink/rt2x00/rt2800lib.c: In function
'rt2800_txpower_to_dev':
include/linux/build_bug.h:78:41: error: static assertion failed:
"clamp() low limit (char)(-7) greater than high limit (char)(15)"
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                         ^~~~~~~~~~~~~~
include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
   77 | #define static_assert(expr, ...) __static_assert(expr,
##__VA_ARGS__, #expr)
      |                                  ^~~~~~~~~~~~~~~
include/linux/minmax.h:66:17: note: in expansion of macro 'static_assert'
   66 |
static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)),
 \
      |                 ^~~~~~~~~~~~~
include/linux/minmax.h:76:17: note: in expansion of macro '__clamp_once'
   76 |                 __clamp_once(val, lo, hi, __UNIQUE_ID(__val),
         \
      |                 ^~~~~~~~~~~~
include/linux/minmax.h:180:36: note: in expansion of macro '__careful_clamp'
  180 | #define clamp_t(type, val, lo, hi)
__careful_clamp((type)(val), (type)(lo), (type)(hi))
      |                                    ^~~~~~~~~~~~~~~
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3993:24: note: in
expansion of macro 'clamp_t'
 3993 |                 return clamp_t(char, txpower, MIN_A_TXPOWER,
MAX_A_TXPOWER);
      |                        ^~~~~~~


metadata:
----
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2jkA3TgHM4HJPklKlKvochTS6Sk/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2jkA3TgHM4HJPklKlKvochTS6Sk/
  git_describe: v5.15.163-88-g1d0703aa8114
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: 1d0703aa8114ca7fa386273d01ed8a7e1b66d335
  git_short_log: 1d0703aa8114 ("Linux 5.15.164-rc1")

--
Linaro LKFT
https://lkft.linaro.org

