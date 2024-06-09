Return-Path: <linux-kernel+bounces-207372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FEF90163B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 15:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620961C20A30
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 13:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E06442071;
	Sun,  9 Jun 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="YMpbYDsK"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F173EA98
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717939559; cv=none; b=UzPSOuU6D8cZ5TMc3QjLpLkyqeyS2G2I7PAbIvAHKZoYLh4M/Mfi5QGT8o6YqWMTwLDn0A0SW39gpF26/3lkUWsQl3r54H+NObz4z+ctkzntEX7V/mq+IhuUdGGmLxVMTD4Tx1J4fUzySH0yzkOqxHVysEO4mRpVXxe20DOrAOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717939559; c=relaxed/simple;
	bh=u+u9QLYNu4HrAWgyPgFZCbJEI/NnuOHhXl5OP6+ZmdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qc3sRGLCO2hd3dy59gDfHJiLleLirLMGzY4zaILJlirg0+v57859OfmT3fteORXZImP9JdYJdmmF28KT4rd1U3w/+hM6F8HWRapI71oQ+1aVltodhXZ8CNx53oz3dfqBUhAHihMCS3voH7nwfQyNwRflrOPpY1txe3tbCd7+Lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=YMpbYDsK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c2c6277ef3so1512668a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1717939557; x=1718544357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fXq7SaL6D194sQwZh+H3HooqCMUEWewEfZ6pmv61pw=;
        b=YMpbYDsK3qlD6k9XSWAC8sYjl4/OSBdkyruZWgQ3cKsuUDo5q20x9DnbrVhpswPoAI
         Nq3D1Rsv+s1TQqSy0/r+ehL7MPRZ/RvoRagti2mRCUfmSj2MnT57KqszzvbVfjihDkBE
         w73yi0DdnUBrfATzYq31QPPaXV3MQjwocSD15qp4d/eTJ5+r4deirIrnVfhCV3zgyRSv
         HiJtMLbmjarAcVb13AbiuGGOWwKW2FKHhNJgmM2FuFy81EJ79quV4Zlta4JN5A0OVg1G
         lwwuAHN19C7C2VXJaHt/SC7Kd66qv2Smekyrpa6hvGM+hJqlvUVLHwoEsQ3Xhgm4pCrK
         yU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717939557; x=1718544357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fXq7SaL6D194sQwZh+H3HooqCMUEWewEfZ6pmv61pw=;
        b=D4lKYuqJugbxgazwQiewwzcy89YojOEVF9zzakfMo4tkm14qnvh7NfbUWSU4tyexsm
         Ut9USKhGBbp7S4Ll5E0Zg3oJeauoOlDT7T/3lhkwvYKDJkTjpU5jjaWvsBCiLD7Y5w+J
         t00rb9WCUA4d0fUew0T67BPcEHHQaWxffiBRPnBKO5XE2YrprhH3jIwPIP2i8tzFUyAy
         YbuHAfdlbRUVLxpBQg6tyNuOsTJhN46gLeQ+nsJumkmAWf2WBoyexjaD0L6V1kR0W6Xo
         Jco02XzV8U0jkP8L5YjQJLcVNKYOyAKCKP2cpCwZTCwWqa3xxdsdwglZoWgZFDyCBXri
         w0wA==
X-Forwarded-Encrypted: i=1; AJvYcCXiUzxi1AGhoYni8OF7z9sW2wTmIloSuop7CJLnKKvu50YvwqZdL2w2kSz30dq/W6qWo8O1d6xbaMpM0hly3ItOhXhakJjnu2qn74UJ
X-Gm-Message-State: AOJu0Yyzl6isAhO8/Df0beeLQjlqW9RpJtsg46FILxqP2EPRn8njyNZR
	Ut+Zu8Xisu6YgVKgPEtfj7kqbVbpekOX2gfT5Dv/zdcP/C0QY8syRdqZcDgnEpnt7lyddUCFSsP
	PD3e73QguaUSX+VDdZyySDI3EYklQcWwHFYCLVC14h3LU5BAuED8=
X-Google-Smtp-Source: AGHT+IE1odL3BBZ9hhvpRx8NNX+yPBmqQqY4qii/zdBs8e8gtpn0Fcfehkq7fp6P+LBk9yP6x1KrUy0lPGjR7Qg/WhM=
X-Received: by 2002:a17:90b:19d1:b0:2c2:dfc3:eb7c with SMTP id
 98e67ed59e1d1-2c2dfc3ed08mr2450309a91.18.1717939557527; Sun, 09 Jun 2024
 06:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609113903.732882729@linuxfoundation.org>
In-Reply-To: <20240609113903.732882729@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 9 Jun 2024 22:25:46 +0900
Message-ID: <CAKL4bV5zSAu0iEvfHuiJjUZqi=zgr2e7xiEOaiYsWN70Ur9j8Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/741] 6.6.33-rc2 review
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

On Sun, Jun 9, 2024 at 8:41=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.33 release.
> There are 741 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 11 Jun 2024 11:36:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.33-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.33-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.33-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Sun Jun  9 22:02:19 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

