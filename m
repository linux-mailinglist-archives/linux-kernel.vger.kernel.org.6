Return-Path: <linux-kernel+bounces-181727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0388C8054
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 06:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE41EB21914
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 04:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E2EC13B;
	Fri, 17 May 2024 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="JlMp55ka"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B2BA29
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 04:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715918910; cv=none; b=WAAW2Z4IV/mvZo7EQa44f4Gu+XvvBed/pLq2stz3cn2GW+OiNax/Q8ki1k3zqgMna5uRB8pw5SSTRjRum17litXDTYnh/2OxVZNNuD63MumcbTJB9pTUNFVc7SQneP7fyY3D4YJ3HsBennvJbTD2L6/iT8ECxYOg5vdjverBJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715918910; c=relaxed/simple;
	bh=6+Uz3blSvLFobZIL/OP5jNoLWkv1gFs+020MMxFWXwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGR5nPG/yji7m9OOEf+w0uJ17gDil36BIi9bWc/EGK0nJu+u0Rzcffc7+XIa3E/+2rtGd35GiS4bqY+gcnXJUf1EMRuFlVKVQgNQR9+PrjioTz3yYUqs2fbPnoNEoKgDxioaF8R/Ltim0QacKJ08Cj9Hyp7Y9V4SjEvDqPWKTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=JlMp55ka; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-60585faa69fso604362a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 21:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1715918907; x=1716523707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7pYmolyX6LtzqiyQPnIUtpzHGrCDTdggEyxoBqZiFg=;
        b=JlMp55kayT+uYdAJjefNu27PhCOZpPcY9HZNYaML6KzMeFNX/fceOHxoceUIgP+ff5
         PSpEYhALquQXCv9DDjAxhzgmIvZa2EviaAGcJ6eyRSQhXJXkx4o/69fn2B3s2Eq/RUui
         B+Vmx3L/vSrsHT/HpSzOBFnW5PlPwIK3subDsLIBfimPXCjiUnZKcyXVl7M/K0Ee8paq
         e5mj8qxKmedb0OUjPKkNj3p/yC5TJ+lwhKjoBie9b4fCriR7WWN8GEaJULfF37Bn4Cwe
         bx4p2kaeYhR+W44kprBahEDzfMCvd4gxxZKzM/qHdl3V/8ByPKQUWXtPE30914nB31Gb
         EKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715918907; x=1716523707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7pYmolyX6LtzqiyQPnIUtpzHGrCDTdggEyxoBqZiFg=;
        b=qozl51DlTdBLWoNxhjHDIXinkoDOTNlDziCw0HYad1+RULOGrNbMa+k79HjRHLiTKq
         N/gZhNP2XfWRfp1iLN3mOsoUuWjHhkfYznx0ywertH5/nr0lSqWvuGvZ7nSMyj0ys2wv
         C8Uz0+ZYCwhnLmhSoUORY2A5BOSXwcurYpiRJcyQIPPwN/VQ0FhOJvuHEY3PH+UHpx0a
         wKE6K2u585FlI68AAhxawJfP7HD6KMEebVFRIXoIOtN0/MKOm9w7xPUNAwXB2hNNupQB
         2ER2Bfdj9PRluQHGsEa1Cq+XKJGh2B0T3ANk58rbeenyMG2lLVuhjPI3K3u+UxzngXY7
         9gRw==
X-Forwarded-Encrypted: i=1; AJvYcCU2xtrv6jwmXRN0imt+b7kA+mdMjmEnB1bQFOHVAMIyiEIcmeM2QgDRmAWyIfO3vDKSuW6IzxgZ7VYh2e0l4hGcCHN9yjKIM0XIGsdP
X-Gm-Message-State: AOJu0Yy5LdYHuTQsBk6bPz0yZdkbFXUimEIIorxGOGzanOBGFw7bOy/r
	PnrimN+Sr/kHZMOWKLt9hMgV7IluaGjcNTuDF7YBAb+1p9UQmXnDQsPs/XAKjDyWOcFXvdoiYRO
	DsecsVSJmnT7DmG0CbEi6Z28jEHF4Yr1cOlxlCA==
X-Google-Smtp-Source: AGHT+IGecLsqL6tl9xvM8D8czW3bdjhLtsJutGGzjXKsfLl5VIFbzdyGPn9xWacjZDMmALlIDR4wRadonqzYDPPQcEQ=
X-Received: by 2002:a17:90a:51a5:b0:2b1:54e4:e125 with SMTP id
 98e67ed59e1d1-2b6c76f9388mr28128174a91.22.1715918906790; Thu, 16 May 2024
 21:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516121335.906510573@linuxfoundation.org>
In-Reply-To: <20240516121335.906510573@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 17 May 2024 13:08:15 +0900
Message-ID: <CAKL4bV4nWc4GtqbbzG_vAVwNxvmwTc3WZLDuOHeTfOim3azgig@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/308] 6.6.31-rc3 review
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

On Thu, May 16, 2024 at 9:15=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.31 release.
> There are 308 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 18 May 2024 12:12:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.31-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.31-rc3 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.31-rc3rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240507, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Fri May 17 12:30:22 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

