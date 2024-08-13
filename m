Return-Path: <linux-kernel+bounces-284638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CFF95035D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2981C228FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDBD1990DB;
	Tue, 13 Aug 2024 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="co4dXDH9"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC88D1990D3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547529; cv=none; b=rdGjQh8XueCSWjQ6ehKPeTZ5Mw3Z1N8Ft+dy4idmI3/mu13E9vM/jTvNMuK0eI4VEJxW6kOiIG2IeYfluQcEloCYRLhFUZlsMzR7gRnWVhSjZOgR9x4wF5VA35j09ewLPIB2RR7H0AF+qr9hSRV68AqTq8ABvShfX0x/iDn2Z44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547529; c=relaxed/simple;
	bh=sb+XtHUDQtmCMGrfwTt5ykYomI6fe6U6GobYI4zQheA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L46YN8C9wvYht5Gihz0ewUNA1DSrb3qd/W+pgqLJuQEMl9abnx7xr6bRxvxl70nRTQsP7TTWO9fpPkH2W7U2RWeor9T1TIY0yr4XkowruG+tXGXGdJMmUs5Lc6PpiyiA7Y1Pk+29DJzt2pEXFnHMVTaM8G4kq5Ew0SlJOGlmWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=co4dXDH9; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7163489149eso3741396a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1723547527; x=1724152327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXWH3cj6qeEDUbAOW6N1y6hA61YbTTG0cc3E6ZuOHeQ=;
        b=co4dXDH9T5dwUz2ji9Rc0hE9ZkVkuuyb/eCVrcPgFz7NynGIfnbPxaPHzanPxoMjH0
         WTTjOHDytBYI0ZYVVbyaP3DFvrLbT1x/ldr+4Ia5ZujoQIsIfsEo4Ok5Z0tLaDYsARh+
         4/wLnRcnGAP454IvSleShVnDzOhYKsv7DBqArJ9DXppMwwU9xH6qHMzC10LAR6AckSHl
         YY6csT1T2QatrEcEi7agw8XV9BJDE1Se6t+GIE7xKOZICGpbRfuZPmRprnXrTSjYBDHU
         h1eyRZ0HwNcJXnsm6ZvbpPZ/B+56wd8ulQvKkSOOk2RqPJNc66BPf6NUt6SdMYKfyYYk
         5HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723547527; x=1724152327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXWH3cj6qeEDUbAOW6N1y6hA61YbTTG0cc3E6ZuOHeQ=;
        b=uVU62cDKnZDuJ/Q/CFJ9fj1h6pZVdkr5tmjoIvixHmz23Y4lVRjrHOuckAykc+DBaz
         pWZTuzKgPxP7FDRI8ivGUaC8/t5I/2jBcJiSIk5uRJB1L+O3KwjWhZLSmLjnblbkwrtf
         1fTHmkyz3wXtqC9mBVkxn0dEtbOtd4TMUI7a1+FY0/7RucnJ7Jxf6jBU2QEqytfZhckW
         VaGBrGA8ET9VFWy1TlCsgykmwWk3PlXFT/bwK6oEeeBQuXY8pJO/4O+tlPbUpiXqOzFo
         GItUqGeRqW+nQFb89qfm5qLjnokfX/FAI3/lsndrIg3Jn4sA/60AZAklo3VJ5B+ID7B8
         hLHA==
X-Forwarded-Encrypted: i=1; AJvYcCWr9qFWrOyCrB1JRKhR/5wc2iNHzn0+AjbIQOL2ndENYQ81K0qv9NtCt/dGgG34sYGumTfK4eVvvDV7tI5BoFYL5tYTdPDDUL76ZgCE
X-Gm-Message-State: AOJu0YzB7BaRtpC9io9BlZA2zPnhkSi+/NR00+wooxslfjS575UBm71r
	Ii5GS3WuarCvUS22nkv6h5KnKqAoBgnWcemXEHKusEJ1uI5T9c0l3zF1tifWa2GOY1QnEYyQU+f
	6XuWAvsza/MzqesGDOqfJKzsY6Uc1Mn5bfHG7Rg==
X-Google-Smtp-Source: AGHT+IGuSeHG7m5K/jmSW20RDVS0llLgYzyxC9ou/X+cYTWu/3utdqzZoNS752omYejEHO3eijXxIXiNFbcWZM3Y5l8=
X-Received: by 2002:a17:90a:5c84:b0:2cf:eaec:d756 with SMTP id
 98e67ed59e1d1-2d3925048e2mr3647563a91.12.1723547526952; Tue, 13 Aug 2024
 04:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812160132.135168257@linuxfoundation.org>
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 13 Aug 2024 20:11:56 +0900
Message-ID: <CAKL4bV6-OVxsOQPQYHetJZ7C7=oxBK5eHnOG-+HhTgDu608zPg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/189] 6.6.46-rc1 review
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

On Tue, Aug 13, 2024 at 1:14=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.46 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Aug 2024 16:00:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.46-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.46-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.46-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240805, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Tue Aug 13 18:50:55 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

