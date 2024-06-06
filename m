Return-Path: <linux-kernel+bounces-204471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7368FEF83
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9478285A41
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44091ABCC1;
	Thu,  6 Jun 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0ggKR6R"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC69F19AA54
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684065; cv=none; b=tmV7HDDxdthbA/3s1X3hwoTfjebXCz6rhOfpIJUOHZHTMYPXkXUi9DZhiTwNIewozySTZQ+WkUR10jG2Yn8DjtBFr178pa2ScC6sRkI0IcvH9dDsj04CpPpHRM8X47bLhrZp7I6HitpoT4FeX4g2IspNoioNyWoq+XBKbcU5gT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684065; c=relaxed/simple;
	bh=zgz2bLOFJRkBwOEW5RaCFDEbiZHMyOTfAejaJyCZblg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWkVrQTSYEwYM96yMLjEtN9yMfltzkVHI9CtAlKK2w5+FeHGuXnbEIXZKDCdZIUTFW/9eJotbC8eUE7cOpsGKu3uszzryqd4sJJOvW+VlfvyUU1PgynqcITn/vZrJcX0ZwcNXIOngNJlytbwh0Y+by4mjDq6HhqKQvPHSmdUfik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T0ggKR6R; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so1113965a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684062; x=1718288862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DXB1vdhxU7ozzaIOv3LXxHYx4cJj0wQEg5HvR8ydDjc=;
        b=T0ggKR6Rr9DJJ0xca52554+6PUnuOKGLzlJ8+TCCjQLBBPjXncDYJgHL/ILrnmeCWY
         gr3bAJIRdgfItiYNELe03WZE5iucyBWi/vSCdOdXUR2y7A9l1vWMzWcBINT/37d5ouvY
         77temUAk1dpUQAM/LOZL1c+VrgshuG/vVAy25/EQsUmvUjPUINRt7aynoSK7WCfIQ7MP
         4kwLzvoG+l0elZXqYKx2NflaMUTXVXUr2EdLbcT5horQ5FGjC0NdpgglM86sAh6O+hmF
         pNnEHackePWRXLFLl2Tor2Mh2n6DIGRddAg4jgsssqtm0pJH4rifyaqQZMcYz30octAz
         OWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684062; x=1718288862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXB1vdhxU7ozzaIOv3LXxHYx4cJj0wQEg5HvR8ydDjc=;
        b=YnYv1t00mNr6fc8obxp4XMfuD73u0Jncc41sfjO3ojSEnCdJVxcQHFfAq5U6C2l8jc
         RGA3AE505++qGouHBXn5to86vm91h7TbXKeKSjji+q11L3ozz4av4hNGdJGjKRNmZvJd
         OXZG4/wyuXP3c/B3Y4s7XwIOROiOjdGFirqN8wpXjqjRqMOwIhjW9I+Yddgc7Nx3WPhZ
         fC7+2RLrggHhiSp2rTWUAlEBtIwj3obNwMRvHshwq2csUQ3DIly3oddeFHbiX+1RFuiA
         de1Ex7geJLbAZHKuACr9BVtTWtW6upyjELV8Q7YCmwkMH6A63UaiHYVDZBNCJzqCe9Hn
         1kkA==
X-Forwarded-Encrypted: i=1; AJvYcCVn3aj9A5w1WVRcxY5yZFn0E/8BIO5rpqvJC/RBbobxZixliWaQ59LRyYnt2/KokRqZ+ubArwkbzj/klt/p/Ggna2iqTw6MQdqXG9F+
X-Gm-Message-State: AOJu0YyulAERz++Z/0rB5Gfyck078W7ylfJ3pQvrJYPjnwuDMupFJu8l
	Y83ysKpPAscnFLbPqPvkTmoYtzPyvtWq/iijF54Y8r5beCtDMNUyoldLS96LuNcYuUiD0vq0K5O
	k7NYId+vXdHTIausS5WMBHjc+5Yoi2eZKAdNuOQ==
X-Google-Smtp-Source: AGHT+IGu9Nb7LzeYBiQRctkm+Mte+Uml7Mcg4Wm54UUxwsCVucNqjC5EhuyxtMfysFzkWUictLWSdMHJTlM05oWiqTU=
X-Received: by 2002:a50:d5c8:0:b0:574:ebf4:f78c with SMTP id
 4fb4d7f45d1cf-57aaaf0eb41mr1306728a12.7.1717684062055; Thu, 06 Jun 2024
 07:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131651.683718371@linuxfoundation.org>
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Jun 2024 19:57:12 +0530
Message-ID: <CA+G9fYu+5dfJMBsZFECzkWc1cxzqWNNHpaKfOcZhZ4frUJNCOQ@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/374] 6.9.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 19:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.4 release.
> There are 374 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The Powerpc build failures noticed on stable-rc 6.9, 6.6 and 6.1.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

arch/powerpc/include/asm/inst.h: In function '__copy_inst_from_kernel_nofault':
arch/powerpc/include/asm/uaccess.h:177:19: error: expected string
literal before 'DS_FORM_CONSTRAINT'
  177 |                 : DS_FORM_CONSTRAINT (*addr)                    \
      |                   ^~~~~~~~~~~~~~~~~~

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.2-803-gfcbdac56b0ae/testrun/24217279/suite/build/test/gcc-13-maple_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.2-803-gfcbdac56b0ae/testrun/24217279/suite/build/test/gcc-13-maple_defconfig/history/

--
Linaro LKFT
https://lkft.linaro.org

