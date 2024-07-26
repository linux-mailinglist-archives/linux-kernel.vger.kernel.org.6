Return-Path: <linux-kernel+bounces-263233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C9693D307
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4EDBB20A17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A386017B437;
	Fri, 26 Jul 2024 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="W8xXGrRk"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4C23775
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997148; cv=none; b=mPwN/vjSnJZr9iXhhHBWu+hSJUrLmdN1gtYenGT1k0nZDBE0rUYispAfyq0j+WZ9h4cDfB4IQt2l8D2Fesf+9v3L2TKP30BJqnBs/aJoUtO+Y0U7Xo+sPZFGMdpkJWhiqai6ICq5bCR3pYWDBw2kNKAb0MFPWX9f59pwCUOtc2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997148; c=relaxed/simple;
	bh=Ow0lF4PR1W4zPn5dnOxQWbvpWyIhvhfyYRUku7Phcrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvRuKG2u4WEY6WMV7F/vS3HlHuUYKEb8mIGvP7pqpLGNYhnMbIRWBeE2gPT9UyRv6xsYBrH6Bl4693wM7zNPGo9r8v1wN6L/yRRQItsut9P2+KVoPsVGz23YLlU1jN8q/H0/oPWXhQwqF9KPTRe+0IRMxWXuRCpBiaBG+Ol8Wf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=W8xXGrRk; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a92098ec97so678911a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1721997145; x=1722601945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2CXarSgTnQy4ZvMHuo03qNRpFcxWzwsegdi47MF0qg=;
        b=W8xXGrRkDpidzv4aJEcx3FgioSldwL0GlbBZS83Mz+uZ5AyaU74v1H/8MNmWTaZIn3
         xGCF961mDx5Bd/g7+jZSnZYYiYKyIRXaaG2yvks1pcRQ9OPNsd+1b+RqkWO1AtCWuuWb
         MoLt/HMVtzO720zgm874dXDb4mLkdmSnXS64H2z7EHNgmPA1U+4V+MzKPW7o5BIgz72U
         J8iHZwNMCBW96XqnkizjSG+268kOgvMxp7YILsvRMrEB54xiIUxykNZkc0fJ5I+qwZ93
         tr2pgkmRd+3E5Kdu0j5yCzd7XcXef7w2rF7wQRRYa3OtUxJBQpMpufIme6r38bhgoozR
         5nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721997145; x=1722601945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2CXarSgTnQy4ZvMHuo03qNRpFcxWzwsegdi47MF0qg=;
        b=hj1XxIBZbCkOlevzll6DMgV1J5/OYisQE00UQl2FOqAkxPaW4RvrajPIBXcgOOR1z0
         p60Pbzw8HUDFYi0HC6WNABouo3XrTF04wwQw7gta6W+5DSU8335eaK1qif/d1KFkt+Mn
         X7IoCHWWaHyDfwXZbeoIXfUlwZELJ3GwoGjq1tNjaTYHzDgh2qFxi3JHZ3Ibd0HJ2rYd
         FMkOYmTJS254CU5m9jjiy95gHrDee4PEw8n48JceN3MH+tgbCrdOSJtfFeL/EHY7/BOJ
         okspcPerEwTX7V03kqYrfaXTwMcs3pCUOgHbPDteIKgHYY3UAG8rVpISM1OBqh9TUobq
         Lrnw==
X-Forwarded-Encrypted: i=1; AJvYcCVKwm7FxTuUNiV6NiYuAgnLkTYeX52+5weswZ3boko6xzZ0I30/uRr4G0wtykISkb9OvlGYZ1qHO9W9+L4Mxu5osY7Um+3Y3YYHX+a6
X-Gm-Message-State: AOJu0YwVC4Qs/WxGM3lzPFIAlrq6Ie6UISCH622CsAelSHmEtzDImzJy
	V5IH196nPE9uuxVMDHpQphtwD3/2TC0rnDdV6hfQVzPMda7DqI3gVl2zzOyD9NefoB9njUfRoHt
	BEcXbGILr1rUyFZMU5JXfro7aunN6HOc+bZDQSA==
X-Google-Smtp-Source: AGHT+IECb8woF2lIKmHKOjmufAD4JhhxypYA+icIANC3xTm1uDphLcOwr+ij+DGnOuZ/K/cor76RApG76j1tmrVHkmQ=
X-Received: by 2002:a17:90b:164d:b0:2c8:f3b4:a3df with SMTP id
 98e67ed59e1d1-2cf2395832dmr6365849a91.42.1721997144677; Fri, 26 Jul 2024
 05:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142728.905379352@linuxfoundation.org>
In-Reply-To: <20240725142728.905379352@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 26 Jul 2024 21:32:13 +0900
Message-ID: <CAKL4bV46vNSzkJQXBH8xOOSY70Q2PCoKoyJpmFBHPQzs4cdL0Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/16] 6.6.43-rc1 review
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

On Thu, Jul 25, 2024 at 11:45=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.43 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.43-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.43-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.43-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240720, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Fri Jul 26 20:55:25 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

