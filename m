Return-Path: <linux-kernel+bounces-205923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECD9900236
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 943F4B22346
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE4A188CD0;
	Fri,  7 Jun 2024 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="ZdiivRZC"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621E315FD19
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760008; cv=none; b=o2F8ihYJnffudBW19V0JU+bs/EOf+2DvqXBz8LuXH5qnLKd8GBCh/S8qoT//5TmXespiugZzU9tIytwcD/VMGJWa8a/zFhhY4b7mRZw+PHA/wNx8tKvV418TIS9C/VKhoACdjemZcVbYqCY/N4CkOfTtG3ZQW1mwVdCLQGjNQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760008; c=relaxed/simple;
	bh=2wr+lHAs0v9eNSflllxbXQVFuP35fXI9JtBvHoVR5yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQSceAxEQai9CMCMwwP/FofDHmd5DAeW+iyo0pW4oOGQdNSJn5oCIeSIr98RGm8dKPbiOsjFDBb8HZt32yfB7QM/L17bCj0MWfbWRyFpB6UrRcuKhDOUlvN9rY18sEoL6pz8dg8o8kKdb6IW78oAVm6TInQ5422I3Lfa7P4rJBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=ZdiivRZC; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6c4f3e0e3d2so1543066a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1717760005; x=1718364805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xONs9cG3bwLvzUz0akmZOGXQK5GwoaC52V868nn/RM0=;
        b=ZdiivRZC99xXYQgs9WyaxAoG2w3FyDm9Dr66kjH251lHJf33zxDFyKRZfkos+u1wA1
         Fh2iyodJHd22B/lTCuak0s0CQdZZvAjVlM5gF9jJoa22n1uwpcdAWO05Ht2BySi8inEI
         W4pEIZ6ePj4ndRo8i3JxmufGKh0z0ThPg2hau1ON+QywkGFi8F/+h5cH56pdOYNgrWpz
         APpp9M9Nw98sFDKL28X5QSKr1yUFUYJka4zeLwAsCVE8wbJ2F+PflJU2jeHufB31WEmd
         aXKtHnm9F9XxUdrE7PerCVYLFVpgo43vjkzLmOdXGLaFPQXJYVWztSD6oLpDaAhmuaZ/
         DTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717760005; x=1718364805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xONs9cG3bwLvzUz0akmZOGXQK5GwoaC52V868nn/RM0=;
        b=u78vF9N4A0HarzN/+fQNHhMJmYfoKDeX+pmCgkYqxZytoQf1/p7qIgBmTeLn1UHUFb
         rAVwvk98tq5JwOuc3LxNkMq5UGTkrWa4o70OW1kDPhjmZS86J4dPpySgCmtVhOdL3Nwj
         qkIQfJsfraeUmE0PxP3yuKskrWXzvhyyI5vNR4rex6ohGisytpuxstmOmqfEnawrJoW3
         VbBh8ZYFBy+FREiNjzfe7aWsvozqHUaJMUvjxicAn69W8h6brmtXVFGCX1mwZNwD6odG
         FC+N02TiMmh+8XergWEmsiXuAzUgvGW7obm/nAcCcoFHbrsDlRa/vta+8bkOmdNkzwDq
         LYpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg7xvs86T0TKWYUFnPTqvEPbVVfsYVqaGU+QIgiCmOCRPuWPn1DM2E+z3v9+R3bHhd0D4pbfle63IMNOTATDhxwNXFtN4yqxKIqvz3
X-Gm-Message-State: AOJu0Yz6NzrlFDMBMeIV6OBps+WLSUzgEvzbygJ5Tm8+1oDbgCOdaZgt
	Z1ZxZ5+vZVyLuP8/bnhealn8j7OMbF0xmlrR4JrcYmtajE0df6FP71GzeB7q2BilYhakqXPv6Br
	eHTW1SsyPS0CLGyhoqEAMnwj+9wtkGnOzihUDlA==
X-Google-Smtp-Source: AGHT+IG7+ZIc0p1zJoLLk91skDbqRsWdWPxDuKxxght4BciIei9F3bE1Mu7itn3uqV0BQDye1Nze6/TKU7qLlbcHg+E=
X-Received: by 2002:a17:90a:5207:b0:2c2:1d0f:3c6e with SMTP id
 98e67ed59e1d1-2c2bcc6b446mr2113104a91.37.1717760005426; Fri, 07 Jun 2024
 04:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131732.440653204@linuxfoundation.org>
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 7 Jun 2024 20:33:13 +0900
Message-ID: <CAKL4bV7_mPSr6FKH6j75hsHiOG-Zu20+rotzG4uU04qz91eAJw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/744] 6.6.33-rc1 review
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

On Thu, Jun 6, 2024 at 11:18=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.33 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.33-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.33-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.33-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Fri Jun  7 20:08:16 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

