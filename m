Return-Path: <linux-kernel+bounces-179825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C6F8C6610
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF861C21C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D1F5A788;
	Wed, 15 May 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="HXt9wlOf"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092EA58AC3
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715774595; cv=none; b=EFYpAHVMGXAn+5eSVkKtDiCaMAdtGFBBF9W4QvddLph7jjIMHXObV/teBMRkblQ1/BttdchEz4tI1eRtFFOilnMWzTj+SJA7GloxXMyih5pKtGU0Vz9KmuccbHQ9Rog8KVplNJ6emOQrHeELP3lQWCHNgq4g1HHA7/QPttp0tvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715774595; c=relaxed/simple;
	bh=cZULlQnzOZ2Pej2Sv06sBDw4hjTWF4t0tcOP2mtKUnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvmKlpwmD7Xu0BMSnQovBTB0BNL2lNatu3uo2nas4P67yDi8E5v94JuofMas68IC/TEDAnoV8YhJG1zGHQ+1Zqh/3zxR2iweQ7qEi0WMMYaDWDANs3EBVS4YbloE802kTtwwklDq0xWMtyok3s8vCCjc52MHGGoEqfiHujiBDHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=HXt9wlOf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eeabda8590so48991485ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1715774593; x=1716379393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DcB2okqnAgkynFg9jcCuDayVN3zRAZHBcQStj5iFBs=;
        b=HXt9wlOfvs2sIRCSWTFaAjblrRrOvJuDvO2b0jj921ZVX171pJfznv4gg1GbM2ChQ3
         1Eli4ccfayEr4h5692lDV4dw3qJlzO6Ge+ZEFiFKmGMwSSz2XcSO2sNuESJtg9M+ygYn
         LMSfq/+xtllH4zUx+YX+P1+tgRCCbWQSYve8vCYIId7vooCR5DcGplIsevzo1OubgYez
         36Xv5TscXEy+rXBBYwuyOvTN5nWkzZxSrqZ6Gi6B2a7ik4YIqg9pe9Mwp38BmjaNl2MY
         U8iamyKj3xZs8Pvh+VcuWZVNtjdnu2cxDCfuf2fHNwjvuEADflbf3Zxxj8wcaeMT85Yq
         4qOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715774593; x=1716379393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DcB2okqnAgkynFg9jcCuDayVN3zRAZHBcQStj5iFBs=;
        b=rEPAUf0OTjItkJhWl7ad7VgGfK4rwGL3g+mFDcy1XKBaUB7OnPVYGHIOGxa34ZFeza
         BGg8Nl5NEqVEtIhblsIC5N/ExVQwcOJGoJgCIwoDT3XPb95Nf1MBVvz4vZZvYiFaQhSq
         snMe6fDEDxw/B7vVNPDLOmCq7NRTz9FKSoMZrguQtG+SbfAI6Y4qWpKh9GhIOkXqenv4
         bqrywvRy31tb1BPM/uguFJulbRLkzIDVlNFAq8fH8JgwehDKvtViSt7aZkXHYj/0XGIS
         QgHgF4Vxe0FXKwOMML6Gs9Kj6gMCf6lRVPa2wrhtHeExgdinSM3KCpF+I9E2NQ1pPZvp
         W0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUDzTkWw3ycyAZhlMgmh0Jrr6Bn3VoAOCfIm4E03zQ99ZTtcCrY8cPmPjLksyIS4A+xHXcRS8E44h8IulvEJA/Yeoak5szD2XDvO7+k
X-Gm-Message-State: AOJu0YwG+6Lgh2PneFyCvf9wYOc+UPCl7uoFgjXWDGDDXAP2f8Pg5951
	844Ztet4A7JM2koR6023pUHdXi96R2QTHeLyo9iAXreCkqj2n76sqHIAjZOzP6VgUf97siRRo7D
	Q3mNZ9klOO46j1rkvDgatLajqLDy5f346zxMZOA==
X-Google-Smtp-Source: AGHT+IFy3gmVgZkNpyZFzjDzx0VAz+u8/kXHpLODxZzc9kj++XjUCO678HSP+AFx1+KEX/6z3WmoITL5ipamNpy1768=
X-Received: by 2002:a17:902:7d95:b0:1ee:b2ff:c93a with SMTP id
 d9443c01a7336-1ef43f3e4admr144321025ad.40.1715774593154; Wed, 15 May 2024
 05:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515082510.431870507@linuxfoundation.org>
In-Reply-To: <20240515082510.431870507@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 15 May 2024 21:03:01 +0900
Message-ID: <CAKL4bV5YkLqnZJsLB6t-n0ZeSSZAHYsaE0c6=-=ohK8PBG8AvQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/309] 6.6.31-rc2 review
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

On Wed, May 15, 2024 at 5:27=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.31 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.31-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.31-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.31-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240507, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed May 15 20:35:08 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

