Return-Path: <linux-kernel+bounces-445883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2029F1D14
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 07:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF48A7A057E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB48E13AA5D;
	Sat, 14 Dec 2024 06:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="Biz0Kp73"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF93D7EF09
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734159442; cv=none; b=S+HxfBMU9SlrVMaAdqL23m3cPlPGCVJXbj7kFTSUdJgNJfuBnr2XqNBE1fXvVMeB6EWM0BIdWCxUnMg+V9i9dNxK4gX9tBAxEOkolPR9wu4N4NzODQzZ6zPdPKy1RhsoEF/J9LFoZPOYKLTo177NXL7lFb0tECsimluLmJP6vrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734159442; c=relaxed/simple;
	bh=s7Maksqyo1/cbgvd2H9KCJaNZwpklbS0ty8L690vreo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZjpsEHkh1Lhrlce1TTOe93DzLzTuYmkAiTC9/GSfBTouk/CyAv0cr5q3hEnJ9KQ/pEg2r3gDt5P2Ki9Mo7MiGymfJ/HsNrsj1IoPBndF6o3KbFO7LO02OgJoxyPv/r/0xIwOmWNFOMtQUOz8c8ydq9j0ZdoUqNkeNdL+EQ/zME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=Biz0Kp73; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso1623496a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1734159440; x=1734764240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unpH/x6sT+wpQJiB0CaAbGxv+9w2ZHMovGzlygSlC2A=;
        b=Biz0Kp73JnwyCisYgCuaJi2RAHrcSwyTQyVYPT7cstzmUjyeYch3KkYjYg5cJnQViM
         T4EuHBCl8TZ25SV62ZhHTmpHo0Wn2A+HIS61JiDWJj6jHE1Mueljpq/unnXjilLUAGg7
         eKLXxXMUE/oJNwTDIsggckKs3xcKrEBqD09m6VyxKXLQnCRGblezwzGe2xS6XNRvSPj+
         doC+pJikdiyNXv+FF/1oZkqSJL5a8LKNVDJsJGEuaB1T4ztX9uRA6A5EeGG5vdDUYWd5
         SAHVdcPeK1HOsHyHv5uB4ukfEDmFGHeWpVCJjFeVgItecAAKtgLQI6pQoFN2kBJ5PPIO
         fDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734159440; x=1734764240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unpH/x6sT+wpQJiB0CaAbGxv+9w2ZHMovGzlygSlC2A=;
        b=vYTNQ9fJsM7WXRFd1P0NKDEAR05IjpQKt6yeHVKo4HQ7AOPu0SEa4+ODyFfXBa9Kys
         aTDsyyznLeolshEbEdPkvav0mC0rouwxbq3Rt9xE1pgMRMZeiZfyT6JB/Vl3CbanDHMy
         oA57xWywLwajrBErIkvG29i3E57jKlpDnCg3ZNfoh6jZrSQvhjyGd82n+08SWH/NBbzE
         vVSoLNO0PSTWYB12tDFcaXwSsh9GimXqrl3UXEM+M5WNYT8zg5TS3hgGE4s5HTvBXJgK
         ZOMxeai1Wqv/3JsgRPYFLQJUghBYeuzhsxVK/1e7CksTTOWMr7HvoXcz4fGYRjnt66ZM
         SZ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIXun6qxfDPNj2V/cEpppQv++UW1balUfVvsYX8TnDwmoofAgyRdUaptOymHsjhr3NDBXFFjHCd7RF2GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZskacpV8uR5K6WxE5mEP+YPXTeCBOxmZDDy+MvO/rlVzQ2r4
	HND2/zGWNpMjn6OT0A4AdYmt1rnpIalkRMXUpuNzAd2bbhGBafUjIuTQcJzMvPycfoEDxJIERyd
	j9ZEYMqAsCfXWqd9B0S7ge+7btezlgUwT5Wwhgw==
X-Gm-Gg: ASbGncuEKAQ5WoNQNVlAeDyXGP1HUUio0LjwSfQQMNY8T3280gbIjdKMGW/2e5+lQkO
	5clsmZHxLX+v3VoBVCjC313nwgRqVt+XuNWDK5A==
X-Google-Smtp-Source: AGHT+IGfWcHf1IqCM6xcZ42qVvO2ln2ZF7gp7PWckjle/qKeI72/cD+d0i+huT9mtsOvNbU440ioF28S4h2DaAFrN0A=
X-Received: by 2002:a17:90b:1d51:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2f28fa50ff0mr7489453a91.6.1734159440009; Fri, 13 Dec 2024
 22:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213145925.077514874@linuxfoundation.org>
In-Reply-To: <20241213145925.077514874@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 14 Dec 2024 15:57:09 +0900
Message-ID: <CAKL4bV4y4ftwOw3E5soaob-EkkDS_5miUmziwrp4PTrh4aK=6Q@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/467] 6.12.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Sat, Dec 14, 2024 at 12:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.5 release.
> There are 467 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.12.5-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.5-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Sat Dec 14 15:37:12 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

