Return-Path: <linux-kernel+bounces-323976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DE5974656
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF131C256FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407A61ABEDB;
	Tue, 10 Sep 2024 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="lFOdaQHy"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0515E17E8EA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726010605; cv=none; b=VWe6AgfKCxyHfwdJQ7ZmblXNEbbLydxxTbTD3UJxe8eH16Y9yNxPbfQi9R2kw2oKY7rxgKGomnw1jPNNQ8g7vMia4eldWJQsWP5YXQDi3a5q2qGL+I5tub7791vXvl2DvQVK6r1AN+w/HZsAdCp8DHDIFtC15ezy0Tcecdv7UVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726010605; c=relaxed/simple;
	bh=KSvBi2d6vm/0KYuogrQllNQnrPvwHkhq7i8d/l/hgyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDt3fKktmsCMlJcN4QotdkKHfBptrQX/NmHn//YJ7u0cFcWtMGJe2GitxMG6+KUQUOCrEWZxm+vYANMtluCSPB/GNO0Uy3Vl0VabqgJY3STlPEMK2eumt4VL1uBFxIKxMZSLzFmOjKG6SIrqh9GQYqGEk/e4skjlZYGIbImGZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=lFOdaQHy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so37756615e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1726010602; x=1726615402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpXFBylcGnxCC+S0MaQQ7GUPPJbSvGD7+pph+6eGm8w=;
        b=lFOdaQHyt9fv+KCahyFFLj+mhzoZIOFwHrDRcYCACbfRmqexwyHgQIQFHVZippcE8V
         lQlFul6rfhY6aEkmZ/q1Vl1X2uexSibLJ50m5dhKwrAYavcnWN1aXzrdsuPHAuXlURRS
         wYRE8xhhJhQ4bsG5125nMyZqX11Ag+jeENbi4tKOEeWTMZwpusoQslU2KZTReIdY0CKS
         ZjbbSHCTG6WqmoRBDEjAuy/BrMGhxdDkE2pvCxVD3+sI95T50vmx+2yDIv6Sm5Lh0uWj
         ZpY1E/N/vxR03kSGGN5goi/GOglVb5trcjFJAr5yt7MHcKgYIEyOGNPZ3h4a/r9EVAHy
         9fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726010602; x=1726615402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpXFBylcGnxCC+S0MaQQ7GUPPJbSvGD7+pph+6eGm8w=;
        b=UZjAeJVI5K4T4WGcgkgWAz4qljuRL/AfWxs9+jvRwEENdFwsi0SFxL9QdsBBICmlVI
         tPzvI2ds2N+bLR9HPpNRKOcxjv3c/uVwMygP+VkAgN2hg3AR2hFc9tbaPPNWtXqQ8eF2
         6KXXlUDNFlxCgKuIW1QpKhyB6MUZ7WSQoxll6ONDYQhe7+cGIangp7ZrfHVGCE/LbuzC
         oyL7OdJ2OjZMJNCyHRNUmOwD0l6qjzm6vTrkyPeEuubHIf5WmoczjI1d19R9cAZW37HF
         a+39tzJZx+8ueX77nJrTRmNYqAwc03N9oOvNj9CIRIeZQevud/zrgmXI8VzPC17T4g5S
         6QsA==
X-Forwarded-Encrypted: i=1; AJvYcCV/k/6HRt7OXN3KLHa5bAfaRI45pSuI2TaPUBYCXd24x3fozUGSpZ8DhawGxYo6DMqLP7xLBG6kfJvkGIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyosjMmoZHU4VN8kN6vC9w630Q0otsik7bnTeY6NC8cGLY5SAr
	CLoytwOX/SH0gsz0ARq7MMtQxGiAov02wgW7wzob8lhNWQr9UraaIEDS12YrDvBA0sRwg6gBNu2
	F5AjgGHHjlbOuxwdCl2IPXoubf80NVZdnqesAnQ==
X-Google-Smtp-Source: AGHT+IHXpAVVFLfb9vXmEQ3pJZZbBxrBQe5whIjxyrQJYKOrv4F86wvqJo/JtPonJoceq/102Dvf8ecry9Xh5xn2lJM=
X-Received: by 2002:a05:600c:1d23:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-42cb9052dc8mr61959925e9.16.1726010602117; Tue, 10 Sep 2024
 16:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092608.225137854@linuxfoundation.org>
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 11 Sep 2024 08:23:11 +0900
Message-ID: <CAKL4bV4s3tAR1LSASwybirMmYvvTSSCNtjrD60SfkPPW9B0ypw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/269] 6.6.51-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Sep 10, 2024 at 7:30=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.51 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.51-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.51-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.51-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Wed Sep 11 07:37:37 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

