Return-Path: <linux-kernel+bounces-290792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777059558BB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 17:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9FC1C20CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428A41494DC;
	Sat, 17 Aug 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nftuxcRl"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C48F40
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723909202; cv=none; b=KeC9eHEBjjhcEC7lCbZsfuvz+c29hMV2cg4Not+5LFFqgjdy3PJunH8NC3tGmKYvUOCJmuIRSes1qZtLoVb20/kN8SxNToSDY5uaOfh/2g+EoUKf+QdYJEbnmEh35o5okWBjiNQ4JWjS3lTsFZX+5WXyCvqCLOBncyUZLQilJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723909202; c=relaxed/simple;
	bh=+tzeaKbZ3wXqBh2YX5z2yPeSMdZb1tAgkHcCAOIOSOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUZ9IbDyoMaZTrP7uQCvv+BaIkqJLhiRnvkMRL92ihx/gTdUo/dGRSZHawyohSWienJbD4YfNkgs/Yzwo73urXafCmicSxyBWe/5JNzBOj8nZ2k9SkDICvFrWCb08arC/d7nH0EqCKMU7sRQtQueS2Yw4MRjAo9a50MXUvoOPqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nftuxcRl; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bf90d52e79so2083346d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723909200; x=1724514000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNBm3qjSy5qMMK53bE87AwOPaQn+kCh2D9IAJ17szRY=;
        b=nftuxcRlVfDt8kEWVYHzJN5v+TBSLPvNK43LJSuY3U6rfQfy12Np9LXCpH0CZFjTY+
         5XvmdoKRLHgzXiPetvuGCvffTx0skU8GoJhT6r8ix4Av+6ocDFcDdrcgCyfbD4/FL9fg
         pKnUVhm84dfmCXCv8kzhm75I/EXHUKP47OUEIxp9g53NGZ8rW9jda5YbucmZXfRLrlAZ
         irOFtnhhyWLK1LuBC9Vl8GkAusJDWj1/Dcz+6gfKJKAON1cUwBk5ww8wrtFaKLiQCFSM
         pMICGT8LtBVXEPC17PN6ipqDBeSqfbzyOHfdWeiFnU8kg1y3Xc/4/0bBk7x+EhWpIMz+
         79Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723909200; x=1724514000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNBm3qjSy5qMMK53bE87AwOPaQn+kCh2D9IAJ17szRY=;
        b=Chqqc6rTDMVvjAikegCxK7vkHKxJ3DTPMIniSVvvR17+VCjqD+ikXQUO+uGlrs9oeY
         +Fv9ZmrrzBCMrG6ctr3sDx3nbuRFIrFjYxfgDYdMnU0cJZJW7u0VNBBGUP4VDFq7PZG3
         JltSTUBJZ20sfsXdC+qG/nPWBXCe1McePkpZeWfOexSv0FQ6k71gQEkKhsbS0MeRYHWi
         pQsddu8iQ/MalLRM+dtDdF1+UHu6+vfsneRbeQ5NUZThmFCA5n4pUZe6Rz4pt/8QhqHE
         FM7E/4CuQemeHlxh8REC3t+5tMMPg68Vxw+VQQUTzTZUp0v2bw68XY4arZ1fzlSJmwvS
         fOqw==
X-Forwarded-Encrypted: i=1; AJvYcCWe8Rp5w7dG6rsVOv01ecDvWGEsEK7cbZZCWz9npEvCzyVDebUoIzzdyWdjWom0py5ex3VGyJPU4c7XAa+1rmQ3X6PBuCuCb3jOQ7ac
X-Gm-Message-State: AOJu0YwKnzd+CW7PY/0FPIeHtd6+bNu2CPDZpyLfy0vwv8Fmk6xeus86
	oEQAFOLbXoONf3WFX0Jv9R3JokRi+nY4ArCBp9zqltMAr0Gh0IajvxeYDc4xnra1jijNGEqJTqN
	KzbspJ3ohZTsW2iYu3slsjYyyIvOsVjrvSomjdw==
X-Google-Smtp-Source: AGHT+IEadpRL8Jv6RZt+8WVKsffMlrSHeIJHNVZpBdeFc3pSSRb+C20YqvoECyKpXKPIZnw7z37bSTAoeYIB6ZLpoTA=
X-Received: by 2002:a05:6214:498d:b0:6b5:4aa9:9686 with SMTP id
 6a1803df08f44-6bf7ced6631mr86203366d6.42.1723909199600; Sat, 17 Aug 2024
 08:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817074737.217182940@linuxfoundation.org>
In-Reply-To: <20240817074737.217182940@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sat, 17 Aug 2024 17:39:48 +0200
Message-ID: <CADYN=9++QDcougZ_xJOLf8otPOrrFcwaJe_gL7ZYmmw6gDXWmg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/345] 5.10.224-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Aug 2024 at 09:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.224 release.
> There are 345 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 19 Aug 2024 07:46:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.224-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following S390 build failed on stable-rc 5.10.y with gcc-12 and clang due
to following warnings and errors [1].

s390:
  build:
    * gcc-8-defconfig-fe40093d
    * gcc-12-defconfig
    * clang-18-defconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The bisect points to 34a325f5a22f ("s390/pci: Do not mask MSI[-X]
entries on teardown")
as the problematic commit [ Upstream commit
2ca5e908d0f4cde61d9d3595e8314adca5d914a1 ].

Build log:
--------
/builds/linux/arch/s390/pci/pci_irq.c: In function 'arch_setup_msi_irqs':
/builds/linux/arch/s390/pci/pci_irq.c:298:9: error: implicit
declaration of function 'msi_for_each_desc'; did you mean
'bus_for_each_dev'? [-Werror=implicit-function-declaration]
  298 |         msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
      |         ^~~~~~~~~~~~~~~~~
      |         bus_for_each_dev
/builds/linux/arch/s390/pci/pci_irq.c:298:44: error:
'MSI_DESC_NOTASSOCIATED' undeclared (first use in this function)
  298 |         msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
      |                                            ^~~~~~~~~~~~~~~~~~~~~~
/builds/linux/arch/s390/pci/pci_irq.c:298:44: note: each undeclared
identifier is reported only once for each function it appears in
/builds/linux/arch/s390/pci/pci_irq.c:298:67: error: expected ';'
before '{' token
  298 |         msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
      |                                                                   ^~
      |                                                                   ;
/builds/linux/arch/s390/pci/pci_irq.c:271:17: warning: unused variable
'irq' [-Wunused-variable]
  271 |         int rc, irq;
      |                 ^~~
/builds/linux/arch/s390/pci/pci_irq.c:270:13: warning: unused variable
'cpu_addr' [-Wunused-variable]
  270 |         int cpu_addr;
      |             ^~~~~~~~
/builds/linux/arch/s390/pci/pci_irq.c:268:24: warning: unused variable
'msg' [-Wunused-variable]
  268 |         struct msi_msg msg;
      |                        ^~~
/builds/linux/arch/s390/pci/pci_irq.c:265:56: warning: unused variable
'cpu' [-Wunused-variable]
  265 |         unsigned int hwirq, msi_vecs, irqs_per_msi, i, cpu;
      |                                                        ^~~
/builds/linux/arch/s390/pci/pci_irq.c:265:53: warning: unused variable
'i' [-Wunused-variable]
  265 |         unsigned int hwirq, msi_vecs, irqs_per_msi, i, cpu;
      |                                                     ^
/builds/linux/arch/s390/pci/pci_irq.c:265:39: warning: unused variable
'irqs_per_msi' [-Wunused-variable]
  265 |         unsigned int hwirq, msi_vecs, irqs_per_msi, i, cpu;
      |                                       ^~~~~~~~~~~~
/builds/linux/arch/s390/pci/pci_irq.c: In function 'arch_teardown_msi_irqs':
/builds/linux/arch/s390/pci/pci_irq.c:371:44: error:
'MSI_DESC_ASSOCIATED' undeclared (first use in this function)
  371 |         msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
      |                                            ^~~~~~~~~~~~~~~~~~~
/builds/linux/arch/s390/pci/pci_irq.c:371:64: error: expected ';'
before '{' token
  371 |         msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
      |                                                                ^~
      |                                                                ;
/builds/linux/arch/s390/pci/pci_irq.c:359:22: warning: unused variable
'i' [-Wunused-variable]
  359 |         unsigned int i;
      |                      ^
cc1: some warnings being treated as errors


Build log link:
--------
[1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.223-346-g2810e3a9f5d6/testrun/24902188/suite/build/test/gcc-12-defconfig/log

metadata:
--------
* kernel: 5.10.224-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 2810e3a9f5d69d54c8932173cfbd380f16d36b5a
* git describe: v5.10.223-346-g2810e3a9f5d6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.223-346-g2810e3a9f5d6
* arch: s390
* toolchain: gcc-12, clang
* config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2kmIhNosE42gaZLyeRO6utnwevO/config
* download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2kmIhNosE42gaZLyeRO6utnwevO/

--
Linaro LKFT
https://lkft.linaro.org

