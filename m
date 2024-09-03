Return-Path: <linux-kernel+bounces-312831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3402C969C32
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D933B226FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C041A42DF;
	Tue,  3 Sep 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="1W2fpLkc"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9C1A42D3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363716; cv=none; b=Owbbw9zEOq+xLAPGfBHOXSSHhyel7e/b5zaQl7pRd0fvf/utijWkmUVg1F+Nx6OO9X04s/QamewRf3GGIMPupnLGBoQuE4+sGohpYlMi2tlf4YOPui9BjwcEkcvwkouTHfDUk7GFiPVwXTpVOqxY44j1kDKcV3S/pAq4RZGD97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363716; c=relaxed/simple;
	bh=27rmC43+DKIhGwj8M1M31H9C6n8kaXdoV4uvdxhuEgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irPO/zRTS3KsiIG04S/wkjnfGVIzMg92XtauVfeWh114A0NR09Y3nNW48nPJxv14gwXe6R0ML8LoK9LOYRqs8CuXGmcMxgeFBKPM/2GdIId39yJVkBFw/PI+BAX499qsHqKGR4SpgqGQjPRM8burqsHkX9jY/4HaSkyEi4qM4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=1W2fpLkc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bbd16fca8so33578235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 04:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1725363713; x=1725968513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCRTP/YrsWgFoEXAwptIQeI3efMclrmBYYYgqSK6yfg=;
        b=1W2fpLkcq5VaTLaNuWnQ0+HRRsKIy1oaq6ehhud1YZHmPS1Uk7lo9Iz1FetgJUM2T6
         rdGMblqGRWjERSrleVvo27a9bMwPP9K9W24GPiyPHyH1O+0QM1L+nk9NGm2ee0DX+oGG
         uh8bbkiQYwwTfO2uIEjErRjX4bNdQ3kfx2X1br+m2yTa/dFK2IjakSGq6CIJgKL3re+U
         YFP7Xm8Yc/CJubboLM+Ep0vE+T76J+naBddfdPsGsNBCREy+2bSE02XELzysUISgn1Rd
         jJH2L9mqvp9okYAy+BWbQc+IfU3rV8cMv5cduNrJZzDFcAg1HAFOnjr8SrCdaYV9IwM4
         WPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725363713; x=1725968513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCRTP/YrsWgFoEXAwptIQeI3efMclrmBYYYgqSK6yfg=;
        b=tDykTXNp7/ik/cJBCp5UvNiAlSm6d7jfG3EB0gYJwJqdaINYehxkE/2KtCikdhOYzU
         Wy0UjBx7DBgEs1aIzLPnmsWzBj/0SslLIr72DLXYVGxA/Wvc+FKz2ta6nHz1RK14Kc0i
         NixP/mH0CNjDY5kJ6s5UYkvfoX5WOQw1QSR4nEUhGouXqbOGqN8eWZ5dH63bF13o2+a+
         T62ho0Fwl6N6ebeHbm6TeuHz4o6RbelLIz4xdPeyx6yX0hTXbe9iins90aedFzIvYVWB
         1J0JgyXoS7UShZ43qPYV0461DL+E08jIO3FoXw3Lz2Wb6DxSJqTMKc76kvbD0muJvBmM
         kMqw==
X-Forwarded-Encrypted: i=1; AJvYcCUh4EttLlVtTDgqb9eLkoDQgvJXl7inff4FHJeZgRDxevDL1lkV1kdw8NYmk5XMaQvDJpjhAZdW/xJ9TVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5dsWdTuSI7OlVJyojmHkyQ7xYOOoMapycmcW/15mT3HDdTBH
	2gDpHU0OEMhDNEoRaXHaKL2TJ/ph5/GLflUlXliDpCIYO6nWH0oa1f4OUfJ37pJ68bycvWZEiUA
	TuksDEXXlyxrl9B+ITD99H4kQAvQTWpKKzk/2Jg==
X-Google-Smtp-Source: AGHT+IGa92m2LMCXflLaiEs4By7t3Xb4VTHpL+lnmhdtVI77oh5nvoDYjhC/3FmPZ3/culI72AM73cH8LI2Ukit6TGI=
X-Received: by 2002:a05:6000:1147:b0:374:c283:f7b7 with SMTP id
 ffacd0b85a97d-374ecc8f661mr2369288f8f.21.1725363713010; Tue, 03 Sep 2024
 04:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160807.346406833@linuxfoundation.org>
In-Reply-To: <20240901160807.346406833@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 3 Sep 2024 20:41:41 +0900
Message-ID: <CAKL4bV5SRyAq6Q6e7jQ5tvk6bDKzbuk-x5vnhT_TmBpHVchtRg@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/93] 6.6.49-rc1 review
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

On Mon, Sep 2, 2024 at 1:26=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.49 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.49-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.49-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.49-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240805, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Tue Sep  3 19:41:58 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

