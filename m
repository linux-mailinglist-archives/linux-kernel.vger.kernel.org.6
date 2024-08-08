Return-Path: <linux-kernel+bounces-279436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D71894BD54
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B13B23056
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D1718C912;
	Thu,  8 Aug 2024 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="LNtf2SjJ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9B18C348
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119898; cv=none; b=fIGXbXGk4Z7dFOlMOA3hosHqHDaCPXT2TbIr3LiJnu07OmBeKZj9PAwm3Ec9wcIERq0x3FdQPdLt0cL8S8nzDQmHlfEvYkru8+3xAer2j0StaYE3bEA0zJEydUXv+p5znzlZhOy8KSaO3qveaTLbfUMIJTLUMOLA3rrCyZpHikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119898; c=relaxed/simple;
	bh=oEuWZae036GQ7jXBrMcJ89tlNiHxMOCogZ5ebECNtmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMhsbLwxIYkbIK+0ruANgWlLlL9jeNGb1iACDZ3QYcRn8UdgO7MEMW0xHwyR2Kfm4uX+zR2HUojbWrGCbXgRQEadNZxpFXjuvbDNOi0cHaaGFeLO0GmiuE5H98pQ1+9B3b5OFH2AkzpR4ePAdg9ak3LIsPWmcmgpbDkcEtZOkl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=LNtf2SjJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d1c176635bso461569a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 05:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1723119896; x=1723724696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfAfcdXAF2CMiBj/87aqcHqpCcyX1shZ8yk7dz5R1uE=;
        b=LNtf2SjJLYdsaPx7VLojoda/3Kbcgx30u7UpKXvxgE+C1MBnheUJp4JzpeU3titslf
         JZLkLG5RoItHjrDc8RP6dEr232gerQ+x2nT1fogmcFr/w0KvX/6sFFBABHqc95noJUQZ
         6b7zlRrQLJ6Knw/O097tLkRDZtfbD+96DEQtqVCS0IzAultCFexgIxGCHvSJ9xVvqGZ1
         on+O0gK/iVEFkJOWf8MOTEj9B3BMjiDKJG5WVCNnovGd8pCufa/tGlYhU+/wGPrjuiWK
         JLb8QMa7y+QYzbGCqSqxNCaFUwzHX0U6WL10PW2Hg5SECiKlBUccv672YDyHr5EPNAmr
         lDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119896; x=1723724696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfAfcdXAF2CMiBj/87aqcHqpCcyX1shZ8yk7dz5R1uE=;
        b=SuQmSxHBlefz+mpxvrTS4TA99OaCQiS5hdwGXnMdBHqJf3aTdMVqJ7NzU4jXIK4Sw0
         +ehSb5xFUpvEcncArNfqGpi3x0OUu5GsqYyo2ZVQl2RHfHQvo/zPbC8eWlX2JqBYf1gj
         KX3ghyo7gix2NUDoCh0VC9AK3dFXWuFiCSNgoK5buWlwDcRMGj18l7FmJdGOHsadZTlf
         JTQOzFcHRX2Hel8vMk4KYKdkCsqyHzg4zkSTpHkqJbxAZjj9AN9go4EXaHTrEn6Q+uyj
         73XccxKgNl/sf4286oSSpfrzBuEOJdUn72KLFify+Tq9ur13nq5enVOw1NQycYj4136d
         /1vA==
X-Forwarded-Encrypted: i=1; AJvYcCUGdoWkcFKkJt6LsA3/sYrR88oi2NcxOUKe37FXvq3OtFSOqhDHa2prRl3YasciXa/S92HyIB3WXXvMEHyghhJqcnDw4Rjm5sbU517r
X-Gm-Message-State: AOJu0Yycnlovr/wi/wKBBDOhNxt59TREuhwkKgbnVwfwoiFfDu33c3v+
	d5dD2xx2SwU2aTKPEnmEKFD5M/CHe0ksKh03fRLiWhKAADcpWx/kFL+CpTm1tUiXzgNTbOZA4EW
	nPlzYTaFzFSt03x9vwCmIV05hnd/RDPcKzoi/NA==
X-Google-Smtp-Source: AGHT+IGZfCQrsBQaBp8v+W2s/fAHN32pPPoANaguDaxiXXrdG2KlTFuQjIkgMbIJzL0P5hzPmIHrN+c6QDv66p+Xf3Y=
X-Received: by 2002:a17:90b:4aca:b0:2c9:96fc:ac54 with SMTP id
 98e67ed59e1d1-2d1c336efb2mr1862632a91.2.1723119896355; Thu, 08 Aug 2024
 05:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807150019.412911622@linuxfoundation.org>
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 8 Aug 2024 21:24:45 +0900
Message-ID: <CAKL4bV4CXPtyD9Jj5wmUjMnmNgre5UVtmVj-hGAWA7VjRJrzsA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/121] 6.6.45-rc1 review
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

On Thu, Aug 8, 2024 at 12:07=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.45 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 Aug 2024 14:59:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.45-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.45-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.45-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240805, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Thu Aug  8 20:02:46 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

