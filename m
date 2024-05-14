Return-Path: <linux-kernel+bounces-178825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E2E8C5843
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E651C21A27
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F0517EB82;
	Tue, 14 May 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="2kCFN+9M"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B7A1586C6
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698100; cv=none; b=hpbzsR7Hze8sAFg3RPdVGVP1O6wv1MP9cvty6aN3r6KIRnhrpBRBhW1KxFtwJI3xfolsO0EXcvuA8oHfAgwZ+nMYopxAl7x9UBJ4X3BkPK3IYmwl6Rts1Ihh9nql1iXNtFr5NXbesOEQnI3v/BFTt9ucZZNWpch7AbTtoAZKMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698100; c=relaxed/simple;
	bh=v5cKs+69XP5Np4L0qIMo+yZTTs38YWffGnAEMsOYqxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFwKTncnjyQQVNW1uFSwxAiOLwsskdCnN4cRk927aXLiPhbfsvnoaZ7r2ZniQQYT1vt8WZkYiRTiG8ADOqDBoQLOL0aueNglc/OxWJVu1i9Jcz2bB7HedzBMKBBIU0ihV+vU6YU3MMzFb2fsMM2s89vA+Awafz2svnijUTGbezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=2kCFN+9M; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f472d550cbso4579724b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1715698098; x=1716302898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZk3CwTUVB475tkoToAu9QenbV4AhIaVymB/BlnOoyw=;
        b=2kCFN+9MmYwF5pI1UUsbYW7ZhtJDbAYPwo6SqYU0s0jjzU7ORu1EQXjQ+1Og9Jagcb
         CIEbZlkjySwUTSJ5spm706Y+TUpIJULE7seKjsqutvWLh6qN+7D3DWlasJGtRqew/zZd
         /ksERnUpAXeWBvBeDqoLkk7fLJ2CRXNEutlK5ePrXkpZCL45huXh4NH6SxNPuNC3/5xq
         Iq8uvk0HiyWTGvcb3/+otkDgTOTaq5nZAV5QIM2acErIJ1KKgW364eUQ5qEhznlHzCDm
         0mDA/Xs/SWCeraaKFmax6GSYEPaA8i65dLCNWlx+2JBGr75xRT2OXtyRnjQfvuvzWBWj
         XoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715698098; x=1716302898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZk3CwTUVB475tkoToAu9QenbV4AhIaVymB/BlnOoyw=;
        b=J0jjoKm2y6gICkPFIhpMAPq4XZ0m9vEyo76Nww7svNNKTD+QoDyDg0Lj5R7M4ZNmFM
         hCQ8iE+v24p6niR9aqjt74pyTX4+liN2tyKSNbDb+pQPPsY/lbgGg+KbdYSIliRPnxLg
         x1/YuXvlHfVB7WVStAfChc/zjuAiCsBo2pjVRmSGrvoSSDWBv2+xEwCHXTlL3uhW0wlD
         Ap16Dj/zppU7csZ7eNgCWgjN2aEd8daxuc/dQWOyLrdsVzThSS8/w43t+004X+9fNIPX
         2JUxYJlT+vNtXsVFpGgXXr/OKeXzQFtxbX0V+4qNyJ5u1fGvJwsqz9Mriy6u2Ebv+1aa
         SSaA==
X-Forwarded-Encrypted: i=1; AJvYcCVNqxvnWwpaZFTzowhwd4MNFFQGJ8XDj5GYN44jVGpzMGD3zq1ygP+0r7TxXw7gCRAa8rGlgFSIYQCRwjfC1B/OhdLVKg8A9ZbymgLd
X-Gm-Message-State: AOJu0Yxr3YtblUhWk4Kh1zzsVBIIimGLZPTQWdnq+MEUHcHjpQG5Fr38
	XO5AJrgJM2F1bVlPx8GAF9BZgunHB95UyR7MMnhrFHrGTDoLpI+LggBYS06myK5v4briCRUdxsO
	zBTHiCE8OjqcUwmbBz6Lx4FdGe7tmvWxtJQAtOg==
X-Google-Smtp-Source: AGHT+IEMDE14BQJ7hwbgCihLMNzbQ80px+rakB3WXBnAWf/pBUQIv0Chn06Qv5WDJjyyU8qAjhHS3Rmz0+zRhzvLJo0=
X-Received: by 2002:a05:6a20:748f:b0:1af:acf5:f9e5 with SMTP id
 adf61e73a8af0-1afde0b7309mr20033005637.23.1715698098122; Tue, 14 May 2024
 07:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514101032.219857983@linuxfoundation.org>
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 14 May 2024 23:48:06 +0900
Message-ID: <CAKL4bV4=MjQAWTEvvp9pJ4JD4ZbC=7hjhbc2S=Ri_uPMvRG6Eg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/301] 6.6.31-rc1 review
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

On Tue, May 14, 2024 at 8:29=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.31 release.
> There are 301 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.31-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.31-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.31-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240507, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue May 14 23:21:48 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

