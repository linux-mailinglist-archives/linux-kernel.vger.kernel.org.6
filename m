Return-Path: <linux-kernel+bounces-213459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B57907599
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12511C240B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB380145B3C;
	Thu, 13 Jun 2024 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="2K1szvcB"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC47E76D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290080; cv=none; b=XDRphXuruixSj3yYoRJ6TZbLDbstD+DhTF+fAAoDDYul8rGYzU0QWrSyLy8xoXPxMZvV5yKFy4EwUDWmr/bD3XBFbb40em/lwQUEjwuTSVkq1cXtpHb0iqDOVEUURPMQH2rgsk/CC6aPCIWeTu4mx2LwsmY9n2QEeUdzpYWwYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290080; c=relaxed/simple;
	bh=ZefUIUyomFMimAAhveylaaGjEmkSppUTk1bAsNB6uJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pn9eLdGc9RWi5vcbyR8+ilHhsbfGJ/iSe33AierM/36pP9KFEB0ouIV4lN3O3UaLzWqWh1bFBj261e9iCzZEoG2s0dnhrX//qnAiTM2MBc0GoCWDO6GiMZ1ygNoQjPONh7ZqTb0fYyIh10IqYXwQA/XDV7cr5j2KpnhXnGXUlXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=2K1szvcB; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6e40d54e4a3so890466a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1718290078; x=1718894878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJbpBNKH1nKMaS+tK4/41cAHjDB09P3ZLPEGUZzZCqo=;
        b=2K1szvcBECQW4keBWNgZ3JT5PxgHH+gbYrwQLW8M+dMH7TISOt6B8xukSt/qYf8xBU
         VPwJaNkp64uDKwzE0xrFcLgdvzMgpEDzG6ImC/EetYeeE1dTc81tWzwKEUftE+e6WEiR
         sY3EvqEN1xW6CdE7DdcchnpXIqBf4jsW3qwK6E2H+S9gqDS3G2eMhhHJ6QL4Ze8Tf0IN
         Oz9K9Y5zThkNvLI5s6MrGE7AvKS9IghoB/8JYW9ievsXAKfiwVhK0JCiVcGBVFNc0Nv3
         L2kfHaChIJhcH2yfAfCvbiszOtwBmfGfMwAxjZC2e0Qee2mFCM7ixnDfHrzhplMPa5Rt
         L/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718290078; x=1718894878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJbpBNKH1nKMaS+tK4/41cAHjDB09P3ZLPEGUZzZCqo=;
        b=PEsmbKlc3GL0vTC1RLpO8hKQrXjjGwz/ynUjGA2vr+AtEHbVm624+0DZBI1IaWyTzQ
         Q3JjxjgNSl3KYT5svfBiDCpkrbuoMHTN0ZQv6ywN3EMN+zn5bNbPZ5z+CtrD1Mcro8Mr
         aXjm2qddl4YNezDmmJ1NxiA1K1kAE0VJ5QaXpx8t3hLlgoB/gUjmlAeFG9A8Hj/0ryZx
         1QuqBqJDMxEgBoaYKY9qSjrG7l4hO/nLZ6r/lzjoBm/6+egD8S+Yzwz8EvkpFIw1B67U
         6mqTHBDo6URTR8OFq0TT9OLO6pTSugM6oAChz7dBwm9q0tRhGl72Y0qcLdcG2tFPgfHo
         pFjw==
X-Forwarded-Encrypted: i=1; AJvYcCU7RKVXnwqPkKhmTOYraO5bn9S8tkYadPO+eI/Y7xx/VifsXmG6YHgTHckIOh/Zuo+aeUrUvOSTRq3m4DOUEcXVsEfxqz8UOv1XhGGq
X-Gm-Message-State: AOJu0Yxe0XZizL++P+yLGv5iBrE+CXLPELwpIVizJPvWFDbg7so/9FGT
	+aQTJOjdGRxNhK5qFLS2A3zP8vnOA5W3SyXLzuscL1XsZ/b0DEIFJB/hegVXKNG53a9bltxMjHM
	+pQF2+pAdsUCWRFAI7A0MBzZccG6POGOeY19COw==
X-Google-Smtp-Source: AGHT+IGctOV4sUJXx3kX4lbRej3zxxjongFChJ+rwztXfqOuHwCwpySuoVQD6u2sUxihtO5b6CbJl6hbO99jW4+2BQ4=
X-Received: by 2002:a05:6a20:394a:b0:1b4:772d:2885 with SMTP id
 adf61e73a8af0-1bae7d9453bmr74989637.3.1718290077789; Thu, 13 Jun 2024
 07:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113223.281378087@linuxfoundation.org>
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 13 Jun 2024 23:47:46 +0900
Message-ID: <CAKL4bV4Mmy-SNKTf2gScQ_YEr1WH1Uz_ydGHKVKN0v17kJn7Nw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/137] 6.6.34-rc1 review
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

On Thu, Jun 13, 2024 at 9:10=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.34 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.34-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.34-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.34-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Thu Jun 13 23:11:09 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

