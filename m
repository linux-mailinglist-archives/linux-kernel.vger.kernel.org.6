Return-Path: <linux-kernel+bounces-410405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B039CDB18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98ACFB2279F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C7518CC1C;
	Fri, 15 Nov 2024 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="tXfKv/XC"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276618BC36
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661660; cv=none; b=pVnFvhqrrPLvl9p0zxNKLTBRAvZ18Wfh28LLcH8aTZukHE4BBOjdlqSfGKCjaSAGO7AOvJPjnxO9QLjJOfq0zRCFK1Qztc2Q8gcGVKsWb2A3LP5cIVsiMRgLwaLyBGNvUXalC5RTZMGJ32jVHTL6iyRVAZv9gKqLVbLzMEOcUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661660; c=relaxed/simple;
	bh=LX2q62WYby1zXSo+OspoR6SQ4JOEQtEGQY1uhwAGwsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rr+n58tT1A+NqpHwkJMya5kZrYwK4feNIjmUc8XIpg3XyQxOIzDOmz9anAeNHpOoYSAAy8rdlWODrdbddt1C2Hl+DqBsOUGuDxJnPrAxkq1ruvtBDhxNv/W9qGACMivcQ2DTLr7W9bQdpMOzVOOru17rRHmXUdIePlwUJ9pjrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=tXfKv/XC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so1231468b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1731661658; x=1732266458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/GGcDKwuNPpMFO6GIJo1U2NCmyHIGhmOInYHhaYUCk=;
        b=tXfKv/XCsYU5lC0X13pUcbWJ6VDCYtcRNu2i1Oud64L9LZvIJB1bEGbD7EWz6E8Mwa
         j+rPT/2uKdUI6fvxk2lV2Lv8YOmA6mbx6Fu9Y/YjWtDYoAiYNqbI3EPDL/wK/YIskhAg
         UjCjLdCztHce0cjVzexF2/Fl/RY76D9Jtt+nAN5lhIauM63fxmJsp+wg8m5NJKUrc0UO
         i4Zm6H+VgKTQ5ww7BDOAQ56dHv1c7Z9UQp47nQ5tWuiRe9XgYM3pAHhl4XoKDfcCdLsF
         Txw5h8rCeOnEW7SoghafUVqrY4yHWr3y0rMbD2ABhjKRZ7FFxxOMBry8IYHdr6w3R6sx
         /NVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731661658; x=1732266458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/GGcDKwuNPpMFO6GIJo1U2NCmyHIGhmOInYHhaYUCk=;
        b=QpAwDT5oCSUwnFsu/SjuKS9l+E6d1ievBp6cfhxZt6aAYsKmk2XMT7dH4TX1rjOfg6
         130T+sTR6LtQgsvd6/UsjomR0WW8g70oZsTvHJC/2IS035zfCV5Q3rIReYfYrolIvylG
         LSFB7pa/cx3rytn21UeBM5KWpAnMdWtPyMsgMizaV9+3FXSuc1JldUVQ9MFBQjQ39znx
         HzAZRz2x3ChvKln4Y67QcRyLaG3TRAoDVsJY3zx6k+isejOxzpmLidqXE6yDX2RqmjxO
         dkeLDqC9mgRpYjKk9xMF3IpQ6/xMl/FkpIFwUW8ro/TZqczuBOdVCk81aXmBg7Odgod9
         gh0A==
X-Forwarded-Encrypted: i=1; AJvYcCWhCiRBxBUl1Oe0xy0s5ZG0QdrLXl1nHyj6qmK5do7Znr0LAjXJuASZV5gZCoHxV/s+9dYoCAGZxoJHJ7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYDNCt0HQap/V6xFpGcec1F9/jA4Tai7/3CTYYtoVlhDdx37H
	YSDaDcZGQUfPV16//e5hD678aUkjCDb/3SAS7JCMTkbWOF6AtGM0s5kCln25MAiX5Ecq8fTP774
	Ng8rdrUzeTTJRpGCoR0CzUdCLVptWGbf4dQzQlQ==
X-Google-Smtp-Source: AGHT+IEipBAtaSO6qTco6CXlymxGLqUFgKpppjq1+DZHQLwOzlZTO2vDwCJPay9SltCtNZBs+tQmMU2jQDqrwF3BKco=
X-Received: by 2002:a05:6a00:188e:b0:71d:eb7d:20d5 with SMTP id
 d2e1a72fcca58-72476b96ccbmr2943756b3a.8.1731661657842; Fri, 15 Nov 2024
 01:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115063722.962047137@linuxfoundation.org>
In-Reply-To: <20241115063722.962047137@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 15 Nov 2024 18:07:27 +0900
Message-ID: <CAKL4bV48qydBq=_LGWDHW=bYB5JPvKa=3Nwg1WZC_aU3Upf8Zw@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/48] 6.6.62-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Fri, Nov 15, 2024 at 3:51=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.62 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.62-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.62-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.62-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Fri Nov 15 17:47:19 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

