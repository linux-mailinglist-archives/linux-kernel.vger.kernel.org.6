Return-Path: <linux-kernel+bounces-289622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4613595485F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BBA284A99
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9851AD9F9;
	Fri, 16 Aug 2024 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="CCIg1UHf"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448E1AD41D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809381; cv=none; b=mWrggMFnVLLPD7AHK4AfAqZusSYdtBzMikD3ZuRlxx5IMWnj+37Au/ZPSHz5rr4LsqJz+pPjBOGUphzkjkggoubX+1tFSJUlRLedVuS5wklEgvHpbcNfGCf8WEY1I4E+n9F9y8wXvnGhOcfIv4wVOJPZ6tAUJy7yr+aRq+dCsBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809381; c=relaxed/simple;
	bh=D4nKS/yjD2pHvtewgQqkHUg/tkdKA3kStDkmEStwIWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kP9Q776YfWRn+wYOz4CJR2MqwXOe9G8UozSWKMxH+DebFJOXd/mVaXgJhKtefJauTPEkvLcDD/FWvFhiYmz09H/hu+O1wOGwSFAzQ94d/ox0+kf6NJmDRYzywZ4g7MkiMhyIkWJnHPdpaP5mURY98f7ITQplHTgL4kmTsDWhVBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=CCIg1UHf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42819654737so12945275e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 04:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1723809378; x=1724414178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9suHjmHKgK99ZzlX9eSnvMS4iKAMzmcKW3ySCj8XS8=;
        b=CCIg1UHfQ9n7MRaC7io+tjWdJnOpIXdJyEbMce+lmU6Ev3OQ8552/fbsXLHn8OCrQh
         kS1u7kZIELQrXTe2rc7PpXpzIre/UoKmRXBzdcLxI018ShZ7Z6crZEimfjh5QfNbdAJl
         WXdA7KECu0tCv/XeddM+2rskGKmK9wE25vPO5SCv1cGKx6ez6vmNVsQiM1/aelQBBuD3
         j/eu9u0u0Qtu71+hNmeKggFAbk/5PQJy9VPPZy5m3nMnsfU8xJ3HNjgckB9OIPvW4j1D
         TKfEJYj7LfBl8HdGeV8+2ZGBtIIs8f30WMw+z8UpFdQMzjiXyLcA0kr0jgKGTjDSLpbU
         D09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723809378; x=1724414178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9suHjmHKgK99ZzlX9eSnvMS4iKAMzmcKW3ySCj8XS8=;
        b=vRBw2w/JAZf8ar069hw4NWIvX5qo9zYI40kLK1DaNRl6g/bOIh+F758K5snx9AOMMZ
         hxF+AxfWK/nlXp+EuXsfnBEJKcxJK1U2qZxKIIoGEcrxwBAghD3Lol5+efGjek2ri8XE
         awQRwKd1EaleUD1mEg9Y5GnWJ+UGSc9rYiXJkQ11h+5ZhCQLHXGC/1Xy8AYuXJu4sl61
         PUpSsmsYk7WCVaZv2k32rgaJQvJ2P3oBFyMEkwKE9oHxaWEoy20tN6fIdC7hsjqylDJG
         +aG8hhN5fe2CrfG2ne1AF8SXuwzogq0gNRrY+8Kz2+lZhICGDD+PpoYoZQvbGHB81cpB
         mYiw==
X-Forwarded-Encrypted: i=1; AJvYcCVnvSgvsm14jqefQBowsM5v4wr2JKtKGzpeo0O68xCMDn9ouHib4aJ8tP5LXTSfCfD08QlnkVmyk4WzfcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIuUilm1jECjM1pjDBm+1JsmMlhkDCFmbncwLh6FYH8wwsvWZh
	AN0levFtbosJfegZgVgeAJChgYO8wkQAUvwiUk2vCZg1SWBOBYP+V59LzJ6cM+7DvdaghuiOhmZ
	Tvw3AHy+JmU3sNbiGyAZvyDZVMPHpLoLQ06tQ8w==
X-Google-Smtp-Source: AGHT+IHPDhhIr/7vN8snqpMY5o0ZtPpSGQ7K70xweLfVNy26r4EgEucpC8K/BV94ZejpCF7uxoOQQluLQX1kcd4qVEs=
X-Received: by 2002:a5d:694a:0:b0:368:31c7:19d3 with SMTP id
 ffacd0b85a97d-3719431e723mr1668359f8f.9.1723809377805; Fri, 16 Aug 2024
 04:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815131838.311442229@linuxfoundation.org>
In-Reply-To: <20240815131838.311442229@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 16 Aug 2024 20:56:06 +0900
Message-ID: <CAKL4bV4f72Fb06ToaahCNKPk7ep2cPOCBPbmLvbgtBE6mz3JCA@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/67] 6.6.47-rc1 review
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

On Thu, Aug 15, 2024 at 11:11=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.47 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.47-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.47-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.47-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240805, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Fri Aug 16 19:48:25 JST 2024

Thanks

