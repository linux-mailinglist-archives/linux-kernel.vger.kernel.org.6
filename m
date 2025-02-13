Return-Path: <linux-kernel+bounces-513898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AC8A34FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FEF165F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C5E245B0D;
	Thu, 13 Feb 2025 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="oUO/2Q3P"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87842222D4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479978; cv=none; b=EjfslOTueQOK9GoR7U6l4Q+IHxMK/MAe37Ho0sFdtg6t/4Gau5HxSMYyB3I9mwN8kJhbAQEbZ3Wm+Zx7v5TGUolC8mxQonAsxw6Y6pWc0HbHqawQANfa6GItj0mtrHH0AAtmiLc2iP94UK8Qijrme6x69uX+L+tBwuXTNpuu0ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479978; c=relaxed/simple;
	bh=YQfOmSG7bhXwrXEI7g7HfGozQsPSZTjYO8leaGIMmsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsBQId+pj7JciBBLtq+ELJOqNP7pREnVEwRVDJOmlZsKFp6eKbZSIki20ThKjygTQ8clQiFenjiin+8SzR4TKE9Vt8q41SCpd6JStqIRI2qaRNseWARQw12y5xoL2ddxfYInqIz5lG4We9Xrluq9C7LdaDkL/zB3WXtqZoRqWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=oUO/2Q3P; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c8f38febso23821685ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1739479976; x=1740084776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD4jlIA09LlCQfIugtat8U7n/Mwu0d3vsRXd4yayRgQ=;
        b=oUO/2Q3PXsidHZjNIZDeRNCHZj9da8ZMHp0JlrZxMXWcpGliGuw5DkkzVzGPI4Pa7w
         8lxiZ6jGtHaSaPN+Uj694Q/odEkqOBynbhyONGBawHj8MdPtTI9LEVY/PgtlbGRv7SP/
         3Ud4vgE8b5aQZc0CSsAJwEgrrf2hFH264HbxU6G4gHXkk5Bi9yHzF0JBBw8mU8UTwByy
         skztsCQ7MTEPhT2Fsn1YsqwGf0VN77NKRalF7wGaCC+LmFjRw1LH3v5WSHLWVtqio1Pl
         CpxQ7VYElIbgyee3VlM/m4qmsRbwdAAQvHni6ykzTch+6hh0TBA4lkT1Ot+P3SAVcLny
         h4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739479976; x=1740084776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kD4jlIA09LlCQfIugtat8U7n/Mwu0d3vsRXd4yayRgQ=;
        b=WsOcAtKl9+zJPGCm29Es4qU/oHxDpOLNws4uc1iMaPZkV3BbYYEOfZAl6aInePglOQ
         gtSJAHWYUd6T7/S+9VJFKXfiuUPLo9lhnb8a0hM4wJ42VMJghS8PqKZwG5KMyVtbpBf9
         lLG4I/wiY62kbKpql/YFED5ELJGcGo1ws+yw9mADoMYMUoX0dB9DrDxGiCiXCtdJ/yfi
         mvA5hpKZzdACyLAFO2/LZe6C2YbY0PWio1HTQyLprM7a+7U1Yb1KwYCnRB9TuLV+hQvA
         as42Ad4cQiVKKw+HaMzKgfBKJ60sOfcz6/ghbi1ToU3PRdrpRO4WMmUYII7h5wWj3MZ7
         bYZA==
X-Forwarded-Encrypted: i=1; AJvYcCWjECWF5ZptB5XmBmo93/cs/I7rKJyj3UUEvnMeslnM11dYzjA2B728EWoRA4we88ps2IRS0jow6d3fH0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9aU8T2Q7g2LOdM934QmQas++xXIMhoonK+YDAoWCZc6ezD9m
	CJRP+rVqn+HXtLwj99jiBPhc8OJesV7u1h/jA3sDqVdT8VTLEbnLWXycB3q8TlqyzSe07znGk7j
	8boWUAEl67JZksT8CQ9RNvQAKGhHlII5ONaxdYQ==
X-Gm-Gg: ASbGncu466ZuAUYdPcPACPo0Jhgyj2yh2HiaLjPtqhOZFpejRdkYG5F6FtnLLDK2hA6
	cIVsH8LwKMIP8wecJtpBIis/Wky15jftOBrtJOkwIJHuVKbluIyV2r82/jfZslAtci1W3QaY=
X-Google-Smtp-Source: AGHT+IHjzHdPOUuygC6NBlatxleab1j3jR6rTUbN05uLgsUD63sYvsqWUeg/8xCBEvwpGmkWUxZGnEHEHJM5LlFEhYs=
X-Received: by 2002:a17:902:d483:b0:220:e9ac:e746 with SMTP id
 d9443c01a7336-220e9ace872mr19612115ad.53.1739479975905; Thu, 13 Feb 2025
 12:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213142440.609878115@linuxfoundation.org>
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 14 Feb 2025 05:52:44 +0900
X-Gm-Features: AWEUYZnADGWAsmbaFXOyq0Ts9-qFL2MZJjpcjwmTCjML1qk57OFJC9AtigNj_Sg
Message-ID: <CAKL4bV58AGyft6AA5j5CV=Fvm+uX_czSmSu8a=sgdQqYygBjbw@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/443] 6.13.3-rc1 review
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

On Fri, Feb 14, 2025 at 12:07=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 443 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.13.3-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.3-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Fri Feb 14 05:08:38 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

