Return-Path: <linux-kernel+bounces-290552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EBF9555A7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 07:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6771C21547
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 05:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D00012FB0A;
	Sat, 17 Aug 2024 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBnMZ+fD"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031412CDB6
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723874156; cv=none; b=hd0bnvFJ2vjdCbt3un5WG3OhLfu+ej7eTPnk2R+NBDUpl3jfYFU78ldiNFEbPFbFVMGvYXQotyWaGGArCqK8YbhDcFqybjLy3jYMyC7rg+C9mg2oN2vjSBPORlja85a3+8rIiRBNc5Cl5fF+OgS9ei0oOUdhr1EQPxqgC53mtEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723874156; c=relaxed/simple;
	bh=x0tjE7zHG6lY5cEzWOOeiKPc6Ssm8TTI/c6m7gLX1m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0BZppYWzWZAfOq2z7TgIMFcYvDIsysFPmk6UTZRM8PUEhr/gyMb6zVB2TRQIOt0LKJLQXowvX9Vqwfl6vPDtHcu3eOGRek+shaOIhL/fWTkNTAzqxaktd/mcG70N8RsYxZBAPud5jKJhiyePiRetuc+cqFKphZDM2Z26fJsLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mBnMZ+fD; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf6e17cc2bso14235456d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 22:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723874154; x=1724478954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zO5DfF0viHSdHtAQMPfC+hUUBY2ki1Sd9boOM/ZvnhY=;
        b=mBnMZ+fDXvEQbKI9uWvD70HYjaGU7P/qKYovbXXMonRMZ7SKQrL6BMbmRZ2Ec7mWYu
         kG9qkJtaiF1dCPnWH9fbnN/ZlZuga3KvbTvejthR9phDklMpQgWoKGDCETHm3LERfexM
         XqCnvQXPh3VYhxOE8SUJtiFYY7i5faazjYO7ND13rC0sk5ndxTshLY9NfnlRzkWLkrXc
         E2lPpGdq0A4e5Sc8VWtQ+vSQUUjG2ToKQ/i+kSUjWt7JQ1zDJw+9vYM53ECJHGzTbuqO
         t3gt/cHow3UcLtyoUPfbxeGX4ZnMdeHIG7Y9BM0vrE28/Kjl4g80UnsbYTtjl5WJOl4V
         4Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723874154; x=1724478954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zO5DfF0viHSdHtAQMPfC+hUUBY2ki1Sd9boOM/ZvnhY=;
        b=WVwJfBkL1Go3Q4/ED4dLv4clvIUcsq1uSY9ofPhQs6175yUFBWzFIz/ExS+mhVdflg
         nt1dbzD5zoaXLocxOQrCUf+zf3UafVlqmmJGKN5RtFeHyD3LN5OAL6ZPuV24gBcj4SZT
         E+HNK+gtZhDEMLTv5/QJTwbJWvikjn8CZJJSdC87EYzunieptC1OqFXnlaYIN+CbLnmA
         HJUOh8Vwwl6ved371UNEWQdHfycyOmXWhrPslCeZJTcl5SZ+ihHXVYNkdmx19uwjPabt
         7WXYrJFVc3WzmR97pS5Ms67s9xCHU0M1pXf2uH5F2eWt8VxBHQFx6wbyVTmrVfzHxTPM
         x+lA==
X-Forwarded-Encrypted: i=1; AJvYcCVc9QWaBR06r7C7ZXmiU+9oDZgeriAwYfP8uHsCBC1lcuPDWdXGbNIHHfNW098oiJ76Rq7i7/ExAHQN7YA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9CAqC5bs8LTCm5fFSOgdnnqBPIGZYmb+TThF61tz0laAOs6X
	SuLEoFFdjZ6Eklb4J8C18bjE1MXVu6mFzujlqheqc3sa9Psi1hHjemD8Yz5hJ82lg1iZT/MTG40
	+zdcqooPXzrrRCte5I4onWHDp7RW1LMYVaDA2fQ==
X-Google-Smtp-Source: AGHT+IGxPjrv7dCSE/Do/bjou+Y4IoMXg01+vIkSYQmvAsJPrtNyj03mz3wUw+BiG/VwsTp6/e075xN4f1duRl7HfrE=
X-Received: by 2002:a05:6214:3f86:b0:6bf:6127:98a7 with SMTP id
 6a1803df08f44-6bf7cf1c06cmr51142686d6.56.1723874153746; Fri, 16 Aug 2024
 22:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816101524.478149768@linuxfoundation.org>
In-Reply-To: <20240816101524.478149768@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sat, 17 Aug 2024 07:55:42 +0200
Message-ID: <CADYN=9KMRjaxqtcc-Yo9ZDK3b2HH7gzJiwTrUXz7t0x0TO6=uA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/483] 5.15.165-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 12:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.165 release.
> There are 483 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 18 Aug 2024 10:14:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.165-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following S390 build failed on stable-rc 5.15.y with gcc-12 and clang due
to following warnings and errors [1].

s390:
  build:
    * gcc-8-defconfig-fe40093d
    * gcc-12-defconfig
    * clang-18-defconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The bisect points to 85cf9455e504 ("KVM: s390: pv: avoid stalls when
making pages secure")
as the problematic commit [ Upstream commit
f0a1a0615a6ff6d38af2c65a522698fb4bb85df6 ].

Build log:
--------
/builds/linux/arch/s390/kernel/uv.c: In function 'make_page_secure':
/builds/linux/arch/s390/kernel/uv.c:219:19: error: 'UVC_CC_OK'
undeclared (first use in this function)
  219 |         if (cc == UVC_CC_OK)
      |                   ^~~~~~~~~
/builds/linux/arch/s390/kernel/uv.c:219:19: note: each undeclared
identifier is reported only once for each function it appears in
/builds/linux/arch/s390/kernel/uv.c:221:24: error: 'UVC_CC_BUSY'
undeclared (first use in this function); did you mean 'SIGP_CC_BUSY'?
  221 |         else if (cc == UVC_CC_BUSY || cc == UVC_CC_PARTIAL)
      |                        ^~~~~~~~~~~
      |                        SIGP_CC_BUSY
/builds/linux/arch/s390/kernel/uv.c:221:45: error: 'UVC_CC_PARTIAL'
undeclared (first use in this function)
  221 |         else if (cc == UVC_CC_BUSY || cc == UVC_CC_PARTIAL)
      |                                             ^~~~~~~~~~~~~~
/builds/linux/arch/s390/kernel/uv.c: In function 'should_export_before_import':
/builds/linux/arch/s390/kernel/uv.c:249:40: error: 'mm_context_t' has
no member named 'protected_count'
  249 |         return atomic_read(&mm->context.protected_count) > 1;
      |                                        ^
/builds/linux/arch/s390/kernel/uv.c:250:1: error: control reaches end
of non-void function [-Werror=return-type]
  250 | }
      | ^
cc1: some warnings being treated as errors


Build log link:
--------
[1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.164-484-gaff234a5be72/testrun/24890486/suite/build/test/gcc-12-defconfig/log

metadata:
--------
* kernel: 5.15.165-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: aff234a5be72ef6e0a85246b992f6ec19cd59812
* git describe: v5.15.164-484-gaff234a5be72
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.164-484-gaff234a5be72
* arch: s390
* toolchain: gcc-12, clang
* config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2kjlB8pPtrlqwxjAoqVX8sFQDpN/config
* download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2kjlB8pPtrlqwxjAoqVX8sFQDpN/

--
Linaro LKFT
https://lkft.linaro.org

