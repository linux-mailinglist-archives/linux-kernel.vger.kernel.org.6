Return-Path: <linux-kernel+bounces-330763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709C297A3E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E18E1F2A114
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E8C158A18;
	Mon, 16 Sep 2024 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="inLTVKAC"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9557B15852B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495825; cv=none; b=U/05WSM8jKWn7/MdDV+SgkZVc9o1jMocAqr1eJeYaGtV97HcYAfh7ubq4LaJNJwPkU998KzE/l1dyGAeqPvSy/LE2Z1GbLIZ5C0XlwUhgiliV76luJuCbHIWXhS3UJdAbDbn+IaQUpIZIMUR7CNp3XB3wX2T/LhzNFD7O6F5lg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495825; c=relaxed/simple;
	bh=Z+VVMYEinWZISnatS9m7WZOCo5cTANY4O5vrS2RyMg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJp9INxOzZEqd5Hk1skHZ/TDkWdEEZZfpB7CrMUuahYWngImvvnPXhZks/UHWpeqFZFnUgS7YkIguuF8sns1ZBA0YsRX3jEic8i3BbeSLS06ddy9WXMu3S2fknN1GEMiWEtXTzODxhMTYDJA1XOUZwmyfCULxtHOz2cvj/9NjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=inLTVKAC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37747c1d928so2138807f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1726495821; x=1727100621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qf3XwMadpbdi02w8khiprAJxJ2YHAsadcr9JrJBY/mQ=;
        b=inLTVKAC56/XHmk+0+A2f4WAAcg4+PErkLUxJaKiGQwJlFofqdpT7Z65XSP+aqisnS
         OycB1C4JTjoMKz5U52mZ4FymUoSeqpKG7clqwHrwRl1Sy3wU27pODzYqj0yhxd5gwSq+
         oM8S8nsQ2V3Ny6mKExf7aEeW+Xa5UyX72k+JUwxwOx6VGaVgxKDep8OBw9G1k5En/0HT
         eUCvk8r9+k+1/qwZwpgQXCMEXVUx6dFTbI+9ZTMaOmmgqLUpSGKJST+KzgJwh/LtQVPD
         RiEryr6Nq/ho00N7oMLgdMXWj5su1eBX2mrVYJ7IMJ+0AaQT3kmkqZrMg4n5PKFg7MRL
         LPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495821; x=1727100621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qf3XwMadpbdi02w8khiprAJxJ2YHAsadcr9JrJBY/mQ=;
        b=PSgexbNoJKj/bOe4fH1JG7KoZ/wgaXnvmTI7xFHqrWrQyh/VQxyYyntIq97lx36vy2
         V48nsqkBH0gfafEe4YEVIjcrIlfqoVZDLb7gg1J5V7KLTkW2HHNEWZjp2JLBNuIPQjIN
         s0+WntTisT4x12B61EWOgDk76sEuCCRfbL4x6CQ0h+hzRnkBBO4xQ1/CrCqXPAdesnui
         Y1wsnsFk0Lrh1D+fVnlR5cWVjnoEKscMQFKu01U2z+3kRwwhX9err3yBS7fwO8bFaXgC
         qcCVGvpTay6wYYTaol0hAIxuJYbxRzK/WfIfQCReeLfXeWZqV4MfzxSE0dDo4wG+iTV5
         Tglg==
X-Forwarded-Encrypted: i=1; AJvYcCXQJec4I+LTwn7YRuzpM1zV0t2YfKKrKm37VbC0jwVxrzGd9KZYpZSCiM0r2mA+JEavoaZNb1nRlyrivMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXKTL8E+AgRgvocFio0p7FAQeBwqyrI56/eb5dGRFLaJ0+9pSV
	BYlTUizl649nTOHCOW/B0wDUZ9EJ22N+UBJ8F7DlY6rzg9FFmPaUzUulGSMOeb1VL4Wd6K1sAev
	i5R2jxQiigD3Cxyrs2phN5vkENI8VV8R0XdbkqA==
X-Google-Smtp-Source: AGHT+IGNe9zsNe9IEEFt6FK/qfeqEqaQ+brEvCCBY98xBgyALI4wNUeQsrdsVTt0cieNkT1+Kekc7iDWS736YTEtFyQ=
X-Received: by 2002:a5d:58d4:0:b0:36b:aa9d:785c with SMTP id
 ffacd0b85a97d-378d625a662mr6649923f8f.52.1726495820589; Mon, 16 Sep 2024
 07:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916114224.509743970@linuxfoundation.org>
In-Reply-To: <20240916114224.509743970@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Mon, 16 Sep 2024 23:10:08 +0900
Message-ID: <CAKL4bV4JAGKpTZ_=jOX2npUwe598AbSM9gOekgzRVAhaa0xgLw@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/91] 6.6.52-rc1 review
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

On Mon, Sep 16, 2024 at 9:09=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.52 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Sep 2024 11:42:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.52-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.52-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.52-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Mon Sep 16 22:24:01 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

