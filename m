Return-Path: <linux-kernel+bounces-367640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A49A04C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA01C21B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255D720263F;
	Wed, 16 Oct 2024 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zBaf/9d/"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2481F80D7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068903; cv=none; b=dsi+9hSuNopA1cDfJh6lkiJmZseSu6DThUY6o7/a81nr0XFUVAZfgKZ+vx6qIBzp8MW/jApX/BmYPgdUOkC5eotJ4NGtK4MaTY0VNgVoIZDU/PTVRV7JJUNikIxYe14A9boouaRqCkB3B/VCeIalNXuv2utcxSADo/730DjxhkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068903; c=relaxed/simple;
	bh=0ooDMGKzrk1LRoPou2txp9yefFiEl/aBC0G6Fiy+HUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKKox+/B5O8GMUmWQOwrgBbT2aTDLP9FjEfMOL2mYNRluRXp2PxWEDdjnsZ/zoUZ2fyfOf4EwMXDouCnA6bPXf2DPJj65ssyFs/Td28fHs/vx5H7DSXXVXeEPlAWDQ7zo9fXW8eIPVFf3vV41f2M7hoJQHxfPCo1mFU+klM1t48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zBaf/9d/; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-50d46cfcbc1so1202774e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729068901; x=1729673701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aM1j+CmDA5rs0zqyd0QFs7mI1QpTz4ZuLqOJ8HwBQeg=;
        b=zBaf/9d/lts4o8Ko+bccyAtlvtpF6AZW+3E22/FVneRlOX5IiSlkFNNSGIChOcJ6HJ
         4eF2MI/F8zVRTNFQ6BFnAHtTyZRfYxQ+/Bln6TETcslHoWLBrhV2rQJCO4FkFKtf7d39
         r9hUqNUmD7m+mYs40ESYaYKRMljoylqaBybS48yzgxpHmVrqSzBgmOo/D7/saWdx5EZ+
         pIXYmPnN0SdcPncbpVGBZt7NuFgiYXZ1r/2NHUZ155TRugRryhwDQdmR1wJ9Cxsbqijg
         OcwgYGisrA71gyPkBOOmmZn/uscyYXTDjsJhlQpVlGpQUPQUyC2Xj5umlvnlwDFRYFNe
         +OfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729068901; x=1729673701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aM1j+CmDA5rs0zqyd0QFs7mI1QpTz4ZuLqOJ8HwBQeg=;
        b=Cg5WKhVF3I4EIT2NlzER3zSiNqGAgx7qH3QmXCojQ0MQwFRjRZfXknX1jf//yimmAN
         xhW9IcprCvJ4d23l/lLaAzLnrL/1KWP5bHpLjhHfaPcGUQLRyV3qytmTkgZSc0Nz9Tdx
         UTqZDwTx0UCz07tPw1S77/sHsfBJPzMtq+4ovcYOarY487fS6dJKSmocixo/WQQSx8a+
         91oPtQ141xjjJgiKxtjuwaBACzXIP0+5Yz2q2xkOyR1mCF4QW9WqHCQW1MhoLsK3kR+R
         E//m3Phh2jmhMEGEbZYiOsyiJipuF6AvSr4sstn5rr1vRYxlhch+iyRl+KdUiqTegZ6F
         cACg==
X-Forwarded-Encrypted: i=1; AJvYcCVjR9k6AyVTPRKsu3Qkn+jAxTxx++oL5qhVtt8JIcGEt3+oXJZ06KRsCw9LX2scef8iodF8u0pejvx/7H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfAbIZ/HslgnotzUYxwbKUk8WZHPAE+Cc6w+aWDqiwdl4pmXcd
	mi8ggvfTtIWhf2piKijWWL+9KJtQBevAZybZA2nxIgdGvNxLjqCFrptqfLer4bQDDUcmS6C4uVE
	Ch49uxoTp4d50jsx+qEhivRv6+ZLPvwfHabWFFA==
X-Google-Smtp-Source: AGHT+IFj1BIMhN2y2ujDgAuHcdv2pSDskTuzb3rgrptZ7N5fVnXHbsRKomX3FKehRMuLXTjo6jvoeqyRgKvU0F7lrlI=
X-Received: by 2002:a05:6122:29ca:b0:50d:354a:19ae with SMTP id
 71dfb90a1353d-50d354a1d7dmr11686940e0c.10.1729068900898; Wed, 16 Oct 2024
 01:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015112440.309539031@linuxfoundation.org>
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 16 Oct 2024 14:24:49 +0530
Message-ID: <CA+G9fYtTO8QbKEhggzOk-n+pBk5pEHenCfgs2RdQd=Ztsi+hnA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/691] 5.15.168-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, LTP List <ltp@lists.linux.it>, Jan Stancek <jstancek@redhat.com>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 17:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.168 release.
> There are 691 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.168-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

From last week's regressions reports,
The LTP syscalls fanotify22 test failed (broken).
This regression is noticed on linux.6.10.y [1], linux.6.11.y, linux.6.6.y and
the Linus mainline and next master branch.

Now this has started failing on two additional branches linux.5.15.y and
linux.6.1.y.

 ltp-syscalls
  - fanotify22

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected to patch
  b1a855f8a4fd ("ext4: don't set SB_RDONLY after filesystem errors")
    [ Upstream commit d3476f3dad4ad68ae5f6b008ea6591d1520da5d8 ]

There is a fix discussed and posted in these upstream links,
  - https://lore.kernel.org/linux-ext4/20241004221556.19222-1-jack@suse.cz/
  - https://lists.linux.it/pipermail/ltp/2024-October/040433.html

The stable-rc 5.15.y (5.15.168-rc1)
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.167-692-g63cec7aeaef7/testrun/25456713/suite/ltp-syscalls/test/fanotify22/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.167-692-g63cec7aeaef7/testrun/25456713/suite/ltp-syscalls/test/fanotify22/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.167-692-g63cec7aeaef7/testrun/25456713/suite/ltp-syscalls/test/fanotify22/details/

[1] https://lore.kernel.org/stable/CADYN=9KBXFJA1oU6KVJU66vcEej5p+6NcVYO0=SUrWW1nqJ8jQ@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org

