Return-Path: <linux-kernel+bounces-416534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5D39D467B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6665B23B62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DE42309B6;
	Thu, 21 Nov 2024 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="lk4vJ8Wf"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689474068
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732162216; cv=none; b=bQGQVhCup7JfxsD4yhBeWb8bCfWqmmAOqt8AvHUjUjrtsJ9LD9X5hjSuUZRfMIk4CUvlvthEsPW9FLKcP/5X6foSxFR4I+f/86PhnYy7910dZemHHUHOVDQ8LDp5TCe9v+sJCbtJsaXaij4po4d0FTm/Kbw6fgKow1a4iAtRNx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732162216; c=relaxed/simple;
	bh=B7xihZT26qiygX0gKCUDPAr5CIdT5RCJ87wuM5RULLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrBfYDN+Nw8YpaW0inBJBxmP5OAl+707srzXedAnA7xIFyem0kcu4/Ldezmllz0Wtklwy+6qO/AAEiJ3u2AMLfILjIZuoLXM6cRnpev8278/du0YInjy4w5bs2G2epGKqgInLWuYQGzzKwNZrZjsvPNbn6WJV7HSQrQq8HClQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=lk4vJ8Wf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-723db2798caso429023b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 20:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1732162214; x=1732767014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eW+fFrqUQmQKRzIcmuovs8hOwhvb53DeD1uVIRrkq8=;
        b=lk4vJ8WfI1lN4x1+F0xBSugcCX2qyNdwQDYpqVOC21L44F+C9GGp0N4xPC7BWkjBvq
         DAuX44KFSnyCfwDL1Y0/wk6Lbx3EDvfl1TiWW0uNFTMUu8QyaWH+Phq3XSOKtvglm5LJ
         WY7IgoYjJuguPlnia8Btt1PDLGcYfj6okrwhsnxseN2fsdX8e8XdFFtZZ0VTaGLVxbhl
         4H6xVTosdI/iZh/eU/xdcA6VKqJARNxtsFPbfDKxf0noYNm+8JX69Dft2TLIIjeeUjGE
         YV8r4gmLth+HlFYpHh38HbW1m973DYUzU4tW6XOZcNKRXv4+VrLs2pHbPtK6MHV66Eaw
         o4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732162214; x=1732767014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eW+fFrqUQmQKRzIcmuovs8hOwhvb53DeD1uVIRrkq8=;
        b=woRsunZtwvhnPlp51AXISsYvF83CzIY0TddUKwFq5xv4mAJb95ScMzQLpwiBOGwq/L
         wY64KWkxxz6K5bbyaOwULQBDq0yQM5t7p2Cyd0WOqQ2ZxBwYOp7frqAFkAE8KDyGvWhO
         U90L5y6tVq4eM2HPJjHKcznpO8Be4i7PbzOtObXcyUtZ5/xm5etrOWPymAb4CJUrQKcO
         ebxz7V4sN0tJ626rgz9RUP32NYci4Q/1vKGCflG6X1/aKVPeaMZwGZZ4lFNZeEMiArJN
         YzlZW0gA3fTYJXe7sUvaBUJhn3418PFZarqoGalU3cB/9UhvJ8zaBY4TmT5zxCCHRRO1
         qq8A==
X-Forwarded-Encrypted: i=1; AJvYcCW2mG44oMYCz7AYmzz5z7Ju51z/xeHkiaasiz6ILCumOBJcnIhrJeqiT1LWYrSYUPCOGUqbZnaZCbYxJV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZ2mKZeinJYnJRodKWBkLOwLI2fvDw9aypSPA83q928AK7UG+
	bHfFpSt4u5TRxIcNCasTwbyY6tgBx4NGFltDB+Mu+fAD5P2ZkfmJYh7OaK83ZjukYpJFr3PzIHt
	5fUwALXlj/htIjPcnFnn+aOfJfDWQX12k7MkQTg==
X-Google-Smtp-Source: AGHT+IFdPQvHbccmjyatlDgiS9cIuoXmk/x192oJMaXaoFIZ+y7bREGGD/Gs+VCdZ7po1w9u+EDS8LYFG90e1gtySXI=
X-Received: by 2002:a05:6a00:1743:b0:71e:702c:a680 with SMTP id
 d2e1a72fcca58-724bed98ce6mr6543640b3a.26.1732162214596; Wed, 20 Nov 2024
 20:10:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120124100.444648273@linuxfoundation.org>
In-Reply-To: <20241120124100.444648273@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 21 Nov 2024 13:10:03 +0900
Message-ID: <CAKL4bV5EzB3HVJQ7YcpyhMECmjfH3B_6JcJxeuuxrE3+Z0vNZA@mail.gmail.com>
Subject: Re: [PATCH 6.12 0/3] 6.12.1-rc1 review
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

On Wed, Nov 20, 2024 at 9:56=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.1 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:40:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.12.1-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.1-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Thu Nov 21 12:38:33 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

