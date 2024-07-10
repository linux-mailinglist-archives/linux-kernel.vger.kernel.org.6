Return-Path: <linux-kernel+bounces-247680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E5B92D2F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B828B2347F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4C0192B8F;
	Wed, 10 Jul 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="DkKwCr5/"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984B51922FE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618586; cv=none; b=CKnPldVlBV+SKlFMJl92odWTRtCB1elAu9K0K0QNFO6pv2wgtAGf67fTt4s+ThkCIIXkwPxuiTwIVlD7Bfb+qNfV0mP6TLM+V08YQNxLB9zrcrZmFYWR8uwJKhbqTMLIMJEIK4Xl/EGBa+w0d4tT2MkF2yYQaqJemdYtSpnkjvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618586; c=relaxed/simple;
	bh=WcNEWQKtSC+Dj0jBIox3Xr3GfAY2vvuavazXjG/PjMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLCisMUQu6sYz4QQvNtiQ+T2ykNGkzGM7l1q/B8vcwZ9ncjhAZQAw58TFAFawe4YE5QXlWJBTi8zVWDKFcMPm32nETEXYjnCT+Zs9XLL2FLpPE7Rno7ro4UK6KbjuDbV/WbKbNf6jfLaidapPeW7UfMWNR54CcHdtEjS1Otcbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=DkKwCr5/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c95ca60719so3961494a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1720618584; x=1721223384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+5I4HocYoLlRWtU9xSNyyq0WSjcKj0wutOR3acSvmA=;
        b=DkKwCr5/HhDZszQ8jD1Q8lP+Glcopv0cWkqQNGOth8+HssWb/d5eH9IXeXTKXmwxaT
         eTAxEfn94l/8M6KSVdf7ENpxYsb6SzKahAf7LfBC9rNIilrB4mpooCowDRl3dN0oBP8r
         scXWLG1Ugco/enDpeQyaVI3CWZFePWn0ptHjPuL8Tiz4Z33I0EOKsVblwOESLd5VMN6L
         fiir6ybTtwpPfehKo2D0mwNDrm+uP6RNKtaohFS4LsY6tILHfHJ8AveLJP/vBBj0O+P6
         xIzMK0RKMs+1LGWo5RPfBNt5gZMtQ/72JvBpG7b1MA7Lx5n5fS58d6eNEEwmr5ZK2QtZ
         lsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720618584; x=1721223384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+5I4HocYoLlRWtU9xSNyyq0WSjcKj0wutOR3acSvmA=;
        b=ZmLdJRn7iOG6NlD9tYmyYa5AyG2+UbfLvAXKDWB/IVlM8vbrpKwFz5I0mQ69ZkrDc6
         FpZUcUKfNpAacDtyKFUPoq5THPKVDS4jSJ7gC8RntSMpAbx5+CHsoGt/Mb3/5ncq4ugA
         Pn8lBwzc5DgB4/iAv5dnnYYCqNNBr2TrIA09gjMGvGkrXBJ4mBQ4EPXXp54BFHq9gHbs
         Gk6cdBUoid/DHH3WbuKdLUPlmm46Ae/EJbvaxTaafZQO4rHfQ9RnUbex+nGD26FApvbn
         Stn2Uc+c+uBid5W++SYLPjBpwCPb2ivO0JvB7osUyrAZvTCNqCKeY8aU4RhgbFm7K9EA
         cccA==
X-Forwarded-Encrypted: i=1; AJvYcCUsbmE3GiiRYF2H0HTme7FqZjV50OQjoHKJyZLiUxz00bxY7PR4ql2l3b+XYnVTEQLv5mr13gAOKQP8UU/wfSLmGxmqKj2d3cTKEI8n
X-Gm-Message-State: AOJu0YywATMDV9vzfocCGnFTrWpGZBeChB9hv0ObrWGmEqueeJovX+ZE
	tj8LDCf6DDpO3aqbAiFsOPOZSmLxW/WhtIBZnWvrgTeG6dZxpNSa78gsRZ8U0yq2rL9vSuH2E7h
	jH01BXwlUUAUw2C05gZ3HDo16engsbG9wZSiwqQ==
X-Google-Smtp-Source: AGHT+IGVWjcx2CIKKhJpC93dsIDJRQ59BMorlnyl7TRS9pMm/YWO3qF6CzwWosQ+pKzgyemjtuMmhhNtcB7dLeMy0JM=
X-Received: by 2002:a17:90a:4b46:b0:2c9:65f5:5f61 with SMTP id
 98e67ed59e1d1-2ca35be8f0emr4813325a91.9.1720618583619; Wed, 10 Jul 2024
 06:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709110658.146853929@linuxfoundation.org>
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 10 Jul 2024 22:36:12 +0900
Message-ID: <CAKL4bV4bzzKhUv7u3SUUDD=dp_KZ35K43faoZp9aQp5GmUfTCA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/139] 6.6.39-rc1 review
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

On Tue, Jul 9, 2024 at 8:12=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.39 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.39-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.39-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.39-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Jul 10 21:13:34 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

