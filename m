Return-Path: <linux-kernel+bounces-204479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5F48FEF9E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1921D1F22712
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10F31AC42E;
	Thu,  6 Jun 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NV2mbL0N"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07D19A290
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684283; cv=none; b=m6qkEK1byaiw8rd1YMD1bfjagWC9V6JAadjetcjILaWk/XCwA2Fzj2HmRxu4ScNDPgd0KHbw9dAOC7rr7MeFQ1hj8BbSPtqvtAhF45gUIq1hyt5hQStdWDYMa0vflVjphQ8glqziJRch64c+RFUFjbeLTLX6PfTLas7fG1m6DVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684283; c=relaxed/simple;
	bh=rmmMpzdyFfWteamtgVIF5tn4EX415jCjZRCHwTpxgvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Faf1/1TW7NItYllyJvtXgyqvIcHhfK2nIZsO3uw+atfw3YFOl9IdURtiwAVLCfV3AnOyi7lEB0Vk8F18Ncg5JmEZleAiqms7qmtfA0MUO847ysUnJqM8RNxssaJcPFEs8LVqZFQPWbA+KLBDGbrXRL+29HOnSx/ID3iZTDkKFwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NV2mbL0N; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so11423091fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684279; x=1718289079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LC4tRTIHi//VBdNQZVHv125hh2tQ2QXg5+VbtzAPUpE=;
        b=NV2mbL0NtmtZRowFGYpzah+WHCPSrsF8W/Rcv8QfNt2P2xuq4GfgMJz8+z9Paeccz+
         q50zeRQMnSog4l9riklPT92iyNvbNkUE5OvHL0nifVmV7XSsk489oHmjFy+9JjFwQIGk
         rQ0mx0dP0sm1qbcDeWYv83O/x8E7uw5wVy6sknVqTm8zXVRsh+7hCnAJsZPh+95+nwTx
         YPxbzfRxlpmnOZnDlKzGEKZAhN1lDAyiL7PaclrEMPR4TYlaKoIBwdVVESceY6wzND+4
         5vBG96UtoKBgx+vEL/5S7tbHjdd1G3Do44AjgTJ9FXqUdSkNQzthFW0t2PvstBkd4G6X
         WWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684279; x=1718289079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LC4tRTIHi//VBdNQZVHv125hh2tQ2QXg5+VbtzAPUpE=;
        b=H357v+hEGjlSwGRTXn/uhdrlDX+QTVghuC9ENXAbEDbg173D0BYPcJqwVJ6fHhNhuJ
         2tFw5UwsRSsACq0mbKTm4g0MBI5NQeobQtc2j0Ay2nq+uhkfA+VvyUdioQPynS8r/Wuj
         qDBPwZiVZJYg98ezsbeWEtddMP1/bnUDpt3yWoZhZIFF8jf7CaDW0SyNeQUThmGRq05m
         Dqp2nhzHMgzCkPiE3nSsHSDdkTOn8Ac9QgRSrf7xvq53X0KmBsYbcl4ATqdPSzgFot6J
         1fs/vSgcX97/PiccxxMub3cuqdV+YKDwLwU3jt6nSN/y4pdSYJqT97FcWvgf7ew7etjN
         hgHw==
X-Forwarded-Encrypted: i=1; AJvYcCWJK971/uVK9B4bEhBejqfPXjvTSAjm+YYqqeEahWD5YFtpgrMTyJoXTiCeG4EUIauTDtzlH1M9WzPDEAotX7qMdUzxqtgMP+bpHH5F
X-Gm-Message-State: AOJu0Yx0YZlC2zTwv+kpetmKvuM+SnUzVyyuA/mPMZjCFWVlJjY8jpH5
	WY7LSrwGH3wMMRpoTGIr+oeKOZ3Q53oExmQ9ejExF1y4Q2nrsI9fZS254NGJdkS9f0iIEMf7DS1
	2d1TWuvzo/TR2a+uZ0ZCXXvujuDHkfBktgF2d33dGWYHqRyd4iHTdIQ==
X-Google-Smtp-Source: AGHT+IHMLnBPcN3irSS+eA2p+kw7vDvQ9FAixpR7MCh8sCi1r1oCN3gjs7NJKZlOVqI7Ebk24TeiFHvs2oANd1cDbag=
X-Received: by 2002:a05:651c:1504:b0:2ea:7a0b:7935 with SMTP id
 38308e7fff4ca-2eac7a08d3emr36700041fa.24.1717684279295; Thu, 06 Jun 2024
 07:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131659.786180261@linuxfoundation.org>
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Jun 2024 20:01:05 +0530
Message-ID: <CA+G9fYtMCm-iRDfhq-H5nENO=OyH+wN+HfwHUhandK0JKV_nnw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/473] 6.1.93-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 19:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.93 release.
> There are 473 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.93-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The Powerpc build failures were noticed on stable-rc 6.9, 6.6 and 6.1.

Powerpc:
 - maple_defconfig - gcc-13 - failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

arch/powerpc/include/asm/inst.h: In function '__copy_inst_from_kernel_nofault':
arch/powerpc/include/asm/uaccess.h:177:19: error: expected string
literal before 'DS_FORM_CONSTRAINT'
  177 |                 : DS_FORM_CONSTRAINT (*addr)                    \
      |                   ^~~~~~~~~~~~~~~~~~

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.92-474-gd2106b62e226/testrun/24218239/suite/build/test/gcc-13-maple_defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.92-469-g50926b327d43/testrun/24206687/suite/build/test/gcc-13-maple_defconfig/history/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2hVb12s1n1cz2MGh802HcC7iWkd/

--
Linaro LKFT
https://lkft.linaro.org

